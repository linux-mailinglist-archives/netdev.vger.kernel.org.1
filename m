Return-Path: <netdev+bounces-171717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F481A4E4EA
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F185C7A5859
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702EA2080CE;
	Tue,  4 Mar 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCmS67IK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B84A202C22
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103219; cv=none; b=AjCBZ3rGm+KowZ5JDdRFiNPGCayLhYGPVbhjs1+Qa/hKlRMi7MqJWmSkwSXli3Kr1KVQp4y/RO9t38BBJlpLzEqhJy7Yb7W8+y+QFC8g5O+2w+g3b0lZa50/rEKjL9NPffIcS+vahcXaaHhAlDE+Y3iVvomyomMzobJkoBoA8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103219; c=relaxed/simple;
	bh=JlT1us2ac0awV9pP8C1xjNPYJXM/5zfVenduqUQN3GA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=unEFhkWiuDaLn6KzQXq4XvBVHoGhF3X3tuLxnu3yoK3g6lz8BMF7Ib3QgZN/WqJ8NtqfctTmAr4Q/FkkV5LzXEr8H7dousAb05pgiEmycoLOIXVCr8WH6N5Q/y5/gpFcLLTbn8tLkuBRYUzLIs3KMZJuzNs74Q7kN4JxV59Q5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCmS67IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68501C4CEE5;
	Tue,  4 Mar 2025 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741103218;
	bh=JlT1us2ac0awV9pP8C1xjNPYJXM/5zfVenduqUQN3GA=;
	h=From:Date:Subject:To:Cc:From;
	b=vCmS67IK8Z/ZNpIbSioSbxjDwdkvjbq8UL/Hyzl5JSUS15KaxtAWCYco+PewJiPZG
	 5xmRWVdyobrTKdNPKeTJx1ONGEeswiKaQwlYnRSv5NyWsly3ma6DRFR9WrziPp5pXY
	 ZXCwADk8HBDZo6g1sywa176K6SwvZwKzra8ivXGhxxhuue3gm1LICdsoE41TJXby8h
	 UyEUMS1IEL/GAeyQZUGu8n4JE4Lv8Xt27mRSUJz6nhQvnpMVdAoTH5XrBjmB3nQV5v
	 KZLB8uswGxBE9H8BOaedHZUCCYjpdnFgPGx2okzlx0rAkepSqMr8ujFyCEXVmjigo9
	 +5bxYZw/HXAiQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 04 Mar 2025 16:46:40 +0100
Subject: [PATCH net-next] net: airoha: Enable TSO/Scatter Gather for LAN
 port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-lan-enable-tso-v1-1-b398eb9976ba@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF8gx2cC/x3MPQqAMAxA4atIZgO1msWriEN/ogZKlVZEKL27x
 fEb3iuQOQlnmLsCiR/JcsaGoe/AHSbujOKbQStNalQTBhORo7GB8c4nkrPDxLQReQ0tuhJv8v7
 DZa31A5wWe4hgAAAA
X-Change-ID: 20250304-lan-enable-tso-5cb14e5f55d2
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Set net_device vlan_features in order to enable TSO and Scatter Gather
for DSA user ports.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ff837168845d6cacf97708b8b9462829162407bd..8210d8f75debd792ddb05a8ebb64825d3159bc2c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2474,6 +2474,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 			   NETIF_F_SG | NETIF_F_TSO |
 			   NETIF_F_HW_TC;
 	dev->features |= dev->hw_features;
+	dev->vlan_features = dev->hw_features;
 	dev->dev.of_node = np;
 	dev->irq = qdma->irq;
 	SET_NETDEV_DEV(dev, eth->dev);

---
base-commit: 188fa9b9e20a2579ed8f4088969158fb55059fa0
change-id: 20250304-lan-enable-tso-5cb14e5f55d2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


