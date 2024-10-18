Return-Path: <netdev+bounces-136871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFB9A35AC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C45A1F22B1F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10618871E;
	Fri, 18 Oct 2024 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H96QUNf1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561F187FE8;
	Fri, 18 Oct 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233627; cv=none; b=fQWRxyDvKwQLcWFuozZt924LUQ2OeiBTUDbDyy0VS8OyB8EyBqQVze+uTKlTzXmid0rlgY9ZXgY86VgcIx7lX7umQ3V5Mwpm5HnVCZBgwdf6ELvnYjqrLlJY4KZJhKlzurdogctTk4Lfvq1dfMBaaPpGoUmxdB22bpwRwd3FOAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233627; c=relaxed/simple;
	bh=NWg2ucQMEXkdG/t0H6WMRiCw8WmY2G+BSx2umyPRAWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ts3gKARD5tkknzRU99ZY6ajtiUtzFmZw+3RR4ZghOuWRDUkDVhot+cFopQbmtEURI07Dvh2c4TtffyWVuyS+jxOokf3BQDEfT9khOgHAUQWWhd4ZDlZa8eBRHDimi0jTdiiREllWzytY0zanU29+EVNER3PwMJQwmTxZnasY9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H96QUNf1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cf6eea3c0so14395345ad.0;
        Thu, 17 Oct 2024 23:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729233624; x=1729838424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAXwTR66yAILUnUD8iXKY4J9SzL8DhxXJKiHt0S8h0U=;
        b=H96QUNf1eGy9f0/ZN0Z7aUAlClxKZxgJvXuPQxQOmahd82qeDevgH/TU6rzzakp1aC
         5ERruThPJnob6+m5dT5V07EqA+spdW6u+cqR6RFtE4Ur/6e5TgXKz28AfjI0QeAz/0Am
         U6xJ0Mu2MF5kZ8V1gxUjwUGRkfzxa83+PuGIbmz1UZyBua/s2NC56LKw2x1Nh95twmM6
         znbzsEZRGAEmhJ60Sv/NLExrRjPgIBKlCrjNOeq9sleZ/q3kuBGkRbpzSTsseT5eqPQe
         yptltweCGhOwxniytjgR5+z+F552YKRW6wMaFMDoxO6n1DOVXi3gPElsfM0AS3H0tzVA
         VkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729233624; x=1729838424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAXwTR66yAILUnUD8iXKY4J9SzL8DhxXJKiHt0S8h0U=;
        b=iJS7N/1FRkdiwi6b/+225fiTAOEH7+TLQa0vgMYV/ZlnT3QPc6wXedMR6FzGc/2X/G
         HOrfMetRFS2CJIIEGmotaJRknEnk+7lVrfgXmne2fFFhsgshEZ0BjnQvpQrL9i1AfPm9
         GVVyh0AJahK6MgYkvncQWdiRWdW0K1URymfJfE6+c5pndawNK7WagyIGaadKIXCfwks9
         7kRyQ324+UV42+AAia3MtxnAWfKHpFFwNs0Qp6wCrJPw79RLFqemQw3bbSPxxlph9uvH
         v4cxjvTjEg3QR1fkd1cmJMleUH+OQA2BWxkMkwv6zNnVOyGBH+ChsNjOKQetB2havGyn
         rQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCX3fXpsV0m4y/+TVCLH9ZIhktzgjzTpTveClDmYDkq2ppyhHygVchC1ezKagi4HPDkmgoxapop9MuIS07o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLR1ry5RxuW61XE2wK2QTUVl03sPxmkUzutlFq3r9Mjadpnlqu
	CRDKvDfJIKTKuDkhUtAKXLy0wEEiAtCMWzuzRCdytqLLHoskSq9MgsJqYg==
X-Google-Smtp-Source: AGHT+IHFQ90ihWqPYEL7Ct51SslG3VL9y32CIIVvGJDd5cHSgLsXcnYM+ZbtTXhZ468ZOJA50p73OQ==
X-Received: by 2002:a17:903:32cf:b0:20c:5e86:9b5e with SMTP id d9443c01a7336-20e5a719f37mr18587745ad.3.1729233624372;
        Thu, 17 Oct 2024 23:40:24 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a74766fsm6285455ad.73.2024.10.17.23.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 23:40:23 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 7/8] net: stmmac: xgmac: Complete FPE support
