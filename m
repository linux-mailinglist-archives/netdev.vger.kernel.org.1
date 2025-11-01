Return-Path: <netdev+bounces-234844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D3C27F64
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91AF54EF980
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1A2F9D83;
	Sat,  1 Nov 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9eYnHcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3982F693D
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003699; cv=none; b=J5cFFtrfLT3g/mCd385ZiRF54tA3utvBJFiQXsocY9fs9vcCQAD/GnyfZpeCyzvf46e79xM//VnX+kDlW0olPpJX+FgImGPeV11JPQkyogDvpoMFEilR15D/CiSbCJfAk2DDy+/cp7B/HclANmeqYoSCxH0Vy89mOrRAZHIN5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003699; c=relaxed/simple;
	bh=GuA+isXe74pCMi5AagYqigBBFtYLC8iDrtT+Rj/v+/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTAa4PV4kJCQbqWM8UBYD9y09UjMgds8AaoUxq2xmToAgM9QQRm3bfi5dN9EoyPLm1GuxaGdoI3uHVExCKA6RuzH7qHs9ts1XCVSpW8J4iNyTokoRuBq4VSWSp90tBaDx9oLooSkt5T21v1uE6mgo4GPRlly5FlWNOXa0rN/nag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9eYnHcQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so1904143a12.0
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762003696; x=1762608496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsQWwaTBYaXaYYeBhg0oOm1XDOfz/d4zqdv0JWj9rWk=;
        b=U9eYnHcQOCoJN3AkeOc0eOPBcQzwGy2sr8czqaD/cqlS3II1+pDKQgvEyouhUFLDWm
         bvbBOEgR0fG71n4XTskzpYduGWtavL6dJ/9B7Q+wgBsUEWmFA5RmLYYPGi1FL/2gQCyk
         Wj9sWzXyFd+jblBopFapTYXwc/xMJLMtAKPAOHh9xxNF2AToAXxrwUanlzfqz0+oAfp1
         eIcfKDazSVmTJ5nhp5o79RyhiRO+NaYFg0hqDZgrjQvh/hqMriR6yq+xI1MuKzq5lKB1
         zlBT0S4um5Ot9FqWilzB8oM/r4ZqhgxqiHOS478WQUDAa+oXw7aAaLT+NUy+0SxuO0jK
         g4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003696; x=1762608496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsQWwaTBYaXaYYeBhg0oOm1XDOfz/d4zqdv0JWj9rWk=;
        b=ZQuK7JTvLGYyU6CKnP0fCB1AJI9JZOBW88gS8KZz4AivjN60ITMG+Z2/88mSKrbmcV
         gQxp9Gy1agz9yrBa70p2xO1qV4WBqSjNxFU7Fj7D4mkQ5v3CXp7ZkxIPBZeXW+laY7Bp
         qQ+yR0fn7rF9xd1MY/72IXJEu4+71nfYQ69yMMWEYM0OarmpHzhh7Lr/ybGbHqMpjVG7
         jJYt9Raz2O/4xGUjvcuBGkZsW1C2LNrH3zNe73uaYPxcA8LImSjaafBWYk4uAy022ZOQ
         KGXgI4MoybpgxpNztoh4aAceipbEfroHxILbnEbLYkSjCo/sKVOBt221cJcNb2H1HBZz
         3aPw==
X-Forwarded-Encrypted: i=1; AJvYcCU83+S9onBWo3uyl/W4XlIxMSaFQBHROC8z2jsapGrZK8mIeMgroprR+ow4GZffvzMUA69VdgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUx1X48Y/Ql10Wah+wuSeMACKbinhetkK8M485tWblmBZnd5gs
	Rw6OGx8+eTWYOH3IjBlO1pN69MCWDz8IrQWNkxEPqVIFcrVa8CZxqlix
X-Gm-Gg: ASbGncvmf3/CqKiWIx+gBJNMoCGnGdY9y7BP6STbU65T5MjpyUMt3ulnG4Ur7atCnf1
	qKCBM1mZjE8dSmWDpWk43d3VVFSaiKG3FGk5rRw7g7T6WmDQ+ygHjECJ8xnDfu3pWLqmffcWB49
	WOTdRtA+8StBqVSEhpgTy1x/pvxisGkaSh32ZQ0tyi8ApfW4SsAC069DNkrDHiriA7O9F1447Q5
	chE7hCnupWRCZ9nbh1JOgEIaYA7cQH++6uyjimtDwxr62sO6dlkGub26v5ro88VDQr3fC1/3C76
	Wj7DONBKRY4CkqPaYg+TI52kY7PlMy/knKg1aEKgRx5pwyWvKeL5BEDwz3mVhRPCM4C7jp1NWNu
	PZlgwz8DbxyzBt02UcxHB0IoOjCYLqkr9j2gwg5rBEcS7MJDqsf+F5l2CaMYrgbw7ehCvrv1Eb1
	QrGexoNJvAGEJuiBPZwOxokTBnTfi/Dj+oSdLBqAXFumkHjP280jxqkNvBz7DGUPw+76U=
X-Google-Smtp-Source: AGHT+IGZSQM2I289mbdiKbtsD737lwC5ysxlXKrslabDruRymOPxxKq14HayHZfu2hGtyjjE+PL15g==
X-Received: by 2002:a17:907:72c8:b0:b3f:9b9c:d499 with SMTP id a640c23a62f3a-b7070735de0mr699584566b.51.1762003695965;
        Sat, 01 Nov 2025 06:28:15 -0700 (PDT)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cfa966sm453741766b.65.2025.11.01.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:28:15 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: dsa: b53: fix bcm63xx RGMII port link adjustment
Date: Sat,  1 Nov 2025 14:28:07 +0100
Message-ID: <20251101132807.50419-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101132807.50419-1-jonas.gorski@gmail.com>
References: <20251101132807.50419-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BCM63XX's switch does not support MDIO scanning of external phys, so its
MACs needs to be manually configured for autonegotiated link speeds.

So b53_force_port_config() and b53_force_link() accordingly also when
mode is MLO_AN_PHY for those ports.

Fixes lower speeds than 1000/full on rgmii ports 4 - 7.

This aligns the behaviour with the old bcm63xx_enetsw driver for those
ports.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index cb28256ef3cc..bb2c6dfa7835 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1602,8 +1602,11 @@ static void b53_phylink_mac_link_down(struct phylink_config *config,
 	struct b53_device *dev = dp->ds->priv;
 	int port = dp->index;
 
-	if (mode == MLO_AN_PHY)
+	if (mode == MLO_AN_PHY) {
+		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4))
+			b53_force_link(dev, port, false);
 		return;
+	}
 
 	if (mode == MLO_AN_FIXED) {
 		b53_force_link(dev, port, false);
@@ -1631,6 +1634,13 @@ static void b53_phylink_mac_link_up(struct phylink_config *config,
 	if (mode == MLO_AN_PHY) {
 		/* Re-negotiate EEE if it was enabled already */
 		p->eee_enabled = b53_eee_init(ds, port, phydev);
+
+		if (is63xx(dev) && in_range(port, B53_63XX_RGMII0, 4)) {
+			b53_force_port_config(dev, port, speed, duplex,
+					      tx_pause, rx_pause);
+			b53_force_link(dev, port, true);
+		}
+
 		return;
 	}
 
-- 
2.43.0


