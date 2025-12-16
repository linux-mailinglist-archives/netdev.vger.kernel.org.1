Return-Path: <netdev+bounces-244994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1442CC4D71
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA33930F55DF
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D129C33EB0C;
	Tue, 16 Dec 2025 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="i5nHNCah"
X-Original-To: netdev@vger.kernel.org
Received: from mail102.out.titan.email (mail102.out.titan.email [52.45.239.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A233554B
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.45.239.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765908237; cv=none; b=ssZiYsmQSX90zSGHofl2QQWq/QALnDFGTscCe2SuMWRkH10RrgfkRpDTJMQA3xskSG2ZcMPT/5U3tsHWzxik/pSgWxZ3d+MhVmnjoMVXwyiXImoZT38Pml0wgc7BfxOtI80c1hFgQ4UFzxqWHPFJVwwGpN5d5y6FYv9I4PM/UZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765908237; c=relaxed/simple;
	bh=6NJ4QGWQlriE4UJw51AEavMvHJyyg9wuWwNA/m2aGOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+utsQPVFHJSJR0vgnhTNAI/sSWWZz9F4KPffHrgoRtNT42TcB05YwO/gNQ810kxpO+zk43vIn3BJZyFFkAb4o7PY4SX6nLSgyiug8OCCj2Fjh994+BvZb/WC8M4o84W2CRjbLSSd36wgmT33ute83p+o/rWoS0WXw+/PtnD9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=i5nHNCah; arc=none smtp.client-ip=52.45.239.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dW4Yk5vxnz2xMn;
	Tue, 16 Dec 2025 18:03:54 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=CDawo+fF0LESR9TpJ+UYGDKMkCrwqrs00DCR3DiPQws=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=references:date:in-reply-to:mime-version:from:cc:to:subject:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765908234; v=1;
	b=i5nHNCahqOiglhBMjW/L3/G1AmyioAfYDdeDmrHwWMLYev/ESTtK4dQmRdKubF2b72ZWs5T2
	o1cvbh3wbJ2Tm638uU2VRfoVBlTg/8nY8/q5ipZt60YhITIqMCegI3smXAvI28Sydihxnv96E7L
	Bbk7OsvETr4U524QfkAzzpEU=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dW4Yd2Mx5z2xNX;
	Tue, 16 Dec 2025 18:03:49 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH net-next v4 1/3] net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
Date: Tue, 16 Dec 2025 18:03:29 +0000
Message-ID: <20251216180331.61586-2-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251216180331.61586-1-me@ziyao.cc>
References: <20251216180331.61586-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765908234689110305.27573.9134173884844574602@prod-use1-smtp-out1001.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69419f0a
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=NfpvoiIcAAAA:8 a=uCHZyEKV_PbTw5-4gUMA:9 a=HwjPHhrhEcEjrsLHunKI:22
	a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22

YT6801's internal PHY is confirmed as a GMII-capable variant of YT8531S
by a previous series[1] and reading PHY ID. Add support for
PHY_INTERFACE_MODE_GMII for YT8531S to allow the Ethernet driver to
reuse the PHY code for its internal PHY.

Link: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/ # [1]
Co-developed-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 drivers/net/phy/motorcomm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 89b5b19a9bd2..b751fbc6711a 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -910,6 +910,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
 		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
 		break;
+	case PHY_INTERFACE_MODE_GMII:
+		if (phydev->drv->phy_id != PHY_ID_YT8531S)
+			return -EOPNOTSUPP;
+		break;
 	default: /* do not support other modes */
 		return -EOPNOTSUPP;
 	}
-- 
2.51.2


