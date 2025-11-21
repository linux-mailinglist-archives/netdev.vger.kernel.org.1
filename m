Return-Path: <netdev+bounces-240867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D9C7B9A5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3BE3A63B0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488732BE7A1;
	Fri, 21 Nov 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2aRlOs2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2AD20C463
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755169; cv=none; b=shZsw/T6k0v/wIOCaZG5mJI0tasT4I1fKiV9nqd6z3qAsTkOWdF0LPh4vFIBsPltJ69JDbgheMRQd3rzV8fJcSVmUACP1sroY6WiaMTrh4Mr4/ziX7B4B06/z1CPiSqQQJUfgqSYQDbn0MjopWPsMyZUBviUfLOSRTEHYhPyXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755169; c=relaxed/simple;
	bh=HrNZhaxv7onlfpO3ao+whj9c0aPhYTP9eDswdxnDVH4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XoXAFulj17MSjROvv3wZLKD2nAGXxyRqicRRwI+qgfK2E9fVU+4iVq9eTTCcwa4OIl2wn+axHdDKB+8K31SSiUbU1qgG9ID/7fLlQKMvLr0BJRYBPmxo27SD2hvztlX+XWGUGW9CKlwFyekg3gSJI9JiTj+MGrxMHRnQVUxMII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2aRlOs2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so21567615e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763755166; x=1764359966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T8Ep+Gc51oYUhnNGxeVHBvrIQTzHV7wIK3+gDjsdisQ=;
        b=M2aRlOs2GDpiOx2QpAhr84ovxeTj0GUw60n/YgVymiW1m3mIuzVaoGsBQZl70p/3l3
         ia7n5J15Hi4D8LLMDY+g9idOCd45anJJxAhB6tgdrICJKtVyCcvkfs8o1jd/vnNBZ0cu
         NW0gpOKPo4kLcrRBWokj2W+plwRtJW8BgaDToZwET7JITaAvBumBJuQqWF5EtBUNQloM
         Qj5aRMptB8BNFd93e7QwI8251WGGFpiuh9ERWMeMDg6Sh39HCeNBmcJ/COVCl/Q3Ip30
         CWQ9PjQKvYsXKCFR+KUP1Tqdh0P6NMWP7Rwxqh+eY15DdVpjSVqN74pO+4QSWG1180Ds
         ltBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763755166; x=1764359966;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8Ep+Gc51oYUhnNGxeVHBvrIQTzHV7wIK3+gDjsdisQ=;
        b=pISIG6t796mEFeECPgY+87vUGSQRPneLXCrvIa9yBH2f/tnOdHhTHf6qOfzkq4v9sn
         /P4kT4vosXFSKz6cB0lkGl1zKzCcc+67YEkBO+mcabluMXlUPnOiXBmZuQo52PK+nd5o
         XEmBv59rC/SsmAK+7ri8D3EzT8DYKXyvpIJwonBd3ffYXBPbcn1d5nEcMRKsYQRoKO5/
         f15Ey1MiqXaGVO7BODqzkbcfY1CzzkK3ejcltzWRhz6ue0jjcIzvurw5aWDx3e0JMj0s
         FPj4XI5AJWWY/CglgQGp55CYVTEmcE3zQdoNjlqu8cfp+X0hiShP1L4mttsQYq6ASEuO
         /h0g==
X-Gm-Message-State: AOJu0Yy6UEt/XpTSeHs7SrM8AN/U8ZR1cfsCpUJ0sO/9kyoJw++l9Vuc
	c71E5J2xSp00PIQCkfNHukLnNr2zBAEF50uBNbwHpJtGgYgb+BPcwUZY
