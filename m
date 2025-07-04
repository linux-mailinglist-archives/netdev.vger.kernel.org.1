Return-Path: <netdev+bounces-204217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08CAAF9983
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 19:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B84517D42F
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92E293B42;
	Fri,  4 Jul 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq5nQt/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B481DD0C7
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649245; cv=none; b=t2IrMaxuuKoQg6UKML97y1uoxTDJcaTr3k5VmCI+J9H9bZ0hRWX6AVVNi1CI2m0bGHZkbP9kboE7tzMVZTT0cVmfsTSW7FhWdkPUNmbw7LvCrDEJjSm9WsGBB3V5uryoJItr01Q8heeL5e9lnhHcX8eCezlfAlFaGoL6qMrJyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649245; c=relaxed/simple;
	bh=UdE2wCHXWoXBCeTbv4BQLfwv23s57LU+ZR904hskDSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvOY7N79CL6RVTPJSYdsaswB756BxkSEaYi7kv6XPMM+VABdNr8KnMLMJDprb5pkZBoKJk++QEvUKrQHPdrcOWUkEjDggXxmI4+iJ76EBQagKfCXxvsF/cMUE8eA8bisnzrSbaCmi6MZ9uxyXjHJ0OSpIi1GTj9XAWlPUY3XvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq5nQt/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5C0C4CEE3;
	Fri,  4 Jul 2025 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751649244;
	bh=UdE2wCHXWoXBCeTbv4BQLfwv23s57LU+ZR904hskDSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq5nQt/w0COcnj2QGzSWI6m7CZobPXbXF83SaX68mu1id63YZ0idO0Z3MV32MVSd1
	 g8LjKI07ySTIykZ9bdxpsjnqgyH8Cni4hvijmk6unU7N8jfm4DutWfRaxB5qCvCtci
	 TBMmvGtkZc70JMYH8buod6teh7n5IjJS0clfwyEoYplncbC4YbrAHFL895T9Ec/Ikn
	 k0vjB+44kGIp8X1hkRieTx07AOWvl5Nm2Zq91/XSS67snkyitRxNn1ci3C7mxv/65+
	 YVqZu/76K0evT0Rk+ijJDWAvddSXZu8o435xWRYyHW00NfKAKoVBV7HUAn2LntflZQ
	 L9cruT+S1RpPw==
Date: Fri, 4 Jul 2025 18:14:00 +0100
From: Simon Horman <horms@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@linux.ibm.com, davemarq@linux.ibm.com
Subject: Re: [PATCH v2 net-next 2/4] ibmvnic: Fix hardcoded
 NUM_RX_STATS/NUM_TX_STATS with dynamic sizeof
Message-ID: <20250704171400.GN41770@horms.kernel.org>
References: <20250702171804.86422-1-mmc@linux.ibm.com>
 <20250702171804.86422-3-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702171804.86422-3-mmc@linux.ibm.com>

On Wed, Jul 02, 2025 at 10:18:02AM -0700, Mingming Cao wrote:
> The previous hardcoded definitions of NUM_RX_STATS and
> NUM_TX_STATS were not updated when new fields were added
> to the ibmvnic_{rx,tx}_queue_stats structures. Specifically,
> commit 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx
> batched") added a fourth TX stat, but NUM_TX_STATS remained 3,
> leading to a mismatch.
> 
> This patch replaces the static defines with dynamic sizeof-based
> calculations to ensure the stat arrays are correctly sized.
> This fixes incorrect indexing and prevents incomplete stat
> reporting in tools like ethtool.
> 
> Fixes: 2ee73c54a615 ("ibmvnic: Add stat for tx direct vs tx batched")

nit: no blank line between Fixes and other tags please

More importantly, the cited commit is present in net so this
fix patch sould also be targeted at net. IOW, please break this
patch out of this patchset and post it targeted at net, while
the remaining patches should be posted as a v3 for net-next.

> 
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
> Reviewed by: Haren Myneni <haren@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
> index 9b1693d817..e574eed97c 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.h
> +++ b/drivers/net/ethernet/ibm/ibmvnic.h
> @@ -211,7 +211,6 @@ struct ibmvnic_statistics {
>  	u8 reserved[72];
>  } __packed __aligned(8);
>  
> -#define NUM_TX_STATS 3
>  struct ibmvnic_tx_queue_stats {
>  	atomic64_t batched_packets;
>  	atomic64_t direct_packets;
> @@ -219,13 +218,18 @@ struct ibmvnic_tx_queue_stats {
>  	atomic64_t dropped_packets;
>  };
>  
> -#define NUM_RX_STATS 3
> +#define NUM_TX_STATS \
> +	(sizeof(struct ibmvnic_tx_queue_stats) / sizeof(atomic64_t))
> +

I'd suggest changing this to use the old, u64, type instead of atomic64_t.
Then, once this patch has hit net-next, via net, post the remaining patches
of this patchset for net-next. And at that time, in what is currently the
first patch of this series, which changes the type of the members of struct
ibmvnic_tx_queue_stats, also update u64 to atomic64_t here.

>  struct ibmvnic_rx_queue_stats {
>  	atomic64_t packets;
>  	atomic64_t bytes;
>  	atomic64_t interrupts;
>  };
>  
> +#define NUM_RX_STATS \
> +	(sizeof(struct ibmvnic_rx_queue_stats) / sizeof(atomic64_t))
> +

Likewise here.

>  struct ibmvnic_acl_buffer {
>  	__be32 len;
>  	__be32 version;