Date: Fri, 18 Oct 2024 14:39:13 +0800
Message-Id: <1776606b2eda8430077551ca117b035f987b5b70.1729233020.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729233020.git.0x1207@gmail.com>
References: <cover.1729233020.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the necessary stmmac_fpe_ops function callbacks for xgmac.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_fpe.c  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index dfe911b3f486..c90ed7c1279d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -373,6 +373,78 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr,
 			     &dwxgmac3_fpe_info);
 }
 
+static int dwxgmac3_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
+{
+	return common_fpe_irq_status(ioaddr + XGMAC_MAC_FPE_CTRL_STS, dev);
+}
+
+static void dwxgmac3_fpe_send_mpacket(void __iomem *ioaddr,
+				      struct stmmac_fpe_cfg *cfg,
+				      enum stmmac_mpacket_type type)
+{
+	common_fpe_send_mpacket(ioaddr + XGMAC_MAC_FPE_CTRL_STS, cfg, type);
+}
+
+static int dwxgmac3_fpe_get_add_frag_size(const void __iomem *ioaddr)
+{
+	return FIELD_GET(FPE_MTL_ADD_FRAG_SZ,
+			 readl(ioaddr + XGMAC_MTL_FPE_CTRL_STS));
+}
+
+static void dwxgmac3_fpe_set_add_frag_size(void __iomem *ioaddr,
+					   u32 add_frag_size)
+{
+	u32 value;
+
+	value = readl(ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(value, add_frag_size, FPE_MTL_ADD_FRAG_SZ),
+	       ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+}
+
+static int dwxgmac3_fpe_map_preemption_class(struct net_device *ndev,
+					     struct netlink_ext_ack *extack,
+					     u32 pclass)
+{
+	u32 val, offset, count, preemptible_txqs = 0;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 num_tc = ndev->num_tc;
+
+	if (!num_tc) {
+		/* Restore default TC:Queue mapping */
+		for (u32 i = 0; i < priv->plat->tx_queues_to_use; i++) {
+			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+			writel(u32_replace_bits(val, i, XGMAC_Q2TCMAP),
+			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(i));
+		}
+	}
+
+	/* Synopsys Databook:
+	 * "All Queues within a traffic class are selected in a round robin
+	 * fashion (when packets are available) when the traffic class is
+	 * selected by the scheduler for packet transmission. This is true for
+	 * any of the scheduling algorithms."
+	 */
+	for (u32 tc = 0; tc < num_tc; tc++) {
+		count = ndev->tc_to_txq[tc].count;
+		offset = ndev->tc_to_txq[tc].offset;
+
+		if (pclass & BIT(tc))
+			preemptible_txqs |= GENMASK(offset + count - 1, offset);
+
+		for (u32 i = 0; i < count; i++) {
+			val = readl(priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+			writel(u32_replace_bits(val, tc, XGMAC_Q2TCMAP),
+			       priv->ioaddr + XGMAC_MTL_TXQ_OPMODE(offset + i));
+		}
+	}
+
+	val = readl(priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+	writel(u32_replace_bits(val, preemptible_txqs, FPE_MTL_PREEMPTION_CLASS),
+	       priv->ioaddr + XGMAC_MTL_FPE_CTRL_STS);
+
+	return 0;
+}
+
 const struct stmmac_fpe_ops dwmac5_fpe_ops = {
 	.fpe_configure = dwmac5_fpe_configure,
 	.fpe_send_mpacket = dwmac5_fpe_send_mpacket,
@@ -384,4 +456,9 @@ const struct stmmac_fpe_ops dwmac5_fpe_ops = {
 
 const struct stmmac_fpe_ops dwxgmac_fpe_ops = {
 	.fpe_configure = dwxgmac3_fpe_configure,
+	.fpe_send_mpacket = dwxgmac3_fpe_send_mpacket,
+	.fpe_irq_status = dwxgmac3_fpe_irq_status,
+	.fpe_get_add_frag_size = dwxgmac3_fpe_get_add_frag_size,
+	.fpe_set_add_frag_size = dwxgmac3_fpe_set_add_frag_size,
+	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
 };
-- 
2.34.1


