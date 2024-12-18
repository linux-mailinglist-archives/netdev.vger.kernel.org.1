Return-Path: <netdev+bounces-152876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F2F9F6267
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF807A5D9A
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF3C199254;
	Wed, 18 Dec 2024 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7Gf22wB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA5C199934
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516593; cv=none; b=uEjKUjPGFT15iNNWYdm2V55zQ3hWG+kQVVDbu70RL2+xoHJ7Wq6WfLZm4WXsy8HSG3k2JAO2k21Ue+onS+ubx0I2SgEvqj6tIkwSMiymNVWfzf+jHmGtn5sC6f2roSEKefDawGLB7r048LPoBM5Edb+sEKAFIpXLNkgjPtnh5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516593; c=relaxed/simple;
	bh=P+J2pMiqKacWF5Aa303CVJXew1v9t11ZL+P/4xSizaA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=flhy3pmVTpIKfd6rW5aW3PuEVQI1NWCYP9JpesztSk5/NHNYdyWp++5jbyiRbeSAMw2wsfDv/9729YX6C6OLvc7f7uH1+A3y/fQpZD2wpWFQ2Sx9HMEV3/6zX8zHZh6Qia8DhDc1BQla0Jy9qq6H77IE3Ysz9uy9K1ak3I+aQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7Gf22wB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so4287437f8f.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734516590; x=1735121390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAb7buQtZvzLy4h6wv6KVdad2xL0uuqFklY9DHfyPE0=;
        b=b7Gf22wBolIp3fRRah4wf1pQGR+usKvYM8RiODwcKDg1D2IVu1c7VPW7UMOk4nw4ln
         NV6DYqVa/WLkTgzwDbTI/2JJ/HTGFBa7y5Pb0O/KA4IITgTYa4J6kx6p/vKUXXaLVEdY
         VoTrYZrrceIAZAHQ9LYGxZevNz1MSs7N0BnjOGPQQLz1f2u9kObZkNVHjnRntzW9gIvZ
         kzyjJu1rxu55EYnmQvGd0z1C/tBaj39PcBb2BKQJZub3+Df4HhbgcAmfNCKie5J8NTRp
         Da5vSY/q07bAxwT+zHhkPMJIbNJ72i0VQbz09jf4milnRmZMavtj+d9RyFfsVIBaSbbP
         K5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516590; x=1735121390;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAb7buQtZvzLy4h6wv6KVdad2xL0uuqFklY9DHfyPE0=;
        b=FJa9zlteQP+3eRdFHuxY2iFLMFhYFMW/x/tyMXCXd6XYORstrYG+B+DB9velC2fe5/
         Tgt30+shzeJjnIpkOKWd/daJZNhZCJUTAIbGBFYTeZU9mlCj8fNMUiE94AFl+wae7Vrg
         Z258Rx/UzxuUsJh0xdea9T6VD3JaOKuFNjTGsnmCK++FrlM/cR1sDK3Uw+cX8WQ2mw5S
         IDuhjMGRr2o4o/0HRyUoBkPX23CUeoKjghoe2CvxzHgJdAxQ1soMAUDpIZpU5MU2CdBY
         1leGI7MrVw+HI828Z4Z2x1sDkyKBklejlBKPrpKcQU+ugeRPgJGwvanK6jeOblEzTAyy
         Z2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHl/NcCP0EdrqGT9vtDI88f/Bd17eh9gqKf3zKBGzWDoZRDnCc6pKeOOfnMc5Fy7HIoS7fvsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFT0ivC8+SpWxVJYwJCMVnfq/SLM5uKnzHUvdNZcOcyO+uD7Ny
	Zk+NBSjYnDUvG3SJRAShycFBaJlNxTOfNaK0Ftsh3YEffLfPUBQp
X-Gm-Gg: ASbGncvwuG3q2hz+lq/jtxm+jwkcD62pLlVt1pn/ruvek458TqrK9uCTZ8I+2MuEoj3
	YTRAICBWJufrXTG7J+vbItdh3PRFBa0gqdIKRYu+RuczecvSB6ITFn8cGx8nhyv1baO/CaOKZcK
	RyhczXbqHHAkznglAjPkCFwoU8+crMFOa/ZTMkQmR2eoGnRKWaf4BnmkAQmeUDK/zD4+luHCN9z
	qkAV/NDfWbnFWIpSOztPFg9YPG/G4VpH7+/P8w69mX2TEUCCRo+fkrXrqYnyZfk04+qa6yGhUNW
	JxdFSXvMXYlo1E6puOKtlWaP7CBYjALWQ/zSwN1oWWOm
X-Google-Smtp-Source: AGHT+IGySVXonN+VpOWJVnd9AT2Ej9WOcun/u9yJhJSvD1PVi9sxRGd3knI1j/MGYFsr4tb79l1woA==
X-Received: by 2002:a5d:64eb:0:b0:386:7fe:af8e with SMTP id ffacd0b85a97d-388e4d2f515mr1952750f8f.12.1734516590380;
        Wed, 18 Dec 2024 02:09:50 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1646esm15076525e9.26.2024.12.18.02.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:09:50 -0800 (PST)
Subject: Re: [PATCH v2 net-next] sfc: Use netdev refcount tracking in struct
 efx_async_filter_insertion
To: YiFei Zhu <zhuyifei@google.com>, Martin Habets
 <habetsm.xilinx@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-net-drivers@amd.com, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>
References: <20241217224717.1711626-1-zhuyifei@google.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <3280aeeb-bddc-ee1f-b33b-eab95a91084d@gmail.com>
Date: Wed, 18 Dec 2024 10:09:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241217224717.1711626-1-zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 17/12/2024 22:47, YiFei Zhu wrote:
> I was debugging some netdev refcount issues in OpenOnload, and one
> of the places I was looking at was in the sfc driver. Only
> struct efx_async_filter_insertion was not using netdev refcount tracker,
> so add it here. GFP_ATOMIC because this code path is called by
> ndo_rx_flow_steer which holds RCU.
> 
> This patch should be a no-op if !CONFIG_NET_DEV_REFCNT_TRACKER
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
> v1 -> v2:
> - Documented the added field of @net_dev_tracker in the struct

Please do not post new versions of a patch within 24 hours, see
 https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

> @@ -989,7 +989,7 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
>  	}
>  
>  	/* Queue the request */
> -	dev_hold(req->net_dev = net_dev);
> +	netdev_hold(req->net_dev = net_dev, &req->net_dev_tracker, GFP_ATOMIC);

This line becomes sufficiently complex that the assignment to
 req->net_dev should be separated out into its own statement.
(And the same thing in the siena equivalent.)

Other than that the direction of this patch looks okay.  Have you
 tested it with the kconfig enabled?

