Return-Path: <netdev+bounces-141369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629149BA987
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B44281BCA
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D074F18B494;
	Sun,  3 Nov 2024 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQBRltNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA74EB50;
	Sun,  3 Nov 2024 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730675756; cv=none; b=jqteDl4D8r/8znXe6WCwYBImjkLOvktrXo49DjW5d7nXyUSxCrhR1aY2KxqJqLgoQgDBFx6Cm4GlDkDGPIgwHS7kWgALPFB2bGq3T9lH6b9Hq6VmXZgGxpvLomn4yDnUz7kTX4swzYwi0dv7CSQ2K10hRujyfu8+6ZInJsSzO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730675756; c=relaxed/simple;
	bh=BE4DGyJ8XjLzaAsRPWHaw4RoO+TPlZsY/cThhh6d+Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kk022HZwGVS8oLtYJ1i/tlZ8kMGE4Tnv/bsTq7UcsaXR00zOuQfCgMCCuN64KwL2BnzhGH8216XhUmGZrHAQ12fGXOuienjMhMTmS0j8a0YB4/lpvzLXcfuhaIDJw56N77VP15FE/4VQMnhMHs+WnKFEm5YYih0ZCqmy5HxMWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQBRltNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2494EC4CECD;
	Sun,  3 Nov 2024 23:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730675756;
	bh=BE4DGyJ8XjLzaAsRPWHaw4RoO+TPlZsY/cThhh6d+Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQBRltNstbBw0WGplF7nRlkQ7LztYZCpG4LCj917GjVKxpiklE/kUjsw0VaYJPLJZ
	 uMsj294WitOfdRBaeQ5E9lEHOixCRXRsL3eLiSAAhd03y4Tf/P5byT8qCIOnk05uPX
	 ivaMcYuCv8+I7vBpylea9oypc1XETtXTbBG5s7rYDiVTlkoD/QCKBBtFKNNO9bHvlP
	 Mn0HvdK0h+VCrN3SiUtCC76sesfXektKKTzXum8NJr6oenwG9dZrGTRYSaQzuglwP4
	 PqKbqUV8qdPsrYqFRvjCK6tNVT3eRVQgxQb/Yyhau77MvUEYw5I/BP0i3YG9RVVh6P
	 QVS/Rw8eSypqQ==
Date: Sun, 3 Nov 2024 15:15:54 -0800
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
Subject: Re: [PATCH net-next v7 2/2] binder: report txn errors via generic
 netlink
Message-ID: <20241103151554.5fc79ce1@kernel.org>
In-Reply-To: <20241031092504.840708-3-dualli@chromium.org>
References: <20241031092504.840708-1-dualli@chromium.org>
	<20241031092504.840708-3-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 02:25:04 -0700 Li Li wrote:
> +===========================================================
> +Generic Netlink for the Android Binder Driver (Binder Genl)
> +===========================================================
> +
> +The Generic Netlink subsystem in the Linux kernel provides a generic way for
> +the Linux kernel to communicate to the user space applications via binder
> +driver. It is used to report various kinds of binder transactions to user
> +space administration process. The driver allows multiple binder devices and
> +their corresponding binder contexts. Each context has an independent Generic
> +Netlink for security reason. To prevent untrusted user applications from
> +accessing the netlink data, the kernel driver uses unicast mode instead of
> +multicast.
> +
> +Basically, the user space code uses the "set" command to request what kind
> +of binder transactions reported by the kernel binder driver. The driver then

Something is missing here. s/reported/should be reported/ ?

