Return-Path: <netdev+bounces-149208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179FE9E4C54
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6800281E68
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B71E49F;
	Thu,  5 Dec 2024 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK0CHahT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78B4C96;
	Thu,  5 Dec 2024 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366153; cv=none; b=DGlnvp+am2dzx9AsveRZPBiHcA2KOnDoAxQ0yXJ5YP9jkr/PGH+dUmOnTaBsoqZ9louNquYWls03O3uNUXGC48Icb67OyfaUs2q3m2VGmVlUYxZNGoy8Vu/cZ5h0DeL4OAekxEuSzG3rYM4+X/CPL8DUL02stuFR+fYux6oHQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366153; c=relaxed/simple;
	bh=bCFToNXOOk4QUCeXM2IFMAHFOjr+msvvvubD8bYPWQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLNf/fG/ahjiT8Pq7oJxNVk1DIYNuTu3scD8CkxXnU/QBc5cJy40Ps+x9FvV3L9UEKGXsIOH7YOJCUHI5TYqiG6B/HclEr8fKEW4nAjGpaHHSW/w1vh2KgNo+rzcC8ak+SzV8aBBzdrQTXeWkk9GGzcRAIldTF/vxKoPKXDv2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK0CHahT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82E1C4CECD;
	Thu,  5 Dec 2024 02:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733366152;
	bh=bCFToNXOOk4QUCeXM2IFMAHFOjr+msvvvubD8bYPWQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CK0CHahTfR9D/E+og6RDoq06SHlrmaVVPgLE9utF54AclobpK8Mqa9VEhCFDiGJcz
	 NKywClULEvdIBx45u8F5VsNXNMV6RkxCXi93BwLRyy4q4qLIAWV++/R2ksjbr/Xcfo
	 cX5JzwlUD3GxptnsRFS734/SW3PNEerXWjBWoAmroXd7LBwE6h14P6tYofoT1WPlsx
	 2L9CgkFyistKY4iIip5VaFWz22biThnTSlMFPBiDnUEOkmdpZ9prO28LPHiHSGNJ4R
	 7s5LCv5MbYLuadtbEA48bntl0SPIgbanoa1XrdekkIM5yXzXjKsusbBX+wuZTdk+ir
	 CPOspzOPstKnQ==
Date: Wed, 4 Dec 2024 18:35:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com,
 gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
 maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
 cmllamas@google.com, surenb@google.com, arnd@arndb.de,
 masahiroy@kernel.org, bagasdotme@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, hridya@google.com, smoreland@google.com,
 kernel-team@android.com
Subject: Re: [PATCH net-next v8 2/2] binder: report txn errors via generic
 netlink
Message-ID: <20241204183550.6e9d703f@kernel.org>
In-Reply-To: <20241113193239.2113577-3-dualli@chromium.org>
References: <20241113193239.2113577-1-dualli@chromium.org>
	<20241113193239.2113577-3-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 11:32:39 -0800 Li Li wrote:
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
> + * @context:	the binder context to set the flags
> + * @pid:	the target process
> + * @flags:	the flags to set
> + *
> + * If pid is 0, the flags are applied to the whole binder context.
> + * Otherwise, the flags are applied to the specific process only.
> + */
> +static int binder_genl_set_report(struct binder_context *context, u32 pid,
> +				  u32 flags)
> +{
> +	struct binder_proc *proc;
> +
> +	if (flags != (flags & (BINDER_GENL_FLAG_OVERRIDE
> +			| BINDER_GENL_FLAG_FAILED
> +			| BINDER_GENL_FLAG_DELAYED
> +			| BINDER_GENL_FLAG_SPAM))) {
> +		pr_err("Invalid binder report flags: %u\n", flags);
> +		return -EINVAL;

no need, netlink already checks that only bits from the flags are used:

                                    vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
+	[BINDER_GENL_A_CMD_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0xf),

> +	}
> +
> +	if (!pid) {
> +		/* Set the global flags for the whole binder context */
> +		context->report_flags = flags;
> +	} else {
> +		/* Set the per-process flags */
> +		proc = binder_find_proc(pid);
> +		if (!proc) {
> +			pr_err("Invalid binder report pid %u\n", pid);
> +			return -EINVAL;
> +		}
> +
> +		proc->report_flags = flags;
> +	}
> +
> +	return 0;
> +}

