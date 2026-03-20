Return-Path: <netdev+bounces-270053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E+8Mq2lvWm4/wIAu9opvQ
	(envelope-from <netdev+bounces-270053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:53:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EFF2E0888
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 20:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB5AC305E350
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31550352C4F;
	Fri, 20 Mar 2026 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU7FqUV8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97A287259
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036268; cv=none; b=ippiiRjEtrI0QC363UBC9IJbrPNfGBGUdr/QWZyqvUpHMDSyI3XzBuG6ZHZnL5piSD7lcnLmCRXRva/qLn0p+zZLoNOs1k7nRCXFyGLIAsyCNYZYYU/bHWYClo48JBgExjIhy5TafXFx82WnX9faHcSoF4TndWew2cn754hEdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036268; c=relaxed/simple;
	bh=2vbu4pd5MILwYlxZrkNCrjwGhby1msVHrhgbEllJ4sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyBpM31bSU+NrzP+2dzh9UvfspOVPdBpUN2/RvM3/KP7p5QfWHhYYlpIE6cGWW5kHKnWt8E8QeqUSvPu0s3NaW3awCcLe0jy0bEAuHq4dKH+ejf68he9xhjZdXhzeg3qEhx0IuQaXfzQwrSzr3ur2Rq6TCfwGdQZGGlt9a/+26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU7FqUV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A827C4CEF7;
	Fri, 20 Mar 2026 19:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774036267;
	bh=2vbu4pd5MILwYlxZrkNCrjwGhby1msVHrhgbEllJ4sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JU7FqUV8isFL3zNM7biU71xh9DCKMaRH8i6W2Y0hWvCugfYAS+6XHFThDPw6FGtsJ
	 oSWBIl5sbgp6Y5bJkGyjf6c1IHJU3Ybi7Ant8s6aAcoRoXCpjTAdSZl6pWbOh02qyy
	 QrXfOoJH0hqyAQB5EmCtCiTuBf3UDPQFytQqOUB0zx/BJ8x83H+3kya/Kj4byR6pdT
	 xPE2q14+lyo7M9tXwtqJFCmB8vO0WOw8F7YQPRtD+gGPLNaeKHUItmqJYRPQYI1YB1
	 53Ezpbae4B+DFSpKDWJiXqq2BM1ZdtxS464lprDy4Jm27iv+TEPOYnsqLVXw525Rpy
	 7layT5+MzdFOw==
Date: Fri, 20 Mar 2026 19:51:03 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [PATCH iwl-next] ice: prevent integer overflow
Message-ID: <20260320195103.GJ74886@horms.kernel.org>
References: <20260320050544.422640-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320050544.422640-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270053-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 48EFF2E0888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:05:44AM +0100, Aleksandr Loktionov wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> In ice_sched_bw_to_rl_profile(), the loop over 64 bits computes the
> scheduler timestamp rate as:
> 
>   ts_rate = div64_long((s64)hw->psm_clk_freq,
>                        pow_result * ICE_RL_PROF_TS_MULTIPLIER);
> 
> where pow_result = BIT_ULL(i). For large values of i, the product
> pow_result * ICE_RL_PROF_TS_MULTIPLIER overflows u64 before being used
> as the divisor, producing incorrect ts_rate values and potentially
> undefined behaviour.
> 
> Fix this by pre-computing ts_freq = hw->psm_clk_freq /
> ICE_RL_PROF_TS_MULTIPLIER once before the loop and then dividing only
> by pow_result inside the loop. The division order avoids the overflow
> while preserving the same mathematical result. Declare ts_freq as s64
> to match the type domain of the surrounding arithmetic and avoid a
> redundant cast at the use site.
> 
> While at it, scope the loop variable i to the for statement itself.
> 
> Fixes: 1ddef455f4a8 ("ice: Add NDO callback to set the maximum per-queue bitrate")
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


