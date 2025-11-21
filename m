Return-Path: <netdev+bounces-240767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4624C7925C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55D31344327
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325563242B0;
	Fri, 21 Nov 2025 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKjI11Lb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010DF344055
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730557; cv=none; b=gkNRTMrNL8X5SAYzv7zZ700IJeBoPei2UFyAhEnwG05QPj2H+CJ7VtZRY+oQNsfulR5hBm554slbWx3g7D3fzvjin0S8sUTUCd8Db7/NDPV9Q3mu+pAXmPs4XWQm15fI96iK62pesFTTZDgxPWuH56hdw2UdZzsOeLXEEO7xio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730557; c=relaxed/simple;
	bh=1kNZgnokdRlI7YTTKd52iZEubsDvhWy0QKNmrWwpJ0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrYJOXJImSnpSwe/O2qwxHLWciE7TIB6DOe9LRvAl2AYc0uhtzelKwkpipBkFQ7ZAyGk71k1IzQt0iBOxU/xoVGcxh3m4RuJiuns9CVDFIlCqf1pNcKCw1x94RF/PDs1tYcr6/FcAHTyiDipmqpzRLXd2V8UV7kt981IDWxT8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKjI11Lb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso13640495e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763730550; x=1764335350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFMlwqCTPV6LgIow9qjui4+mkS7CwcvLdBw7Wz/wxII=;
        b=PKjI11Lbrao9/q+EcF7/R7iUe8qWdbKJNnC/ybSwz5qdmI+RvwYrhqZAoeIhPfiiMF
         ENImnchXnLvtvMP2iKHnD56l+rnFYcZfbF2b6IiGxUWdNHFeOSlyF2Yz8Sn7IMHw0dIA
         KCsZNpSlkX/W0BO8CFQ/QYTSOuman4vCRJMheQbhqMPpiSp1/S5N9FdtHXvE5ADz1tUi
         QjikZZeFyHrvx2t5DIDt4wM9dOqdhWV5VH7FftJqhEXu3ArwIwwX8sO+c/98rk54G2vC
         4nY/bRaBNcNLPLgwzbioUacR6sSArROqJZWMaxnqmg/Tb9xMo+rJjFnsARCvkf9m1WKs
         8VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730550; x=1764335350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFMlwqCTPV6LgIow9qjui4+mkS7CwcvLdBw7Wz/wxII=;
        b=ptaaNzOJI3nTkBAlwgmygXertYWpXlEYdKG/6TdCno4RCy0gZUqRE8si/SKsUban2P
         /XkoCz6ZM4Y/JBXf0Yn9D2q0hl5xAsL59ibKyj9lsj3eysYwtIXaa3KNXpACTC+342yi
         OZ32e4gazsaJ6TOYvW0fEKIDr1mN1rgjTAjyc12T4NQrjpduIpEk2QpKKubUEm04TFR6
         SsVyRJ3UWU2aT9Q0EmDstjBJEysfZxiw9d5XC335QojQhfwRkR1X2IaMwEASzM6hbNQl
         vpPOBbwjZc36TGq/J6NI+69pxk1tATTZstUORmaj5x7yiSHZOEvF9Au/xjnVI34gtw3/
         KCHw==
X-Forwarded-Encrypted: i=1; AJvYcCUeQmR01LxESjhU/9WbKF9340HEawmTSo7PnDCTcMMaDjiEEsqnC2HoBvXwKflQfpQOmGpq/14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUCaAnQHwGmy/JEtDcj/7ix0lOY/ug3qnsHtui2KIYri0+z5xo
	dSvnugep6fVoXI8CnFhnof0iR06K5dmLKN49LjIrfD2O8SfITSV/1Js9
