Return-Path: <netdev+bounces-190232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C2AB5CF0
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75E1866AA7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7D239562;
	Tue, 13 May 2025 19:03:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7632139CF2;
	Tue, 13 May 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747163026; cv=none; b=Ib4UOW/coPXPNae3A+Iqx2LZj3Xd/vUCMORtB1gtBpRpR9DiQiNmYtlffXADxRnPpYjMrwSFSo+mFH0ZPWxoTx8/MaVnONFfz+c8rqpzQhtU847sZxW4yrjo7ZFHBrR3SwhtoKWXKUmKRrGz1f3dLerb7W1AWCFAVqzhTted8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747163026; c=relaxed/simple;
	bh=xOX2aEFNLfafziYim7DQ7yE2j/RCERFPYvsKlEZEDY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NO+RtyaN/IGz6CxPkmN9KbaWYNcIYSwyX2ucUmjV23ZD/S0Y4B709WsgUPXuu+Wg+HVd90xPDihdJYpq1ShdYSH7C4doTcirPKcfieHot2KTosex2NKOgANveNI8RTvmroD+MXHJmI6U9iM1SRLuUPh5/gmfjIWMgK6Ib3f/eyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uEuop-000000006PI-1lSq;
	Tue, 13 May 2025 19:03:31 +0000
Date: Tue, 13 May 2025 20:03:27 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [net-next PATCH v4 03/11] net: phylink: introduce internal
 phylink PCS handling
Message-ID: <aCOXfw-krDZo9phk@makrotopia.org>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
 <20250511201250.3789083-4-ansuelsmth@gmail.com>
 <5d004048-ef8f-42ad-8f17-d1e4d495f57f@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d004048-ef8f-42ad-8f17-d1e4d495f57f@linux.dev>

On Tue, May 13, 2025 at 02:18:02PM -0400, Sean Anderson wrote:
> On 5/11/25 16:12, Christian Marangi wrote:
> > Introduce internal handling of PCS for phylink. This is an alternative
> > to .mac_select_pcs that moves the selection logic of the PCS entirely to
> > phylink with the usage of the supported_interface value in the PCS
> > struct.
> > 
> > MAC should now provide an array of available PCS in phylink_config in
> > .available_pcs and fill the .num_available_pcs with the number of
> > elements in the array. MAC should also define a new bitmap,
> > pcs_interfaces, in phylink_config to define for what interface mode a
> > dedicated PCS is required.
> > 
> > On phylink_create() this array is parsed and a linked list of PCS is
> > created based on the PCS passed in phylink_config.
> > Also the supported_interface value in phylink struct is updated with the
> > new supported_interface from the provided PCS.
> > 
> > On phylink_start() every PCS in phylink PCS list gets attached to the
> > phylink instance. This is done by setting the phylink value in
> > phylink_pcs struct to the phylink instance.
> > 
> > On phylink_stop(), every PCS in phylink PCS list is detached from the
> > phylink instance. This is done by setting the phylink value in
> > phylink_pcs struct to NULL.
> > 
> > phylink_validate_mac_and_pcs(), phylink_major_config() and
> > phylink_inband_caps() are updated to support this new implementation
> > with the PCS list stored in phylink.
> > 
> > They will make use of phylink_validate_pcs_interface() that will loop
> > for every PCS in the phylink PCS available list and find one that supports
> > the passed interface.
> > 
> > phylink_validate_pcs_interface() applies the same logic of .mac_select_pcs
> > where if a supported_interface value is not set for the PCS struct, then
> > it's assumed every interface is supported.
> > 
> > A MAC is required to implement either a .mac_select_pcs or make use of
> > the PCS list implementation. Implementing both will result in a fail
> > on MAC/PCS validation.
> > 
> > phylink value in phylink_pcs struct with this implementation is used to
> > track from PCS side when it's attached to a phylink instance. PCS driver
> > will make use of this information to correctly detach from a phylink
> > instance if needed.
> > 
> > The .mac_select_pcs implementation is not changed but it's expected that
> > every MAC driver migrates to the new implementation to later deprecate
> > and remove .mac_select_pcs.
> 
> This introduces a completely parallel PCS selection system used by a
> single driver. I don't think we want the maintenance burden and
> complexity of two systems in perpetuity. So what is your plan for
> conversion of existing drivers to your new system?

Moving functionality duplicated in many drivers to a common shared
implementation is nothing unsual.

While this series proposes the new mechanism for Airoha SoC, they are
immediately useful (and long awaited) also for MediaTek and Qualcomm
SoCs.

Also in the series you posted at least the macb driver (in "[net-next
PATCH v4 09/11] net: macb: Move most of mac_config to  mac_prepare")
would benefit from that shared implementation, as all it does in it's
mac_select_pcs is selecting the PCS by a given phy_interface_t, which is
what most Ethernet drivers which use more than one PCS are doing in
their implementatio of mac_select_pcs().

Also axienet_mac_select_pcs() from "[net-next PATCH v4 08/11] net:
axienet: Convert to use PCS subsystem" could obviously very easily be
mirated to use the phylink-internal handling of PCS selection.


> 
> DSA drivers typically have different PCSs for each port. At the moment
> these are selected with mac_select_pcs, allowing the use of a single
> phylink_config for each port. If you need to pass PCSs through
> phylink_config then each port will needs its own config. This may prove
> difficult to integrate with the existing API.

This might be a misunderstanding. Also here there is only a single
phylink_config for each MAC or DSA port, just instead of having many
more or less identical implementations of .mac_select_pcs, this
functionality is moved into phylink. As a nice side-effect that also
makes managing the life-cycle of the PCS more easy, so we won't need all
the wrappers for all the PCS OPs.

