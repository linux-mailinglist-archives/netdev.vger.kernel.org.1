Return-Path: <netdev+bounces-231511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC21BF9BE1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7503B92BD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50011A08BC;
	Wed, 22 Oct 2025 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="up9Uy+TR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BB017BED0;
	Wed, 22 Oct 2025 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761100492; cv=none; b=bhVfVxh4OwwfsHkSkA+RtFwk7B4tUsNWnkmDkvyKaZkrx56KVw+AOuTK5UoW7AeWe8FApPhmz3ADmdJk1Q01ZQ0u1Wue1890YLo8etQSYAk+fvP+ajSr2Ndkcnp4DTKklLOdbD3EBAjx2ZlTuN1yWx9+08MVzJnmnTorL1OKvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761100492; c=relaxed/simple;
	bh=GUa6DD6670ykAflR4DIqdI2NKY0zlT6ht7iF9qu1gG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFAwWdBVFfMJHZdZdT4PDAIZ5jIRCmS+Zeuu4gfxeX3aXfhBYyYV9y++hQmAjJW0lUFdFGH+Qh+H/eEZajOsVExj9ooC9EGIBbytwu4LnJiyg4guKHlvzLqQLick8UmRmnrAsFp8Ahnjzw6DVRbhtsV7BD/bb+OOnQkIYdXNI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=up9Uy+TR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WWQYq1JCkw9J+60GCKpbnq5dicoFbhTFSsFRkQJ7qn4=; b=up9Uy+TR3p7oIbJ7LFeVNbdVWC
	tVGqa08PwTUOkQsmFgig3YNDZwzwq73HNOyKZ+dxhLrjBBHqSr6UhMNt8tY55BZz/ejbEjjCYw+8W
	54bDr5FF4IM9b/j1pvtWH2lRcoF/i35am/ATaYrQnL4hrf1EUOSUgoknxy+NMPoTLgn4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBOgN-00BheV-9q; Wed, 22 Oct 2025 04:34:35 +0200
Date: Wed, 22 Oct 2025 04:34:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
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
Subject: Re: [PATCH net-next v3 2/7] net: dsa: lantiq_gswip: convert
 accessors to use regmap
Message-ID: <41cf88a6-556d-44b9-a9ae-82c331a96df7@lunn.ch>
References: <cover.1760877626.git.daniel@makrotopia.org>
 <baf5cc2487823210ac648726c56d6f4ebb35d323.1760877626.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf5cc2487823210ac648726c56d6f4ebb35d323.1760877626.git.daniel@makrotopia.org>

On Sun, Oct 19, 2025 at 01:47:42PM +0100, Daniel Golle wrote:
> Use regmap for register access in preparation for supporting the MaxLinear
> GSW1xx family of switches connected via MDIO or SPI.
> Rewrite the existing accessor read-poll-timeout functions to use calls to
> the regmap API for now.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

