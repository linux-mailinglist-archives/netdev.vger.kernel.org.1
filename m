Return-Path: <netdev+bounces-232934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 197F8C09FBD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D50A1AA73FD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588742E9ED1;
	Sat, 25 Oct 2025 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ka2eZd34"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5B2030A;
	Sat, 25 Oct 2025 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425030; cv=none; b=uOdq8R6fECFZjk4A4jBrJlD1qNcqOe6O8RLxRM/b++wnKVvG/rAqIMj7bwwO1/WNzhsUlVVRx//2qaBpvImY63AANCCJom9dlWbMY4gdn7vtb9+DYyhZXz3E1bvj3j5zdkuRSKYGYr7HnjqWfWjp7ap/kDEwuTqcyOkhz7RxmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425030; c=relaxed/simple;
	bh=HQMJMovbVwXvQ1to99lm/kTzOKLCwcubXTMchh6sK2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBHXSkjYKdFO+vVqI6le3tPtdfkRLSAl2jN2eP0ldPMTVtEzXcKrHx3NKbwAK7eybQ0AZzRP5Nj8o0SFIW6bmSKQaoEm/hS6O+CLE9nHZM15UJ83gzSn0O+tgW4E+9EW3ricAVMnaxOuELxlU5M5TEWcRYFvr/KMIP5MlJ9ad04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ka2eZd34; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=msZsmcP10DvegO2UYbUabCKD2N+qWJGeZYwtV2MxTHk=; b=ka2eZd34ofn5xugbcSOZsksIov
	TwXl5oq0qe8WeaMoWf1XhJCGqJJM08LNXncrvcwYebO5gF+3us+oAx+BByAdhB6XJj2piGufKLlW0
	ihl32/qjsj1s4HF5j9nN/jewjyfk5AoXml+iFs6Bry2Fw8I7VJ/ndEB+6kwsabLg3ru3/AilzFqK2
	mj/+eh6/L4DFnJ703N2NUpaGrrE/0beb7kEQl/SM+mAm+M90QpZkvtyt/Mrh/QAan/4Obj1CRzw/2
	Kqli/s6GGAVCCx8uAMyMrtMSPNudHlFdtpEKqnLm6hvUU6kvzRE/tnEYBPFQjDzbufiq1tUK7UbV1
	c/maXPMA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCl6r-000000000OH-3M4W;
	Sat, 25 Oct 2025 21:43:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCl6o-0000000040e-1OXJ;
	Sat, 25 Oct 2025 21:43:30 +0100
Date: Sat, 25 Oct 2025 21:43:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next 03/13] net: dsa: lantiq_gswip: support Energy
 Efficient Ethernet
Message-ID: <aP02cniTo8WxnMqs@shell.armlinux.org.uk>
References: <cover.1761324950.git.daniel@makrotopia.org>
 <5be787b67aadb589a06cf732a8def0284a25237b.1761324950.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be787b67aadb589a06cf732a8def0284a25237b.1761324950.git.daniel@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 24, 2025 at 06:01:58PM +0100, Daniel Golle wrote:
> Introduce support for Energy Efficient Ethernet (EEE) on hardware
> version 2.2 or later.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

