Return-Path: <netdev+bounces-199551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22F3AE0AD3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2302D188D286
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E8521CC6C;
	Thu, 19 Jun 2025 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="A+Js7YX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C811712
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347987; cv=none; b=GY6Zblx5b6aPSDTwynvbFKuT7D4UIsePAn3gezSZ5SuFuvQNE6e4BtABSmcjSU9Z2G/BsbGOGaunXLJvGdpvRY1AMtS351nhwpHaWCbvI47nP6r8jOySvJ52aCETOYWEeCSB/AdQEAP1WYqmDNHX0qNWljppukPDM3gK9WZallE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347987; c=relaxed/simple;
	bh=fDe+NO9O5896xwCQNC6PiyG5IQ4LuWMhbfIyxn0QSnY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bRxpqET5nav1S3tNjCCwTB2JHEcOLEPe2qG4E5ySgFH6p07mE9ZJ102eddCzlqKpshB1LwW9I/7iwClEH1lNhIsY8m8ELcHef6ZZl/Q0PmECnmKjBnPhOuJ0c9WXR9wltgd5jMpNXyJJWgvRtbUZ3guyfWzvIznB8MXFFLrGA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=A+Js7YX6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c3d06de3so1027076b3a.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750347985; x=1750952785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHzmZmz7YL16tZnYVWGdwhEjWRKvuCTRcUPV73eYEpg=;
        b=A+Js7YX6gpfxIeWGmpLkLCB7dIrTo97Z1H5XFexJF1NrgS9qI8xNt76EsLvSp/ufsx
         Nvu4TkLcRURsDcTuP5GlCU1GRm7VtfwGUlXGjOTSkBKDN5XMrtQk3ojrTb4cEHlk/Tlf
         icr1XaKxN2ZrYKEK/hSv3VskSxpOKVKn7/xi035gHvTaVzsYLth9941BihJuQrY8GfZa
         OGW9IKQo1triutA0YIk+9m7Iq6Rbhun5bLU/SQaOhal9csAp9Z1c1PDPoOG83fq7lKL9
         9J1VXHKHNYcakPk70fRvhJUHMOHszFzmxLxWUOaZX4OGpLORJ0pR1e+WWrK3QiAmXI3i
         Busw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750347985; x=1750952785;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHzmZmz7YL16tZnYVWGdwhEjWRKvuCTRcUPV73eYEpg=;
        b=qX9QHb8EKFkgpKzYhFUYgfAt80vWHiEV8yObaFS7vGhmqSUx9VcdmSZkmj9D6XH5Qw
         aoUhQHdM7NBlWXD1xggmegty0HYQJAn5DHxRucNeELOxyxj6XVQkaUJkOVGcxtP6WEXU
         pWqQDIUKQkFXIsPP05JMtRJKxVhgUQLSt83YMVXkccYr2XfhE0FT706vgNC9Dy7yLjNQ
         uGDj6g4wTQBr50bqhY5Ng7qYBNJXTR3MNsPzbo62trzFYvzzYc2jFbDXwcAO9i2nINtL
         KpBfgCO6m5HJ9TS0nPgdf2aqVK+otWmpqPcAEjcGyAZXXx9ijQpJRPyNKNYMKM9bXQQO
         k4Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVWPwkefb7/7NvjvPjgWmpEZa4e1sl8u/KeO300iwfrk/+F/245Jd/2MB9+36G7CM5ik1DMbY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUxUw8ljbfgv5Q2JyBjImManVMKj7gfMIEGKyv40q8OkHu8Nt
	GIjHe6zr5hLhs1U3AdBOLLlRAbFEqJOJh8zX0NG5Wx+UcyBV2kpNOGPA9X21OjjUbiU10SFPxsF
	4Eh8W
X-Gm-Gg: ASbGncs/ZBrxT3aYjX2sXNJifTN9Jg8+TyNgfVdB/2kzFyZ5PsZ2hQDIxCBeN5IhM4g
	RiQZcymQMboK2nesS4nQZGIOWpjK/0eYnIDE9zii7T4jscty4JhrVPT4Z9otYtIm5DGdrxqfOfA
	c/XNHpffKANZNFgStJQtBrMWbnGoo37Q6I24ONR2msa3Fy/jmvP9OpYPX/Mn5E1KzFhgH6GZI+y
	JGzIj0sAud5Oqe+cN7ChLt60L4SNP4ozTXZPWDnTAbxXj4AEBJWXMN7tKiZfTF6CWAqk5P2XZpK
	5XDcVYOhiUvYOd7iacynd+I99ygutCHUUE4RQVOu8LQUAcqCGeNaXNvyDYfuu3HZrvhT0oZilFo
	=
X-Google-Smtp-Source: AGHT+IFX0+r/8Aax2grPGATI2BQwhoyvRRl8IJkpmqZC+C7MLFgEI/+tLFMqzggDagIaWjb11D4NBA==
X-Received: by 2002:a05:6a00:1989:b0:746:24c9:c92e with SMTP id d2e1a72fcca58-7489cfdaf27mr34613397b3a.8.1750347985100;
        Thu, 19 Jun 2025 08:46:25 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a64b1c9sm138026b3a.115.2025.06.19.08.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 08:46:24 -0700 (PDT)
Message-ID: <bc579418-646f-4ccc-bf9c-976b264c4da2@daynix.com>
Date: Fri, 20 Jun 2025 00:46:20 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <6505a764-a3d2-4c98-b2b3-acc2bb7b1aae@daynix.com>
 <4e0a0a37-9164-465a-b18b-7d97c88d444e@redhat.com>
Content-Language: en-US
In-Reply-To: <4e0a0a37-9164-465a-b18b-7d97c88d444e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/19 23:52, Paolo Abeni wrote:
> On 6/19/25 4:42 PM, Akihiko Odaki wrote:
>> On 2025/06/18 1:12, Paolo Abeni wrote:
>>> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>>    	if (tun->flags & IFF_VNET_HDR) {
>>>    		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>>    
>>> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
>>> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
>>> +			features = NETIF_F_GSO_UDP_TUNNEL |
>>> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;
>>
>> I think you should use tun->set_features instead of tun->vnet_hdr_sz to
>> tell if these features are enabled.
> 
> This is the guest -> host direction. tun->set_features refers to the
> opposite one. The problem is that tun is not aware of the features
> negotiated in the guest -> host direction.
> 
> The current status (for baremetal/plain offload) is allowing any known
> feature the other side send - if the virtio header is consistent.
> This code follows a similar schema.
> 
> Note that using 'tun->set_features' instead of 'vnet_hdr_sz' the tun
> driver will drop all the (legit) GSO over UDP packet sent by the guest
> when the VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO has been negotiated and
> VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO has not.

This explanation makes sense. In that case I suggest:
- creating a new function named tun_vnet_hdr_tnl_get() and
- passing vnet_hdr_sz to tun_vnet_hdr_tnl_to_skb()

tun_vnet.h contains the virtio-related logic for better code 
organization and reuse with tap.c. tap.c can reuse the conditionals on 
vnet_hdr_sz when tap.c gains the UDP tunneling support.

