Return-Path: <netdev+bounces-235240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4928DC2E31F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 22:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA993BD4B1
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4BC2DAFC8;
	Mon,  3 Nov 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hP2PCmsQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F72D73A6
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206562; cv=none; b=EATjJpiv4KynA4KgXYqWCnW0q8B5IMby2sJVkot0fg0d5JrDvvUCZNrOP4Suan23jzqjJHMK4UCUXEebfAS1T9xQqfm0SR0elkRh8R6GmS+MwYTAHD/qYNbb/2ugDAVp8ZdA+wVxgMnSl3vV/OF9yG6A5LymhLl8VnN7G7b86J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206562; c=relaxed/simple;
	bh=bKIpJqI60i8SELaBcfti0szCqJKqc6X+ZQ8D+NzlItM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V07rdkFtPkOlCOqMJYOno4beItY7kVZGtEuJjg1hTlt+BEl4i9uBub/ignS54jXzNo5XcqzmjbEf0KBeH38Ijjz9qQisHbGCaabzpBcnaTxMTCZ90orWQg2iQ5YDvvxvx+6a2q23Tpi/iwQyIVO01V3WMlmYPmcaXsBVzof38LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hP2PCmsQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qUcl+FLDP9DUn9+R6gAUKDMu6yC43VqE6BlTTJx/il4=; b=hP
	2PCmsQkq4mTEUsdujzsVDHaB7fIQrNrURbQoNkPkTrAFXgyOvE/+oPBEUFBIJIfaT8cNqRWD5z8Aw
	AUMzFGa5FX7U4FSN+W+gXY7hl0WD6Ax/SWVfDPmYW33S3uRSG50n/hB5h582amwgIEERrt+GPg5g1
	01WUR47QZ1gncRM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vG2QM-00Cp5K-06; Mon, 03 Nov 2025 22:49:14 +0100
Date: Mon, 3 Nov 2025 22:49:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH v2 09/11] fbnic: Add SW shim for MDIO interface
 to PMA/PMD and PCS
Message-ID: <9628b972-d11f-4517-97db-a4c3c288dbfa@lunn.ch>
References: <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
 <176218926115.2759873.9672365918256502904.stgit@ahduyck-xeon-server.home.arpa>
 <2fabbe4a-754d-40bb-ba10-48ef79df875c@lunn.ch>
 <CAKgT0UeiLjk=9Ogqy1NU-roz4U32HXHjVs8LqRKEdnPqYNcBjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UeiLjk=9Ogqy1NU-roz4U32HXHjVs8LqRKEdnPqYNcBjQ@mail.gmail.com>

On Mon, Nov 03, 2025 at 12:18:38PM -0800, Alexander Duyck wrote:
> On Mon, Nov 3, 2025 at 10:59 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > The interface will consist of 2 PHYs each consisting of a PMA/PMD and a PCS
> > > located at addresses 0 and 1.
> >
> > I'm missing a bit of architecture here.
> >
> > At least for speeds up to 10G, we have the MAC enumerate what it can
> > do, the PCS enumerates its capabilities, and we read the EERPOM of the
> > SFP to find out what it supports. From that, we can figure out the
> > subset of link modes which are supported, and configure the MAC and
> > PCS as required.
> 
> The hardware we have is divisible with multiple entities running it
> parallel. It can be used as a single instance, or multiple. With our
> hardware we have 2 MACs that are sharing a single QSFP connection, but
> the hardware can in theory have 4 MACs sharing a QSFP-DD connection.
> The basic limitation is that underneath each MAC we can support at
> most 2 lanes of traffic, so just the Base-R/R2 modes. Effectively what
> we would end up with is the SFP PHY having to be chained behind the
> internal PHY if there is one. In the case of the CR/KR setups though
> we are usually just running straight from point-to-point with a few
> meter direct attach cable or internal backplane connection.

We need Russell to confirm, but i would expect the SFP driver will
enumerate the capabilities of the SFP and include all the -1, -2 and
-4 link modes. phylink will then call the pcs_validate, passing this
list of link modes. The PCS knows it only supports 1 or 2 lanes, so it
will remove all the -4 modes from the list. phylink will also pass the
list to the MAC driver, and it can remove any it does not support.

It also sounds like you need to ask the firmware about
provisioning. Does this instance have access to 1 or 2 lanes? That
could be done in either the PCS or the MAC? The .validate can then
remove even more link modes.

> To
> support that we will need to have access to 2 PCS instances as the IP
> is divisible to support either 1 or 2 lanes through a single instance.

Another architecture question.... Should phylink know there are two
PCS instances? Or should it see just one? 802.3 defines registers for
lanes 0-3, sometimes 0-7, sometimes 0-9, and even 0-19. So a single
PCS should be enough for 2 lanes, or 4 lanes.

> Then underneath that is an internal PCS PMA which I plan to merge in
> with the PMA/PMD I am representing here as the RSFEC registers are
> supposed to be a part of the PMA. Again with 2 lanes supported I need
> to access two instances of it for the R2 modes. Then underneath that
> we have the PMD which is configurable on a per-lane basis.

There is already some support for pma configuration in pcs-xpcs. See
pcs-xpcs-nxp.c. 

> The issue is that the firmware is managing the PMD underneath us. As a
> result we don't have full control of the link. One issue we are
> running into is that the FW will start training when it first gets a
> signal and it doesn't block the signal from getting to the PCS. The
> PCS will see the signal and immediately report the link as "up" if the
> quality is good enough. This results in us suddenly seeing the link
> flapping for about 2-3 seconds while the training is happening. So to
> prevent that from happening we are adding the phydev representing the
> PMD to delay the link up by the needed 4 seconds to prevent the link
> flap noise.

So it seems like you need to extend dw_xpcs_compat with a .get_state
callback. You can then have your own implementation which adds this 4
second delay, before chaining into xpcs_get_state() to return the true
state.

	Andrew

