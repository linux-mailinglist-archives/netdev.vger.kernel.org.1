Return-Path: <netdev+bounces-287570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLgyCQBrBGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:13:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B50532E07
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CF67304BB52
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34823FF88C;
	Wed, 13 May 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1YNvFRI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BE3FCB03
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674416; cv=none; b=EYNQlY2sg+FIqZegITDXG1Zv7rYOKj2J1O7HseloRqOJxDddqqMqDQTqTMdWqC8T8CYVzutBouKjFvpDIOAfLgUNNh/r4weeKTgAE55TqEhzz1h5Tuvic0Uz2i/VGXXkvjGA6EmUCs3l0GZeUap7C3vkBe71VNzvF/64ntq7cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674416; c=relaxed/simple;
	bh=CpGkwp82wpNTsFSWengLwbabkK/i3jYuaJc8/HRvkyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCvrIHj/u1R3xXrseodtv163xInzWCns300izqXfgO4lk5MnH8+S+fxln/HFOgiQtyXMrGh5Kr+hrNBnWp5IjWczo5BXnhTkGy6v1hS5JTNNBTTTSfUFGOO9+u3RI2Ck/EoaSNHDbRCUowziUJzPDtKfvbXMegUQB3r6I3NbGRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1YNvFRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22810C2BCB7;
	Wed, 13 May 2026 12:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778674416;
	bh=CpGkwp82wpNTsFSWengLwbabkK/i3jYuaJc8/HRvkyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1YNvFRIFV8CHf+W1DKVzkwyKVs44h9UBuC9M/Xnqs7EZbpb6VkW+ccQvPBgDLs8D
	 puBPozY0kBl6dmg3L5S0sVInJiimgSjHynHFzxsq/9vf97GC5Db/7qdOCHuAzqLgHH
	 atYkSSGmurJu2TOgQB+EbHPtVSCVZJTdTbiYMPCNE8M3TPDkBj7QBruMdMOr3tC23t
	 mi5zisMR26mhLsBg3P2VmpI0PRt5Eb+DUNo/7VOwaGm5fFuuSuGATqIpdZtzVo0HBl
	 8dMMurnFJLGwG79dXdAflWk1AWZMKP9V17d9BC92mVMiulyN8/i4NxTL4n0/QimtcL
	 luK67sm+27bcA==
Date: Wed, 13 May 2026 13:13:32 +0100
From: Simon Horman <horms@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next 6/8] ixgbe: extract ixgbe_restart_auto_neg() to
 avoid code duplication
Message-ID: <20260513121332.GA136966@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-7-aleksandr.loktionov@intel.com>
 <20260511154043.GC27589@horms.kernel.org>
 <IA3PR11MB8986A411A8E4C16AA67F2709E5392@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986A411A8E4C16AA67F2709E5392@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Rspamd-Queue-Id: B5B50532E07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid,intel.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 01:42:39PM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, May 11, 2026 5:41 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org
> > Subject: Re: [PATCH iwl-next 6/8] ixgbe: extract
> > ixgbe_restart_auto_neg() to avoid code duplication
> > 
> > On Fri, May 08, 2026 at 05:12:24AM +0200, Aleksandr Loktionov wrote:
> > > From: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> > >
> > > Both ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx()
> > end
> > > with the same three-line sequence that reads MDIO_CTRL1, sets the
> > > MDIO_AN_CTRL1_RESTART bit, and writes MDIO_CTRL1 back.
> > >
> > > Factor it out into a static helper ixgbe_restart_auto_neg() and call
> > > it from both sites.
> > >
> > > While at it, also check the return value of phy.ops.read_reg() in
> > the
> > > helper and skip the write on failure.  The original inlined code
> > > ignored the read result and would OR MDIO_AN_CTRL1_RESTART into a
> > > stale autoneg_reg value (left over from the prior MDIO_AN_ADVERTISE
> > > write) and unconditionally write it back to MDIO_CTRL1 if the read
> > > failed.  This is a small behavioral change: on read_reg() failure
> > the
> > > restart write is now skipped instead of being issued with a
> > > potentially garbage value.
> > >
> > > Signed-off-by: Jakub Chylkowski <jakubx.chylkowski@intel.com>
> > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > FWIIW, the AI-generated review of this patch available on sashiko.dev
> > flags that similar problems wrt write on failre exist earlier on in
> > ixgbe_setup_phy_link_generic(). It may be good to address this area
> > more holistically as a follow-up. (I am not suggesting increasing the
> > scope of this patch/patch-set.)
> > 
> > ...
> 
> Thanks for the review!
> 
> On the min() nit - the operation here is "clamp the new (smaller) itr
> at a floor of prev - IXGBE_ITR_ADAPTIVE_MIN_INC", which max_t()
> expresses directly. Rewriting with min() would need to flip the
> reference point, e.g.
> 
> itr = ring_container->itr - min_t(unsigned int,
> ring_container->itr - itr,
> IXGBE_ITR_ADAPTIVE_MIN_INC);
> 
> which adds a subtraction and reads less naturally than the floor form.
> I'd prefer to keep max_t() here unless you feel strongly - your
> Reviewed-by stands either way, and I've added it for v5. Thanks again.

Thanks, I don't feel strongly about max_t().

