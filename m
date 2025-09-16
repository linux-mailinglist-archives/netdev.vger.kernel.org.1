Return-Path: <netdev+bounces-223681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06AB5A08D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9D41C04794
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869322DCC08;
	Tue, 16 Sep 2025 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgC3DJTS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF3245012
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047606; cv=none; b=WZBgcz/NSecKuc1UV+GgdFQhC3VyyhyKejOtSnL+PyAXne118rdmOz2yQh1u9KhRsy8P9t2G3/j4d6TqCEeu97lqSxioK7fcgOWSlwMVt+vLR2cV1adKSx+b7phoPFQz5umFC17wttCauHYvkvmjDWRkj8WUjnPWqsH24hletgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047606; c=relaxed/simple;
	bh=BlV/zHkqjQf+ifev6wIKglqCA5gEeZLAyIwo6fmUPNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7rWorO6iADvKBBAA2X9HH6oXUS/8uuTWAriw16ZueE6MK5JXKY5FBb3wY9//jx2xJpGkzUx46mhIVfOEx8Tjfw7mwyF1YaRAEBIc/NN246wqhAB3TpJeDiHmaGv+9SbPGs6IMK2+XUmWMIFxMl3GsxdyPYN0TnhXv3dFIkx/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgC3DJTS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77b0a93e067so808646b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047604; x=1758652404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6NAtqurZPuJVv9MlI+fsRcvLTmzttrSsdFVWoHOXaA=;
        b=MgC3DJTSAbbAaWK5aNgomWWhN8rU22YE+QUx8HerMxfXvRDKujKr1jxsCdHp4nxsBu
         ZweHCbMjAEr1hYKk/gd1AwF0AKa+6yl+5S/+b/1nxTKoH8XGm0TITx1owect2EQN7sNz
         5qVifne7tp6JML1YuOQpywvGSWOBSMYAZqb2yDX1rJSHgzO6ulkbc6955LOBM2k06Ucp
         Cd0E3OBCdeKMAB6xlJp4EuH9IIhjKZdR+sVKjBiWFfeltr/XVStChqM/w3zmSEwFHzbw
         j8dSnFOO8MbnpC6fkwVHD7twPEILuzjXVmb6qzk2gIugOtBpi0SEUKoucrckR/NrBs4o
         7wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047604; x=1758652404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6NAtqurZPuJVv9MlI+fsRcvLTmzttrSsdFVWoHOXaA=;
        b=sg2wUwdkUpbLk6zOkEu0VFmBmx2lKdgeSJYKxEwFX8O7aGqFWnCwoTZyZ7l36BJLZ/
         xGqX4401335SqK62VfXP0xgK1AlhU/LoDnCH/09utrvCqdiF5tGV+yC/MWAiCOD6CLw5
         +ZozG3D5c4vP+vxuG3JptCApA1MkE4s7Aoz1JbwZT9qdLtjBxl7i3O+Gvhw7jWiPYer2
         nuI4z0ou9/Y1zBHOkxJjydg6jMy5bSQmuy6ZULoqZ1ZCcmGUt73d5HnUTua53zkuqyBq
         2wqUP37ad6OPs3365j9PU8o8UdYtddzuHy3JafE4ifAeq5kNGjLv+LV7Vo/P4d7lJlh2
         7Tqw==
X-Gm-Message-State: AOJu0YydIl+1xnm0TM5PbAICnnHPRgEw8GXheE4iGK7D0kg7DkZgwTr/
	mYveHa4S+pJTv7m6nimlEFVyJfIFF4713NyzzKQ7sSV/m1Nbi5TELfDC
X-Gm-Gg: ASbGncvUqtLgYiOFYDXE0hMJN3VsS7KoJQvFrXXukb4RmqhN/GfmGlTkaPham8F9sRs
	EhFApiR0q8Auh3nDzIrMJnpydTuZ1eONzz90QpcM0mf9zqhMHqo2dOWv1ujCd/5O9Bruc3DKWSf
	oKM+lLSsCDmAJBtCBbdCXfGjZfqRljdhiqCsL4GqaHVYaGSMG4oLGWDEcGmQQWZUCgcolVY7T0O
	adRBzILgNWRoXVoAZ2VO2vyLqHd3RpryfaiKiPpsRPr9Qe5UFm3pyBvtRMJ+HOlvz+pR+THwufK
	9qSsg2LEJXK1FGxYev2E3LswMUmx/JI3whPUglQT+rb52lCP5HpDORMfnjW4N9xZome8oi9cmsa
	sGeURJTD9PQmea3j9Xc6LPwnTOQjecW+kIRgWgR+rdx4Yp9ihheZCTKim
X-Google-Smtp-Source: AGHT+IE+y04TgsnGdr50srE5VJlDF11c/nMrRpgKED3As1DNw1hUFMxhvslMP2AQcq5t/31wHspodA==
X-Received: by 2002:a05:6a20:7f87:b0:262:7029:107e with SMTP id adf61e73a8af0-26270291299mr14807680637.4.1758047604237;
        Tue, 16 Sep 2025 11:33:24 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b543sm14915968a12.33.2025.09.16.11.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:33:23 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v3 1/2] net: dlink: fix whitespace around function call
Date: Wed, 17 Sep 2025 03:33:04 +0900
Message-ID: <20250916183305.2808-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916183305.2808-1-yyyynoom@gmail.com>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary whitespace between function names and the opening
parenthesis to follow kernel coding style.

No functional change intended.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/dlink/dl2k.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..faf8a9fc7ed1 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -970,17 +970,17 @@ receive_packet (struct net_device *dev)
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
-				skb_put (skb = np->rx_skbuff[entry], pkt_len);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
 							DMA_FROM_DEVICE);
-				skb_copy_to_linear_data (skb,
+				skb_copy_to_linear_data(skb,
 						  np->rx_skbuff[entry]->data,
 						  pkt_len);
-				skb_put (skb, pkt_len);
+				skb_put(skb, pkt_len);
 				dma_sync_single_for_device(&np->pdev->dev,
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
-- 
2.51.0


