Return-Path: <netdev+bounces-289249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EDFMsXCC2qWMQUAu9opvQ
	(envelope-from <netdev+bounces-289249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:54:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ECE576306
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6EE0301A3BD
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C22F1FEA;
	Tue, 19 May 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIbPj/N0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4361F22257E;
	Tue, 19 May 2026 01:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779155651; cv=none; b=quwLC3nyQi9xO0YPXiMFJLFV0Fvyk9Y+AGCnc7juoLSOEAAMT4uyA68iIvVyaRvquSdFCO1OSW5Y/P88sSm9FCDq62BsK0gLsmZ5rIX0yDo4w2eCPmkzLJgdryOw2sF4CYgW6LKl1LwdOPp6XiVe2+IwLt2ib3mfXiMJv5QAOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779155651; c=relaxed/simple;
	bh=9FSlpH1+cu6zoGZ99wr3bklW6dbJAAEdSpsDVvK04nM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKXXxz3GBkUeSRqBn4JSX+boGFOBh9TFod8Nryv1LiC2/P24Rbfz5Y8ooTw+F/21pBZwTrLui6XQVZ5p7G0MmwD5O5kaaecjkk8mEX6f+7SgpQH74toR5UYkl6uQqjeDeo0avsXwtW8jR850X0+yztXPkuecJqT2wpcBiAbuG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIbPj/N0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72374C2BCB7;
	Tue, 19 May 2026 01:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779155650;
	bh=9FSlpH1+cu6zoGZ99wr3bklW6dbJAAEdSpsDVvK04nM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JIbPj/N051ActeaWG36H/M0mn176ueS0sPTzmcLMl9JB7P39vBlKeL3LcVUqcME9I
	 CVIhaRTb0Tqjhv0XuCB04ubLq7q7fvGSboxVVHQa7K6sfrX9chlr4iO0pR0i/UJP55
	 w9UAFvSSHIz2GPqwOz4q3aHgt4xwfrb8q3GK9ZNZnB6P0FyfgQ6MuhoxJYXmJDUlrc
	 yqu3rWcvPHtpXfewCfeFIeMfZKNA34bxn+te1rnLEPMlYEw1Yh7pNAXzB0bi+zTLWU
	 yaPVCp1tLEWSfaQKfO6RnESCB6qnvcQOsNJwODueHtuw5Q3Tsmy6r3AwHjp0TfV+Tj
	 qSVPNnxFTOEAA==
Date: Mon, 18 May 2026 18:54:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 zerocling0077@gmail.com, 2045gemini@gmail.com
Subject: Re: [PATCH] netpoll: normalize skb->dev to the netpoll device
Message-ID: <20260518185409.3e7f638e@kernel.org>
In-Reply-To: <20260515050511.106309-1-rollkingzzc@gmail.com>
References: <20260515050511.106309-1-rollkingzzc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-289249-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 33ECE576306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 13:05:11 +0800 Zhang Cen wrote:
> Sanitizer validation reported:
> KASAN slab-use-after-free in queue_process()
> Read of size 8
> Call trace:
>   dump_stack_lvl() (?:?)
>   print_report() (?:?)
>   srso_alias_return_thunk() (arch/x86/include/asm/nospec-branch.h:375)
>   __virt_addr_valid() (?:?)
>   kasan_complete_mode_report_info() (?:?)
>   kasan_report() (?:?)
>   queue_process() (net/core/netpoll.c:88)
>   kasan_check_range() (?:?)
>   __kasan_check_read() (?:?)
>   process_one_work() (kernel/workqueue.c:3200)
>   assign_work() (kernel/workqueue.c:1201)
>   worker_thread() (?:?)
>   kthread() (?:?)
>   ret_from_fork() (?:?)
>   __switch_to() (?:?)
>   __switch_to_asm() (arch/x86/include/asm/switch_to.h:9)
>   ret_from_fork_asm() (?:?)
>   kasan_save_stack() (mm/kasan/common.c:52)
>   kasan_save_track() (mm/kasan/common.c:74)
>   kasan_save_free_info() (?:?)
>   __kasan_slab_free() (?:?)
>   kfree() (?:?)
>   kvfree() (mm/slub.c:6876)
>   netdev_release() (net/core/net-sysfs.c:2227)
>   device_release() (?:?)
>   kobject_put() (lib/kobject.c:730)
>   put_device() (drivers/base/core.c:3810)
>   free_netdev() (net/core/dev.c:12164)
>   full_proxy_write() (?:?)
>   vfs_write() (fs/read_write.c:668)
>   ksys_write() (fs/read_write.c:729)
>   __x64_sys_write() (?:?)
>   x64_sys_call() (arch/x86/entry/syscall_64.c:35)
>   do_syscall_64() (arch/x86/entry/syscall_64.c:87)
>   entry_SYSCALL_64_after_hwframe() (?:?)

You trimmed the stack trace too much, the information about 
the object on which the UAF was detected is missing, and 
so is the UAF location.

Please add a Fixes tag (even if it's the first commit in git history).

With that fixed please repost.
-- 
pw-bot: cr

