Return-Path: <netdev+bounces-277308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMJJM0nE2Gk4hwgAu9opvQ
	(envelope-from <netdev+bounces-277308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:35:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6B43D4DEE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C0423039D9F
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D9236F438;
	Fri, 10 Apr 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3b2Q+a9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMUk0Va1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715D36EA98
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813645; cv=none; b=Edzf2PZa92lsMdNSJO6oKY+A09NgLTvo2xBFKSntFqdU0jmk/4t+46o4uhRbhc8KvwIInSSxS/uzoTQlVWynqUB4Adk3btESzGgdmzcxSAeYzVJjGbPNmMvyrNGK8xprLR9OF5EZlbs7xiVBbZEocu32HUzjLLTAGqa8ZnAqeYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813645; c=relaxed/simple;
	bh=PL46tfh1WfqKMuD++IlKnguhPhGvIN5KgQ3WvmFN/y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pG4wN9KESEypWLokeDgErkMVDDFyKEsUWWEE3Q19SPl3ms5JEOSfo75ZRCokM25YGUXQlFUOSRqvpyTXJBkTQiwsKmF4WMR5GlMnhNLCNgjahqnlyhwU5l54sy5GvanXq4VHpxpgDpUia4oQ1rN7M2lNb7Z3jobKHZJgRILtuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3b2Q+a9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMUk0Va1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775813642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbM21vS9RG0xTNneVhbnDW2fnz9h7Hsz+sTJGjyoxSk=;
	b=h3b2Q+a9dwFcY5oUHiGMCZE1s4w2pUGhKM9fTvkvOMH1p7imb5xsT4DRUvxRi/GjUIxuic
	QPxk00Rf/MSwrcNHmJa451Q9Nh7OuheYsguICvwQ+o2/vDjD+J5tJF6Ia21FRD3+JrosbZ
	BQJSwr0VKUN7mTkAHgKwMxeRv5kSXAc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-b--fYoF7PKGryGDTaieUoA-1; Fri, 10 Apr 2026 05:34:01 -0400
X-MC-Unique: b--fYoF7PKGryGDTaieUoA-1
X-Mimecast-MFC-AGG-ID: b--fYoF7PKGryGDTaieUoA_1775813640
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso2970885e9.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775813640; x=1776418440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbM21vS9RG0xTNneVhbnDW2fnz9h7Hsz+sTJGjyoxSk=;
        b=DMUk0Va1Nnn67y9nViXazsWhGvZNab2nSURdYVoXuzJYwfcO5l84NTMTzL3IEEOGIJ
         qNzmDZ/t10gbjXoig/kkKP3OoyDx4ia3dQm+s+x3QY5V0V4iIdEoimoyMvkJGHWzlnHO
         fE3kJGYeGwmgb0UzY3p6S6kdxAhcaU2y/moe0XI5xqy+7bTZfwtClpIJHGhRQNAjKSzV
         7+XNcIEIR4L2C6NhqFY6o6ost31/gAd9ZRtX+MCShGBeDkjej75FTVgLlxqHi9t++xy6
         GmoIQHiecs0vMApQDwSnD1jLHoQG3zQ3hDnhC6Kzk3NMhkzH6VRfGlyu+MoQGjHpJGCS
         j34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813640; x=1776418440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbM21vS9RG0xTNneVhbnDW2fnz9h7Hsz+sTJGjyoxSk=;
        b=fbt+y7r25w59FaLNBSHjxNgLLAwPJuwE95e/0Kdr6+PLZQjCjnW11gxXCnFxyLfYnb
         gFpJarFjZTPFmxMnrJy5mJJSv9xS/ZAEdFmKClO4vQAhPtFFL6ZiLfUlwINjBqrZokjb
         O110WAh36Igt2PHxGUFMAnqlf82pBJ/VW1PKVEto/4QUc53JNPDaA64Hb7uqxBkY0c+5
         QecGZ7S3z+1W270aZFQzUb1fvCkwEgj4Ygoeu+xz8JWOtoXdbY3NjUHa+PgktsQLzplP
         5ugyJxAbDxjE8BhgXlrO57llGjvPQk1KM3umer+Ihubcm4D0a9WypNM18EyBHfkU5FY9
         z0JA==
X-Forwarded-Encrypted: i=1; AJvYcCWlFvfzH+XkCgVrcc0htfULiHeOFI1aL6tMLQpr+t4FjmEPkjjs0MYD4OkLS2UfFhjV/xxscd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD52DWxAumidE4JX7ZK2jjYtkeuaGYE2gdKAKv1/6NqSf4WbaM
	7AJ0UfoPiLp3qDqwow0zeEOio18vAKCH5JcYWgKvpkEVXE5j1EYdPwccX0gQDM8u42O5LbAtAO9
	HbLN5GUVEXBROCufvWef3Ti/1hW1i6iV/bwLwttqnOLfFtHhj3fiVr5Yyqw==
X-Gm-Gg: AeBDieu8dagfIH4TU2ur10qQqi7YzY+CsmW7YU93Uo+Ju4Jhb3VWlNwCZLT8xYVBsmG
	z0F4FzM1BYR4a4IMxFhtStHzz/fpxfnQBubhKobLYjB6OtXfdB8/mpoRTtVEYknwzRLgvXXB8iE
	OT3XGAR2Ezp/Z9/HYqdtOe7JmHOvABXgTL3uNlIgP+B79zW/6TfBe67//JsxVukny4Nw0tkn8eh
	37IR+7P2j3nkMkiM6T0dTbrhG/gK4xgbAQN1KAHVX8/AYVTlyc5k1ISn9it6l/RhVXdZ1/xB+6C
	92bP2PCSYsYj0+ijzuPhO3O1UhjZhory4iRNQ85uKSX9me00VDyTXAyj6x3c9BiOb0B2fZEpkjA
	0zJJ9I1OsCHTHvzn/DKLk
X-Received: by 2002:a05:600c:45cd:b0:488:a82f:bb96 with SMTP id 5b1f17b1804b1-488d68c7fc2mr24692045e9.29.1775813640017;
        Fri, 10 Apr 2026 02:34:00 -0700 (PDT)
X-Received: by 2002:a05:600c:45cd:b0:488:a82f:bb96 with SMTP id 5b1f17b1804b1-488d68c7fc2mr24691485e9.29.1775813639482;
        Fri, 10 Apr 2026 02:33:59 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4a46sm34427405e9.4.2026.04.10.02.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 02:33:57 -0700 (PDT)
Message-ID: <7768956d-f1d6-496b-93ef-10525852e95e@redhat.com>
Date: Fri, 10 Apr 2026 11:33:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/4] ice: perform PHY soft reset
 for E825C ports at initialization
