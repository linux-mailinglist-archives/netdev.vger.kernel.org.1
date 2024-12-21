Return-Path: <netdev+bounces-153942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5EC9FA213
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874A6160C22
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E2185B4C;
	Sat, 21 Dec 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C22HBiVt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE2B188736;
	Sat, 21 Dec 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734807625; cv=none; b=AeAcVsylT9nvWZpdCb78AjT+rlnVZrdd4za+AbcsOa/qJR+0+r+Hdwt6kdLPyEoWZoUVwzmceYDg5o5r3iiVh3XwZy8ivnihsLofnyND6A89rp6Om0SuxhnBVbO3Zqq9dMSyW4kLBaYqzYAovkDynlqRR90i5dp6WSB9YXexdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734807625; c=relaxed/simple;
	bh=xso+BTQ7wKalTNXo7LxR3Ywz68456X58F4/WojKcj+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfYlnHdDyDWV9OIua27QulktJx55MXiJ1NOdhdvLWTA6VzSH20Np42qPYUojHPZo1PEK16BJI9/zzdN0cSJZ3m4THdWSrhPF5pArDTkIkJrNZIt7dQBwo/Zh1FFU4zgkUrj5naCCMb5rfjdbHch4tNqcz5K+CyZC0XcKh0njyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C22HBiVt; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa679ad4265so712401466b.0;
        Sat, 21 Dec 2024 11:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734807622; x=1735412422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6CAnPCrQ/RQ3sxtJ6/NfqPeIWh1YcOvyFt8Uoyq2I2I=;
        b=C22HBiVtnJgXam5h7i8XNGQDUUseToAjcH6N7kv7GU+wkOJJhylHX8/CKTj0Lg9NUG
         U9UkBIr26mS14Uy1iGW2jC1VcLKxlxtFjB65WiUpPx3zao0plOkcj/t6XedkckBhSyTp
         8UAM0IdOADmsP4/jmn84h2CarrUHpApUsq8k1DTX5/r8EZHU6fjFpdPpnCwUxWfarCOJ
         t0EJeqY/PBHBzHQUfYbmiltMriiWbffhaJFkV0g0Kexff12TSwTZlu5j/Ri+wwUEqMBD
         J1W8iAscbUT6Q40H2TkYOaW3C1QnwYITFe24BVmfqOICs48463fX+f1fDkAGkrzLB2NK
         XggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734807622; x=1735412422;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CAnPCrQ/RQ3sxtJ6/NfqPeIWh1YcOvyFt8Uoyq2I2I=;
        b=G9HyqXgq/qQUzOTsZjVeA/0JSBqv5dYETzOKzfow9lC+kyVbF8/o8/YFTH3ddDEgQu
         vflHgllWGeBGJ1dVlzxbwRQF7W9KoVl0fHoz+lczGxTcmUSv37GBNAQmAcKwxqOK8b5J
         UmD6FbxXaLrvZavwmkOc1p6rw/49V+jRMVjA/xFmxxfBij+BlHekPxok9Zr/NvqBzIC0
         cUKiKpYLre+sD6leplkUoOCMrk0sxL01qF7LsAWI1boF81W3CkOZb2tJ2aeO+S+FiFPi
         bwi2LPKfeqG040Zupx+8dhg1tH4eMGghiLiTTqkKjxZ/uooXNCVQvnlFxsFSg0r8mYXd
         +hSw==
X-Forwarded-Encrypted: i=1; AJvYcCXTWHoSsCRTOL2X+qIClYEWrrugL9txBIrrOgv9dlImdmFZ4Sj39Y2WgNws6DOoJ8NcvvBzZftNUmoIYY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYvALm5OS4XDkIvcnIsEFWrc+1z40UgH/mz0lmm3XjrzAjr4p
	GIyhY8TViVPVAAKUAH7nQsapjFXjcXaUKaXBsmIqjw2zXnH9Fz6zlH36MQ==
