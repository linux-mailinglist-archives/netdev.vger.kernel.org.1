Return-Path: <netdev+bounces-127897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52615976F6A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F3D281944
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0E1BE25C;
	Thu, 12 Sep 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="EyG6xjGL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9F49654
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161299; cv=none; b=s7qAh4kHTiTMBcpRruMSXaJ89px2HPUKkTIsb319xx8J3g4co9olcjSL9KdRaERXdCYkkvRJtMLzUDiVSlvundMJLglb/7Q1LyE0Am/zQdI88RC0JQdQCTLr8U+xSpVb0Tki8ktDuamV5xtbuXoQFHdGlsyQWQq3mkquIJ2t3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161299; c=relaxed/simple;
	bh=X/8dSa6Si8j86RcrAC3yTRSUMQ2+9mgrF5IHUg1rLMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q34rqOvgzNyLEQAj10OiqUdbcJpVMyNI3npuHM9WxedKFhM37vshrwUzCGGYZlbXG8tXQm0v6g2u4xrMRaf+UUzN9c+rQEbTqYFZKqoT2Gd5/BL1lss0AMEWqSJ0RFl40lG2+bDVTT5f9EQn77LDeNMaKcsnHi1rvTthFxBJJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=EyG6xjGL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718d91eef2eso804925b3a.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726161296; x=1726766096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kYk0hVyvaX7KwaimyLasjhw8gwXmSfmWWg+9dvi0cA=;
        b=EyG6xjGLUllGSHKJJSiMpQoCu4QNyg9/AZkmvaWlTwCFRWP7tzRp0E0vBOgvJRv5IW
         pPokfxkYuCbwXHRLI8SlAkxiG8njz1SG7bhMbZg2a6pF+ITkRWXXScPR1hsG4Q3t85OB
         /TczDbfULq13haXbGYcMlAJnVtVkYfe9OYXM3ccJAsex3TqsPz0h+Bm7C4DGEXSyJ3KS
         ItI68wie+W5RIWhinGmYK9AITRTzmYTsa54KFHElksnGoK8/k6IxTvRF+uRtADIHaP1M
         b/8kHsDRIFp0X1gqxkMe9jQSEv83KToEin1MMpfRS0k46LDPjYL2BB4/A/jrt4P+wJBG
         LY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161296; x=1726766096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kYk0hVyvaX7KwaimyLasjhw8gwXmSfmWWg+9dvi0cA=;
        b=Zvq6IzYUb3lvkgpoMbFLZeO62LUoXuUgh5UEZOYYWer3EgPFvOmxlJJpyk3+NUqFpE
         3H7npOksGL4LEkBtvwc9KqFqdPrh15xylkZbrYHJG3EKb7tZcVZIcOG/YZSS0xEu2/3l
         e49G9L8dfeO1+T1OT9Cf+svwLX9NIK9O8o5Fp/IUb+lhyi4tLKUSSRKcTbxt4xKEjGK6
         aYhy6OstnqyYKYTspJdkqTfsThsSjH/tofQ0cgz0XMbHGmwHloAPXmnAtSGnKd+QaR0t
         hddkMMNGGx6CO7RPkTYzBbo1PZhOncYE66uBMuKk+mUbIa8RyUZizgFN2gjP3kjbbPIq
         HS+w==
X-Gm-Message-State: AOJu0YwZgqJkZw42QE5aJLqKpSpjAIyRNtaACKFq+hRVrYPZLgsuH2rK
	wINWCjmO5mSVCBxu/pMfMtG448cyLgHgyZsJn54vUGCkystTBnYEfbOn9hqwkrAXbZvWs5yASEU
	r
X-Google-Smtp-Source: AGHT+IFeFzfepH3xVTtICzvejNXFvWYIR6ONEGgBHgtKTw+66Mh3xriLj9BjVGy10yoX2ZCqjWq6oQ==
X-Received: by 2002:a05:6a00:6f4d:b0:718:eeab:97ca with SMTP id d2e1a72fcca58-71907d98483mr18499227b3a.2.1726161296145;
        Thu, 12 Sep 2024 10:14:56 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddc6f9sm1731375a12.70.2024.09.12.10.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:14:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] replace use of term 'Sanity check'
Date: Thu, 12 Sep 2024 10:14:20 -0700
Message-ID: <20240912171446.12854-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The term "sanity check" is on the Tier2 word list (should replace).
See https://inclusivenaming.org/word-lists/tier-2/sanity-check/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/arpd.c | 3 +--
 tipc/node.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index 3185620f..e77ef539 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -494,8 +494,7 @@ static void get_arp_pkt(void)
 	if (ifnum && !handle_if(sll.sll_ifindex))
 		return;
 
-	/* Sanity checks */
-
+	/* Validate packet */
 	if (n < sizeof(*a) ||
 	    (a->ar_op != htons(ARPOP_REQUEST) &&
 	     a->ar_op != htons(ARPOP_REPLY)) ||
diff --git a/tipc/node.c b/tipc/node.c
index e645d374..b84a3fa1 100644
--- a/tipc/node.c
+++ b/tipc/node.c
@@ -252,7 +252,7 @@ get_ops:
 	/* Get master key indication */
 	opt_master = get_opt(opts, "master");
 
-	/* Sanity check if wrong option */
+	/* Validate node key */
 	if (opt_nodeid && opt_master) {
 		fprintf(stderr, "error, per-node key cannot be master\n");
 		return -EINVAL;
-- 
2.45.2


