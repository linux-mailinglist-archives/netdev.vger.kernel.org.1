Return-Path: <netdev+bounces-278092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOziJyr53GnXYgkAu9opvQ
	(envelope-from <netdev+bounces-278092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:09:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B733ED11B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 16:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 556E830416DC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CDF3CE4BC;
	Mon, 13 Apr 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrHvvPzr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594D3CB2C1
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088950; cv=none; b=WdzmFS5AHsptjbteMlLV6umgS3xFNiHrWrrJ5GSGRsnA5TTrFMr/6+il/kVgXYBvIAzwnG8ZTZgPfczTk5d6nmCgUH6MeJRS1qAo7KHXC1MJjEqbQn9wlOzOHMEu3XPtkAg8kmHgqZrpietCLssUnGXIWR+Hm809dLpZSJDs3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088950; c=relaxed/simple;
	bh=lsCmK8bgfymrGWmfnrdu1HhqbYmux52O5R+oq3QNKiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XznfqKNLvzIWMozuTQ+LT1OsosZ52/+AcTTgIwabkDpRgejT//k5szK+3qMP+tKKN1zfPPRmOsXtSHpnJ4vmb6I2qn2RLSzckNR74/GUoVqdRPYXKWUdqt2GzY/X6QsskyQkaZTZfh0OJOy2Gl5vz3hthioKByytTX8zr0M+7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrHvvPzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F623C2BCAF;
	Mon, 13 Apr 2026 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776088950;
	bh=lsCmK8bgfymrGWmfnrdu1HhqbYmux52O5R+oq3QNKiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TrHvvPzrpaItVhm08JmAQ2LYc1MyMWm5ZlJgajH2XrONzWtxui2XUkOlSEA6SjRrn
	 JWxyBP38OFwqjqr4nN+52tbPPgBT28Q0TpaeRFlc6NSfWPA9Faox1scws8YQTJrpKD
	 asmbtxTCSwiskLxl2sGMpV0Ntr1eGYa0XHELW5SHmbc+2eo2BSMye23okJaRP2Id2J
	 mSRh2QM0HsGvP0o/z04EGtlud04GcO+gktRQr/oAu2PArDfb+8nSjdszoFUEvoPPRr
	 tlwLJ/3DwadsQ1VblrpnvCoS6Kc7bNJRtDlcztSEFvm7TmHq6aN6qL7Be+3PhyMldb
	 pkLEY4qsNClCg==
Date: Mon, 13 Apr 2026 15:02:26 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 6/6] ixgbe: fix integer overflow and wrong bit
 position in ixgbe_validate_rtr()
Message-ID: <20260413140226.GQ469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
 <20260413134334.GP469338@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413134334.GP469338@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278092-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0B733ED11B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 02:43:34PM +0100, Simon Horman wrote:
> On Wed, Apr 08, 2026 at 03:11:54PM +0200, Aleksandr Loktionov wrote:
> > Two bugs in the same loop in ixgbe_validate_rtr():
> > 
> > 1. The 3-bit traffic-class field was extracted by shifting a u32 and
> >    assigning the result directly to a u8.  For user priority 0 this is
> >    harmless; for UP[5..7] the shift leaves bits [15..21] in the u32
> >    which are then silently truncated when stored in u8.  Mask with
> >    IXGBE_RTRUP2TC_UP_MASK before the assignment so only the intended
> >    3 bits are kept.
> > 
> > 2. When clearing an out-of-bounds entry the mask was always shifted by
> >    the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
> >    which loop iteration was being processed.  This means only UP1 (bit
> >    position 3) was ever cleared; UP0,2..7 (positions 0, 6, 9, ..., 21)
> >    were left unreset, so invalid TC mappings persisted in hardware and
> >    could mis-steer received packets to the wrong traffic class.
> >    Use i * IXGBE_RTRUP2TC_UP_SHIFT to target the correct 3-bit field
> >    for each iteration.
> > 
> > Swap the operand order in the mask expression to place the constant
> > on the right per kernel coding style (noted by David Laight).
> > 
> > Fixes: e7589eab9291 ("ixgbe: consolidate, setup for multiple traffic classes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > ---
> > v1 -> v2:
> >  - Add Fixes: tag; reroute to iwl-net (wrong bit positions cause packet
> >    mis-steering); swap to (reg >> ...) & MASK operand order per David
> >    Laight.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, I was a little too hasty there.

AI generated code review points out that the cited commit
doesn't seem to have introduced the code being fixed,
and that perhaps this Fixes tag would be more appropriate.

Fixes: 8b1c0b24d9af ("ixgbe: configure minimal packet buffers to support TC")

I will also forward on a review from Sashiko, although it
is for an existing bug and thus is strictly FYI.

