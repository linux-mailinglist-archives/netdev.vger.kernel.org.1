Return-Path: <netdev+bounces-187121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34964AA5157
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 953EF1C05D46
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EB920C463;
	Wed, 30 Apr 2025 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l6ZVDLUp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3884178CC8;
	Wed, 30 Apr 2025 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029780; cv=none; b=BiXs+5wCPu37w3rH0mfeYkIY4GgMjRsWtYg+KMc7B/52ehkVpLwq2sMK3D0SUppZBxxp6sCESoUiPM9dg6NH2F9MfWipuK/S0CihKlv5Ken2dzJ7PFUQl/cRrLdhp2KDDTMaFSSfR8s66txgoNoynphMew/DHnd6aqXGbsk9CEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029780; c=relaxed/simple;
	bh=eMd2c87o8So+qenhBw3u7v5a+xmgGXAoQedapOD7Obg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOLDFC4B4nn+ebAewFyRqk9uSRlPRcqpxlqHWr/JbTOQ/Rh885bYCO+k/FQssfkEVVZn52rdU/o/qMzLZyGJP5KxYIa0CxsZ2wIvpMcEZp5KjGCbfhuKCW/I9Tc1fAa7imh9WCEz+VNinE1uloVKW+jAy/IqdrfBwlrp6c91lgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l6ZVDLUp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VHw++ueBqMA9gHPPexHywPa7lWGoLeLxlqgC8EeY1Tg=; b=l6ZVDLUpbXfufkgK/4b2kUf+jE
	nsA4cuy09Jzm8ybkngc8Pu5wOAY/mAprZYa442w/X14ne7YT0VvKpV4hEomb2YzzMpEcODfmf4bBf
	d85owhf7d6dld/+bD84rEQUrFmpQwZ2jgahbx8NMTutobJXEnlM8qoDXRjrAlG4C3cmM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uAA6J-00BFbx-N9; Wed, 30 Apr 2025 18:15:59 +0200
Date: Wed, 30 Apr 2025 18:15:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Roger Quadros <rogerq@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH net-next 3/4] net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay
Message-ID: <26696cfd-85f2-4876-9a56-f005eedc8380@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <32e0dffa7ea139e7912607a08e391809d7383677.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <07c540a2-c645-460c-bfad-c9229d5d5ad0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c540a2-c645-460c-bfad-c9229d5d5ad0@kernel.org>

On Wed, Apr 30, 2025 at 05:56:29PM +0300, Roger Quadros wrote:
> Matthias,
> 
> On 15/04/2025 13:18, Matthias Schiffer wrote:
> > All am65-cpsw controllers have a fixed TX delay, so the PHY interface
> > mode must be fixed up to account for this.
> > 
> > Modes that claim to a delay on the PCB can't actually work. Warn people
> Could you please help me understand this statement? Which delay? TX or RX?

See if this helper:

https://patchwork.kernel.org/project/netdevbpf/patch/20250429-v6-15-rc3-net-rgmii-delays-v1-1-f52664945741@lunn.ch/

There will be a V2 soon.

      Andrew

