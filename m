Return-Path: <netdev+bounces-186455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF35A9F329
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E553A85B2
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC9268C65;
	Mon, 28 Apr 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="skb4qs5G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D532C85;
	Mon, 28 Apr 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849315; cv=none; b=Rhnd1HXowxDDHh8VZOlHlzWQnwCuJT7XExnnA4f4ifBRIAOEvA8ZYdGS0FTYEyj/Ido1EbJ6RmSbjppoUIDR3dO1Px2nYSvwZZfIFG2Nj9QrKBQLUq8tb7tqa4fJjR8vJgjNkSOFlOs45CH6n0H9ySGhLVHS2FWDdg20dNplFQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849315; c=relaxed/simple;
	bh=N82UuaGkcXSgDvbJ/SYZp0qqmioxEerlUofG5QQN/bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VN3Gceo61DJQBQRjxEekz6U3OAt3CeRSfrORhW9WDduvZ/b4anl4c9matqEvTxxDE9LW1soo+Rt/KB3zjWGjThWLiGDLX8QakLlxvmh4yhx2/kMnzeBFpKovSeugV4rENC7bXW991Bg4DZA6248Q36DweE8E1VCcJqmnycdXXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=skb4qs5G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aIpoS0ND3fqgX9y156pe5+DTr/v2sx0BpH1llI6WOd0=; b=skb4qs5GVkbEEle4HYIM/yPAtD
	2wnqyHXOICSwi0UCqYjBEO3Mr2FyKKapL7KS1cf8RfobEAdNTs1diMML0dUhuOKZ+PkYas6k8h4eV
	gvAG3s8P1cP6asKazO8WG/M0XtoSyIOok25LS48Gp/bGqPv/+keIUJJJ2TYaOR/1TirI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9P9W-00AqR4-GB; Mon, 28 Apr 2025 16:08:10 +0200
Date: Mon, 28 Apr 2025 16:08:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <9b9fc5d0-e973-4f4f-8dd5-d3896bf29093@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
 <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
 <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc02e46e4906ba92b562f8d2516901adc85659b.camel@ew.tq-group.com>

> > However, with the yaml stuff, if that is basically becoming "DT
> > specification" then it needs to be clearly defined what each value
> > actually means for the system, and not this vague airy-fairy thing
> > we have now.

 
> I agree with Russell that it seems preferable to make it unambiguous whether
> delays are added on the MAC or PHY side, in particular for fine-tuning. If
> anything is left to the implementation, we should make the range of acceptable
> driver behavior very clear in the documentation.

I think we should try the "Informative" route first, see what the DT
Maintainers think when we describe in detail how Linux interprets
these values.

I don't think a whole new set of properties will solve anything. I
would say the core of the problem is that there are multiple ways of
getting a working system, many of which don't fit the DT binding. But
DT developers don't care about that, they are just happy when it
works. Adding a different set of properties won't change that.

	Andrew

