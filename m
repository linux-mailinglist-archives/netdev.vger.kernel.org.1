Return-Path: <netdev+bounces-228841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E1BD560B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 19:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94394257F8
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015292C028C;
	Mon, 13 Oct 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pA2g89KP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484127FB2A;
	Mon, 13 Oct 2025 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373134; cv=none; b=SkdXevQugqz6favniOBbdYpCFKlkwoKLZmU3JkWTmwuzrI2voNZbyhsNWBnFAXcV2ihbKpnl2oXoRPwUVVi8CLgl3iuo8Lyye6k16HGdMhbGGvLa/Wb2WOTTMtY47L+wa0KK1HHUsYqUFsFkfK524IdZ7Wcl0E8HmhGbx5NSf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373134; c=relaxed/simple;
	bh=iY5Uc4N1spkTNm7yswBzVuZtLtP3EszV/g3z8a10PW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEnTP4yApPptiz1TOKpHKQ0qk2dpaY5/ivE8aJaOW4A9JCE+P6y08++9FjPqimgShnGyDcSYCtTHtFbqhSm+OyJCGIfnWv0tNGSHkBKr7ZKjP0B1TkCFT+HHJxtUpLh6hO3bRNq3/wy4ur3zxZdR5izwrMk/kdcn2/KK5k1XWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pA2g89KP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sZscqZKkrNU08pkD7g5GNPeeLKmgl6YVw6Z3iAshFp0=; b=pA2g89KPSLdEPDFcmMTLhja5qj
	npwWUWySPoFAPBw5jdlzu5ouH/bNi5WljygVD0FlY9joqRK77CpqTut6tvbuhtwsdJ7FGXcV3tLx6
	TqQVLWwXXbBP0Q1GVHDceWW4NMO5Kd+7T8XUMB5ZD8nYtPTIIJNLc1GbnRaH3vL0uVkQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8LSo-00AoSk-Pc; Mon, 13 Oct 2025 18:31:58 +0200
Date: Mon, 13 Oct 2025 18:31:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ixgbe: Add 10G-BX support
Message-ID: <b5dd3a3e-2420-4c7c-b690-3799fac14623@lunn.ch>
References: <20251013-10gbx-v1-1-ab9896af3d58@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-10gbx-v1-1-ab9896af3d58@birger-koblitz.de>

> @@ -1678,6 +1679,26 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
>  			else
>  				hw->phy.sfp_type =
>  					ixgbe_sfp_type_1g_bx_core1;
> +		/* Support Ethernet 10G-BX, checking the Bit Rate
> +		 * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
> +		 * Single Mode fibre with at least 1km link length
> +		 */
> +		} else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
> +			   (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
> +			   (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
> +			status = hw->phy.ops.read_i2c_eeprom(hw,
> +					    IXGBE_SFF_SM_LENGTH,
> +					    &sm_length);

It seems like byte 15, Length (SMF), "Link length supported for single
mode fiber, units of 100 m" should be checked here. A 255 * 100m would
be more than 1Km, the condition you say in the comment.

	Andrew

