Return-Path: <netdev+bounces-107517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C991B495
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 03:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33ABAB20DA4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83EAD2FA;
	Fri, 28 Jun 2024 01:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C286FC7;
	Fri, 28 Jun 2024 01:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719537081; cv=none; b=G43UINnsZQOJc4yYF7QfFn3Qow8ECyTLI+5fHBXUXi01C5vc6laGAzU+WHNq94wFnfrjcEMjnC1NEpU4H+7KJETTCjTTdwDli252zrtZyokQVy+exfAm7cdLD+Pr3A8Eiv5t9oc5ymTYJU42qwNYUbyshLLgvXDe/yD7AYzopYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719537081; c=relaxed/simple;
	bh=AX6vzRoEhZIXhTB8bmQXDahq6Kmf4gcwbghJqr+xbNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QokUq3X5ZRfHg7N3FsABrbJXuGk3PSLoNb4TvoxVX+sDfY/fAttKVP3LeEfgua+9CSRwDq/JM4mh17/IQU5CKRZuSKXHf+cpX+NqWlOB8fi2FDT432bsKqayuUBqfhDn4RZV6Tr7a0BetQvMwgiRSbWh3YN1NvNqmXBJr+aBnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sN08u-000000000E1-0yNQ;
	Fri, 28 Jun 2024 01:11:12 +0000
Date: Fri, 28 Jun 2024 02:11:07 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: aquantia: add support for
 aqr115c
Message-ID: <Zn4Nq1QvhjAUaogb@makrotopia.org>
References: <20240627113018.25083-1-brgl@bgdev.pl>
 <20240627113018.25083-4-brgl@bgdev.pl>
 <Zn3q5f5yWznMjAXd@makrotopia.org>
 <d227011a-b4bf-427f-85c2-5db61ad0086c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d227011a-b4bf-427f-85c2-5db61ad0086c@lunn.ch>

On Fri, Jun 28, 2024 at 02:18:45AM +0200, Andrew Lunn wrote:
> On Thu, Jun 27, 2024 at 11:42:45PM +0100, Daniel Golle wrote:
> > Hi Bartosz,
> > 
> > On Thu, Jun 27, 2024 at 01:30:17PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > 
> > > Add support for a new model to the Aquantia driver. This PHY supports
> > > Overlocked SGMII mode with 2.5G speeds.
> > 
> > I don't think that there is such a thing as "Overclocked SGMII mode with
> > 2.5G speed".
> 
> Unfortunately, there is. A number of vendors say they do this, without
> saying quite what they actually do.  As you point out, symbol
> replication does not work, and in-band signalling also makes no
> sense. So they throw all that away. Leaving just the higher clock
> rate, single speed, and no in-band signalling.
> 
> In the end, that looks very similar to 2500BaseX with broken inband
> signalling.

Let's call it that then: "2500Base-X with broken in-band signalling".

MaxLinear describes that quite clearly in their (open!) datasheets[1],
and gives some insight into the (mis-)use of the term "SGMII" in the
industry as synonymous to just any type of serialized Ethernet MII:

"
3.4 SGMII Interface

The GPY211 implements a serial data interface, called SGMII or SerDes,
to connect to another chip implementing the MAC layer (MAC SoC).
"
(page 32)

Later on they mention that
"
3.4.7 Auto-negotiation Modes Supported by SGMII

Two modes are supported for the SGMII auto-negotiation protocol:
 * Cisco* Serial-GMII Specification 1.8 [4]
 * 1000BX IEEE 802.3 following IEEE Clause 37 [2]
"
(page 37)

Aquantia's datasheets are only available under NDA, so I cannot quote
them directly, but I can tell you that their definition of "SGMII" is
pretty similar to that of MaxLinear.

> 
> > Hence I assume that what you meant to say here is that the PHY uses
> > 2500Base-X as interface mode and performs rate-adaptation for speeds
> > less than 2500M (or half-duplex) using pause frames.
> 
> Not all systems assume rate adaptation. Some are known to use SGMII
> for 10/100/1G with inband signalling, and then swap to 2500BaseX
> without inband-signalling for 2.5G operation!

Yes, most 2.5G PHYs out there (MaxLinear, RealTek) actually support both,
with interface-mode switching being the better option compared to often
rather problematic rate-adaptation...

When it comes to Aquantia we are using 2500Base-X with rate adaptation
for the older 2.5G PHYs, so I assume the newer ones would not differ in
that regard. Or rather: If we were to introduce interface-mode-switching
also for the Aquantia 2.5G PHYs then we should try doing it for all of
them at least.

> 
> 2.5G is a mess.

+1

[1]: https://assets.maxlinear.com/web/documents/617810_gpy211b1vc_gpy211c0vc_ds_rev1.4.pdf

