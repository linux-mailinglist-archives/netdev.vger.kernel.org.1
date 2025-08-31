Return-Path: <netdev+bounces-218571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCADB3D4AF
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 20:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8583176298
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893DA2417C6;
	Sun, 31 Aug 2025 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="HjlbWOfg"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029720CCCC
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756664453; cv=none; b=PbOftYOKJsLvXO/lOJH29XpZvztTE4A3dwuU1T59T9s07lJzM6RWesCs4/JRaJTGzC40RbN3ADALQP9eBnDkap6LJF0tnShcNdiLfn0qKeXqV2CTFR8HIfrsmMD+HaLV54urOhoN5xHeexDkmqYnLM0aR5OhAE6oKhWwoBRRtCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756664453; c=relaxed/simple;
	bh=xU/FKwzEX2KM2xNbYvg4p+FRuTsuNod8K1pMTzvLv+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NZ8ygJ2Uw/1oT69YL1O76F5qQY+FlUJ3IKxLvKdH5zHuqAJCSRJZxEdEJN9PCt9VHW+VWAAQy0Um3EyZRdi97B1DGLCU5U/Ce2rZWCB5J379Kh+2zIY6PAYCdsB7DTbeJjNzt03Syjjx7LcduCcrQQv5isrG3fDAfvpSETedn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=HjlbWOfg; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wAVsVDob+0m0RfhC+kwtVS7pyYcYjkPPYGb/5fbXcxw=; b=HjlbWOfgcr06NlbPqxWedujDV5
	fsws6pPKvOfMT92q14TJvpt4q/vBdZqYXJ1oWA4Ucu3CW63Ib3T9Q68FOP2wxD3IhDvnzNUKSNMZU
	x0DM835l/uBiCaqTlSGq8DSj+/GyA3A01+5UHpMzVZClzR8AgCHPX6tP0pVgk0X03dsQ=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1usmeu-00HaAs-2T;
	Sun, 31 Aug 2025 20:20:08 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	hacks@slashdirt.org,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Michael Lee <igvtee@gmail.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix tx vlan tag for llc packets
Date: Sun, 31 Aug 2025 20:20:07 +0200
Message-ID: <20250831182007.51619-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending llc packets with vlan tx offload, the hardware fails to
actually add the tag. Deal with this by fixing it up in software.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Reported-by: Thibaut VARENE <hacks@slashdirt.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 5a5fcde76dc0..e68997a29191 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1761,6 +1761,13 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool gso = false;
 	int tx_num;
 
+	if (skb_vlan_tag_present(skb) &&
+	    !eth_proto_is_802_3(eth_hdr(skb)->h_proto)) {
+		skb = __vlan_hwaccel_push_inside(skb);
+		if (!skb)
+			goto dropped;
+	}
+
 	/* normally we can rely on the stack not calling this more than once,
 	 * however we have 2 queues running on the same ring so we need to lock
 	 * the ring access
@@ -1806,8 +1813,9 @@ static netdev_tx_t mtk_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 drop:
 	spin_unlock(&eth->page_lock);
-	stats->tx_dropped++;
 	dev_kfree_skb_any(skb);
+dropped:
+	stats->tx_dropped++;
 	return NETDEV_TX_OK;
 }
 
-- 
2.51.0


