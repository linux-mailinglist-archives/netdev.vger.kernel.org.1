Return-Path: <netdev+bounces-182579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2798BA89296
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8221896AC7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4B1A23BD;
	Tue, 15 Apr 2025 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh7c+h4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1C212FAB
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688387; cv=none; b=b7UaFxJdaKjREkJ4yk0zJAtZ4UwoDykZsM/E6GiBeJ+3IYysKEYZDwCkMluRY8BQJTgkWkPYi7euwfygPMV5ex0vmnXmhRbWbSUVQ7FDqHQ4Dmwi1Fiq9YFilkEqWB6XRmnEnotNlKix+Njf/Z70cKajRgY4vlQ3i3nkxx3CrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688387; c=relaxed/simple;
	bh=9xlkwBOx7+55VFb9EgrPtEzotWf95XgwbhSfFB7iIYk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DCjdvBS88h8jM8zhwwhauIx5jalUPdKYdMwUbUVdvyAGmw5ikmfpTwQajoca/he9i/VYcls669wV6XZoSfWR9dSQ4o3ALlljBujtSABo2YrbqdLtpZbwzOPnFcL2bzOFxMxRNxZwJuyoeWGt5CpBIG3jmJ0Fge8iZbnxaDQPtcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh7c+h4g; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso5581234a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744688384; x=1745293184; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwT3Y/QkpZfk2z20zJXmNna8nuzxOd0Il7oUMcoEoNc=;
        b=mh7c+h4g/lHC02J457DT7PIOf7mReZgOTaftPO3XrS5FuZEcgjFswbCa7LQRWmnG7i
         gF9LwGIcpEdwhxTahWCtOVEfMGa+0E25x3zVs2Fh/IYk6DaG7cIJU9Y28hynjtdwb6no
         52sy/CR7vWePdSr5uLRxnuU3bmemUAnSkyZGiajLJ+RisQaA+fiYQ7IwlCmrFUGE4xnf
         3SxQyDcIdKZuV+k1EtESKDtkfw2eDChaO8wDKpDX/Y5EVrf7c4phc88Oh1gUxDOwnF/B
         xRYN+syNvaULLDIgNUUMAkEff1JpdywFbvEzK0lFsdbEhDAmtd5hiNzur06dJ/IUmt1t
         huLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744688384; x=1745293184;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwT3Y/QkpZfk2z20zJXmNna8nuzxOd0Il7oUMcoEoNc=;
        b=VzRj7NNGQT/zjbQorNGptyz7ogdB0uTzABaMG3hwORakcGxVdWA30AnUFPlm1jBFRe
         lR5UMrFeWm30xeaF3Mi6572llLtGbDAhtFCqKBthmv5DPKsZIYE5D+TGXfWW58cm4UT4
         JjYAM4l6numNbIrgiNqhZVp2sILnKvrSkC7YBjxTUa8yFc0WZDFVNTtC5D+xNYm03YiE
         rsMzgxbEFRXn7JBV8AVEnC197p0DrZs74g1v0uoeDXRZqeYr7KGd5mnplxFgmRCl0snf
         Bvz19Qu3xnMi8aAKqbDCcSuI7P6eGWN6j92FhjKrRdYobuEXuQPHjO6v8tJdsNO5xDPh
         EQAw==
X-Gm-Message-State: AOJu0Yxbfq//S7mwAw0gg6AFfwHJvjtikLQILDY7mdm31on19fztmTGw
	Iq2NnOBNJl2bz/lCVavV1XjDb/OgE7pFaMRxgMq9Yacj9p3x9jOPf6UGQQJFuVAtOrx3TsBK9/A
	T9Nd61W9+mZ8ZfaUowmD58WTIblrg2UHCsRVNMA==
X-Gm-Gg: ASbGncsv+1mX4Dg26Fj7yUSZkynvw+ZIdB0HKrN6YYhKsyogZ3ragHaUnXBUv4Gg8cT
	j8jtn1x1FpkNbXcA5nyj8pgkc0d1TK8jV1+80b5AKD5HIJps1SOyuibXpV+bCGsOU4Qzwbo4I4h
	0fx274SD0kizD0SiVUQ8MZQCY=
