Return-Path: <netdev+bounces-172280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A3A540B5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B163A9DA9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21308502BE;
	Thu,  6 Mar 2025 02:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IVKzSSQT"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54782150997
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228408; cv=none; b=YaiJmCW+GgKTEgMeQOZ3nWG1F+w8wmwzI7nVBTB4DLEDT+4jVFoOJKKXmWChWnC+dLS7NACQ+xLdH1swZMjPaJSOZP48uQqs7U0OMXfZe9srK3IVXpqyg4EpX3GKes3sD4/fkIGqS8XgplIvNey2xx1zaz7zMEbTlbVkiiq9LNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228408; c=relaxed/simple;
	bh=oZhQ3cx+jZPDjrIyToA+9aOzE462rMFOy5TIYftaGcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uzeqc5FFne30TzKG9OgnXbhHbe7ChG9xdo5uep5y/7qAUC+PyIdLYvq43K5rzkgNck9QQJZvic9dcKnvmzo7LqhTWhlTIdxaYEnX917aiSoIamXf813GYKBKNWq85uEYg741wXr0Svedo7adp0Gmgcz9EUysC1MW0Aq5b/j0m+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IVKzSSQT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1741228404;
	bh=sl5BJG1PuyP/V54YfUqYsqMWUstYHw5SnQXzcmn2428=;
	h=From:Date:Subject:To:Cc;
	b=IVKzSSQTsHDTW3QroSxMBGwA6j1LBiiZH7ljJynHs/3oChZBZ0TgOCQpKM7htmqtB
	 wFr8w52pNBTStLZWAexFiTvQzmhdxsGTQPdj7bk8MaF8484wf9F054kHwGXWWUguex
	 nujkIHCu+4dbSoxRjprMPkntmi6CJ3RH0AzX3WAARG5jzFQfeYcNKamk2+arNeMIhz
	 wdA14jw67s46bxJkPeVQzqfXboL+2Nus+cq0NVmmGEtQ/J9tWjuA4BnoUC1v0NlM34
	 0VqiRfTcKA0Zp6E7/uvjedY2+DSinbuaqY0ZCrCTzUP0PygiO5mpc+8QCR+X0jVx7b
	 D3Nwf5UeWwB8A==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 4CE4B78B2C; Thu,  6 Mar 2025 10:33:24 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 06 Mar 2025 10:33:20 +0800
Subject: [PATCH] net: mctp i2c: Copy headers if cloned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-matt-mctp-i2c-cow-v1-1-293827212681@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAG8JyWcC/x3MSQqAMAxA0atI1gZq6nwVcSE11SwcaIsK0rtbX
 L7F/y94dsIe+uwFx5d4OfaEIs/ArNO+MMqcDKSoUlrVuE0h4GbCiUIGzXEjd1ZR25XU6BJSdzq
 28vzPYYzxA/3818xjAAAA
X-Change-ID: 20250306-matt-mctp-i2c-cow-e9f028942734
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Wolfram Sang <wsa@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741228403; l=1357;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=oZhQ3cx+jZPDjrIyToA+9aOzE462rMFOy5TIYftaGcA=;
 b=n9v6NaoVgoD5qhx4BEmKAVRp4A7WYgH6bjYn1I3ZUMGmxwVA3VOpAjPqJDGF2uaDDQUeRN2uG
 FWHgfQGdhdhAy73MJ8E9zQXtGh63bLZQHUXdTKNWeQtIfZYOMhKzT5W
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Use skb_cow_head() prior to modifying the TX SKB. This is necessary
when the SKB has been cloned, to avoid modifying other shared clones.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Fixes: f5b8abf9fc3d ("mctp i2c: MCTP I2C binding driver")
---
 drivers/net/mctp/mctp-i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index e3dcdeacc12c590c0790c9425eb2d997937c1bb9..d74d47dd6e04dcf4163bb8cdc446dc3c649880d2 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -583,6 +583,7 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	struct mctp_i2c_hdr *hdr;
 	struct mctp_hdr *mhdr;
 	u8 lldst, llsrc;
+	int rc;
 
 	if (len > MCTP_I2C_MAXMTU)
 		return -EMSGSIZE;
@@ -593,6 +594,10 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	lldst = *((u8 *)daddr);
 	llsrc = *((u8 *)saddr);
 
+	rc = skb_cow_head(skb, sizeof(struct mctp_i2c_hdr));
+	if (rc)
+		return rc;
+
 	skb_push(skb, sizeof(struct mctp_i2c_hdr));
 	skb_reset_mac_header(skb);
 	hdr = (void *)skb_mac_header(skb);

---
base-commit: 3c9231ea6497dfc50ac0ef69fff484da27d0df66
change-id: 20250306-matt-mctp-i2c-cow-e9f028942734

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


