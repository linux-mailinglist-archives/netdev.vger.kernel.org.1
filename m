Return-Path: <netdev+bounces-206455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA1B03310
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E42B18942C6
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC061E7C23;
	Sun, 13 Jul 2025 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0RCDfFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDC29CE1
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442299; cv=none; b=BgCA7SbNpWF7ooBOOuk5l2FpsHmgcjt3V0P4Vzbhrfea0J9sNT6RPcMT/hjA+YkFP59MP9DhZYsvz2U+3VTWMTYOyjWXHIpDUZQFJxHIdodFiid1F8XI/Fx5nQGE/oxL6t1DKjjOSaTnj/m0lnAI1FARJTDZ6ZCSOgpNEr2yfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442299; c=relaxed/simple;
	bh=st4oveWOmX4V7s935If4MTzf9khDZlAq5igZSQTYmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WimnEXM+kxaRG4m7/hylHRY54NABg4vFkvs64HtgQMvfJlMQtTPqGHkPNZba4njBFwvjg+grrc9yqSue//jr3Mf5FGW0zk8PbDNgd9Qz0gYKJXec0ynMtcIf2O8VWIIfEjvvDujBBbx/cmxXOD0Nyu2mmDQVLwCxMpGFCUOTM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0RCDfFq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74924255af4so3057068b3a.1
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752442297; x=1753047097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIwkxZdMO/HA3mkyHrh9qwZasR4mA+8mnZjoVhZ5GXU=;
        b=k0RCDfFqJIlbc2AZh/3HRdEjTYmodZv3+maOk1kPmH1HaDS6bDzjHkAuDdMtdK98Xk
         ySampypzab3qPI1BpG0KyYUXrkOUuX0DqNMxR/QfKDigFSrBkELVfnlXXjC3gfx+KEl5
         LPxb5YErkpmQeFerRrgrYIsGCrj7ihwiQIloQU7n4rBV+DDHeq8NdHNW8SsAJ8gDIhQ1
         yBggWqWdnAfN93X1n5aMwxuhqEpvvOgiW3cQcbsiYjktKIP50M3funjD33chlgbCWDNC
         fq5vftpYA4vC761xGBCoszk/5ldQglTw//rItfR08PaYQAmQooQ3n42tDBs7bXhCdP+0
         g3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752442297; x=1753047097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIwkxZdMO/HA3mkyHrh9qwZasR4mA+8mnZjoVhZ5GXU=;
        b=pz7DAlnXxuKiF9I1FDpUy51dNxtGE3LBSyHGVepJ8YGrHPuHBNOUYlOhIWl7l/9r2R
         rFBhrddWIi3AwF1KozApDKns0+aGsHOKNmF4RQ7Ri9Tta9OlHlC8Zo0gjsP+O4fWm6eD
         cFI7PrCHTse3a/GoTC3z217Xo6njZVMRULz6YLvjvOZkBvRrEKlSo9tboQ98J4PLI2LT
         g31ybpeDmUrAZZdGllBOh5cq0OvgBs8mAircegPtqjqBAAyvYmPFN+IDU8sUcXG8hsIy
         f1k0YPBPwmCDRZ8jUUJvtUUkPIXcuEQw7fntS2GdjtjKKoivR1wSjpSkUqaUvsqCWCSn
         1goA==
X-Gm-Message-State: AOJu0YzZ86bPxmN6bEGx2glFaqcaSzrs/IZJUg+7rOwlhFRojZbmqVU+
	XoHggQSiloPJkwkQqPIscPcraHw+GHadyQTkkFUQW5eO8Buo4RZmMxIM8G1rDA==
X-Gm-Gg: ASbGncuti1qf0FHKlEzLy4STMiHB1F/IQhRro5cp+4vjKwZyvaoUP2nEcaOd61O+vk8
	jKEcpPYCtBqfEzlvuRkegJHly9fhd6x6lVz+2gnE1jLG2dBc+3qgbxF5raijX8mBvNg1V2IwMan
	ZiTHAiITO2BJtT/HMf+scjC5yT1RGaxnjffILrxyu54Kvzu0EPt5MeADBf3Q3q5aZGQiMmQvn8u
	Emo0QDVgndhjyaeZyNS5aiqUsL6lo7HE7AGmnVFHX1/W9JlyqA5gmIc6zp0eT9y9UK1fSYrbXhN
	prXyi97tM4rA81gkHioID/mQCdwZ7Ry1hnrj+Dz3Rkw4rEvNeuFEb+m4TY3xyrLyFKUPgXc4cmu
	zBxNqRFqycSdzBpIWiZ/IRkPWa1qVBe09livSZm4=
X-Google-Smtp-Source: AGHT+IGcqBrWcQQ2m2aYDI4kO4rABv7QOjkOArdlO3csan4qkTbljFEaEia6otzV51b2XY+uxP8aUw==
X-Received: by 2002:aa7:88d5:0:b0:748:f365:bedd with SMTP id d2e1a72fcca58-74ee2955a68mr12328741b3a.17.1752442296552;
        Sun, 13 Jul 2025 14:31:36 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:b9d2:1ae4:8a66:82b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d328sm9502918b3a.94.2025.07.13.14.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:31:35 -0700 (PDT)
Date: Sun, 13 Jul 2025 14:31:34 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHQltvH5c6+z7DpF@pop-os.localdomain>
References: <20250710100942.1274194-1-xmei5@asu.edu>
 <aHAwoPHQQJvxSiNB@pop-os.localdomain>
 <aHBA6kAmizjIL1B5@xps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHBA6kAmizjIL1B5@xps>

Hi Xiang,

