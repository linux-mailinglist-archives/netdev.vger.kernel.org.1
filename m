Return-Path: <netdev+bounces-174390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4470DA5E759
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D0816DD65
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999731EFFAD;
	Wed, 12 Mar 2025 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f15VbVfm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614F1E5714
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818342; cv=none; b=XgRF+3yCaVbp35ZFEqlYWD63EgWQo2UyI6/SRsDRQU1uCN1XprW1iyqzxpg70j7lmntEUi8WnDbxc2sfdSNLOlJciBvUbG92ala0YiD+KMFLKktgLdYdKPGwc+CfCagfXk17VXZ2tfv2LFNvWTa6+zkqvhW8aaE17Avmdj7Uhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818342; c=relaxed/simple;
	bh=gIKv/8obtKeHq+ynwm+rCQqDpnJZeDXZkrZ6kOI6dU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjlySyryPi9btrNkuv980VA4g+TfCj89JzDnFKnG6pgjx009cnPprle7fL8tB4bVdsNvL+m3FiB3gbrirsu5ov7M/oUY2IwladP3kVBNFEtFLQE46ImFEXscJex93zVcXEPbTsPnEXdMnO1IIqLluKUoaqVVzJBFqNYDDZ73Ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f15VbVfm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rBuXBus5iFIGWKaTiHoIllR3Mb8mgIIt7od8i9FpuGI=; b=f15VbVfmYohFagLD6N1ENLriN7
	BCnq2HcMX86RPea0zDYsjyczMHzDCsgPfqgiQDuBuohrzF8+0Wo2wspeGj0gLTP1piaVAG2ANtjVX
	Gk4VSqg6aqEyfsjoVyMi5lc2YGaYCORMaTtnS2eCxn08QhDmoj9e1U2dAcmCo8fUOYIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsUW2-004noa-Bs; Wed, 12 Mar 2025 23:25:30 +0100
Date: Wed, 12 Mar 2025 23:25:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Cc: "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] igb: Prevent IPCFGN write resetting autoneg
 advertisement register
Message-ID: <0486c877-cbb4-411b-9bd6-9b10306c47a6@lunn.ch>
References: <20250312032251.2259794-1-hamish.martin@alliedtelesis.co.nz>
 <eae8e09c-f571-4016-b11d-88611a2b368f@lunn.ch>
 <9455a623aaeb08999eec9202459d266f22432c00.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9455a623aaeb08999eec9202459d266f22432c00.camel@alliedtelesis.co.nz>

> Hi Andrew,
> 
> Thanks for your feedback. I'll try and give more detail about what's
> happening with a concrete example.
> 
> If we start with the device in a state where it is advertising:
> 1000BaseT Full
> 100baseT Full
> 100baseT Half
> 10baseT Full
> 10baseT Half
> I see the following settings in the autoneg related registers:
> 0.4 = 0x0de1 (PHY_AUTONEG_ADV)
> 0.9 = 0x0200 (PHY_1000T_CTRL)
> 
> EEE is disabled.
> 
> If I then adjust the advertisement to only advertise 1000BaseT Full and
> 100baseT Full with:
> # ethtool -s eth0 advertise 0x28
> I see the following writes to the registers:
> 1. In igb_phy_setup_autoneg() PHY_AUTONEG_ADV is written with 0x0101
> (the correct value)
> 2. Later in igb_phy_setup_autoneg() PHY_1000T_CTRL is written with
> 0x0200 (correct)
> 3. Autoneg gets restarted in igb_copper_link_autoneg() with PHY_CONTROL
> (0.0) being written with 0x1340
> (everything looks fine up until here)
> 4. Now we reach igb_set_eee_i350(). Here we read in IPCNFG and it has
> value 0xf. EEE is disabled so we hit the 'else' case and remove
> E1000_IPCNFG_EEE_1G_AN and E1000_IPCNFG_EEE_100M_AN from the 'ipcnfg'
> value. We then write this back as 0x3. At this point, if you re-read
> PHY_AUTONEG_ADV you will see it's contents has been reset to 0x0de1.

Thanks for the additional details. These should go into the commit
message.

> If you run the same example above but with EEE enabled (ethtool --set-
> eee eth0 eee on; ethtool -s eth0 advertise 0x28) the issue is not seen.
> In this case the contents of IPCNFG are written back unmodified as 0xf.
> This seems important to avoid the bug.

Yes, it does seem like the PHY is broken. 

> 
> It seems that any case where EEE is disabled will lead to the
> undesirable behaviour where the contents of PHY_AUTONEG_ADV is reset to
> 0x0de1. The key trigger for this appears to be changes to either or
> both of EEE_100M_AN and EEE_1G_AN in IPCNFG. The datasheet does note
> that "Changing value of bit causes link drop and re-negotiation"

Which is what you would expect, since EEE is negotiated. But
implicitly changing the link modes advertised is not what you would
expect.

By the way, what PHY is this? I don't remember seeing any errata for
Linux PHY drivers resembling this.

> What's your opinion on that less invasive fix (i.e remove "ipcnfg &=
> ~(E1000_IPCNFG_EEE_1G_AN | E1000_IPCNFG_EEE_100M_AN);" )? Is it
> sufficient to rely on the EEER settings to control disabling EEE with
> the IPCNFG register still set to advertise those modes?

I actually think you need to do more testing. Assuming the PHY is not
even more broken than we think, it should not matter if it advertises
EEE mode for link modes which are not advertised. The link partner
should ignore them. It would be good if you tested out various EEE
combinations from both link partners sides.

However, setting EEE advertisement and then always setting link mode
advertisement does seem like a good workaround. It would however be
good to get some sort of feedback from the PHY silicon vendor about
this odd behaviour.

	Andrew

