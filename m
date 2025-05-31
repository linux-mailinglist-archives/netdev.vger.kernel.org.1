Return-Path: <netdev+bounces-194469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19AAC998E
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 08:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3751BA2FD1
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 06:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2551DA62E;
	Sat, 31 May 2025 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="wTyqerRG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9402111
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748672343; cv=none; b=CEMb7LXisPyilNCMTZpUnRQKSu74mh4VorhlOeqIM9HU3i0huATu9wTsowQZRz9uV3q1eaOgfnho2wj+eFXQr4WHMwqaOwrcbRI0o2g9xdQ/kY10uVjsCrt0d8RtlOzmUN3i9xK/3lFBPx4qYXVQ+kh7uGK0q/yH3A7Ksy+sIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748672343; c=relaxed/simple;
	bh=JhcByfYsKlhcRKw/0xyNeT2AqZgQotuXvX2E8bKo7hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OLCr8vsN0Zu2anXE+uUPg8yXPsNiQ8VarDA/XMdWB462juyKnxh8qxx/qKScGqd7+uQ8DWKyKHOYkdbwlNjAaBclFscuer9Ynl9E5k36ywN8GJwrqN5C0JrASqJy3dpOJcbejM8INc04BSh5OkNjbfaIq9BcmSAwGDZsSzO3sYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=wTyqerRG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c5eb7d1cso2969869b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 23:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748672341; x=1749277141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7J36olf6bUMPrQFBU0ciNvlJ/IDUx9/IznLR4C4s6tc=;
        b=wTyqerRGjfl0WuVbh0qnRe3zhk4wUM8cEF2Ahttv1An+kIJ1P2Oen+eEfsZiYHodX4
         MoAQpQfw1emJyHEEIdO6F/5eTEDj1ml24HvX0VDhXWEGCF6uIJIA95GOkwMNLBJ43B2h
         ZdMqt5s2X9dYuNXFFy1qep3KoHqeQ9W/baruic26XFjRl696x+hZ59ncJTuhcyz3LZZy
         DZuZNlVJqW7eUJ1VAUsuXcIH10xHyHiiONFVm49d87ktE8YhPOMPlMARGqAIlEBVivkH
         7aMAG4Rua65AHbZyrdxw9Hp1PNsCQpJ9acMjTjIHS1aoDcan7oJ6ur+z3EjcprAImpWc
         2JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748672341; x=1749277141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7J36olf6bUMPrQFBU0ciNvlJ/IDUx9/IznLR4C4s6tc=;
        b=HaeTeK9H2Ge2GJQDsDz60lksbPI1nfzZ+goXwnP5/vrNXxoq4O4nrNYv/5t5nbe9/a
         1krnXVEiX45VjZ73J/aGI6EGI1lSxM7wNsG38QwIqIvCX+Kx59pz1iJKWRZifXr1KCWv
         GzPhNizfhc9w7F/ubpwDrduWcTY0fJ3qaK2BQc+3Jfop5a4SGFnF8IkbWlh1biiKXmLF
         hMWtnutyFHdLDYZJ26wuT4m309+KMxAU01aTxYXMWqaJeX3TgWngaWxOi2k091xBDH/U
         Pf9P0sWdqQNeAgMEGb7drV3KYcFhfxH8bncFaLQeXBZQQajTJBQ9cW55K0vnqbtnwirN
         eR/A==
X-Forwarded-Encrypted: i=1; AJvYcCWqyhiI5wdmvBXAuCJh7y64eG4xwkdSQGodMuangI8VN2eXingZVSdFRaImmW4mrStatAOmtZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICxFuTXv+xK3o0/fq6uXbky3XAev4CV0mk7N06uDT0gNbExgU
	b7eESYspBWDZ35XSRtp8pmJSetW478OrfSJoOrwpWJXqhhsyhVLr+ec9Lj0JHXAuwPs=