> +uses "reply" command to acknowledge the request. The "set" command also
> +registers the current user space process to receive the reports. When the
> +user space process exits, the previous request will be reset to prevent any
> +potential leaks.
> +
> +Currently the driver can report binder transactions that "failed" to reach
> +the target process, or that are "delayed" due to the target process being
> +frozen by cgroup freezer, or that are considered "spam" according to existing
> +logic in binder_alloc.c.
> +
> +When the specified binder transactions happen, the driver uses the "report"
> +command to send a generic netlink message to the registered process,
> +containing the payload struct binder_report.
> +
> +More details about the flags, attributes and operations can be found at the
> +the doc sections in Documentations/netlink/specs/binder_genl.yaml and the
> +kernel-doc comments of the new source code in binder.{h|c}.
> +
> +Using Binder Genl
> +-----------------
> +
> +The Binder Genl can be used in the same way as any other generic netlink
> +drivers. Userspace application uses a raw netlink socket to send commands
> +to and receive packets from the kernel driver.
> +
> +.. note::
> +    If the userspace application that talks to the driver exits, the kernel
> +    driver will automatically reset the configuration to the default and
> +    stop sending more reports to prevent leaking memory.
> +
> +Usage example (user space pseudo code):
> +
> +::
> +
> +    // open netlink socket
> +    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> +
> +    // bind netlink socket
> +    bind(fd, struct socketaddr);
> +
> +    // get the family id of the binder genl
> +    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME, "binder");
> +    void *data = recv(CTRL_CMD_NEWFAMILY);
> +    __u16 id = nla(data)[CTRL_ATTR_FAMILY_ID];
> +
> +    // enable per-context binder report
> +    send(fd, id, BINDER_GENL_CMD_SET, 0, BINDER_GENL_FLAG_FAILED |
> +            BINDER_GENL_FLAG_DELAYED);
> +
> +    // confirm the per-context configuration
> +    void *data = recv(fd, BINDER_GENL_CMD_REPLY);
> +    __u32 pid =  nla(data)[BINDER_GENL_A_CMD_PID];
> +    __u32 flags = nla(data)[BINDER_GENL_A_CMD_FLAGS];
> +
> +    // set optional per-process report, overriding the per-context one
> +    send(fd, id, BINDER_GENL_CMD_SET, getpid(),
> +            BINDER_GENL_FLAG_SPAM | BINDER_REPORT_OVERRIDE);
> +
> +    // confirm the optional per-process configuration
> +    void *data = recv(fd, BINDER_GENL_CMD_REPLY);
> +    __u32 pid =  nla(data)[BINDER_GENL_A_CMD_PID];
> +    __u32 flags = nla(data)[BINDER_GENL_A_CMD_FLAGS];
> +
> +    // wait and read all binder reports
> +    while (running) {
> +            void *data = recv(fd, BINDER_GENL_CMD_REPORT);
> +            u32 *attr = nla(data)[BINDER_GENL_A_REPORT_XXX];
> +
> +            // process binder report
> +            do_something(*attr);
> +    }
> +
> +    // clean up
> +    send(fd, id, BINDER_GENL_CMD_SET, 0, 0);
> +    send(fd, id, BINDER_GENL_CMD_SET, getpid(), 0);
> +    close(fd);
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index e85b1adf5908..b3b5cfadffe5 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -79,6 +79,7 @@ configure specific aspects of kernel behavior to your liking.
>     aoe/index
>     auxdisplay/index
>     bcache
> +   binder_genl
>     binderfs
>     binfmt-misc
>     blockdev/index
> diff --git a/Documentation/netlink/specs/binder_genl.yaml b/Documentation/netlink/specs/binder_genl.yaml
> new file mode 100644
> index 000000000000..35e5f0120fc7
> --- /dev/null
> +++ b/Documentation/netlink/specs/binder_genl.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +
> +name: binder_genl
> +protocol: genetlink
> +uapi-header: linux/android/binder_genl.h
> +doc: Netlink protocol to report binder transaction errors and warnings.
> +
> +definitions:
> +  -
> +    type: flags
> +    name: flag
> +    doc: |
> +      Used with "set" and "reply" command below, defining what kind of binder
> +      transactions reported to the user space administration process.

Please the references to which commands use given enum and attr.
The YAML specs are automatically rendered as HTML:
https://docs.kernel.org/next/networking/netlink_spec/net_shaper.html
so hopefully it's clear which attrs are used where.

> +    value-start: 0

I thought flags default to starting from 0 (or rather (1<<0))
Please delete this if it's not needed.

> +    entries: [ failed, delayed, spam, override ]
> +
> +attribute-sets:
> +  -
> +    name: cmd
> +    doc: The supported attributes of "set" and "reply" commands
> +    attributes:
> +      -
> +        name: pid
> +        type: u32
> +        doc: |
> +          What binder proc or context to enable binder genl report,
> +          used by "set" and "reply" command below.
> +      -
> +        name: flags
> +        type: u32
> +        doc: |
> +          What kind of binder transactions reported via binder genl,
> +          used by "set" and "reply" command below.
> +  -
> +    name: report
> +    doc: The supported attributes of "report" command
> +    attributes:
> +      -
> +        name: err
> +        type: u32
> +        doc: |
> +          Copy of binder_driver_return_protocol returned to the sender,
> +          used by "report" command below.
> +      -
> +        name: from_pid
> +        type: u32
> +        doc: |
> +          Sender pid of the corresponding binder transaction
> +          used by "report" command below.
> +      -
> +        name: from_tid
> +        type: u32
> +        doc: |
> +          Sender tid of the corresponding binder transaction
> +          used by "report" command below.
> +      -
> +        name: to_pid
> +        type: u32
> +        doc: |
> +          Target pid of the corresponding binder transaction
> +          used by "report" command below.
> +      -
> +        name: to_tid
> +        type: u32
> +        doc: |
> +          Target tid of the corresponding binder transaction
> +          used by "report" command below.
> +      -
> +        name: reply
> +        type: u32
> +        doc: |
> +          1 means the transaction is a reply, 0 otherwise
> +          used by "report" command below.
> +      -
> +        name: flags
> +        type: u32
> +        doc: |
> +          Copy of binder_transaction_data->flags
> +          used by "report" command below.
> +      -
> +        name: code
> +        type: u32
> +        doc: |
> +          Copy of binder_transaction_data->code
> +          used by "report" command below.
> +      -
> +        name: data_size
> +        type: u32
> +        doc: |
> +          Copy of binder_transaction_data->data_size
> +          used by "report" command below.
> +
> +operations:
> +  list:
> +    -
> +      name: set
> +      doc: |
> +        Set flags from user space, requesting what kinds of binder
> +        transactions to report.
> +      attribute-set: cmd
> +
> +      do:
> +        request: &params
> +          attributes:
> +            - pid
> +            - flags
> +        reply: *params
> +    -
> +      name: reply
> +      doc: Acknowledge the above "set" request, echoing the same params.

