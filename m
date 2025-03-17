Return-Path: <netdev+bounces-175465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F2A66011
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32FE19A1D55
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820B1FC7D2;
	Mon, 17 Mar 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOoQrkzp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78DE7E9;
	Mon, 17 Mar 2025 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245275; cv=none; b=sc/dNBXx3BbkIec+vt0lIJMCYX26S+JmPaCrRorBPE71T8Qte2gWd0PmTNRFfC/kIOQDx1iw2smPNR7syYSHPYTCW5Xnc3OMEuLk7ysASFGzhtmSp8Kz06gcXQwe68x30Kw3E2sH3U6CXhrdwrMiIOB64GVveh5mMZhOgi4Zyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245275; c=relaxed/simple;
	bh=p2YVZYQRf9WN/kGKHtowKY9JsSpZSKLtMxKwWBHCd98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moRZoUyDC7LiwBjxX8J/CSgP4xGg6xI/I2GZ/I1BbUQmhaTUSPSf1guKzFjQS8JNwztkJ81KbCLNM/t87xU9/ZPkVYI63HuAT9WDSZpuSbvLjmyZjd16CFrHC2HwkeE8icPyr8QosG/BxKdkH3A93DAvHUlqXMKUl6lWuuLGz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOoQrkzp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab771575040so1122391666b.1;
        Mon, 17 Mar 2025 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742245272; x=1742850072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5L9yFHvEwuxkSVXYVG/BbTA9FtI76p5+l7yOTCMGbh0=;
        b=NOoQrkzpDEU0RxdfGa9fZJOfOvJWcenJ3NQTKeRYsNkhKCiNThm+DqjXrpFoxtSZ9q
         tnGGQB3bx9uuZ4J1gsN1ZVs2Wc73qz3MLDmPwjwv1RVOe6wkjsTQwQSEUeb1fCz3ZPUa
         Zt2MBlaNXkL9XRqUfdemesxXguWNzEtj8o5zFwgmwezeojJYQL103KHAYb5y4qwwgKlC
         KZqdKx5BxqEDvCWvyzs1bnLhyvDRt2+bqn+x+yf0enRB6azV0rH3aV5T+ihF6IaJBAGt
         teLnAAASdQf5d9PXkmj5znmz8KU9oecUkxOE0WeHbStO5fxcubTfw0h1p1Ie3VDPxOcw
         JLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742245272; x=1742850072;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L9yFHvEwuxkSVXYVG/BbTA9FtI76p5+l7yOTCMGbh0=;
        b=dBZLD5tb3Kko3KL5Izb5xvOt4FI8CH362oLAQ+NzFS4oOhy/vKh+qRRNFq3xdOUEMH
         LdhbVDdWTjbi+u6rFyCTIFgeIOMam/OrLJdz87bLzbGmXOBB/rfaiuk+BNTVNHxe7DK0
         K4xxagFpGh6HGn4UVmz1DaweISK3pKWNRyCLHuhJO8vTCLw+QN8JO28VtRPNFLyr3d+h
         6LgWLq82Gtt5kuokEiTmVJxvrBz2uqvAFCP+TsKOZmtGcWE5A7TkAbhald2rsKvQZP1A
         1b+d/HXAbc4q4LlGGG8s4eBtM3Mz+KPPs8xp7KWNRY3XDivKBVq4JOyVNB6n3zmeN3Co
         DPhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVgIiPyTGlzZ/9l+8RH9hJG1Z8KkEfu77B8y6T8KymyLlwG0rGTi2GSiTj93Q/iKGCYCMh9drLXRqhB7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQ7xdn9lAB06jP0JpIUw+YA/cfPMJw0vbFE2tarXKYWtDtAgA
	BKkORn5KRpjKxAnXN7jvau/KNudNdcKjdEIJL51cMLrYjlmBmtBu
