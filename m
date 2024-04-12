Return-Path: <netdev+bounces-87247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032878A242D
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973AA1F22DB0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C9134B1;
	Fri, 12 Apr 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExrKKh7w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DD1429A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891246; cv=none; b=HfUw3BGYBIygMXWKJJnnxPCPTkfB80ZKzIuyZehK/BNpyxDe+r8gE3S9E4card1tsnicGQ1cXt65+u/yW/GizLb47OaOTUe6h8WpwCEwKd0TT68tw9RfxiIeE6lrSvKyaP3+GbIwUVVP4GCDxRZ1pWELy4uxTePg1qwaZvccBHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891246; c=relaxed/simple;
	bh=jScZ5912t2Qs0kslZzy4LrPs3EcJy0WUf9gUbHLO3bM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QBgLlnzSR+eys60g3MMl2kQxIdiLmsfyJlCG5xQW63mG8nXFvSS+y9ToYG5kJ6OZEymOHAiQlnK9i+bolkFLCojWBYjZatnPpzxPWYtHyQWA+35YasKxulJIIjeza2Wqzm35EBL0i1GpPpJodmGj/tiPXBrXS+Au0WQgTRNxFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExrKKh7w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ee0642f718so676931b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 20:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712891245; x=1713496045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0lE8JZkoAX1VaptJx9l9YwOtaEzL18K2NGhiHt34HcU=;
        b=ExrKKh7wf8BGFFUNgszBcPyG+CIgtn0crnSygUddRHi6FjlAtkHuOVvmtXXyI431by
         m1lqpigZe7LU+zUzKSisofRlZ7cUj8EVMr9lFAAmiDJDWOMbjomNNihOJr4ILnnh0+BO
         23ZoJIsY1E7wzruUewAa03KOsEUwZ496fFtdMvmqwOk+2cDkzXd4U5DiKwFlj0mQC3DY
         5wSXBJ64ldLeCcwebiXpZR9CsTEVH8CmvPgdLfBLduqR3uOcUC1hMQPPeazNDsA14ygf
         rWRbP/kWmF+LIsK6LJJx8t0/eYh2Ujf/i1Zau4wUmsKg2Df6cGvFSCsqUqV9KpCjOlP2
         za5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712891245; x=1713496045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lE8JZkoAX1VaptJx9l9YwOtaEzL18K2NGhiHt34HcU=;
        b=E/sLod2+9/zHtIy52YAnDiDnFJaMhXRL51NX/7ZjeuBEdwySEOFxtJ66o368tVr8zE
         jkyFaWeROl3I7AiYz8AqVYQrYZ/hap+ZP1ClmgsHKTayrCrADvZtJm13cO940sYVT7Ql
         sqn0Ew8q2EwuG0itqS4Ws90dz2FP3OPsnE/w+eyUS0eNdBz/nBd5sWdzOhLB5T0pkLiQ
         BkVB9M9ZaaTIMe+tB3ENo75NaEydzTfUJMKIAU6S4NPb2iG66Gcvfi0ir9unEmRkY3ww
         mhHoigPiiWp03e47aYQz1ZEGsxiYddhcG793nLhcwIoTaO49AZjO0ZjoKcNXSSh8v2KP
         OBSA==
X-Gm-Message-State: AOJu0Yxl4itaYHv5QDDG1ZhjTYP4HiKFl+H/TldMXMmSkiQwWwdRf6bN
	q6Q1t/QoGzokbYy3kvDxcCLs4fd8Zzb8jwTiuDOBZqhVAJV02HXM
X-Google-Smtp-Source: AGHT+IEQD8q+luWkyb3TUjmj84OMw2MurwN6+l6UMEFq9XfE+e1Bdr5g1JB1uFEEfSnpMKQcnLR4kA==
X-Received: by 2002:a17:902:e746:b0:1e5:5760:a6c1 with SMTP id p6-20020a170902e74600b001e55760a6c1mr2233065plf.21.1712891244677;
        Thu, 11 Apr 2024 20:07:24 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709026e1600b001e2ba8605dfsm339824plk.150.2024.04.11.20.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 20:07:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	pablo@netfilter.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] net: save some cycles when doing skb_attempt_defer_free()
Date: Fri, 12 Apr 2024 11:07:18 +0800
Message-Id: <20240412030718.68016-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Normally, we don't face these two exceptions very often meanwhile
we have some chance to meet the condition where the current cpu id
is the same as skb->alloc_cpu.

One simple test that can help us see the frequency of this statement
'cpu == raw_smp_processor_id()':
1. running iperf -s and iperf -c [ip] -P [MAX CPU]
2. using BPF to capture skb_attempt_defer_free()

I can see around 4% chance that happens to satisfy the statement.
So moving this statement at the beginning can save some cycles in
most cases.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2
Link: https://lore.kernel.org/all/20240411032450.51649-1-kerneljasonxing@gmail.com/
1. Fix the wrong order of testing cpu (Eric)
---
 net/core/skbuff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab970ded8a7b..6dc577a3ea6a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	unsigned int defer_max;
 	bool kick;
 
-	if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
-	    !cpu_online(cpu) ||
-	    cpu == raw_smp_processor_id()) {
+	if (cpu == raw_smp_processor_id() ||
+	    WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
+	    !cpu_online(cpu)) {
 nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
-- 
2.37.3


