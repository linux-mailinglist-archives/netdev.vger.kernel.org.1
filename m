Return-Path: <netdev+bounces-146621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FE9D49BE
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0771F22133
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D981D07BB;
	Thu, 21 Nov 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNlqGvjJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0251CDA11
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180506; cv=none; b=GoskmwaN6ohGaQWTB82SJk62XBpnxbTX55u1KL2k6i0PZkeZ+9dPz6YD/mqruPZUnoT5hxfaYNV6id9kjtwxfsiQbFReKb0cxi4q3wktoNMv68gofsbn3zhu+uEDpdaF+Fm9+3K3uZpq7Rmd0N/fueRlE958C/ZnJhKMEEYBM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180506; c=relaxed/simple;
	bh=vd6fEIhwAJV856OacKnw2vIdjuLyIgAloMDcu8Z+rlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2gTxrwu+FmqFeggAasokALaU8KBf+EUDD5+zKqlILrsqV1TTMssm4DmJ66ksTRhPy8ODiPKW2jCtnkWUNYT5Fr27zPzEeXcdCbmcCrPYaQJ9Sk3pIT3tK2j4f2nKmIlZhtEs6MUgTRMEgnTXgdRfKBWlTsLHAEA8loZN+WI7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNlqGvjJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2I24DRZqf5YuYyIOYeFxTWR0dSlx3u9tHHEDx80HQ60=;
	b=QNlqGvjJviS9+kznfcRK0MpswsZVgGTLLnWm23t1MBNOASrMaJuzC496MEsl2YlfI0yJj3
	XY2xk5g5GJ8UoZKJWwBkE7XsT2lYt+MPiRS1NZqH1TkR5qxvhRIrHLbBR1JYmixdb+44NC
	mrmmFuBsJfsgMWKHYTc5if3Dgl3NS04=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-inaRNFmpPlSJhHzAjfTpsg-1; Thu, 21 Nov 2024 04:14:59 -0500
X-MC-Unique: inaRNFmpPlSJhHzAjfTpsg-1
X-Mimecast-MFC-AGG-ID: inaRNFmpPlSJhHzAjfTpsg
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460bfa9ff3dso9723751cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180499; x=1732785299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2I24DRZqf5YuYyIOYeFxTWR0dSlx3u9tHHEDx80HQ60=;
        b=A2Mlm7yANDEJPxBUeShk7H/9KD51sXY0TRKMA1wyOLz6/FrqcQuTZd3sqBNJguJD4F
         98yER9LDCKVViNn1SyO6+QbZg+mzyiwACtpSGuvnQXBMSr85g4ytzzWSfjqXNCulgm0M
         wbvHws6iQ5/HJMcMjlLO+TruIgZl03yKwLviNYyLoKCkttmweBbhRjPGny4idrqHjTcU
         swj3H0K29pCt1Ps9uV11VRRJWBePoI0s5/FZIbKDmruPRTCQ3XkN67yP0NItXN8tmUL4
         9l6dd5+hFcRtekjIp8Fkho/hQoTdUnQw86/b0FxsAr0T2G8UAcON8p+UvtWh8OvC1rDJ
         b0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUyuvTuOM3+folM3eZrU+EhS4wu04hqZ8kqxYxuyHHU5JQfsXCz4nF1uMiknhRJT3tkvrkgtyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHcpj33aAk134du4EvqE+nj52lT29eVe0hGcbhVzpZUewouRN
	D87Zv1O+h/3ZiImxNCnaJglENY++SNNNBYbUwklFRMfNpWh4spNu9x2dFs80kQeaferzck5Cr9V
	1IUlX3ZyBe5tIBEm8Ds5iCDiM+Cx3iMzowlAQlymKaAFNrjd72ifkVQ==
X-Received: by 2002:ac8:5813:0:b0:460:ab1b:a16d with SMTP id d75a77b69052e-46478f800c5mr71865771cf.27.1732180499401;
        Thu, 21 Nov 2024 01:14:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFuciddkRYDLoyXHvsvHU904RIlVszbK8lqddhAJdV5+Xjc/UlDsEsRj/wMGBNav07v68LIQ==
X-Received: by 2002:ac8:5813:0:b0:460:ab1b:a16d with SMTP id d75a77b69052e-46478f800c5mr71865511cf.27.1732180499106;
        Thu, 21 Nov 2024 01:14:59 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646a547318sm19421071cf.70.2024.11.21.01.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:14:58 -0800 (PST)
Message-ID: <322e75ab-8ae8-4dd0-9646-ef41d9ff2fba@redhat.com>
Date: Thu, 21 Nov 2024 10:14:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v3] netlink: add IGMP/MLD join/leave
 notifications
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>,
 Patrick Ruddy <pruddy@vyatta.att-mail.com>
References: <20241121054711.818670-1-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241121054711.818670-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 06:47, Yuyang Huang wrote:
> @@ -901,6 +904,58 @@ static struct ifmcaddr6 *mca_alloc(struct inet6_dev *idev,
>  	return mc;
>  }
>  
> +static int inet6_fill_ifmcaddr(struct sk_buff *skb, struct net_device *dev,
> +			       const struct in6_addr *addr, int event)
> +{
> +	struct ifaddrmsg *ifm;
> +	struct nlmsghdr *nlh;
> +	u8 scope;

The variable 'scope' is not used below.

Cheers,

Paolo


