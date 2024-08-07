Return-Path: <netdev+bounces-116466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4A94A86E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3947B25D68
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1EE1E7A35;
	Wed,  7 Aug 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4FAeIuP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA2C1CCB32
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036603; cv=none; b=gaekTCeSgLC5Gv+VZWyZFCqQwC1lJjWCEC+AeJyUq9TAFTX3EdMj8/IS3qmxDOQeZNJKV52v+q4A/JA94I8MHTCoTby/x2cPDYHP6KarsKeRICwJEfpgDi71dAMrJGIhL/7jOe7nxq3uAxP103W8rfpU/nMS4eLgxtXg2RwlfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036603; c=relaxed/simple;
	bh=gWXTxKWxKnBSDRDyccgIy7Rh8kC5b9TVDX+3XkmBSTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsGPGt3iG4no7awpqVhgw9PmPwXGv4+Bp1hmejOHrZk8O5I+SV5DWZXEosAu0Rp0qRLclX1X6vCzcDwPBuDgLgn5NbiXZSKBD7HLoPVzd4bJ6kky1eTpue4IB1Wn1eAO0lGbAj5zWH29yQf+6eGGUYD/8yxyyM6viT0kc9pCAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4FAeIuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E749C32782;
	Wed,  7 Aug 2024 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723036603;
	bh=gWXTxKWxKnBSDRDyccgIy7Rh8kC5b9TVDX+3XkmBSTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4FAeIuPaje8FKlKsJiBuqlTGt/77zr7tWI9ipfmM336IYNLr554RNuQVahfCm7Ul
	 IlmV6lASETeeuWHaegoTwPGdbDCNHsxHWanPWSBTaBvxsUrARBsB4TTlCEtdHKNPw+
	 Wn5sBMHhfbI6ytgyQLOInnNj1Nt67qIfC3RUZ2L+KKYlj6isoIabYlYMEJzxNnQT8h
	 8os/hD0goDmC0mJDRb6AbGuihFIA6AYSHymFnBbhN1+mtYblJdwEgzLzNyXYEiyUwg
	 bIyCKzBqdlQQsuSkDIxoKbK0Y8NgenF2ey3nhLDhmomn4vLS+3kgyXwrirQbkBYW0O
	 bAq4L8k3/CJ/w==
Date: Wed, 7 Aug 2024 14:16:39 +0100
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
	ricklind@us.ibm.com
Subject: Re: [PATCH net-next v2 3/7] ibmvnic: Reduce memcpys in tx descriptor
 generation
Message-ID: <20240807131639.GA2991391@kernel.org>
References: <20240806193706.998148-1-nnac123@linux.ibm.com>
 <20240806193706.998148-4-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806193706.998148-4-nnac123@linux.ibm.com>

On Tue, Aug 06, 2024 at 02:37:02PM -0500, Nick Child wrote:
> Previously when creating the header descriptors, the driver would:
> 1. allocate a temporary buffer on the stack (in build_hdr_descs_arr)
> 2. memcpy the header info into the temporary buffer (in build_hdr_data)
> 3. memcpy the temp buffer into a local variable (in create_hdr_descs)
> 4. copy the local variable into the return buffer (in create_hdr_descs)
> 
> Since, there is no opportunity for errors during this process, the temp
> buffer is not needed and work can be done on the return buffer directly.
> 
> Repurpose build_hdr_data() to only calculate the header lengths. Rename
> it to get_hdr_lens().
> Edit create_hdr_descs() to read from the skb directly and copy directly
> into the returned useful buffer.
> 
> The process now involves less memory and write operations while
> also being more readable.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 80 +++++++++++++-----------------
>  1 file changed, 34 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 7d552d4bbe15..4fe2c8c17b05 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2150,46 +2150,38 @@ static int ibmvnic_close(struct net_device *netdev)
>   * Builds a buffer containing these headers.  Saves individual header
>   * lengths and total buffer length to be used to build descriptors.
>   */
> -static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
> -			  int *hdr_len, u8 *hdr_data)
> +static int get_hdr_lens(u8 hdr_field, struct sk_buff *skb,
> +			int *hdr_len)

nit: The Kernel doc immediately above this function should be updated to
     reflect the new name of the function and removal of one parameter.

     Also, although not strictly related to this patch, ideally it should
     include a "Return:" or "Returns:" section.

Flagged by W=1 builds and ./scripts/kernel-doc -none -Wall

...

