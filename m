Return-Path: <netdev+bounces-78011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04174873B9A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983121F232D3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BC213A245;
	Wed,  6 Mar 2024 16:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VEe19hPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC213540F
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740971; cv=none; b=thlMsehoxEBHCCNaTKcTsSZrLFzefeyV4tW8i9V73weu4ePoWkyfqQAsKVHxjDY1jCMUkQ2yQnB43WloA4KLNwjWeuQHyAAZNkuTxWWjOXpfDT9XYyW6+mKeyLOgOtCyqTSxaCWWIKm04+vG7oklj1PM0j+Qh9Kk1qLzb3reCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740971; c=relaxed/simple;
	bh=z32H2W0+bAA8K3al791Bcxgn6bvbS8+ewbGc/AfuoCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFr6yZc0edKGOI9wTKZFyXpmT7rRUAGRFr1EkEdtEeomVcg1GHDih7gwxPPf3X4y+bSD1TfxFODOJyssk2DciZ8+NbOPN5OHazORwbNIThJ6N3TdILSCkZE5dRsIlSju/mDgZY96yoOV/fzq0pM1KxFQo4AOgc8DSgTKoFWsQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VEe19hPM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a458850dbddso369958566b.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709740967; x=1710345767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wlU/9Qkg1nIimNbYF8d0Sr5oxlBQPbvYAXTbXHs61WE=;
        b=VEe19hPM7o8fwT9b9ydsTNmyfdxy50CDodrqTbmxw3YZi3qs8Ua5x3YGHuVj9kMPXT
         y5D7UlmWt+cFsWkZnXAPKl/9Oq5CPS7N+PnKVAiqArMz5kjNVOLcK1wZre9gcAoolmdG
         LhnLJmEwDI3bNb8A2hiiNALOI+G3YE0KTpOxKTncqwmm1iYHnyH84lxpJWKZaXiIZv/+
         3z7s7hfjKUqcpMo3ORIoHtAEkW3QKxANhc+CO/hMvhXYm8tETZyS685d0OLruZB29sE3
         1ktTrg/TFOVTapYzUegC7m4FwCmfy5uOHUNRu/lLC5jsaw0L5cI2e29Q+1Bcqdck7OaD
         kC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740967; x=1710345767;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlU/9Qkg1nIimNbYF8d0Sr5oxlBQPbvYAXTbXHs61WE=;
        b=mmsdrwu/MDiLWGrrnAsZvAFoRtRzUZjq02EG6ND8FRwVir9/eLDTQtjCGKP9tTQa3+
         1Kl4Mm2b9f0GB84KWvJVK6YJzd6zxvS9eqiJm46Ah7tpXL7zKDeP60nCs7gMWkREV9eS
         rknqnOoJ1ty3Cw+FDlwMwXUSKVy9YHrbu2ndiHELBu3VGALPAPsdF+4SSGN7us1Yp/WZ
         raGxl2DF5RRzmPq7VrbKHIVa93G5WbaK3TGd1vzt+HhYQev29a1QG+GWOmk5qOOuIQe7
         SmqVLxzHgvhCAhI5WxRDH/Yp1ZhG1vY/mMeNj5aL1XB5SovjTCcr/btusEME+xgp5S8u
         rMKQ==
X-Gm-Message-State: AOJu0Yy4pQkG0p8PWTdr0qmmPE9uvHT/m0P+TMvRXuU9n80w6Lc3c6Sp
	pT+ehxIwg9LUA7osqRWGmRPxegP+nRfSf3nGy2AdWOvfjK+wW3STairKH0a+jYo=
X-Google-Smtp-Source: AGHT+IF8m0GL3sxCfPMOGqxKk9r1J/ZqfuZ1FT4GfMCqSzX+d4XPtDEaLvVUA3E6fvHmfpKQdJCbfw==
X-Received: by 2002:a17:906:a896:b0:a45:bcac:c7e0 with SMTP id ha22-20020a170906a89600b00a45bcacc7e0mr1237580ejb.65.1709740967360;
        Wed, 06 Mar 2024 08:02:47 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:2746:4b81:593e:203b? ([2001:67c:2fbc:0:2746:4b81:593e:203b])
        by smtp.gmail.com with ESMTPSA id ub13-20020a170907c80d00b00a4406929637sm7302832ejc.162.2024.03.06.08.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 08:02:46 -0800 (PST)
Message-ID: <91005d44-8a51-4c6d-9f5c-d5951d92f7c5@openvpn.net>
Date: Wed, 6 Mar 2024 17:03:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
 <053db969-1c21-41db-b0b5-f436593205dc@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <053db969-1c21-41db-b0b5-f436593205dc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2024 23:56, Andrew Lunn wrote:
>> +	ret = ptr_ring_init(&peer->tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		netdev_err(ovpn->dev, "%s: cannot allocate TX ring\n", __func__);
>> +		goto err_dst_cache;
>> +	}
>> +
>> +	ret = ptr_ring_init(&peer->rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		netdev_err(ovpn->dev, "%s: cannot allocate RX ring\n", __func__);
>> +		goto err_tx_ring;
>> +	}
>> +
>> +	ret = ptr_ring_init(&peer->netif_rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		netdev_err(ovpn->dev, "%s: cannot allocate NETIF RX ring\n", __func__);
>> +		goto err_rx_ring;
>> +	}
> 
> These rings are 1024 entries? 

Yes

> The real netif below also likely has
> another 1024 entry ring. Rings like this are latency. Is there a BQL
> like mechanism to actually keep the rings empty, throw packets away
> rather than queue them, because queueing them just accumulates
> latency?

No BQL is implemented yet.

> 
> So, i guess my question is, how do you avoid bufferbloat? Why do you
> actually need these rings?

This is a very good point where I might require some input/feedback.
I have not ignored the problem, but I was hoping to solve it in a future 
iteration. (all the better if we can get it out the way right now)

The reason for having these rings is to pass packets between contexts.

When packets are received from the network in softirq context, they are 
queued in the rx_ring and later processed by a dedicated worker. The 
latter also takes care of decryption, which may sleep.

The same, but symmetric, process happens for packets sent by the user to 
the device: queued in tx_ring and then encrypted by the dedicated worker.

netif_rx_ring is just a queue for NAPI.


I can definitely have a look at BQL, but feel free to drop me any 
pointer/keyword as to what I should look at.


Regards,



-- 
Antonio Quartulli
OpenVPN Inc.

