Return-Path: <netdev+bounces-152347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4739F388F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587A3168A1A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E772207A25;
	Mon, 16 Dec 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rscwysoZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1B207A09
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372745; cv=none; b=iirW4kWSeN8rfiSNr3P57Mr9QUChP2Nzany99nauQqbJMt83VxMTvPyBHnpseck86YLR1O2StT0g85MksAD0pq6J5PLE+fEY6+nqm5WQWbIc3fUWapDOwMSl7Awn45HacTC3W0cimoONDhV/RD5rAdT3AptgPe0sRinoky3jWko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372745; c=relaxed/simple;
	bh=NAMkqvjyjzEhrzj9HyHkJzqaWLMFTsWM8E07sNl9HJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX378Q331UT1wtNMNOLKR3f41wF3ZcJZYkNlewUWbyRSRrB6/aph8AD1NYd5vTFJqm2xYURyqCXNYVtPJ3nDvEkxWs6IuJQMOqUollQEbonzGVBjN/tMANW6KLspYMHih99rtDO+hTNc48slk/lA5lszhpXE4XsYzTN960p/oug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rscwysoZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215740b7fb8so8245ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 10:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734372743; x=1734977543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4DdfO0nYZ+/1J5cyUBt/nzIbkFFhM2nZz/opvI7d38=;
        b=rscwysoZevMezCxoF1pSg5V3oGjSai/+BRiibKqt1DbZF3tVBVGz69B+M8k0E/0D78
         bLh+LuSs9vR6vweCA7xMb2eHuxSEc2GbuyI0kfbFVT/Xf3nkp1RZGamf1t23q7wkkRKQ
         MdVJB8OyJxhwRL1Ns/51tB4Ouv57hKlDkzx9pm/vZN8OiO84cqh1A4u2FLevLga5qSHC
         d2ELtbO+sMqeMcneiTCdsUvU9sFwHW54Jsb0Af4hxdJxBS80AJfdg9mvHjeigeEj4Z40
         bqvHVbiKU4Zg2bXSH72bYXEyTZEYy6OClU+PLh74J23RJrc4R7IRlnCm7PhiEG8Z7Azg
         yYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372743; x=1734977543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4DdfO0nYZ+/1J5cyUBt/nzIbkFFhM2nZz/opvI7d38=;
        b=rKYbAVgZPJcfesHRdV4dfGvfMWwf1iAyoHTA7dzdHwBUJXct40Q40UpanR7YHwbjUG
         fvPjiqn3YHoSs+5eCNfVat6EoOW+fy0zgmXzIoxJMO3mGMmWoFOlJejoCEF/vdRUmE3o
         XL+yA/UwLLGEJV20REovImK2vaw88Z3/fEhSXKVGPYxftJS0u9caTl/wHCJPtKIwFP1r
         p+gOG6jO9m2buztKC23MyCAaracNk7Smkc0X2prp4uoJRCxoO4jU72HemY3AhGD7m3Ji
         cjIsXf0qlc0u015OLTEw0rwmIRq8dMebO3d+iytaC5S+gxwfZGfdL2TdUimSgI6GcOdd
         bN/w==
X-Forwarded-Encrypted: i=1; AJvYcCU2XuTEjSG4206naNPPc9H9ilaRHJfnXqI7TA48a8igjFifx71+vfu5VeXctPTntvuZvnyDXpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vX4MW6E7kTT8USQPtoo3tkzv8SvvB00DWL9THeG+H4ABNAZo
	iMKyd7ARN5EfHosei97nGuZvZ0Z5UyCWZLyKZNnN8tasNIx6oc54vrs47TIdBA==
X-Gm-Gg: ASbGncujBSajoIFEdmQR8DwNJ31ryVmCK8rn9t1UomBjc/ByAkIKnypzS6AlORN/ILC
	GN5XVOcUE3glZ8jir/Q3Sb5od93ESLAr0pCgghind6eMRAzBSMCu2QZpugq12LxNmLqSdBqpmxw
	KQraBVgRc0elS2LnazbiQKz0KCwLfYA+VzeEj1ckx5dga2UKR14Mag7eZuuoF2iX+WK6OfofPVH
	gycGvYARG4WXBz7qbGHo5+JPVgHXN8aDKTZnQbBX5FVv9iSiHGpE1MRFNFRoxvgIHGdcpylFbpI
	vNSox4F3ncSbEQSUxvw=