X-Gm-Gg: ASbGncvLYknW2NnBGRrht1k/pyo0B7JtQgzUC4ICDxiP5dmeC0xMEYHU5ORpW9q8gSW
	rmxf0WyySqjs3VKZghbvnH6S0cn3XWie/NScBKzzGnPjtZvzbn6DeCzUCxKTQZwbqckzGcDJwn/
	beecUIr0LFigJUZNuZealncet7VvrUzerKZosuriXWwdElMtMNsfKJBZ0GQxxeN+2m6HJfbv4RT
	xdUGdMAQze3K6exodTLK6rbdrRXZSTSiBcLa4dLlEAyLrYyoRKRxtl5q2dEL56x+vJ6PWFyX6qt
	y+Fk1Zr8rnwz8Qz3OzPeTSX2j/gD2zkFTQpbS+PXYaPTF737YSGaF+drWA/zen42BdtLhWqr72O
	vw9ZPGS/iZaNYzaT9KkDEyOsg+gshheXH0/7jO/7BU5NunEwM5IN3yVptBrdYiyZjwqAeZ+435r
	k3m+V7rtL1OL+YQDfWvWtLsOS4Q8BMCBsNB5x1
X-Google-Smtp-Source: AGHT+IEnnym8fpryOF1gXM2Me2FvldN/5CQdHrRxMYbrbFv96LREQAQcz+DO9M3vu0Rl7YesTL+bQQ==
X-Received: by 2002:a17:907:97c9:b0:ac2:e2bf:d42e with SMTP id a640c23a62f3a-ac38f776594mr68165666b.11.1742245271579;
        Mon, 17 Mar 2025 14:01:11 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b36a:1900:9cb7:dd21:ffd6:1fe2? (dynamic-2a02-3100-b36a-1900-9cb7-dd21-ffd6-1fe2.310.pool.telefonica.de. [2a02:3100:b36a:1900:9cb7:dd21:ffd6:1fe2])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac386314658sm86681466b.135.2025.03.17.14.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 14:01:11 -0700 (PDT)
Message-ID: <9cc1ed25-1244-4f4d-8e5e-fe5113a07fbe@gmail.com>
Date: Mon, 17 Mar 2025 22:01:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] r8169: disable RTL8126 ZRX-DC timeout
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250317084236.4499-1-hau@realtek.com>
 <20250317084236.4499-3-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250317084236.4499-3-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.03.2025 09:42, ChunHao Lin wrote:
> Disable it due to it dose not meet ZRX-DC specification. If it is enabled,
> device will exit L1 substate every 100ms. Disable it for saving more power
> in L1 substate.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3c663fca07d3..ad3603cf7595 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2852,6 +2852,25 @@ static u32 rtl_csi_read(struct rtl8169_private *tp, int addr)
>  		RTL_R32(tp, CSIDR) : ~0;
>  }
>  
> +static void rtl_disable_zrxdc_timeout(struct rtl8169_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pci_dev;
> +	u32 csi;
> +	u8 val;
> +
> +#define RTL_GEN3_RELATED_OFF	0x0890
> +#define RTL_GEN3_ZRXDC_NONCOMPL	0x1
> +	if (pdev->cfg_size > RTL_GEN3_RELATED_OFF &&
> +	    pci_read_config_byte(pdev, RTL_GEN3_RELATED_OFF, &val) == PCIBIOS_SUCCESSFUL &&
> +	    pci_write_config_byte(pdev, RTL_GEN3_RELATED_OFF, val & ~RTL_GEN3_ZRXDC_NONCOMPL) == PCIBIOS_SUCCESSFUL)

These two lines are too long. Netdev allows only 80 chars.
checkpatch.pl would have noticed you.

Apart from that, looks good to me.

> +		return;
> +
> +	netdev_notice_once(tp->dev,
> +		"No native access to PCI extended config space, falling back to CSI\n");
> +	csi = rtl_csi_read(tp, RTL_GEN3_RELATED_OFF);
> +	rtl_csi_write(tp, RTL_GEN3_RELATED_OFF, csi & ~RTL_GEN3_ZRXDC_NONCOMPL);

For my understanding: The csi functions always deal with 32bit values.
Does this mean that all Realtek-specific registers in extended config
space are 32bit registers?

> +}
> +
>  static void rtl_set_aspm_entry_latency(struct rtl8169_private *tp, u8 val)
>  {
>  	struct pci_dev *pdev = tp->pci_dev;
> @@ -3824,6 +3843,7 @@ static void rtl_hw_start_8125d(struct rtl8169_private *tp)
>  
>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>  {
> +	rtl_disable_zrxdc_timeout(tp);
>  	rtl_set_def_aspm_entry_latency(tp);
>  	rtl_hw_start_8125_common(tp);
>  }


