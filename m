Return-Path: <netdev+bounces-137968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0453B9AB4B1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F062848FF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F01BCA02;
	Tue, 22 Oct 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGROF7yt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB281B654C;
	Tue, 22 Oct 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616792; cv=none; b=ZsQV318Eip/VUo7G42j2cVHnWpAGnPgpoXfy0E+ewCd4e8gCwqEUtGnSrpbAPxSudnsr4euLwdHaOLkQSUEEl9q63TRJDiFwLtLxNjV5JXkrBDarTYDb7VVQhG7HOyy5O3DUj2Zv+6LcOkxZ3A+w52vnQTgBBqNXD9T7wtgJjtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616792; c=relaxed/simple;
	bh=uioEgb0DsXDhOsVLFcsAYKNJt4BaLDhV451d6aRsg9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/e4WxmtW/yObZ1wLc3M63vWQhxiRolLoSk07sbTm6xPOW8AKO+AGiL52e07hdw1dNlV4XdNmtaegQP/Ksedc8BaBudLWDoBD6KT1cLNhiZeE95JQDQZbZ3MUGDL4mkUeHoxt21DegGSiu5a8nxccv4KaRiSD/GEvMsaMf1llhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGROF7yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48188C4CEC3;
	Tue, 22 Oct 2024 17:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729616791;
	bh=uioEgb0DsXDhOsVLFcsAYKNJt4BaLDhV451d6aRsg9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGROF7ytdD/nJ6XyS72Chnx6UF3ZaXqFdxx/xRgR0jjbFeaPml1PwXQS0kRIz3WII
	 2xjWNto/wRi8mXI1g+QjZX8t8Ta0K+lFOK/0pfq6IgJNlnQoL0cNjQlI3xrndiXgKH
	 eG4SsjqKoRQ9sXu9eLzxJY00sHe7HgSP4ertVJkpYOeQGGfOvSro4HNq5mpDOc8+l6
	 DqF+DAR023TwRQmS0/05DhK2CChnS6+C3CRRZVfTH9wU6Gr2x2b+fajk8HDLGcX7GM
	 6vs7CTgs0LLsedCh7SYVZzgolg+y1ErevX8Bggvzc1KXQG3lRvMpimqtApoXIkU6Ej
	 2Cy6UJNEzwvKw==
Date: Tue, 22 Oct 2024 18:06:25 +0100
From: Simon Horman <horms@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, arnd@arndb.de, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
	kernel-team@android.com
Subject: Re: [PATCH v4 1/1] binder: report txn errors via generic netlink
 (genl)
Message-ID: <20241022170625.GJ402847@kernel.org>
References: <20241021191233.1334897-1-dualli@chromium.org>
 <20241021191233.1334897-2-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021191233.1334897-2-dualli@chromium.org>

On Mon, Oct 21, 2024 at 12:12:33PM -0700, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> Frozen tasks can't process binder transactions, so sync binder
> transactions will fail with BR_FROZEN_REPLY and async binder
> transactions will be queued in the kernel async binder buffer.
> As these queued async transactions accumulates over time, the async
> buffer will eventually be running out, denying all new transactions
> after that with BR_FAILED_REPLY.
> 
> In addition to the above cases, different kinds of binder error codes
> might be returned to the sender. However, the core Linux, or Android,
> system administration process never knows what's actually happening.
> 
> This patch introduces the Linux generic netlink messages into the binder
> driver so that the Linux/Android system administration process can
> listen to important events and take corresponding actions, like stopping
> a broken app from attacking the OS by sending huge amount of spamming
> binder transactions.
> 
> The new binder genl sources and headers are automatically generated from
> the corresponding binder_genl YAML spec. Don't modify them directly.
> 
> Signed-off-by: Li Li <dualli@google.com>

...

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c

...