X-Google-Smtp-Source: AGHT+IEfEXxe6/88B7W3Ta+rHBgd4CloRpBzbKVVffZppyqMz0jW8gRGU5GdUqod3Ic1zoXiNpGZyQ==
X-Received: by 2002:a17:903:2441:b0:215:98fd:cb04 with SMTP id d9443c01a7336-218a454adb3mr4316275ad.25.1734372742230;
        Mon, 16 Dec 2024 10:12:22 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d927c6sm8398373a91.8.2024.12.16.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:12:21 -0800 (PST)
Date: Mon, 16 Dec 2024 18:12:18 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH net-next v10 2/2] binder: report txn errors via generic
 netlink
Message-ID: <Z2BtgqkPUZxE8B83@google.com>
References: <20241212224114.888373-1-dualli@chromium.org>
 <20241212224114.888373-3-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212224114.888373-3-dualli@chromium.org>

On Thu, Dec 12, 2024 at 02:41:14PM -0800, Li Li wrote:
> From: Li Li <dualli@google.com>
> 
> Introduce generic netlink messages into the binder driver so that the
> Linux/Android system administration process can listen to important
> events and take corresponding actions, like stopping a broken app from
> attacking the OS by sending huge amount of spamming binder transactions.
> 
> The binder netlink sources and headers are automatically generated from
> the corresponding binder_netlink YAML spec. Don't modify them directly.
> 
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  Documentation/admin-guide/binder_genl.rst     | 110 ++++++++

Thanks for renaming to "Binder Netlink" this seems much better IMO.
Also, I belive the documentation should also be binder_netlink.rst in
such case?

