Return-Path: <netdev+bounces-252537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELNAKRyScmkMmQAAu9opvQ
	(envelope-from <netdev+bounces-252537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:09:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E46DA08
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A13863012E88
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D512633CEB0;
	Thu, 22 Jan 2026 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVcKdEbE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E694A346AFF;
	Thu, 22 Jan 2026 21:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116183; cv=none; b=KXMnqPBK5CxwTaVXZQHLOXbyodY/ZSIMFi2dMgdfHvX8AWgISrTA7KedVj/ai8KKQ2m7y4kv7d4YIGV+RN00s1arMrbsqah9okIp1WoR1bQ3u7qSDynpr4QoNgosBMaj1EnTBn7D4TF7EqnXzxTnXHe0IWcchdvH7SDDJOZijDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116183; c=relaxed/simple;
	bh=t7rqMgsvSr1YpvQGuQMKvBpiRwX2rBxkxGjTmf9ueW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbx1zqQ7O7CBYah2XW8OdlCCU6dQck5u2h3X5mwgixdtL5wKqKBzsF3sEakEQuwANoHrq5zDjVqQClABznGUjsLEsmNMydPVtlIoqLaRfm2U6txeFSb6waVuRB03XxYuf8GrCvocrjSh7aJCJlAuW0XEKDwyQLcAgoaE4ch47mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVcKdEbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920DEC116C6;
	Thu, 22 Jan 2026 21:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769116180;
	bh=t7rqMgsvSr1YpvQGuQMKvBpiRwX2rBxkxGjTmf9ueW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVcKdEbEkziPCVr2qdmtF39k16VnPdbueuA3fypGBnbB2viUfmauGVyq0psXl1RUX
	 HpJmDFcd4Jhe7Eu5z5Pg58il7K3wtdFf+4owZeo8LSTkcFwi3dnG+4bqK/ePAX5oQu
	 06Hfhjgn3JhaMmEq8i2/TnaBdP8qCYnEoSWTylsgnaSNIXysDcjGzf+sWXUVx338Mr
	 28Wo3It4clbHYptOS9w2l6QhDJ7RGG9MwLlVpoMrWHovNW+Pu1PAkgz6ug0XfudMhV
	 1Xkr8Hojo7mIfO8MmnNx1ZXnGk2MhycUE9Rce+PbkQEI646n3QReZqtem9JPbQBm7k
	 3a9svRNQuqacQ==
Date: Thu, 22 Jan 2026 21:09:34 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	pmladek@suse.com, john.ogness@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/5] netconsole: convert to NBCON console
 infrastructure
Message-ID: <aXKSDoi8Yue_Ghxj@horms.kernel.org>
References: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
 <20260120-nbcon-v2-3-b61f960587a8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-nbcon-v2-3-b61f960587a8@debian.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252537-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E62E46DA08
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 08:23:49AM -0800, Breno Leitao wrote:
> Convert netconsole from the legacy console API to the NBCON framework.
> NBCON provides threaded printing which unblocks printk()s and flushes in
> a thread, decoupling network TX from printk() when netconsole is
> in use.
> 
> Since netconsole relies on the network stack which cannot safely operate
> from all atomic contexts, mark both consoles with
> CON_NBCON_ATOMIC_UNSAFE. (See discussion in [1])
> 
> CON_NBCON_ATOMIC_UNSAFE restricts write_atomic() usage to emergency
> scenarios (panic) where regular messages are sent in threaded mode.
> 
> Implementation changes:
> - Unify write_ext_msg() and write_msg() into netconsole_write()
> - Add device_lock/device_unlock callbacks to manage target_list_lock
> - Use nbcon_enter_unsafe()/nbcon_exit_unsafe() around network
>   operations.
>   - If nbcon_enter_unsafe() fails, just return given netconsole lost
>     the ownership of the console.
> - Set write_thread and write_atomic callbacks (both use same function)
> 
> Link: https://lore.kernel.org/all/b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 97 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 60 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c

...

> +static void netconsole_device_lock(struct console *con __always_unused,
> +				   unsigned long *flags)
> +{
> +	spin_lock_irqsave(&target_list_lock, *flags);
> +}
> +
> +static void netconsole_device_unlock(struct console *con __always_unused,
> +				     unsigned long flags)
> +{
>  	spin_unlock_irqrestore(&target_list_lock, flags);
>  }
>  

Hi Breno,

I'm wondering if we could consider the following annotations,
as "suggested" by Sparse[1].

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c5d7e97fe2a7..79e39a6c5343 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1772,12 +1772,14 @@ static void netconsole_write_basic(struct console *con __always_unused,
 
 static void netconsole_device_lock(struct console *con __always_unused,
 				   unsigned long *flags)
+__acquires(&target_list_lock)
 {
 	spin_lock_irqsave(&target_list_lock, *flags);
 }
 
 static void netconsole_device_unlock(struct console *con __always_unused,
 				     unsigned long flags)
+__releases(&target_list_lock)
 {
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }

[1] This particular commit of Sparse, from Al Viro's tree:
    https://git.kernel.org/pub/scm/linux/kernel/git/viro/sparse.git/commit/?id=2634e39bf02697a18fece057208150362c985992
    Which addresses this mess:
    https://lore.kernel.org/all/bf5b9a62-a120-421e-908d-1404c42e0b60@kernel.org/

