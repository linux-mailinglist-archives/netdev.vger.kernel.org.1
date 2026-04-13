Return-Path: <netdev+bounces-278089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPrnAA7z3GnZYQkAu9opvQ
	(envelope-from <netdev+bounces-278089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:43:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 985893ECABD
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B61EE300B5BA
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444D73BE17B;
	Mon, 13 Apr 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUoG8juz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221921F0E25
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087818; cv=none; b=kl7XT64r9Fd0Fh6FTNeer7FFFy0dpQM/WnKELgHvy7BzDlokezqLebsOJ3S/YoYoz674x0DkEodYNOPHM/UF5RIBlQ4NbUO76xcV62XoHaX08nR4tPWjC3inWPSwuORM+E2jrHYvHhkU4O7AE9Ltq24VVuz0ip4+SCF2J7ruF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087818; c=relaxed/simple;
	bh=ZFAMrSY8jw7Ij+knpPaJsB0Cm3Po6aQaaQ3IiLfQUog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB0+gH/N3Sho+WZYBaz+2ENlLp6AlC68RVKKnM7KhqsIm7wlvEt1AdU3JWr9HGPu4Z7JTl048S2nb24PGAwtZKvp8cTymGHuov6JhmQJAyK1AIa3mhd8uXQm82HnD68d0+gvCA/m8d8XtiD1d9lXvpsQLRiZcFNQ/Qd3BjQ65tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUoG8juz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A04C2BCB4;
	Mon, 13 Apr 2026 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776087817;
	bh=ZFAMrSY8jw7Ij+knpPaJsB0Cm3Po6aQaaQ3IiLfQUog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUoG8juz+ZV1bFSwY92yONhOy4d/ti0+M/1zb31HvLm6g16/O1wIDHFZiCIG2VG0Y
	 /us+KqUkPoMCCHTTPVYI7Xxay43OefA5cRgFJLG/PEHil7xCbvu6fM3z1trgq2I3pe
	 LEXfALQd5ZOqRMYrdZmuGsaNqGl2XMGuYJKLapES5rLxWmCkAk3egTZam5mSCilxcA
	 8uexhE7jAF0Z/46Y22oiKXROxwL8OF2CBtELixs11prlorUcgZcZuqeQ6sDg0Ol1Ac
	 ZB0srmiOvhhpxkFFV0YlpajtzdjW3A2bXRzu2T5ad392Kp0chl4c7VNI8zjuOfnBmi
	 lK3BHjwEuDYhg==
Date: Mon, 13 Apr 2026 14:43:34 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 6/6] ixgbe: fix integer overflow and wrong bit
 position in ixgbe_validate_rtr()
Message-ID: <20260413134334.GP469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-278089-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 985893ECABD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 03:11:54PM +0200, Aleksandr Loktionov wrote:
> Two bugs in the same loop in ixgbe_validate_rtr():
> 
> 1. The 3-bit traffic-class field was extracted by shifting a u32 and
>    assigning the result directly to a u8.  For user priority 0 this is
>    harmless; for UP[5..7] the shift leaves bits [15..21] in the u32
>    which are then silently truncated when stored in u8.  Mask with
>    IXGBE_RTRUP2TC_UP_MASK before the assignment so only the intended
>    3 bits are kept.
> 
> 2. When clearing an out-of-bounds entry the mask was always shifted by
>    the fixed constant IXGBE_RTRUP2TC_UP_SHIFT (== 3), regardless of
>    which loop iteration was being processed.  This means only UP1 (bit
>    position 3) was ever cleared; UP0,2..7 (positions 0, 6, 9, ..., 21)
>    were left unreset, so invalid TC mappings persisted in hardware and
>    could mis-steer received packets to the wrong traffic class.
>    Use i * IXGBE_RTRUP2TC_UP_SHIFT to target the correct 3-bit field
>    for each iteration.
> 
> Swap the operand order in the mask expression to place the constant
> on the right per kernel coding style (noted by David Laight).
> 
> Fixes: e7589eab9291 ("ixgbe: consolidate, setup for multiple traffic classes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Add Fixes: tag; reroute to iwl-net (wrong bit positions cause packet
>    mis-steering); swap to (reg >> ...) & MASK operand order per David
>    Laight.

Reviewed-by: Simon Horman <horms@kernel.org>


