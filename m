Return-Path: <netdev+bounces-42315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A967CE327
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BC71F22AE8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FE63B787;
	Wed, 18 Oct 2023 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZMFfNyB5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C08C0C
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C435C433C8;
	Wed, 18 Oct 2023 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697647768;
	bh=dHXqrJebTI1Fnwepc+GRKXNte43aWgbwtNnUBH9dulc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMFfNyB5gaWUPGkwnUAPU1tBsvw+tlS/eA/UQDXaqst87Rv2k0frTS5aoyGyU0nvx
	 xDJQiCn9PVORtz2ytOXs7fRb07Yc1+LCQjJypm+UqjSYYxnwmZVxk5bSf3WoQSJ6r/
	 jFSy+1q+ZuTEEN1YkpL815tY3wKFlSNMx5qDuWPw=
Date: Wed, 18 Oct 2023 18:49:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org, mhocko@suse.com,
	stephen@networkplumber.org
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <2023101840-scabbed-visitor-3fdd@gregkh>
References: <20231018154804.420823-1-atenart@kernel.org>
 <20231018154804.420823-2-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018154804.420823-2-atenart@kernel.org>

On Wed, Oct 18, 2023 at 05:47:43PM +0200, Antoine Tenart wrote:
> We have an ABBA deadlock between net device unregistration and sysfs
> files being accessed[1][2]. To prevent this from happening all paths
> taking the rtnl lock after the sysfs one (actually kn->active refcount)
> use rtnl_trylock and return early (using restart_syscall)[3] which can
> make syscalls to spin for a long time when there is contention on the
> rtnl lock[4].
> 
> There are not many possibilities to improve the above:
> - Rework the entire net/ locking logic.
> - Invert two locks in one of the paths — not possible.
> 
> But here it's actually possible to drop one of the locks safely: the
> kernfs_node refcount. More details in the code itself, which comes with
> lots of comments.
> 
> [1] https://lore.kernel.org/netdev/49A4D5D5.5090602@trash.net/
> [2] https://lore.kernel.org/netdev/m14oyhis31.fsf@fess.ebiederm.org/
> [3] https://lore.kernel.org/netdev/20090226084924.16cb3e08@nehalam/
> [4] https://lore.kernel.org/all/20210928125500.167943-1-atenart@kernel.org/T/
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> ---
>  net/core/net-sysfs.c | 142 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 112 insertions(+), 30 deletions(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index fccaa5bac0ed..76d8729340b7 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -40,6 +40,88 @@ static inline int dev_isalive(const struct net_device *dev)
>  	return dev->reg_state <= NETREG_REGISTERED;
>  }
>  
> +/* We have a possible ABBA deadlock between rtnl_lock and kernfs_node->active,
> + * when unregistering a net device and accessing associated sysfs files. Tx/Rx
> + * queues do embed their own kobject for their sysfs files but the same issue
> + * applies as a net device being unresgistered will remove those sysfs files as
> + * well. The potential deadlock is as follow:
> + *
> + *         CPU 0                                         CPU 1
> + *
> + *    rtnl_lock                                   vfs_read
> + *    unregister_netdevice_many                   kernfs_seq_start
> + *    device_del / kobject_put                      kernfs_get_active (kn->active++)
> + *    kernfs_drain                                sysfs_kf_seq_show
> + *    wait_event(                                 rtnl_lock
> + *       kn->active == KN_DEACTIVATED_BIAS)       -> waits on CPU 0 to release
> + *    -> waits on CPU 1 to decrease kn->active       the rtnl lock.
> + *
> + * The historical fix was to use rtnl_trylock with restart_syscall to bail out
> + * of sysfs accesses when the lock wasn't taken. This fixed the above issue as
> + * it allowed CPU 1 to bail out of the ABBA situation.
> + *
> + * But this comes with performances issues, as syscalls are being restarted in
> + * loops when there is contention, with huge slow downs in specific scenarios
> + * (e.g. lots of virtual interfaces created at startup and userspace daemons
> + * querying their attributes).
> + *
> + * The idea below is to bail out of the active kernfs_node protection
> + * (kn->active) while still being in a safe position to continue the execution
> + * of our sysfs helpers.
> + */
> +static inline struct kernfs_node *sysfs_rtnl_lock(struct kobject *kobj,
> +						  struct attribute *attr,
> +						  struct net_device *ndev)
> +{
> +	struct kernfs_node *kn;
> +
> +	/* First, we hold a reference to the net device we might use in the
> +	 * locking section as the unregistration path might run in parallel.
> +	 * This will ensure the net device won't be freed before we return.
> +	 */
> +	dev_hold(ndev);
> +	/* sysfs_break_active_protection was introduced to allow self-removal of
> +	 * devices and their associated sysfs files by bailing out of the
> +	 * sysfs/kernfs protection. We do this here to allow the unregistration
> +	 * path to complete in parallel. The following takes a reference on the
> +	 * kobject and the kernfs_node being accessed.
> +	 *
> +	 * This works because we hold a reference onto the net device and the
> +	 * unregistration path will wait for us eventually in netdev_run_todo
> +	 * (outside an rtnl lock section).
> +	 */
> +	kn = sysfs_break_active_protection(kobj, attr);
> +	WARN_ON_ONCE(!kn);

If this triggers, you will end up rebooting the machines that set
panic-on-warn, do you mean to do that?  And note, the huge majority of
Linux systems in the world have that enabled, so be careful.

thanks,

greg k-h

