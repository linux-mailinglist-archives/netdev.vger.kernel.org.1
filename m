Return-Path: <netdev+bounces-54083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58D805FAE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927E91C20943
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 20:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490436A010;
	Tue,  5 Dec 2023 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZpQK+Jm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D717692AA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 20:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA5C433C8;
	Tue,  5 Dec 2023 20:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701809192;
	bh=EcxrluR7rHeirw8m6JBZ9mBIrJoWhLdESfw1gflpKTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZpQK+Jm3hMwnnABUGccgKc27HvKxV5HlQpiX/Y5Prx2ANrbVk7G8l0fQo/ogL848
	 y/dwAy19hoJAVfdXFlKzNkHnqgQyyUFFajTt6ai8H0TXqhEthLsrZwG4fv7rMLC4PN
	 6/+rFsUYzSGuHX/xFr+KdRX14cisAdJvSGvEI7SFTtd4cXFLCg1JyR4rZRzfXv+XnV
	 RUJmD9vCAuN81nfFRzbb59OJJeGhJj+QpR/Qr7c9ps9EG3pKfCmUQdzrpF9TXP1Wk1
	 n7JYlorlxx0OKRWILXc+D4J2jwr03Uvz+F3yUIMi/6oyUGItzjrAK4THiFcXQlqGNm
	 FQeEtlPeA5TxA==
Date: Tue, 5 Dec 2023 20:46:28 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net] ice: fix theoretical out-of-bounds access in ethtool
 link modes
Message-ID: <20231205204628.GX50400@kernel.org>
References: <20231130165806.135668-1-mschmidt@redhat.com>
 <f78a8937-0811-03e8-464d-47f404a3718b@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f78a8937-0811-03e8-464d-47f404a3718b@intel.com>

On Fri, Dec 01, 2023 at 08:33:36AM +0100, Przemek Kitszel wrote:
> On 11/30/23 17:58, Michal Schmidt wrote:
> > To map phy types reported by the hardware to ethtool link mode bits,
> > ice uses two lookup tables (phy_type_low_lkup, phy_type_high_lkup).
> > The "low" table has 64 elements to cover every possible bit the hardware
> > may report, but the "high" table has only 13. If the hardware reports a
> > higher bit in phy_types_high, the driver would access memory beyond the
> > lookup table's end.
> > 
> > Instead of iterating through all 64 bits of phy_types_{low,high}, use
> > the sizes of the respective lookup tables.
> > 
> > Fixes: 9136e1f1e5c3 ("ice: refactor PHY type to ethtool link mode")
> > Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > index a34083567e6f..bde9bc74f928 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -1850,14 +1850,14 @@ ice_phy_type_to_ethtool(struct net_device *netdev,
> >   	linkmode_zero(ks->link_modes.supported);
> >   	linkmode_zero(ks->link_modes.advertising);
> > -	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
> > +	for (i = 0; i < ARRAY_SIZE(phy_type_low_lkup); i++) {
> >   		if (phy_types_low & BIT_ULL(i))
> >   			ice_linkmode_set_bit(&phy_type_low_lkup[i], ks,
> >   					     req_speeds, advert_phy_type_lo,
> >   					     i);
> >   	}
> > -	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
> > +	for (i = 0; i < ARRAY_SIZE(phy_type_high_lkup); i++) {
> >   		if (phy_types_high & BIT_ULL(i))
> >   			ice_linkmode_set_bit(&phy_type_high_lkup[i], ks,
> >   					     req_speeds, advert_phy_type_hi,
> 
> I guess that that "HW reported" number really goes through the FW in
> some way, so one could indeed spoil that in some way,
> what makes sense to target it at -net.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


