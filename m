Return-Path: <netdev+bounces-136059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3099A02A5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CE61F2699A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC7192D9D;
	Wed, 16 Oct 2024 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ya9mJeOv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9CF18A920
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063983; cv=none; b=TO1IH0SkFnHoWkx018FOskuJCtgOlylNx6XFIhfnKsC+GE6VTFq8/Q/IXjq7fbD/3NAp2HpHmaHwDbr1sIdZmO5VYp9Gb7XRTDyp1HPA2pW5YbavnWqz6OkTDYPu4R+mcBN5IiBYWd9rZ3t4cbKP76IVO4XWFc0UJmnb6Yx2dKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063983; c=relaxed/simple;
	bh=T6awPUxcRV2/CBK1A8EemWwI0ARo5KzSn4uao/fe2u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS8fChlnGBwykiVoROpU20ymfEmdAXUoA/Fn0VN3lM6/pGN/UJpLC1fmrPP7OR2NGRB1ZjK0EE25p0FTOh52XdUZzFHbqzx820EeMEOTTNc3LyZaaCrryALmPGJ4YPCxQQ8g7L5YWMNAmEuQcGmgrESdazDpmbXpy3rL+WDER1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ya9mJeOv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86e9db75b9so894608866b.1
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 00:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729063980; x=1729668780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkmfvI37fM4cCea1RGGGm3CHgsjq8A6c8nzfgUsjx54=;
        b=ya9mJeOvwk0CpZGQz2aP96T12HXczo66JC2acv3d/FrFmgj1jmcUuq7zjJqByNvMIW
         Ij91SSlSxU3066XrYgYTaWNxf5zgfV2HUAgz9etFnQNj8Mn+YzyRpPmzUnGL+gDLp89l
         Tct6IWOgVkArSXbl9GNQBF9CCaQr86/Mh6TnhxxatBydnNbuNgWCBfXRzUw1RuIPm7pL
         lkhwzwE/+CQL9dlGSBQXhC/2zVPIHoiuiF9m9oXIsnprhYy91IU5gwiGoI5mh7eLYMoy
         XiI5kNk3fWwOMdt3+vbTowylMW3nfv/CWzDTl+UqkDcIt+yontWtmIHxRIlFew2s33N/
         4E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063980; x=1729668780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkmfvI37fM4cCea1RGGGm3CHgsjq8A6c8nzfgUsjx54=;
        b=jer4I0mImtmiyzJHo4+4Q15OxvrPPCvks68VYzZnV48FyHZm8DEYDz0UafLG1k0XCl
         G13j76mmuGPvWxdFmQEB6+8woYWbGYjPrShZ2XuoU5R5xxBlY0ozzXjtHCAe2hfVmVCZ
         FmD90xrjJMTSoyEnW+Xswt5qO89zF4GUZwc0wDu/ftqkkQdgRYbT+R1kyntq05i4r4OI
         YQcj9r9s1Ylbybny5FNyeACrxQoG4UXDooTiAeNf89YZk7L+EL3P4QarDbsO+gWLcO1X
         XlQUCLrHiMO1o/bhqulvOv9twrvHgbXGJOQsMVRkYq6J/fgZEwBtTG0yZVGfeiFUMTnO
         Qv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBsj24KBpHADCIcEtfLDJNfoeVkYmiyNCjv+kW/p8+jHHio99FuiUYfLK/zrlTFn/tKNhM6yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mhHz1o0JXO13FQUl2kJRaN/HNfkNFUUIR5svvT0Ft6SIVjkh
	BrXXHmrEaDc22TLBspNAa0CDuINYbiXRd+6paLPI2jlYa/YD2vmwxvylCBoEmto=
X-Google-Smtp-Source: AGHT+IHdXqZrS9hSsS2s7NntKAPcw8a41BekSqDPVCDbv+ZB5PWjzoKqEeITzxy3aBK+d5Kbo/3BOA==
X-Received: by 2002:a17:907:96a3:b0:a99:fa97:8c2f with SMTP id a640c23a62f3a-a99fa978da4mr1186891466b.53.1729063980451;
        Wed, 16 Oct 2024 00:33:00 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a3f41ab35sm28582666b.180.2024.10.16.00.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:33:00 -0700 (PDT)
Message-ID: <a3a133dc-3616-4aed-9b44-4f9e74a5eda3@blackwall.org>
Date: Wed, 16 Oct 2024 10:32:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] bonding: use correct return value
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241016031649.880-1-liuhangbin@gmail.com>
 <20241016031649.880-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241016031649.880-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 06:16, Hangbin Liu wrote:
> When a slave already has an XDP program loaded, the correct return value
> should be -EEXIST instead of -EOPNOTSUPP.
> 
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index f0f76b6ac8be..6887a867fe8b 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		if (dev_xdp_prog_count(slave_dev) > 0) {
>  			SLAVE_NL_ERR(dev, slave_dev, extack,
>  				     "Slave has XDP program loaded, please unload before enslaving");
> -			err = -EOPNOTSUPP;
> +			err = -EEXIST;
>  			goto err;
>  		}
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



