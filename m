Return-Path: <netdev+bounces-243349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BCC9D80C
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 02:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80DA4E0115
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 01:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F731F4181;
	Wed,  3 Dec 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YkOWFUDg"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AB1E3DF2
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764725531; cv=none; b=BbQf3P0dHgzkKZkGWP6zktrPTfS4JOCu05Pjodh5pHjVKIcXPXAsuChtLA1lrDjzVGfZnwH77nBgBW0er67uGmo4f0kGlZ+D+CZOYPD4N/FOcYW0cu7lugzAI+sALL2E//46amMvyAi6pUmhryozLtcCbSAvWeEt1ZStJY9X/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764725531; c=relaxed/simple;
	bh=ifTG2EWkHu8F7pe0skh6hT195ZLD9h+pqfEjF3OKTj4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XJX+1rreML+H2e9cxBTM52eXlovUMukMdU04MBz7bhHXsbgZT/UvG9wEPSw+fBfKi3Dkl3Wga3bU6JUt5ZlOoiUvAhXSJQiNTsPqd4M+yI5xNP3jZmSBY70xiT57/q+IArDYgvvQzpfZ2NDFyxrbCOIwQjuTnjfRbqCuIP8MpHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YkOWFUDg; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764725517; bh=FgD4FVBsIZc/lJgWx44TSx1/rV+CY/xX0o1zBduphyg=;
	h=From:To:Cc:Subject:Date;
	b=YkOWFUDgoY329RdApQMaJfZissAdj/pwiDYdy5eM31fjtKOn6hcMGilwu3Fzi3RnB
	 rFOALpCZOYJEpPLWW2hSsWhnCUvrz18E86yvB87Uhgb8S7wL1YRub6wJfiuhWvy8DL
	 CP3iaSL5czzKH9Y19ODiIQoKKaKkPxBI2a/10Xd4=
Received: from localhost ([58.246.87.66])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 7F7B4684; Wed, 03 Dec 2025 09:31:55 +0800
X-QQ-mid: xmsmtpt1764725515tevgm4er9
Message-ID: <tencent_639FC431D959DA3E8FC007985FC88EA5A90A@qq.com>
X-QQ-XMAILINFO: M07Ulnfy3VHKVnABMxCOZ4Vj1SFpQK+ANJvNR9/RsY3dnBXHnxT/POhN78hogO
	 /MMywCcjYH3yAIEjAwzwA81HZaP9GrnFzp1bqdb9Wgs8y5S1rRchqkbzRMFDqfu/bPmsE7yK1QKy
	 3heICWirMQ+63WnqaJMBlDs7tsaJWgZ7ke6KcSm3+kkAZEbCSLEZKaDLXfg+kctph1WgNYdVocWJ
	 d+URF5SNp7WDk5+4ewcALjulP+mneOqRv0NTtBo0iG3TFQTo2/OwczD/03tb7C49E9azwCwCO8ta
	 zTh88G+HnCHfKGcCvspNlF6IRss5E0OA6Po4ynJHU3buEH51ZkASzm3lKV9LEcQe+Zb01qpuwfHn
	 +2z8W+mpaPJfZe45AbE2ofhhEy4Dc+blrPooQyH0d9DajoKjUAnuWPi5+fhzfjoAzVkZ4uIZuBo1
	 ys/OwjTXsaIy+RJ1rT26/B6EofTfIfSd/+x0PLOeiyPaZ0g2KyGqB3KjAn7k+zVJnviIoOCO+b4W
	 9/6prNXmraM5HvPcWRtRkCHnRbpSkYhcCtQPJ4ZUOVA1QAu4Vh4WWNPkrYfhXjcJJHdb/K5kuwkr
	 CjeV+EES5jW3WNWQ2OWO3/Nm/iK1jUjezyJR4UbZpXw2dFtjxo+Rr6t1hKJ3sNynLLLPNaJOkPog
	 tCmbUclzH0I12lWiqVPMYTSvQ6Hp5YE02arlWNcMyd2oPx6EahFiSxBjCJG1G5RsjqSHSXw1r8NA
	 Y3DmS6GLsPAh+XvGL3cyDjIsEzUEKE7dO1QgZkwxXHNqsLcxDRDgqXrUy2PJ173INXa50JWUz4Hn
	 BDlR7w8MA/fh43QcoOEabD52JtciPPIwaxKDLltAxqag5Y5G2P6HMzpF1io7wfWiQey5ilyHB3oW
	 hjYwRCIiBFAtTCmHnyN1f9sqzPVjPBnu4qnKSqL63eR861Mw/ITdnZJETLMpaEZ4YO0rYVq4QTi5
	 QwEw7thDoOTA0f9Qqw+e+9Pfb69qC+
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: 2694439648@qq.com
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	hailong.fan@siengine.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	inux-kernel@vger.kernel.org
Subject: [PATCH v3] net: stmmac: Modify the judgment condition of "tx_avail" from 1 to 2
Date: Wed,  3 Dec 2025 09:31:52 +0800
X-OQ-MSGID: <1f65707a427512e7b549809ec40286fb12b4c114.1764725087.git.hailong.fan@siengine.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "hailong.fan" <hailong.fan@siengine.com>

Under certain conditions, a WARN_ON will be triggered
if avail equals 1.

For example, when a VLAN packet is to send,
stmmac_vlan_insert consumes one unit of space,
and the data itself consumes another.
actually requiring 2 units of space in total.

Changes from v3:
        - format commit message
Changes from v2:
        - add fixes tag
        - Add stmmac_extra_space to count the additional required space
Changes from v1:
        - Stop their queues earlier

Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload")
Signed-off-by: hailong.fan <hailong.fan@siengine.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b90ecd3a..9a665a3b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4476,6 +4476,15 @@ static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
 		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
 }
 
+static inline int stmmac_extra_space(struct stmmac_priv *priv,
+				     struct sk_buff *skb)
+{
+	if (!priv->dma_cap.vlins || !skb_vlan_tag_present(skb))
+		return 0;
+
+	return 1;
+}
+
 /**
  *  stmmac_xmit - Tx entry point of the driver
  *  @skb : the socket buffer
@@ -4529,7 +4538,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 	}
 
-	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
+	if (unlikely(stmmac_tx_avail(priv, queue) <
+		nfrags + 1 + stmmac_extra_space(priv, skb))) {
 		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
 			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
 								queue));
@@ -4675,7 +4685,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		print_pkt(skb->data, skb->len);
 	}
 
-	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
+	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 2))) {
 		netif_dbg(priv, hw, priv->dev, "%s: stop transmitted packets\n",
 			  __func__);
 		netif_tx_stop_queue(netdev_get_tx_queue(priv->dev, queue));
-- 
2.34.1


