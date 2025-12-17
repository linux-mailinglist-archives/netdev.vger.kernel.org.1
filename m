Return-Path: <netdev+bounces-245248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DFCC98A0
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 22:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A11A30393C6
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 21:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF127FD7C;
	Wed, 17 Dec 2025 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi7cY+9C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3119AD5C
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 21:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005335; cv=none; b=gNSmR9dBr/6VD9Z4jjR6PYO2jtAQ0H3qLZWxkHtVIpOqVdMe6zPOEtlUuiOEF6W5fNT7nKNvTPgxH2JLYYYHacrHn7CLcDl9T/rZ1I0RlrYdd4/FG/ORuZGX9n2o9wZx/Y5K8AKgqZN6uA9hSkP3Sc1mRHG3/inZxEUfLydfINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005335; c=relaxed/simple;
	bh=BaFe8NVmB4jyIE4pQ/4p6zOG8BM4BGZxrRHSXBFWy64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TBZvJkBgZ+gzl9SjnR6Ez7gR5hTV913FES4W7NrJogh8t+Dx5+Qidi/7i7Iy0upDeivqhb43vGUCNF7I8LJOoen21DEjRQRgBkIbiGGntS5xiw87lUQWLYnbM3eHEriTb4G25IWQ3K8WxY1Z+W2OZMv/RV2W+iapkP1zhU6QHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi7cY+9C; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so3973933a91.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 13:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766005332; x=1766610132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llYlRwQLctWSGZQDxd2QIS2AvLGcZz6Ye2pGmxI1idA=;
        b=Fi7cY+9CIy6f7tgHaLa6B1tXYXBu4Y9mYQ6rm0ihxIzulfQxjzvmCIPE8qypSCzPjf
         hM1CUaAgzdbSgdGlbxakWVNFVz+qhbH5RGjwoRmS85vHtU7IvUmNMNNetuHPu7wE5jFe
         HLbaGnIPkYYObXTGIGPnwIe4rrcnJxXk09mSDcu+CHtkTJjXwnwBztS6bik1u3+nhHfY
         Ic4S7K3CDhonjwYxHmPMpoFXRyB9cFUk1q483pL4sV1YKVn0vBG319MQiI5p9PhdraaJ
         LHuoGv6kXvjPGei3xDemflMjJTzlj3B+wzhx9oxp+/yT6WWabShkfnoRWjRQwM57BOeK
         Ovsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005332; x=1766610132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llYlRwQLctWSGZQDxd2QIS2AvLGcZz6Ye2pGmxI1idA=;
        b=Lqfgqgj0aeHj9IodyelvAI3KUIGywX1fX+IW2tjdGzOmsR2sTzXQdYRsCyHsole6Va
         mXas44OeHRCUsa5qhgMMzjZW7aB4mCypGk5W0hJqkDo9FuSF9h8+TFz4YYTEOBUV5SrP
         2KjI8f6T6GMXnMbS66y9HdbXaPF5AKNbfvvi0X2vW5eb1BNYzS5UY/7BpA789c1BdKN2
         SrXrCGi8VxPxBe4Ib5/QJuRrF/U4l/g4xDtlnTDFZZhkqHuOW7uDlYagQEo1caxb8tZ2
         Jb5wmRhWIYLbW9ZpGuKSW6+FFhhV4W5estBpAMu3VTT+lZdIUCwafnXO7I8rrClNxjeN
         qukw==
X-Gm-Message-State: AOJu0Yyz0wwDPWiin28FZdCatuSaXaTFtLDQYeAqtA09PQolciz+Pl2H
	EeMBsr+p4isRELM4CpnbqlUkKYFuIBw8dDAnTtTNjnhs7TQ+Jr5SQlGYWTOXPw==
X-Gm-Gg: AY/fxX7MsPSlLTngwUV3mdyi3Mr4GrVMr9nFha+PaLQXjOaJg6Jma90DqlAaUFmH8Gj
	NjI0vMGWzcPzTBoTakHJIU7GxbWWZ9MvSiFM4vzzy52jl+0IRfxMoTYCJ2ItmORJj0geUztdzZa
	FoLUjZ3ayng1DG39oRcML+3FcGa8GaD/OHFp4YLOAGLsPegP9C1MX80xbhPVty0yhINFBf0NoXa
	QGYZcEBWHhxq87jxhURn3Pq76dOmUx6o1Olm4w5nkuuHV2bOwn/AG6Trg5U7Q6aEVfUPc+xKle9
	5/i4UH8Y4GPbtMi/aBuaYMYFUf6E2fWz6HfV3Lk3LMsUPwUpFMXMclUtHkHlhzTFNEiRRsKHgOY
	6sD3KAcNrXgopPq8465wSlAe0csEt1UssYGpl5WYJoY2LpAm7lXWUYs4ZJQ==
X-Google-Smtp-Source: AGHT+IEfkiMxQaMnFr3ApA+fVWSCLZvNJY1nONC5zfJUX5Mt4Ma9hUMxG5kOaGcNWruRLKZ1j3Rqug==
X-Received: by 2002:a17:90b:1d4c:b0:341:8ac7:39b7 with SMTP id 98e67ed59e1d1-34abd769977mr14636782a91.25.1766005332256;
        Wed, 17 Dec 2025 13:02:12 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e7722726esm13810a91.8.2025.12.17.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 13:02:11 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: mdio: rtl9300: use scoped for loops
Date: Wed, 17 Dec 2025 13:01:53 -0800
Message-ID: <20251217210153.14641-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently in the return path, fwnode_handle_put calls are missing. Just use
_scoped to avoid the issue.

Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/mdio/mdio-realtek-rtl9300.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
index 33694c3ff9a7..405a07075dd1 100644
--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -354,7 +354,6 @@ static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_mdio_pri
 				     struct fwnode_handle *node)
 {
 	struct rtl9300_mdio_chan *chan;
-	struct fwnode_handle *child;
 	struct mii_bus *bus;
 	u32 mdio_bus;
 	int err;
@@ -371,7 +370,7 @@ static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_mdio_pri
 	 * compatible = "ethernet-phy-ieee802.3-c45". This does mean we can't
 	 * support both c45 and c22 on the same MDIO bus.
 	 */
-	fwnode_for_each_child_node(node, child)
+	fwnode_for_each_child_node_scoped(node, child)
 		if (fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45"))
 			priv->smi_bus_is_c45[mdio_bus] = true;

@@ -409,7 +408,6 @@ static int rtl9300_mdiobus_map_ports(struct device *dev)
 {
 	struct rtl9300_mdio_priv *priv = dev_get_drvdata(dev);
 	struct device *parent = dev->parent;
-	struct fwnode_handle *port;
 	int err;

 	struct fwnode_handle *ports __free(fwnode_handle) =
@@ -418,7 +416,7 @@ static int rtl9300_mdiobus_map_ports(struct device *dev)
 		return dev_err_probe(dev, -EINVAL, "%pfwP missing ethernet-ports\n",
 				     dev_fwnode(parent));

-	fwnode_for_each_child_node(ports, port) {
+	fwnode_for_each_child_node_scoped(ports, port) {
 		struct device_node *mdio_dn;
 		u32 addr;
 		u32 bus;
--
2.52.0


