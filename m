Return-Path: <netdev+bounces-89035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068D48A942B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F3F283D37
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783774BE5;
	Thu, 18 Apr 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4MHI2bw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7656462
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425779; cv=none; b=DOpPKt8RGWGm+WUnEJD3V5byWiUNNoEz/+0P46KEUX9ownngQjbcvKdfAIuhbSvR93WnVwSGTHPLqh2psRPhAv3QyH2FwHlx0uXxc9OTQ9jMd43zAV6nGcpE9POKqsGEe9qxhgtzlG4OK1O4e+Hxm8x+DG8Rtko63WTqIRhcCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425779; c=relaxed/simple;
	bh=FEFmTqiSFB0xi75Lvv3A7nJ4J3W1Xw4/8ttAG32oOdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZkp7CDCz7azfD/MffvQ035GOCylCBFdhs3aE1HUKStEdAG6GJ08oYF1yoLonhb/7nzu2RKwpB+mtquO/LZW1oY1G5eiEIw7VmJEE4nY0096A7l2KEJUrE92yvSXxh76bkxTC/sIvInGU2eyEas5+D/nfSZ9TtEA98iEOnQVXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4MHI2bw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e65b29f703so4892105ad.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713425778; x=1714030578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBehbCdCyWW8txnp4pZNDxM/Mx+V9ByxE1Nv3M+HJek=;
        b=D4MHI2bw07X5vJntF4UdNgQLWEhdjsdanOlDUaJ4zbbJg9T13Gf5eu+N4tDIAavDDB
         rRQ+6485uz4vpoEby3WmiFwCnJG4YSX7Hr315AVdGZuvT4D/bHl/Esnx7ewfeL7x7hDC
         kQJHMC0AcpmVU1/p6N75bZEQ2TQuxCru5NRtOvHG23jsHpvaLphS25MguOce7RafMEtl
         5TNIkpsF4eAWJyRGQagGRDwJkQLUeoehq37Lc+7P0lFSa7OZ7EKW9GoASHMxkL1gL2In
         n1XlUi60LaeghdwL83BdSZjn6FkMyXNzabgFcPvJiavT84kYp76dZt7hV8mIHP+yWExN
         82oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425778; x=1714030578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBehbCdCyWW8txnp4pZNDxM/Mx+V9ByxE1Nv3M+HJek=;
        b=wkt/2cX97t5rDSfw6y9cMeWwHWk4r/WRu63eXEgT8ndTM/1rmnwtIVDuzhSP4Qlgr+
         F72zbjoS6z4gEsCkCADq5CAwSfVUtpQNok3yWDpWBib6oTjHda1/1gsdd4FFiZVNzW7c
         AsbSZaP7aGZFSmYCF9RV3GFwqsxH1LxRpjasbXSaRd/dF8D+S86Ofaj07HzIuSBROThx
         Gc0WDvZZcajiMRok4uOjAod2rum1UIlEUprvhO/NqWKj6VBFRwu5VD/q2LopbSJ7OU8n
         EVRYpmc2oz9ZMmHI4joQAylVO1XtRp0DqH0U8ZHfe0s3JvDsMvefWy7kIJADlmuB1aZJ
         1N5Q==
X-Gm-Message-State: AOJu0Yz365r16HpGfoJoFRlAySro5pwohZki/YbOmEMMS3E/GZkfhs5r
	+21/APLX6DqQj5MNRa5DzQEcso1eWUu2UfYtnBzgsvXJ+S2W2m4i
X-Google-Smtp-Source: AGHT+IF7Yff+KHvjATsuFYkHY3u1kmEmAmJLiYxFlUk8OFwGCBrSjwOts17Cu32vk8JhsZvjcgLo3Q==
X-Received: by 2002:a17:903:41c9:b0:1e2:61ca:9449 with SMTP id u9-20020a17090341c900b001e261ca9449mr2689550ple.40.1713425774392;
        Thu, 18 Apr 2024 00:36:14 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001e26ba8882fsm841756plt.287.2024.04.18.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:36:13 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 2/3] net: rps: protect filter locklessly
Date: Thu, 18 Apr 2024 15:36:02 +0800
Message-Id: <20240418073603.99336-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240418073603.99336-1-kerneljasonxing@gmail.com>
References: <20240418073603.99336-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As we can see, rflow->filter can be written/read concurrently, so
lockless access is needed.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 58e0da91bfef..ed6efef01582 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4524,9 +4524,9 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 			goto out;
 		old_rflow = rflow;
 		rflow = &flow_table->flows[flow_id];
-		rflow->filter = rc;
-		if (old_rflow->filter == rflow->filter)
-			old_rflow->filter = RPS_NO_FILTER;
+		WRITE_ONCE(rflow->filter, rc);
+		if (old_rflow->filter == rc)
+			WRITE_ONCE(old_rflow->filter, RPS_NO_FILTER);
 	out:
 #endif
 		head = READ_ONCE(per_cpu(softnet_data, next_cpu).input_queue_head);
@@ -4666,7 +4666,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 	if (flow_table && flow_id <= flow_table->mask) {
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
-		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
+		if (READ_ONCE(rflow->filter) == filter_id && cpu < nr_cpu_ids &&
 		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
 			   READ_ONCE(rflow->last_qtail)) <
 		     (int)(10 * flow_table->mask)))
-- 
2.37.3