To: Jacob Keller <jacob.e.keller@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
 <20260408-jk-even-more-e825c-fixes-v1-2-b959da91a81f@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-2-b959da91a81f@intel.com>
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
	TAGGED_FROM(0.00)[bounces-277308-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 5D6B43D4DEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/8/26 20:46, Jacob Keller wrote:
> From: Grzegorz Nitka <grzegorz.nitka@intel.com>
>
> In some cases the PHY timestamp block of the E825C can become stuck. This
> is known to occur if the software writes 0 to the Tx timestamp threshold,
> and with older versions of the ice driver the threshold configuration is
> buggy and can race in such that hardware briefly operates with a zero
> threshold enabled. There are no other known ways to trigger this behavior,
> but once it occurs, the hardware is not recovered by normal reset, a driver
> reload, or even a warm power cycle of the system. A cold power cycle is
> sufficient to recover hardware, but this is extremely invasive and can
> result in significant downtime on customer deployments.
>
> The PHY for each port has a timestamping block which has its own reset
> functionality accessible by programming the PHY_REG_GLOBAL register.
> Writing to the PHY_REG_GLOBAL_SOFT_RESET_BIT triggers the hardware to
> perform a complete reset of the timestamping block of the PHY. This
> includes clearing the timestamp status for the port, clearing all
> outstanding timestamps in the memory bank, and resetting the PHY timer.
>
> The new ice_ptp_phy_soft_reset_eth56g() function toggles the
> PHY_REG_GLOBAL soft reset bit with the required delays, ensuring the
> PHY is properly reinitialized without requiring a full device reset.
> The sequence clears the reset bit, asserts it, then clears it again,
> with short waits between transitions to allow hardware stabilization.
>
> Call this function in the new ice_ptp_init_phc_e825c(), implementing the
> E825C device specific variant of the ice_ptp_init_phc(). Note that if
> ice_ptp_init_phc() fails, PTP functionality may be disabled, but the driver
> will still load to allow basic functionality to continue.
>
> This causes the clock owning PF driver to perform a PHY soft reset for
> every port during initialization. This ensures the driver begins life in a
> known functional state regardless of how it was previously programmed.
>
> This ensures that we properly reconfigure the hardware after a device reset
> or when loading the driver, even if it was previously misconfigured with an
> out-of-date or modified driver.
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Timothy Miskell <timothy.miskell@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  4 ++
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 90 ++++++++++++++++++++++++++++-
>   2 files changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> index 5896b346e579..9d7acc7eb2ce 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
> @@ -374,6 +374,7 @@ int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset);
>   int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
>   int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
>   int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
> +int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port);
>   
>   #define ICE_ETH56G_NOMINAL_INCVAL	0x140000000ULL
>   #define ICE_ETH56G_NOMINAL_PCS_REF_TUS	0x100000000ULL
> @@ -676,6 +677,9 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
>   #define ICE_P0_GNSS_PRSNT_N	BIT(4)
>   
>   /* ETH56G PHY register addresses */
> +#define PHY_REG_GLOBAL			0x0
> +#define PHY_REG_GLOBAL_SOFT_RESET_M	BIT(11)
> +
>   /* Timestamp PHY incval registers */
>   #define PHY_REG_TIMETUS_L		0x8
>   #define PHY_REG_TIMETUS_U		0xC
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 67775beb9449..441b5f10e4bb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -377,6 +377,31 @@ static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
>    * The following functions operate on devices with the ETH 56G PHY.
>    */
>   
> +/**
> + * ice_ptp_init_phc_e825c - Perform E825C specific PHC initialization
> + * @hw: pointer to HW struct
> + *
> + * Perform E825C-specific PTP hardware clock initialization steps.
> + *
> + * Return: 0 on success, or a negative error value on failure.
> + */
> +static int ice_ptp_init_phc_e825c(struct ice_hw *hw)
> +{
> +	int err;
> +
> +	/* Soft reset all ports, to ensure everything is at a clean state */
> +	for (int port = 0; port < hw->ptp.num_lports; port++) {
> +		err = ice_ptp_phy_soft_reset_eth56g(hw, port);
> +		if (err) {
> +			ice_debug(hw, ICE_DBG_PTP, "Failed to soft reset port %d, err %d\n",
> +				  port, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * ice_ptp_get_dest_dev_e825 - get destination PHY for given port number
>    * @hw: pointer to the HW struct
> @@ -2179,6 +2204,69 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
>   	return 0;
>   }
>   
> +/**
> + * ice_ptp_phy_soft_reset_eth56g - Perform a PHY soft reset on ETH56G
> + * @hw: pointer to the HW structure
> + * @port: PHY port number
> + *
> + * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
> + * bit in the PHY global register. The reset sequence consists of:
> + *   1. Clearing the soft reset bit
> + *   2. Asserting the soft reset bit
> + *   3. Clearing the soft reset bit again
> + *
> + * Short delays are inserted between each step to allow the hardware
> + * to settle. This provides a controlled way to reinitialize the PHY
> + * without requiring a full device reset.
> + *
> + * Return: 0 on success, or a negative error code on failure when
> + *         reading or writing the PHY register.
> + */
> +int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
> +{
> +	u32 global_val;
> +	int err;
> +
> +	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
> +			  port, err);
> +		return err;
> +	}
> +
> +	global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
> +	ice_debug(hw, ICE_DBG_PTP, "Clearing soft reset bit for port %d, val: 0x%x\n",
> +		  port, global_val);
> +	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
> +			  port, err);
> +		return err;
> +	}
> +
> +	usleep_range(5000, 6000);
> +
> +	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
> +	ice_debug(hw, ICE_DBG_PTP, "Set soft reset bit for port %d, val: 0x%x\n",
> +		  port, global_val);
> +	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
> +	if (err) {
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
> +			  port, err);
> +		return err;
> +	}
> +	usleep_range(5000, 6000);
> +
> +	global_val &= ~PHY_REG_GLOBAL_SOFT_RESET_M;
> +	ice_debug(hw, ICE_DBG_PTP, "Clear soft reset bit for port %d, val: 0x%x\n",
> +		  port, global_val);
> +	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, global_val);
> +	if (err)
> +		ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_REG_GLOBAL for port %d, err %d\n",
> +			  port, err);
> +	return err;
> +}
> +
>   /**
>    * ice_get_phy_tx_tstamp_ready_eth56g - Read the Tx memory status register
>    * @hw: pointer to the HW struct
> @@ -5591,7 +5679,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
>   	case ICE_MAC_GENERIC:
>   		return ice_ptp_init_phc_e82x(hw);
>   	case ICE_MAC_GENERIC_3K_E825:
> -		return 0;
> +		return ice_ptp_init_phc_e825c(hw);
>   	default:
>   		return -EOPNOTSUPP;
>   	}
>
Reviewed-by: Petr Oros <poros@redhat.com>


