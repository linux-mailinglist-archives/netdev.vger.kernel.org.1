Return-Path: <netdev+bounces-139733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF0A9B3EB2
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 00:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA3C1F231E0
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897931F4261;
	Mon, 28 Oct 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kxp6uBow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802DD18130D;
	Mon, 28 Oct 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730159708; cv=none; b=EFlmi1IAcMWJPiezHAAvURwXADuUp/i0e+MgwEzT3JG2BbSS53MA/QGObeuZ1P4y+KbcBXXJCtT4coSzWZ2Hb0JO0m7iwa4lwslcNfvQy0o44W19pkWwvC1E1sRmpLik5gBNkkUe/2YZuvbhJtNK+Ny6+oIFVHFdZJ0u6xpdQLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730159708; c=relaxed/simple;
	bh=jXuNapBKxnt0vtqD6mgvhwwHIVj2R/3axufv96ykCbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eq6YvIa8TyjJ2ytAUdOXXjupTqmct0emKi9Hxib+CyAIzXvXYGTf9L3cT6PT6C+ZnaO4k0jwmD5hD+Gae6rxRTPKtcGrgSjY7g7kYrGiRBnEX+v+UUIvfJm/OtN1nHnbJcR6bhMEpPeVAai57DFM3uArEB9I8kjSR+9Q+T/FYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kxp6uBow; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso45008475e9.3;
        Mon, 28 Oct 2024 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730159705; x=1730764505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCSAb7w1GmldJWVOCxKoC0Mkn/M+7pIQZRhKt7cP6N8=;
        b=Kxp6uBowYG9AoFpYzltZuWyROK6FticcsKV6fyli8GvSVXdd3emTyqgtj/6PYIXNyz
         HOQhQ9Zdy2CIIuDBG1P2eih1atxK7LX/bHJcS/sfNUv7ljS0/Z9PNW9zhJUGstUBAxR1
         MbDb0D5ujNAA1zqSXBKZNEBmEZ3UUqXq7E/F+/CW320EZlrhxhgGoHvvuE7w9+ckNCsS
         okHrVdt7l3tIcZ1+lCFsogGEdkrez7VLeENlGFwcVLCgLrgsp3LtJgRNdhmOlcpmKoIu
         o9pD9sq5Km+Glmc80SWpaAXsCYuKdwPWZcEMUcgiZNWtLa3tbKQMhZtH9K6mVSZm+nNc
         NjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730159705; x=1730764505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCSAb7w1GmldJWVOCxKoC0Mkn/M+7pIQZRhKt7cP6N8=;
        b=dNn0RHFJiTYNnSzUVjMVluPDFDW+YfqJvFNIyG7kslFgaczrkVD/Usp7Cab22RX2PD
         tXNlfk1OyFN3k4PTzgdKiB819nRnenJUnvuvFuL8+FjnsvjcqT4nlrJ9ldSIaAdTyIqD
         pnGpz1ziCl4kD/i6JJYS2VyT+9BhWw8G+hv4r7BR33d0fO7y19niQ5S2epVn++8s+yP6
         ApbsQMOMNtve32glax7jTmwZ45iZPJKyyd74cynx2/GXoiYhYOuTylc6XzUqKsmJ8qse
         fRJ0PePRh7CpvyO7UJOx1kPaugwR7c5skS1EKmaqd89N5Nqaw0pbaypWDP5NflirFNwC
         EotQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkDk9zEgULO+cwQrwTt1ksvpm/s03XwqdoiZE81jV9uu8Cth6eE+v4okvX1bW0PcXntyxVzRuLYCUOd4I=@vger.kernel.org, AJvYcCW2MenY2+sVvkPWGi+OhlExuURpeGVukizwkH51eYXh7systrKE2pa/qJ+Vjwvlv5wFPXD0VrBV@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtD5rg/IKmPSgwZdaOxjb7o5oRYqiHkT/kUM6VBygZIwS/Jc3
	6EURy7HiDsStKWpTb+n0J0JJof7TeOGuTtTYnUBs+AdBzD8gsvNd
X-Google-Smtp-Source: AGHT+IFlXOEKPWixM2CbBX4WfD114h41yRBeY/Sc/ldzOy807Z0Q7Ks0vBcHB52l5tm9G+aXMKALfA==
X-Received: by 2002:a05:600c:3542:b0:42c:bae0:f05b with SMTP id 5b1f17b1804b1-4319ac7425cmr93676285e9.1.1730159704661;
        Mon, 28 Oct 2024 16:55:04 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b79esm158332975e9.47.2024.10.28.16.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 16:55:04 -0700 (PDT)
Message-ID: <34589bdb-8cbd-455d-9e5b-a237d5c2cd0c@gmail.com>
Date: Tue, 29 Oct 2024 01:55:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wwan: t7xx: off-by-one error in
 t7xx_dpmaif_rx_buf_alloc()
To: Jinjie Ruan <ruanjinjie@huawei.com>, chandrashekar.devegowda@intel.com,
 chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
 m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
 loic.poulain@linaro.org, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ilpo.jarvinen@linux.intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241028080618.3540907-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241028080618.3540907-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jinjie,

On 28.10.2024 10:06, Jinjie Ruan wrote:
> The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
> allocated and mapped skb in a loop, but the loop condition terminates when
> the index reaches zero, which fails to free the first allocated skb at
> index zero.
> 
> Check for >= 0 so that skb at index 0 is freed as well.

Nice catch! Still implementation needs some improvements, see below.

> 
> Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> index 210d84c67ef9..f2298330e05b 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> @@ -226,7 +226,7 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpmaif_ctrl,
>   	return 0;
>   
>   err_unmap_skbs:
> -	while (--i > 0)
> +	while (--i >= 0)
>   		t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);

The index variable declared as unsigned so changing the condition alone 
will cause the endless loop. Can you change the variable type to signed 
as well?

--
Sergey

