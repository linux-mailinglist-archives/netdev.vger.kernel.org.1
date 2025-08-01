Return-Path: <netdev+bounces-211337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07393B180FB
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F7E164411
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1B221FCA;
	Fri,  1 Aug 2025 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERzDBUPF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230062E36E5
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047289; cv=none; b=VgvXp3Sdp4wj5UHq14zRuxubjc17v7Pti5lJU1X1g5Npsoe1OhEnU7mXR4fylVMnc08zEp4bJYdJ7GN4Gsm4/PG7VL1X9Qsvtys/DBH/MJXeviOkgrCrbq1LZeVKMjtldlrPX4cZyfPU29xew0mCrs3pzDvomuzGznUYxA0AQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047289; c=relaxed/simple;
	bh=pEp65GNdz3/656yb3ezhgbsXx5CGqU2Gt3GmTVnoYxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqWrU0KSpzhvej0K4g089twPIonuNcGVRXPUhMlm8A+b9/NBqSxdwcR5iiqAVsWR5rXAWKYfdzRifH8giG8lThIjQzL5Qdw7hjr4XPGSXrRQbFZMI4setVsIdjpykj8AQKH2zGUf77C0vSbLZiSjyAN9MKkJnfipcZmAs2QYR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERzDBUPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760B7C4CEE7;
	Fri,  1 Aug 2025 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754047288;
	bh=pEp65GNdz3/656yb3ezhgbsXx5CGqU2Gt3GmTVnoYxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERzDBUPFX+gAzf/5o01l60KcG5wcIGEB7V8Nv4UZc5t9OszFE5rDzqMyqx2lPsJ4M
	 +VX6TPf4eMh59JZMwPhHGFRWODj3bzGTN1NcE7B3OJRGrCmm5vgPTyHtTHOoegC8ow
	 f88r5s1hj75Z9/FXhYRhBxLqEdmKBKM7E2pKR2xHyC/GaF/PMu4zu8E6IJz8dq/kkt
	 ydJLyFcXOAzMX+LF3bNt6qt5tfPWIONpkT0JzeXb5JKS4SbvAmzovI7cXuvB945Ept
	 IIoaW3azFOjyRVq6Gi7sLBOa7IEGRxOvdrq5uqqBtYO+ruMN8u8e8+zc6AfDyeOKEU
	 KVzXsm7kbIhUg==
Date: Fri, 1 Aug 2025 12:21:25 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1] ixgbe: reduce number of reads when getting
 OROM data
Message-ID: <20250801112125.GO8494@horms.kernel.org>
References: <20250731125025.1683557-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731125025.1683557-1-jedrzej.jagielski@intel.com>

On Thu, Jul 31, 2025 at 02:50:25PM +0200, Jedrzej Jagielski wrote:
> Currently, during locating the CIVD section, the ixgbe driver loops
> over the OROM area and at each iteration reads only OROM-datastruct-size
> amount of data. This results in many small reads and is inefficient.
> 
> Optimize this by reading the entire OROM bank into memory once before
> entering the loop. This significantly reduces the probing time.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Thanks, nits below not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 58 +++++++++++++------
>  1 file changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 87b03c1992a8..048b2aae155a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -3006,50 +3006,70 @@ static int ixgbe_get_nvm_srev(struct ixgbe_hw *hw,
>   * Searches through the Option ROM flash contents to locate the CIVD data for
>   * the image.
>   *
> - * Return: the exit code of the operation.
> + * Return: -ENOMEM when cannot allocate memory, -EDOM for checksum violation,
> + *	   -ENODATA when cannot find proper data, -EIO for faulty read or
> + *	   0 on success.
> + *
> + *	   On success @civd stores collected data.
>   */
>  static int
>  ixgbe_get_orom_civd_data(struct ixgbe_hw *hw, enum ixgbe_bank_select bank,
>  			 struct ixgbe_orom_civd_info *civd)
>  {
> -	struct ixgbe_orom_civd_info tmp;
> +	u32 orom_size = hw->flash.banks.orom_size;
> +	u8 *orom_data;
>  	u32 offset;
>  	int err;
>  
> +	orom_data = kzalloc(orom_size, GFP_KERNEL);
> +	if (!orom_data)
> +		return -ENOMEM;
> +
> +	err = ixgbe_read_flash_module(hw, bank,
> +				      IXGBE_E610_SR_1ST_OROM_BANK_PTR, 0,
> +				      orom_data, orom_size);
> +	if (err) {
> +		err = -EIO;
> +		goto cleanup;
> +	}
> +
>  	/* The CIVD section is located in the Option ROM aligned to 512 bytes.
>  	 * The first 4 bytes must contain the ASCII characters "$CIV".
>  	 * A simple modulo 256 sum of all of the bytes of the structure must
>  	 * equal 0.
>  	 */
> -	for (offset = 0; (offset + SZ_512) <= hw->flash.banks.orom_size;
> -	     offset += SZ_512) {
> +	for (offset = 0; (offset + SZ_512) <= orom_size; offset += SZ_512) {

nit: while we are here the inner parentheses could be removed

> +		struct ixgbe_orom_civd_info *tmp;
>  		u8 sum = 0;
>  		u32 i;
>  
> -		err = ixgbe_read_flash_module(hw, bank,
> -					      IXGBE_E610_SR_1ST_OROM_BANK_PTR,
> -					      offset,
> -					      (u8 *)&tmp, sizeof(tmp));
> -		if (err)
> -			return err;
> +		BUILD_BUG_ON(sizeof(*tmp) > SZ_512);
> +
> +		tmp = (struct ixgbe_orom_civd_info *)&orom_data[offset];
>  
>  		/* Skip forward until we find a matching signature */
> -		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp.signature,
> -			   sizeof(tmp.signature)))
> +		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp->signature,
> +			   sizeof(tmp->signature)))
>  			continue;
>  
>  		/* Verify that the simple checksum is zero */
> -		for (i = 0; i < sizeof(tmp); i++)
> -			sum += ((u8 *)&tmp)[i];
> +		for (i = 0; i < sizeof(*tmp); i++)
> +			sum += ((u8 *)tmp)[i];
>  
> -		if (sum)
> -			return -EDOM;
> +		if (sum) {
> +			err = -EDOM;
> +			goto cleanup;
> +		}
>  
> -		*civd = tmp;
> -		return 0;
> +		*civd = *tmp;
> +		err = 0;
> +		goto cleanup;

nit: maybe it's just me, but break feels more natural here.

>  	}
>  
> -	return -ENODATA;
> +	err = -ENODATA;
> +cleanup:
> +	kfree(orom_data);
> +	return err;
>  }
>  
>  /**
> -- 
> 2.31.1
> 
> 

