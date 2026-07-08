Return-Path: <netdev+bounces-305947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9im4L5OXTmp1QAIAu9opvQ
	(envelope-from <netdev+bounces-305947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:31:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AACC729859
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:31:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gUp7BK0u;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305947-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305947-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC24D3018771
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4F3BD644;
	Wed,  8 Jul 2026 18:31:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264E37649A
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:31:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535505; cv=none; b=eGip+pdxPpdgGEzSnZW+5nu38Xx2rzMsieHsVEAeirdXWCdxH6ZGhTVGyBGGc8J38WA3XrMpqi8sExCMXHjsqJvayK4+SzdVwa7W41weVXC42sqjgJjSunrSZndCWthi6s6yMWuopZEmY58uzHxloBS1TgMhvaXb+Iwbj9I44SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535505; c=relaxed/simple;
	bh=/OYBvD8w27A84ib7crH5i7VQCld9zY43nRchmXLbt5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8Jm5aXv724IR089xgKWIBgxaUXzfrNZWym5FOxJThuLSvVNrYs/jwHj5Vx4xQicdx3fiK8QrBbi2wIX2IVT0XJ5M7EUy7yR+xncpimsypcxNNXS9YKMyIMLXPdp9++kPqLNgM7QPFtkGLqeWoE94nXNIyYgL7Ou2PGwBb79AWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUp7BK0u; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594061F000E9;
	Wed,  8 Jul 2026 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783535504;
	bh=vnpc+0AH8CrNGReb0Fv2l86Pm0BA12D/xz718fUUFis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gUp7BK0ujx+doynC8fr9Y2IoyLR39ZswQnALsAFA+3S76GspsHGBf2WklNckinVpC
	 z7tNPdpZUx213yND5uuvZHcj+n3Lnov8XEVid8uvUx9pyldh0PEEJtIqdsii2ijKLb
	 gAHkM81CJbbtgDNgm7dz+NrKjzLukl+lMmVL7Sp8VyAWmV9V6Ew/35P/h9Nw4rtcX0
	 XuRY8AZfiK8H5LhXNJ4UfFr1C9EGGzqnt0aF2hNY38qI42KdLIKHaB0vCsK/HOzBZ3
	 kJEfbAKi0nL3VoAo7K8bZX+Wb2hhing81BXVCrOGjTGUSx7OU8Z8jugeWE8KYtHze8
	 W0CmfAvymaPPw==
Date: Wed, 8 Jul 2026 19:31:40 +0100
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kuba@kernel.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Subject: Re: [PATCH v5 net 2/7] i40e: avoid null ptr dereference in
 i40e_ptp_stop()
Message-ID: <20260708183140.GK1364329@horms.kernel.org>
References: <20260701124524.13644-3-maciej.fijalkowski@intel.com>
 <20260708150455.1498611-2-horms@kernel.org>
 <ak6HOhJh/pxdloEs@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak6HOhJh/pxdloEs@boxer>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305947-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,m:jacob.e.keller@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AACC729859

On Wed, Jul 08, 2026 at 07:22:02PM +0200, Maciej Fijalkowski wrote:
> On Wed, Jul 08, 2026 at 04:04:56PM +0100, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > i40e: avoid null ptr dereference in i40e_ptp_stop()
> >     
> > Check if main_vsi is not null before calling dev_info() to avoid a null
> > pointer dereference when i40e_vsi_clear() frees the main VSI during rebuild.
> > 
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > index ff62b5f2c8150..ca93df4d67859 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > @@ -1556,8 +1556,9 @@ void i40e_ptp_stop(struct i40e_pf *pf)
> > >  	if (pf->ptp_clock) {
> > >  		ptp_clock_unregister(pf->ptp_clock);
> > >  		pf->ptp_clock = NULL;
> > > -		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> > > -			 main_vsi->netdev->name);
> > > +		if (main_vsi)
> > > +			dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> > > +				 main_vsi->netdev->name);
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but this lockless check appears
> > to introduce a time-of-check to time-of-use race condition.
> 
> Thanks Simon I saw these, however since all of the issues are classified
> as pre-existing issues IMHO these changes are okay to be taken and then
> we could go with another round of fixes.

Yes, agreed. Sorry about the noise.

