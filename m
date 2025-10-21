Return-Path: <netdev+bounces-231382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB013BF8451
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BB2545861
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8926E16C;
	Tue, 21 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMgO+w8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451721FF4D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075210; cv=none; b=O3ynT5B1mEp7qgrVxZsn8Bnnsa07/iNZJN9EMGxArL79tBQeBzVykXY0ygEtPRdM7gzn8xQG+JRW0+xKE1w1QQGU0FBDj/m0yKnRm8eVCFw+L87dTsjm4WZ/5KD8K1xP3Wg/iyXTKBb7G96ojpcNX7FFbNDN6JCELdFu4etYGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075210; c=relaxed/simple;
	bh=K1TU1UHrq0DQiKTAOIZPJwfZQj5ABx8dAaTeOx2uq2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if8/xnEPuWTCZIne6iQfK73uWOPxs3BPoTRVyCiNZaDbhamMHHVRFiVWxcI8zMPvjqY5JMoPu2OGnvBQ/MP4vl86ESF882FT3D/5UeR3thd2HM6CfrdPknnGaBvKl6VPoc1TbqyHkC/Afj0OGkuXX8P7NK8wLnzJLjXWlpHW2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMgO+w8w; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47109187c32so28552455e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075207; x=1761680007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFUK3/M2/OMRE/7w/JqieZkjZV+2HO5R7PJSBTyxlH0=;
        b=EMgO+w8woxr3D53Jss0PBhzKhR46ViW/unYaVj57OJ+NvGBHXke2Msw5fuB99RG2tl
         k8udkcEK6dg8HUdtkcxiDS2AnvfqnXJPR3gTSmJnHHG2EM/J99nYjWeFseKlYQf5t144
         hx+8XHJIOAHYy/xwVB9A/bFkXV6vy2ZDoy2Mj0SL1r6fl/NosqWq1yJN3PFO/GJpPl/h
         J+WAkXol1uTmINIus+3EBwecGSkwn5YDSh56qarKnrimA/ddeTPiZSZ73gJAxA5D5WYP
         oIz8cJ0D7SlDs9hzNXDOYYa1YOhuZWcXzU8/ZznVtwLBpu8JN1JchvqcXNrgD70GmVNR
         KpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075207; x=1761680007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFUK3/M2/OMRE/7w/JqieZkjZV+2HO5R7PJSBTyxlH0=;
        b=Km3+5uajth1Lioerqq5FuWhq+rwid4NRPHx6BQbsgoBbEv2NDe88pYDSJPRCXLrCAt
         UvFVgBcMp+mjy144CX3yfoOSSO5NrV4bS4z3b52CgNk3lIk1HKOAqmjPjNZYHAfKKGJT
         1uwfWlAns4wULop4nhuAcXM+AiwxMTPSjH+jXp/zaErioqi1Ddhv0lXY8on9Q7F9q6hl
         VCn36i12cvyJqn9Bjeb0aR/Xb1U4XO0XMnV1Ps2+J3bZYx5LAldUGs8bQqRlORnX+BBT
         mn/5SG6fjdbOsAsprKg2VSb8WlJama5n7JS4IcUQqewsxrbMkVzOIcGMT0VYe0343Sep
         xvzw==
X-Forwarded-Encrypted: i=1; AJvYcCWyYE9W7+GhK7iQIjd+XMSKZEL1LCubQA/UuFiFsNDXxxNb2X84NPNB1QLD7APaD58i5FJ/pts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEDJF6yg2amG8r0GBGIoKQ1a3Kkz1u2CPofj/BNAQ11c+zuVk
	Y8WMpZKGghqbSa73n0AYThMtsGldY05MNBf9TwUralxMDtf9oQ+DxG61
X-Gm-Gg: ASbGncv2t8+w4dj23hVWSlZjVQFjQ1lQT18VTPW3sAGog7JgI+T/SkpjP5anpBhW9QV
	nkZwCjyl0a19Vql5V/ZasummQ6Vc7I2kG2N3pVjw8z3D2VHAC1CCmuYo+kwpRlpa6gr9eXoLqYT
	4lwulON3MxjwsuMcR/gJKa1+r/ycdDTuOvO3NQqWxG/djKKrdSKpN9kZm+xm3hHkwnBvUrvub4m
	t+n+ffCn9q+gsFRsMlXtgLER3sl9FL1UtqvO+K+tHuN3Z7oOAWJCZDCXk/fuGmX8Ex2ooAPvqni
	ugqjUSUSydt/38bCHwWC0d3v2Y4YKRRbc0++TlMvsIPu2aUx/fszbFcQLDHkLUl3TzW6CG7TxtS
	hHm9gnjswZcSMxg8PxShPOa7ZbBmHuk/ISmkw6rW7COGCEezM8azOwr0wiBADOLaoMssg9d7pUT
	J2R5wl76vzqhiZpi/GpXM8Xd4z0B9JKU2U
X-Google-Smtp-Source: AGHT+IH2bGg1MypnCbkNL1KvMQcoGo9pVkFOJRpGUB8Vak6PvFEbE3s2pNvi9PmCY/UqdtGimE4Phg==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr152001025e9.6.1761075206980;
        Tue, 21 Oct 2025 12:33:26 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm21327187f8f.36.2025.10.21.12.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:33:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 1/2] net: airoha: use device_set_node helper to setup GDM node
Date: Tue, 21 Oct 2025 21:33:11 +0200
Message-ID: <20251021193315.2192359-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021193315.2192359-1-ansuelsmth@gmail.com>
References: <20251021193315.2192359-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use device_set_node helper to setup GDM node instead of manually setting
the dev.of_node to also fill the fwnode entry.

This is to address some API that use fwnode instead of of_node (for
example phylink_create)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8483ea02603e..ce6d13b10e27 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2904,7 +2904,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 			   NETIF_F_HW_TC;
 	dev->features |= dev->hw_features;
 	dev->vlan_features = dev->hw_features;
-	dev->dev.of_node = np;
+	device_set_node(&dev->dev, of_fwnode_handle(np));
 	dev->irq = qdma->irq_banks[0].irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
-- 
2.51.0


