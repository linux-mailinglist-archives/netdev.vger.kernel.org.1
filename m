Return-Path: <netdev+bounces-118799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB22952CEC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4401B1F21E46
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0337146A6D;
	Thu, 15 Aug 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwe+zvJC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441CB3BB50
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718684; cv=none; b=WvjxDBnxSyRMo5Dk9/AxwmMDNMZgF671/AT3bmepZGySw1i/5HbIgS2xzlAMINeQ1UDKTH6E+b1Hm1SXA/129LmMAKJgE9auzzDK6nzK/tqnu/IRAPZaZZ3fuA5675Wi07+MKQOKmoDy+ys/Iaa3sY/hui6Z9MzRY09nIdMous4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718684; c=relaxed/simple;
	bh=y5UiP2q8/9MJOQV1SrXwQK4fg18yzEWE8zm3Mmn67A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BAxNz/+e1aN49F9VBFWDmpgVmM1rjFWali3lGSrgs3OwQTHDx0A57XnAnRGd47VVHz6m2SghCS0lbCjEuAE7uZQU576l7ynRkjGf7j6ZIwXH3jikILDFTKfRQ2jwfxT/0L1hZ6YkqYqNU9xncoWK6rM8BxuezZ/eqSen98ggnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwe+zvJC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723718682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0lfhDcNSOUZAAV1h0MPWluOZzgmlLSz6RPmGbaRLpE=;
	b=fwe+zvJCiBdBX4MI5rPabq7ydH5fVMLx8Ip2t6kxstHIz3AuoP26iu3dsiLQpYKT+2cJPy
	RYz/tTbf3UgBB9+FAh4ZE6kuHnByV3fMiPFOhCYaRebxLUvq6NKteT5th2S4SyKIwR1bK/
	9hj4fq4Nie0MYkyKBFc2r4+bke+Kd/c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-zX-Z50SwPYGrhL6gVlVldA-1; Thu, 15 Aug 2024 06:44:41 -0400
X-MC-Unique: zX-Z50SwPYGrhL6gVlVldA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3718a70be44so95089f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723718679; x=1724323479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0lfhDcNSOUZAAV1h0MPWluOZzgmlLSz6RPmGbaRLpE=;
        b=woyqaphwy5fmWWSOKt2FlvSyghKfyh50hsxmEZs+pQM4WXkxab3yI3dyxkHGtTo0nE
         rMn0SYhux1oMZ9sc+mZ1sPM3hJvVBuoPHKrFDdAik3f5IMuc5RH9jZY7ewvdTb0cFxK3
         OwthsgE90a7MAKGhsg7UFOv4vtNJOjkeCGVDZTgpvSr3Lk0n4Y3e13yFrq2pAKu+bxe5
         +p7T7EirOkDJefUKrANiXprYu8OjU81TdN9BYxRO4ugbyZl5uzu/7yycxkqKnwbk4UGP
         jnbJa6zFpv0/7whlnkm9UA4px+X/UWhFyqhCbuN36czCahcWIyGUxqsmN5CGISChywvq
         ibTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnkvECCctSAWsHrqFxEPq/PSQlUo2E7CMBoPuvfV87gbPtPqq/P9DgjVmzK9hDgsE7YdyKoh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEvu6unZSkHZrQF/rUbqJPzTjN10giLviQYj96zxVi4WmEypuY
	6cw7s5OTNTkZfh4BquWwvfoaD8bnxhymsEkJ4Ya+V38/vHI7riUmbpX3EkaUgk6Qd77HyUhw9ZC
	4X7WcFhtBs42cgt4CaySn5Yf03h/MMvDw1az6sDjsgrZW6jRLGPSZhw==
X-Received: by 2002:a05:600c:5126:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-429e6a2f8femr8444075e9.3.1723718679617;
        Thu, 15 Aug 2024 03:44:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9899v2p/rMSnYmptDuAsIFHfYoVEHGtz5gijcac/bX7qsLvlsDYWzl9qlH11Q54Ph6ftl5w==
X-Received: by 2002:a05:600c:5126:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-429e6a2f8femr8443975e9.3.1723718679098;
        Thu, 15 Aug 2024 03:44:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898970afsm1171164f8f.78.2024.08.15.03.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 03:44:38 -0700 (PDT)
Message-ID: <1df13327-377c-41b7-9637-c873f3c1ddeb@redhat.com>
Date: Thu, 15 Aug 2024 12:44:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ip6_tunnel: Fix broken GRO
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240813115910.87101-1-tbogendoerfer@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240813115910.87101-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/24 13:59, Thomas Bogendoerfer wrote:
> GRO code checks for matching layer 2 headers to see, if packet belongs
> to the same flow and because ip6 tunnel set dev->hard_header_len
> this check fails in cases, where it shouldn't. To fix this don't
> set hard_header_len, but use needed_headroom like ipv4/ip_tunnel.c
> does.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Please include a suitable fixes tag.

> @@ -1731,6 +1732,7 @@ ip6_tnl_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
>   int ip6_tnl_change_mtu(struct net_device *dev, int new_mtu)
>   {
>   	struct ip6_tnl *tnl = netdev_priv(dev);
> +	int t_hlen = tnl->hlen + sizeof(struct ipv6hdr);

Please respect the reverse xmas tree order above.
>   
>   	if (tnl->parms.proto == IPPROTO_IPV6) {
>   		if (new_mtu < IPV6_MIN_MTU
Side node: it would be nice to extend the existing self-tests to cover 
this kind of tunnels, too.

Thanks,

Paolo


