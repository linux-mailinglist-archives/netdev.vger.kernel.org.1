Return-Path: <netdev+bounces-76915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CB86F656
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A359A1C203BE
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6D2762E6;
	Sun,  3 Mar 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vcu1nPUI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01F1EF12;
	Sun,  3 Mar 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485697; cv=none; b=kQfWhcy1B3A9vRVj4nuK7QUy6o26Jq2/rGGst3uGcv0Lpkp2Vujl3nc6bJlofFjqxJW4LAlS0uJM0JLLI6JBjmGxVTed6BNQaak/WqU0LuOZ23TvzYCwxdrJF6kZq3lf0mKc78ZXhD2EepC4tGCdv1VPml8Ssx1ffOtXhD/2bLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485697; c=relaxed/simple;
	bh=NL9aiVIwAPApNQZnE3TAbfLjOthvcjkPaF5fg/XAtTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uft1pAEcHwtnmVVbwEYBmAnXRLJFes4dma3DgcSb84NdogOifu63vIn9FVLlQ9RIvsA5+UzN4OeEb6ksFzSAJdjEk0giRMMKUACrb2p8FBtFdeh4LxjwG0Mh1ejFNl485BabrIyWo+C6aOdBa6ce/3xNHeYxTpBkYk8ehhuoIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vcu1nPUI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bDDDCH2dSvegdssRK89kL693cAKNTHCCNXibHY3RMX8=; b=Vcu1nPUI45fnYstLtqKWKWmyP6
	ayUP+YCEMmf+fLPZQHnGrjQV1mDWpLPpVpEAsuhw4Q4W6nFnOTwpy1ujQRhGMK6no7LDAUh8zbu+I
	2Nse4lg4YTUvp8wRhmqditP0Bm9AHIHstHUK0mqRcBNsYqxva05WDKyhY+5EEvY9DkNw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgpK0-009F4r-7u; Sun, 03 Mar 2024 18:08:20 +0100
Date: Sun, 3 Mar 2024 18:08:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <c88a9ec0-7465-473a-a7fc-9be1d6906714@lunn.ch>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <ZePicFOrsr5wTE_n@makrotopia.org>
 <d29b171b-c03a-44db-8e0d-15f9bd35c4b5@lunn.ch>
 <ZeStVG-GI0V-cYHK@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeStVG-GI0V-cYHK@makrotopia.org>

> It's very new:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/wordpart.h

It is not in net-next yet. So to make merging easier, it might be
better to keep with the current macros, and submit a patch next cycle
swapping to these helpers.

	 Andrew