X-Gm-Gg: ASbGncu2aAPYqnPmekwcI/ruY0TFdBh2iWj1swP4pC/NeX12BQ0ZiaCjAljoW7irgMA
	eemt6kSx+NtL6nwxUjPRO2fvgd//M2sppYZIjLube2+AfQ4RlmkhvtYgrhz1oZ7yX6mQEKcPtbc
	yHHERdjAH8uhOCmWWQF/qDHGJD/2Zem03M72EdWqDAZaNTS/cf5yJgMGRi49TP5YRrhOssXWKfb
	cA+S8DwjIvQyGgbEhqyMlfFRsXEtC1m7baorOB7XOSwsmMaLJ3NiYPt+Vsj+X6beO8K0orE/1bc
	YySaTXuk2pFgQNjW1ZX8/bcO771xkK0NR7nfdEdMbeUVHUbtO+bz4kiaBMVYnAbv+Bv3+NBwyLf
	fYPMbt5WQsqynnO9z0AP9AjoPSe4Cl48JTSD05Zzp1fxr/GeJ6WFW5eAPcqKzUyhf7SdhOlWOdl
	QFj8dcArQ4l94eimO/Aqwl7bhK9jMypxA0OIlK0TedVtByitOa5ZJJiv48+++C6iDHXFutdNzQ+
	F5SRC1VIOYzegtwrZ4/6NAZyGkE01AHq6ESciU3mHsKRt88Hj2giQ==
X-Google-Smtp-Source: AGHT+IH5P86mF1M3xKWsN1AdNrDrU+YK8lyH0R8wXBUOWiT2daT7RxY1tTO3ZTQ9zZaQbN7Zn6+GWg==
X-Received: by 2002:a05:600c:190c:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-477c017d879mr39407505e9.10.1763755165492;
        Fri, 21 Nov 2025 11:59:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f20:6900:adc4:1eb8:ca42:9808? (p200300ea8f206900adc41eb8ca429808.dip0.t-ipconnect.de. [2003:ea:8f20:6900:adc4:1eb8:ca42:9808])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf198a67sm62396735e9.0.2025.11.21.11.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 11:59:24 -0800 (PST)
Message-ID: <f8c902b9-f40c-4966-bb31-560e100b3cc0@gmail.com>
Date: Fri, 21 Nov 2025 20:59:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: fix RTL8127 hang on suspend/shutdown
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
References: <c8f46dfa-00b2-4802-9009-d732005e685b@gmail.com>
Content-Language: en-US
In-Reply-To: <c8f46dfa-00b2-4802-9009-d732005e685b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/2025 6:58 PM, Heiner Kallweit wrote:
> There have been reports that RTL8127 hangs on suspend and shutdown,
> partially disappearing from lspci until power-cycling.
> According to Realtek disabling PLL's when switching to D3 should be
> avoided on that chip version. Fix this by aligning disabling PLL's
> with the vendor drivers, what in addition results in PLL's not being
> disabled when switching to D3hot on other chip versions.
> 
> Fixes: f24f7b2f3af9 ("r8169: add support for RTL8127A")
> Tested-by: Fabio Baltieri <fabio.baltieri@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index de304d1eb..97dbe8f89 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1517,11 +1517,20 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
>  
>  static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
>  {
> -	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
> -	    tp->mac_version != RTL_GIGA_MAC_VER_28 &&
> -	    tp->mac_version != RTL_GIGA_MAC_VER_31 &&
> -	    tp->mac_version != RTL_GIGA_MAC_VER_38)
> -		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, !enable);
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_24:
> +	case RTL_GIGA_MAC_VER_28:
> +	case RTL_GIGA_MAC_VER_31:
> +	case RTL_GIGA_MAC_VER_38:
> +		break;
> +	case RTL_GIGA_MAC_VER_80:
> +		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, true);
> +		break;
> +	default:
> +		r8169_mod_reg8_cond(tp, PMCH, D3HOT_NO_PLL_DOWN, true);
> +		r8169_mod_reg8_cond(tp, PMCH, D3COLD_NO_PLL_DOWN, !enable);
> +		break;
> +	}
>  }
>  
>  static void rtl_reset_packet_filter(struct rtl8169_private *tp)

Will resubmit due to a missing blamed author.

--
pw-bot: cr

