Return-Path: <netdev+bounces-189599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA7AB2B9D
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 23:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C93189971F
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223425F97A;
	Sun, 11 May 2025 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FAhkc07q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F114A09C;
	Sun, 11 May 2025 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746998752; cv=none; b=XGdSYhaA+V4tn6lHWjGbAp1rV3TTYHO3DawV/HgQkd85/FuNmZ8BPxOCV5/eetLdFBVjlqUtdVhSAOWyq3He8mA6WTXDMWLZBjPLBmHRsXYNCE7FoOWLsCXupiLo03xpFGMfhwygfG/ERQQuU+F5Wu4uNhQIg8sO/RRtQDpDpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746998752; c=relaxed/simple;
	bh=gUWXrPZP0cgNig1Rls3XoWX2UmOwqqNTnMVATnn4H2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzuZgfpoyNQ/qgE3hVY/4se66sXtn2OFX2jtI1zqV+3FGvVOSKa+9MXscuDRJAFJqBNQzspT/y6qnXkGRQJTD3nGYk6Dk+XnEKz3R5JqoQhc+NS6coFEijGaeAGka2DsPrHUQenZGsWwf8FUkeNdzyyOOof/NohsLGTc/ncUkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FAhkc07q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pFDIZWe85lWzdsVOO9D9K4RCfE3MGF8f7zr5mhPvBlE=; b=FAhkc07qAlQhbeIcSsYcowD/zh
	28GpGuhOHupvuPXTxs3uoYu4gGBRZh48QxNridrAuo7FSpll9ucBiUpcOcV3Wasl5auLvpKmHrck9
	XMnw0yvBadv1bjs3/UaOm8ietfTKaUB52YDpLbewhnMce8udVoP1i9PxmkQhCmtiEzSw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEEAp-00CHOm-O9; Sun, 11 May 2025 23:25:27 +0200
Date: Sun, 11 May 2025 23:25:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
	sean.wang@mediatek.com, daniel@makrotopia.org, lorenzo@kernel.org,
	nbd@nbd.name, netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: Re: [PATCH v1 09/14] arm64: dts: mediatek: mt7988: add switch
 node
Message-ID: <74afe286-2adb-42d3-9491-881379053e36@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-10-linux@fw-web.de>
 <bfa0c158-4205-4070-9b72-f6bde9cd9997@lunn.ch>
 <trinity-0edcdb4e-bcc9-47bb-b958-a018f5980128-1746984591926@trinity-msg-rest-gmx-gmx-live-74d694d854-ls6fz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-0edcdb4e-bcc9-47bb-b958-a018f5980128-1746984591926@trinity-msg-rest-gmx-gmx-live-74d694d854-ls6fz>

> i will move that into the board dtsi file in v2 because "normal" bpi-r4 and 2g5 variant are same here.

Maybe you just need to expand the commit message? What does this .dtsi
actually represent? The SoC, or what is common across a number of
boards?

	Andrew

