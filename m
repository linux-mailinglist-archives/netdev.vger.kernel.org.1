Return-Path: <netdev+bounces-146203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5279D23C8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBAC1F228F1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A061C3F26;
	Tue, 19 Nov 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSAnGICn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE11C1ABC
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013264; cv=none; b=IdUmTePQzeh5IOV5QaPHfMgKFH/4xvMQstopDO2nMBGa4VNp7kF1a5uFdIrhO3DtDEnShLsCNGS5EA9EcPTFVBH78nvdui4roe234stE/ahezurvbys0Uo/QTqyXwL4lqef5PoFFeSmUQS2H5R7+ecvv4foevYPE0g6Lt6aUUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013264; c=relaxed/simple;
	bh=6VCRFnCX3pfgj4fK4Xruwd8ELWuUcPyHUTVhmyFVH0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQZzvhbm6aQOQt4rxdTGwL03jgdLboNaj2beTcpiPIXQpjmDqrlaOLkC+0QsWi/tc84lOKBMjegomyx5BKqNsVdMxXH8zqERUx9rkF1GffejkoYZSBgpu940JfdP9bdXlSIfZpCdvkeDVT+ZTbRnkQeNK2OQOttGz5VwjTBMajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSAnGICn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732013261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbq4GTD2ZW1VFhzZ9Ih2F0hJrIDKiy6HQqH3WOgrSvw=;
	b=DSAnGICnYZ/LSDkTvNvW+0nc13xCmE67aGex7OjLGLZAQ1/4jbaZFEBL12NbizOsVM1GcU
	+/5afBsrn7XzvTX07HTkGhicHrYSFz27gBSNyed00wbi6PAbNbvKSPn/cr214/vK7vS9z2
	xr8Ikw0JjbycVwEELuPAh8+jAFMsca4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-SUW3VP67Njy-eY8ukiIGeA-1; Tue, 19 Nov 2024 05:47:40 -0500
X-MC-Unique: SUW3VP67Njy-eY8ukiIGeA-1
X-Mimecast-MFC-AGG-ID: SUW3VP67Njy-eY8ukiIGeA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431673032e6so33443075e9.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 02:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732013259; x=1732618059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbq4GTD2ZW1VFhzZ9Ih2F0hJrIDKiy6HQqH3WOgrSvw=;
        b=KxBBXQOCxmoV78UQzNgpgvnxGOnAxA/Rdy53tZ44lXCFN/gubA9zPDFsCZQ6j+WVHN
         ppjwLW7mUq9l+xHALl3Qy1efqsAFrDImt/oIFPM7NN4zqMc9/ya86Iq3IwOlEm+a2BDV
         bjjwnbsrWErVQRuZAX+zwtLRt1tRMKSSkOyaptzBtX0Gs6frcMQQr1jNoWVgt76qR6cd
         n91XptpXEF4cfAUhAKoQEJ9n7ZyHLqq/6sbk70XZC1jmHjIXC3DWa0boXUskUoOD9g7c
         dJIlASKhv9lraqfRcf94XLp5nb/dtUO1+Cz8okyCx9kSQdMZDrKxRw+P62v6i3jvAaSt
         n6+A==
X-Forwarded-Encrypted: i=1; AJvYcCXO3U3x9uAfUd/TXIPLp3Gvn7m1n1FOOaL+ywdKBcDWe5/Bwd6kmr9uyYLr9kvoucz4z2p5xbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5pBPWuH9+jX3mGQLHqo0rRiuVwBF4hb1PE4wH2+5OozwkscR
	QsNx0eYue407s1MvHDUR4hWXNvJ2/cQhYVnG5ZPFB4Pz04kz1fLMqgltLssSja0UKDtME05fD4L
	Oxv/FLqFI4gplLPpdRTskdcXa+aX2dUluUWAd8mqeHxycESX7S6DYgA==
X-Received: by 2002:a05:600c:1c09:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-432df71d609mr136397815e9.5.1732013259174;
        Tue, 19 Nov 2024 02:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXQU8bYBZyo+JtkpZZANf/ov31RNF5jrSGWsBbL2ftQ1DTgrFXVNSX9siT2RRWrGpE1HT9Bg==
X-Received: by 2002:a05:600c:1c09:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-432df71d609mr136397625e9.5.1732013258844;
        Tue, 19 Nov 2024 02:47:38 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38247d065c3sm5791778f8f.87.2024.11.19.02.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:47:38 -0800 (PST)
Message-ID: <1bc6fbd9-aa04-4bed-b435-262edd8f2d37@redhat.com>
Date: Tue, 19 Nov 2024 11:47:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/4] net: ipv6: seg6_iptunnel: mitigate
 2-realloc issue
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 David Lebrun <dlebrun@google.com>
References: <20241118131502.10077-1-justin.iurman@uliege.be>
 <20241118131502.10077-4-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241118131502.10077-4-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 14:15, Justin Iurman wrote:
[...]
>  /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
>  static int seg6_do_srh_encap_red(struct sk_buff *skb,
> -				 struct ipv6_sr_hdr *osrh, int proto)
> +				 struct ipv6_sr_hdr *osrh, int proto,
> +				 struct dst_entry *dst)
>  {
>  	__u8 first_seg = osrh->first_segment;
> -	struct dst_entry *dst = skb_dst(skb);
> -	struct net *net = dev_net(dst->dev);
> +	struct net *net = dev_net(skb_dst(skb)->dev);
>  	struct ipv6hdr *hdr, *inner_hdr;
>  	int hdrlen = ipv6_optlen(osrh);
>  	int red_tlv_offset, tlv_offset;


Minor nit: please respect the reverse x-mas tree order above.
Also the code would probably be more readable with:

	struct dst_entry *old_dst = skb_dst(skb);

and using 'old_dst' instead of 'skb_dst(skb)'

Cheers,

Paolo