X-Gm-Gg: ASbGncvkAh3/BvEajfXwgjZtAkTRz8G70IBlYQ/YE++B4nssoXIPNGEUjkAOr8nFiT4
	+9MTLdU1IwBXbCMJNV72A8/tF+ZqeBc78c+MPogWGdqHGiljhVE1Mp74gxXQTzNEqMqEDEf6a57
	zpMHcE6Rna39JYW7cQKsdhc+roIhbTrHNgaYA+71+cv1qf6C1eSw2dHLGjMrFhwSiOiHRqt1rlr
	gjQk5B9k5b8CaRqird5pjD2Nb0ihTsBz5jvlaImZaqXyOvh8nNVJpDPEzLSjuMP9khBgmFImhIK
	BWdvZzk5BfeBBQLdwi8QeqJTu4GgLMbKfoj3acfxblEqSYextif011SCe1gBOZRzA1tXuo7eQzZ
	sLwadEYArazWAA2pPXNwJWndvhBSz5K18vzbSfU9Y5FLYmA==
X-Google-Smtp-Source: AGHT+IEk0EXG/yVewC8lH/t8QM3FLvkrLccCyJCiCFxE9Yo1ulc/vj8GtEXjoR+6nmWxcysbpJ6N3g==
X-Received: by 2002:a17:907:704:b0:aa6:489e:5848 with SMTP id a640c23a62f3a-aac34695112mr645149166b.25.1734807622244;
        Sat, 21 Dec 2024 11:00:22 -0800 (PST)
