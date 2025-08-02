Return-Path: <netdev+bounces-211457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F56B18E2D
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 13:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16738AA3516
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 11:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE60219A95;
	Sat,  2 Aug 2025 11:18:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E451EEA5D
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754133508; cv=none; b=iU3rUiTNeG0+WdDGotxeW5ePPxCaUMvqx8PCp/qhlh39Xgc3ZrRJQNjJgNXBwsB3YywuzH56yG9B10pWll3FuZV+DdrHSzu8SB4cx1Z/eFp3BoyIMmio9Jo5Xz55sk+MDeCOnvhnakyp9+SzCtwUSY2ij+cH3/sjby3Iz56DYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754133508; c=relaxed/simple;
	bh=M3ijbfr3mum5lnPs521+VfucI8wpyPANOAX9t+hBmZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9zQcA6gtTQUqIuGJGg15y+PpjXCPLg7CfpjxBainfj4pmd39JgOVdSQMZG8tzRZN+MwFizOR2tk1+89euN8UFeyzDHM1YuISs7m/W/C/r5CO75Tp5tkWZvYln6DlcwbXo3+q39XU02DPuVbM2HjisWxc760IivjLDDKkDqF5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc5571a.dip0.t-ipconnect.de [93.197.87.26])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7960061E6479F;
	Sat, 02 Aug 2025 13:17:57 +0200 (CEST)
Message-ID: <5665468f-4ea1-45ad-8b73-47b028ef5e83@molgen.mpg.de>
Date: Sat, 2 Aug 2025 13:17:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: reduce number of
 reads when getting OROM data
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250731125025.1683557-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250731125025.1683557-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jedrzej,


Thank you for your patch.

Am 31.07.25 um 14:50 schrieb Jedrzej Jagielski:
> Currently, during locating the CIVD section, the ixgbe driver loops
> over the OROM area and at each iteration reads only OROM-datastruct-size
> amount of data. This results in many small reads and is inefficient.
> 
> Optimize this by reading the entire OROM bank into memory once before
> entering the loop. This significantly reduces the probing time.

Awesome. For posterity, could you please add the measurements without 
and with your patch to the commit message.

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 58 +++++++++++++------
>   1 file changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 87b03c1992a8..048b2aae155a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -3006,50 +3006,70 @@ static int ixgbe_get_nvm_srev(struct ixgbe_hw *hw,
>    * Searches through the Option ROM flash contents to locate the CIVD data for
>    * the image.
>    *
> - * Return: the exit code of the operation.
> + * Return: -ENOMEM when cannot allocate memory, -EDOM for checksum violation,
> + *	   -ENODATA when cannot find proper data, -EIO for faulty read or
> + *	   0 on success.
> + *
> + *	   On success @civd stores collected data.
>    */
>   static int
>   ixgbe_get_orom_civd_data(struct ixgbe_hw *hw, enum ixgbe_bank_select bank,
>   			 struct ixgbe_orom_civd_info *civd)
>   {
> -	struct ixgbe_orom_civd_info tmp;
> +	u32 orom_size = hw->flash.banks.orom_size;
> +	u8 *orom_data;
>   	u32 offset;
>   	int err;
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
>   	/* The CIVD section is located in the Option ROM aligned to 512 bytes.
>   	 * The first 4 bytes must contain the ASCII characters "$CIV".
>   	 * A simple modulo 256 sum of all of the bytes of the structure must
>   	 * equal 0.
>   	 */
> -	for (offset = 0; (offset + SZ_512) <= hw->flash.banks.orom_size;
> -	     offset += SZ_512) {
> +	for (offset = 0; (offset + SZ_512) <= orom_size; offset += SZ_512) {
> +		struct ixgbe_orom_civd_info *tmp;
>   		u8 sum = 0;
>   		u32 i;
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
>   		/* Skip forward until we find a matching signature */
> -		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp.signature,
> -			   sizeof(tmp.signature)))
> +		if (memcmp(IXGBE_OROM_CIV_SIGNATURE, tmp->signature,
> +			   sizeof(tmp->signature)))
>   			continue;
>   
>   		/* Verify that the simple checksum is zero */
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
>   	}
>   
> -	return -ENODATA;
> +	err = -ENODATA;
> +cleanup:
> +	kfree(orom_data);
> +	return err;
>   }
>   
>   /**

The diff looks good. With the commit message amended:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

