Return-Path: <netdev+bounces-306900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ji2zN82rUmqGSAMAu9opvQ
	(envelope-from <netdev+bounces-306900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 22:47:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621EB742D90
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 22:47:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Sg5HR/LF";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306900-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306900-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1BBF30067BF
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 20:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2C307492;
	Sat, 11 Jul 2026 20:47:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D330F7FB
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 20:47:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783802827; cv=none; b=iooUUxL3Q2k+YV4Th1dcNlgSjJ8BIew8Q7IQBrdaJE5vRsfc1Xdiz5/ANSfS2n+TuHS1rWRgKjXRvLOkvVgoXEk2nvikXjFcablqd5r/Fvr1ec3Bq7QUZgnQb3AD8vM65dOb/sbJraM/Iv1ydru3PGgjvfMLmrr8DdbaJU/rQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783802827; c=relaxed/simple;
	bh=DPDyCEihiFM/u44UmNIjDt/nyBXG1bmV9KcLzfatXIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhvpsev7ZlL4oRS+b0aUEFPH+hIBwD6JH2bo71jVCqnmmWDaqtHEnzt+P9+iAee5MtqT52f0ScWK9r5P6YqQmZoS/jLXN+bACusolo2oByfccQYugeOknwHuhq8oym3gIQQKX/3k/2Bla01Tyn6x08ke7ZkgqFwhN3S3xAEN/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg5HR/LF; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47de008b020so967097f8f.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783802822; x=1784407622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AmoAV8UWF1T8XHPG609ZOYG8y3KrBiLQM4o1W4fAjFw=;
        b=Sg5HR/LF7CkmUmlqNI1QzZpwG80A9yvp+FPnrNgIbzgj32MMVZSNfePQS5Ugl10N8b
         312DbglvDX198chcY7QD2S+ZRzNZ29htbZADQ+R816KqNmXLVSZm0VRCta5vhz0c8lUb
         L0dMAF1vTvJzupoa6APkXzbPxlfy+tvVOrr3nkyoImth6FPWoVajOZSd565i5sZScNdf
         C/pS3d0cxbSWfC76/7aFmTYNPrUL2g/9/z9MY7LovksUoSpmv97W1Tr84IthgEIzTo56
         c+8y/yby95tw84tDgrCR0+9bPxOj5mgKYF9pxoAs8gi2x4HfJo1Ufo1B6Y2BHp4MVBR8
         RluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783802822; x=1784407622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AmoAV8UWF1T8XHPG609ZOYG8y3KrBiLQM4o1W4fAjFw=;
        b=HtKQUYMvSDtsXc6PEYDmOwrC+qYCqL6PBGkMoUmHDkuamFALVzTsSgpzhlUs9FocMh
         WYH1G+9YZmfQkYrqA65E9TaCv5zaVOEnUrMQPJu7ZHNkYF4t5OYLGs6tt/rmeNZaqowV
         VoYi/YrGYfXEOw6ik98TiZNm9bVNiRzg+cZrh7T6JKpz8WH3MrwZdhDLMWBCYvcfQThl
         x1JRsmyuPtCOt78A1mOPA+GtdPwrOASayi0nIHFuWkxiIQK8QHuWQQFIPWKoZT8iIezB
         g3KFMyjoYP3DP2nuxjYd1p3Lbk+xXA8gzJDw4YOfXwEOOYDmyqxJMGYlmrNvDJTfJLtm
         blpg==
X-Gm-Message-State: AOJu0Yzr//8st60iqUmcqa1Qlz9YU8s1z6XaELpdu+dLXxWrqTJqvskN
	tal7bmf2JGj3x2DmR000Cmd+PIH71TqVQtWJ3jai8QMzW3PclEJsENUhYLdG
X-Gm-Gg: AfdE7ckEH2ZWVQmgSdSFTXNISOep9Tg4/VbWu9ggM98aOZPMBemXgvLeQevctwZTeAm
	wMy8XoI3abu6TgwYtJMKvdFR0wC6RWNKllh1tl8kKkSt+yQqaEvxDaY5afYwvBroaI+6D8Ugg8p
	umwdB62EWaLUtwmzQQ3FEBJkKzvhJvtYbI7Yn+JvE65TsSFXqSMmnOGNR0mFvkXJQkbeQjc0Q54
	0iAcY23PC5L8f1ocSE8ig+iWGPLCJoGrFeTDteogycxPAyFtHuqxvn2J9Qtj13g0v8CQ9hedkM2
	ZSYq19XESve3zSeuztBMJUsK4areZ0siPTTFlGA7NdSY41WHbUrWDHFb6v1upkju8vBv7RHl8p1
	xy8y6Sdx6a5hIidZa5cicubcaU96yVPlWvcZZhViaWzakDqkStOdIkVQbbw==
X-Received: by 2002:a05:6000:4905:b0:474:bbbb:bf17 with SMTP id ffacd0b85a97d-47f2da2552fmr4147321f8f.0.1783802822129;
        Sat, 11 Jul 2026 13:47:02 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm69561366f8f.34.2026.07.11.13.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:47:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	maheshb@google.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net v2] net: reduce XMIT_RECURSION_LIMIT under KASAN
