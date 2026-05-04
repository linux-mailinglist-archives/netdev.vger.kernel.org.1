Return-Path: <netdev+bounces-283746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FDGL3hW+GnTtAIAu9opvQ
	(envelope-from <netdev+bounces-283746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:19:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1837B4BA141
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7F13041AB5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD7C31A045;
	Mon,  4 May 2026 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0Os4fDi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2480318EF6
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882435; cv=none; b=KURci5b2HvzwaeHxOpOBZ/qyRSzEQOJ57J+e+Xn/xYWVu+0Bq5stoIt6xok/V0fGrqyDK6bhWYBgge4lxjSelUDpqRk1Pv4lbGr7UlCAfsqnVKMHgryyGW2f1lmlxSOVLEdhSKZ/r0mnat7gpKsFAXYmoTrIS/cQXKraabptv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882435; c=relaxed/simple;
	bh=i0ow0BGME4ktvZKUNMDO7lIwbJDhWGcBGUZClqgLTvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlyF5R2XrmdoEqEzVgzDlH+4ZANuzdXpf8UlLtzXrj1M5RNAgr2ogWqKeuJsYa8FQRmwSza76nzx655q03PDyz42SNczKiPsPvF4JXRMZQOnFj53JdZu7VsDKnYQGD6z+04/4rP6NCWjqzoy+hTP3DH6WV8srW2nXJadbo0ZREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0Os4fDi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777882434; x=1809418434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i0ow0BGME4ktvZKUNMDO7lIwbJDhWGcBGUZClqgLTvE=;
  b=C0Os4fDiK/tiJxWEygkm/r4sTvACATvvtm8Ebf4pL9vlN4At9W9/7TZb
   SL1YgRXP644wpbcdrvtsiIIBbFijc+n0h8VFX2eEnpOgWuuTWmV2o2AC9
   B6ASbWfNINq1g4H3Pq3qmpqJL4/sO0Qq5EwMkoXf2/6fhCnFqH3miLGeM
   TRS1OmB4X0YUFSD3BBgZ2jIlZDrdQY7KCPsCLohxOsX+6qgWnpfkWD90b
   BxMhb8teU5ZEv5BWxoRULUB7qHRpD/ddVa8J+g3VoE9TsQJU4Wc9/xo1Q
   /QkHwvwoXeG+ZVDlxMDRWkQ+c6csKi5cLpOg3mhQpcTznfX7O8ussmfv2
   w==;
X-CSE-ConnectionGUID: ObTG+0dPS+GYHRr/gVhZAg==
X-CSE-MsgGUID: EE0gWmiGSLmM8ptT+TeLyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="66267429"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="66267429"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:13:53 -0700
X-CSE-ConnectionGUID: FJTjzmBeRjKWGxOzEDSmhA==
X-CSE-MsgGUID: UPX6moqJSWqissfla8fyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230852817"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:13:51 -0700
Date: Mon, 4 May 2026 10:09:55 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: michal.swiatkowski@linux.intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, jramaseu@redhat.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com
Subject: Re: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of
 IP/IPV6
Message-ID: <afhUUwTq7xPSe75N@mev-dev.igk.intel.com>
References: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
 <20260430152948.1683359-2-horms@kernel.org>
 <20260430162149.GC900403@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430162149.GC900403@horms.kernel.org>
X-Rspamd-Queue-Id: 1837B4BA141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283746-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev-dev.igk.intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 05:21:49PM +0100, Simon Horman wrote:
> On Thu, Apr 30, 2026 at 04:29:49PM +0100, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> 
> Sorry, the email I am responding to was supposed to come with
> some commentary - it seems my method for adding it is broken :(
> So I'm adding it below (as best as I can remember what it was).
> 

Thanks for adding the comments.

> > ---
> > ice: use NETIF_F_HW_CSUM instead of IP/IPV6
> > 
> > This commit replaces the IP and IPV6 checksum offload flags with HW_CSUM
> > in the ice driver to allow hardware checksumming for IPv6 packets with
> > extension headers. It also removes the mutual exclusivity check between
> > TSO and GCS.
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > index 5f92377d4dfc..33f252a6a22f 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -3491,9 +3491,8 @@ void ice_set_netdev_features(struct net_device *netdev)
> > >  			NETIF_F_RXHASH;
> > >  
> > >  	csumo_features = NETIF_F_RXCSUM	  |
> > > -			 NETIF_F_IP_CSUM  |
> > >  			 NETIF_F_SCTP_CRC |
> > > -			 NETIF_F_IPV6_CSUM;
> > > +			 NETIF_F_HW_CSUM;
> > 
> > By advertising NETIF_F_HW_CSUM, the network stack assumes the driver can handle
> > checksums for any protocol and passes non-IP packets (e.g., from AF_PACKET
> > injected frames) to the driver with CHECKSUM_PARTIAL.
> > 
> > Since ice_tx_csum() strictly parses the L3 header and expects IPv4 or IPv6,
> > returning -1 for other protocols, will this regression cause non-IP packets to
> > be silently dropped instead of falling back to software checksums in the kernel?
> 
> The problem above seems to be a legitimate concern, if a corner case.
> It seems to also exist in i40e.
> 

I think there is a lack of skb_checksum_help() before one error return
from ice_tx_csum(). I will add it.

> > Additionally, skb_csum_hwoffload_help() relies on NETIF_F_IPV6_CSUM to
> > safely fall back to software checksums when IPv6 extension headers are
> > present.
> > 
> > Does using NETIF_F_HW_CSUM bypass this safeguard, potentially causing
> > legacy hardware (like E810) or E830 without GCS descriptors to compute
> > incorrect pseudo-headers and silently corrupt IPv6 packets with extension
> > headers?
> 
> The issue above seems to be a false positive as the ice driver
> doesn't rely on the behaviour described. Rather ice_tx_csum()
> uses ipv6_skip_exthdr() to correctly handle extension headers.
> 

Yeah, righ.

> > 
> > Finally, for protocols other than TCP, UDP, or SCTP, the driver falls back to
> > calling skb_checksum_help(skb) in the default case of ice_tx_csum().
> > 
> > However, the driver appears to ignore the return value of skb_checksum_help().
> > 
> > If skb_checksum_help() fails (e.g., due to -ENOMEM during pskb_expand_head()),
> > could this result in the packet being transmitted with an uncomputed checksum?
> 
> The problem above seems real to me, but it also seems to be pre-existing.
> So I don't think it should delay progress of this patch.
> 
> If it is a problem, it also seems to be present in i40e.

idpf, igbe too. It should return error in such case and drop the packet.
What do you think, should I add the patch for that here or send it separately?
To be honest I prefer sending it separately as this is in already exsisting
code and touch more than one driver.

Thanks