> @@ -2984,6 +2985,130 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
>  	binder_thread_dec_tmpref(from);
>  }
>  
> +/**
> + * binder_find_proc() - set binder report flags
> + * @pid:	the target process
> + */
> +static struct binder_proc *binder_find_proc(int pid)
> +{
> +	struct binder_proc *proc;
> +
> +	mutex_lock(&binder_procs_lock);
> +	hlist_for_each_entry(proc, &binder_procs, proc_node) {
> +		if (proc->pid == pid) {
> +			mutex_unlock(&binder_procs_lock);
> +			return proc;
> +		}
> +	}
> +	mutex_unlock(&binder_procs_lock);
> +
> +	return NULL;
> +}
> +
> +/**
> + * binder_genl_set_report() - set binder report flags
> + * @proc:	the binder_proc calling the ioctl

nit: binder_genl_set_report does not have a proc parameter,
     but it does have a context parameter.

> + * @pid:	the target process
> + * @flags:	the flags to set
> + *
> + * If pid is 0, the flags are applied to the whole binder context.
> + * Otherwise, the flags are applied to the specific process only.
> + */
> +static int binder_genl_set_report(struct binder_context *context, u32 pid, u32 flags)

...

>  static int __init init_binder_device(const char *name)
>  {
>  	int ret;
> @@ -6920,6 +7196,11 @@ static int __init init_binder_device(const char *name)

The code above this hunk looks like this:


	ret = misc_register(&binder_device->miscdev);
	if (ret < 0) {
		kfree(binder_device);
		return ret;
	}

>  
>  	hlist_add_head(&binder_device->hlist, &binder_devices);
>  
> +	binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
> +	ret = binder_genl_init(&binder_device->context.genl_family, name);
> +	if (ret < 0)
> +		kfree(binder_device);

So I think that binder_device->miscdev needs to be misc_deregister'ed
if we hit this error condition.

> +
>  	return ret;

Probably adding an unwind ladder like this makes sense (completely untested!):

	ret = misc_register(&binder_device->miscdev);
	if (ret < 0)
		goto err_misc_deregister;

	hlist_add_head(&binder_device->hlist, &binder_devices);

	binder_device->context.report_seq = (atomic_t)ATOMIC_INIT(0);
	ret = binder_genl_init(&binder_device->context.genl_family, name);
	if (ret < 0);
		goto err_misc_deregister;

	return 0;

err_misc_deregister:
	misc_deregister(&binder_device->miscdev);
err_free_dev:
	kfree(binder_device);
	return ret;

...

> diff --git a/drivers/android/binder_genl.h b/drivers/android/binder_genl.h

Perhaps it is because of a different version of net-next,
but with this patch applied on top of the current head commit
13feb6074a9f ("binder: report txn errors via generic netlink (genl)")
I see:

$ ./tools/net/ynl/ynl-regen.sh -f
$ git diff

diff --git a/include/uapi/linux/android/binder_genl.h b/include/uapi/linux/android/binder_genl.h
index ef5289133be5..93e58b370420 100644
--- a/include/uapi/linux/android/binder_genl.h
+++ b/include/uapi/linux/android/binder_genl.h
@@ -3,12 +3,17 @@
 /*	Documentation/netlink/specs/binder_genl.yaml */
 /* YNL-GEN uapi header */
 
-#ifndef _UAPI_LINUX_BINDER_GENL_H
-#define _UAPI_LINUX_BINDER_GENL_H
+#ifndef _UAPI_LINUX_ANDROID/BINDER_GENL_H
+#define _UAPI_LINUX_ANDROID/BINDER_GENL_H
 
 #define BINDER_GENL_FAMILY_NAME		"binder_genl"
 #define BINDER_GENL_FAMILY_VERSION	1
 
+/**
+ * enum binder_genl_flag - Used with "set" and "reply" command below, defining
+ *   what kind \ of binder transactions should be reported to the user space \
+ *   administration process.
+ */
 enum binder_genl_flag {
 	BINDER_GENL_FLAG_FAILED = 1,
 	BINDER_GENL_FLAG_DELAYED = 2,
@@ -34,4 +39,4 @@ enum {
 	BINDER_GENL_CMD_MAX = (__BINDER_GENL_CMD_MAX - 1)
 };
 
-#endif /* _UAPI_LINUX_BINDER_GENL_H */
+#endif /* _UAPI_LINUX_ANDROID/BINDER_GENL_H */

...

-- 
pw-bot: changes-requested

