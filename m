Return-Path: <netdev+bounces-278042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGTPIsLN3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:04:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1CA3EB101
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9578D308A95A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228053BF67C;
	Mon, 13 Apr 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/30kM3r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D13BD22E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077694; cv=none; b=RGuvQqzPl6FxY7R3G/lhvTjrJ7ZTTyO7QOohxOePvTSDlWLaTGsHn2hmXT9/RWlkkMfHkG/N6OARx2evaBTF/F8KLIZ5xT45VZ8PQaWvJnp6jWv22cQHCuRSfOtc3ZOCLh9mmaO85UnzkHHzYinF1hRY7AVCv8zuR/d9hXCR2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077694; c=relaxed/simple;
	bh=nz5hxxicKyK9BXmV2TEjGdfMjMpJw2jsLLzARmCjv5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/CoapDGuhEAPLSC6YI7po9XyJ76uN1N++dAMIqiDQBINiRFlo0/UN40K3+8tcD9LpaRp8w6wbI3lVTrjUzmMtWJwu25Phw+va2Tr69NRsaG3SzhELsjUCeKPBwxA7P3FPgiqHoCD1Lyd4KUu5tY4sYXEom7bYkqQ1ij3R1w2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/30kM3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638EFC116C6;
	Mon, 13 Apr 2026 10:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077693;
	bh=nz5hxxicKyK9BXmV2TEjGdfMjMpJw2jsLLzARmCjv5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/30kM3r2N63GzzLiQlAttghWO10O6LvFF5HbwPtLczvbXdm/JViuh2Ap481ew5ra
	 8liF+004dJPeIJ2Q3kKL6nhXxD/n7KSfFeefsJOV1qXbYFBa/4djNB2TaX3GE3XgY1
	 z4yDt8Sh0RYEu/0i8C5X07PVb2ggRSCVxk+HI1EOnzddbi+LYaiMS/V5gaezCWjdZl
	 cJD1ep3rO1IjOaqX4jrmRHoFQADEml09InnL4Le9p274txJGljZBVJgs5CVE7RnlLx
	 e1mjozks+dVQFe1LE3L1f3aXiQvpD+gol5hZUcamwAlu9cDcyyo4HN8QdcRJp5tthd
	 3wV15Xf/GmwdA==
Date: Mon, 13 Apr 2026 11:54:50 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-net v2 4/6] ixgbe: fix cls_u32 nexthdr path returning
 success when no entry installed
Message-ID: <20260413105450.GN469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131154.2661818-5-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278042-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: CD1CA3EB101
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 03:11:52PM +0200, Aleksandr Loktionov wrote:
> ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
> even when ixgbe_clsu32_build_input() fails for every candidate entry
> and no jump-table slot is actually programmed.  Callers that test the
> return value would then falsely believe the filter was installed.
> 
> The variable 'err' already tracks the last ixgbe_clsu32_build_input()
> return value; if the loop completes with a successful break, err is 0.
> If all attempts failed, err holds the last failure code.  Change the
> unconditional 'return 0' to 'return err' so errors are propagated
> correctly.
> 
> Fixes: 1cdaaf5405ba ("ixgbe: Match on multiple headers for cls_u32 offloads")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v1 -> v2:
>  - Add Fixes: tag; reroute from iwl-next to iwl-net (false-success
>    return is a user-visible correctness bug, not a cleanup).

Reviewed-by: Simon Horman <horms@kernel.org>