X-Gm-Gg: ASbGncvSJC765FbR0Dkcha+vXxg1+cmsQJ6Zsq+itCTvw04b4Eb/x9lkCRL7UNbRKl4
	j8bMMVfD4W/x/3IEmhZvsHhynsrW/kvF3jy7O8pX9srWO7Be8cVY2yRZPlZeaVVrmzn6tNYS1zO
	H26xeJZ9G/1iugZ5ES0o0hCgimuwzYXbIkXXn1QMuYkRPJzicO5T1zETk5zgc7RmwwlF+bX2W02
	WqB59xVE0MnRWlH9P0C3xTGgWszy9XiIiBNxBD9hqljzNwtJIIRAIlx9Y4q4Cu+TeuhhSbjbNHP
	k3md17kJ4DEpRA3YFkn1pgishaXIm5wiIB/Nx3sx4WqiXB83CmQc4C2cIWXU/Q==
X-Google-Smtp-Source: AGHT+IHcohDm93GoJdJT5Bpih9wVyRo02JgcaAAvaBTF5EvmUvN8C4vML32+2GMlhQAF3xkcNqlwQQ==
X-Received: by 2002:a05:6a20:4321:b0:219:935a:6e1e with SMTP id adf61e73a8af0-21ad97994f0mr8711301637.26.1748672341044;
        Fri, 30 May 2025 23:19:01 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb67dbsm2034605a12.70.2025.05.30.23.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 23:19:00 -0700 (PDT)
Message-ID: <a8d56434-da4b-466a-8225-3c6b64596b23@daynix.com>
Date: Sat, 31 May 2025 15:18:58 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/8] virtio_net: add supports for extended offloads
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1748614223.git.pabeni@redhat.com>
 <bfac8c3cc2a36ca419ca583e3a43da0ed5185b8a.1748614223.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <bfac8c3cc2a36ca419ca583e3a43da0ed5185b8a.1748614223.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/05/30 23:49, Paolo Abeni wrote:
> The virtio_net driver needs it to implement GSO over UDP tunnel
> offload.
> 
> The only missing piece is mapping them to/from the extended
> features.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>   - drop unused macro
>   - restrict the offload remap range as per latest spec update
> ---
>   drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..ec638b4aa1c1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -35,6 +35,24 @@ module_param(csum, bool, 0444);
>   module_param(gso, bool, 0444);
>   module_param(napi_tx, bool, 0644);
>   
> +#define VIRTIO_OFFLOAD_MAP_MIN	46
> +#define VIRTIO_OFFLOAD_MAP_MAX	47
> +#define VIRTIO_FEATURES_MAP_MIN	65
> +#define VIRTIO_O2F_DELTA	(VIRTIO_FEATURES_MAP_MIN - VIRTIO_OFFLOAD_MAP_MIN)
> +
> +static bool virtio_is_mapped_offload(unsigned int obit)
> +{
> +	return obit >= VIRTIO_OFFLOAD_MAP_MIN &&
> +	       obit <= VIRTIO_OFFLOAD_MAP_MAX;
> +}
> +
> +#define VIRTIO_OFFLOAD_TO_FEATURE(obit)	\
> +	({								\
> +		unsigned int __o = obit;				\
> +		virtio_is_mapped_offload(__o) ? __o + VIRTIO_O2F_DELTA :\
> +						__o;			\
> +	})

I wonder why this is a macro while virtio_is_mapped_offload() is a function.

> +
 >   /* FIXME: MTU in config. */>   #define GOOD_PACKET_LEN (ETH_HLEN + 
VLAN_HLEN + ETH_DATA_LEN)
>   #define GOOD_COPY_LEN	128
> @@ -7037,9 +7055,13 @@ static int virtnet_probe(struct virtio_device *vdev)
>   		netif_carrier_on(dev);
>   	}
>   
> -	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> -		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> +	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++) {
> +		unsigned int fbit;
> +
> +		fbit = VIRTIO_OFFLOAD_TO_FEATURE(guest_offloads[i]);
> +		if (virtio_has_feature(vi->vdev, fbit))
>   			set_bit(guest_offloads[i], &vi->guest_offloads);
> +	}
>   	vi->guest_offloads_capable = vi->guest_offloads;
>   
>   	rtnl_unlock();