X-Gm-Gg: ASbGncvikPG5nMyosujr67cL28vRnA+SuPC4RIv/nvvfFJIHqh5ZdLlwhOiGPmFtCKn
	VXMnCbbu9bHKQ7m+u2CO/eJBmL66YHpYhM5rdImh+H00tZH77/dxF+rQqAlFuNSqGvv28xsOW+E
	EHQ4r2vhjfFAJq890d4YMJOkyIssirTskZBwau2dNHt4GQ/UQiobfbsn35jqTcEu5z4SFF7qU1l
	OKwYs81ENaaZyvg+6yBLFB3QTrdM1GhUaY3xuwQWSDWtZUMAvWwqRvApUkrvM5PkGdTFoXeRraN
	druHuKIfEB8B1XZ/UKbkqDAxYxf/qHpuahHTtHP97+R7SMOg6v67LkFDJdjuucvSascHSQyBAr7
	hRISP/I45XURBRkxF70I9/hUWRESIy/qiXFX1v9kGrWVDcrXylaubglnChJqLhqdnBKzpTpschG
	YDQJ3CCP/YYbIb2dyC/cstUZ6u4g7XxPUCTXS6GD8DawGyymW6mQpWGG86xuntMDA5bEu/iilUH
	0iWOC4kMjA1LBBaeWE6lQr2gYAsktrvL9wyFqCEmycekPLAZ47lEUjaT5B2aLj4
X-Google-Smtp-Source: AGHT+IHoItNRpoCOBTJdnxOZ5STshksMTUe0MQdPOU8mrz4QGa20rK1RibgJCBzaf5gs5Q0f4HIW/w==
X-Received: by 2002:a05:600c:1994:b0:477:5aaa:57a6 with SMTP id 5b1f17b1804b1-477c016e402mr21494025e9.10.1763730550006;
        Fri, 21 Nov 2025 05:09:10 -0800 (PST)
Received: from ?IPV6:2003:ea:8f20:6900:2d1a:1f47:fba3:71e8? (p200300ea8f2069002d1a1f47fba371e8.dip0.t-ipconnect.de. [2003:ea:8f20:6900:2d1a:1f47:fba3:71e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3aef57sm40152705e9.11.2025.11.21.05.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 05:09:09 -0800 (PST)
Message-ID: <1ca0e3ed-faab-4203-be4e-9998d6d2b7ad@gmail.com>
Date: Fri, 21 Nov 2025 14:09:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Michael Zimmermann <sigmaepsilon92@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
 <aRxTk9wuRiH-9X6l@google.com> <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
 <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
 <aRzVApYF_8loj8Uo@google.com>
 <CAN9vWDK4LggAGZ-to41yHq4xoduMQdKpj-B6qTpoXiy2fnB=5Q@mail.gmail.com>
 <aRzsxg_MEnGgu2lB@google.com>
 <CAN9vWDKEDFmDiTuPB6ZQF02NYy0QiW2Oo7v4Zcu6tSiMH5Kj9Q@mail.gmail.com>
 <aR2baZuFBuA7Mx_x@google.com>
 <22b15123-b134-467c-835c-c9e0f1e19e29@gmail.com>
 <aSBWiuivrPG8vNKw@google.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aSBWiuivrPG8vNKw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/2025 1:09 PM, Fabio Baltieri wrote:
> On Fri, Nov 21, 2025 at 12:17:33AM +0100, Heiner Kallweit wrote:
>> Could you please test whether the following fixes the chip hang on suspend / shutdown?
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index de304d1eb..97dbe8f89 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -1517,11 +1517,20 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>>  
>>  static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
>>  {
>> -	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
>> -	    tp->mac_version != RTL_GIGA_MAC_VER_28 &&
>> -	    tp->mac_version != RTL_GIGA_MAC_VER_31 &&
>> -	    tp->mac_version != RTL_GIGA_MAC_VER_38)
>> -		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, !enable);
>> +	switch (tp->mac_version) {
>> +	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_24:
>> +	case RTL_GIGA_MAC_VER_28:
>> +	case RTL_GIGA_MAC_VER_31:
>> +	case RTL_GIGA_MAC_VER_38:
>> +		break;
>> +	case RTL_GIGA_MAC_VER_80:
>> +		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, true);
>> +		break;
>> +	default:
>> +		r8169_mod_reg8_cond(tp, PMCH, D3HOT_NO_PLL_DOWN, true);
>> +		r8169_mod_reg8_cond(tp, PMCH, D3COLD_NO_PLL_DOWN, !enable);
>> +		break;
>> +	}
>>  }
>>  
>>  static void rtl_reset_packet_filter(struct rtl8169_private *tp)
> 
> Yes, patched it in and tested on both suspend and reboot without
> touching the wol flags, seems to be working correctly.
> 
Great, thanks for the feedback!

> Thanks!


