Return-Path: <netdev+bounces-170951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05B1A4ACA3
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902513AC278
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB5D1E1A33;
	Sat,  1 Mar 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DFIHpIYI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259235971
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740844281; cv=none; b=R81S3vBBko1W5Udpto5a/wpfRaMnUuBTJX5lfIB5Usmnzj2N3v4eIDP1Dtr2gyfMN0WHfBSST1Bt8gkNNmkfDoBGjcoz343Ei9H3jxCSmCroroixJVK634LFEg68B5R8xZ4jiD6H7JWx58QNpe7NSXlPXskvfhTBQXdp4R0seyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740844281; c=relaxed/simple;
	bh=rIwGP+5QhefBUqmSNhmYB/4OYFDuQ3+MUvNK5+eXCc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V48qrpJI7kpbK3y+vO0kPMqymLbJf9UE8tc4iSa2WjU6Hn4XfbEm4BGHeVslmXzUgPLm6HSVW+yyt4pD8U5Xq20lxuDVyRvbT6QwptksZGQry4wLHXzPmhgXomv0S/P7790O4O96nn8DRBqAtLAmHxDUoo222TRMQR+mG6eHyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DFIHpIYI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GvkEmj7cqY5M2OHwbVp82hYCqgPP+4jqnKLRK/ixqMI=; b=DFIHpIYIt7ZT7K9UZBFMRgfMdz
	a9catRR7sfGQbyVvGeMZM+PcflArGyFa6dCGALGoLSWEqTNxkhkw3e/H8vj5XxXsx6QUTsAQmLJUc
	CrXasdWwW5gd137PJ+Sovr10ptJHJnkUGr9aDX38a0Qfl8LzbWXFL7eeVl9j0ZwqgX8Btb26lP1sr
	6dpHRLSqbI4cTiuFU9pyJZuqpYUtFGd52nxPUnofY0xxG6s5NE/i9pVZ3qi6/1KqXFZUR4Aptaya8
	AcNV4/7dNPEXEDsPLlEhq5GKvjQrGY7pouHXlWnstXFYkartzfIQe43eT6h0mq+gtGoeqU/m9Zz3d
	0lykcS8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51572)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1toP7Q-0004an-02;
	Sat, 01 Mar 2025 15:51:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1toP7N-0001sw-0H;
	Sat, 01 Mar 2025 15:51:09 +0000
Date: Sat, 1 Mar 2025 15:51:08 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [QUERY] : STMMAC Clocks
Message-ID: <Z8Ms7C4-1IgjqBlq@shell.armlinux.org.uk>
References: <CA+V-a8u04AskomiOqBKLkTzq3uJnFas6sitF6wbNi=md6DtZbw@mail.gmail.com>
 <84b9c6b7-46b1-444f-b8db-d1f6d4fc5d1c@lunn.ch>
 <Z8LkPQ-w_jyXriFp@shell.armlinux.org.uk>
 <e54bf5af-b2ab-496d-9146-41f88bc4b5f2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54bf5af-b2ab-496d-9146-41f88bc4b5f2@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 01, 2025 at 04:15:17PM +0100, Andrew Lunn wrote:
> > However, I think that we should push to standardise on the Synopsys
> > named clock names where they exist (essentially optional) and then
> > allow platform specific clocks where they're buried out of view in
> > the way I describe above.
> 
> Interestingly snps,dwc-qos-ethernet.txt has a pretty good description:
> 
> - clock-names: May contain any/all of the following depending on the IP
>   configuration, in any order:
>   - "tx"
>     The EQOS transmit path clock. The HW signal name is clk_tx_i.
>     In some configurations (e.g. GMII/RGMII), this clock also drives the PHY TX
>     path. In other configurations, other clocks (such as tx_125, rmii) may
>     drive the PHY TX path.
>   - "rx"
>     The EQOS receive path clock. The HW signal name is clk_rx_i.
>     In some configurations (e.g. GMII/RGMII), this clock is derived from the
>     PHY's RX clock output. In other configurations, other clocks (such as
>     rx_125, rmii) may drive the EQOS RX path.
>     In cases where the PHY clock is directly fed into the EQOS receive path
>     without intervening logic, the DT need not represent this clock, since it
>     is assumed to be fully under the control of the PHY device/driver. In
>     cases where SoC integration adds additional logic to this path, such as a
>     SW-controlled clock gate, this clock should be represented in DT.
>   - "slave_bus"
>     The CPU/slave-bus (CSR) interface clock. This applies to any bus type;
>     APB, AHB, AXI, etc. The HW signal name is hclk_i (AHB) or clk_csr_i (other
>     buses).
>   - "master_bus"
>     The master bus interface clock. Only required in configurations that use a
>     separate clock for the master and slave bus interfaces. The HW signal name
>     is hclk_i (AHB) or aclk_i (AXI).
>   - "ptp_ref"
>     The PTP reference clock. The HW signal name is clk_ptp_ref_i.
>   - "phy_ref_clk"
>     This clock is deprecated and should not be used by new compatible values.
>     It is equivalent to "tx".
>   - "apb_pclk"
>     This clock is deprecated and should not be used by new compatible values.
>     It is equivalent to "slave_bus".
> 
> But snps,dwmac.yaml only has:
> 
>  clock-names:
>     minItems: 1
>     maxItems: 8
>     additionalItems: true
>     contains:
>       enum:
>         - stmmaceth
>         - pclk
>         - ptp_ref
> 
> Could you improve the description in snps,dwmac.yaml, based on what
> you seen in the data book?

I'm afraid I can't, because the description there is basically rubbish.
As I stated in my previous email, the only one listed there which
means anything as far as the databook is concerned is "ptp_ref". The
other two are just made up names that have no basis for anything in
the databook.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

