Return-Path: <netdev+bounces-180233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6603A80BFD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063A650664F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5C51D5ABA;
	Tue,  8 Apr 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Qdnrm8BE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7D1C5F08
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117460; cv=none; b=aBY4/JcZXIVzkNmqCi3kzwzEjIlXDH1BMpeMfJmCokqMRKY7K1RlUm8tRi2w1e000JYlDQ5KqqWZq3vv9aC2OUiGPviCvvEuHPPq8lPJmSVCk32wjQicIe+hAD0IENbfqh7pEiIQzsHSFbXDvaG7Zuf8cCvtU5dG+D28qonOb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117460; c=relaxed/simple;
	bh=SShOKKa4LMqYcTOm6njD8nRn5wiR7lnqI6a0xzjIzG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdJGemdI6HLdYEYYM1mbYscG1YihchEPE8pAtYFUWtMWJJ+Q/up3ecpw5sGDauZWky12I4t3dW9xvaLUREpdhOfK5teTfmfkovqobrHhBHZBPlaLthV40dyylRIWWBiw/XMw6K7V/IFHT+5nfc8UAn6QOL3Lk7jBASmrhvyYGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Qdnrm8BE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rB/dIvd7bU6zo6n9YdzMajIzzeCmS1EwGXtnalG5tYI=; b=Qdnrm8BEZBNy23lYC19M1XF7Et
	Kp+5vAHIJY07hxFNlG2cyzxI82LuGlxAdpnBCSX1HCcmFT4O2k4peaJQhTQDULdEaO6iZa8YuYRla
	OJ/P5KfclV+qVRbN3/GE5+LzbjNWkeAwXt8MPqNdiJPCdno71A5qqo/rDuqQXh6GCksQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u28cc-008OFV-52; Tue, 08 Apr 2025 15:04:10 +0200
Date: Tue, 8 Apr 2025 15:04:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwc-qos: use
 stmmac_pltfr_find_clk()
Message-ID: <0f370f79-6221-48e4-a700-86fc26547f95@lunn.ch>
References: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk>
 <E1u1rMv-0013ON-TJ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1u1rMv-0013ON-TJ@rmk-PC.armlinux.org.uk>

On Mon, Apr 07, 2025 at 07:38:49PM +0100, Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

