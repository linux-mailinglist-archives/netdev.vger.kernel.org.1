Return-Path: <netdev+bounces-271021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG68Em2FwmkAegQAu9opvQ
	(envelope-from <netdev+bounces-271021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:37:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35903308626
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38FBF3002D13
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF2F3D47B3;
	Tue, 24 Mar 2026 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+LQz+V2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5E2D63F8
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355253; cv=none; b=FZB/KBB+SuiUhg23aRJBy3+PGJtq+asNshEpIm+ZpHlGxkFqiLWLAs9yLdFV+qlptKatmYJoH43ZzBzImlKhVUOophZopxH89zqek2WR9Pv+4QaXz0NSyj2iasjorAMecYp02wKJ0amOqt7P++NvBvKpT2tVF2DAU2KVbStJg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355253; c=relaxed/simple;
	bh=2hwBaiTYWPgPdvYP/SDJeV1QwJS7IHBoFcHIsCNSe3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAOY28QyC3aSzPzJdtbf91mNKz7WLRpJiqBz6qslvV4EQZbbEwaILKzBAXzjwwjjuxIfKE1rR89ZsBSOfkwoHdyoiLHGt+anRBbQDHApBRndUr7w20BXJF8Z1Vz+HcytSdkEYxW+nGncJBfnXMshAGNoqNqspoqZSxm1K0MYvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+LQz+V2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82a67ce6969so886633b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355252; x=1774960052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwSnjFcjq1oUFhDGo0eVz8ywdnnal2i+ieo63wHrZYg=;
        b=g+LQz+V2qNOpDJuAPTHj1o2Yz3j29juTS1l3w829Ryt72+ExBfBiog4isQlFKkQfPp
         ymMffKKK1WURJSmrdMscXarjjIYU8+GAVDwzt+ACJqF1VbRJjzlaq+J1Uyaktj0zevBQ
         s5fVZig+27VAB44vebHbgdX2/K+wU9uW0a0VbZEHiAHz9qNwM3RUJ9+l7VYS1+nXsW34
         NvzKWR1VNg6v0KG/xuBd0sCQD8nUur2hGz6cSbAhiqwVFJLUSL1uMqwSodpMgMXYNCLq
         nZfYDzuyR6P5zD+V42t9Zba3N7QxzUhHO1RMuMgWqGH5Vg8SBGcDSqRQLhjzNoCjSFQn
         B6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355252; x=1774960052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwSnjFcjq1oUFhDGo0eVz8ywdnnal2i+ieo63wHrZYg=;
        b=GGfHwGWJ3VfeP+AlTDP82gAsf0Lw69EmUczqDKSXWD3oZwyM4CbZ8lmlePQA4WwSKH
         zL2Z6dzzE9WwHRTZMUL7t43CXZm1DqKwrUF1TBqxUSUs+GUweKUAa/7NoC07vmA5DLjo
         B3mG8LxDDyfl8gvFwswZ7WPZ0dJGfMv31ozBLZDVgjfBnpXnVy27i51SgI9wrfQC6YNu
         TRSUGR170EbklZVlqH0A+3L8r4OuZG+nyYcC5IkhR8+WAAdjUg1itx02bVTKLym6RcKI
         zcyQXWo1+XJ1Fq+urDqHSf1042pa/EdUO8Sb6fmxSQXLyiVjLlkj9WIOA6QIQnPbVqO8
         UQvA==
X-Forwarded-Encrypted: i=1; AJvYcCW/GWwo0W+iNvkQGVUnUjm9AYKiheICAOeEFMsUFJt4juCw0OAd7cdR+ZOed8cnXpdLi82Gulg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMExjX01bZRp6ChMoiYdg9D9ecmCQzGHf5Cwnj58ic1h3iKW76
	uJTxU5dvCNAh71qU9Qg1zZYe1K21F1HDrY6algvF7TzhXV7CZNekwQnl
X-Gm-Gg: ATEYQzxxSCC3n6TwgHwi9WT8ntOWnKTn8j0bu0VzNMaQRheUtKULrZl9cic57qQ3OZv
	Pt01Z9KVgJZfuI15DK8hKK4uv+TLqd727mmc3FlZqCdGYYbPTLPPUJwIyYN5CFlVD+LBEWSBxt1
	rhoHF8B6g1GiDt6rHV1XVYTbJ2Z/PDcatVUedzIslz9m4QrjAID/espGttO+KvuCCGKrSCn2jh1
	eUBKqpDsPZJ7BhruJZLz3wktDiQucnPcUm/NoWj6dr9qa0dO5nin7BLlYWEiw8t8aXNu8LbFQVq
	kSbzhwXlwkYayvapiHaJ/YdW65UVo08sB3Qa5euPHdBBXuZJqLJZDkKF+6lAghEUncYbUgy0Oee
	1hFq8CCGMmYo4cFK3XACvs1qwdfySVT7l8J8wA5VyuGMan7X6v3ERdlddB3NgI/Bt0hm/LAucaL
	ndaw67gLZ/djzOiCw563OdQAK+II9wkNphe7e85LQxQ0BV7bmlWPeA2Q==
X-Received: by 2002:a05:6a00:6c8d:b0:82a:7f28:c79b with SMTP id d2e1a72fcca58-82a8c2ef7bfmr13798915b3a.31.1774355252204;
        Tue, 24 Mar 2026 05:27:32 -0700 (PDT)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f409sm12224583b3a.31.2026.03.24.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:27:31 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: arc@lists.infradead.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	"haoyu . lu" <hechushiguitu666@gmail.com>
Subject: [PATCH] arch/arc: bpf_jit: fix missing newline in pr_err messages
Date: Tue, 24 Mar 2026 20:27:02 +0800
Message-ID: <20260324122703.641-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-271021-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hechushiguitu666@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,haoyu.lu:url]
X-Rspamd-Queue-Id: 35903308626
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: haoyu.lu <hechushiguitu666@gmail.com>

