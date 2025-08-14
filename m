Return-Path: <netdev+bounces-213783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BFB2697F
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BE6680728
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C495189919;
	Thu, 14 Aug 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TF9jpGW3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8015B0EC
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181318; cv=none; b=a1aSOT/BMhc4vLhp51VwlGIlbBWtD+G8FQlKjn2jFFV09W/O5GKlTTsx4pTXV8wGLZzL5lhJyStDf8iTPOp7gJE59UtFsVz7gYqpEiQmulAFBq8zCrBZg+86t4UKcKWXevBknfUHJEwXzMaL0hSRq2BvsggiI90bOF5cCaQ53KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181318; c=relaxed/simple;
	bh=Nv+/dxjXEfwDWLr/1grlcSdyiIXILWRaB6a5/uDVyxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUXteWKE1GQ9prfv82tfYjjllZkn97qck8ChvfTm+t5ijCdDqcvAD/hy6wCQzx7jSNHEaVYMKbHOlK6h0oX6lMvFWKrXMMe5JZ1hd9Ddej9TnyuHRA0UvSBjM/qfF2deleNU8u/2nv2p1Twyc+3ksMwZz9nFgTyOPf/UuI1wZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TF9jpGW3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755181316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4D8gG4VxqTxelFwQ1e54IqH8CQvuDHtJLbJw8SAs8w=;
	b=TF9jpGW3XRuy1A+OF/SfVDh7eoZjhn4ojiFPNdAn20JsO9yXWd9z5/PhbY5kaj43g39GxY
	gtNca3rriXIl+PrxnjUoQkzEFh+j2V/X6U95EN8ldITrzjsi+1Y7dqbkDgXX/REZFbV8VX
	v0SwMcDBzEYOFX201N1yctQcstaDE0Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-wgGswuBIME2P67-Lu5ykTQ-1; Thu, 14 Aug 2025 10:21:53 -0400
X-MC-Unique: wgGswuBIME2P67-Lu5ykTQ-1
X-Mimecast-MFC-AGG-ID: wgGswuBIME2P67-Lu5ykTQ_1755181312
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9d41e5125so604510f8f.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 07:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755181312; x=1755786112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4D8gG4VxqTxelFwQ1e54IqH8CQvuDHtJLbJw8SAs8w=;
        b=inDoE/gpJ+v1yJRYfjn6i8Gp40FvK0DPLq/NCNunkUSqmwLyTA6zXMy1h8J61cC79F
         tR3GcN4ftAkag6ma1Q8cNG/atRCx7NgI6vQQhcYAHuRcOosgn/ZojhWr6DcLAu/g7Gun
         NvYn+KMwD4oa4gXeriUNaImOIdkP6ZT2z0h20zgwW/RnooNUQyDt1hjWF7lN38oCP3Xz
         AVT41KzaZXuCtcnxXCLN35c1rUmuKT6Yh28qKU7+v9G58RtQfz9IcIZQ66kYWOqGGCFw
         h9A1zmdyGkcK1Z6K2dLxJpHmPBeTHZ5yDezaBFKqaFXMG+nSlJ+RQ8RTswZJp6hRMfQt
         FvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWbpdOlIal63orE5JivcxlFN+b+PSNxcYok2rV6Lf6e/YdCvwLf/PLlBc5Ls6SOxQ78QglZC3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcw9Z3wCu7zkqzPu+LIOkuPNB8BIKHy6NTsA79afpWlz2Zx3t
	6akh0huWwxphNu++CBcvpzlr93bz4BgFZqAghv2pLUbocQnliuVVHyo/1iXYl4s77KjiDDoyt6J
	xvosNs31MHIsC5V9v5x0riXWsxIVXvGEO6heQspr1A/g0+I5olOy8S71DoQ==
X-Gm-Gg: ASbGncuoQGu8IzpdsceKU3AzQQ40DSmVc5upOKlI6hrWfuxNNoczXQSh6w/2JbbtEo1
	/KAYwfAEWjn/5Pzt0rMC9HZGKhNMSW1X5vCw9wgyRPR5wNe0tgI3VW3yp5CVfGylSY11ak1XHwR
	GGfqJ7hn2wKjZE6bMd4ldsLn0kuBklauRkmYzBMIbxfeTBPfZT7bqo+ybs5ZkngUDqy95yqby2t
	PThzfNU40+oc34Ic6aSb1MWxbSGzv4XhI6QLLsddcpWYHITK+J31ylsq3bt066KILnYPYDVprDq
	TTmorWItE15WO+qcUWbpjVAsS+eRd3xHKh2a8YUM6gv34zp9taSKgRjMicUtv1UaP2jkaVDRjpv
	NGlPCSXkBQ5s=
X-Received: by 2002:a5d:588b:0:b0:3b7:7489:3ddb with SMTP id ffacd0b85a97d-3b9edf359c5mr3064197f8f.34.1755181311984;
        Thu, 14 Aug 2025 07:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrE2caGeKgmVr1D7u3U1MMi8pB2cC9ALWnDtwMDpzUI/cfik+ModE5psTeXFwdTMoakv8Vqw==
X-Received: by 2002:a5d:588b:0:b0:3b7:7489:3ddb with SMTP id ffacd0b85a97d-3b9edf359c5mr3064150f8f.34.1755181311580;
        Thu, 14 Aug 2025 07:21:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm53745431f8f.49.2025.08.14.07.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:21:51 -0700 (PDT)
Message-ID: <67a52aff-6f78-48ce-b407-d293fdf86210@redhat.com>
Date: Thu, 14 Aug 2025 16:21:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 02/19] psp: base PSP device support
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
 <20250812003009.2455540-3-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250812003009.2455540-3-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 2:29 AM, Daniel Zahka wrote:
> +/**
> + * psp_dev_unregister() - unregister PSP device
> + * @psd:	PSP device structure
> + */
> +void psp_dev_unregister(struct psp_dev *psd)
> +{
> +	mutex_lock(&psp_devs_lock);
> +	mutex_lock(&psd->lock);
> +
> +	psp_nl_notify_dev(psd, PSP_CMD_DEV_DEL_NTF);
> +	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);

It's not 110% obvious to me that the above is equivalent to xa_clear(),
given the XA_FLAGS_ALLOC1 init flag. If you have to re-submit, please
consider using xa_clear() instead.

/P