>  Documentation/admin-guide/index.rst           |   1 +
>  .../netlink/specs/binder_netlink.yaml         | 108 ++++++++
>  drivers/android/Kconfig                       |   1 +
>  drivers/android/Makefile                      |   2 +-
>  drivers/android/binder.c                      | 237 +++++++++++++++++-
>  drivers/android/binder_internal.h             |  21 +-
>  drivers/android/binder_netlink.c              |  39 +++
>  drivers/android/binder_netlink.h              |  19 ++
>  drivers/android/binder_trace.h                |  35 +++
>  include/uapi/linux/android/binder_netlink.h   |  55 ++++
>  11 files changed, 622 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/admin-guide/binder_genl.rst
>  create mode 100644 Documentation/netlink/specs/binder_netlink.yaml
>  create mode 100644 drivers/android/binder_netlink.c
>  create mode 100644 drivers/android/binder_netlink.h
>  create mode 100644 include/uapi/linux/android/binder_netlink.h
> 
> diff --git a/Documentation/admin-guide/binder_genl.rst b/Documentation/admin-guide/binder_genl.rst
> new file mode 100644
> index 000000000000..71b4c6596c5b
> --- /dev/null
> +++ b/Documentation/admin-guide/binder_genl.rst
> @@ -0,0 +1,110 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================================================
> +Generic Netlink for the Android Binder Driver (Binder Netlink)
> +==============================================================
> +
> +The Generic Netlink subsystem in the Linux kernel provides a generic way for
> +the Linux kernel to communicate with the user space applications via binder
> +driver. It is used to report binder transaction errors and warnings to user
> +space administration process. The driver allows multiple binder devices and
> +their corresponding binder contexts. Each context has an independent Generic
> +Netlink for security reason. To prevent untrusted user applications from
> +accessing the netlink data, the kernel driver uses unicast mode instead of
> +multicast.
> +
> +Basically, the user space code uses the BINDER_NETLINK_CMD_REPORT_SETUP
> +command to request what kind of binder transactions should be reported by
> +the driver. The driver then echoes the attributes in a reply message to
> +acknowledge the request. The BINDER_NETLINK_CMD_REPORT_SETUP command also
> +registers the current user space process to receive the reports. When the
> +user space process exits, the previous request will be reset automatically.
> +
> +Currently the driver reports these binder transaction errors and warnings.
> +1. "FAILED" transactions that fail to reach the target process;
> +2. "ASYNC_FROZEN" transactions that are delayed due to the target process
> +being frozen by cgroup freezer; or
> +3. "SPAM" transactions that are considered spamming according to existing
> +logic in binder_alloc.c.
> +
> +When the specified binder transactions happen, the driver uses the
> +BINDER_NETLINK_CMD_REPORT command to send a generic netlink message to the
> +registered process, containing the payload defined in binder_netlink.yaml.
> +
> +More details about the flags, attributes and operations can be found at the
> +the doc sections in Documentations/netlink/specs/binder_netlink.yaml and the
> +kernel-doc comments of the new source code in binder.{h|c}.
> +
> +Using Binder Netlink
> +--------------------
> +
> +The Binder Netlink can be used in the same way as any other generic netlink
> +drivers. Userspace application uses a raw netlink socket to send commands
> +to and receive packets from the kernel driver.
> +
> +.. note::
> +    If the userspace application that talks to the driver exits, the kernel
> +    driver will automatically reset the configuration to the default and
> +    stop sending more reports, which would otherwise fail.
> +
> +Usage example (user space pseudo code):
> +
> +::
> +    /*
> +     * send() below is overloaded to pack netlink commands and attributes
> +     * to nlattr/genlmsghdr/nlmsghdr and then send to the netlink socket.
> +     *
> +     * recv() below is overloaded to receive the raw netlink message from
> +     * the netlink socket, parse nlmsghdr/genlmsghdr to find the netlink
> +     * command and then return the nlattr payload.
> +     */
> +
> +    // open netlink socket
> +    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> +
> +    // bind netlink socket
> +    bind(fd, struct socketaddr);
> +
> +    // get the family id of the binder netlink
> +    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME,
> +            BINDER_NETLINK_FAMILY_NAME);
> +    void *data = recv(CTRL_CMD_NEWFAMILY);
> +    if (!has_nla_type(data, CTRL_ATTR_FAMILY_ID)) {
> +        // Binder Netlink isn't available on this version of Linux kernel
> +        return;
> +    }
> +    __u16 id = nla(data)[CTRL_ATTR_FAMILY_ID];
> +
> +    // enable per-context binder report
> +    send(fd, id, BINDER_NETLINK_CMD_REPORT_SETUP, "binder", 0,
> +            BINDER_NETLINK_FLAG_FAILED | BINDER_NETLINK_FLAG_DELAYED);
> +
> +    // confirm the per-context configuration
> +    data = recv(fd, BINDER_NETLINK_CMD_REPLY);
> +    char *context = nla(data)[BINDER_NETLINK_A_CMD_CONTEXT];
> +    __u32 pid =  nla(data)[BINDER_NETLINK_A_CMD_PID];
> +    __u32 flags = nla(data)[BINDER_NETLINK_A_CMD_FLAGS];
> +
> +    // set optional per-process report, overriding the per-context one
> +    send(fd, id, BINDER_NETLINK_CMD_REPORT_SETUP, "binder", getpid(),
> +            BINDER_NETLINK_FLAG_SPAM | BINDER_REPORT_OVERRIDE);
> +
> +    // confirm the optional per-process configuration
> +    data = recv(fd, BINDER_NETLINK_CMD_REPLY);
> +    context = nla(data)[BINDER_NETLINK_A_CMD_CONTEXT];
> +    pid =  nla(data)[BINDER_NETLINK_A_CMD_PID];
> +    flags = nla(data)[BINDER_NETLINK_A_CMD_FLAGS];
> +
> +    // wait and read all binder reports
> +    while (running) {
> +            data = recv(fd, BINDER_NETLINK_CMD_REPORT);
> +            auto *attr = nla(data)[BINDER_NETLINK_A_REPORT_XXX];
> +
> +            // process binder report
> +            do_something(*attr);
> +    }
> +
> +    // clean up
> +    send(fd, id, BINDER_NETLINK_CMD_REPORT_SETUP, 0, 0);
> +    send(fd, id, BINDER_NETLINK_CMD_REPORT_SETUP, getpid(), 0);
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
> diff --git a/Documentation/netlink/specs/binder_netlink.yaml b/Documentation/netlink/specs/binder_netlink.yaml
> new file mode 100644
> index 000000000000..7eef013e6f07
> --- /dev/null
> +++ b/Documentation/netlink/specs/binder_netlink.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)

I think you need a Copyright for this. I'm not sure if it would also be
needed for the Documentation though.

