Return-Path: <netdev+bounces-271816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJy/A1SlxGmZ1wQAu9opvQ
	(envelope-from <netdev+bounces-271816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:17:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1435832EAE4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 04:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E529930225A2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E33932C5;
	Thu, 26 Mar 2026 03:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JL2+CKQl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="drTwl0nY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EB1F2380
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774495040; cv=pass; b=cFnOMatZLR9+hILfq/ifSZOGeoKtsmkNlk7zq20PhAGG7nkFe0LVDBrgzZ7MxxFIjyf1YoBCJtzoaJ/z8yMPYNTlOSMMN/UxEN59TRPcf8Nn4KgdO9ogrh7tq5OGeJKFd5+AQ8Urib01rF+sNfSPqCeEOkqfXVKqgYEHq4BOi9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774495040; c=relaxed/simple;
	bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjdscAcP2J5a8alTGU5O68//A6pBQw1eGkZzwFUoEN1P1d5j82oiHtCExBtQZIi5f902rG0S5QsR5TXwVCXU4hwHjiKa6myQlpiTh8f0r5LY0RpM9TXj9Dvp7oHtKbWdz/T+YGkZF0dpBFOc8mxIni4xAIG+4gOzt/ZfanN0aeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JL2+CKQl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=drTwl0nY; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774495036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
	b=JL2+CKQlV1vQL0FG18MqmztmgmOBSQcyT5mznqThtQ+pwaZf/OhOfGXDPNwzw3Cfox05l9
	XObCNciuX8pTfjeZ6X68LtSeI47TRXJ9dBNkpLzr/3lXYwr+1tl4dMSYhJDwwrKbjtIRGI
	Z7Isq64LyAq1uASCy/S3YAd9kR4iiQY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-m7HXsCp9OueUCqTstvDomA-1; Wed, 25 Mar 2026 23:17:15 -0400
X-MC-Unique: m7HXsCp9OueUCqTstvDomA-1
X-Mimecast-MFC-AGG-ID: m7HXsCp9OueUCqTstvDomA_1774495034
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aec07e8aafso3601205ad.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774495034; cv=none;
        d=google.com; s=arc-20240605;
        b=esM8LT7/kSNpJgh8woSJk2E3AabBJjrpMIc20UTw+bh3mFZAm4auMK6Fp31rsDMGk0
         B0zAwPnHUihkRbIOSVWZkBZSwUokiFPUVbFeq8BGCEK6p6pDDQIcSQimLu+FaCV5qRuV
         iJ33AksYi3hzmrSvhtDPCdvQLkU+yy/zM0Qxa5lkJo2Q5/ogVpX8nrasMlbB1Uwg4XTS
         xDMxMNq5Bf+TY3/c3hO9MKk6oY2LcvO5115Eby/AyYD1wuL2iuBN5ro4/H6Jkqpf9/4y
         NMwIV/WXk1o1pGLBDOFtmCktLX6hcSjnPOLMiakGX3lJbIQSxFSM+/O3yXdlIR/BjZt/
         4aGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
        fh=WoD+VYUmgTCQHWrAGTcMNzltDyolXLk9A6iUOWx6nLY=;
        b=GI2R7nxlf+KP81HXOWwF3nagztKRut5UqH2c9LWYbBq9dSA2XJ8stHsGDQlQnLath0
         dXt50MPZD3LLQKSYI/ObTsgLL5evAGsUwpRPtrP+yuYcvGkurj2cnk+2wXDUTymxELuw
         DrngSSFEQrSE2+j1ZmK2ypLAzQxquj5rWj5BIP3ne990k1SaWci9V45PE3PQU4KKtqm0
         t4ii3D5rR9/u5lm5rXXseBFaPuPXHam9PylHwq93+k4P3mBBq4L5SLXDcdoOKKmYpAlS
         X2Knfiy+uoay2Xx+Vjjr13aCJvXNOOXGtXXAHiexYeU1sk9vJhmL1VC7VQueiQ6g3tKX
         Tjnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774495034; x=1775099834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
        b=drTwl0nY/Sg9TTmJm2Z/Q6h8WD9tprBQE+BqneWaLE1y64j5+CbVNcyM/1BR+thtYh
         QTpHovR8Iy1VjV7hrWF18abB38ejNNMFgwJlCFLjyj/ZACDgAAF17Gco2ZhL35Q1LDpW
         HzZVPlTGqVB48LCNFU+Ey0pie0gNmu0nDVkIHENPMDUiT4+3kNzRqUwfLX1QzKvdUp3z
         IXFV0hE8s7M5FQEog6qJY4HwTWnqkF015b5frV60B8ka/FLAcRfWL/GSFgnkufxINwXu
         U5w4CKtGUU/Mba9cgPgJ9RdM8SxbyA/sbPlLOLN2ZVucBtwVRQ/aoeQHdN5F2xHPvwCW
         K/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774495034; x=1775099834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEMu4a1EBiI1qS1w4fpDR/u6eaGVbAKl6V32/+r3aXo=;
        b=DxzmNUCWceI/CaAqEuFXwef5PX715YFaSqssP82/W0Bw7L0E6/K5Up+rexTUTX0G0/
         sAur5df4pyzVaYnsQfmU/EZ4nnN5ZrRHbEL6AVLWZcQxx3BIvX1e+zibeTeawlor59/C
         nTOPqpATYc24JHeKc+Jsm2becozi1W9KOlLmYQEb/eci8OgLN3OJCkVHHiI6OK/TyKQX
         iJ9j5ENiEd7Be6i0quNo9H5E5bWqhvUZzoZTJJ3Xsj6woCq8GXosNt/C6X9gz2OMEnL/
         4hWG1uG0h6/xr/WgTSF3hYqLoU+N4U6n5DILgx8pRRluVNzXD5f1UicPDAttz39sLd/V
         sYdw==
X-Forwarded-Encrypted: i=1; AJvYcCUsUExwy2sg/YS0H9fWh+bqV5WhWcnVN9pXzcXuV1HSMAjhBny8/iQcRPL99++YBWY2UWVxzwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSA07f9Ufl9qM2tFWyBbTU8SIOlOaG6/WqIBieE6fRoYqJpJQ
	xqutQ32WTw5Khpnouzr3V8YyRfvXaKICNDXBiCo5gduhg+t4c+vx2RTyvpqQtvuWs2cJLW5JweM
	KP6XfE9pz9ZaqZHBeNNM4pa3le8D6gdeXP0f3yVH9HXaHMTBdI2RJz+0V1QcbcqhupOkYaBz1Xf
	suvjId9akrpu2A3Ng/3a5RQhwDFYZqB1iP
X-Gm-Gg: ATEYQzx5Np/ciqPuIQFr7QSHp4IOvkN1fJpov62vPXZ4PI03xbvc7IT26R/7lxzBPec
	0qmGjQRnAWmRCiqMRMI91YOnQBtfnVG/iO0pVUhlytnuHozekglyA6Vk/CkvZ9gHIQf0JqZTYYu
	N8rjy/OOrbW86Lkiof6TWoCAqEwwOgyXXKflKKurC4UnY5+I9o2iFKH9jGED4aLLqn0RPM3RwMF
	8AY
X-Received: by 2002:a05:6a21:998a:b0:39b:f9f5:7a4a with SMTP id adf61e73a8af0-39c4ae08a84mr6464207637.50.1774495034095;
        Wed, 25 Mar 2026 20:17:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:998a:b0:39b:f9f5:7a4a with SMTP id
 adf61e73a8af0-39c4ae08a84mr6464185637.50.1774495033612; Wed, 25 Mar 2026
 20:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
In-Reply-To: <dd3984b3bce9df3591927f927668cb31cc7ecf34.1774460059.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 11:17:02 +0800
X-Gm-Features: AQROBzAarNEtZJEoyFy_DkMNrrDU5KBdW2pr9F5lbth0WTjJwR9jg3tFeGnbKuI
Message-ID: <CACGkMEuL613R8GRUX2hjRuJcvP0LNC_6_D1Y1yEjtTqehy6zJA@mail.gmail.com>
Subject: Re: [PATCH v2 net] ptr_ring: disable KCSAN warnings
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Schippers <simon.schippers@tu-dortmund.de>, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271816-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,tu-dortmund.de,gmail.com,lunn.ch,davemloft.net,kernel.org,redhat.com,networkplumber.org,nutanix.com,lists.linux.dev,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1435832EAE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 1:36=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> Eric Dumazet reported KCSAN warnings:
>
> BUG: KCSAN: data-race in pfifo_fast_dequeue / pfifo_fast_enqueue
>
> write to 0xffff88811d5ccc00 of 8 bytes by interrupt on cpu 0:
> __ptr_ring_zero_tail include/linux/ptr_ring.h:259 [inline]
> __ptr_ring_discard_one include/linux/ptr_ring.h:291 [inline]
> __ptr_ring_consume include/linux/ptr_ring.h:311 [inline]
> __skb_array_consume include/linux/skb_array.h:98 [inline]
> pfifo_fast_dequeue+0x770/0x8f0 net/sched/sch_generic.c:770
> dequeue_skb net/sched/sch_generic.c:297 [inline]
> qdisc_restart net/sched/sch_generic.c:402 [inline]
> __qdisc_run+0x189/0xc80 net/sched/sch_generic.c:420
> qdisc_run include/net/pkt_sched.h:120 [inline]
> net_tx_action+0x379/0x590 net/core/dev.c:5793
> handle_softirqs+0xb9/0x280 kernel/softirq.c:622
> do_softirq+0x45/0x60 kernel/softirq.c:523
> __local_bh_enable_ip+0x70/0x80 kernel/softirq.c:450
> local_bh_enable include/linux/bottom_half.h:33 [inline]
> bpf_test_run+0x2db/0x620 net/bpf/test_run.c:426
> bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
> bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
> __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
> __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
> __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
> x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:3=
22
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff88811d5ccc00 of 8 bytes by task 22632 on cpu 1:
> __ptr_ring_produce include/linux/ptr_ring.h:106 [inline]
> ptr_ring_produce include/linux/ptr_ring.h:129 [inline]
> skb_array_produce include/linux/skb_array.h:44 [inline]
> pfifo_fast_enqueue+0xd5/0x2c0 net/sched/sch_generic.c:741
> dev_qdisc_enqueue net/core/dev.c:4144 [inline]
> __dev_xmit_skb net/core/dev.c:4188 [inline]
> __dev_queue_xmit+0x6a4/0x1f20 net/core/dev.c:4795
> dev_queue_xmit include/linux/netdevice.h:3384 [inline]
> __bpf_tx_skb net/core/filter.c:2153 [inline]
> __bpf_redirect_common net/core/filter.c:2197 [inline]
> __bpf_redirect+0x862/0x990 net/core/filter.c:2204
> ____bpf_clone_redirect net/core/filter.c:2487 [inline]
> bpf_clone_redirect+0x20c/0x290 net/core/filter.c:2450
> bpf_prog_53f18857bc887b09+0x22/0x2a
> bpf_dispatcher_nop_func include/linux/bpf.h:1402 [inline]
> __bpf_prog_run include/linux/filter.h:723 [inline]
> bpf_prog_run include/linux/filter.h:730 [inline]
> bpf_test_run+0x29d/0x620 net/bpf/test_run.c:423
> bpf_prog_test_run_skb+0x9a4/0xef0 net/bpf/test_run.c:1159
> bpf_prog_test_run+0x204/0x340 kernel/bpf/syscall.c:4721
> __sys_bpf+0x52e/0x7e0 kernel/bpf/syscall.c:6246
> __do_sys_bpf kernel/bpf/syscall.c:6341 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:6339 [inline]
> __x64_sys_bpf+0x41/0x50 kernel/bpf/syscall.c:6339
> x64_sys_call+0x10cb/0x3020 arch/x86/include/generated/asm/syscalls_64.h:3=
22
> do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0xffff888104a93a00 -> 0x0000000000000000
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 22632 Comm: syz.0.4135 Tainted: G W syzkaller #0
> PREEMPT(full)
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/24/2026
>
> There is no race on ring accesses: reading/writing a partial pointer
> would be fine, because the reading is done by the producer
> which merely cares about NULL/non NULL.
> Document and disable the warnings using data_race().
>
> Tested-by: Opus Sonnet 4.6 1M window.
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


