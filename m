Return-Path: <netdev+bounces-279496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEd8K3J442lHHQEAu9opvQ
	(envelope-from <netdev+bounces-279496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:26:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFB0421148
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD406300B523
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857935F170;
	Sat, 18 Apr 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozWhwrOF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664791F5437
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776515181; cv=none; b=EOmemJQNx58Gr5zE5x18q/1L0QErPUK767AZ8mkqDDM7zMfZfiD7pGNCod394VYXsKeKO0Mr4eViLVonzLm3YVbzencjEfVeXeRtImexpSeBa+89C5yzGKFI4VJneOoz+GdmhDVvAS9qs3XUEAPsJrVBj6TybZOnlTDYHBqBmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776515181; c=relaxed/simple;
	bh=HWqdLCoCTZqiCrLr9u4qrUUcnDgqwBoxhU21yZ6mtlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBpe3FnTfetsjtg0z5844fGR4wNG4zTIhtX3/ZKzL9J8fpgGxLit5ylRESN1s8NYKoobgxCOGDJooj/EGlv/FrrBCnXE/yH6aPhGN9rfP21umHpWc1566xlPbPzH1G/FhbfoHLcoNX431l+Cu4ZXPQwOhrlH8zKq5cEB3pjc0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozWhwrOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DDEC19424;
	Sat, 18 Apr 2026 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776515180;
	bh=HWqdLCoCTZqiCrLr9u4qrUUcnDgqwBoxhU21yZ6mtlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozWhwrOFH1J0gopSPh/j36j8gnog6t9LlP644uOsvC6YNbcK6BddYXLvld5NLJabP
	 17R7bcOzeoBodoNVESMX7cDZV+j+/uyvU6CLCR8k6LQ+riyH17PUFzjK2lvpfPcrDb
	 jdnJjvIkxij5xc0dFqo4Weyv0g/IbbfmrJ2u3AOF4Xor39+1KYm/AF0JwY2GdffUXU
	 Zje7Tt4Z1GNUXdK0CWdeUdXIsppS5QOZ3Ybvbr1fDx5IxcD0JByjP2/ZwRymbuqS/V
	 Kx/+imAe95ENuVisPa5DqwHimzd33gQ8iuq1/mX/+hUSs+/mwWiVh/+kthBqnUdCIz
	 UKesces87sREA==
Date: Sat, 18 Apr 2026 13:26:16 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v3 5/6] ixgbe: fix ITR value overflow in adaptive
 interrupt throttling
Message-ID: <20260418122616.GC280379@horms.kernel.org>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
 <20260415142841.3222399-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415142841.3222399-6-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279496-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: ADFB0421148
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 04:28:40PM +0200, Aleksandr Loktionov wrote:
> ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
> bit 7) and a usecs delay (bits [6:0]) into an unsigned int, then
> stores the combined value in ring_container->itr which is declared as
> u8.  Values above 0xFF wrap on truncation, corrupting both the delay
> and the mode flag on the next readback.
> 
> Keep the mode bit (IXGBE_ITR_ADAPTIVE_LATENCY) and the usec delay as
> separate operands in the final store expression.  Clamp only the usecs
> portion to [IXGBE_ITR_ADAPTIVE_MIN_USECS, IXGBE_ITR_ADAPTIVE_MAX_USECS]
> using clamp_val() so that:
>  - overflow cannot bleed into the mode bit (bit 7),
>  - the delay cannot exceed 126 us (IXGBE_ITR_ADAPTIVE_MAX_USECS),
>  - the delay cannot drop below 10 us (IXGBE_ITR_ADAPTIVE_MIN_USECS).
> 
> Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v2 -> v3:
>  - Use clamp_val() instead of min_t() to also guard the lower bound
>    (IXGBE_ITR_ADAPTIVE_MIN_USECS); keep mode and delay as separate
>    operands until final store; use IXGBE_ITR_ADAPTIVE_MAX_USECS (126)
>    as upper bound instead of IXGBE_ITR_ADAPTIVE_LATENCY - 1 (127)
>    (Simon Horman).

FTR: I think the code would be easier to reason with if
mode and delay were kept separate during earlier calculation
of itr. But I also think that can be handled as a follow-up.
as this patch does improve things.

Reviewed-by: Simon Horman <horms@kernel.org>

