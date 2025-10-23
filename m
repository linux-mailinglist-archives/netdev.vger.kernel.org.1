Return-Path: <netdev+bounces-232073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50BC00981
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869C71A61547
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1B82FF668;
	Thu, 23 Oct 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Vo4MIiRf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC32FF155;
	Thu, 23 Oct 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217098; cv=none; b=VeL+b6Hs/aAvsVgGf/qiSZLqseVAyPl+IUL6UTU7j6WDrMs9ufFZ41oAvFkGQbxby/RM4bIamd5CWRmIC2gkwq3VKt4f0wrk7KCRtO2l3p3wWp/HETm/SjbKH1FeFA1CAdKfzZLpWQV42LK5uhX1pK5sSM96TOUgNEJMKqLquaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217098; c=relaxed/simple;
	bh=6vn6v4MILSmOJO1xxegRdfAeOu/+fF7cc10L4LrUSRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgnoCHViuUNSCaLKKRA3FU/NtmicwsBrUzB9i/Ym/3QG90SwUbEgLw3POmZ9KQMnTWUMvyfVRkHXZULTAkJel8fTM/OAhpHp7p1mh9p+8zioEQEMYj2DACqvNb1WTIUtKZZTXZVG2gmAqMxhTEtajTfdJp16sgYP0z4XPya0VhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Vo4MIiRf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qNGKgnMkm6N0a34ArXOzNjX3fTe4GCYWTtnKll+z7TA=; b=Vo4MIiRfyHNRUscorfDM2/WOE+
	41TOMbZ/qQpN4QtO+oFf2EFpHe03toytLAivMuDtRJF6x8M16xbeVOrA8JQl8HwymcoIzP4c4O6Jf
	NCAmA6iZQ5I6/8i/xZbPnXziAmvjlSFD974zsQ2/HEPYDv5NqJKlQO+ZhzwQcfh05YCVc750IXVm0
	3EybN0Xz1J5Hg7BMUp3kY2o+Sw54x9cx8nXnxw/Z+fnxc5i0T1zuxhvLhtmHfjUgBE5/GfIKvhyCc
	r8HPePXiy+8MBBJilicxlzwsXUqg0E5L0uuE6n89f2TKdJliV0ncU+TVqkTMHhaw3jZAvBu0nJrdL
	aJCwddtQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58128)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vBt19-000000006Dh-3jCL;
	Thu, 23 Oct 2025 11:58:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vBt17-000000001cq-0c85;
	Thu, 23 Oct 2025 11:58:01 +0100
Date: Thu, 23 Oct 2025 11:58:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net v3 2/3] net: stmmac: Consider Tx VLAN offload tag
 length for maxSDU
Message-ID: <aPoKOIfCGvDEIWS7@shell.armlinux.org.uk>
References: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
 <20251017-qbv-fixes-v3-2-d3a42e32646a@altera.com>
 <aPI6MEVp9WBR3nRo@shell.armlinux.org.uk>
 <ac0a8cd8-b1bc-4cdb-a199-cc92c748b84b@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac0a8cd8-b1bc-4cdb-a199-cc92c748b84b@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 18, 2025 at 07:36:26AM +0530, G Thomas, Rohan wrote:
> Hi Russell,
> 
> Thanks, I'll update the commit message.
> 
> On 10/17/2025 6:14 PM, Russell King (Oracle) wrote:
> > On Fri, Oct 17, 2025 at 02:11:20PM +0800, Rohan G Thomas via B4 Relay wrote:
> > > From: Rohan G Thomas <rohan.g.thomas@altera.com>
> > > 
> > > On hardware with Tx VLAN offload enabled, add the VLAN tag length to
> > > the skb length before checking the Qbv maxSDU if Tx VLAN offload is
> > > requested for the packet. Add 4 bytes for 802.1Q tag.
> > 
> > This needs to say _why_. Please describe the problem that the current
> > code suffers from. (e.g. the packet becomes too long for the queue to
> > handle, which causes it to be dropped - which is my guess.)
> > 
> > We shouldn't be guessing the reasons behind changes.
> > 
> 
> Queue maxSDU requirement of 802.1 Qbv standard requires mac to drop
> packets that exceeds maxSDU length and maxSDU doesn't include preamble,
> destination and source address, or FCS but includes ethernet type and VLAN
> header.
> 
> On hardware with Tx VLAN offload enabled, VLAN header length is not
> included in the skb->len, when Tx VLAN offload is requested. This leads
> to incorrect length checks and allows transmission of oversized packets.
> Add the VLAN_HLEN to the skb->len before checking the Qbv maxSDU if Tx
> VLAN offload is requested for the packet.
> 
> This patch ensures that the VLAN header length (`VLAN_HLEN`) is
> accounted for in the SDU length check when VLAN offload is requested.

Please put that in the commit message, thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

