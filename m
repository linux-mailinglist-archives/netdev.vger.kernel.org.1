Return-Path: <netdev+bounces-193364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC438AC3A02
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A943E7A26F9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E61DCB09;
	Mon, 26 May 2025 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDqEj3Fa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F5B1D8E01
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241553; cv=none; b=PeiFcy/0CEByscf3szNLPtME2EJ3Upt4QQ4jaeA92hAAqoCSt591ij3QtYMfRy/1jctCBCP73u7Vqr8B127UEjAWdyLi/2Cb0vBIOiMA3oWwphWYHRnUU18G787HVUmkH9m3KVdpMbAs4/hOcLhSs1ENU2GbR5UdBwBSUBhxBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241553; c=relaxed/simple;
	bh=Ae4tSg4kmOccm2miOn6Vld2T7LyPE4HZAwLWC/VQ3jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMtrnSWxdUtP15pE9EikTprvTx+HC7V3NA16VioByPXsHp9iXKpQfdNqJ0xd1qw0v7wshlZuuF3to4sb5B6xx4VM5B6zE4tJwFzSjzoL2wAPKceP0DmOM/5R2QaSVnVxktD1ZzcJFFxmx/fTiUMejd9SLr+XKTnSEGnr4Stbo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDqEj3Fa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748241550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nm4c9M80Q1z8j97S6rw42ru1/YFOaWVgzS3+rocsC18=;
	b=YDqEj3FaEqAccdU/zIcliXGqWWcH4yrrHaLbauoWY69KCfbx5mguAWntFsf8JNfgPLgY0b
	4BlNloKIPV2eqH1tvnQxpxsmV5bIbeBWzgGsajQhLV0tNKpcj595G0EOqBwMsSNOtW5sbr
	hh+yBJCQ4p3RJfV6NQN/omB7bXM9aHA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-7mpi9VMGPc2tp2SCLeLv7w-1; Mon, 26 May 2025 02:39:09 -0400
X-MC-Unique: 7mpi9VMGPc2tp2SCLeLv7w-1
X-Mimecast-MFC-AGG-ID: 7mpi9VMGPc2tp2SCLeLv7w_1748241548
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so14287715e9.2
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 23:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748241547; x=1748846347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm4c9M80Q1z8j97S6rw42ru1/YFOaWVgzS3+rocsC18=;
        b=EupPUztnevQBYBVDmj87b3ks5S6Avza0v189TJrSZUHRpP9APRbnRVXfSb6xSp/QCZ
         IPhcPHmHLYoIQzLNAG1N1/9PwX/BnwtnChUObd8XQoFigoszvETpYik1Ah8lxSv6iIu+
         XXoSiJLXa9oARPYUpf/yXfR19fftnjNOuiErA/Alb+3ctZduO717T/XyFSR9UJuGVAFB
         KoGCViN1vLAUX2aOt1J7vUZDoXde4wCs4iGanBfDRXz8zFREsb7TeCoE7gfLV/QqNJY5
         vYhgXGS38LxKcUSHz4m9l4HklDgIruY4xzrJ4ZGotMRlYKdn9uPlfr15OYa++cccVDl3
         w5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIUzv13XMhB1w9Qb7JecUUzVKyY9d3KTx8my/lpBs61ysx4XDoNi2eaHVPxHhld1TEku1lzIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoYZuAbzByu9WA3VroCh71ONN+mSnJsv5wg/mDf1TSS3GwNsHd
	3yQ0UNo7Cr9MKnV0KhOzXXM6OsFzomOiFWebCh6myi9+RgAxSfuVfAhZ6Bmh57qEhWsnkX8U5yK
	/yOkMog0DFfrEZrhO8RlGtn2yNqAU1xVlhFw8AnbSQDACimAWd5PSy0wHqw==
X-Gm-Gg: ASbGncsZbFgvEhUah/62H4H+GADL3bPa77NFcFdmRLmWdo7ShJhDvdX+I0KhuLSiJTi
	f6eVaUpabLQLFZcDRUm1D0/BeiFtFTx/YQ42efW6huLBD8ojd9K/wKNkHjyjE8w38yXyCKnQfG9
	s6uh30pK8PNY07TXbYbabCwraaUquaT8oO7JsrUvbX80RyBgj1BqEI8IjampojCGZeUKqqPkEFR
	wqN5ufHQD5L/dMWdFzM6YEg/Jo27vTygvVC+Uo8GaU+VWm2QjoCANhe2DKNCRz17mMN5Iemh/Ol
	Ib0fsJ+R/8U5i3uQTng=
X-Received: by 2002:a05:6000:2507:b0:3a4:dc32:6cba with SMTP id ffacd0b85a97d-3a4dc326effmr712393f8f.4.1748241547629;
        Sun, 25 May 2025 23:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHndZUEepyKYMwEo5a/tkf0IiFhlmHejT7ojvDBOeg+h7FMmR/yDqdIddZzGS2LYqvecgN7Sw==
X-Received: by 2002:a05:6000:2507:b0:3a4:dc32:6cba with SMTP id ffacd0b85a97d-3a4dc326effmr712375f8f.4.1748241547256;
        Sun, 25 May 2025 23:39:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0552esm223589205e9.11.2025.05.25.23.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:39:06 -0700 (PDT)
Message-ID: <be4c5d3d-f2c9-4a09-96ec-0b25470ef9f7@redhat.com>
Date: Mon, 26 May 2025 08:39:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/mlx5: HWS, make sure the uplink is the
 last destination
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
 <1748171710-1375837-3-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1748171710-1375837-3-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/25 1:15 PM, Tariq Toukan wrote:
> @@ -1429,6 +1426,14 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
>  		}
>  	}
>  
> +	if (last_dest_idx != -1) {
> +		struct mlx5hws_cmd_set_fte_dest tmp;
> +
> +		tmp = dest_list[last_dest_idx];
> +		dest_list[last_dest_idx] = dest_list[num_dest - 1];
> +		dest_list[num_dest - 1] = tmp;

Here you can use swap()

/P


