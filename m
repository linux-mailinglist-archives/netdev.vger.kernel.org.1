Return-Path: <netdev+bounces-167316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D45A39BF5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F033B0E9C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A212500C4;
	Tue, 18 Feb 2025 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Stpi2rHf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9425B66C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880726; cv=none; b=OhCJP0sstAzULgJ3XNx54mhWQRorHLz8mW3yTHIDIfeUayiH05AsUFsjWe00Pt9kt6aR98c7Lz6x/0kdL+pWdOxDvheeQr0sFPcrfc6wRrE++Fqx3g259IjJf0ceiSrDo2yeRAILqcuqB4H0340JSFg43ljeP45pQ/1vh2Ih2ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880726; c=relaxed/simple;
	bh=J7YPNgTlSTC9u5qgBvxTm1btToP1NUwYmJ3uu8kpPCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQi/AP1JJHoNcRQA6bPRXc5F5OehfPeu78BmhFpoeHV4LdP40kR/030useOFlAr++39ALq67eTpJtnmcS05bNQnIQS7nPo/zHvQft6Q9rBF14uMZXmwPc7ZwS3RJYCJ94iOCiistyBgcftkkxJzHvaZOeeAsYWN3+yhMlQsgDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Stpi2rHf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f3913569fso1566567f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 04:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739880722; x=1740485522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDr7CbuzwdAjv3j17BGUFIjIaG4/64+enDXiRgGmfYM=;
        b=Stpi2rHf0eoh3mNm3FYiCUiU5Teq1RNcq8fpD0jxPEnes+zY2rFB5ZNDLkJLdu9X4R
         RSOcsagBr6KGy6ADKWpQbIS9NDWST6KCyAmukqP2HyTGeTKuih1Cat78QB3vYFJue06t
         1rcN9Ab1rzqUxzQnlYTlQS9TnIgzCz/lCGxrwX/uPnaUQaqLTOHv84Z5emS1AuKXnWgn
         uZ/uwgqXovSWAVp3M0Z8fa+XousuOn1M85eGcQTpTvIVc+ZPCGqFW/dVmYMYN3epN17b
         9P3aL1FC9zerJ0iNQmVuTQ9xH7u8BX23EUNTaiIwhE6ILf/75BAPgeyWvoMzUbXsecQe
         w9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739880722; x=1740485522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDr7CbuzwdAjv3j17BGUFIjIaG4/64+enDXiRgGmfYM=;
        b=kMEgsBi0o+bKoqQfK2e0PR5HyGKlUy0hp+3Lw4N8VEahxJZdPON9B/864ZLsUSktnp
         kNBf3G0uk4+1li3AhFvrmQ8CyrU3aLTbyUBzrZooZfOlttBhuyYVNbVLV2qAAMrgaHLO
         FFKz2qjlW2eXciNdAmtVDaYIAgVMrwJfj/uBmrIF4IN5S+vuEttRxUNjTumOFEY3lf04
         fmfSzu/0BaSSwjvUDYAgEytb6WbPtWIdzF/O13HiQFIWVVM2crqa4Td7mW3N+dIXDX05
         wCouE688u9VUb7YOAhmN86sOKHyjoTIRyHgeZOpvm2Kay5Rassl1Lkn+v7a9+dzsiuAY
         PXWw==
X-Forwarded-Encrypted: i=1; AJvYcCVxHMPlMgU7/gDhiFs6SgEHsiYUJrq80cjrBjoV7ZKwG8ZsKHuzEgSDX45nYNVEB5rcibVef1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKqtsO+vO0VdlHvlhQvRPWUUJYMNl1cMtd8xvQd91MjwShR6N
	IDTOya3meOM9bZtRCIF2fzsPVfzfGrjLdTw0QHiYcvnMs8nlea2r
X-Gm-Gg: ASbGncuDTg+aU11nKWFaWJoBckf4PFPYH17HUOYXpdPOaTGQQkluGhttpxQzLRFXRQe
	MER1IDEHt3D3WAhPWZHrAw/IS62fqckgdJmS+pc4NC+envyHoesg43ec62v0VtszXfI/9FqNDOz
	4FNi9PM6beqwwE9DShvHmx+9uRyGf4OociUcDl19UZcwcSKZnF8v28TuOhZ03v5//ZkoASHpGTe
	wKtPUyIxQ03rYXnwYWYIEIkIgRUsKMnQ2j8bZTA5E88M0UNC7kiIZi/ecSjiFPtPjnZvovfQAXI
	2G+JayuY78deQG+sV2OC6ia8r9LdQhwoHnrn
X-Google-Smtp-Source: AGHT+IHmfDPFnIDHuEhrdhTvPSFmwSkQRoaBkZsb+G7zM0FAvsiSVhDKC53LoQJrFBcC/7f9k7MjqQ==
X-Received: by 2002:a5d:5889:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-38f24ce773amr20377528f8f.4.1739880722104;
        Tue, 18 Feb 2025 04:12:02 -0800 (PST)
Received: from [172.27.59.237] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5b40sm15005745f8f.68.2025.02.18.04.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:12:01 -0800 (PST)
Message-ID: <ca85460a-39fe-4b9c-83df-50ff925f2219@gmail.com>
Date: Tue, 18 Feb 2025 14:11:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/4] eth: mlx4: don't try to complete XDP
 frames in netpoll
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: tariqt@nvidia.com, idosch@idosch.org, hawk@kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20250213010635.1354034-1-kuba@kernel.org>
 <20250213010635.1354034-3-kuba@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250213010635.1354034-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2025 3:06, Jakub Kicinski wrote:
> mlx4 doesn't support ndo_xdp_xmit / XDP_REDIRECT and wasn't
> using page pool until now, so it could run XDP completions
> in netpoll (NAPI budget == 0) just fine. Page pool has calling
> context requirements, make sure we don't try to call it from
> what is potentially HW IRQ context.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - clarify the commit msg
> v1: https://lore.kernel.org/20250205031213.358973-3-kuba@kernel.org
> ---
>   drivers/net/ethernet/mellanox/mlx4/en_tx.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> index 1ddb11cb25f9..6e077d202827 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
> @@ -450,6 +450,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
>   
>   	if (unlikely(!priv->port_up))
>   		return 0;
> +	if (unlikely(!napi_budget) && cq->type == TX_XDP)
> +		return 0;
>   
>   	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


