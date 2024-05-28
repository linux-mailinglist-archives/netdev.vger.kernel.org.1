Return-Path: <netdev+bounces-98560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126588D1C19
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3544E1C23383
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6D16DEDB;
	Tue, 28 May 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6V1EhJmy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881F316DEA0;
	Tue, 28 May 2024 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901370; cv=none; b=KoE7mCatbBJXN9RHBHOcKXMf7nw+Kh07cbPm/OyLRE0vDpT9BXR5shT7y4Upqhnt/XCJQbQZwryBHYia1pdPRcoOapZvBu3Ho7xXQ3ajBEXckUiiapcN3mSpKz8Kp4FONWWLY+xMC71KP2JZhoX2HGQxR0EKYWgx7S5UmJsjyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901370; c=relaxed/simple;
	bh=BlS+RNoJZf7uRqH8yZdZgXZub+cVsj79b4zET2aARhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L63zuDOHKdshXj0GrTi93p+DJIcyUQQK+PC3BmTgZkLrPyZzDNK/Hn1TqmtEeNlngCAdCT8QwsB9ol95GKyI3D540CdoX0Ytphv7dYHxI+W/gRJZ2swiwq2NQrbEVzobBfZIZjTywPx6UBcwGgM0ZuGFSRUey4YGYiM6Nodc2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6V1EhJmy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+woYX1uxkRDOXtBX1F1Aj3xr5QPBx2mr8y8wsI+bzIE=; b=6V1EhJmyF5HfLnX+zuf7uLpRue
	nlyqWF2L8F2B3o2iUCjLTwVrj9Gr6/QiCMSZmIJpMa/0oaAZQ2K96tk7ylb+MYbuE+XJjAzlezgkF
	dSa55z+3D/HDINRKUK0OZS/AsebKBWHMMOlEm+MINfSyPY+d/VuH9uqfbJJu+5xWLlNU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBwT3-00G9k6-EI; Tue, 28 May 2024 15:02:17 +0200
Date: Tue, 28 May 2024 15:02:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ang, Tien Sung" <tien.sung.ang@intel.com>,
	"G Thomas, Rohan" <rohan.g.thomas@intel.com>,
	"Looi, Hong Aun" <hong.aun.looi@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature v2 1/1] net:
 stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Message-ID: <48673551-cada-4194-865f-bc04c1e19c29@lunn.ch>
References: <20240527093339.30883-1-boon.khai.ng@intel.com>
 <20240527093339.30883-2-boon.khai.ng@intel.com>
 <48176576-e1d2-4c45-967a-91cabb982a21@lunn.ch>
 <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751469FAA2B01EB6CEB7B50C1F12@DM8PR11MB5751.namprd11.prod.outlook.com>

> So, for this XGMAC VLAN patch, the idea of getting the VLAN id from the descriptor is the same, but 
> The register bit filed of getting the VLAN packet VALID is different. Thus, it need to be implemented separately. 

Please wrap your emails to around 78 characters.

It is well know this driver is a mess. I just wanted to check you are
not adding to be mess by simply cut/pasting rather than refactoring
code.

Lets look at the code. From your patch:

+static void dwxgmac2_rx_hw_vlan(struct mac_device_info *hw,
+				struct dma_desc *rx_desc, struct sk_buff *skb)
+{
+	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
+		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+}
+

and

static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
                              struct dma_desc *rx_desc, struct sk_buff *skb)
{
        if (hw->desc->get_rx_vlan_valid(rx_desc)) {
                u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);

                __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
        }
}

Looks identical to me.

From your patch:

static void dwxgmac2_set_hw_vlan_mode(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 val = readl(ioaddr + XGMAC_VLAN_TAG);
+
+	val &= ~XGMAC_VLAN_TAG_CTRL_EVLS_MASK;
+
+	if (hw->hw_vlan_en)
+		/* Always strip VLAN on Receive */
+		val |= XGMAC_VLAN_TAG_STRIP_ALL;
+	else
+		/* Do not strip VLAN on Receive */
+		val |= XGMAC_VLAN_TAG_STRIP_NONE;
+
+	/* Enable outer VLAN Tag in Rx DMA descriptro */
+	val |= XGMAC_VLAN_TAG_CTRL_EVLRXS;
+	writel(val, ioaddr + XGMAC_VLAN_TAG);
+}

