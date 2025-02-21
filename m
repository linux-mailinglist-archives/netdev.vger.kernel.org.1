Return-Path: <netdev+bounces-168589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3AA3F6DA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 15:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B713A366B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB50820C48B;
	Fri, 21 Feb 2025 14:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458320A5D8
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146975; cv=none; b=d7nX2F6HIsUi1N04SR9goJwoUXHmnl0oIc+IsMiXfuheI4X91g68lyfC78AAERnNWlh5jDwiKAr+/PaKfDw1+Ed9maRHlLsen/Z4rx4EFoB55VXivN2CJf5rf/qmQooAcwRsKmAIT7Pmk4GIZGIVeWqZJH21rC4K1txjjyt/Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146975; c=relaxed/simple;
	bh=A5JN38YOejtDvZRLlVe5bqdYWZY4tPVqAyIGRCh1wZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOJ6wX0WEkLh4ddCtZFC64ipMbkIHOrQlkeabU2HNRHUECd7LXzq/B6gILR2nO3b9CtAj/Ds2+YJa8F0WO87fVlBOysiVeODcw8/MFx0TUI0eGbaO46s9kAkkiDCt3I70SUyfQ/ulxjkxDZn6yDOuDtdF13XXkIdcSA0DKCiiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af27c.dynamic.kabel-deutschland.de [95.90.242.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 643E161E646F9;
	Fri, 21 Feb 2025 15:09:02 +0100 (CET)
Message-ID: <7d8cfd3b-1e2e-48e3-b9b7-6f8aab8a83d7@molgen.mpg.de>
Date: Fri, 21 Feb 2025 15:09:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ixgbe: fix media type
 detection for E610 device
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, andrew@lunn.ch,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250221135315.5105-1-piotr.kwapulinski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250221135315.5105-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Piotr,


Thank you for the improved version. Two minor nits should you resend.


Am 21.02.25 um 14:53 schrieb Piotr Kwapulinski:
> The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
> device") introduced incorrect media type detection for E610 device. It
> reproduces when advertised speed is modified after driver reload. Clear
> the previous outdated PHY type high value.
> 
> Reproduction steps:
> modprobe ixgbe
> ethtool -s eth0 advertise 0x1000000000000
> rmmod ixgbe

As you use modprobe over insmod, you could also used modprobe -r.

> modprobe ixgbe
> ethtool -s eth0 advertise 0x1000000000000

Is now an error printed?

> Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
> v1 -> v2
>    More commit message details and reproduction steps added
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 683c668..0dfefd2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -1453,9 +1453,11 @@ enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw)
>   			hw->link.link_info.phy_type_low = 0;
>   		} else {
>   			highest_bit = fls64(le64_to_cpu(pcaps.phy_type_low));
> -			if (highest_bit)
> +			if (highest_bit) {
>   				hw->link.link_info.phy_type_low =
>   					BIT_ULL(highest_bit - 1);
> +				hw->link.link_info.phy_type_high = 0;
> +			}
>   		}
>   	}
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

