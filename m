Return-Path: <netdev+bounces-152524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349129F475E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9126A16E35F
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD61DDA35;
	Tue, 17 Dec 2024 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAyWgjPt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28F01D63F6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734427217; cv=none; b=MnQlGCTD0dtYjZCyB9oBYpupJfARBMTwHF48W9JxSjQVpdLI2zY3ME9+MCwmTGmRb4a7vyTDrhULiaaZDZzO889czaEOu2iC3j03i7DTY/8YgWKRq1TN5aKWw5VuigKau3m25zxikDCeBFm5cDQmvKK7vsrPEd0I7pPzU+A7HjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734427217; c=relaxed/simple;
	bh=h49wb3/FMFiEkSL2cqaXQUDAqaoOthdH188do6RuISM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maJDTApLB8uPVWPSrsiK0byUJm5Uut8LBAFnaU33tIwHT04o2Dov2420EHhGyQ1Y06ixqDUtGATWe3Guhja2he/h/KcVgWDTrL00NZSz2wzzgkEpQZykUj6RpBTp7Hi9/GL76+0hgjSnQs1DyC6HIAYAIJQ5iJdK6jbSchPCT3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAyWgjPt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734427214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECFrhsJcD9yaPs9mZl15tYc8r1V+g7whohkb6M/rkZg=;
	b=BAyWgjPteW3eXadPGColjhX2qgmusFnUlU4wwE36vLHn0uRk9IE+u6zpCAEgA7eDc3JxY3
	vKKklECs+ZXdvEDogrZWW2nSs0BRheItoceQKc6C0idn8CBXz44qJVtxQvSYiIfT01Gk/d
	c1sVbp5kvRo0tSI496SFvcRtzXIvImA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-8V70qmlKN629fnZBpXvW1g-1; Tue, 17 Dec 2024 04:20:13 -0500
X-MC-Unique: 8V70qmlKN629fnZBpXvW1g-1
X-Mimecast-MFC-AGG-ID: 8V70qmlKN629fnZBpXvW1g
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so22118705e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734427212; x=1735032012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECFrhsJcD9yaPs9mZl15tYc8r1V+g7whohkb6M/rkZg=;
        b=g6sEJoXIRTxxLbJlCQwvL1terjJn+XJZSuRfSzu3sseaheGLnvrZ7qBVscGCuuUzLT
         2bUURXcv+EKP07uMvVbo64MpWGROjcc3NmuKPCg1BwgeyqglmXqzzmErJ3PtgevhdN+w
         imCu+PsRl1UguULwI/8MMeCRoLkPQtAQ1f6jLKGZvYIWp3XfUzdbxhWwhObEsuHHnu6T
         2ch2/05K058K/DUp0dKHh4L6OpAxdu9w/A+RksseoJbc+Sugxq6EqzZ8aD3BSD3QAxP6
         8FZ6XJm8tYNRZQrKM2zs5gMUNUQQ9S0n8Tq26LlpfjCC8Lm1O6t6a1XqHjpiBoYOg6lp
         Nx2w==
X-Gm-Message-State: AOJu0YymD4P8mgLXoN0GMgIVZ9oOpU05jrnAAS6sTiXmJlW7DO2PSkAO
	T4kVvgRKvnSfnZ0oTFx/Iv4/maxxNUFyTP8HHn403uitY/ZlOjK+QVpgvoguU25QXrzW4maG24C
	sYyxmD39Wux0barYiIyGPrAPvgjdEOlpKSiItdaTrK9xVjeRG0NXnYQ==
X-Gm-Gg: ASbGnctEn66S5pW0Lzm6uAJ5yeL98FsGcXrmeYECdG+c2FxUz/0E/WU+l6x3ogHdWCB
	QyU+XBq82obxukdbYJCausyi7WZk+YZPa/z6yxowZ2c1/vXMrlSGtF4quZJVkaacl4aBm6tjTae
	v95n+or16d7NWEurRTVLqqlbqmJ9cAyJB1im9kzVQpbrDoq3lFkPg/kRAhYk+fqSP+WTFcUpUDJ
	+tI/JEQ0sCzrDUViHO5T2bY5W+AjlxUbxSM3+4g1iZVvZdrMOnHZLkybfJbpiTlt7QVwVDZ9V8o
	UCYO6ULQmQ==
X-Received: by 2002:a5d:6daa:0:b0:385:e38f:8dd with SMTP id ffacd0b85a97d-3888e0b8e56mr14402500f8f.46.1734427212448;
        Tue, 17 Dec 2024 01:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT45Ia9tcjRNm5HiAwicXMmieHdb6en5L8TLMBtkb6z8PazXLW14+YCs65EkY3Hnh0oRocUQ==
X-Received: by 2002:a5d:6daa:0:b0:385:e38f:8dd with SMTP id ffacd0b85a97d-3888e0b8e56mr14402465f8f.46.1734427212064;
        Tue, 17 Dec 2024 01:20:12 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8016bdfsm10656780f8f.43.2024.12.17.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:20:11 -0800 (PST)
Message-ID: <118bbd72-b1fb-4da2-b1bd-5a66ecfe7322@redhat.com>
Date: Tue, 17 Dec 2024 10:20:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 3/4] net: enetc: add LSO support for i.MX95
 ENETC PF
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, frank.li@nxp.com,
 horms@kernel.org, idosch@idosch.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20241213021731.1157535-1-wei.fang@nxp.com>
 <20241213021731.1157535-4-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241213021731.1157535-4-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 03:17, Wei Fang wrote:
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 09ca4223ff9d..41a3798c7564 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -533,6 +533,224 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
>  	}
>  }
>  
> +static inline int enetc_lso_count_descs(const struct sk_buff *skb)

Please, don't use inline in c files

> +{
> +	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
> +	 * for linear area data but not include LSO header, namely
> +	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
> +	 */
> +	return skb_shinfo(skb)->nr_frags + 4;
> +}
> +static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
> +{
> +	struct enetc_tx_swbd *tx_swbd;
> +	struct enetc_lso_t lso = {0};
> +	int err, i, count = 0;
> +
> +	/* Initialize the LSO handler */
> +	enetc_lso_start(skb, &lso);
> +	i = tx_ring->next_to_use;
> +
> +	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
> +	/* First BD and an extend BD */
> +	count += 2;
> +
> +	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
> +	if (err)
> +		goto dma_err;
> +
> +	/* Go to the next BD */
> +	enetc_bdr_idx_inc(tx_ring, &i);
> +	tx_ring->next_to_use = i;
> +	enetc_update_tx_ring_tail(tx_ring);
> +
> +	return count;
> +
> +dma_err:
> +	do {
> +		tx_swbd = &tx_ring->tx_swbd[i];
> +		enetc_free_tx_frame(tx_ring, tx_swbd);
> +		if (i == 0)
> +			i = tx_ring->bd_count;
> +		i--;
> +	} while (count--);
> +
> +	return 0;
> +}

I'm sorry for not catching the issue early, but apparently there is an
off-by-one in the above loop: if 'count' bds have been used, it will
attempt to free 'count + 1' of them.

The minimal fix should be using:

	} while (--count);

/P


