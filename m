Return-Path: <netdev+bounces-173052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B831A57063
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BB93AFBA7
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE8B23F434;
	Fri,  7 Mar 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WMhOKhug"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46721C17B;
	Fri,  7 Mar 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371773; cv=none; b=jZTLuzq1VAcaLp0jXCYmuFifTnvIK1cgi/CRB5foPPFbGSDomqS5wqU4jR564/bl91r9BMKUvwxNgnTxApOayTJmgGslV9RWtaJ9GlNMtuk8rMzKGpOV96rNiLzJeznV5Io8+laCFaCreHK0c4L6xYTE6m67kNgigSmtbXrGmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371773; c=relaxed/simple;
	bh=UhbysGiaH8FQ+ovQ5mfhRgpDsda9xG/VbV10XXNS1tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3MJu/dr8BDPEkIpND1pDioSIRsnLjqKGxzrFDaVubYvdRZ1q5ev6TkOQktypmISt/dKgLMtydqBeVreWNZ4+LpZYmzD+msodRHJTXprQh53b+1PJ35BCnOswr/4iIxonS8zNwJKSWUcZjoN7DV9qDjaJZ3AhlQa339EvL/M3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WMhOKhug; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MWbVuIUV4GkljN1k7GKXrppH1dlxoAA7vzJpSPCNsbU=; b=WMhOKhuglrHkpbV/vRsZcs+D0H
	zLiPV7i2eS2xvJsy0QnqQ6mVDhonciTp5SLpB27cs0NnxoDn3yM7TG7eV1jDuQaZdcMZhuBUn3Fsa
	qfRUokBI3yXbTHrB6OJXuykdi02AgOzdCuoESh6jeNdui4Wgbra/wOXOnnPZPiZ55dAdBo7nH54vb
	408s4a7FJoZ+suIFg0bI01v/KJv1Fg4eWSb91v6g+ab64bDZI/QjTbcCf3psM2U0ukL9L2mkjwct6
	cMr+fGCgpq9y5z7Dfqn5r7xbKtX9fAZPLc45O60XUV5vmcE0nzlnIuBWreEHZ7MNpwGWE8AywAKeg
	fJe3EoKw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53270)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqcLB-0007sw-21;
	Fri, 07 Mar 2025 18:22:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqcL7-00083J-0h;
	Fri, 07 Mar 2025 18:22:29 +0000
Date: Fri, 7 Mar 2025 18:22:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Andrew Lunn <andrew@lunn.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and
 php-grf during probe
Message-ID: <Z8s5ZZyTCpS9xHlA@shell.armlinux.org.uk>
References: <20250306210950.1686713-1-jonas@kwiboo.se>
 <20250306210950.1686713-3-jonas@kwiboo.se>
 <bab793bb-1cbe-4df6-ba6b-7ac8bfef989d@lunn.ch>
 <1dd9e663-561e-4d6c-b9d9-6ded22b9f81b@kwiboo.se>
 <20250307085558.5f8fcb90@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307085558.5f8fcb90@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 07, 2025 at 08:55:58AM -0800, Jakub Kicinski wrote:
> On Fri, 7 Mar 2025 00:49:38 +0100 Jonas Karlman wrote:
> > Subject: Re: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe
> > 
> > [encrypted.asc  application/octet-stream (3384 bytes)] 
> 
> Is it just me or does anyone else get blobs from Jonas?
> The list gets text, according to lore.

Looking at the emails I've received, some which were via the list, some
which were direct, I don't see anything out of the ordinary - seems to
just be text/plain here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

