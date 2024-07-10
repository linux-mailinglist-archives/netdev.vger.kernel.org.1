Return-Path: <netdev+bounces-110473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A84E92C85A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896EC1C21998
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E54C6B;
	Wed, 10 Jul 2024 02:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jggazSsv"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F462F29
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577880; cv=none; b=fw6QnJO0Kxl8Cbm35NxYRP64mpBbK+g4g2QyBwReowxqmxYqIrbRWgRKcJnwFHdgGE/yi1ZbA+Z52GUPV0C+W3HDJa7cF3fbUAueuW8Eho5OExoy4QXAKn9qLxmA+6GTXIcLZxnoQNFGU4vD5cRzI8lebQytEb0Dx/J1u4XHm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577880; c=relaxed/simple;
	bh=JBhugqa9TK2DQd5I/BMCO8nrGollFLYKCirNGovJYtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eYYzKM0fugMqpQlWaaDT2US/lVLFVEX00zgmOib3UCmht+z4beWoLCvtcIWL/boss4c8eUik/B3GNhxon0AvJSUuugeP/M+tpkyi6s7zKwfOQh+5ki1Zbnx9UD9CNQfL70Jem2DvA0jvUmkyNSdQJE8dYXm5yuBEBbcwd/7WZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jggazSsv; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id BDC3820127; Wed, 10 Jul 2024 10:17:49 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1720577869;
	bh=iqiitfH02PWVrl8K43eLfDl0xvYXhnZme0NUZ/EeWbk=;
	h=From:Date:Subject:To:Cc;
	b=jggazSsvP5lZ6GsJb4aUmC7MMcD53ycsbEzJg4Kggtq513e/rFes0qCsAvhFYzeKO
	 E9/AUUIO66bYBpUX48hPa+jcNNnPMoDE4lNRnhtJ7JjwACkBF5358LDcCeRQ6ODsDk
	 MQWbw+L7exHMFK4/HKUpfvFPyMuQboOrJ0WEjJJR/vc5F/EsLHzmVDHIuLOgE6yJfm
	 Vga3itOL2+3MC5a5Znk7kXof7OoGjMITkkNWO9Va3wxX8pUg3WxZitRnUsVEqPDVJ1
	 R3qgrDVy/Fmj9cY1wv4DB8mufqIx5NhubsKPmG6d3foNRLnaI10hF9n4G0aAYyhI5U
	 VaXeDsj2swt/Q==
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 10 Jul 2024 10:17:22 +0800
Subject: [PATCH net-next] net: mctp-i2c: invalidate flows immediately on TX
 errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-mctp-next-v1-1-aefc275966c3@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIADHvjWYC/x3MQQqAIBBA0avErBNGi4SuEi3CxppFJiohiHdPX
 H54/AKRAlOEdSgQ6OPIr2shxwHMfbiLBJ+tQaGaUUsUj0leOMpJGKtxklIpXBCa94Es5/7awFH
 qCvZaf31VPRdlAAAA
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Bonnie Lo <Bonnie_Lo@wiwynn.com>, 
 Jerry C Chen <Jerry_C_Chen@wiwynn.com>, 
 Jeremy Kerr <jk@codeconstruct.com.au>
X-Mailer: b4 0.14.0

If we encounter an error on i2c packet transmit, we won't have a valid
flow anymore; since we didn't transmit a valid packet sequence, we'll
have to wait for the key to timeout instead of dropping it on the reply.

This causes the i2c lock to be held for longer than necessary.

Instead, invalidate the flow on TX error, and release the i2c lock
immediately.

Cc: Bonnie Lo <Bonnie_Lo@wiwynn.com>
Tested-by: Jerry C Chen <Jerry_C_Chen@wiwynn.com>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-i2c.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index b37a9e4bade4..4005a41bbd48 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -442,6 +442,42 @@ static void mctp_i2c_unlock_reset(struct mctp_i2c_dev *midev)
 		i2c_unlock_bus(midev->adapter, I2C_LOCK_SEGMENT);
 }
 
+static void mctp_i2c_invalidate_tx_flow(struct mctp_i2c_dev *midev,
+					struct sk_buff *skb)
+{
+	struct mctp_sk_key *key;
+	struct mctp_flow *flow;
+	unsigned long flags;
+	bool release;
+
+	flow = skb_ext_find(skb, SKB_EXT_MCTP);
+	if (!flow)
+		return;
+
+	key = flow->key;
+	if (!key)
+		return;
+
+	spin_lock_irqsave(&key->lock, flags);
+	if (key->manual_alloc) {
+		/* we don't have control over lifetimes for manually-allocated
+		 * keys, so cannot assume we can invalidate all future flows
+		 * that would use this key.
+		 */
+		release = false;
+	} else {
+		release = key->dev_flow_state == MCTP_I2C_FLOW_STATE_ACTIVE;
+		key->dev_flow_state = MCTP_I2C_FLOW_STATE_INVALID;
+	}
+	spin_unlock_irqrestore(&key->lock, flags);
+
+	/* if we have changed state from active, the flow held a reference on
+	 * the lock; release that now.
+	 */
+	if (release)
+		mctp_i2c_unlock_nest(midev);
+}
+
 static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 {
 	struct net_device_stats *stats = &midev->ndev->stats;
@@ -500,6 +536,11 @@ static void mctp_i2c_xmit(struct mctp_i2c_dev *midev, struct sk_buff *skb)
 	case MCTP_I2C_TX_FLOW_EXISTING:
 		/* existing flow: we already have the lock; just tx */
 		rc = __i2c_transfer(midev->adapter, &msg, 1);
+
+		/* on tx errors, the flow can no longer be considered valid */
+		if (rc)
+			mctp_i2c_invalidate_tx_flow(midev, skb);
+
 		break;
 
 	case MCTP_I2C_TX_FLOW_INVALID:

---
base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
change-id: 20240710-mctp-next-cf7031122060

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


