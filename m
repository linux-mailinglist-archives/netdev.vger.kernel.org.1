Return-Path: <netdev+bounces-226421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD1B9FFAE
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B06D3A5056
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492FC29B79A;
	Thu, 25 Sep 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtyPcheZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24629ACF0
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810249; cv=none; b=p/pOIZAx1UGIQDryE91NIOv3aSARCiBU8ImH+54fH+/J+XNcExuiwnqdRnrPGLydMQLpQw/Jq2/cqGuxjdxk8h4xyb+J5sfmJRiHi/QRMzNb8FVLAa29CrtRDQhU/5QEwuz06P67Yy2rLMETVwJZOc/+aBAXc1V42vMsjIy/q2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810249; c=relaxed/simple;
	bh=dYuqr2GSG8NOMs6Xn8T29IWXFaooQ8AMUrrXaiN16FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnUfSwSrJFV3QtkTZeHgB4sJ3BBqfOgt5p/1phZuV2T5D3RKEcoNLFWuNEG12tSxSgdXZy0lvQvKQ9JBskG66IRb8rvw7cS/K/CTqjeSA3KG6wOFr+oLLq1ZOQGs76siO5ZIwtVwXihGXzGyhjT1lCNf3MF+yI1IHtmdORtwb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtyPcheZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758810246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMuxM89R6MEfDdd+6bytrowoXrE1EfEgsSy96sExds8=;
	b=HtyPcheZL8R5stNnnUcFiQG9KLvV1nTt1fg4cJCK1NagfAh6+LUT4mYyNAdqlsLVTzgR0p
	twkJS8KINgrZhTItW2W5D78z1kYNjQJBk4i/UipaXtZDB6ykr1QDC4UfGSXMfkLnwEhOQk
	XEE3rbTRGh5bb9fqRWq5OHroiJD/5TQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-4ECyEnjnPAu1W59Hs8R3CQ-1; Thu, 25 Sep 2025 10:24:05 -0400
X-MC-Unique: 4ECyEnjnPAu1W59Hs8R3CQ-1
X-Mimecast-MFC-AGG-ID: 4ECyEnjnPAu1W59Hs8R3CQ_1758810244
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e39567579so777185e9.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810244; x=1759415044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMuxM89R6MEfDdd+6bytrowoXrE1EfEgsSy96sExds8=;
        b=kQmSbzqWtx5eqlM3t3LFrDFaelYoLR0oj90Gk1OHpV25HhJDNfmqJ+2iSRsWba5GYV
         nQ/GqpbEw+Rj+TVrCwvkqzhNX8O6Vk2IgDu/viB8mrMqh+waCQLEplkm66T1UUiGy650
         0aNweq5RxrhT1pgGkprj/xC+udmVt/NWaJM2pxs72R7MYfEpS1ITj7N9txVm1OfgUyI3
         vMS+Bw4HRRRnmQLMqLtqmZiLCaqE5rfT8qPGFZWvAwAVHAQuvnl/5X8lOYONHuaPX0Ay
         +nYjSAKMoAFApbrZe6le6azSOb02/FBh8gHAHGgy2HPqRAHm3NpA7Q0UxjHtMSctf7tG
         h7GA==
X-Gm-Message-State: AOJu0YwvUUvgYkX1G8u+byNcZJUYlefln4vLGkbu+OLsNJeMCIgOqt0S
	VeVpEfiua5KbcqevRmQIL0tF48pbAh+vzupDkoJkbglRxyLcSke4AhcuM97HavPZxA7AApKSasr
	MkDEMNW2XOPZGSElA5NzlvDizhbUY4V/DQRTV0emnEj2G4s3Fdz1Pfj60Rg==
X-Gm-Gg: ASbGncvHzDD+OyaGxJh8NjDHPUADvimP2T16q9+e64CVypaF9M3CzrK6qcDO+IHP9Aj
	MRs+RuchX95n7MgL5vrfeUd4zug4/WesNJl+Jbfq4QzOQOg3eER3OoCQo2xIqixJkz2lgVPLKFQ
	UnWOPxEC/de2OnxGUUGt1rILU9qnWV433aHEU5xPWKvql0UgLiOYJNlDRmlsvQ8HnmS/k/J8DVu
	cGuWoGynIk9MtK0o5ZcAhNNi+oDKnMgqwHpfIwJuWLPAOYFVvKyJfHnwT8m/d96rbO5tZhIBkqA
	XIIZ2/HWSEZoZl1mCaB6sd94xfw8eIFX4z/Jp7a+AGVajB6XWMCGT+TA/KYwEMUS4IGYev38IDl
	NMolznwaDljos
X-Received: by 2002:a05:600c:1c9b:b0:45d:d9ab:b85a with SMTP id 5b1f17b1804b1-46e3299f565mr43904305e9.7.1758810243696;
        Thu, 25 Sep 2025 07:24:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9YXnhD0FxsllUyBaiVQWY9PkmgoZepRKRm35fQoWyBGnECcfNupZbIZQvTB8qYn0+J32BDg==
X-Received: by 2002:a05:600c:1c9b:b0:45d:d9ab:b85a with SMTP id 5b1f17b1804b1-46e3299f565mr43903915e9.7.1758810243276;
        Thu, 25 Sep 2025 07:24:03 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33b9eabbsm39079635e9.3.2025.09.25.07.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:24:02 -0700 (PDT)
Message-ID: <0bf3a83d-2fa0-4dc9-9a50-39463d31d4de@redhat.com>
Date: Thu, 25 Sep 2025 16:24:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 17/17] geneve: Enable BIG TCP packets
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tcpdump-workers@lists.tcpdump.org,
 Guy Harris <gharris@sonic.net>, Michael Richardson <mcr@sandelman.ca>,
 Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>,
 Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
 <20250923134742.1399800-18-maxtram95@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250923134742.1399800-18-maxtram95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 77b0c3d52041..374798abed7c 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -1225,6 +1225,8 @@ static void geneve_setup(struct net_device *dev)
>  	dev->max_mtu = IP_MAX_MTU - GENEVE_BASE_HLEN - dev->hard_header_len;
>  
>  	netif_keep_dst(dev);
> +	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
> +
>  	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
>  	dev->lltx = true;

I think it would be nice to extend the big_tcp.sh selftests (or gro.sh
whatever is easier) to cover this code path for both geneve and vxlan.

Thanks,

Paolo


