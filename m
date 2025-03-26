Return-Path: <netdev+bounces-177695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683BA714D6
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27342189E70D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED61B0F3C;
	Wed, 26 Mar 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAkT8icV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4A1A8405
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984866; cv=none; b=kiOrDjTEwfOVWdw3kqsEzoPE5Y5oF5hL+qeyYLWHumU0NWFfUNsA6+kKn1sUKx4aSCD2wLXvndoBJm2GbiBbssGRVDneuEHOQKTvG/v43jOFed/Jge3412fDyJTdE/7iBdK1oOByZLNAbj1dqv0ughZer8hwxNMhudgrY6Gvugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984866; c=relaxed/simple;
	bh=G05IUxK6aZIYhCSHSFb3rV7aKw4hoZVUVFNFbOhikiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l90nIQOEVnkFvCszQ0tjYnocmWfcNR6Rh84eCsV7xYMz8IWJdAJ5uFilzyLsiuB5BcWGHJiEFuaeEsvkkLJqBtpmh23mOHggVsYH35beJju2zIShTIwJzXnxQQYwvP/h7p/bwSUTZ1ffatWpSCVjSldtB9fuIK0seWxUhWefoR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAkT8icV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EAEC4CEE2;
	Wed, 26 Mar 2025 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742984862;
	bh=G05IUxK6aZIYhCSHSFb3rV7aKw4hoZVUVFNFbOhikiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAkT8icV4rI1GXgws3cpcPAs0Tvv/DaMhD8wcWeR9X2sXNsrfzTfzcHV03/4RhAMO
	 6z6YYcKmcbjIOnIuxGVZCN5E6EmSnPNrsRU/lkZeTdH6qJWIuo7WzyLhOeu/28L6A6
	 NdNdbythBt6U1YOzSZp8+oHAlGThlYzfEGhaSpIjV+Y5YwRbfiP1u8szLiaYgcNVJR
	 wT1H4OyfQgaaFa0AkZm6l8hXPz5W94TP0MbSB1SfHt9GV7k4u3fG3+Gh51Z8GL9xl/
	 uIOVD2meREF5kaxJsb/GyIjkQ5GPFRaV03ok7hQ4fwIPCQp/fGCQH5Gp13ja/dL43X
	 a3P2roMDQIIrw==
Date: Wed, 26 Mar 2025 10:27:37 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, jacky@yunsilicon.com,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org,
	kalesh-anakkur.purayil@broadcom.com, geert+renesas@glider.be,
	geert@linux-m68k.org
Subject: Re: [PATCH net-next v9 13/14] xsc: Add eth reception data path
Message-ID: <20250326102737.GB892515@horms.kernel.org>
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
 <20250318151520.1376756-14-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318151520.1376756-14-tianx@yunsilicon.com>

On Tue, Mar 18, 2025 at 11:15:21PM +0800, Xin Tian wrote:

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h

...

> +#define XSC_SET_PFLAG(params, pflag, enable)			\
> +	do {							\
> +		if (enable)					\
> +			(params)->pflags |= BIT(pflag);		\
> +		else						\
> +			(params)->pflags &= ~(BIT(pflag));	\
> +	} while (0)

Hi Xin Tian,

XSC_SET_PFLAG() seems to be unused. Perhaps it is best to drop it and
add it when needed.

And, FWIIW, I would have implemented both XSC_SET_PFLAG() and
XSC_GET_PFLAG() as functions as there doesn't seem to be a reason that they
need to be macros.

> +
> +#define XSC_GET_PFLAG(params, pflag) (!!((params)->pflags & (BIT(pflag))))

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c

...

> +bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
> +{
> +	struct xsc_wq_cyc *wq = &rq->wqe.wq;
> +	u8 wqe_bulk, wqe_bulk_min;
> +	int alloc;
> +	u16 head;
> +	int err;
> +
> +	wqe_bulk = rq->wqe.info.wqe_bulk;
> +	wqe_bulk_min = rq->wqe.info.wqe_bulk_min;
> +	if (xsc_wq_cyc_missing(wq) < wqe_bulk)
> +		return false;
> +
> +	do {
> +		head = xsc_wq_cyc_get_head(wq);
> +
> +		alloc = min_t(int, wqe_bulk, xsc_wq_cyc_missing(wq));
> +		if (alloc < wqe_bulk && alloc >= wqe_bulk_min)
> +			alloc = alloc & 0xfffffffe;
> +
> +		if (alloc > 0) {
> +			err = xsc_alloc_rx_wqes(rq, head, alloc);
> +			if (unlikely(err))
> +				break;
> +
> +			xsc_wq_cyc_push_n(wq, alloc);
> +		}
> +	} while (xsc_wq_cyc_missing(wq) >= wqe_bulk_min);
> +
> +	dma_wmb();
> +
> +	/* ensure wqes are visible to device before updating doorbell record */
> +	xsc_rq_notify_hw(rq);
> +
> +	return !!err;

Perhaps it can't occur in practice, but err will be used uninitialised here
if the alloc condition in the do loop above is never met.

> +}

...

