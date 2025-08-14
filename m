Return-Path: <netdev+bounces-213705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E55CB266D9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C60F9E7F0D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E228415E8B;
	Thu, 14 Aug 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir0KuCxj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04F1465B4
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177497; cv=none; b=HWNFEyYxUnLLXWcCtWt19wmLNnK1EUm3MBx6LnpJVXvA7ZO7XjflWBzCvZpH7YVnr9enRbda3EPbsA0xE1HVDlF4vlrKLRH7nSLGOv6m6LmWs14ybogPG6V0vcq5ABF7hdAlgmE3fcQPGf6Qf2oYpokNn4pp3NyW2NkPpbzkKVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177497; c=relaxed/simple;
	bh=ZblVfjBCF1Uu/h6jkZbqDdOmO9nTJW/aYEFtS/qW/qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwpGpuS40LiGW6TEPQ+eoQXmqGe6yT7hzqrs+tDBgP5MTZ+rU4AUyEerdHQGVV3af1walRIASr7MA475XkylV03IacH/mBhFsLOKTFwguhu1a4NmVWPl9FP7/oz/iKXM03RDSMqXCkio0VQUcpF/nYR9/9fOgo7Xx3EmUv5zDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ir0KuCxj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755177494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsLmdu5xGiFRo5LVcjyyt8uyFSXZsr2abTU1wQICQ5Q=;
	b=ir0KuCxjmZcqIz76UpIUKx1SwfhuhBC4BszLq4xwy38P52Sv511M7mi4smwrVMAmJgTh/A
	+TNGlrevP+zXZVdYCnHtKCl7xrHp3kXNVHODm5P+RDjUlr2Afb/I2Tw0RwZX3R0U7+22u/
	8a6VzpmFMQgbthTu6v5Pq4oDvvVKP+4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-IdMGqRmOPAqfDaC9DVU9PA-1; Thu, 14 Aug 2025 09:18:13 -0400
X-MC-Unique: IdMGqRmOPAqfDaC9DVU9PA-1
X-Mimecast-MFC-AGG-ID: IdMGqRmOPAqfDaC9DVU9PA_1755177492
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b00352eso3946485e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 06:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177492; x=1755782292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsLmdu5xGiFRo5LVcjyyt8uyFSXZsr2abTU1wQICQ5Q=;
        b=arNMrkP7+ZxN9dc4XUiXDHefuC8PrS3bkc2BaXec0BibPA3pk/a5GHrQk+8cMjLgM5
         xc6nIp1RU7OypqZzqj5yP97MhYzGaFHpkZDlRprSM9Z2FFgLP2unZZQeXSrwKcrdxJtw
         NgK1ZqWDyFDZKA4aNe6ip+Qo5MYhWg46cLp1l5iag+KOVzLfM0r4Y4vslC0Rbk+1HXyB
         14ZCsqjPNFmzzNiZ+UMvfDoOTalEnIKN+JVUvJfVXMATqHswPf3OEkJhPgcH0G+HRgFj
         GKGeNAwHyrFJ4jafmqZvpwXRv+czvL+N6nNKjdYMF7iefT9tcqNRuIBWY0+SYdTHTLDE
         okmw==
X-Forwarded-Encrypted: i=1; AJvYcCVojA8uXKV2uL/nMHJ/ZLY09nBAtOk10iGYxgD187kSph3c6jUun5l2Agz5dyEM7d0iJLOwn+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxFbsZF5l227Ov3vPhWdhBl2Rq3WH1yD3dudh3t4kNBX/OldHc
	swAWKtlEq44Fx/CVqvTuZLX/ZzrQo4FKfSOVV5I91GQsVRF5E1uEHj66r0XhVLkFf7DT4QEPC60
	nfR4+FVdipM87i6kwtY8Xw+LX0jL0IBxSD2pdn8yX1RyiN6CamunlAA2m5w==
X-Gm-Gg: ASbGncuQe9rSdnKQ67AxnkKKQj3wx9ioYx/N3+bqQCFdFiYlANMguKxlmAhMOdvCxrJ
	YGRBODGYIpna8FUtbAYHgNbt8k7GVXe4WUMAnhkyni1IZfLcfOD98xKHEMVkjFKhz1eswYtpCt7
	xDZxQ1FlL1/T44VQMM30g0gtToP0uKf1TRWTcXgq6NEI4j8yLCDY8mXdezkqkRuWZvlRtoZTmQ5
	WCEhWZvDT1PMWFYY/HW+6uGMelYn0L9USCkLnxj6h0ZtBbCQKEJ8mUj1ar/WZzQ6hTKxXcHQsCP
	ugm9xNFXmBWpKlFkJ3cUudiHTIUoC2TvOz8UvxYutaSVAviyT2VmSgPbC01uuTu/c9xAggpPeT7
	DA5I+LGcAXPk=
X-Received: by 2002:a05:600c:19c8:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45a1b60f531mr25843905e9.9.1755177491637;
        Thu, 14 Aug 2025 06:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKYngYDYMmXm6bNr14tIbNwS97DqwS11FutfVF00Hp0knQqTzKEuuxZK3w1r2sGyTf+Hb0Ag==
X-Received: by 2002:a05:600c:19c8:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45a1b60f531mr25843395e9.9.1755177491220;
        Thu, 14 Aug 2025 06:18:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm49417683f8f.30.2025.08.14.06.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 06:18:10 -0700 (PDT)
Message-ID: <63d55246-fd88-40e6-bb78-8447e0863684@redhat.com>
Date: Thu, 14 Aug 2025 15:18:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/19] tcp: add datapath logic for PSP with
 inline key exchange
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
 <20250812003009.2455540-5-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250812003009.2455540-5-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 2:29 AM, Daniel Zahka wrote:
> @@ -2070,7 +2076,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
>  	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
>  	    !tcp_skb_can_collapse_rx(tail, skb) ||
>  	    thtail->doff != th->doff ||
> -	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
> +	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
> +	    /* prior to PSP Rx policy check, retain exact PSP metadata */
> +	    psp_skb_coalesce_diff(tail, skb))
>  		goto no_coalesce;

The TCP stack will try to coalesce skbs in other places, too (i.e.
tcp_try_coalesce(), tcp_collapse()...) Why a similar check is not needed
there?

/P


