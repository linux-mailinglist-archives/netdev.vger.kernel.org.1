Return-Path: <netdev+bounces-220431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63CB45FAA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C18485625
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5740637427D;
	Fri,  5 Sep 2025 17:07:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8A35CEA6;
	Fri,  5 Sep 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092065; cv=none; b=FHY0qdN/J55NzJTRhx8n+x8Mb2IL9xexlRI8ita+g681YdQnwV6aK0jDMUMBiopRk1/s61EmMDO81Yhew255BNaPQj4DAITIzfo0tR4c/GSti+vAXGY17KoIKkcXRPaTla9009wesVPHyeZsYH+C8i3MHlOvEuPHZtjzO2ysT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092065; c=relaxed/simple;
	bh=sroc+RppV1M6H+TIsJKRX7fAwebQ6S9cC3k5ypJgaso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ud1llj9HTgK06QSNJJVX8EjXibqjBzuMHmQg2wzjMwvt4l0mXdylULqJHZ6snQYc3tUSyhcyhstAxq0sE03MA0f3poDxkLYIlASpwd5+QtkUf4Jz+v3fZn/G4JrdEY+maaBQr1KHlPft1hupKviZX3InfXi8ZCayvi2cgDKOy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0454d63802so399152666b.2;
        Fri, 05 Sep 2025 10:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092061; x=1757696861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WB27QbpegxH/pdun83Mbz494V3PtsHtvy0S+yeujRvY=;
        b=CmjNP5r4eG4sfHICvAa4dWwO8BbOuaExEPoJfFgLrTU5w37vcFgU1rsPGXqk78/HRJ
         BD3uUXuPppUHwkbSKAWozVEjoK/C4oinNQmxKQGB4B85VQ10dtSXMYVNnmaC/Abi/RGi
         PiSVr99uuqBdzegMxOtCH2CHvihu9cz0YlIlurO5DpISApzxC7Rr2KOm2hni5mFAD1Um
         QsGLXWEXouE8eZAKddB2cRXoW07bUhZv8kshaCXMLTgqPltVdiMnUU0f5g8EA5IJIUC3
         a3J9Mou9IWHDe5fwr4J1UgVyNj5QZ2iNPG3du6t/ehgsu4dF5xB3uJhjQvWTo662jPDI
         x2JA==
X-Forwarded-Encrypted: i=1; AJvYcCWJdZE/CZU9mvG5LYjxzsy70tp0E3/WtD3ALRVBBjwzb90w739MZSPNuTV4xRpI+/PjuFfoh6JFGP+qfac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64FxIJG5StBbUi9+aKR/obj9hheCMwIkgDk9Dnlq09V+vGgEA
	ROOsP22rvOPv4PrWI1bPqknMGTa8qq3z5s/lKhAjsgSka5jKc8vXgMHr
X-Gm-Gg: ASbGncuXq7eyaJaJIxMaWSWSSPx3yo5npBlqnOl6VfwRsuBj/1TXVGrCwxYVptIvMGQ
	bm2Cd1VrAinMm9M1eEznJXMZ0t6nUVaZWZGIEyhZSeIMjrEchAYiH6YYw+cKnJw/JmSPiuWScNR
	mDhO5J59SXFMexKxdWcsaz7sYL+Lr8wxl6DCB272jwibAr2GpxKrrwpBIFoG5YR+iW43/kOIXVf
	htIGDwlUk8RSXdw7WsQOEQ2oyisxXb9t0GZvvhBa/SoIIMRd8SM1WtLpZnfQABgAYJ7JV4RToGN
	6J8mHCqyj1t+4JG0GCwC0Dq5gqpV9KLEEPmgwtxyJ7F2+gsS7lii9oo9BAuF3iA28UX1buZw48+
	HHW2W58JnYtlUNA==
X-Google-Smtp-Source: AGHT+IEkBpUVtO8y7z6mSS/qOlXkeoTLptQaKSdIMGlkvuGLpdfe1FLEyTDL49ho2pOVXAdSfYopkA==
X-Received: by 2002:a17:907:2d0e:b0:b04:708e:7348 with SMTP id a640c23a62f3a-b04708e75b4mr1064208866b.30.1757092061372;
        Fri, 05 Sep 2025 10:07:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b02152cc1b8sm1602638466b.36.2025.09.05.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:07:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 05 Sep 2025 10:07:25 -0700
Subject: [PATCH RFC net-next 6/7] net: ethtool: update set_rxfh_indir to
 use get_num_rxrings helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-gxrings-v1-6-984fc471f28f@debian.org>
References: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
In-Reply-To: <20250905-gxrings-v1-0-984fc471f28f@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 jdamato@fastly.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=leitao@debian.org;
 h=from:subject:message-id; bh=sroc+RppV1M6H+TIsJKRX7fAwebQ6S9cC3k5ypJgaso=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBouxjSKU6lgNhuZGo6wKBMO2msYpL2/Fa+SIRns
 9e1AD7gvDiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLsY0gAKCRA1o5Of/Hh3
 bew6D/9Pxn6a4MJUgaAelp2Jvwf39pM8Cp8W1AfGBj2lmIJbg+j4d7oNHtxRxq93vaGnnZK9gNb
 1Qf2MAc4m2wx5er2xyEYEjvm3g6H3ntp0I2ZEbxzN6pDeGfHEKx1nRvKuw9DUqepUen04/T+BA5
 XmciqjcDeOf9SBvjqnlMfnrNZo75xeKq5T9uyg3Zq3vZJ9/rz7UZm9v36iq1FzZxJ4DoTraBbLR
 g6Ln6iXJwQoxaa/1aHN17NzOAZ4opKuyXEJtpX8E+ssxnKOIn/w6ArSGP3YUjxu4FPoLZRBUc93
 ibavi5cAVk5GR6GZfEDe8Yud2x/zstGRvDthHqLdLZH6D/h2MeyrY8Cggn48tqLFNmKacsuAmVC
 zZrxPZizGYlZkgi1aYhHjRXe7MJbMsuK73uX/OrhuYefH7BY+TqKpmaciFGd4UKCU4QXx84P37j
 1wWrSISGeqqmS+978jiGO4mtIS+0qLafPE3dJPTOMIQzDc7gnXrPTMH+FJwOGvs9hfHG236Y5p2
 jZsc0b8GoGeMdTx2x7ZMu185VKB/q5u+OnpCNN552wOUEDvsS1GTJ7XUxUx0JXNB5R+pSzlH6t/
 ewPRoYQ0muxDpaMVFf8kjYW7E0cps9uFf1lVL4FdQnmT5BRzaMDhbinkqHRM9cbk2AGYkiEV9qR
 3zKVJ/ClWzx732A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new get_num_rxrings() helper function
for retrieving the number of RX rings instead of directly calling
get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index daab20b392f7b..b8d85bba48329 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1367,7 +1367,7 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
+	int num_rx_rings;
 	u32 user_size, i;
 	int ret;
 	u32 ringidx_offset = offsetof(struct ethtool_rxfh_indir, ring_index[0]);
@@ -1393,20 +1393,21 @@ static noinline_for_stack int ethtool_set_rxfh_indir(struct net_device *dev,
 	if (!rxfh_dev.indir)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = get_num_rxrings(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out;
+	}
 
 	if (user_size == 0) {
 		u32 *indir = rxfh_dev.indir;
 
 		for (i = 0; i < rxfh_dev.indir_size; i++)
-			indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+			indir[i] = ethtool_rxfh_indir_default(i, num_rx_rings);
 	} else {
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + ringidx_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh_dev.indir_size);
 		if (ret)
 			goto out;

-- 
2.47.3


