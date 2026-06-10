Return-Path: <netdev+bounces-297692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rNNoDdFuKWpHWwMAu9opvQ
	(envelope-from <netdev+bounces-297692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F366A11C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=muv6aSst;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297692-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297692-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9101A319EED2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0AC416D1B;
	Wed, 10 Jun 2026 13:57:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1F4071CA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:57:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099840; cv=none; b=muKXleNWWweiLJLgOw+0T7KNP9b+swVaNoX2f9WhUftLz+AgVjq769X/Z6Spq4EIc5SaBIiXu/0RwhiCJbmNSkr0a559um+lfdZRvCKNUnSfaP6azMaDRddNtPxK1bqHTTPAimvw8j0r9f1RSYmq/1aBQxdsvKPwYQ6i+jDH7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099840; c=relaxed/simple;
	bh=fzWB4kxadpLfTCMoiRfgSxMiKNXKfXfcECHeLrOiEPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsISTHUMWSgiz2cjBnuUWdngPGsS+yoHwYxBCShSPGGIihtyXiK527hPsDvD1yx6Gj+pfrAi3IrReGosSqvLh4s4tmCgH6RzetmbugMZJ3aAEhJalxkBG6p7i/h2hRlFILnWxeC/Nkk8zwr/CGN3RJb1biz5g4aLhteGzJi+JcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muv6aSst; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D361F00893;
	Wed, 10 Jun 2026 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099839;
	bh=L5C3ussGByA9i7+3Y4M9b5bsaS5ARFq9X8h53aSoPEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=muv6aSstXmClq7TOtm27CPmIBazyJZTdkK02DTfhLUNNvL1po573EcRUqLW5cdJde
	 +7Em78k9lvzqGTfIjmnG42RoS4u+ZyES7+Npz7BeCm8fLyz69F7O8u7GQcrpIIb3wj
	 GukK5mt7HhZ2roOaWEyNQwRp7DVAvQWgf7z4V7vUFBb8CoJBIgorrFFKQfzeVZDNVO
	 goRU0GaCiE3Aqvq6WqrL/l0rQXVOKuUAwlvZkBZdW6jqsvP5qNosxOXSk+tnnpRd+G
	 zjbhyGZm9SV5lylYDRr8zhLjVpodOippCKdBIPuyvIeZBmysfirxu+2u3l6qsSRLr1
	 mG7Zrqcaw6x6w==
Date: Wed, 10 Jun 2026 14:57:15 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	konstantin.ilichev@intel.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH iwl-net v3] ice: fall back to SBQ when LL PHY timer
 interface times out
Message-ID: <20260610135715.GL3920875@horms.kernel.org>
References: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605120734.1462847-1-przemyslaw.korba@intel.com>
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
	TAGGED_FROM(0.00)[bounces-297692-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:przemyslaw.korba@intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:konstantin.ilichev@intel.com,m:aleksander.lobakin@intel.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B0F366A11C

On Fri, Jun 05, 2026 at 02:06:26PM +0200, Przemyslaw Korba wrote:
> The low-latency (LL) PHY timer interface relies on a tight, atomic poll
> of the PF_SB_ATQBAL register with a 2ms timeout. After an NVM update /
> EMPR, FW may need significantly longer than 2ms to start responding to
> ATQBAL commands. The first PHY adjust or incval write issued by
> ice_ptp_rebuild_owner() fails with -ETIMEDOUT.
> 
> Fix this by falling back to the existing SBQ-based PHY register write
> path when LL times out. This makes sure PTP is initialized when FW takes
> longer than expected to come back online.
> 
> Steps to reproduce:
> ./nvmupdate64e -if devlink -f
> Update E810 card with nvmupdate64e, and observe dmesg errors:
>   Failed to write PHC increment value, status -110
>   PTP reset failed, error: -110 (-ETIMEDOUT)
> 
> Fixes: ef9a64c07294 ("ice: implement low latency PHY timer updates")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> ---
> v3:
> * actually add TIMEDOUT check in ice_prep_phy_adj_e810 (did do it)
> v2:
> * add TIMEDOUT check in ice_prep_phy_adj_e810 (did not do it)
> https://lore.kernel.org/intel-wired-lan/20260603114904.1297713-1-przemyslaw.korba@intel.com/
> v1:
> https://lore.kernel.org/intel-wired-lan/20260511095830.1095984-1-przemyslaw.korba@intel.com/
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 38 +++++++++++----------
>  1 file changed, 20 insertions(+), 18 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>