> +static void binder_genl_send_report(struct binder_context *context, u32 err,
> +				    u32 pid, u32 tid, u32 to_pid, u32 to_tid,
> +				    u32 reply,
> +				    struct binder_transaction_data *tr)
> +{
> +	int payload;
> +	int ret;
> +	struct sk_buff *skb;
> +	void *hdr;
> +
> +	trace_binder_send_report(context->name, err, pid, tid, to_pid, to_tid,
> +				 reply, tr);
> +
> +	payload = nla_total_size(strlen(context->name) + 1) +
> +		  nla_total_size(sizeof(u32)) * (BINDER_GENL_A_REPORT_MAX - 1);
> +	skb = genlmsg_new(payload + GENL_HDRLEN, GFP_KERNEL);

 genlmsg_new() adds the GENL_HDRLEN already

> +	if (!skb) {
> +		pr_err("Failed to alloc binder genl message\n");
> +		return;
> +	}
> +
> +	hdr = genlmsg_put(skb, 0, atomic_inc_return(&context->report_seq),
> +			  &binder_genl_nl_family, 0, BINDER_GENL_CMD_REPORT);
> +	if (!hdr)
> +		goto free_skb;
> +
> +	if (nla_put_string(skb, BINDER_GENL_A_REPORT_CONTEXT, context->name) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_ERR, err) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_FROM_PID, pid) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_FROM_TID, tid) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_TO_PID, to_pid) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_TO_TID, to_tid) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_REPLY, reply) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_FLAGS, tr->flags) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_CODE, tr->code) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_REPORT_DATA_SIZE, tr->data_size))
> +		goto cancel_skb;
> +
> +	genlmsg_end(skb, hdr);
> +
> +	ret = genlmsg_unicast(&init_net, skb, context->report_portid);
> +	if (ret < 0)
> +		pr_err("Failed to send binder genl message to %d: %d\n",
> +		       context->report_portid, ret);
> +	return;
> +
> +cancel_skb:
> +	pr_err("Failed to add report attributes to binder genl message\n");
> +	genlmsg_cancel(skb, hdr);
> +free_skb:
> +	pr_err("Free binder genl report message on error\n");
> +	nlmsg_free(skb);
> +}

> +/**
> + * binder_genl_nl_set_doit() - .doit handler for BINDER_GENL_CMD_SET
> + * @skb:	the metadata struct passed from netlink driver
> + * @info:	the generic netlink struct passed from netlink driver
> + *
> + * Implements the .doit function to process binder genl commands.
> + */
> +int binder_genl_nl_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	int payload;
> +	int portid;
> +	u32 pid;
> +	u32 flags;
> +	void *hdr;
> +	struct binder_device *device;
> +	struct binder_context *context = NULL;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, BINDER_GENL_A_CMD_CONTEXT) ||
> +	    GENL_REQ_ATTR_CHECK(info, BINDER_GENL_A_CMD_PID) ||
> +	    GENL_REQ_ATTR_CHECK(info, BINDER_GENL_A_CMD_FLAGS))
> +		return -EINVAL;
> +
> +	hlist_for_each_entry(device, &binder_devices, hlist) {
> +		if (!nla_strcmp(info->attrs[BINDER_GENL_A_CMD_CONTEXT],
> +				device->context.name)) {
> +			context = &device->context;
> +			break;
> +		}
> +	}
> +
> +	if (!context) {
> +		NL_SET_ERR_MSG(info->extack, "Unknown binder context\n");
> +		return -EINVAL;
> +	}
> +
> +	portid = nlmsg_hdr(skb)->nlmsg_pid;
> +	pid = nla_get_u32(info->attrs[BINDER_GENL_A_CMD_PID]);
> +	flags = nla_get_u32(info->attrs[BINDER_GENL_A_CMD_FLAGS]);
> +
> +	if (context->report_portid && context->report_portid != portid) {
> +		NL_SET_ERR_MSG_FMT(info->extack,
> +				   "No permission to set flags from %d\n",
> +				   portid);
> +		return -EPERM;
> +	}
> +
> +	if (binder_genl_set_report(context, pid, flags) < 0) {
> +		pr_err("Failed to set report flags %u for %u\n", flags, pid);
> +		return -EINVAL;
> +	}
> +
> +	payload = nla_total_size(sizeof(pid)) + nla_total_size(sizeof(flags));
> +	skb = genlmsg_new(payload + GENL_HDRLEN, GFP_KERNEL);
> +	if (!skb) {
> +		pr_err("Failed to alloc binder genl reply message\n");
> +		return -ENOMEM;

no need for error messages on allocation failures, kernel will print an
OOM report

> +	}
> +
> +	hdr = genlmsg_iput(skb, info);
> +	if (!hdr)
> +		goto free_skb;
> +
> +	if (nla_put_string(skb, BINDER_GENL_A_CMD_CONTEXT, context->name) ||

Have you counted strlen(context->name) to payload?
TBH for small messages counting payload size is probably an overkill,
you can use NLMSG_GOODSIZE as the size of the skb.

> +	    nla_put_u32(skb, BINDER_GENL_A_CMD_PID, pid) ||
> +	    nla_put_u32(skb, BINDER_GENL_A_CMD_FLAGS, flags))
> +		goto cancel_skb;
> +
> +	genlmsg_end(skb, hdr);
> +
> +	if (genlmsg_reply(skb, info)) {
> +		pr_err("Failed to send binder genl reply message\n");
> +		return -EFAULT;
> +	}
> +
> +	if (!context->report_portid)
> +		context->report_portid = portid;

Is there any locking required?

> +	return 0;
> +
> +cancel_skb:
> +	pr_err("Failed to add reply attributes to binder genl message\n");
> +	genlmsg_cancel(skb, hdr);
> +free_skb:
> +	pr_err("Free binder genl reply message on error\n");
> +	nlmsg_free(skb);
> +	return -EMSGSIZE;
> +}