Hm, this looks strange. We shouldn't need a separate op entry for reply.
Operations are request + response.

> +    -
> +      name: report
> +      doc: Send the requested binder transaction reports to user space.

This is probably an event and contain the list of fields carried:
https://docs.kernel.org/next/userspace-api/netlink/specs.html
The list of fields is needed for user space C and C++ code gen.

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

please add

	enum: flag

to the definition of the flags field in YAML.
Netlink will auto-generate a policy checking that only values defined
in the enum are allowed.

> +		pr_err("Invalid binder report flags: %u\n", flags);
> +		return -EINVAL;
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

> @@ -6311,6 +6500,83 @@ binder_defer_work(struct binder_proc *proc, enum binder_deferred_state defer)
>  	mutex_unlock(&binder_deferred_lock);
>  }
>  
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
> +	struct binder_context *context;
> +
> +	/* Both attributes are required for BINDER_GENL_CMD_SET */
> +	if (!info->attrs[BINDER_GENL_A_CMD_PID] || !info->attrs[BINDER_GENL_A_CMD_FLAGS]) {

Use GENL_REQ_ATTR_CHECK, it will set metadata to let user space know
which attrs are missing

> +		pr_err("Attributes not set\n");

and then you can delete this

> +		return -EINVAL;
> +	}
> +
> +	portid = nlmsg_hdr(skb)->nlmsg_pid;
> +	pid = nla_get_u32(info->attrs[BINDER_GENL_A_CMD_PID]);
> +	flags = nla_get_u32(info->attrs[BINDER_GENL_A_CMD_FLAGS]);
> +	context = container_of(info->family, struct binder_context,
> +			       genl_family);
> +
> +	if (context->report_portid && context->report_portid != portid) {
> +		pr_err("No permission to set report flags from %u\n", portid);

It's better to communicate the errors to application using extack
(inside the netlink reply) using NL_SET_ERR_MSG(info->extack, "yourmsg")

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
> +	}
> +
> +	hdr = genlmsg_put_reply(skb, info, info->family, 0,
> +				BINDER_GENL_CMD_REPLY);

Use the same ID as the request, the BINDER_GENL_CMD_REPLY
shouldn't exist. And then you can use genlmsg_iput().

> +	if (!hdr)
> +		goto free_skb;
> +
> +	if (nla_put_u32(skb, BINDER_GENL_A_CMD_PID, pid))
> +		goto cancel_skb;
> +
> +	if (nla_put_u32(skb, BINDER_GENL_A_CMD_FLAGS, flags))

it's typical to chain all the nla_puts..

	if (nla_put_u32(skb, BINDER_GENL_A_CMD_PID, pid) ||
	    nla_put_u32(skb, BINDER_GENL_A_CMD_FLAGS, flags))

to avoid repeating the goto's for every field.

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
> +
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
> +
>  static void print_binder_transaction_ilocked(struct seq_file *m,
>  					     struct binder_proc *proc,
>  					     const char *prefix,
> @@ -6894,6 +7160,28 @@ const struct binder_debugfs_entry binder_debugfs_entries[] = {
>  	{} /* terminator */
>  };
>  
> +/**
> + * binder_genl_init() - initialize binder generic netlink
> + * @family:	the generic netlink family
> + * @name:	the binder device name
> + *
> + * Registers the binder generic netlink family.
> + */
> +int binder_genl_init(struct genl_family *family, const char *name)
> +{
> +	int ret;
> +
> +	memcpy(family, &binder_genl_nl_family, sizeof(*family));
> +	strscpy(family->name, name, GENL_NAMSIZ);

You're trying to register multiple families with different names?
The family defines the language / protocol. If you have multiple
entities to multiplex you should do that based on attributes inside
the messages.

> +	ret = genl_register_family(family);
> +	if (ret) {
> +		pr_err("Failed to register binder genl: %s\n", name);
> +		return ret;
> +	}
> +
> +	return 0;
> +}


