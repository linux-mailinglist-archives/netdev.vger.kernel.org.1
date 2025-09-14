Return-Path: <netdev+bounces-222853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F7B56AB1
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7673BB472
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFD126CE03;
	Sun, 14 Sep 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="UEyTsq/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22880248F78
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757868978; cv=none; b=ZxHJ7XD+PtWDG5X+mbVTfcxYtwOltdjEva8YVAgavIJqLC8OYL0h6LtEY93Nul95ZDl7+hYifSHOaZZCnDBHOH9ICbrlu0szqeKewf/zQg/DHrDd/p6GYSzdXbkd7FK7UEg5UU1thQX368wkeKWORjR3NRz8EtrD6K1BFqmR0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757868978; c=relaxed/simple;
	bh=RkfQfhlJbWyA2LHc1bvVYWrp9RkM8HrXK7A2wjNzvIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb5iIqTLVPNzKiAsv92fkgA/h7V3bEYnyj1lBJ+m/yHQZQ9HpB3ExuN4STBXDI+ilDeOT+eQmz1uZLwllo7ffv5oms/qq3EVyWL2unj4Fx6zdphvnpbb3dox+1fbPiwKeIF84dik2kTOhMdlaBdYuHJynGWRFh6QXnSFtbI3pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=UEyTsq/8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0428b537e5so469091966b.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1757868974; x=1758473774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPlpyeAwSRDCzGoq7PgUzo7R9sROP9lHXNmER4Pl0Oo=;
        b=UEyTsq/8pAHwi+9IH7M466q475q0LO+gzT9fX/DKEThrKeJ4CVCViGmTCEM9hneJbN
         tzDYssgdnVoC2KRYJM/5MoN5mideTncUgNFC9+TkC7ZMoqrMb0EC+GDMI+JTI8brCgcy
         FH10yS7ugg2I7a1NHE8791AcrUeSFwsMgT9ttuj2dyHi2mpgygjYfTHDlJWQ+sLxcNTH
         Aw1uWKyGWp9TEGE4no9J95JcdbyLVeyw2Zi4SHizjKaBMhZK+CB69iqApmeCBa/Lrj4A
         1BRDk1KaiPEictdpO/quanr2HJFmfT5esvxx+pdAOJUZZnlA1zbXs1y0HsKrPasKTrT2
         nqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757868974; x=1758473774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPlpyeAwSRDCzGoq7PgUzo7R9sROP9lHXNmER4Pl0Oo=;
        b=jB7bRdENF8RR18XFP6eBulUR6T2nyT1LYXvlfQj0dn3i5gRNZcQ/JqGZpVIV0Uukz0
         1FTgzhG1u6jT63webJ0pg0KuXLLJteb4RfmZ5AvdplY/KNWKFQqyiMoX+J2YOlR52kvA
         ycNsJRxp4dYjXbU+9AEL1zY5AZVSazDQ94L/lRVwCKHMxpqvjupzRrw3yT9SMpNO5fpX
         fZlUZVBEk/5CWtxGD00OjhsRBpxmiIRJLZ/98qHyCEufetyYTnLnLYEmjJLkYjnZm0/A
         4l1j3lrNsbe9GjPeLMd0VQ7K0prEsyqHUHXLfJqSi9cCug+b+PJtPQ9tslAXBA6io7Ju
         3eug==
X-Gm-Message-State: AOJu0YzVLfENRpxvV4FMyZYawxbWqkobY1xG+lpExSr3/VKihY0hD6pr
	NqJ2as0ndInAFPKLOtPfu4fCW17hAlRw09aNfNh3rWSIg8YHA8DbckpruR6MLoLC+CjdGjNtB4A
	xD5xmJzA=
X-Gm-Gg: ASbGnctpkdNRGlTOoo4cA0wwCeLZxO3s1kN+wn7z/Bl7jC/zGuYeO4s7Ukp21dLvuuu
	i9DZ/s7izTEU+eKS918+dArw2esXkmQkPP8RQdy/qekngXiLGTdO2W7C9zyFHnC/PaNm4CIwgjD
	ffXIl+RIONrvl/akyVOeiofNJHu2all2m923bGzOMcldq9noTgsO73MUevg5QvFX2WmRjDDg/j3
	vTxDrcDNwAX05zrgNgSTGbvk/gkJ7tqqrTpmPbwS7SiWQNETEySv/o7PlFtxocWMPPIFbKAunJD
	2wKihjNL+j+QNvXC3hjtOkFkfd4NrOo9IEAjZxDbp8NEiqfDWzyyRmL0tu6RdO7Eg2uq8Tf/31b
	2Fh9Dx/VnFH3ALzg88G3ASptLPUP3SdkKq4uJSlXhHA+huIUYJQ2QYPD9oMR47w3xhq98lQ==
X-Google-Smtp-Source: AGHT+IFo7cg/KTe51S4KiqVqGNE/pynRgI3QfYqO9osoGDCNwd6sXzlp1MQZ0N6YUJ78vOJwr7Bgcw==
X-Received: by 2002:a17:907:9344:b0:b04:4786:5dfa with SMTP id a640c23a62f3a-b07c3820e57mr986866666b.35.1757868974236;
        Sun, 14 Sep 2025 09:56:14 -0700 (PDT)
Received: from ?IPV6:2a02:810a:b98:a000::a43c? ([2a02:810a:b98:a000::a43c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da302sm768603066b.16.2025.09.14.09.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 09:56:13 -0700 (PDT)
Message-ID: <a9d9967d-ef5d-47ff-88a5-b1fcf9bcd319@cogentembedded.com>
Date: Sun, 14 Sep 2025 18:56:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: renesas: rswitch: simplify rswitch_stop()
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250913181345.204344-1-yury.norov@gmail.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20250913181345.204344-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> rswitch_stop() opencodes for_each_set_bit().
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>   drivers/net/ethernet/renesas/rswitch.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
> index aba772e14555..9497c738b828 100644
> --- a/drivers/net/ethernet/renesas/rswitch.c
> +++ b/drivers/net/ethernet/renesas/rswitch.c
> @@ -1627,9 +1627,7 @@ static int rswitch_stop(struct net_device *ndev)
>   	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
>   		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
>   
> -	for (tag = find_first_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT);
> -	     tag < TS_TAGS_PER_PORT;
> -	     tag = find_next_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT, tag + 1)) {
> +	for_each_set_bit(tag, rdev->ts_skb_used, TS_TAGS_PER_PORT) {
>   		ts_skb = xchg(&rdev->ts_skb[tag], NULL);
>   		clear_bit(tag, rdev->ts_skb_used);
>   		if (ts_skb)

Probably shall be [PATCH net], otherwise

Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

