Return-Path: <netdev+bounces-228649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D19BD0CDD
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 23:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4164E189210E
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0CA21C194;
	Sun, 12 Oct 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igJLaO8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE61509A0
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760305518; cv=none; b=C0JrZYZ9VhcC3jB8W3eCthnPNIHAbWQr++B+lA3LGn09K6nFyyaD6Jmh14Y2swZ8pISQup++MqRnu/fa3dVkotqvrMN8bZtoBpio5cSY4HnXdCjFauJuTEomqHJJK/mQRZMBcIlwjq+fwUIOFvCu07lRISfjabCstoiw7wEmycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760305518; c=relaxed/simple;
	bh=pBmB6dYzG/rtjzLSsG5N84atNVrDoFvIvt+ipGGsbGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LES6YmwRbgIE4z1eEIty5WZxTC1WjnDwydbdwdfdiX3Xr9iX63vqCuMqmkLZMQHoy5YpABaCHg8Wv9OqubWGQVDG9MF3r1PwDk9QFR46MpZ/zjMrBy+Sds5ge1s6zw+wUNdc3r3EAI/no5sNesJNY4vr9+yaIW0ra53cdjX5LJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igJLaO8m; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso19327985e9.2
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760305515; x=1760910315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EdKalYrw01A5FTVQGRDTmE39BSRascxTBSrB+kK4iFk=;
        b=igJLaO8m1ku1cvyswXkcuZe4ot/i4CWyYJcbCEMWduMRE88xkgG8dpSjEayujd3NKb
         fcPLGjUqpa932tvO/XdsMzrqFR5x2Ty+18SsC/yt5OE8BpRYAClVIetW9suRWBrG0VyQ
         p56XBfg3eJZLcygugv9kBIDppbNaliL6UGZCa/xKB8cI2FD9ZGQwe3dKRMPgRxSf1DCu
         fnhKnExsySGjSAiyxFPoszdB4DiWEPudncBMVJthabMMaPobD+o+ajiy+CnNVbpfzhwZ
         GuJ4FTCiro9TLexq8QOaP7DzlnL5iR3yVQU2ene+fS2IRICu0RSf/vlkIgd9yPaMRig9
         gzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760305515; x=1760910315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdKalYrw01A5FTVQGRDTmE39BSRascxTBSrB+kK4iFk=;
        b=RwrU6CqdXrIS+pDQ3tPgpqKhVhBa52sEqWY/+3Cp4eJc/AKmUb7ikGekx+wPnNcm1H
         I5xgY15gDACbDLe4TQd8QQHWHjwL90OwPJcBUmrpX0XdYzdF8yUHxjAm9t9OGO8XHXOE
         AN0SqeA/MXVuUPnwACWO5S6jdO+OIxjH3/tebKSUAmI7Ob4M+emHj2uiFcXj+OHjSBJk
         Gcs+WNwLZPXo33L4Q17TGfAYCLJ/GmILImqHvCpdERT8wvaPW7E73WqVGBAwMJ5mf/e5
         QOy5dPaJID7A0SSkZ5iJvzJay61Zulgnsralzd7B/KBORm5HmEQ9q6ccUMP41Hgg27ie
         pCqw==
X-Forwarded-Encrypted: i=1; AJvYcCWYwe4C0x/uUIYUiWS7QePj5Hw8bu766SytoogXLYDqMxhXzkxdmwY6WH2fSuPVYOtPyRx2Sy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl1ucTNSKuKscFfApiUDH4nC9bz3bYtE/2VRSQKPkAvihfhP9X
	AfkvFoMt6LxM2IAnTY+wQXMba+5PAFXjrqtai7/R1z9UT064guIACb4y
X-Gm-Gg: ASbGncvNTcO0yLI6zdTs+3MgJ7BSKSVXWmbX92aS5FsaFTr7byLYut2HNE5pC3bUyqD
	Xv1tEqQ6RKeKC46YojJRkM6nKzK5YKpGxOo1gZVadIFBAaybCXp7XJSGarOKsFJGZQqkxTzZtJB
	aOZPuG9upvqaPFF+suQf9hb2PxkzI1l6YDcGety0apUZvnvlz5nwI0j5al16e8tPM7Q9Mb7qarD
	ILTrptv8FvSve6mx8xhW4yMvGvm8oL7dp1lzkFlzPfq6l1/1c2/TpfQhmZHPYrT7n3mb73P6mJA
	/dikJSmoMCZGrOqKgaGODioNdp+O/rdu8fFYo4lopWFQhb0UgRw3x3mi0zlMMpobcMaktuwXPY2
	fzgmmLb0OTUY2W1E/1GMfHqOiqb6Jl+/ehUi3eRIQ7wiF3fEXwU7uMhwMZ18lAKZdbNZ8SWWRq9
	tO4vI7ue4/6FM5nJrXZfO4TEciMBFQJKB9OJGU6LRZ3Z4Lonyld0+mqbqSPpOeGeS0qr4yr6ek8
	hnYF5nb
X-Google-Smtp-Source: AGHT+IHfZo9JMyPhdR1KDmeLqLu1NQfL2GUGs8Nd5Ab8wV1RidArxbC6pd8I0W5DLpRvpI7dPLCHUw==
X-Received: by 2002:a05:600c:1d11:b0:46e:5aca:3d26 with SMTP id 5b1f17b1804b1-46fa9aef840mr133299445e9.22.1760305514588;
        Sun, 12 Oct 2025 14:45:14 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f04:5200:9878:fefc:dd7a:1ff4? (p200300ea8f0452009878fefcdd7a1ff4.dip0.t-ipconnect.de. [2003:ea:8f04:5200:9878:fefc:dd7a:1ff4])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fab3cd658sm116270535e9.1.2025.10.12.14.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 14:45:13 -0700 (PDT)
Message-ID: <6d9956bc-6816-4726-9bcd-03bce1b9f027@gmail.com>
Date: Sun, 12 Oct 2025 23:45:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
To: Linmao Li <lilinmao@kylinos.cn>, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
References: <20251009122549.3955845-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20251009122549.3955845-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 2:25 PM, Linmao Li wrote:
> After resume from S4 (hibernate), RTL8168H/RTL8111H truncates incoming
> packets. Packet captures show messages like "IP truncated-ip - 146 bytes
> missing!".
> 
> The issue is caused by RxConfig not being properly re-initialized after
> resume. Re-initializing the RxConfig register before the chip
> re-initialization sequence avoids the truncation and restores correct
> packet reception.
> 
Seems to be some chip quirk, as the RxConfig register is re-initialized,
just after the hw reset.

> This follows the same pattern as commit ef9da46ddef0 ("r8169: fix data
> corruption issue on RTL8402").
> 
I wonder whether more chip versions are affected.

What we can do: Apply this as fix for RTL_GIGA_MAC_VER_46 in net.
Then switch to unconditionally calling rtl_init_rxcfg() in net-next.


> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 9c601f271c02..4b0ac73565ea 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4994,8 +4994,9 @@ static int rtl8169_resume(struct device *device)
>  	if (!device_may_wakeup(tp_to_dev(tp)))
>  		clk_prepare_enable(tp->clk);
>  
> -	/* Reportedly at least Asus X453MA truncates packets otherwise */
> -	if (tp->mac_version == RTL_GIGA_MAC_VER_37)
> +	/* Some chip versions may truncate packets without this initialization */
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_37 ||
> +	    tp->mac_version == RTL_GIGA_MAC_VER_46)
>  		rtl_init_rxcfg(tp);
>  
>  	return rtl8169_runtime_resume(device);