It looks like your patch caused the following NULL-ptr-deref. I
triggered it when running command `./tdc.py -f tc-tests/infra/qdiscs.json`

Could you take a look? I don't have much time now, since I am still
finalizing my netem duplicate patches.

Thanks!

------------------------------------>

Test 5e6d: Test QFQ's enqueue reentrant behaviour with netem
[ 1066.410119] ==================================================================
[ 1066.411114] BUG: KASAN: null-ptr-deref in qfq_dequeue+0x1e4/0x5a1
[ 1066.412305] Read of size 8 at addr 0000000000000048 by task ping/945
[ 1066.413136]
[ 1066.413426] CPU: 0 UID: 0 PID: 945 Comm: ping Tainted: G        W           6.16.0-rc5+ #542 PREEMPT(voluntary)
[ 1066.413459] Tainted: [W]=WARN
[ 1066.413468] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
[ 1066.413476] Call Trace:
[ 1066.413499]  <TASK>
[ 1066.413502]  dump_stack_lvl+0x65/0x90
[ 1066.413502]  kasan_report+0x85/0xab
[ 1066.413502]  ? qfq_dequeue+0x1e4/0x5a1
[ 1066.413502]  qfq_dequeue+0x1e4/0x5a1
[ 1066.413502]  ? __pfx_qfq_dequeue+0x10/0x10
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? lock_acquired+0xde/0x10b
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? sch_direct_xmit+0x1a7/0x390
[ 1066.413502]  ? __pfx_sch_direct_xmit+0x10/0x10
[ 1066.413502]  dequeue_skb+0x411/0x7a8
[ 1066.413502]  __qdisc_run+0x94/0x193
[ 1066.413502]  ? __pfx___qdisc_run+0x10/0x10
[ 1066.413502]  ? find_held_lock+0x2b/0x71
[ 1066.413502]  ? __dev_xmit_skb+0x27c/0x45e
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? rcu_is_watching+0x1c/0x3c
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? dev_qdisc_enqueue+0x117/0x14c
[ 1066.413502]  __dev_xmit_skb+0x3b9/0x45e
[ 1066.413502]  ? __pfx___dev_xmit_skb+0x10/0x10
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? __pfx_rcu_read_lock_bh_held+0x10/0x10
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  __dev_queue_xmit+0xa14/0xbe2
[ 1066.413502]  ? look_up_lock_class+0xb0/0x10d
[ 1066.413502]  ? __pfx___dev_queue_xmit+0x10/0x10
[ 1066.413502]  ? validate_chain+0x4b/0x261
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? __lock_acquire+0x71d/0x7b1
[ 1066.413502]  ? neigh_resolve_output+0x13b/0x1d7
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? lock_acquire.part.0+0xb0/0x1c6
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? find_held_lock+0x2b/0x71
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? local_clock_noinstr+0x32/0x9c
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? mark_lock+0x6d/0x14d
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? __asan_memcpy+0x38/0x59
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? eth_header+0x92/0xd1
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? neigh_resolve_output+0x188/0x1d7
[ 1066.413502]  ip_finish_output2+0x58b/0x5c3
[ 1066.413502]  ip_send_skb+0x25/0x5f
[ 1066.413502]  raw_sendmsg+0x9dc/0xb60
[ 1066.413502]  ? __pfx_raw_sendmsg+0x10/0x10
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? stack_trace_save+0x8b/0xbb
[ 1066.413502]  ? kasan_save_stack+0x1c/0x38
[ 1066.413502]  ? kasan_record_aux_stack+0x87/0x91
[ 1066.413502]  ? __might_fault+0x72/0xbe
[ 1066.413502]  ? __ww_mutex_die.part.0+0xe/0x88
[ 1066.413502]  ? __might_fault+0x72/0xbe
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? find_held_lock+0x2b/0x71
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? local_clock_noinstr+0x32/0x9c
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? __lock_release.isra.0+0xdb/0x197
[ 1066.413502]  ? __might_fault+0x72/0xbe
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? inet_send_prepare+0x18/0x5d
[ 1066.413502]  sock_sendmsg_nosec+0x82/0xe2
[ 1066.413502]  __sys_sendto+0x175/0x1cc
[ 1066.413502]  ? __pfx___sys_sendto+0x10/0x10
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? __might_fault+0x72/0xbe
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? local_clock_noinstr+0x32/0x9c
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? __lock_release.isra.0+0xdb/0x197
[ 1066.413502]  ? __might_fault+0x72/0xbe
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? lock_release+0xde/0x10b
[ 1066.413502]  ? srso_return_thunk+0x5/0x5f
[ 1066.413502]  ? __do_sys_gettimeofday+0xb3/0x112
[ 1066.413502]  __x64_sys_sendto+0x76/0x86
[ 1066.413502]  do_syscall_64+0x94/0x209
[ 1066.413502]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1066.413502] RIP: 0033:0x7fb9f917ce27
[ 1066.413502] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 45 85 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
[ 1066.413502] RSP: 002b:00007ffeb9932798 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[ 1066.413502] RAX: ffffffffffffffda RBX: 000056476e3550a0 RCX: 00007fb9f917ce27
[ 1066.413502] RDX: 0000000000000040 RSI: 000056476ea11320 RDI: 0000000000000003
[ 1066.413502] RBP: 00007ffeb99327e0 R08: 000056476e357320 R09: 0000000000000010
[ 1066.413502] R10: 0000000000000000 R11: 0000000000000202 R12: 000056476ea11320
[ 1066.413502] R13: 0000000000000040 R14: 00007ffeb9933e98 R15: 00007ffeb9933e98
[ 1066.413502]  </TASK>
[ 1066.413502] ==================================================================


