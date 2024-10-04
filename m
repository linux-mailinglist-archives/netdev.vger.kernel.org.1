Return-Path: <netdev+bounces-131964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DE9900C9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED26F285E90
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 10:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF9314BFB0;
	Fri,  4 Oct 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zIciZWcJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CC137903
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037283; cv=none; b=UuA3aAlcdaojZ4XtuTqzNGzZv7chobX5KZKlaRoBU9vUOT3s3KsQM9oGxGljkBYQW114LKP04mz8ISgw9alQ2ei5jomiND59QVoCAp61g387bxQSFzSSU+ninzBFoc/GtMzGLGmLPzid4enMM/G2/gO2bf+PzgjnS2nfiA7AykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037283; c=relaxed/simple;
	bh=Fhp/GmVuaNZVUwOvgvmXGwAfsWReWoiwaIq8FSLPaq4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XItaz9ctFet4/HRSre2SvfJleDUQHe70OhzMjuZEUfj2XljLiQTMovqf6Q0feTNDx2qozOCZpedxFe0wAN1zOLs822dN9+ZGL83fPTISo2rgNMFQdMHMUHZF0d12VSYpGehzmubiyNhc4/9xY7Xbg127NQog5bD+LcQUD0k8PU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zIciZWcJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m9oh1PhzOsMruHoTr7GKJZbx7Eu50PYYTv0Q1dbO6m0=; b=zIciZWcJO5Ff0np2S4rzpG9bla
	0YQNLfdQ7+Au8zeF+eQ2ybzYjG6366+TQTvZllb5wG17MEb/60qUYiocwjFgkzlZJr38bt2c5ObPG
	WlAltHttNNHpaoW/UHhco0ZXq8pz7A/vj4cJVOrXS3Md9StvZkWX2d/pnB4DYxqmAZxC5rGAOSrhE
	WBAQkuYS+WwfmLnqhsy3xtLcuC2L+cfss3bnWHyr+m0XbBHKVto89mEWd4J5SO0diIhr8FMqWi1BQ
	xpcSd0gLAEoGZZnMe4q2SPdwiJ6luUjJltNxUW9O9Vs+wreLvUOeR40SZQO2Oj0dbwNLTLM6KVIGD
	d9l+TpGQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35160 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1swfQn-0001gt-1r;
	Fri, 04 Oct 2024 11:21:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1swfQj-006DfO-QQ; Fri, 04 Oct 2024 11:21:01 +0100
In-Reply-To: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
References: <Zv_BTd8UF7XbJF_e@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 05/13] net: pcs: xpcs: move definition of struct
 dw_xpcs to private header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1swfQj-006DfO-QQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 04 Oct 2024 11:21:01 +0100

There should be no reason for anything outside the XPCS code to know
the contents of struct dw_xpcs - this is a private structure to XPCS.
Move the definition to the private pcs-xpcs.h header, leaving a
declaration in the global pcs/pcs-xpcs.h

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/pcs/pcs-xpcs.h   | 18 ++++++++++++++++++
 include/linux/pcs/pcs-xpcs.h | 18 +-----------------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index fa05adfae220..1b546eae8280 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -123,6 +123,24 @@
 #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
 	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
 
+struct dw_xpcs_desc;
+
+enum dw_xpcs_clock {
+	DW_XPCS_CORE_CLK,
+	DW_XPCS_PAD_CLK,
+	DW_XPCS_NUM_CLKS,
+};
+
+struct dw_xpcs {
+	struct dw_xpcs_info info;
+	const struct dw_xpcs_desc *desc;
+	struct mdio_device *mdiodev;
+	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
+	struct phylink_pcs pcs;
+	phy_interface_t interface;
+	bool need_reset;
+};
+
 int xpcs_read(struct dw_xpcs *xpcs, int dev, u32 reg);
 int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val);
 int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg);
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 868515f3cc88..b5b5d17998b8 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -21,8 +21,6 @@
 #define DW_AN_C37_1000BASEX		4
 #define DW_10GBASER			5
 
-struct dw_xpcs_desc;
-
 enum dw_xpcs_pcs_id {
 	DW_XPCS_ID_NATIVE = 0,
 	NXP_SJA1105_XPCS_ID = 0x00000010,
@@ -48,21 +46,7 @@ struct dw_xpcs_info {
 	u32 pma;
 };
 
-enum dw_xpcs_clock {
-	DW_XPCS_CORE_CLK,
-	DW_XPCS_PAD_CLK,
-	DW_XPCS_NUM_CLKS,
-};
-
-struct dw_xpcs {
-	struct dw_xpcs_info info;
-	const struct dw_xpcs_desc *desc;
-	struct mdio_device *mdiodev;
-	struct clk_bulk_data clks[DW_XPCS_NUM_CLKS];
-	struct phylink_pcs pcs;
-	phy_interface_t interface;
-	bool need_reset;
-};
+struct dw_xpcs;
 
 struct phylink_pcs *xpcs_to_phylink_pcs(struct dw_xpcs *xpcs);
 int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.30.2


