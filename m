Return-Path: <netdev+bounces-278783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK6XAsqW32nXWQAAu9opvQ
	(envelope-from <netdev+bounces-278783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:46:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38A404FA7
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A9D1300AB07
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253A381AE8;
	Wed, 15 Apr 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mm74+F2b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9772F1FFC
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776260806; cv=none; b=Yxi4EBqike7MUKkoHbVOn1lQE01UXQ1inf4CyoH3jgHpaOfMLu+gwv6H58Un5mAdVlXfKhhtX0jm5UoZb799N3F60Kw/NEa4tAyvl8s794Hq3WweUQRL8VUhBWW3V+AxlG7Ww79RpXXDOK6oraOj9mnO3qrMlrz4RDoaOV2dv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776260806; c=relaxed/simple;
	bh=hUX+08o1UGhyqMZxAK7BKsm8gMlYpj2DYuE3FXFWmiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+2+XN97sLG6y1C5ImdsSPbv1drZUaPKn6XPU74BleVDI9xy2cVMOJYUVoFTZkWx+AxbC7dFSo+gCwkXOSfRmnLpSxf6B8lj2yej1NMV7yBBg/4oEsAi8PhZZI9QjXijCaxg8jjcD+s+rWD7W8ms3x7hv74yBJ2r0vTgPjvlydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mm74+F2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA725C19424;
	Wed, 15 Apr 2026 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776260805;
	bh=hUX+08o1UGhyqMZxAK7BKsm8gMlYpj2DYuE3FXFWmiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mm74+F2bxyVi1iMSesfUj0I41WtcnfisuF5oIYTOP13t9S1w0+qUJoSFt8ywZMLpZ
	 X/mN5Xj1ITnFmBE0EjG3IfA/zwiamEt+kLZjbIc/DdZfeF/Csrul2Z7ypZiR4xR2DQ
	 9KEoyyS0TlL7p7K58PcaNmwaHq0aKK2EP/3DxSYrVjvEZKZja7+q3pGnaHo2jK9C5/
	 ymFiYr+bZg+861hBsnWh5iR9HVOexTQA8Fprh76cgyZmPMA2sosB5Wcr9Ie2xAZRcz
	 2FyplORTjonOkQDRXohxIcO9LeNNBKUnn+o7+dFN95QabobrfxDBdAShGAhYB2rz+N
	 qevYxHM4n/h7w==
Date: Wed, 15 Apr 2026 14:46:42 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Avinash Dayanand <avinash.dayanand@intel.com>
Subject: Re: [PATCH iwl-net 4/5] iavf: fix TC boundary check in
 iavf_handle_tclass
Message-ID: <20260415134642.GJ772670@horms.kernel.org>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413073035.4082204-5-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278783-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F38A404FA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:30:34AM +0200, Aleksandr Loktionov wrote:
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> The condition `tc < adapter->num_tc` admits any tc value equal to or
> greater than num_tc, bypassing the destination-port validation and
> allowing traffic to be steered to a non-existent traffic class. Change
> the comparison to `tc > adapter->num_tc` to correctly reject
> out-of-range TC values.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

I am a bit confused by this logic.

With this patch applied:

1) For tc <= adapter->num_tc, which I assume is valid TCs (other than 0,
   in which case the function returns earlier), the filter destination port
   is skipped.

   But the failure path for that checks logs:
   "Specify destination port to redirect to traffic class other than TC0\n"

   This does not seem consistent.

2) For tc > adapter->num_tc, which I assume is invalid TCs,
   the function will eventually assign fields of filter->f and succeed
   if filter has a valid destination port.

   This doesn't seem to be in keeping with the patch description.

3) The above two points aside, is there an out by 1 condition in
   the condition tc > adapter->num_tc. It seems to imply
   that tc == adapter->num_tc is a valid tc. But I suspect that
   is not hte case.

In short, I'm wondering if the function should look something like this
(completely untested):

/**
 * iavf_handle_tclass - Forward to a traffic class on the device
 * @adapter: board private structure
 * @tc: traffic class index on the device
 * @filter: pointer to cloud filter structure
 */
static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
			      struct iavf_cloud_filter *filter)
{
		if (tc == 0)
			return 0;

		if (tc >= adapter->num_tc) {
			// dev_err(...);
			return -EINVAL;
		}

		if (!filter->f.data.tcp_spec.dst_port) {
			dev_err(&adapter->pdev->dev,
				"Specify destination port to redirect to traffic class other than TC0\n");
			return -EINVAL;
		}

		/* redirect to a traffic class on the same device */
		filter->f.action = VIRTCHNL_ACTION_TC_REDIRECT;
		filter->f.action_meta = tc;

		return 0;
}

> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index ab5f5adc..5e4035b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -4062,7 +4062,7 @@ static int iavf_handle_tclass(struct iavf_adapter *adapter, u32 tc,
>  {
>  	if (tc == 0)
>  		return 0;
> -	if (tc < adapter->num_tc) {
> +	if (tc > adapter->num_tc) {
>  		if (!filter->f.data.tcp_spec.dst_port) {
>  			dev_err(&adapter->pdev->dev,
>  				"Specify destination port to redirect to traffic class other than TC0\n");
> -- 
> 2.52.0
> 

