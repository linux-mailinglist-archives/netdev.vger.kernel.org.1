Return-Path: <netdev+bounces-243832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEF7CA85C2
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E88E9326A706
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51C4328B72;
	Fri,  5 Dec 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqxx1j/9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656630CD8A
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764950365; cv=none; b=SkrGBfcO5jKaa7Ii6oTdg3XpnY2fHcwyoy7vGGFuXJvlUFh0fWUTKFMtUpU5S6Y+qXIJZF16GhdRek+tfZv6MlOYpNYjYx2Kvhdirbk20JDVhUf8Sge1MMk3gaIS6Y+hi6wE2FpaTWRvy4uTkUxBCAgLwb3DQT9NrWUP0+cSq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764950365; c=relaxed/simple;
	bh=fMkh/+GORKDOO8v8Ui/IcVECRqz4+4A7C8qVk+4Iogk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CXOQmuiy2vHxjk/RSLpr33OlK8sNgR3p+ww/RneN/t2ARX6V/uut/nr7htkjDnPlqQenZYqSLqE7W+L8HeLEnhOuoniG82luIkfGrJPyMa21cTIM0NBSBuont6apY4DfdWfbLlHHl4heKUbwtVu4o7cGLakVBTOt2siQ4BUuqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqxx1j/9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a2dced861so28368501fa.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 07:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764950358; x=1765555158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8YFHFQMYLs67LBd0r3P2eo50fmHGqT7+PYNyYmOU5o=;
        b=aqxx1j/9Ryjc2mVTKKZrWkWF3N3i1UBwhTlEtvFzaoBX/lHKmiVGsv00QJrKTxd2Ii
         Hps9WUtNGnmLH61dlxApWPSfosfrYvqAalB31u3tj/zsIftr/YtsslctvvCIs6ZpdLxr
         gM7KwXcptUthEM/n6jEP8LAXBe1vtxXautrOX261+p1SIO0kU9FUglIJlW2c/VursQp3
         H8+Xzeq2voToXN4/gxyp24OFG6mHTQ1qLHORfBZCAGlUIR85r8Xkqcid+ieAeZg1YQVp
         q8cHED8RctvYBiFKIEeVOf8lXDO5eiIjG//rdt+Mj5Mqmjq8fV5E12l2STt2qxoVe/nT
         gX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764950358; x=1765555158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8YFHFQMYLs67LBd0r3P2eo50fmHGqT7+PYNyYmOU5o=;
        b=ZMohrJID95XTBNNgBbV7uHGATwBZ23KfxBpL/rMoj913KDmROgds6gJpdLmhzg88mD
         8n+MO/EFV/nLzTMckTRPA1wbp2YI0RzM88Mlwo+NvdxUI91faDnUlEweMroDOYloo4Hn
         05yf+Mj68MjqGIPRxkVNAWNYWW3b3B+UmKmTgPxrKvPKJDcVXDeNwZ5c0P7brr7Pjr+b
         HdmwjrzCwspbWbPs3l980QbnMMw4iQwf6L1PK0wAvWzVd0/9op9lIUVCAKc0cVOKNSN9
         Y8pB1zt+K3gS3lrTq78/DRE2Tf6a1eDdiLEHWAuf1DY6LBtmdfXs5RoPJ2UThNMOM+y8
         mV7w==
X-Forwarded-Encrypted: i=1; AJvYcCVyWC+QMDDpHM+ARIiy5qwIwvbQHJJPOWqaEcTm/ziOVufDlGJqYIlwqLj7LzqyNKH6hkcMAdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzIyXhB6s5cQoRWfngK5/BHH2opN7zWPModdit9lpRBl54uK+
	sdQxnhzYiS5GJ6jbAw3BYe5N/KDs3Bl7x3MDWIQZYgTwZ7XiwQly7h0k
X-Gm-Gg: ASbGncuGhJf0aVr6tAl7v58gRatRDCCNgSnC3z6RC9w8INJhyWgBi2KRLCIs/vh0sYP
	5QSQktKOE6pn4xnmLcXxcpDO9LphhQWm9cgY8K/kd6lq3QOXWEdfr8Hdn2VI9lpzjZoP1jFRpqr
	MtfNxmF4J2Exdk9mer1weQ9MbheRclzUV7+0CviFlagJhfZiEZnOKcHApIJQmA3JQtIX8pcHf03
	4y7pR5KgAq8R38xNa0L5c/MYEsPSBOPJkjTUg1XQO6qUYR+ja8G60fI3JHTlGzb1/a6kNF/zB9V
	wbroyg8A30EGymF2qJ6LL50P9u/3dE5KBASsi+Lx/AsotHUzGNFv6JWClX4JessrEAwipAG61X9
	qwyip+sBGCM3Puc85Llty8aqSm83bUze5sKp5Fhev1aHh+X3bJQAN9DeVQ48COkFlnpYw73k/ca
	h/QGtr4m3GdDX+UunG2GjD0c92BjoM44X/bOJG1HPaLLyZ29Or
X-Google-Smtp-Source: AGHT+IH4gweIrhcwKcKDplfWvPWfFrwQ1eXB+3kFy4WFEYx92+052G49Yb9690eCjEjjdGrPb4UtLg==
X-Received: by 2002:a05:651c:2226:b0:378:e3a7:5dfa with SMTP id 38308e7fff4ca-37e6ccc9f5cmr22155491fa.20.1764950357756;
        Fri, 05 Dec 2025 07:59:17 -0800 (PST)
Received: from home-server.lan (89-109-48-215.dynamic.mts-nn.ru. [89.109.48.215])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37e6feb97c9sm15444501fa.20.2025.12.05.07.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:59:17 -0800 (PST)
From: Alexey Simakov <bigalex934@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Michael Buesch <mb@bu3sch.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v3] broadcom: b44: prevent uninitialized value usage
Date: Fri,  5 Dec 2025 18:58:16 +0300
Message-Id: <20251205155815.4348-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On execution path with raised B44_FLAG_EXTERNAL_PHY, b44_readphy()
leaves bmcr value uninitialized and it is used later in the code.

Add check of this flag at the beginning of the b44_nway_reset() and
exit early of the function with restarting autonegotiation if an
external PHY is used.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 753f492093da ("[B44]: port to native ssb support")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---

v2 - add restarting of autonegotiations by phy_ethtool_nway_reset(),
instead of returning with 0 code (suggested by Jonas Gorski).

v3 - add needed mailing list into Cc.

link to v1: https://lore.kernel.org/all/20251204052243.5824-1-bigalex934@gmail.com/
link to v2: https://lore.kernel.org/all/20251205071759.5054-1-bigalex934@gmail.com/

 drivers/net/ethernet/broadcom/b44.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 0353359c3fe9..073d7d490d4b 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1789,6 +1789,9 @@ static int b44_nway_reset(struct net_device *dev)
 	u32 bmcr;
 	int r;
 
+	if (bp->flags & B44_FLAG_EXTERNAL_PHY)
+		return phy_ethtool_nway_reset(dev);
+
 	spin_lock_irq(&bp->lock);
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	b44_readphy(bp, MII_BMCR, &bmcr);
-- 
2.34.1