Date: Sat, 11 Jul 2026 20:47:00 +0000
Message-ID: <20260711204700.1760374-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260711134732.1385563-1-tristmd@gmail.com>
References: <20260711134732.1385563-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:maheshb@google.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306900-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 621EB742D90

From: Tristan Madani <tristan@talencesecurity.com>

Virtual network devices (ipvlan, macvlan, bonding) can enter legitimate
transmit recursion when combined with packet forwarding configurations
such as IPVS NAT.  The existing XMIT_RECURSION_LIMIT (8) in
__dev_queue_xmit() detects and breaks these loops, but the allowed
depth is too high for KASAN-instrumented kernels: each recursion level
consumes significantly more stack due to KASAN inline instrumentation,
and the cumulative usage overflows the kernel stack before the limit
fires.

On x86_64, CONFIG_KASAN doubles THREAD_SIZE from 16KB to 32KB
(KASAN_STACK_ORDER=1), but KASAN per-access checks inflate individual
function frames by roughly 2-3x.  For an ipvlan L3 + IPVS NAT routing
loop, objdump measurements on a non-KASAN kernel show ~1.4KB of stack
consumed per recursion level (across 17 functions from __dev_queue_xmit
through the full IP output path and back).  At KASAN ~2.3x inflation
factor that becomes ~3.3KB per level.  Nine levels -- reached before the
current limit fires -- total ~30KB plus the initial call chain, which
exceeds the 32KB KASAN stack.  The overflow hits the VMAP_STACK guard
page and causes a non-recoverable kernel panic (BUG: stack guard page
was hit).

On non-KASAN kernels the same loop is safely caught by the existing
limit: the "Dead loop on virtual device" message fires and the packet
is dropped without any stack overflow.

Reduce XMIT_RECURSION_LIMIT to 3 when CONFIG_KASAN is enabled.  This
keeps the recursion counter well within the 32KB KASAN stack budget
while preserving the established limit of 8 for production kernels.

The recursion path triggering this is:

  __dev_queue_xmit -> dev_hard_start_xmit -> ipvlan_start_xmit
  -> ipvlan_queue_xmit -> ipvlan_process_outbound -> ip_local_out
  -> nf_hook (IPVS) -> ip_vs_in_hook -> ip_vs_nat_xmit -> ip_output
  -> ip_finish_output2 -> neigh_resolve_output -> __dev_queue_xmit

Tested:
  - KASAN kernel (6.8.12 x86_64): panic before fix, "Dead loop"
    drop after fix.
  - Non-KASAN kernel (6.8.12 x86_64): "Dead loop" drop both before
    and after fix (no behavior change for production kernels).

Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2: Switch from per-driver recursion guard in ipvlan_core.c to reducing
    the global XMIT_RECURSION_LIMIT under CONFIG_KASAN, as suggested
    by Eric Dumazet.

 include/linux/netdevice.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9981d637f8b54..bdcb61d352afb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3640,7 +3640,11 @@ struct page_pool_bh {
 };
 DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
 
+#ifdef CONFIG_KASAN
+#define XMIT_RECURSION_LIMIT	3
+#else
 #define XMIT_RECURSION_LIMIT	8
+#endif
 
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
-- 
2.47.3