X-Google-Smtp-Source: AGHT+IFPuaQ1S0Nq6WzI4G+HWzkOr4UUAwi7aBcBkCCdmAbuVrV8r4QxGfaumdCrx+jKXQfpAGIseTNwKlDYGy12l10=
X-Received: by 2002:a17:90b:3eca:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-30823646c73mr23635926a91.10.1744688384404; Mon, 14 Apr 2025
 20:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abagail ren <renzezhongucas@gmail.com>
Date: Tue, 15 Apr 2025 11:39:31 +0800
X-Gm-Features: ATxdqUEVkSCE_a7FWDtnhT95e1TrjDwcs5IqDUOsocnzSKa39ikq_GPl3BigH_w
Message-ID: <CALkECRgvg9us9Mp79G-cQ8dOwUA=oHH8jY=Q0ApLNDDNGAg4OQ@mail.gmail.com>
Subject: [BUG] General protection fault in percpu_counter_add_batch() during
 netns cleanup
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi maintainers,

In case the previous message was rejected due to attachments and HTML,
I am resending this report in plain text format.

During fuzzing of the Linux kernel, we encountered a general protection
fault in `percpu_counter_add_batch()` while executing the
`cleanup_net` workqueue. The crash was triggered during the destruction of a
network namespace containing a WireGuard interface. This was reproduced
on kernel version v6.12-rc6.

Crash Details:

Oops: general protection fault, probably for non-canonical address
0xfc3ffbf11006d3ec: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0xe1ffff8880369f60-0xe1ffff8880369f67]

CPU: 0 PID: 10492 Comm: kworker/u8:4 Not tainted 6.12.0-rc6 #2
Hardware: QEMU Standard PC (i440FX + PIIX, 1996)

RIP: 0010:percpu_counter_add_batch+0x36/0x1f0 lib/percpu_counter.c:98
Faulting instruction:
    cmpb $0x0,(%rdx,%rax,1)

Call Trace:
 dst_entries_add                    include/net/dst_ops.h:59
 dst_count_dec                      net/core/dst.c:159
 dst_release                        net/core/dst.c:165
 dst_cache_reset_now                net/core/dst_cache.c:169
 wg_socket_clear_peer_endpoint_src drivers/net/wireguard/socket.c:312
 wg_netns_pre_exit                  drivers/net/wireguard/device.c:423
 ops_pre_exit_list                  net/core/net_namespace.c:163
 cleanup_net                        net/core/net_namespace.c:606
 process_one_work                   kernel/workqueue.c:3229
 worker_thread                      kernel/workqueue.c:3391
 kthread                            kernel/kthread.c:389
 ret_from_fork                      arch/x86/kernel/process.c:147

Reproducer Notes:

The issue was triggered during `netns` teardown while a WireGuard device
was active. It appears to involve use-after-free of a `percpu_counter`
structure, likely after its owning peer or device was destroyed.

Environment:

 - Kernel: 6.12.0-rc6
 - Platform: QEMU (x86_64)
 - Trigger: `netns` teardown with WireGuard devices present

Related discussion (possible fix?):

Subject: [PATCH net] net: decrease cached dst counters in dst_release

Upstream fix ac888d58869b ("net: do not delay dst_entries_add() in
dst_release()") moved decrementing the dst count from dst_destroy to
dst_release to avoid accessing already freed data in case of netns
dismantle. However, in case CONFIG_DST_CACHE is enabled and OvS+tunnels
are used, this fix is incomplete, as the same issue will be seen for
cached dsts:

  Unable to handle kernel paging request at virtual address ffff5aabf6b5c000
  Call trace:
   percpu_counter_add_batch+0x3c/0x160 (P)
   dst_release+0xec/0x108
   dst_cache_destroy+0x68/0xd8
   dst_destroy+0x13c/0x168
   dst_destroy_rcu+0x1c/0xb0
   rcu_do_batch+0x18c/0x7d0
   rcu_core+0x174/0x378
   rcu_core_si+0x18/0x30

Fix this by invalidating the cache, and thus decrementing cached dst
counters, in dst_release too.

Fixes: d71785ffc7e7 ("net: add dst_cache to ovs vxlan lwtunnel")

If this has already been resolved, I'm sorry for the noise. Please let
me know if more trace or repro information would be useful.

Best regards,
Zezhong Ren

