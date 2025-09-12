Return-Path: <netdev+bounces-222638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB8B55397
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB0F3B5ADC
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8030EF91;
	Fri, 12 Sep 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuJhZwGg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C419ABD8
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691033; cv=none; b=gMacD7mCyGbYYB69ZlQgSqa1b1/gbrb6Ng0zlNzXDoTQeW2tDT4d/6QpFLTQmhgVYSKc+cSd18ei+ViC9as3Xv2JuitJnZxfKFaPXN/CgCU2axcHDMARfUnSsnfa+APtq2IYRJHE1CXoXeKi3Xg+cVNH4W3jOw66/eeBRbRhl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691033; c=relaxed/simple;
	bh=JQy2x87irR+6b6G3lHlD+F5xfCP7dwLfGCxleWGHNXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dc2XzFSPJC8AjOMZuS95igcVz9RXV8pgb5WrzGigrHynFom7gPnISCatUp9z0y2hYcyLGwdYnBS8gUb2iRD9hvh+VncTjEfff37y7gIdZJ8PwWwg87QQUES28hjL/SNlvBK5V9E8Z9VjZYGmgnmQgh7eXSIFUePK9I5kIiQAn6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuJhZwGg; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a16441so312793566b.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757691030; x=1758295830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EMHcZD7mDT/xOyFARrYbPCbtK2YhAFDuwMRps1CsJQw=;
        b=TuJhZwGgE1gP3sg8/yjMIZ0GdNsA8/hgJpbXGP44V2JG5Td+GpNH4MTZ+PmyabQ95+
         ibdPm+lkV5rZiF0zJGHo+HWPFEECzKZbkGbdAEYatjihjJhGCHXGgLMDDXVznDsH6fgh
         ev8BlwUqSG6vkLHqBRfvWRxkLo3Gc1cObYKXI59TEMprzAs756azmivAWaBT0Ht1idI3
         QqEu4mUT7FYvTX2NN+tBAK5SlZGOk7QL2U0mfiZMpFBU2eZ7azTQkx+7NpxzY5QnUu28
         +3cbDvyXLPzZ4+Rjz205fAi11zmhFEjENQlz/GZkeRFXHFEIsAmwlXGGrUcXeMGEXjFj
         VLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691030; x=1758295830;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMHcZD7mDT/xOyFARrYbPCbtK2YhAFDuwMRps1CsJQw=;
        b=d/d3syRcXFl716V6EwSz5tR5MX4CpPT3/bwN7MOKQxT2bQ5U22jAhrIrOLGbtUyosI
         jOeeQaqDocjkALQ4x8cRJv+gZL7+3SvMahChDdVkkCC7NyWuPODkDPKOdS3pkG8bUBwA
         apGqF+MMjeELpFgpMSkh96Kzw4DaVNWciP9N9EDGt/pi+32MzXWnQSWuQqzgWJIXyWrI
         0Gm/OI05dz/NWPnQBepKzdkPtwmzihhV488BkOpo4CGV2kA4PbMygRxpt9jVtCN0qPFm
         lVZ9l5iwvZH74DeyT9vZzy2i0b2N2HzvM+HjRpsEUEHm5Gf32NU7WkmrVtwTHDi3OLJS
         LrTA==
X-Forwarded-Encrypted: i=1; AJvYcCU2pRuEZGYh3tKgwuIucB20QMHEteEwsLl6PFBsRKhMw87qv0idSHPiBJYM3B7mQaA2VjbUGgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrapTwpFbeY3K3R8XOMUQvbxL8/Pl56NrSh5HodtX+mARfp/bi
	9mhGGsbc/HdjVymOBNAnPOXxq+ZqBlRX22E9FXsv9AHFkdIpSLIBSkMl
