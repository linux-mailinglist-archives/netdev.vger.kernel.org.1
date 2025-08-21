Return-Path: <netdev+bounces-215644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5EEB2FC3B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA81A006D1
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E85C2BD5B3;
	Thu, 21 Aug 2025 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U2+oXM9f"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E523D7ED;
	Thu, 21 Aug 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785755; cv=none; b=d62DQBim+BrrG/XqCZczPgKEJyuIl8YcvGYdP2RIyoG1pIpzf7s7S8jiInjkzw4qSMh4zBa73OUNJ9HRAG+6i+BRecfzRyIwLOBIRLuiSWZMao0WYpcM77hX1q4saW8ak6pPmePjZ4Z17XD90IZpbLKkRQOGt75eSou1bgUbrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785755; c=relaxed/simple;
	bh=aGTiUaE6wgWfeBsp7D9zWiVk9Ot/eVVN9KU/GJLEIwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR6DlwJKMw67owQeYAd6yy3tlvRs/QGY7qxTaXINRHSAZCxeGxTDBjm3jigFqFvkypZpgQDenp56Svt3XepnvDXCpZKyfxDNCLezWKWq1BnZaQI9xaxnsee3tsR8XESlK0PzPoDeJpd4zcktDJyRlSK8KQo93t5UXtHD90qT+50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U2+oXM9f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xU+9vDUiNjllQZALNS0DJDtz8AB80KXzT3XORAL0N2g=; b=U2+oXM9f0IyReIgrGiTjSkyrGy
	HODDwMdacAre75sfqY4NhMzFpvBKzTOctCAnAze1Q+z8ExOJRZM9TJWeb0puDNEd2kfs21RRsvLp+
	6eLoCMTQ12VeXJYNWW56EdEBecqyGYGW9ZLzwe4gsLt3UmVr5fDTN8VRtP+zYblb0QbA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up64i-005SZd-CQ; Thu, 21 Aug 2025 16:15:32 +0200
Date: Thu, 21 Aug 2025 16:15:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
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
Subject: Re: [PATCH net-next v3 7/8] net: dsa: lantiq_gswip: store switch API
 version in priv
Message-ID: <8eb20dee-162f-47ea-8596-be71a3aa653b@lunn.ch>
References: <cover.1755654392.git.daniel@makrotopia.org>
 <88e9ca073e31cdd54ef093053731b32947e8bc67.1755654392.git.daniel@makrotopia.org>
 <aKZg3TviLUDgKgLz@pidgin.makrotopia.org>
 <58d31b56-8145-419e-b7be-1fd48cfeda88@lunn.ch>
 <aKb59jMfDIJIK0KP@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKb59jMfDIJIK0KP@pidgin.makrotopia.org>

> The (anyway public) datasheets I have access to don't describe the VERSION
> register at all. In the existing precompiler macros, however, you can see
> that most-significant and least-significant byte are swapped. REV is
> more significant than MOD:
> 
> #define GSWIP_VERSION                   0x013
> #define  GSWIP_VERSION_REV_SHIFT        0
> #define  GSWIP_VERSION_REV_MASK         GENMASK(7, 0)
> #define  GSWIP_VERSION_MOD_SHIFT        8
> #define  GSWIP_VERSION_MOD_MASK         GENMASK(15, 8)
> #define   GSWIP_VERSION_2_0             0x100
> #define   GSWIP_VERSION_2_1             0x021
> #define   GSWIP_VERSION_2_2             0x122
> #define   GSWIP_VERSION_2_2_ETC         0x022
> 
> Now I'd like to add
> #define   GSWIP_VERSION_2_3             0x023
> 
> and then have a simple way to make features available starting from a
> GSWIP_VERSION. Now in order for GSWIP_VERSION_2_3 to be greater than
> GSWIP_VERSION_2_2, and GSWIP_VERSION_2_1 to be greater than
> GSWIP_VERSION_2_0, the bytes need to be swapped.
> 
> I don't think the vendor even considered any specific order of the two
> bytes but just defines them as separate 8-bit fields, considering it a
> 16-bit unsigned integer is my interpretation which came from the need for
> comparability.

It would be good to put some of this into the commit message and
comments in the code. That the hardware has the 'major/minor' version
bytes in the wrong order preventing numerical comparisons. To make it
obvious, rather than use swap16(), maybe actually extract the major
and minor, and then construct the version in the form you want?

    Andrew

