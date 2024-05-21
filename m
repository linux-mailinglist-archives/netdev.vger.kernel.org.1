Return-Path: <netdev+bounces-97407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2058B8CB5E0
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 00:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718F31C20A53
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A27148820;
	Tue, 21 May 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY0L3aEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE635894
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716329235; cv=none; b=qgN7xszRcKTJkSytoFJgfO+oJM1vfayRcfcVuBd3hJjQKq4jVPVLiJAgnPkHQIGAaucAiWMlNCiA0KmkN13UMF+Z3KA6PmSG/KkXhuNgYP2eYb85b5o95uczBeGOsepVht/vjtK6TNOuKzuOQkPryw9j8OZgLtk11C220UR16Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716329235; c=relaxed/simple;
	bh=4/SocJVtTlx2jpC30PrCh3JDkjXk6kOLIoa+JhHE48s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMvEVh5hrpVMcPrNV3uXCBVLB+WF3YQZUGmujVqUmW5XosKxgOSrBkWfKee4EpXyGGuSNi/I7dT1jJBuh7FWnKuStzZjNGKJYaleosGOY4TysfStBzAl7AZE8CS1FuKvAYkKFN2pMWPHW1wDguZVSOzWNtFRDKKPv3guVSfTO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY0L3aEC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354b722fe81so218509f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716329232; x=1716934032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xb/UBrZYHxALsiVCP9/3avSOL3EF1Ezebw1+Q3pRV+c=;
        b=IY0L3aECzDB15cbS8/4501+Mm/Us6vXsvjOCZTjYJbOCJNT/ObP8vGXzvX4d+ZEpHu
         /VEaGB/KOLbJoI6IHYq+LiAMFbWdFm+gLhdqwqAfvY75fgWFfDI//dBBaxsK6L5VLY41
         rG83/L845GYmug8v4GfvXGBp2UgBWxVaSiFv4oth74pZR2PsqwQl9qnnlCb1vNgmoNKk
         hsnB0qKwxAxKab8qvV8jiSwSrb5IP3uUFrGHnl4QSQzvLNKiSlT+B1cG560BYm1L8x6w
         6oWZyw+qBbHbEYhEKOOFGiuUHiM8gSng6Wg7pGPI7roCzLgCs4UNnxz8L2HufqFxP7JZ
         Kh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716329232; x=1716934032;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb/UBrZYHxALsiVCP9/3avSOL3EF1Ezebw1+Q3pRV+c=;
        b=o4GbQJso35fWxhraR5KwhFOgFMMLDxPFj2fmhApNuQiGhAesCOf2Km4NUCZxJ180Jt
         8vCNgOae5pjfIXIzMb33Hz0uHj+PCWH98duJwSSVQj8P9bamOzGsuEuFJcsquMEQE5XY
         aP+w/bbtVdWIztlG5W9s3XGqYldn3d8HUmCVxLd08p7R3jbDgfEZ/BZRj0MRFnUuSjyq
         YrPjuDnk2+mwk5RSd+KmEr8ML+GHzTkGcLUzaH+uAUWwn9nhDXyuI0HnEcKffmp9Xuh2
         estoo8CapRNUG9mvwkTxaRgovz8yteBxdMFmBHMXStBzWXeIXayKRE59U4hLCQgVsuee
         bAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDMtxfPsCFMklIqCAO0xBfmAry6lrnoUGQWtoUUCseGFdTj4gXRlrQnoVSWZE09+QZVHss5UItXGG3kX2T0qXNfdXKvxUn
X-Gm-Message-State: AOJu0YwHwsfTlOgBptloWEydVqPdLeIxP4s4rtQ5/bmTc0EBF7jC0D6F
	e0ITM//SHE7twAvNv4I4k8Y7y15/mpXYZPeUstH2luUEAoi1HPUTWTdHtA==
X-Google-Smtp-Source: AGHT+IHiwoQeR19kJMtIed8Va1PQgeU+jgvdIH48GlMMrhyy6elZhESDidEe9ZpBRwqzl/bG/7jTuA==
X-Received: by 2002:a5d:49cf:0:b0:34d:96ca:8c24 with SMTP id ffacd0b85a97d-354d8d18301mr136619f8f.37.1716329232153;
        Tue, 21 May 2024 15:07:12 -0700 (PDT)
Received: from ?IPV6:2a01:c22:73ed:9700:1569:4c96:9bc2:c7fb? (dynamic-2a01-0c22-73ed-9700-1569-4c96-9bc2-c7fb.c22.pool.telefonica.de. [2a01:c22:73ed:9700:1569:4c96:9bc2:c7fb])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3502baacf7esm33162765f8f.77.2024.05.21.15.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 15:07:11 -0700 (PDT)
Message-ID: <2de4a92e-5d8b-4831-9744-1ffcdbc981ef@gmail.com>
Date: Wed, 22 May 2024 00:07:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: Fix possible ring buffer corruption on
 fragmented Tx packets
To: Ken Milmore <ken.milmore@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>
References: <574049c5-70a0-4dd3-85c3-40e396d00b2f@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <574049c5-70a0-4dd3-85c3-40e396d00b2f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.05.2024 23:20, Ken Milmore wrote:
> An issue was found on the RTL8125b when transmitting small fragmented
> packets, whereby invalid entries were inserted into the transmit ring
> buffer, subsequently leading to calls to dma_unmap_single() with a null
> address.
> 
> This was caused by rtl8169_start_xmit() not noticing changes to nr_frags
> which may occur when small packets are padded (to work around hardware
> quirks) in rtl8169_tso_csum_v2().
> 
> To fix this, postpone inspecting nr_frags until after any padding has been
> applied.
> 
> Fixes: 9020845fb5d6 ("r8169: improve rtl8169_start_xmit")

Meanwhile also netdev fixes should have the following:
CC: stable@vger.kernel.org
See https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst

> Signed-off-by: Ken Milmore <ken.milmore@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 86a6d4225bc..86ed9189d5f 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4337,12 +4337,12 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
>  static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>  				      struct net_device *dev)
>  {
> -	unsigned int frags = skb_shinfo(skb)->nr_frags;
>  	struct rtl8169_private *tp = netdev_priv(dev);
>  	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
>  	struct TxDesc *txd_first, *txd_last;
>  	bool stop_queue, door_bell;
>  	u32 opts[2];
> +	unsigned int frags;
>  
netdev wants reverse xmas tree.

>  	if (unlikely(!rtl_tx_slots_avail(tp))) {
>  		if (net_ratelimit())
> @@ -4364,6 +4364,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>  
>  	txd_first = tp->TxDescArray + entry;
>  
> +	frags = skb_shinfo(skb)->nr_frags;
>  	if (frags) {
>  		if (rtl8169_xmit_frags(tp, skb, opts, entry))
>  			goto err_dma_1;

Run get_maintainers.pl. The netdev subsystem maintainers are missing.

Apart from that lgtm.