Add missing newline to pr_err messages in arch/arc/net/bpf_jit_arcv2.c.

Fixes: f122668ddcce ("ARC: Add eBPF JIT support")
Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
 arch/arc/net/bpf_jit_arcv2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
index 6d989b6d88c6..7ee50aeae5a4 100644
--- a/arch/arc/net/bpf_jit_arcv2.c
+++ b/arch/arc/net/bpf_jit_arcv2.c
@@ -2427,7 +2427,7 @@ u8 arc_prologue(u8 *buf, u32 usage, u16 frame_size)

 #ifdef ARC_BPF_JIT_DEBUG
 	if ((usage & BIT(ARC_R_FP)) && frame_size == 0) {
-		pr_err("FP is being saved while there is no frame.");
+		pr_err("FP is being saved while there is no frame.\n");
 		BUG();
 	}
 #endif
@@ -2454,7 +2454,7 @@ u8 arc_epilogue(u8 *buf, u32 usage, u16 frame_size)

 #ifdef ARC_BPF_JIT_DEBUG
 	if ((usage & BIT(ARC_R_FP)) && frame_size == 0) {
-		pr_err("FP is being saved while there is no frame.");
+		pr_err("FP is being saved while there is no frame.\n");
 		BUG();
 	}
 #endif
@@ -2868,7 +2868,7 @@ u8 gen_jmp_64(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
 		break;
 	default:
 #ifdef ARC_BPF_JIT_DEBUG
-		pr_err("64-bit jump condition is not known.");
+		pr_err("64-bit jump condition is not known.\n");
 		BUG();
 #endif
 	}
@@ -2948,7 +2948,7 @@ u8 gen_jmp_32(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
 	 */
 	if (cond >= ARC_CC_LAST) {
 #ifdef ARC_BPF_JIT_DEBUG
-		pr_err("32-bit jump condition is not known.");
+		pr_err("32-bit jump condition is not known.\n");
 		BUG();
 #endif
 		return 0;
--
2.53.0.windows.1

