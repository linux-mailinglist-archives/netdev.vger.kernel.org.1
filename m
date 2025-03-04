Return-Path: <netdev+bounces-171660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D13A4E0C1
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4BE1887AF2
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CBF205E0E;
	Tue,  4 Mar 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAUrCuhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E8205ACF
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098099; cv=none; b=tcGHyyKUFVY+iDhDiEsUpCeGqh8KfI/UhFcOFOKNRHEWKyhNZR+fSf/rTOZhrNIDIL/FHdegX1A4zpfYnUIHv0+ItYkUUF/mtz6uF/8JrKtmeUSN2Yp5u2prNNNbvgcem/xhLvCUxj3SFoVPSWL9zEPIYs6rA1EqhFJOCFRl/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098099; c=relaxed/simple;
	bh=8phL8Z0nowV8iC+G+2BB6CchiuuX38+hPnWOvYuLRO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hU4s9PzVq5EJN0zK/mbX0SL+cpD1nFR97ek7W9LAsc9YJ5WGrDKNfMDcCDmTLZveCZqXPZrUyijKArr0hl59zOIKACFP6bXm66yZonq51JzqXxZBeD3RCKondJ2+tjTrNwhfHK7kRVkaLa6WaQ08ZjYyleUAv+wfWEw+3N6lato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAUrCuhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E8EC4CEE5;
	Tue,  4 Mar 2025 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098098;
	bh=8phL8Z0nowV8iC+G+2BB6CchiuuX38+hPnWOvYuLRO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LAUrCuhy9HGxh4EhJuBs74lB+Lok8y8Al1hbL2/QEkc0iJXqEKrzoz8xWuodIrkxk
	 OJXZ0bEcVFRrEm376VIKEXHWNXY1lQ+ZhiSSLBCox6gYcn99aIEB4AJRRmrg3uej3g
	 u93B3wQAyjoexnEROMADpXqHVZ5N8c0kutmbShy45/1ABSeQsP6KoXPWhKEKzXRnMW
	 McZxHNnpdyW22tiSBVHrW7NzlsxdEcGCbjZVdDaSXVYfICTvhME+ge9IJ2nUdfsGw+
	 ATLY6FcNj7U0dZKHBzTKWfXTIpGXRd9hk9eXgbzntYDZsJMJVuxfKgFSSi9Hc26ok7
	 ONRr8Bfsi0n0w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 04 Mar 2025 15:21:10 +0100
Subject: [PATCH net-next 3/4] net: airoha: Introduce airoha_dev_change_mtu
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-airoha-eth-rx-sg-v1-3-283ebc61120e@kernel.org>
References: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
In-Reply-To: <20250304-airoha-eth-rx-sg-v1-0-283ebc61120e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Add airoha_dev_change_mtu callback to update the MTU of a running
device.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 54a239ab10aaac4a7bfc52977589415936207962..f3a61879e284a7ea12d0ebde2b993f2247cd35d9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1705,6 +1705,20 @@ static void airoha_dev_get_stats64(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
+static int airoha_dev_change_mtu(struct net_device *dev, int mtu)
+{
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_eth *eth = port->qdma->eth;
+	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
+
+	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
+		      GDM_LONG_LEN_MASK,
+		      FIELD_PREP(GDM_LONG_LEN_MASK, len));
+	WRITE_ONCE(dev->mtu, mtu);
+
+	return 0;
+}
+
 static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
 				   struct net_device *sb_dev)
 {
@@ -2400,6 +2414,7 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_init		= airoha_dev_init,
 	.ndo_open		= airoha_dev_open,
 	.ndo_stop		= airoha_dev_stop,
+	.ndo_change_mtu		= airoha_dev_change_mtu,
 	.ndo_select_queue	= airoha_dev_select_queue,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,

-- 
2.48.1


