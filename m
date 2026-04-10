Return-Path: <netdev+bounces-277307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC8sNOvD2Gk4hwgAu9opvQ
	(envelope-from <netdev+bounces-277307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:33:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 523BC3D4CB8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 358863015A5E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A804322522;
	Fri, 10 Apr 2026 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0/66fIp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR9ho5dA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DFC2F7445
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813609; cv=none; b=qIH+lziV064arThWyqNlsD3sg8HeqKqEfZ2wvRGgCFAmN9ovS5deLcgHmIDJJblupYA3atixQzCB0lNeKOwiP/HdEM9+zqTBrKtlzcicZC0OcZoBtpAo+yXboWgo4mapUNdw8r592b7b6lBaiTzb8JsLMySakersX9OT8N7YjNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813609; c=relaxed/simple;
	bh=dpMwIr055aQS+F6+NImx9YNGlz7Vav34qwelPZhzTbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hH52B9xvJanMVho+FI1oaFauisrd356EhSrn9VHFtpvI6VKizqpm6SQ17HqKAOwfiRDSu+sNQBpXLo+CRLfB86y6xSz9o2H/Mw7mqGfSfMOLjqHY7Kl+YZ6QYCejJCiuvKjKhPuWhio6xpD48NaarZRs3O9g8yfB6r2keVky8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0/66fIp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BR9ho5dA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775813606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7B/UUfZnQvrc2YpSzdcD/g7Oh2oh/jVTzJlkculeTRk=;
	b=T0/66fIpRHrsdn7f3i8LnGhqNcOXMPfEXOyaoV1AVOWeKsrWNq2zUQPt1pV/RBSQVTNJ7/
	D/bHZA/FxaaLw/BzW9RjILjWXg7ycMqv+Em0TLeKjn1vxCY4x5WSDZDBQcvM0XSxdoxfYG
	xK9LRtydYLkgkeAQYjiKkktIWubilF4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-4MFKZSPOMG-HvuSDpZVP2Q-1; Fri, 10 Apr 2026 05:33:25 -0400
X-MC-Unique: 4MFKZSPOMG-HvuSDpZVP2Q-1
X-Mimecast-MFC-AGG-ID: 4MFKZSPOMG-HvuSDpZVP2Q_1775813604
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d022974acso1570544f8f.2
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775813604; x=1776418404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7B/UUfZnQvrc2YpSzdcD/g7Oh2oh/jVTzJlkculeTRk=;
        b=BR9ho5dAm3FxscRXnJnU+oUjuqNlhHkSLKtJkfeb8p5xv7NYFeMaB6zl9SHsD4rliO
         GKejmQC/m2s+5143Rde7lhyQu7g5ts3sKyEV+LJ+UZRSRB1kgmAtxs8PNY9UupHUHIdw
         1YQyCn6FmR2mkrS2THds51i9/2N0BL+fJPxE+0MVzd5gIV3sWzIed7xTjOUU5JJBCY5C
         3o8qBxnmYleamA6qE8uY7KywoDZp7Ul61w9bUeotHc+yELSa3fmZYTRta+yDuxvKedBN
         xoqpwHpSb2Pxzfh0jNDZiehsl9y0digDug5TKoAv2PHams59tvTEtVvGda/7T7bgHCi7
         ZeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813604; x=1776418404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B/UUfZnQvrc2YpSzdcD/g7Oh2oh/jVTzJlkculeTRk=;
        b=Owp3MZpuaasnQJFRBV6A7gQo051xBkTmgwXOHxb6fTXC11oTAndDu6OG2m+UNzbKlj
         cho1Zdnq9MZ2W/bWptuL7Td6IXIqWwHd8TIHqAl2dqOGSgH1NHlRgjbpgJ009mhFg7Bz
         hj+mhAwipJOXvyjjC5xS1WjbHKdNPmjf9rolmXWm12ral2qhighM8T4SmT4oWd7PERKL
         5bcjJRF95UlxMdyaupO3bg/UsyFD5i+kzO/7oc9Poq7OPjCrlThYJtDHnInBBumXkhxe
         9de3DVXDT/pom9GiiHOLBL9Tu2Gvc/ggpHoA1V4wSFUpN3T3Oq4MRddoKvqzYgDRiYDy
         8QSw==
X-Forwarded-Encrypted: i=1; AJvYcCUO4v9rmt5asKmLSjZx6o64koc631ildhxSFgNhDtMXR3tRJOoINZG7S+Mjxp6vBI/QZ7ZPenw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0LyBSd9zrtMr7NOC+bCgerTH/CtVWaj53u1RPYaArma98DXCs
	Ah2vh8zIVq0Em7Qg/HBRmxaR3/wseEgmwINobMjnt9TmBg7EB5uN4/qL47aQ0oh49FzS2jKjXUX
	13rzkHlCpS0RsdeaVar3jC7m41xoUPHUza4kW+sWSkELd8REy+D+yt6y2ug==
X-Gm-Gg: AeBDieuI6+fgmLs0btztPXme/Ye2klVe8Ops+vPDwyB+yPSN7N3znBi3OEHg+viLWPN
	fxfyTnvCX77HKP+YrB5EbK/svcWbxPGxhBIX37lZxzqDpAFafB1yfzPQrTnHIY0h8SlsUZYbA7N
	/s8+A0b1ZI0+svObRGbMhMetczxIRq/yENMlGn/1RlQ96QRiMdsnnjAPrbzZSSiEUBsDqOPBe1k
	dA8e/I1RcjHJSvcpCdFXuAhP7BIVK3cn8FJvwL6J+cNPUFBW7Gr61vArkIO7AL/h+6/7JDN8DEH
	WJy6mbiUX5jzBoriRx6+qQxHyzTC1qjMy+PTVWk4E9KotC8YJsp9fhmhd0wseZ8jigCmteZHO8w
	6t/BOsGIrF1QfLVMaAUH2
X-Received: by 2002:a05:6000:26c4:b0:43c:f1da:488a with SMTP id ffacd0b85a97d-43d642a4d54mr3403315f8f.13.1775813603810;
        Fri, 10 Apr 2026 02:33:23 -0700 (PDT)
X-Received: by 2002:a05:6000:26c4:b0:43c:f1da:488a with SMTP id ffacd0b85a97d-43d642a4d54mr3403266f8f.13.1775813603236;
        Fri, 10 Apr 2026 02:33:23 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e468c5sm6393551f8f.20.2026.04.10.02.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 02:33:22 -0700 (PDT)
Message-ID: <515bb9be-5623-4589-ba5c-d8e5e8a4f10c@redhat.com>
Date: Fri, 10 Apr 2026 11:33:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 1/4] ice: fix timestamp
 interrupt configuration for E825C
