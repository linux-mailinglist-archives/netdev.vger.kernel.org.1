Return-Path: <netdev+bounces-278086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHXrDjfz3GnZYQkAu9opvQ
	(envelope-from <netdev+bounces-278086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 172423ECAEA
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B018300A8D0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874EB3CCFBE;
	Mon, 13 Apr 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSCwuu5v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D93C9EF6
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087582; cv=none; b=KkoMGo+dAnc0qygwo9MUHHIqFa0goVYSctOfbPN4EtvmH1CSY3wT+6Tm2Ey2u/1gKVh5t+T1CP69ZEQZAC6zOC+EgWs/s5o8OB8CrK9BGg6agZpOYmK7X/3H14HWO8wJ1SwHAcnADvWlSmu+HzVMUuHwzLP8JNiI+kKoLQH1ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087582; c=relaxed/simple;
	bh=0X3mZWOmxnCPoruGCJnthAxCGMk/6xAlSVH+ODrnXMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfjl472pY4BHQNa5sSNA2KUnZ8JAHafPQQArz/Z5/ZgPdzvlXgbXkmssLmAv4XLrxsLmzljSwByJ1q4yuB38lJbVwY0sSIu7ti1mp+Q3g4BPD6ET43S4Cyc573fOioXnU9TcZjyxvJqnwrHBVsdWlgwAqwNepptlkxbUcRyZfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSCwuu5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15330C2BCAF;
	Mon, 13 Apr 2026 13:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776087582;
	bh=0X3mZWOmxnCPoruGCJnthAxCGMk/6xAlSVH+ODrnXMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PSCwuu5v+KZUBwaW+KFZWQ8FGHtXNfvmLmhpOWwIbY4daYzEdpafJN/VzbSqZcCoL
	 E76fubZyK5z/NGghsczaofX5rDQ0F3a/w5vMD92sJDRva95AqHrHG4PhMwMx8Xg/kg
	 fYq51iYvhFGj2b8HxWDTyadgD7eO3aerOPMBmu/GawBCZ4TZzLLihHnnVbwIOo3Aa0
	 dEG44rBsRx8KWLx8pzFiOQ2gH9jUZb5taiTZatbS7R8XZp6foHwfEEQQKGtKqmi5R9
	 koC05GjLDhALLEbF769DkfwRo2wA03Gv6FmhHL/FeCcaQQjpglMdhJQvvoSK8MNFSr
	 zVFWhKWBFWIlg==
Date: Mon, 13 Apr 2026 14:39:38 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 5/6] ixgbe: fix ITR value overflow in adaptive
 interrupt throttling
Message-ID: <20260413133938.GO469338@kernel.org>
References: <20260408131154.2661818-1-aleksandr.loktionov@intel.com>
 <20260408131154.2661818-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408131154.2661818-6-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-278086-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 172423ECAEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 03:11:53PM +0200, Aleksandr Loktionov wrote:
> ixgbe_update_itr() packs a mode flag (IXGBE_ITR_ADAPTIVE_LATENCY,
> bit 7) and a usecs delay (bits [6:0]) into an unsigned int, then
> stores the combined value in ring_container->itr which is declared as
> u8.  Values above 0xFF wrap on truncation, corrupting both the delay
> and the mode flag on the next readback.
> 
> Separate the mode bits from the usecs sub-field; clamp only the usecs
> portion to [0, IXGBE_ITR_ADAPTIVE_LATENCY - 1] (= 0x7F) using min_t()
> so overflow cannot bleed into bit 7.
> 
> Fixes: b4ded8327fea ("ixgbe: Update adaptive ITR algorithm")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2:
>  - Add proper [N/M] numbering so patchwork tracks it as part of the set;
>    no code change.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 210c7b9..9f3ae21 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2889,8 +2889,9 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
>  	}
>  
>  clear_counts:
> -	/* write back value */
> -	ring_container->itr = itr;
> +	ring_container->itr = (itr & IXGBE_ITR_ADAPTIVE_LATENCY) |
> +		min_t(unsigned int, itr & ~IXGBE_ITR_ADAPTIVE_LATENCY,
> +		      IXGBE_ITR_ADAPTIVE_LATENCY - 1);

* It is not clear to me that the mode flag bit (IXGBE_ITR_ADAPTIVE_LATENCY)
  is always set in itr when reaching this code. But with this patch that
  bit will always be set in ring_container->itr.

* Perhaps no such case exists, but it's not clear to me how this handles a
  case where the usec delay has overflowed into the mode flag bit.

  As a hypothetical example, consider the case where the delay overflows to
  exactly 0x80.  The resulting delay is 0 (both with and without this
  patch).

  I would suggest an approach of keeping the delay and mode bits separate
  during calculation - in separate local variables - and only combining
  them when ring_container->itr is set.

  This may turn out to be more verbose. But I expect it is easier to reason
  with.

* Looking over the code, it looks like the maximum allowed udelay is
  IXGBE_ITR_ADAPTIVE_MAX_USECS (126) rather than
  IXGBE_ITR_ADAPTIVE_LATENCY - 1 (127).

* The calculation does not guard against delay values less
  than IXGBE_ITR_ADAPTIVE_MIN_USECS. Which looking over the code seems
  to be something that matters. (And which occurred in the hypothetical
  example above).

* As itr is an unsigned int, and IXGBE_ITR_ADAPTIVE_LATENCY - 1 is a
  compile time constant, I expect that min() is sufficient.
  IOW, I don't think min_t is needed here.

* It looks like using FIELD_PREP is appropriate to construct
  ring_container->itr. But that may be overkill if you end up with
  something like:

	ring_container->itr = mode | clamp(delay, IXGBE_ITR_ADAPTIVE_MAX_USECS,
					   IXGBE_ITR_ADAPTIVE_MIN_USECS);

>  
>  	/* next update should occur within next jiffy */
>  	ring_container->next_update = next_update + 1;
> -- 
> 2.52.0

