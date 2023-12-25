Return-Path: <netdev+bounces-60208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9481E1D2
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04601C21025
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AB52F88;
	Mon, 25 Dec 2023 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n43RDuBC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18E52F84
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2698FC433C8;
	Mon, 25 Dec 2023 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703526112;
	bh=9h1Oa2qWxHuiKgvhDn0ogLEIGNuYc+hXmgPdiNsK5AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n43RDuBCoqff/xCyglAimGnoDzm5B6aEYq731vGoZzEo8ydasbosK/BaYwy79QChC
	 kJbANiDf3peSmE/cHMpsRAUJk97sy11c5W2X2KMYDgU5OUJSbSYl69YZ1ATM1FYPLA
	 b9DaNBtU64PrdQW5PqmoygP1PrGgtLdkgE5sIrHPIZU+hT9qbw3Tt3q164rR/UyF/m
	 pouY7S/TkJrZGYv0vC3X4vEQXmYNgOGwuwdKLZowVKJ24lTSWGxQil1iCqGXXn/pHx
	 onHyD6OK+LblLMRrG8hAjOhhobIhVABoGcCmyyaP/NPlZTdQNqh7YT8lRzqKOIZY9k
	 CFVG8WV7KTuEQ==
Date: Mon, 25 Dec 2023 17:41:48 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 13/13] bnxt_en: Add support for ntuple filter
 deletion by ethtool.
Message-ID: <20231225174148.GL5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-14-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-14-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:10PM -0800, Michael Chan wrote:
> Add logic to delete a user specified ntuple filter from ethtool.
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index c3b9be328b87..5629ba9f4b2e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1341,6 +1341,31 @@ static int bnxt_srxclsrlins(struct bnxt *bp, struct ethtool_rxnfc *cmd)
>  	return rc;
>  }
>  
> +static int bnxt_srxclsrldel(struct bnxt *bp, struct ethtool_rxnfc *cmd)
> +{
> +	struct ethtool_rx_flow_spec *fs = &cmd->fs;
> +	struct bnxt_filter_base *fltr_base;
> +
> +	rcu_read_lock();
> +	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->ntp_fltr_hash_tbl,
> +					  BNXT_NTP_FLTR_HASH_SIZE,
> +					  fs->location);
> +	if (fltr_base) {
> +		struct bnxt_ntuple_filter *fltr;
> +
> +		fltr = container_of(fltr_base, struct bnxt_ntuple_filter, base);
> +		rcu_read_unlock();
> +		if (!(fltr->base.flags & BNXT_ACT_NO_AGING))
> +			return -EINVAL;
> +		bnxt_hwrm_cfa_ntuple_filter_free(bp, fltr);
> +		bnxt_del_ntp_filter(bp, fltr);
> +		return 0;
> +	}
> +
> +	rcu_read_unlock();
> +	return -ENOENT;
> +}
> +

Hi Michael,

FWIIW, I think it would be more idoiomatic to handle
the error case inside the if condition.

(Completely untested!)

static int bnxt_srxclsrldel(struct bnxt *bp, struct ethtool_rxnfc *cmd)
{
	struct ethtool_rx_flow_spec *fs = &cmd->fs;
	struct bnxt_filter_base *fltr_base;
	struct bnxt_ntuple_filter *fltr;

	rcu_read_lock();
	fltr_base = bnxt_get_one_fltr_rcu(bp, bp->ntp_fltr_hash_tbl,
					  BNXT_NTP_FLTR_HASH_SIZE,
					  fs->location);
	if (!fltr_base) {
		rcu_read_unlock();
		return -ENOENT;
	}

	fltr = container_of(fltr_base, struct bnxt_ntuple_filter, base);
	rcu_read_unlock();

	if (!(fltr->base.flags & BNXT_ACT_NO_AGING))
		return -EINVAL;

	bnxt_hwrm_cfa_ntuple_filter_free(bp, fltr);
	bnxt_del_ntp_filter(bp, fltr);

	return 0;
}

...

