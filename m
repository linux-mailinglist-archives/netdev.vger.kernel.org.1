Return-Path: <netdev+bounces-231099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5CBF4F41
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CA14257F4
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FAA27B4F7;
	Tue, 21 Oct 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcsjzlrZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB827A91F
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031616; cv=none; b=M6uCixy53y0ZFRFMiozzhRefTDeMFcnsK9wh6NGrviv3hxr8xovEbv4AKxtLf8NgJYCbrLV1wdRQ3OMDsD7d/B5MkOB2PyI75nmcG69AxXX3AyrDQ5xn5YNv9rIlW5DEqLj9rtR5Zi74MnTDl/iZCjaC+b/mrDRttFgXdgu9Hng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031616; c=relaxed/simple;
	bh=8fNE3NX1DUD2apr4HvgC0SPEdbANrnlUs0eoTh5oeGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxwLSsd0nbNS0d1FmaDlvaXCsg5xRpUMZzDFmRnVFQDIlZ1QWq+BmM/Xudn0OCBrZk2AtQkJsjg+loYw7ec0dQp83QPTCZkSpEwDXKw+L+gvhU1K3MzTLbyvReNFX8WN7qu8sa926QjB0JeKwCplDbmyFgC3OMToUELxnFc+sLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcsjzlrZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761031613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJDvXzMxMi1pDcKxo2a9jJgMq2W5icRpzq+zghF2eEk=;
	b=UcsjzlrZWP3ufrKMor2LAbQQw1a4afoFb6en2t/aSd8r++azVRGPZkjOZeXijV2w1NIBQN
	ZY1wb5DaqE/gxSwIasDG5bqIUvXLAtSFeQmbaORA5RGXxCaA0escpCpTdHCA8HuGOQzcWO
	GxhCZHLtQHdp9Qhr/DGnjQeO0AjhnJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-6a-cIZr1N5KICY3elzUFRw-1; Tue, 21 Oct 2025 03:26:52 -0400
X-MC-Unique: 6a-cIZr1N5KICY3elzUFRw-1
X-Mimecast-MFC-AGG-ID: 6a-cIZr1N5KICY3elzUFRw_1761031611
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so28382595e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031611; x=1761636411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJDvXzMxMi1pDcKxo2a9jJgMq2W5icRpzq+zghF2eEk=;
        b=k93fZkcNkZuuKh5Nf7eTB8k7fx2GE+u5Zsw3f0eberhMy1jlIm3/ylKGhqp3SDWhAU
         mI53UkxdU04iin6oSey0nhSHrbr1YiTXBfCrSU20bCUpQY4AvrbtEMRIOps8fF+4SVLq
         J03GqkykVN1XKcJH5/snFdCrDPsKw3w2xO4JWYgLtSW21BLHPeyJsl2O313GutG5Y8Vu
         hOIDRiUtnYoaPHrybDlA4GjBvlE5Dn75NUvCq/YFLRTFGvFVM+mFrKJbdaI1Y+PR2i5N
         iSNG67/BbedyjcZ8qlcscxCe0eYzmeqsE0nxo9bbHz78zZczBLXp6w4TWKN5TY9wKcfd
         tLBg==
X-Forwarded-Encrypted: i=1; AJvYcCVyLBMqLZUgi1kGqwWzJly1XqDU26wVhRq0bULenVXV9SN2Gm4uyzmds1eLYXrC5BTGHOFLCzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5XRmf3enc7mRGpAOuRxvp+YBArh3zzyIHFxu9g1ZsxmRze0+
	VepfKzSevKOOGNxTGoTACEKptlQbjkej5OerukGWMcp7SXGkCSPYT5zRKJX9bTmV+rSlDNloPZZ
	/W4ve25nfmfJBzO+a8VtKfz6WC3ab1TQGpbQ0eDVRePdt62v2qpQobHTRhQ==
X-Gm-Gg: ASbGncuJmXrA90z7NncSYWr3JVaexY0jsT1Q0rOo2+mED+oOPPxasIQUGEN6dg45l/g
	gRdBgyt8dZkkDlN+Ib2y1Wg7dIaaagnEvWb2K/HXcC2QmU6IPbS0iTq3b2lNdFVMcGqjOojQIcV
	XL7PQwXYHLgv2kI1+9R+CtPo0hVKsWKcuezppg2NoVJ+QwKIVLylCeJNW5HDok9itD/Su3j/eU3
	ykxjodEo1XXBbLmzVs6sGfUnFVxhNSLZrbHMHQRPf67YC4gWVL0JBjCgVmLqTFuHUKJCAPRWZsj
	kC0UL2/9ajh7r+KaIyWtHF6lcy71jfgHHMgYJc0RqGGHHJlQhNxzRCWnPYboMBstUUsNKYXTliH
	n4xWTsJIPeYD4EWU9aJFQ6awdlimEARhdDHJq3wEJRfKOJOQ=
X-Received: by 2002:a05:600c:540c:b0:471:12be:743 with SMTP id 5b1f17b1804b1-471178a3f93mr118161595e9.15.1761031610912;
        Tue, 21 Oct 2025 00:26:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkWSWmUORa+H15T+v49lrEDk0detT0U6yn7DgHaIoUivTMeJ3869JPfks9PXOdp64Mjfcqeg==
X-Received: by 2002:a05:600c:540c:b0:471:12be:743 with SMTP id 5b1f17b1804b1-471178a3f93mr118161325e9.15.1761031610532;
        Tue, 21 Oct 2025 00:26:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d916sm176481805e9.4.2025.10.21.00.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:26:49 -0700 (PDT)
Message-ID: <11ffb7d0-4e52-496e-84c7-0d93bf03e4cf@redhat.com>
Date: Tue, 21 Oct 2025 09:26:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] net: enetc: add basic support for the ENETC
 with pseudo MAC for i.MX94
To: Wei Fang <wei.fang@nxp.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, Frank.Li@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 richardcochran@gmail.com
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251016102020.3218579-1-wei.fang@nxp.com>
 <20251016102020.3218579-7-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251016102020.3218579-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 12:20 PM, Wei Fang wrote:
> @@ -635,28 +649,10 @@ static void enetc4_pl_mac_config(struct phylink_config *config, unsigned int mod
>  
>  static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
>  {
> -	u32 old_speed = priv->speed;
> -	u32 val;
> -
> -	if (speed == old_speed)
> -		return;
> -
> -	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
> -	val &= ~PCR_PSPEED;
> -
> -	switch (speed) {
> -	case SPEED_100:
> -	case SPEED_1000:
> -	case SPEED_2500:
> -	case SPEED_10000:
> -		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
> -		break;
> -	case SPEED_10:
> -	default:
> -		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
> -	}
> +	u32 val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
>  
>  	priv->speed = speed;
> +	val = u32_replace_bits(val, PCR_PSPEED_VAL(speed), PCR_PSPEED);
>  	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
>  }

The above chunk looks unrelated from the rest of this patch. Perhaps
worth moving to a separate patch in this series? Or add some comments
explaining why it's needed.

Thanks,

Paolo


