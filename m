Return-Path: <netdev+bounces-89033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 036238A9428
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0DE1C20843
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36EA6CDA9;
	Thu, 18 Apr 2024 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2SAwwXy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7556462
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425773; cv=none; b=XH2QuZJjzqcoqMBEqYFD8ZNC76UtZuhfhNq9ISeir7PCTlbpSsSxn01Xz9fvuluRI6/oPG/dQiTKFUkiCWSohzVi82InslI0H2Pbbta5HTmYK+qSoZj8vBrGD92zRheWrkLZjUz+U0xjmFjqytsShUFzfeP/gjmgA0h8AjNFtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425773; c=relaxed/simple;
	bh=SOjRjeUJDoa9oFT1O0p4M4FPxZCcohSdrD5qjmQkkRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TryfS5EQHNtQk+3HPXwO5IRRp3j+oObKm4rSpaxGW/ECWIjI/PLQlD2/QbF5BLdHImDZB35lxvBAz2a4HviN0a8d8Iiqjse8cJrWP9l5HbwuKGT8nztmnOsg06GvpZuc6qvclxc+GtR6X2GwLy1uhvmLWNJ+jLvgmV1ruztrKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2SAwwXy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3c3aa8938so4398365ad.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713425772; x=1714030572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqMygDrTMWROWwU+4nXqwtf7JivSIp3ISM3CYmYtTDM=;
        b=H2SAwwXypeesnkAttAMt7Olq5enFFpwdzmktBzB00tvFNOcq9PNGyM4sPQx2sf4bLn
         k9noKwLQJKNQL30jpUmfrM8GYI9Zcqo0lVyaXs0fUeqCjb+U0Mn5oPyiwICZTQ4wuitz
         k+QkFOMuJE9m6BwS6WtKAm3sR5f7+idhPpXg3jAU9/5gqQ0O5hGDtY7Y0rmP1Ox0olNq
         GmCNY/e3W7WHO6woLc3b4nAFxyQKJjp/pB2V67VcvXfaEf46YAP80iZMaElEEN2FRNxU
         A7qNMN0y7A2i8IfSF6IB1ROfLW4L2aMJbFWKrREx8yhFilhIW6zzlXlZ3P/yjC4zg1m6
         Aq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425772; x=1714030572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oqMygDrTMWROWwU+4nXqwtf7JivSIp3ISM3CYmYtTDM=;
        b=gMElbBr5SMFSgq1gd86JYhQyk3mfNDXYEvjxn5TgEw8TYyeWIXHt1W627bUykcLg97
         QWpQte9r2w3epcGDjykL/EPtRrO1nd1LzXBh+5fAGkWlbLOWG+bmJOMBGnVNW0/mQSa7
         YG7GpsV2v75BnAFyGVzSR7IvHpaCgVtoM13GRWXjTml8QP+0bK5Sz0fEjRSoq9cae2Tc
         2l2un7nT9a5A0Z/hD4rPPkSmpNYic4CN3CUUpVy8u1PTMpTdfpHjmlsJgkuiEdO/59h1
         /6xuOf2Di51iIboAKXE231sP0bIKS2s9sc1T99zAzpMADoVd+qTuijDU+WXJMRTrOBOO
         Vb6Q==
X-Gm-Message-State: AOJu0YzN26kSrYM+GLLFR9dvjg9wOe+iezt9JZC/pe9f50IfySDrjGDL
	EXq+L3QCfW21Wy+VU6dOowBHTPyY0tUkpheLnybrbXGTJx5hq2yD
X-Google-Smtp-Source: AGHT+IEXKnYVhqazbZhTC7VnTwjNePPdZajzKVglHC3nuavD1CEgxOQ0t3x3ItmPNixcMszAQN4Ufg==
X-Received: by 2002:a17:902:e843:b0:1e4:b1a2:b40c with SMTP id t3-20020a170902e84300b001e4b1a2b40cmr2599413plg.42.1713425771690;
        Thu, 18 Apr 2024 00:36:11 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090276c900b001e26ba8882fsm841756plt.287.2024.04.18.00.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:36:11 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 1/3] net: rps: protect last_qtail with rps_input_queue_tail_save() helper
Date: Thu, 18 Apr 2024 15:36:01 +0800
Message-Id: <20240418073603.99336-2-kerneljasonxing@gmail.com>
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

Removing one unnecessary reader protection and add another writer
protection to finish the locklessly proctection job.

Note: the removed READ_ONCE() is not needed because we only have to protect
the locklessly reader in the different context (rps_may_expire_flow()).

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 854a3a28a8d8..58e0da91bfef 100644
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
+		rps_input_queue_tail_save(&rflow->last_qtail, head);
 	}
 
 	rflow->cpu = next_cpu;
@@ -4613,7 +4613,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		if (unlikely(tcpu != next_cpu) &&
 		    (tcpu >= nr_cpu_ids || !cpu_online(tcpu) ||
 		     ((int)(READ_ONCE(per_cpu(softnet_data, tcpu).input_queue_head) -
-		      READ_ONCE(rflow->last_qtail))) >= 0)) {
+		      rflow->last_qtail)) >= 0)) {
 			tcpu = next_cpu;
 			rflow = set_rps_cpu(dev, skb, rflow, next_cpu);
 		}
-- 
2.37.3


