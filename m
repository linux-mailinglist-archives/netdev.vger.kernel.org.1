Return-Path: <netdev+bounces-241265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52BEC82119
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E663AEE53
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15993319850;
	Mon, 24 Nov 2025 18:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0AF2BEC3A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008356; cv=none; b=Jdt80UdssANSyP058O/j4cK6XKoPvWuZQbzIgMja+PUWquYfJTYZP9w5QavjGZ/2ZS/zaTHQceoLQkjGfhV6BToTS6xiMohalEFCg/BNk1nKqSGW50xe9hiFXFK0lZsdb4kcHa26ypbd4+h7S3yjI4IwRLnkyM5LQvuvLXOfu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008356; c=relaxed/simple;
	bh=rL8W2AoR2IUzqeEYR3E8MpD4GwZ6IgyxiHP0qiXIJm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MeALtV/dU8xuMkswdcJBJwqzLgx/oCBxPO/jA/y6hkUAChoG47Ilxk6hCNAnyu/R5tvkUmytAI79754Gk+6vDRf2sh+2fqlHj7cc2prMQ1Rv45y6yLQ0w9+IPVjrBtuxajznD6Sd79VjuMfmQq/8ZKYgcnV23vyJjE9txxjz6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c7533dbd87so3304495a34.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008353; x=1764613153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3DxjUqbIL2xCh1eBwG3gbSSaebFppsbY/iTXLQi+/Eg=;
        b=loRlKvDciFNFf1dfNKDO+h/pw/+V5Yq96yMnVaza/z4q2NoTrFUX91XzF4fwvQ987o
         lPMZpyZLKfFb9vXCPydVgw7Fb5ewJAcfHKXu91gh5ijGwfW8bx0P3wfaG8oadGiP2vnO
         xDTLkYQ4yyphMve6nzQebovRH2p/GlP82QGIfxJzlMQFAp5Wr3VZibLNu7MEulkTT/ra
         ql7R0oxtcw3WyGPTyGZLtyrAINRtcz7DAv5o/16kzgg5d6gJv2biz9HLnqDQTISsiTZR
         je83YmzKs12/2paRS8qgiCzS77mvhQP/Tth+1t/WShOWX1/hpVQuDCj5DQdcY8M5h7Dp
         iZWA==
X-Forwarded-Encrypted: i=1; AJvYcCW4QOWElkvPS+uZL7mPxfil0TlWw9rV4JFg68HQCffDEmO6dv5jeM/ez2oNpqKg8upk0qDaTx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl44I3VXYs7i2I9k+8WHVoeX/yMizzlVM29c1NYBb2RXAzPrEn
	Ila+M61cpPACNToBk02i9xNVTkm/7TqPq22pIAc5QsWv70oBXM9s8XvO
X-Gm-Gg: ASbGncsfDUJGhWQUpdgNjMCW4T0aMzP8lvLR243/gcRgzsC6+bPGvEg7BI17xWflbTN
	G7IzVqbn0V86uusF6e7JVNtZz+cSbRbL/VN/TRkA8D7v2tbe4RlW5Owg7ewoJlys/Q4I15McVY+
	Rt5dSSX3KZlnwfoDkHVS57wrgR5uP51SUoWnlZz+GVWcSKJVcbkWgikoZLcirSwWwGwEk9NId3H
	SkpWJJl9eh0i2b9UeFfMh32R0EOrTJZLVzmJbUKBTC20l5NOP0C88PSldONETCqg+gbuWGljHs4
	iJoz6zdavkQOxb2PZsVq6+Nk+cRjx2l43BvtOk/FVZ5UwHyNcUR9ymCVFafxxLFP66GRzHWoasI
	ryhOGy584kuTNNDVFhLAIAGc1+R07qjp2Ev5IbUIniMR1ua700XgOfrsz0vUj+tOUNTZ+pdB63T
	qMoasWjrDqJFLs7DzBBSfthhLE
X-Google-Smtp-Source: AGHT+IECk7Ln47cP16adw4wOskOF4KXnTNhYGD1bWD/JnrhKyswVQFDUvxWKWTLtQ5ty3hPw0t7hxQ==
X-Received: by 2002:a05:6830:4126:b0:7c5:2dbf:4a83 with SMTP id 46e09a7af769-7c798b57480mr6345439a34.2.1764008353184;
        Mon, 24 Nov 2025 10:19:13 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d428edfsm5574340a34.31.2025.11.24.10.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:06 -0800
Subject: [PATCH net-next 2/8] iavf: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-2-89be18d2a744@debian.org>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
In-Reply-To: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com, 
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120; i=leitao@debian.org;
 h=from:subject:message-id; bh=rL8W2AoR2IUzqeEYR3E8MpD4GwZ6IgyxiHP0qiXIJm4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGdTid0yKtX8UI5tUw/o0nWkUiR+7FBRZut7
 CSlKqZWFZGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnQAKCRA1o5Of/Hh3
 bV2BD/4hPBomVHir2/nBbEv+rFXtri6Sx/XGCuYkhH6dGgIJwIcvP0UxRIL6z9OtM2CqcpXyPRM
 7yo5U6TJ3Iv4//Mkb+6TBbOhmeL1VQzpCEEfCUzX2YadpN6j3DG2ceJ+iDLtZX1iqH38Fi1IR5Y
 qwC9xe67zhK1A6KNMqBWeFj1ADKYvQnxXH4IeoEZaAX6dcueHNARjVgOLaLvLWqoPGo0lmj7HPY
 Rpod5w9B0rTvDWCqK760QZ2wTfiNOlnTLPnUFZCyxe4hXK+kZTmxvGDeoS4zOvKgxkYo3NlTpFp
 lfUR0XceRdll/Px0u/54ZhxNivCQpgyqOatLIJ3IMdp2rbqDg5+qMpF8MJy/HLq8nYE8Wvq5+A7
 ymaVEKsgKzoJwFca8tqBhT3D3AU895ND0Ci7hhYfwrXofmIp51kf/HZP99a2jV73BHtlEyqZLA2
 6mchVlo/igJ0i4yUUtUveknvtJFd6IG4RjulW2ZGcSAqimfQDdY+XloMn/WA0Z/R62ftVnt+4jR
 PKIDeRF0Mbvba0393O2naNi9rne734ynBNmC8e14F6OxotFV0n0saSPWcxQknVFCNx1CLvXa8UK
 Ou2iCep06agy/i1redH0sAz27F4hz5vyV5IpuL3C3S9rapd3XDAjjbzqpPaI4gEUyLardH3g3hn
 mzq4+b93/0ECGWw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns iavf with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index a3f8ced23266..08ff90e73803 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1638,6 +1638,19 @@ static int iavf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+/**
+ * iavf_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Returns the number of RX rings.
+ **/
+static u32 iavf_get_rx_ring_count(struct net_device *netdev)
+{
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+
+	return adapter->num_active_queues;
+}
+
 /**
  * iavf_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
@@ -1653,10 +1666,6 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_active_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 			break;
@@ -1866,6 +1875,7 @@ static const struct ethtool_ops iavf_ethtool_ops = {
 	.set_per_queue_coalesce = iavf_set_per_queue_coalesce,
 	.set_rxnfc		= iavf_set_rxnfc,
 	.get_rxnfc		= iavf_get_rxnfc,
+	.get_rx_ring_count	= iavf_get_rx_ring_count,
 	.get_rxfh_indir_size	= iavf_get_rxfh_indir_size,
 	.get_rxfh		= iavf_get_rxfh,
 	.set_rxfh		= iavf_set_rxfh,

-- 
2.47.3


