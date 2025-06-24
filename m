Return-Path: <netdev+bounces-200574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F807AE620F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11432406BFB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3E27AC31;
	Tue, 24 Jun 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrI5DA8H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A78C25743D
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760280; cv=none; b=ccFqFx7yT2IJuwlcOnJS813s37PEXzxq/fJdxtKmy08LUMoWujICweoKH9U69bqcGuRgykL39bEcYYhPiSErLT8XWdeEHF1SLBA+r2bIKxVpRjXDlQ2DLS3tEZgH14go3qJPhXLTIMLQatSL22oQ3wb/lMPn5hpYb871L+VhPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760280; c=relaxed/simple;
	bh=yxsot7li7aWDbMpJ2M7l364+PdHRsIkunx/znJIFHqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUIwspXVmuhRx49+kw2QpNEP3nDz0eGVITNjkyFPjuck2UoOPBskaOBQBbGZof0LkAdXvwTXI5MNOsN0l10YQlSNgwS/kFlK7AOy2+x84jHxu4LYvf65EuKcTLH9/x0k0AhgMHhEpaRQUGRGFYrTixtaZS4l49gFXqWKmkucHqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OrI5DA8H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750760278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ln5HyZtk161hcYqwhzfMAZcN7gULO9uaQ38rDIrK1c=;
	b=OrI5DA8HTTgU616DVfh8LjHprq3PBVscNX2h0uz39bJ7fpMPMnsAwSFooGpn81NEXqmJZs
	MOtPkpGwVmO+370np92LOyG5VRc4MJhFq1XDy8IqYjx6lHjZTUNgo7IBr+klvtQ6vAh29W
	sKQJrAePY70O3Uldt7FQjvLJuTm+4gQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-3RGt-XiLPQuLANd5DaIOLg-1; Tue, 24 Jun 2025 06:17:57 -0400
X-MC-Unique: 3RGt-XiLPQuLANd5DaIOLg-1
X-Mimecast-MFC-AGG-ID: 3RGt-XiLPQuLANd5DaIOLg_1750760276
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a579058758so2219093f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750760276; x=1751365076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ln5HyZtk161hcYqwhzfMAZcN7gULO9uaQ38rDIrK1c=;
        b=kkrc4iatEMp6rJPV9OAN0IFpKIwtJQd9mhKFFmXaOwgQoU4O/gMx2CSrtdk9r3GxGD
         dP5PEHXxDRgg1HatEXis3SbBbXQBoPnExxYlR6XD+hc8LP1xcakXsjBXgDtAFYlJpAGo
         79ED1EaSarA4+9f7dwWCWzcpfCfkJXRIYlb8x6bN+skX3yftGO+8h82b3KtiJLwPFUq9
         Du1pBO06rYQo7PzfBiD8iRlTxHNf8/dHfru6bWzaxiY3vhwNeIMrWxRJ0E95dgPrVJa8
         i53m/I/fs5EM05cynWQk/pnviziIVU0sJNimTATGT3okwyBHugVQd0Ib6IrHFwd2UA7J
         4RRA==
X-Forwarded-Encrypted: i=1; AJvYcCW377cpl7CIGyLrqGL7kE/rhO2aIwM+IYZgxyKoWKyWWQq5YnnYFiO+uljTmZj8zPS0U11ziRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0YhKGzGOlEtXwZoglhvRKPeb5u7Z/hjmT2v42tLyskg96v0V
	fFYr6RGH//6Y3kg+iB//Jnezx/OOgxcakFWARF1QdTDjX23tDXmIXOFasA8e4IFfwkZQn93iLFW
	rlwRoLGNYikWPuIZn634ph37+W9e8vWhbXFYoY9M8f3vRrWVw2/LyeT3Afg==
X-Gm-Gg: ASbGncvSExKabKsl331MgNTfWAoUkc3qydrwF+l4Rh/aajsIuLvsIUXdVPnviS+Gbkr
	R/1PuTnZ9JCbmX1ETtEdnkzVGGURpUFyHtfMSbCN5PvMqyLGmgSkOHQGqYsqhcCtBxujz1B7xHg
	WUmUa2QGFEpwxABpdgEFzT+KVZC8MZXcNAjoUQ1oRr7kBqv5AATWj0JVlSvkwAViVLfcGPXgmHl
	VIm7OQdq9uxNX6MP9DRAvyqp3T0mscWoDgOGXuugRn6FNr8JRalJaFpik4mA4spFSSUANlKre/r
	ji2iPxXVdhpjsuwkBdswrC/ruByhVw==
X-Received: by 2002:a05:6000:2008:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a6d129da9fmr11398659f8f.19.1750760275745;
        Tue, 24 Jun 2025 03:17:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC4ngUxIcnD6ERbm/m/k7RkxkipdZ9Ie1YqBmuu6Vuw2RA4r/70TZrgIw6mV8PBPv7d8OamQ==
X-Received: by 2002:a05:6000:2008:b0:3a4:f902:3872 with SMTP id ffacd0b85a97d-3a6d129da9fmr11398635f8f.19.1750760275245;
        Tue, 24 Jun 2025 03:17:55 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97adf3sm169365045e9.8.2025.06.24.03.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:17:54 -0700 (PDT)
Message-ID: <e6654755-3aa1-4f4b-a6ab-c7568d8a5d4e@redhat.com>
Date: Tue, 24 Jun 2025 12:17:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-3-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621144952.32469-3-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 4:49 PM, Bui Quang Minh wrote:
> This commit does not do any functional changes. It moves xdp->data
> adjustment for buffer other than first buffer to buf_to_xdp() helper so
> that the xdp_buff adjustment does not scatter over different functions.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1eb237cd5d0b..4e942ea1bfa3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1159,7 +1159,19 @@ static struct xdp_buff *buf_to_xdp(struct virtnet_info *vi,
>  		return NULL;
>  	}
>  
> -	xsk_buff_set_size(xdp, len);
> +	if (first_buf) {
> +		xsk_buff_set_size(xdp, len);
> +	} else {
> +		/* This is the same as xsk_buff_set_size but with the adjusted
> +		 * xdp->data.
> +		 */
> +		xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
> +		xdp->data -= vi->hdr_len;
> +		xdp->data_meta = xdp->data;
> +		xdp->data_end = xdp->data + len;
> +		xdp->flags = 0;
> +	}
> +
>  	xsk_buff_dma_sync_for_cpu(xdp);
>  
>  	return xdp;
> @@ -1284,7 +1296,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
>  			goto err;
>  		}
>  
> -		memcpy(buf, xdp->data - vi->hdr_len, len);
> +		memcpy(buf, xdp->data, len);
>  
>  		xsk_buff_free(xdp);
>  

I'm unsure if this change is in the right direction because it almost
open-code the existing xsk_buff_set_size() helper - any changes there
should be reflected here, too.

Also AFAICS xdp->data will now carry a different value, and I guess such
change is user-visible from the attached xdp program. The commit message
should at least mentions such fact.

Thanks,

Paolo


