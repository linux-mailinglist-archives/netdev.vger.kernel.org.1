Return-Path: <netdev+bounces-243170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E8C9A882
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 08:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 004383473F1
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F789302143;
	Tue,  2 Dec 2025 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ip4w5bLd"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F44F3019DE
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661460; cv=none; b=bye87Dy/3S9L5LLvKhohAzKXCvBunso+en1OSkOk+LgjJ2vgMFG2E1+Xs27Snm9OGHFqdQpTnyXo+WiyeHPoIykJoSKLAS+eXPHQx7fHTE8wbVuwCftfPPJJ0G56jv4oQdGNu712JeKKg144b7j/nVb/V1485hzxdT2dmo2BZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661460; c=relaxed/simple;
	bh=kgsvVFvytHbcmUbIorwmurKMpfEvUWHEoOciuaG+lxI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=sbx6P/3moxl26UYTOrI2S4eMzLYTKvI3sLFWnRSaH2OYObRL3FnlyrTn/ZK4oHi5whhZuwnBgeQLHwnRynVDUj11Ltwx5X7b9MfBivSusnIvsbCvHKjuVemFmRItVNoiXYmCv3I1VUCxwijKoU/JZ38yVpEha65D6wBxrD37bdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ip4w5bLd; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1764661443; bh=xVQzdkZfZGt6uJDP7MtoPwhfeFj+Xe0EF1rEE/XQ3xs=;
	h=From:To:Cc:Subject:Date;
	b=Ip4w5bLdnUd3sIXbK5C5pZX3Xw9j3t0f+312Jn3OPlWFD8Xz6K2c/Bx59CwVwN+Hf
	 PR2EDGl3OweMBBgPX2jyv5oenaeDvacZjR93SBTNggfhPguwaQ7idohLAeuroR9Ci+
	 ZbA9Ai5zYyVyUQSUVW9GhaRf6tF5LuPB+2kEcZCw=
Received: from localhost ([58.246.87.66])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id B0124C13; Tue, 02 Dec 2025 15:44:01 +0800
X-QQ-mid: xmsmtpt1764661441tygoogqk7
Message-ID: <tencent_4A0CBC92B9B22C699AC2890E139565FCB306@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJBX5SsFlQB+monRzvPtS7S73OadbW+wWoYUt0AmUJGPi33KBPGF
	 63YrYR66siDXxfWIj5oxLne/Y0Qki/NT0eg7sYqHKdvTKPqRZLPlXs5GzIunMxYL/VJGZ15naOqE
	 wrUeG6lThMt2q3JqMjEchfZBc2wu7EhJwB5y4bRG9HnbH+MQw06XeoAV0RU4OUIV9EPkn9ANDv9X
	 q88FM8NOmZqm2jm/vo+RKmANl710dEYMcgwSOe/eUxqdnG1unQjZwZOmo+m1+YcJRUVJETN+ZoVT
	 KGEFSVrU3grGLue/1uCDrVH+uKI7hgeYzpgsY+qdhN4L43iFdEA+GwybF440lMLSsb+q2fyJNmo8
	 pBs2auYEOFVYKogP2odanfvmGSw/Q/a0IEH0YzLGSxNtGu96cNmJgjbf64fUEif88IUtUjJb2o6j
	 YWTUHIwCx4Bdy1MmalQRRLu1x3e9EtW1Hf25WcAxtaIp+kJ2/Kg2fHAFEugNdHJGFHjyv+bLP4WX
	 W3orcMiG+iDrUrZWRjxlBczsMSqiXMaL1XZOGNrAmyAuEFhKfBjb0aJbaNziwb6ZXGfhjqOJ/Iev
	 KuC4NzEbkop6X+5Rv0A5mm2MKW8lNTbCxF7DZpUinIYeWeMQRn2uBwAq9u+Y8//lLPgO19siyAJj
	 M+eTP6+Zk7DKNfIMTtJxRRnAwQUdXB588BrR8o1VIf3ELNaa6l6BStWAkc1xeztBm10qnZYJ40dr
	 WNt4ujcL3chYUx0ikcUQRA78rBSioKxKjBywKiPIoLDMSd86TJf/UHkpCClWdQgaXRbQV2Z73oJh
	 Hm6g02ZKMwNROD9qHb6tS0hcWHEGP1nvghPE8AnZe9L7uj25q6xqzGoYJllxRlVzxjY3MWxuQ8Ho
	 vLEYZpKjn8fmcUIyskT98RnlcaoQpS/4Ksq6KREWo7CkFxyCq9Goea6ht5C092r+HjkiE73RYFlU
	 D4Td17sFPwOKxhaWEw/JasWyAfb+88RISX+U8RDc75xrVWL6ftQto5zbSZTU3RadcGPcZpnHFWB1
	 qkI3QBrw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
Subject: [PATCH v2] net: stmmac: Modify the judgment condition of "tx_avail" from 1 to 2
Date: Tue,  2 Dec 2025 15:43:59 +0800
X-OQ-MSGID: <406d20b7eff4afdb6b3f794e3597e7d0b4c34867.1764660952.git.hailong.fan@siengine.com>
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

    ---
    V0-V1:
       1. Stop their queues earlier
    V2-V1:
       1. add fixes tag
       2. Add stmmac_extra_space to count the additional required space

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