> +
> +name: binder_netlink
> +protocol: genetlink
> +uapi-header: linux/android/binder_netlink.h
> +doc: Netlink protocol to report binder transaction errors and warnings.
> +
> +definitions:
> +  -
> +    type: flags
> +    name: flag
> +    doc: Define what kind of binder transactions should be reported.
> +    entries: [ failed, async-frozen, spam, override ]
> +
> +attribute-sets:
> +  -
> +    name: cmd
> +    doc: The supported attributes of "report-setup" command.
> +    attributes:
> +      -
> +        name: context
> +        type: string
> +        doc: The binder context to enable binder netlink report.
> +      -
> +        name: pid
> +        type: u32
> +        doc: The binder proc to enable binder netlink report.
> +      -
> +        name: flags
> +        type: u32
> +        enum: flag
> +        doc: What kind of binder transactions should be reported.
> +  -
> +    name: report
> +    doc: The supported attributes of "report" command
> +    attributes:
> +      -
> +        name: context
> +        type: string
> +        doc: The binder context where the binder netlink report happens.
> +      -
> +        name: err
> +        type: u32
> +        doc: Copy of binder_driver_return_protocol returned to the sender.
> +      -
> +        name: from_pid
> +        type: u32
> +        doc: Sender pid of the corresponding binder transaction.
> +      -
> +        name: from_tid
> +        type: u32
> +        doc: Sender tid of the corresponding binder transaction.
> +      -
> +        name: to_pid
> +        type: u32
> +        doc: Target pid of the corresponding binder transaction.
> +      -
> +        name: to_tid
> +        type: u32
> +        doc: Target tid of the corresponding binder transaction.
> +      -
> +        name: reply
> +        type: u32
> +        doc: 1 means the transaction is a reply, 0 otherwise.
> +      -
> +        name: flags
> +        type: u32
> +        doc: Copy of binder_transaction_data->flags.
> +      -
> +        name: code
> +        type: u32
> +        doc: Copy of binder_transaction_data->code.
> +      -
> +        name: data_size
> +        type: u32
> +        doc: Copy of binder_transaction_data->data_size.
> +
> +operations:
> +  list:
> +    -
> +      name: report-setup
> +      doc: Set flags from user space.
> +      attribute-set: cmd
> +
> +      do:
> +        request: &params
> +          attributes:
> +            - context
> +            - pid
> +            - flags
> +        reply: *params
> +    -
> +      name: report
> +      doc: Send the requested reports to user space.
> +      attribute-set: report
> +
> +      event:
> +        attributes:
> +          - context
> +          - err
> +          - from_pid
> +          - from_tid
> +          - to_pid
> +          - to_tid
> +          - reply
> +          - flags
> +          - code
> +          - data_size
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 07aa8ae0a058..e2fa620934e2 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -4,6 +4,7 @@ menu "Android"
>  config ANDROID_BINDER_IPC
>  	bool "Android Binder IPC Driver"
>  	depends on MMU
> +	depends on NET
>  	default n
>  	help
>  	  Binder is used in Android for both communication between processes,
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c99c25..b8874dba884e 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -2,5 +2,5 @@
>  ccflags-y += -I$(src)			# needed for trace events
>  
>  obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
> -obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
> +obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o binder_netlink.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 0a16acd29653..44932659051c 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -72,6 +72,7 @@
>  
>  #include <linux/cacheflush.h>
>  
> +#include "binder_netlink.h"
>  #include "binder_internal.h"
>  #include "binder_trace.h"
>  
> @@ -2990,6 +2991,111 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
>  	binder_thread_dec_tmpref(from);
>  }
>  
> +/**
> + * binder_find_proc() - set binder report flags

the description of "binder report flags" is no longer accurate here.

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

fwiw, the for_each stops when proc is NULL, so you can just break and
return proc everytime. e.g.:

	mutex_lock(&binder_procs_lock);
	hlist_for_each_entry(proc, &binder_procs, proc_node) {
		if (proc->pid == pid)
			break;
	}
	mutex_unlock(&binder_procs_lock);

	return proc;


> +		}
> +	}
> +	mutex_unlock(&binder_procs_lock);
> +
> +	return NULL;
> +}
> +
> +/**
> + * binder_netlink_enabled() - check if binder netlink reports are enabled
> + * @proc:	the binder_proc to check
> + * @mask:	the categories of binder netlink reports
> + *
> + * Returns true if certain binder netlink reports are enabled for this binder
> + * proc (when per-process overriding takes effect) or context.
> + */
> +static bool binder_netlink_enabled(struct binder_proc *proc, u32 mask)
> +{
> +	struct binder_context *context = proc->context;
> +
> +	if (!context->report_portid)
> +		return false;
> +
> +	if (proc->report_flags & BINDER_NETLINK_FLAG_OVERRIDE)
> +		return (proc->report_flags & mask) != 0;
> +	else
> +		return (context->report_flags & mask) != 0;
> +}
> +
> +/**
> + * binder_netlink_report() - report one binder netlink event
> + * @context:	the binder context
> + * @err:	copy of binder_driver_return_protocol returned to the sender
> + * @pid:	sender process
> + * @tid:	sender thread
> + * @to_pid:	target process
> + * @to_tid:	target thread
> + * @reply:	whether the binder transaction is a reply
> + * @tr:		the binder transaction data
> + *
> + * Packs the report data into a binder netlink message and send it.
> + */
> +static void binder_netlink_report(struct binder_context *context, u32 err,
> +				  u32 pid, u32 tid, u32 to_pid, u32 to_tid,
> +				  u32 reply,
> +				  struct binder_transaction_data *tr)
> +{
> +	int ret;
> +	struct sk_buff *skb;
> +	void *hdr;
> +
> +	trace_binder_netlink_report(context->name, err, pid, tid, to_pid,
> +				    to_tid, reply, tr);
> +
> +	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!skb) {
> +		pr_err("Failed to alloc binder netlink message\n");
> +		return;
> +	}
> +
> +	hdr = genlmsg_put(skb, 0, atomic_inc_return(&context->report_seq),
> +			  &binder_netlink_nl_family, 0, BINDER_NETLINK_CMD_REPORT);
> +	if (!hdr)
> +		goto free_skb;
> +
> +	if (nla_put_string(skb, BINDER_NETLINK_A_REPORT_CONTEXT, context->name) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_ERR, err) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_FROM_PID, pid) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_FROM_TID, tid) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_TO_PID, to_pid) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_TO_TID, to_tid) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_REPLY, reply) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_FLAGS, tr->flags) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_CODE, tr->code) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_REPORT_DATA_SIZE, tr->data_size))
> +		goto cancel_skb;
> +
> +	genlmsg_end(skb, hdr);
> +
> +	ret = genlmsg_unicast(&init_net, skb, context->report_portid);
> +	if (ret < 0)
> +		pr_err("Failed to send binder netlink message to %d: %d\n",
> +		       context->report_portid, ret);
> +	return;
> +
> +cancel_skb:
> +	pr_err("Failed to add attributes to binder netlink message\n");
> +	genlmsg_cancel(skb, hdr);
> +free_skb:
> +	pr_err("Free binder netlink report message on error\n");
> +	nlmsg_free(skb);
> +}
> +
>  static void binder_transaction(struct binder_proc *proc,
>  			       struct binder_thread *thread,
>  			       struct binder_transaction_data *tr, int reply,
> @@ -3684,10 +3790,17 @@ static void binder_transaction(struct binder_proc *proc,
>  		return_error_line = __LINE__;
>  		goto err_copy_data_failed;
>  	}
> -	if (t->buffer->oneway_spam_suspect)
> +	if (t->buffer->oneway_spam_suspect) {
>  		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
> -	else
> +		if (binder_netlink_enabled(proc, BINDER_NETLINK_FLAG_SPAM))
> +			binder_netlink_report(context, BR_ONEWAY_SPAM_SUSPECT,
> +					      proc->pid, thread->pid,
> +					      target_proc ? target_proc->pid : 0,
> +					      target_thread ? target_thread->pid : 0,
> +					      reply, tr);
> +	} else {
>  		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
> +	}
>  	t->work.type = BINDER_WORK_TRANSACTION;
>  
>  	if (reply) {
> @@ -3737,8 +3850,15 @@ static void binder_transaction(struct binder_proc *proc,
>  		 * process and is put in a pending queue, waiting for the target
>  		 * process to be unfrozen.
>  		 */
> -		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
> +		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
>  			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
> +			if (binder_netlink_enabled(proc, BINDER_NETLINK_FLAG_ASYNC_FROZEN))
> +				binder_netlink_report(context, return_error,
> +						      proc->pid, thread->pid,
> +						      target_proc ? target_proc->pid : 0,
> +						      target_thread ? target_thread->pid : 0,
> +						      reply, tr);
> +		}
>  		binder_enqueue_thread_work(thread, tcomplete);
>  		if (return_error &&
>  		    return_error != BR_TRANSACTION_PENDING_FROZEN)
> @@ -3800,6 +3920,13 @@ static void binder_transaction(struct binder_proc *proc,
>  		binder_dec_node_tmpref(target_node);
>  	}
>  
> +	if (binder_netlink_enabled(proc, BINDER_NETLINK_FLAG_FAILED))
> +		binder_netlink_report(context, return_error,
> +				      proc->pid, thread->pid,
> +				      target_proc ? target_proc->pid : 0,
> +				      target_thread ? target_thread->pid : 0,
> +				      reply, tr);
> +
>  	binder_debug(BINDER_DEBUG_FAILED_TRANSACTION,
>  		     "%d:%d transaction %s to %d:%d failed %d/%d/%d, size %lld-%lld line %d\n",
>  		     proc->pid, thread->pid, reply ? "reply" :
> @@ -6137,6 +6264,11 @@ static int binder_release(struct inode *nodp, struct file *filp)
>  
>  	binder_defer_work(proc, BINDER_DEFERRED_RELEASE);
>  
> +	if (proc->pid == proc->context->report_portid) {
> +		proc->context->report_portid = 0;
> +		proc->context->report_flags = 0;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -6335,6 +6467,99 @@ binder_defer_work(struct binder_proc *proc, enum binder_deferred_state defer)
>  	mutex_unlock(&binder_deferred_lock);
>  }
>  
> +/**
> + * binder_netlink_nl_report_setup_doit() - netlink .doit handler
> + * @skb:	the metadata struct passed from netlink driver
> + * @info:	the generic netlink struct passed from netlink driver
> + *
> + * Implements the .doit function to process binder netlink commands.
> + */
> +int binder_netlink_nl_report_setup_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	int portid;
> +	u32 pid;
> +	u32 flags;
> +	void *hdr;
> +	struct binder_proc *proc;
> +	struct binder_device *device;
> +	struct binder_context *context = NULL;
> +
> +	hlist_for_each_entry(device, &binder_devices, hlist) {
> +		if (!nla_strcmp(info->attrs[BINDER_NETLINK_A_CMD_CONTEXT],
> +				device->context.name)) {
> +			context = &device->context;
> +			break;
> +		}
> +	}
> +
> +	if (!context) {
> +		NL_SET_ERR_MSG(info->extack, "Unknown binder context");
> +		return -EINVAL;
> +	}
> +
> +	portid = nlmsg_hdr(skb)->nlmsg_pid;
> +	pid = nla_get_u32(info->attrs[BINDER_NETLINK_A_CMD_PID]);
> +	flags = nla_get_u32(info->attrs[BINDER_NETLINK_A_CMD_FLAGS]);
> +
> +	if (context->report_portid && context->report_portid != portid) {
> +		NL_SET_ERR_MSG_FMT(info->extack,
> +				   "No permission to set flags from %d",
> +				   portid);
> +		return -EPERM;
> +	}
> +
> +	if (!pid) {
> +		/* Set the global flags for the whole binder context */
> +		context->report_flags = flags;
> +	} else {
> +		/* Set the per-process flags */
> +		proc = binder_find_proc(pid);
> +		if (!proc) {
> +			NL_SET_ERR_MSG_FMT(info->extack,
> +					   "Invalid binder report pid %u",
> +					   pid);
> +			return -EINVAL;
> +		}
> +
> +		proc->report_flags = flags;
> +	}
> +
> +	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!skb) {
> +		pr_err("Failed to alloc binder netlink reply message\n");
> +		return -ENOMEM;
> +	}
> +
> +	hdr = genlmsg_iput(skb, info);
> +	if (!hdr)
> +		goto free_skb;
> +
> +	if (nla_put_string(skb, BINDER_NETLINK_A_CMD_CONTEXT, context->name) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_CMD_PID, pid) ||
> +	    nla_put_u32(skb, BINDER_NETLINK_A_CMD_FLAGS, flags))
> +		goto cancel_skb;
> +
> +	genlmsg_end(skb, hdr);
> +
> +	if (genlmsg_reply(skb, info)) {
> +		pr_err("Failed to send binder netlink reply message\n");
> +		return -EFAULT;
> +	}
> +
> +	if (!context->report_portid)
> +		context->report_portid = portid;
> +
> +	return 0;
> +
> +cancel_skb:
> +	pr_err("Failed to add reply attributes to binder netlink message\n");
> +	genlmsg_cancel(skb, hdr);
> +free_skb:
> +	pr_err("Free binder netlink reply message on error\n");
> +	nlmsg_free(skb);
> +	return -EMSGSIZE;
> +}
> +
>  static void print_binder_transaction_ilocked(struct seq_file *m,
>  					     struct binder_proc *proc,
>  					     const char *prefix,
> @@ -7014,6 +7239,12 @@ static int __init binder_init(void)
>  	if (ret)
>  		goto err_init_binder_device_failed;
>  
> +	ret = genl_register_family(&binder_netlink_nl_family);
> +	if (ret) {
> +		pr_err("Failed to register binder netlink family\n");
> +		goto err_init_binder_device_failed;
> +	}
> +
>  	return ret;
>  
>  err_init_binder_device_failed:
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 1f21ad3963b1..c67eba88f89a 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -12,21 +12,35 @@
>  #include <linux/stddef.h>
>  #include <linux/types.h>
>  #include <linux/uidgid.h>
> +#include <net/genetlink.h>
>  #include <uapi/linux/android/binderfs.h>
>  #include "binder_alloc.h"
>  #include "dbitmap.h"
>  
> +/**
> + * struct binder_context - information about a binder domain
> + * @binder_context_mgr_node: the context manager
> + * @context_mgr_node_lock:   the lock protecting the above context manager node
> + * @binder_context_mgr_uid:  the uid of the above context manager
> + * @name:                    the name of the binder device
> + * @report_portid:           the netlink socket to receive binder reports
> + * @report_flags:            the categories of binder transactions that would
> + *                           be reported (see enum binder_report_flag).
> + * @report_seq:              the seq number of the generic netlink report
> + */
>  struct binder_context {
>  	struct binder_node *binder_context_mgr_node;
>  	struct mutex context_mgr_node_lock;
>  	kuid_t binder_context_mgr_uid;
>  	const char *name;
> +	u32 report_portid;
> +	u32 report_flags;
> +	atomic_t report_seq;
>  };
>  
>  /**
>   * struct binder_device - information about a binder device node
> - * @hlist:          list of binder devices (only used for devices requested via
> - *                  CONFIG_ANDROID_BINDER_DEVICES)
> + * @hlist:          list of binder devices

This is the hunk that needs to go on the first 1/2 patch.


>   * @miscdev:        information about a binder character device node
>   * @context:        binder context information
>   * @binderfs_inode: This is the inode of the root dentry of the super block
> @@ -415,6 +429,8 @@ struct binder_ref {
>   * @binderfs_entry:       process-specific binderfs log file
>   * @oneway_spam_detection_enabled: process enabled oneway spam detection
>   *                        or not
> + * @report_flags:         the categories of binder transactions that would
> + *                        be reported (see enum binder_genl_flag).
>   *
>   * Bookkeeping structure for binder processes
>   */
> @@ -453,6 +469,7 @@ struct binder_proc {
>  	spinlock_t outer_lock;
>  	struct dentry *binderfs_entry;
>  	bool oneway_spam_detection_enabled;
> +	u32 report_flags;
>  };
>  
>  /**
> diff --git a/drivers/android/binder_netlink.c b/drivers/android/binder_netlink.c
> new file mode 100644
> index 000000000000..2081b4319268
> --- /dev/null
> +++ b/drivers/android/binder_netlink.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/binder_netlink.yaml */
> +/* YNL-GEN kernel source */
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
> +#include "binder_netlink.h"
> +
> +#include <uapi/linux/android/binder_netlink.h>
> +
> +/* BINDER_NETLINK_CMD_REPORT_SETUP - do */
> +static const struct nla_policy binder_netlink_report_setup_nl_policy[BINDER_NETLINK_A_CMD_FLAGS + 1] = {
> +	[BINDER_NETLINK_A_CMD_CONTEXT] = { .type = NLA_NUL_STRING, },
> +	[BINDER_NETLINK_A_CMD_PID] = { .type = NLA_U32, },
> +	[BINDER_NETLINK_A_CMD_FLAGS] = NLA_POLICY_MASK(NLA_U32, 0xf),
> +};
> +
> +/* Ops table for binder_netlink */
> +static const struct genl_split_ops binder_netlink_nl_ops[] = {

not: There are several places where you have "netlink_nl" which seems
kind of redundant to me. wdyt? IMO you should drop the "nl" in all of
these cases.

> +	{
> +		.cmd		= BINDER_NETLINK_CMD_REPORT_SETUP,
> +		.doit		= binder_netlink_nl_report_setup_doit,
> +		.policy		= binder_netlink_report_setup_nl_policy,
> +		.maxattr	= BINDER_NETLINK_A_CMD_FLAGS,
> +		.flags		= GENL_CMD_CAP_DO,
> +	},
> +};
> +
> +struct genl_family binder_netlink_nl_family __ro_after_init = {
> +	.name		= BINDER_NETLINK_FAMILY_NAME,
> +	.version	= BINDER_NETLINK_FAMILY_VERSION,
> +	.netnsok	= true,
> +	.parallel_ops	= true,
> +	.module		= THIS_MODULE,
> +	.split_ops	= binder_netlink_nl_ops,
> +	.n_split_ops	= ARRAY_SIZE(binder_netlink_nl_ops),
> +};
> diff --git a/drivers/android/binder_netlink.h b/drivers/android/binder_netlink.h
> new file mode 100644
> index 000000000000..022cff5f7c38
> --- /dev/null
> +++ b/drivers/android/binder_netlink.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/binder_netlink.yaml */
> +/* YNL-GEN kernel header */
> +
> +#ifndef _LINUX_BINDER_NETLINK_GEN_H
> +#define _LINUX_BINDER_NETLINK_GEN_H
> +
> +#include <net/netlink.h>
> +#include <net/genetlink.h>
> +
> +#include <uapi/linux/android/binder_netlink.h>
> +
> +int binder_netlink_nl_report_setup_doit(struct sk_buff *skb,
> +					struct genl_info *info);
> +
> +extern struct genl_family binder_netlink_nl_family;
> +
> +#endif /* _LINUX_BINDER_NETLINK_GEN_H */
> diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> index fe38c6fc65d0..8976fb5ee2db 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -423,6 +423,41 @@ TRACE_EVENT(binder_return,
>  			  "unknown")
>  );
>  
> +TRACE_EVENT(binder_netlink_report,
> +	TP_PROTO(const char *name, u32 err, u32 pid, u32 tid, u32 to_pid,
> +		 u32 to_tid, u32 reply, struct binder_transaction_data *tr),
> +	TP_ARGS(name, err, pid, tid, to_pid, to_tid, reply, tr),
> +	TP_STRUCT__entry(
> +		__field(const char *, name)
> +		__field(u32, err)
> +		__field(u32, pid)
> +		__field(u32, tid)
> +		__field(u32, to_pid)
> +		__field(u32, to_tid)
> +		__field(u32, reply)
> +		__field(u32, flags)
> +		__field(u32, code)
> +		__field(binder_size_t, data_size)
> +	),
> +	TP_fast_assign(
> +		__entry->name = name;
> +		__entry->err = err;
> +		__entry->pid = pid;
> +		__entry->tid = tid;
> +		__entry->to_pid = to_pid;
> +		__entry->to_tid = to_tid;
> +		__entry->reply = reply;
> +		__entry->flags = tr->flags;
> +		__entry->code = tr->code;
> +		__entry->data_size = tr->data_size;
> +	),
> +	TP_printk("%s: %d %d:%d -> %d:%d %s flags=0x08%x code=%d %llu",
> +		  __entry->name, __entry->err, __entry->pid, __entry->tid,
> +		  __entry->to_pid, __entry->to_tid,
> +		  __entry->reply ? "reply" : "",
> +		  __entry->flags, __entry->code, __entry->data_size)
> +);
> +
>  #endif /* _BINDER_TRACE_H */
>  
>  #undef TRACE_INCLUDE_PATH
> diff --git a/include/uapi/linux/android/binder_netlink.h b/include/uapi/linux/android/binder_netlink.h
> new file mode 100644
> index 000000000000..2b1460387597
> --- /dev/null
> +++ b/include/uapi/linux/android/binder_netlink.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/binder_netlink.yaml */
> +/* YNL-GEN uapi header */
> +
> +#ifndef _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
> +#define _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
> +
> +#define BINDER_NETLINK_FAMILY_NAME	"binder_netlink"
> +#define BINDER_NETLINK_FAMILY_VERSION	1
> +
> +/*
> + * Define what kind of binder transactions should be reported.
> + */
> +enum binder_netlink_flag {
> +	BINDER_NETLINK_FLAG_FAILED = 1,
> +	BINDER_NETLINK_FLAG_ASYNC_FROZEN = 2,
> +	BINDER_NETLINK_FLAG_SPAM = 4,
> +	BINDER_NETLINK_FLAG_OVERRIDE = 8,
> +};
> +
> +enum {
> +	BINDER_NETLINK_A_CMD_CONTEXT = 1,
> +	BINDER_NETLINK_A_CMD_PID,
> +	BINDER_NETLINK_A_CMD_FLAGS,
> +
> +	__BINDER_NETLINK_A_CMD_MAX,
> +	BINDER_NETLINK_A_CMD_MAX = (__BINDER_NETLINK_A_CMD_MAX - 1)
> +};
> +
> +enum {
> +	BINDER_NETLINK_A_REPORT_CONTEXT = 1,
> +	BINDER_NETLINK_A_REPORT_ERR,
> +	BINDER_NETLINK_A_REPORT_FROM_PID,
> +	BINDER_NETLINK_A_REPORT_FROM_TID,
> +	BINDER_NETLINK_A_REPORT_TO_PID,
> +	BINDER_NETLINK_A_REPORT_TO_TID,
> +	BINDER_NETLINK_A_REPORT_REPLY,
> +	BINDER_NETLINK_A_REPORT_FLAGS,
> +	BINDER_NETLINK_A_REPORT_CODE,
> +	BINDER_NETLINK_A_REPORT_DATA_SIZE,
> +
> +	__BINDER_NETLINK_A_REPORT_MAX,
> +	BINDER_NETLINK_A_REPORT_MAX = (__BINDER_NETLINK_A_REPORT_MAX - 1)
> +};
> +
> +enum {
> +	BINDER_NETLINK_CMD_REPORT_SETUP = 1,
> +	BINDER_NETLINK_CMD_REPORT,
> +
> +	__BINDER_NETLINK_CMD_MAX,
> +	BINDER_NETLINK_CMD_MAX = (__BINDER_NETLINK_CMD_MAX - 1)
> +};
> +
> +#endif /* _UAPI_LINUX_ANDROID_BINDER_NETLINK_H */
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 

