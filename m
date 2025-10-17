Return-Path: <netdev+bounces-230562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D80BEB21E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE41E74305A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4132C931;
	Fri, 17 Oct 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M5gx+vTG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFFF29B77E;
	Fri, 17 Oct 2025 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723836; cv=none; b=TaG7Au8krIOisUi6GtjbrtnhmWTRnAMllNasxDsaZs9ED2J5Bh0lbxK81+bSDoKy1IlHRDApPL1A3tvXvYSbiIHOuNvtGD6KISy32ZvenwtoQt52msk+4Oa9/rYNjLpsKD2K99FDDjKze7E4QmyPh5J1MMttW7hm4ap9bT37Eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723836; c=relaxed/simple;
	bh=k0vrNBXQFjfpmMqOAmrCLWHtFFRVc0/lmvAsSKB8gR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UslQS2pcKqX4+GhsV8sHflUmWRP95zR9jnN+WqgVapkY1+uR73ICCl4fHShVO4HD/pYUs369G7WWKT5JQOMfPQRepl0Pgl4O4RyiG8m532ZRYFPzQFx8eeCtaZU7fUDT93MG+EoT1WmGDEZ+HcwNoN+sMgS2yOPn6tST2L1tQv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M5gx+vTG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/N1/+OxGwHAz4inXaCdshES/YB4/vAFV1rtPsvhg0mo=; b=M5
	gx+vTGAIBxKRykRjZr1vQabB8Ogk0dAvX0sjV4iAVmZ+0OoTbcJdP2td8bXhC2+XOkPUjwQzfkzJF
	sR7b47+k77oTBfOwGbzhvZXMlZqNyZfEvCreESgDGavR0IfD2wGBGYGA98huPGr1ULfyPUWYxem1p
	GqMVI+0YUoRQV3s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9ohN-00BJQl-Oh; Fri, 17 Oct 2025 19:57:05 +0200
Date: Fri, 17 Oct 2025 19:57:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 06/15] net: macb: simplify
 macb_dma_desc_get_size()
Message-ID: <16907a1b-d5eb-4d2c-acea-195c2d1f7cc6@lunn.ch>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
 <20251014-macb-cleanup-v1-6-31cd266e22cd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014-macb-cleanup-v1-6-31cd266e22cd@bootlin.com>

On Tue, Oct 14, 2025 at 05:25:07PM +0200, Théo Lebrun wrote:
> macb_dma_desc_get_size() does a switch on bp->hw_dma_cap and covers all
> four cases: 0, 64B, PTP, 64B+PTP. It also covers the #ifndef
> MACB_EXT_DESC separately, making it four codepaths.
> 
> Instead, notice the descriptor size grows with enabled features and use
> plain if-statements on 64B and PTP flags.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

