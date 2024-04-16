Return-Path: <netdev+bounces-88210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED228A6551
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649AE1C21DD3
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC084D3C;
	Tue, 16 Apr 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iocl2XLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CF386
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253380; cv=none; b=advcsAHjH0LAbMfqz6z5kOr+r1V+p92O4D5PsKz0GhCbSm51FYP3760beQBc8xveUOqbbBRBNHQlEPPtHRSlNPfrVIlwg6BPSnao85s5RVUmLTvciboE4gw+Hjc1R2SAbPCq2FKylUdU6BsRaapmGdBnUWrmy3gPPPFzpYA/ix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253380; c=relaxed/simple;
	bh=+KiaQPhhNId/j17RJ5WzPNy3XIrPK+vq2e8iry+j9Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWDhnJIUL2IiED4siMO8VW4TOU0BPTcHdfocu1UJQIPSpt9fEaMydxXKYJzSmFvZHXtqALcpYmToPIjvLHjQy1jZQXfCHQT7shVJaFqxAYVOMb3DFAIrGCtlFYO1akYCIlqPQop+aEPcoJJYmEmjTz+LYtzECur5TOba1iXMnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iocl2XLA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e220e40998so26204785ad.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253379; x=1713858179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZosKZuOLgAT2ovMTpFweL1hNrHDeyLIvW/nqMPw+0A=;
        b=iocl2XLAvWOrbTe9bzWOSYOL+w3OBsZQnObO0f096U/MlHPXcXzSKuFQU54W1NULTX
         yGQCVvPe0yqBWwBqu3pAu/qjA4gSvyuvhIsnid5VfO/bTmWcHQ5HMmLjHRIGTWB99goK
         ye35dyVO6aW70s0JP1hin6WDXXJrKUBiLSV1s1aSGUt46zCh0UNTW0feA4PmILFYFvP8
         6YIFJXwIRyAnbLO4pQPo9t8WzmHl4/lnNG4a36QHJlwAEeRnZjOAtIl3SYqWiyFt2Ghl
         NP/oXdyLgR2Xaj9xiwfpv7xdsG8ivojIeiC0YsY5z7UAZjFxsb5fpIDB8LcNFuYOrb+G
         OAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253379; x=1713858179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZosKZuOLgAT2ovMTpFweL1hNrHDeyLIvW/nqMPw+0A=;
        b=Nqd9+UNCM0gGdpedTYB107nM7IUAWjRU0s9lW9Leo70UeGp02loZqfUXVAnwekoWUe
         RT+Z0mgZ0x4Gq6INW5p7yQrXvtBMdaBBqX8/kHm0OgqJ1Dqh6w9wQ4zYk6fGjoG4ySLI
         46ONAvDVpZQT8cYZoZGcI+/l4m3QdKi/w5LTP8Uh+iKp/hqmsg6h7hscEy7xSpOmPUsd
         chCI2t1L+VEtt8Xgj975lQnRGRHyYY6wnt3gCsFxGjjL7kbIlVIBjfpebqfwd4AwVIEd
         LiGRX+pF7Nnz1OnAGIghYQnCNAAV7MskaoX1//0S63bJEo8CrCL08Xvjj21dNsHN7vWk
         G7aQ==
X-Gm-Message-State: AOJu0YyNg+69OEgPq8Ubfs4DiDRU4Ty9f07taPJ3F0F3rif4s1jIGoIw
	vyI/UvKf7ZVA954UlUyXLcaIjRaqtS94efVMRtJVUFc6rq+ZZvMj
X-Google-Smtp-Source: AGHT+IHCPHTboGti0enEZwboHZyMvx5bMbgE9zxAsAYRxRME5fkXZFMzUhhf9kLL6QkbJqUdVly98w==
X-Received: by 2002:a17:902:f68f:b0:1e2:a449:da15 with SMTP id l15-20020a170902f68f00b001e2a449da15mr13847892plg.15.1713253378585;
        Tue, 16 Apr 2024 00:42:58 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b001e4881fbec8sm9126947plh.36.2024.04.16.00.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:42:57 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/3] net: rps: protect last_qtail with rps_input_queue_tail_save() helper
Date: Tue, 16 Apr 2024 15:42:30 +0800
Message-Id: <20240416074232.23525-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416074232.23525-1-kerneljasonxing@gmail.com>
References: <20240416074232.23525-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only one left place should be proctected locklessly. This patch made it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d8..cd97eeae8218 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4501,7 +4501,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		struct netdev_rx_queue *rxqueue;
 		struct rps_dev_flow_table *flow_table;
 		struct rps_dev_flow *old_rflow;
-		u32 flow_id;
+		u32 flow_id, head;
 		u16 rxq_index;
 		int rc;
 
@@ -4529,8 +4529,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 			old_rflow->filter = RPS_NO_FILTER;
 	out:
 #endif
-		rflow->last_qtail =
-			READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
+		head = READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
+		rps_input_queue_tail_save(rflow->last_qtail, head);
 	}
 
 	rflow->cpu = next_cpu;
-- 
2.37.3