To: Jacob Keller <jacob.e.keller@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
 <20260408-jk-even-more-e825c-fixes-v1-1-b959da91a81f@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-1-b959da91a81f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-277307-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 523BC3D4CB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/8/26 20:46, Jacob Keller wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
> The E825C ice_phy_cfg_intr_eth56g() function is responsible for programming
> the PHY interrupt for a given port. This function writes to the
> PHY_REG_TS_INT_CONFIG register of the port. The register is responsible for
> configuring whether the port interrupt logic is enabled, as well as
> programming the threshold of waiting timestamps that will trigger an
> interrupt from this port.
>
> This threshold value must not be programmed to zero while the interrupt is
> enabled. Doing so puts the port in a misconfigured state where the PHY
> timestamp interrupt for the quad of connected ports will become stuck.
>
> This occurs, because a threshold of zero results in the timestamp interrupt
> status for the port becoming stuck high. The four ports in the connected
> quad have their timestamp status indicators muxed together. A new interrupt
> cannot be generated until the timestamp status indicators return low for
> all four ports.
>
> Normally, the timestamp status for a port will clear once there are fewer
> timestamps in that ports timestamp memory bank than the threshold. A
> threshold of zero makes this impossible, so the timestamp status for the
> port does not clear.
>
> The ice driver never intentionally programs the threshold to zero, indeed
> the driver always programs it to a value of 1, intending to get an
> interrupt immediately as soon as even a single packet is waiting for a
> timestamp.
>
> However, there is a subtle flaw in the programming logic in the
> ice_phy_cfg_intr_eth56g() function. Due to the way that the hardware
> handles enabling the PHY interrupt. If the threshold value is modified at
> the same time as the interrupt is enabled, the HW PHY state machine might
> enable the interrupt before the new threshold value is actually updated.
> This leaves a potential race condition caused by the hardware logic where
> a PHY timestamp interrupt might be triggered before the non-zero threshold
> is written, resulting in the PHY timestamp logic becoming stuck.
>
> Once the PHY timestamp status is stuck high, it will remain stuck even
> after attempting to reprogram the PHY block by changing its threshold or
> disabling the interrupt. Even a typical PF or CORE reset will not reset the
> particular block of the PHY that becomes stuck. Even a warm power cycle is
> not guaranteed to cause the PHY block to reset, and a cold power cycle is
> required.
>
> Prevent this by always writing the PHY_REG_TS_INT_CONFIG in two stages.
> First write the threshold value with the interrupt disabled, and only write
> the enable bit after the threshold has been programmed. When disabling the
> interrupt, leave the threshold unchanged. Additionally, re-read the
> register after writing it to guarantee that the write to the PHY has been
> flushed upon exit of the function.
>
> While we're modifying this function implementation, explicitly reject
> programming a threshold of 0 when enabling the interrupt. No caller does
> this today, but the consequences of doing so are significant. An explicit
> rejection in the code makes this clear.
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 36 +++++++++++++++++++++++++----
>   1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index e3db252c3918..67775beb9449 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -1847,6 +1847,8 @@ static int ice_phy_cfg_mac_eth56g(struct ice_hw *hw, u8 port)
>    * @ena: enable or disable interrupt
>    * @threshold: interrupt threshold
>    *
> + * The threshold cannot be 0 while the interrupt is enabled.
> + *
>    * Configure TX timestamp interrupt for the specified port
>    *
>    * Return:
> @@ -1858,19 +1860,45 @@ int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold)
>   	int err;
>   	u32 val;
>   
> +	if (ena && !threshold)
> +		return -EINVAL;
> +
>   	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, &val);
>   	if (err)
>   		return err;
>   
> +	val &= ~PHY_TS_INT_CONFIG_ENA_M;
>   	if (ena) {
> -		val |= PHY_TS_INT_CONFIG_ENA_M;
>   		val &= ~PHY_TS_INT_CONFIG_THRESHOLD_M;
>   		val |= FIELD_PREP(PHY_TS_INT_CONFIG_THRESHOLD_M, threshold);
> -	} else {
> -		val &= ~PHY_TS_INT_CONFIG_ENA_M;
> +		err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG,
> +					       val);
> +		if (err) {
> +			ice_debug(hw, ICE_DBG_PTP,
> +				  "Failed to update 'threshold' PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
> +				  port, !!ena, threshold);
> +			return err;
> +		}
> +		val |= PHY_TS_INT_CONFIG_ENA_M;
>   	}
>   
> -	return ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, val);
> +	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, val);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_PTP,
> +			  "Failed to update 'ena' PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
> +			  port, !!ena, threshold);
> +		return err;
> +	}
> +
> +	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_TS_INT_CONFIG, &val);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_PTP,
> +			  "Failed to read PHY_REG_TS_INT_CONFIG port=%u ena=%u threshold=%u\n",
> +			  port, !!ena, threshold);
> +		return err;
> +	}
> +
> +	return 0;
>   }
>   
>   /**
>
Reviewed-by: Petr Oros <poros@redhat.com>