X-Gm-Gg: ASbGncsIWjotvAughbV+qxNcMnq1syGKYe2JpbCDpvODjjAT0sT1JL01zxw1jVl785s
	QV1wn5wbRIhC4KTh5JR2/fvhp0bGoAFNRF/jnDAGKusRGk3p5bbB0ScBMgv/2MuLLAoKrmi2juc
	DL3eaE7yzma+CcQx+VdRtw0O563LFp90gVgH5evEe5uL5GnSBZP44KPwfzs/yTa7/s1Q4wTj+8e
	PHlFYSBmcns1eme6U/s+h7lhz4nVcgHJ75NpwDuiucqIoTuw3Zc0on30b8qAQJ1j2+vy8rHudWX
	/YVhJKM6qnIB5fCvhzvODvH0opgE2Eh0n70mpUjH/IsbtWqDTIpsbVzxCrwpd66O73487RzI2fw
	QDmKOwabmf7RIzoi2vtxY5jIeAlpb2WVjfmOQZHPphVRBTUk6d26ofGLseI6Z+irVhVoUAoCjfO
	QOqAbL0GcC/leUk9RzP3KgI9XV1J0c+VyJvlNuoT8U0yWoi4lhcdA/JJnkb+Zh1Nc8GiaF4A==
X-Google-Smtp-Source: AGHT+IGi+LCPKpW/YpBXnwXxivvlBHDvPh4aYIKuRGCS4rbRtN70V4+pwA+CTEbLZ1pjd48/o/8Eww==
X-Received: by 2002:a17:907:944b:b0:b04:21c9:ad83 with SMTP id a640c23a62f3a-b07c3662cf5mr318560166b.52.1757691029481;
        Fri, 12 Sep 2025 08:30:29 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f09:8900:81f2:fb63:ffd:3c7d? (p200300ea8f09890081f2fb630ffd3c7d.dip0.t-ipconnect.de. [2003:ea:8f09:8900:81f2:fb63:ffd:3c7d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b32dd3e4sm387641666b.54.2025.09.12.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:30:28 -0700 (PDT)
Message-ID: <cc91f4ab-e5be-4e7c-abcc-9cc399021e23@gmail.com>
Date: Fri, 12 Sep 2025 17:30:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: enable ASPM on Dell platforms
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Wang, Crag" <Crag.Wang@dell.com>, "Chen, Alan" <Alan.Chen6@dell.com>,
 "Alex Shen@Dell" <Yijun.Shen@dell.com>
References: <20250912072939.2553835-1-acelan.kao@canonical.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250912072939.2553835-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2025 9:29 AM, Chia-Lin Kao (AceLan) wrote:
> Enable PCIe ASPM for RTL8169 NICs on Dell platforms that have been
> verified to work reliably with this power management feature. The
> r8169 driver traditionally disables ASPM to prevent random link
> failures and system hangs on problematic hardware.
> 
> Dell has validated these product families to work correctly with
> RTL NIC ASPM and commits to addressing any ASPM-related issues
> with RTL hardware in collaboration with Realtek.
> 
> This change enables ASPM for the following Dell product families:
> - Alienware
> - Dell Laptops/Pro Laptops/Pro Max Laptops
> - Dell Desktops/Pro Desktops/Pro Max Desktops
> - Dell Pro Rugged Laptops
> 
I'd like to avoid DMI-based whitelists in kernel code. If more system
vendors do it the same way, then this becomes hard to maintain.
There is already a mechanism for vendors to flag that they successfully
tested ASPM. See c217ab7a3961 ("r8169: enable ASPM L1.2 if system vendor
flags it as safe").
Last but not least ASPM can be (re-)enabled from userspace, using sysfs.

> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 29 +++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9c601f271c02..63e83cf071de 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5366,6 +5366,32 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
>  	rtl_rar_set(tp, mac_addr);
>  }
>  
> +bool rtl_aspm_new_dell_platforms(void)
> +{
> +	const char *family = dmi_get_system_info(DMI_PRODUCT_FAMILY);
> +	static const char * const dell_product_families[] = {
> +		"Alienware",
> +		"Dell Laptops",
> +		"Dell Pro Laptops",
> +		"Dell Pro Max Laptops",
> +		"Dell Desktops",
> +		"Dell Pro Desktops",
> +		"Dell Pro Max Desktops",
> +		"Dell Pro Rugged Laptops"
> +	};
> +	int i;
> +
> +	if (!family)
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(dell_product_families); i++) {
> +		if (str_has_prefix(family, dell_product_families[i]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* register is set if system vendor successfully tested ASPM 1.2 */
>  static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  {
> @@ -5373,6 +5399,9 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
>  	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
>  		return true;
>  
> +	if (rtl_aspm_new_dell_platforms())
> +		return true;
> +
>  	return false;
>  }
>  


