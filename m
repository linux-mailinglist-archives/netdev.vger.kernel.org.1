Return-Path: <netdev+bounces-275606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG6kDa6/02n6lQcAu9opvQ
	(envelope-from <netdev+bounces-275606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:14:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A951A3A3D3C
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C21B3300EC84
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D6322749;
	Mon,  6 Apr 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMjTvXiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C42DFA4A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484427; cv=none; b=fx9QljOLoU+LtjGoGBUo6ZuA7P91D/71fUCPybSHLA/o44A/AxsjZAc6YOKjnK9aNyASvPTk3K5KuSN0cCLDp7TgwWFQgpOQ5S/bzIR20ZGNMZQPoZ0OqAwiguWRTP5drXnIxayvgkeb1vzswalXuO0cSTF5JO26MjQpqpRilc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484427; c=relaxed/simple;
	bh=MAH6RptzeDcpL5V+g/KSRmtMJlqdvpcbYjcxWTTBuNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMwNSSSy15aTuO2bH/buXfQZI+sZZVot7sAnTEez0mZm61/6f4EINFded5LawJ7E7r1qF65kM5oTEe//UugdPZ9QrK2XDZtfbWa0vlY+piIuAwlZQ878dJKOAAF/Gn1THWiPaU85dlHAKlR70VPfX0EBDQBZxIxsJGFiQPb2frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMjTvXiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE4C4CEF7;
	Mon,  6 Apr 2026 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775484426;
	bh=MAH6RptzeDcpL5V+g/KSRmtMJlqdvpcbYjcxWTTBuNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMjTvXiFqY1RT8PIZv436z/iQGl8Ay6NcjanNYH15fxJmVRsksQBoblZLQvKslbhA
	 rITkdThslYEyw/3zQXVQDFTbSrp/8vivYgHuar5g+NzKgvU4rSRznWmFq6KC6HbGCL
	 5Lh+y/YJV/H8AV+B6MF3A+RPODuYrVd7axqEXyCHO2dOeqPdA4oDcP5uWIpYUxlKZm
	 1QnFxzuC+mIhlzBiaKClEAbhgxGUq+Jl1+u4tqecdPHP0Gg1FVFR2mRZ9yJ96WPGbS
	 v+DnTfwNADqx483FGIvNWDb5XNdF7xGPVy5yPU0tw25owTMX7WrBPXSSEZAdxyt0e3
	 MvNrspYXMturg==
Date: Mon, 6 Apr 2026 15:07:03 +0100
From: Simon Horman <horms@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
 ixgbe_ptp_reset()
Message-ID: <20260406140703.GD395680@kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-5-aleksandr.loktionov@intel.com>
 <20260403131035.GA113102@horms.kernel.org>
 <20260403131159.GA114708@horms.kernel.org>
 <DS0PR11MB7579E948B1DAEF3E8D28C1EBD65EA@DS0PR11MB7579.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7579E948B1DAEF3E8D28C1EBD65EA@DS0PR11MB7579.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[osuosl.org:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275606-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.505];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A951A3A3D3C
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Fri, Apr 03, 2026 at 08:26:20PM +0000, Keller, Jacob E wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Friday, April 3, 2026 6:12 AM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; netdev@vger.kernel.org; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Marcin Szycik <marcin.szycik@linux.intel.com>
> > Subject: Re: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
> > ixgbe_ptp_reset()
> > 
> > On Fri, Apr 03, 2026 at 02:10:38PM +0100, Simon Horman wrote:
> > > On Fri, Mar 27, 2026 at 08:30:39AM +0100, Aleksandr Loktionov wrote:
> > > > From: Jacob Keller <jacob.e.keller@intel.com>
> > > >
> > > > Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> > > > ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
> > > > avoids the unnecessary intermediate ktime_t variable and makes the
> > > > intent clearer.
> > > >
> > > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > > > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > >
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > >
> > > FWIIW, this pattern also seems to exist in e1000e, ixgbe and igb (twice).
> > 
> > Of course, with this patch applied it's not present in ixgbe anymore :^)
> 
> Right. Given that e1000e and igb are basically on life support only, I
> would limit touching them unless we have relevant work to do in that area
> in the future.

Sure, that is fine by me.

