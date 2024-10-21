Return-Path: <netdev+bounces-137439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255989A6587
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3D01F22513
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA3F1E47CD;
	Mon, 21 Oct 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGw7hhok"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0D1E3764
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507974; cv=none; b=LZ750pDco6GuGF3S2RqDg7ohR6Vyfqs8vAq4pwJAy1h39n04JPuRlKakpoEFuHZg7zQqZDMoxm2SHS1+XgUnbIZNumqBeMStN5UFrCQOAg9IRIWpvEnTlhDYLHJ31Ot3297tZRccRV5tdOPSQfubINf4aJbmWC1TkPCW0EBwwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507974; c=relaxed/simple;
	bh=XV1S6Zw+g3mH55uWg3ccT7dNJYp0UXWhsGtCGN4+4GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwAF5tXoD0YOry8Ux7QDTY1L3k4FyB5naEkqkghDpQSPf/q5erAcHw/zffVMs0+HOCDsozfJf4d9l0KkfiWK4yVAKhJIf3bdOxns6D0ZDNzMkQToFPUhzpyGgdZlabYFABCxF1DAj/BmNC1wzeR6fQEA+a3X9zM2cXSriYWNuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGw7hhok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Io9Wjovsf8+IWCVdGDtutv8zva9MNZWk0eG1/vRQng0=;
	b=MGw7hhokpVWCEy/rSNOJtu2xQcSXRDNbpMbLi9S797hXiSeXWyxJRrBzOFpb1QUtkAWGvJ
	hVJUWF7G7ZEEDxUHFNXVYzwPkghIX11oVbI0uSmhCoU0b9f8hvagsA3J4i2923/Ffe4BXR
	7q8+9rEcYe8oclvZt2zCHQCKZgDwyt0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-YsNC5RhaP22oy9ALJ0mrAA-1; Mon, 21 Oct 2024 06:52:51 -0400
X-MC-Unique: YsNC5RhaP22oy9ALJ0mrAA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so2290528f8f.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 03:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507970; x=1730112770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io9Wjovsf8+IWCVdGDtutv8zva9MNZWk0eG1/vRQng0=;
        b=N8Jo+XF40qb+NiV3pEdMzK9l9Hd6S5xzetnWeYDNqq4D4hslS8/A3vKZGfQJiMqVlL
         O0FiRK1kVh1LfohEzRafGFn8YsluJKRRrSqnHDaWld/rFbcwZQRPrNb0F6P9M3TDDB2V
         2cRhgbSjH004nNVuCCd82aM8kmlGKa6Z7lLTk7Ge8pVDAzlF5OT9zIn+eNAddZWxc1Mj
         SCxt1v1SqLZLBm4Uw+6Hgll+DzX+hnhY9lzdYx00r/uNte8d1mIeR1LInUNWhmeStOHv
         hzT8jONfFjKuCe0yKxOL8Xhj7WRN8liCTQkEWYGWReB9sfTbdQsCPn7pJ2c/2ZwdoLOx
         R4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWodOFmUrewq82awniMaYhRszWpWxtKxvsl0QBJ87Vv6FAbvUv9nfDat522aiznOAvVpEiVN4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGceI7oqmNrUiS+7vt6vbh3L+UHGx+8OeDXESLYAJf+ufWoirK
	9m7Y0fUaXCxMk6nZbrkPkEh2wE5BQZ+77lXxQAGvz9MCx3DC0qhRymMre0DovxnDyZ+JfAAq7dC
	ReTN2P3A+n84QkxsYKow3BjY9SYl79NZaoZPPqLOfljDs1d/Q16CyKg==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr7003020f8f.29.1729507969836;
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdA0NxQjeMM/mp9d3cx0ocUBlXzwmAevgDKmJdOzzdQKq8l1oOAE/WjVMpBUAWAdDgbNEdlQ==
X-Received: by 2002:a05:6000:183:b0:376:dbb5:10c2 with SMTP id ffacd0b85a97d-37ecf08650fmr7003008f8f.29.1729507969505;
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b07sm4065797f8f.1.2024.10.21.03.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:52:49 -0700 (PDT)
Message-ID: <20d9ed5f-abde-43ee-854f-48a9f69e9c04@redhat.com>
Date: Mon, 21 Oct 2024 12:52:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/10] net: ip: make ip_route_input_slow()
 return drop reasons
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-6-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-6-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> @@ -2316,19 +2327,25 @@ static int ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
>  		err = -EHOSTUNREACH;
>  		goto no_route;
>  	}
> -	if (res->type != RTN_UNICAST)
> +	if (res->type != RTN_UNICAST) {
> +		reason = SKB_DROP_REASON_IP_INVALID_DEST;
>  		goto martian_destination;
> +	}
>  
>  make_route:
>  	err = ip_mkroute_input(skb, res, in_dev, daddr, saddr, dscp, flkeys);
> -out:	return err;
> +	if (!err)
> +		reason = SKB_NOT_DROPPED_YET;
> +
> +out:	return reason;

Since you are touching this line, please rewrite the code with a more
natural indentation:

out:
	return reason;

Thanks,

Paolo


