Return-Path: <netdev+bounces-232917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0BC09EC5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B2AD4E3A4A
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E96301716;
	Sat, 25 Oct 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FlOF+A82"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03918E1F;
	Sat, 25 Oct 2025 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418344; cv=none; b=bpvyLZgUyrBitLfZmRQzdAyKhhx1VIxHsBZioMF/nXE1qXEA69af5DvfJeOKKeTJlykoMJLW5lCbR4+EoFGFrw8b0dMgyJQAoglntd8vLzDOHqIHmkSZUKLll3cEksANlzsT7sZiq6kmMp9wig2s93mjwf8nMm6wLU+iYSrpOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418344; c=relaxed/simple;
	bh=pS1PNweBj0lv67nzhtW2vhqWYh0EvLJlraa9+vAPCfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvu3z109W+vvSvZmnxVkOctO7F+xUenB1nwf19F2fUlkqAFhqPSIhyiehu8urIPmecFXTm5WwUV1Y6S2Q63JUS5XyE7WlG+6sSKymkYfqQ5/43+d54KCTE2gpq/9RJnGFgvo/pWfscquvzCEE/4Qsb2K3R97kd2lRJTcKxzoxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FlOF+A82; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vzMDiq5tlTgX1W/21WhiBB6gzelJCaOUjEZfpZPw2jo=; b=FlOF+A82rwYsAN7j4qoNpJgXtF
	iWSNKWO8eYN/x0dET5c9+Js9JoENDh1Q5nuo4uZl6XJtc+wddCkclErWajJuho0AAVCCNlW9BtOny
	7kFFe0pahZ/Ypmi5vZswSMO2q8XAXspt+qxQ7cPRb2z6ojln7nkxHRXc1u6ZFnl7yeKiL+6NFL5KP
	pdqzgLGgxtbt9xuNsWLKzj68BKWXm9M2Cwot1WLin+o+jWtRoseNWYEIh9Z+Qfx4s030zrPhlwmDn
	nxnEDjLNwimpjuvy8+OxtEbfKUHMGOnwNuCUb7Cynqu2POed4jzv6q6MW3wdAQA9a/3/O3mnxFilD
	tnpPQnCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCjN1-000000000IZ-2XQq;
	Sat, 25 Oct 2025 19:52:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCjMy-000000003tv-0P2Z;
	Sat, 25 Oct 2025 19:52:04 +0100
Date: Sat, 25 Oct 2025 19:52:03 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>, kernel@pengutronix.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Teoh Ji Sheng <ji.sheng.teoh@intel.com>,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>,
	Austin Zhang <austin.zhang@intel.com>,
	"Tham, Mun Yew" <mun.yew.tham@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 00/10] arm64: dts: socfpga: agilex5: enable network
 and add new board
Message-ID: <aP0cU1mygKbt9DBQ@shell.armlinux.org.uk>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 01:49:52PM +0200, Steffen Trumtrar wrote:
> Add an initial devicetree for a new board (Arrow AXE5-Eagle) and all
> needed patches to support the network on current mainline.
> 
> Currently only QSPI and network are functional as all other hardware
> currently lacks mainline support.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

You haven't included which tree you are targetting with this series. I'm
assuming net-next for the following review. Please be explicit via
[PATCH net ...] or [PATCH net-next ...] in the subject line of the cover
message and each patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

