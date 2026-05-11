Return-Path: <netdev+bounces-286724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIXeMngAAmppnAEAu9opvQ
	(envelope-from <netdev+bounces-286724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:14:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A81511E96
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC8F03154A2B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B840758E;
	Mon, 11 May 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvNpoFXI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463D406271
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514467; cv=none; b=VReULoS1dnJChkxVXzP2K/19tHS6QMe7daoQ8ZqTyC3pxlvxvVY/POoNSGaUsoKR7cJlpK51O5HJZ9L7yujz6LtGBo+AGoFnPsO7e0ViHO9azHkfs6uJGumbCNMo/xAIv0svLda13oPU9gm3Y/rdbb+VdB8CmxNI0QBYUpxmb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514467; c=relaxed/simple;
	bh=wg3sj4YnE54AHzo71NUx2gXbPJJaa+jjk+3YhaTtn2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHfKfXZtgPfhi+8SDmOrgDrgkUKWVvz7y+ssLCnkVHofQZP/2rTbiO4RfxRUHq8TCrdWPAyTKMZlBMLoe9NY6FSY0y30b7OujJquFR6+13Ajisc0YcMlQIq9NVQuustwRv21nYevruxCk7n/64aBsZQMubxyXd6NqKtUdiDNAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvNpoFXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF42C2BCB0;
	Mon, 11 May 2026 15:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778514467;
	bh=wg3sj4YnE54AHzo71NUx2gXbPJJaa+jjk+3YhaTtn2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvNpoFXI3fi7jwGkY+pWzGB1wYn05cTBMtf2Kpj7RTyHJq6h1pPue8F7RwO173Ngr
	 6m+0uZ3W3Jhh6O9cOYnEzxy16U8y0930otjA13SJtsp2NtE0ypnPQG/FoQn8jWsPtR
	 KpaMT5d1UWpJbbz86jxDsUPw+jiEmn/icj+xqoNKm1LVpvBr7lVZ3gP0aYQr13Qxjo
	 XiY8SaGpgfLwCDroE0/qJJWHdmPl4SxZYcRJK5APgHS7fNNJbf2+HAzi+s4aFRUcyU
	 GQTiCzqc48IPD0rhu89keicVmyV6tExe2QBPCdpAAeHvs30A98+RE1gP4qya7zfhnr
	 99uBaZ7+MwEbw==
Date: Mon, 11 May 2026 16:47:43 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 7/8] ixgbe: limit ITR decrease in latency mode
 to prevent ACK overdrive
Message-ID: <20260511154743.GD27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-8-aleksandr.loktionov@intel.com>
X-Rspamd-Queue-Id: D0A81511E96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286724-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:12:25AM +0200, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> When operating in latency mode and the computed ITR is lower than the
> current setting, the algorithm can reduce the interrupt rate too
> aggressively in a single step.  For a TCP workload this means the ACK
> stream (a latency-sensitive, low-packet-rate workload) can drive the
> moderation down to very high interrupt rates, starving CPU time from
> the sender side.
> 
> After the speed-based ITR calculation is complete, check whether the
> result is in latency mode and would decrease below the current setting.
> If so, limit the decrease to at most IXGBE_ITR_ADAPTIVE_MIN_INC (2 us)
> per update.  This ensures the number of interrupts grows by no more
> than 2x per adjustment step for latency-class workloads, dialling in
> smoothly rather than overshooting.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index aea76b3..ba7b013 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -2888,6 +2888,17 @@ static void ixgbe_update_itr(struct ixgbe_q_vector *q_vector,
>  		break;
>  	}
>  
> +	/* In the case of a latency specific workload only allow us to
> +	 * reduce the ITR by at most 2us. By doing this we should dial
> +	 * in so that our number of interrupts is no more than 2x the number
> +	 * of packets for the least busy workload. So for example in the case
> +	 * of a TCP workload the ACK packets being received would set the
> +	 * interrupt rate as they are a latency specific workload.
> +	 */
> +	if ((itr & IXGBE_ITR_ADAPTIVE_LATENCY) && itr < ring_container->itr)
> +		itr = max_t(unsigned int, itr,
> +			    ring_container->itr - IXGBE_ITR_ADAPTIVE_MIN_INC);

nit: I expect this could be min(). And if it could, it should.

> +
>  clear_counts:
>  	/* write back value */
>  	ring_container->itr = itr;
> -- 
> 2.52.0
> 

