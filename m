Return-Path: <netdev+bounces-246044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F468CDD6C7
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 08:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46EC6303FA72
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4792F28EB;
	Thu, 25 Dec 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="BIoRQVjO"
X-Original-To: netdev@vger.kernel.org
Received: from mail6.out.titan.email (mail6.out.titan.email [3.226.109.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C352F363C
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.226.109.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647616; cv=none; b=ojJWYvoHbiUWF44IMIwoqyEwuJJs3hHCJ31n6w+TFBgwNnHEO0HTYxXoPvi0kXcBL40/0dQ6UtprIdDTFz+0Yd7gcCUuR1dbJv7BLUJIp6xROdxhEoBTAk30Mx0/rS0Pug+scNz92h41TqRcrcwlwDCzIXaMb9M/NWJ0NRljE6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647616; c=relaxed/simple;
	bh=vJsXWI0fYsWoc0Z/xAAKyK+Q7tFUD345MbtJ/RwQvn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvCjkIUIKeNAUixW1zCovWKGiEXr7fEblIssJViyBk8DdAgP/f5w+0iZeRqqxla1rtM8WVsDLJPwMKDiCYWbRx/81C2GM1q6TLAC4gr/cB4JHDgF6EXjdu2YQiHBCC6TnDw5lujBwjjZTLu5ecDJhEjKPepXREVKBPGf6wdVg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=BIoRQVjO; arc=none smtp.client-ip=3.226.109.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dcKrW1Wycz7t9Q;
	Thu, 25 Dec 2025 07:19:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=a7mwss2zUTWHrGu/W0jn+kAqkcl4B3JbKYGDTqhMoKE=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=message-id:in-reply-to:references:mime-version:from:cc:to:subject:date:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1766647195; v=1;
	b=BIoRQVjOukSUr8uDpgeXbHrgDwlpEDvHHmQN8Z+oqnDdEghudcujFBOphGF6arq3Ad+vUnjC
	THuWAfTjWtp3TnW/Ilh/Ye1Py9YW7AH2QoyiOa69HwbI0BORKIeclAWiy75dRAjDw/WnKu54LYI
	KtZg2uYw0nloa5dkO5ty+Kz4=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dcKrP5V87z7t9N;
	Thu, 25 Dec 2025 07:19:49 +0000 (UTC)
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
Subject: [RFC PATCH net-next v5 1/3] net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
Date: Thu, 25 Dec 2025 07:19:12 +0000
Message-ID: <20251225071914.1903-2-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251225071914.1903-1-me@ziyao.cc>
References: <20251225071914.1903-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766647195062456277.30087.168411733287155282@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=694ce59b
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=NfpvoiIcAAAA:8 a=0_qlMWoZVofwMTi4AHUA:9 a=HwjPHhrhEcEjrsLHunKI:22
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
index 89b5b19a9bd2..dc9569a39cb4 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -910,6 +910,10 @@ static int ytphy_rgmii_clk_delay_config(struct phy_device *phydev)
 		val |= FIELD_PREP(YT8521_RC1R_RX_DELAY_MASK, rx_reg) |
 		       FIELD_PREP(YT8521_RC1R_GE_TX_DELAY_MASK, tx_reg);
 		break;
+	case PHY_INTERFACE_MODE_GMII:
+		if (phydev->drv->phy_id != PHY_ID_YT8531S)
+			return -EOPNOTSUPP;
+		return 0;
 	default: /* do not support other modes */
 		return -EOPNOTSUPP;
 	}
-- 
2.51.2