static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
{
        void __iomem *ioaddr = hw->pcsr;
        u32 value = readl(ioaddr + GMAC_VLAN_TAG);

        value &= ~GMAC_VLAN_TAG_CTRL_EVLS_MASK;

        if (hw->hw_vlan_en)
                /* Always strip VLAN on Receive */
                value |= GMAC_VLAN_TAG_STRIP_ALL;
        else
                /* Do not strip VLAN on Receive */
                value |= GMAC_VLAN_TAG_STRIP_NONE;

        /* Enable outer VLAN Tag in Rx DMA descriptor */
        value |= GMAC_VLAN_TAG_CTRL_EVLRXS;
        writel(value, ioaddr + GMAC_VLAN_TAG);
}

The basic flow is the same. Lets look at the #defines:

#define XGMAC_VLAN_TAG			0x00000050
#define GMAC_VLAN_TAG			0x00000050

#define GMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
#define GMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21
+#define XGMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
+#define XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21

+#define XGMAC_VLAN_TAG_STRIP_NONE	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x0)
+#define XGMAC_VLAN_TAG_STRIP_PASS	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x1)
+#define XGMAC_VLAN_TAG_STRIP_FAIL	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x2)
+#define XGMAC_VLAN_TAG_STRIP_ALL	FIELD_PREP(XGMAC_VLAN_TAG_CTRL_EVLS_MASK, 0x3)
#define GMAC_VLAN_TAG_STRIP_NONE        (0x0 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
#define GMAC_VLAN_TAG_STRIP_PASS        (0x1 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
#define GMAC_VLAN_TAG_STRIP_FAIL        (0x2 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
#define GMAC_VLAN_TAG_STRIP_ALL         (0x3 << GMAC_VLAN_TAG_CTRL_EVLS_SHIFT)

This is less obvious a straight cut/paste, but they are in fact
identical.

#define GMAC_VLAN_TAG_CTRL_EVLRXS       BIT(24)
#define XGMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)

So this also looks identical to me, but maybe i'm missing something
subtle.

+static inline u16 dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
+{
+	return le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK;
+}
+

static u16 dwmac4_wrback_get_rx_vlan_tci(struct dma_desc *p)
{
        return (le32_to_cpu(p->des0) & RDES0_VLAN_TAG_MASK);
}

#define RDES0_VLAN_TAG_MASK		GENMASK(15, 0)
#define XGMAC_RDES0_VLAN_TAG_MASK	GENMASK(15, 0)

More identical code.

+static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
+{
+	u32 et_lt;
+
+	et_lt = FIELD_GET(XGMAC_RDES3_ET_LT, le32_to_cpu(p->des3));
+
+	return et_lt >= XGMAC_ET_LT_VLAN_STAG &&
+	       et_lt <= XGMAC_ET_LT_DVLAN_STAG_CTAG;
+}

static bool dwmac4_wrback_get_rx_vlan_valid(struct dma_desc *p)
{
        return ((le32_to_cpu(p->des3) & RDES3_LAST_DESCRIPTOR) &&
                (le32_to_cpu(p->des3) & RDES3_RDES0_VALID));
}

#define RDES3_RDES0_VALID		BIT(25)
#define RDES3_LAST_DESCRIPTOR		BIT(28)

#define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
+#define XGMAC_ET_LT_VLAN_STAG		8
+#define XGMAC_ET_LT_VLAN_CTAG		9
+#define XGMAC_ET_LT_DVLAN_CTAG_CTAG	10

This does actually look different.

Please take a step back and see if you can help clean up some of the
mess in this driver by refactoring bits of identical code, rather than
copy/pasting it.

	Andrew

