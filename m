Return-Path: <netdev+bounces-212414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B90B2014C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084FE3AD348
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC42DCF69;
	Mon, 11 Aug 2025 08:04:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017182DCC01
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899497; cv=none; b=NirN+PW6X8f+L/WxMhU20hDiMbRVoQGIb227vN9qwzfl1D4loEQ2ET5rLXn+5S2x3ZdqEcZrXg2Kjjd4nJCeC3X90FAkC2CxYLZxUXi0VsyJ+OgeFb2CxaHH/XKEUxEV+M8xDfWLPTFSmrcbRYMHfA+5WrpSUeNWcIH0oiX7oG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899497; c=relaxed/simple;
	bh=+g67r8aDRmKN2qdlTJF3hx3zVS05NNaBJpWwwNIhEDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jz1Fzb1CcaxKTYkBRUPqakwBvcbbAKOs+bYM+APmYKCXmBWEIhwbsoTWI75XCTuOG6tH28+FAWuOZpLeD5hRgy6L06pVh0MWM51T91y6S/7N+xCgIbD+4ZE4xQq6uuPvtAWQ755A48fig4HS/0hNHZUodM1ApNrGnkQZ9sZgHho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7bb.dynamic.kabel-deutschland.de [95.90.247.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2182361E64848;
	Mon, 11 Aug 2025 10:04:01 +0200 (CEST)
Message-ID: <ed450a63-bdf8-4a9e-ac19-9853a018e5c1@molgen.mpg.de>
Date: Mon, 11 Aug 2025 10:04:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: fix incorrect map used in
 eee linkmode
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20250810170118.1967090-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250810170118.1967090-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Alok,


Thank you for your patch.


Am 10.08.25 um 19:01 schrieb Alok Tiwari:
> incorrectly used ixgbe_lp_map in loops intended to populate the
> supported and advertised EEE linkmode bitmaps based on ixgbe_ls_map.
> This results in incorrect bit setting and potential out-of-bounds
> access, since ixgbe_lp_map and ixgbe_ls_map have different sizes
> and purposes.
> 
> ixgbe_lp_map[i] -> ixgbe_ls_map[i]
> 
> Use ixgbe_ls_map for supported and advertised linkmodes, and keep
> ixgbe_lp_map usage only for link partner (lp_advertised) mapping.

Nice find! Do you have a reproducer/test case?

> Fixes: 9356b6db9d05 ("net: ethernet: ixgbe: Convert EEE to use linkmodes")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 25c3a09ad7f1..1a2f1bdb91aa 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -3571,13 +3571,13 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
>   
>   	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
>   		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
> -			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> +			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
>   					 edata->supported);
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
>   		if (hw->phy.eee_speeds_advertised & ixgbe_ls_map[i].mac_speed)
> -			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
> +			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
>   					 edata->advertised);
>   	}
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