Received: from ?IPV6:2a02:3100:a57b:b00:59ac:5c39:b237:9c57? (dynamic-2a02-3100-a57b-0b00-59ac-5c39-b237-9c57.310.pool.telefonica.de. [2a02:3100:a57b:b00:59ac:5c39:b237:9c57])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f06dea8sm307452366b.192.2024.12.21.11.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 11:00:21 -0800 (PST)
Message-ID: <894a61e1-2ac9-40fd-a5fe-97e009f715a8@gmail.com>
Date: Sat, 21 Dec 2024 20:00:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: add support for RTL8125BP rev.b
To: hau@realtek.com, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241220092610.11699-438-nic_swsd@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241220092610.11699-438-nic_swsd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.12.2024 10:26, hau@realtek.com wrote:
> From: ChunHao Lin <hau@realtek.com>
> 
> Add support for RTL8125BP rev.b. Its XID is 0x689. This chip supports
> DASH and its dash type is "RTL_DASH_25_BP".
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
> v2:
> - under rtl_hw_config(), add new entry for rtl8125bp
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 35 +++++++++++++++++++
>  .../net/ethernet/realtek/r8169_phy_config.c   | 23 ++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index e0817f2a311a..7a194a8ab989 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -70,6 +70,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_63,
>  	RTL_GIGA_MAC_VER_64,
>  	RTL_GIGA_MAC_VER_65,
> +	RTL_GIGA_MAC_VER_66,
>  	RTL_GIGA_MAC_VER_70,
>  	RTL_GIGA_MAC_VER_71,
>  	RTL_GIGA_MAC_NONE
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5724f650f9c6..425b1d7291b8 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -58,6 +58,7 @@
>  #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
>  #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
>  #define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
> +#define FIRMWARE_8125BP_2	"rtl_nic/rtl8125bp-2.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
>  
> @@ -142,6 +143,7 @@ static const struct {
>  	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
>  	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
>  	[RTL_GIGA_MAC_VER_65] = {"RTL8125D",		FIRMWARE_8125D_2},
> +	[RTL_GIGA_MAC_VER_66] = {"RTL8125BP",		FIRMWARE_8125BP_2},
>  	[RTL_GIGA_MAC_VER_70] = {"RTL8126A",		FIRMWARE_8126A_2},
>  	[RTL_GIGA_MAC_VER_71] = {"RTL8126A",		FIRMWARE_8126A_3},
>  };
> @@ -632,6 +634,7 @@ enum rtl_dash_type {
>  	RTL_DASH_NONE,
>  	RTL_DASH_DP,
>  	RTL_DASH_EP,
> +	RTL_DASH_25_BP,
>  };
>  
>  struct rtl8169_private {
> @@ -1361,10 +1364,19 @@ static void rtl8168ep_driver_start(struct rtl8169_private *tp)
>  		rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
>  }
>  
> +static void rtl8125bp_driver_start(struct rtl8169_private *tp)
> +{
> +	r8168ep_ocp_write(tp, 0x01, 0x14, OOB_CMD_DRIVER_START);
> +	r8168ep_ocp_write(tp, 0x01, 0x18, 0x00);
> +	r8168ep_ocp_write(tp, 0x01, 0x10, 0x01);
> +}
> +
>  static void rtl8168_driver_start(struct rtl8169_private *tp)
>  {
>  	if (tp->dash_type == RTL_DASH_DP)
>  		rtl8168dp_driver_start(tp);
> +	else if (tp->dash_type == RTL_DASH_25_BP)
> +		rtl8125bp_driver_start(tp);
>  	else
>  		rtl8168ep_driver_start(tp);
>  }
> @@ -1385,10 +1397,19 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
>  		rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
>  }
>  
> +static void rtl8125bp_driver_stop(struct rtl8169_private *tp)
> +{
> +	r8168ep_ocp_write(tp, 0x01, 0x14, OOB_CMD_DRIVER_STOP);
> +	r8168ep_ocp_write(tp, 0x01, 0x18, 0x00);
> +	r8168ep_ocp_write(tp, 0x01, 0x10, 0x01);
> +}
> +
>  static void rtl8168_driver_stop(struct rtl8169_private *tp)
>  {
>  	if (tp->dash_type == RTL_DASH_DP)
>  		rtl8168dp_driver_stop(tp);
> +	else if (tp->dash_type == RTL_DASH_25_BP)
> +		rtl8125bp_driver_stop(tp);
>  	else
>  		rtl8168ep_driver_stop(tp);
>  }
> @@ -1411,6 +1432,7 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
>  	case RTL_DASH_DP:
>  		return r8168dp_check_dash(tp);
>  	case RTL_DASH_EP:
> +	case RTL_DASH_25_BP:
>  		return r8168ep_check_dash(tp);
>  	default:
>  		return false;
> @@ -1425,6 +1447,8 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  		return RTL_DASH_DP;
>  	case RTL_GIGA_MAC_VER_51 ... RTL_GIGA_MAC_VER_53:
>  		return RTL_DASH_EP;
> +	case RTL_GIGA_MAC_VER_66:
> +		return RTL_DASH_25_BP;
>  	default:
>  		return RTL_DASH_NONE;
>  	}
> @@ -2261,6 +2285,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>  		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_71 },
>  		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70 },
>  
> +		/* 8125BP family. */
> +		{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66 },
> +
>  		/* 8125D family. */
>  		{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_65 },
>  		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
> @@ -3793,6 +3820,12 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
>  	rtl_hw_start_8125_common(tp);
>  }
>  
> +static void rtl_hw_start_8125bp(struct rtl8169_private *tp)
> +{
> +	rtl_set_def_aspm_entry_latency(tp);
> +	rtl_hw_start_8125_common(tp);
> +}
> +
>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>  {
>  	rtl_set_def_aspm_entry_latency(tp);
> @@ -3842,6 +3875,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>  		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>  		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
>  		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
> +		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125bp,
>  		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
>  		[RTL_GIGA_MAC_VER_71] = rtl_hw_start_8126a,
>  	};

If the config routine is the same as rtl_hw_start_8125d, then you can use
rtl_hw_start_8125d directly. This also makes clearer that RTL8125BP is derived
from RTL8125D (if that's the case, is it?).
By the way: Why is the new chip version with DASH, if derived from RTL8125D,
called RTL1825BP instead of e.g. RTL8125DP?

And the MODULE_FIRMWARE() entry is missing for the new firmware file.

Note: net-next is closed until end of the year, so you have to resubmit
beginning of January.


