Return-Path: <netdev+bounces-147885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC4C9DEBE6
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D18163113
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A21155326;
	Fri, 29 Nov 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI/VhO8z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601311465BA
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903368; cv=none; b=sReOsRbJLNrNhoBU3X7kGG4uXivPn0UPsgH09L/3Y+Sez0uK/Jztyul70dV8kXDACSJD3b3/yyvg3T4OnJI3tNAPUR0Xm5j4tfDGgDiInpOgtPSPtP7NxBodiZ2UQNMWHvHDJaAFj08OIDz//cB4UQSj1V7pIQnYjm7/+RyNwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903368; c=relaxed/simple;
	bh=/mdO9e2qLWUWv+8NGCkJc4S0Nd+5M6HFpbDtTG+rYxg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NiSrnsP4LpdyLHmqwfa4e5inbrPVY2w7A49CeKSWzLbo6xbGhLJBELYjW+R4cr5YghY3AnaSQRApj5e+5aTN6EHzkzoobR2TO81jlAuZ92Ozp9uE6d3ds87+3HQ12VkLaL436NGNvBD/qY7GSrmHQcWS+RbFmSCeNFWbb56Nyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aI/VhO8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732903365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCGz6TGXnGG/OZd3u/MCxX+mZJ2x1TlmsaGonv5WHnc=;
	b=aI/VhO8z0RU+uzefbwpPfwTJyaasr7IYBWARCHg0eeAzU5IKfsH3A6BdS5Y9fsl1wNexAD
	eGTwet20vylVgZfs9P6TmDufea7gnwY8f8bh3Y8mTjV/jXRaydcwmuj3AFLDqBN70jND6c
	elDmMNh5ck7T15MCwduaUgfVk1mOm4c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-n3Uf_6IUO7CS7BVbBybWFA-1; Fri, 29 Nov 2024 13:02:44 -0500
X-MC-Unique: n3Uf_6IUO7CS7BVbBybWFA-1
X-Mimecast-MFC-AGG-ID: n3Uf_6IUO7CS7BVbBybWFA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43499388faaso16001675e9.3
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 10:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732903362; x=1733508162;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCGz6TGXnGG/OZd3u/MCxX+mZJ2x1TlmsaGonv5WHnc=;
        b=B8rRRGYoBX6uY0sNz/XkVDnL0FWjrTl+VCCrAyDW5ugCt1rTtjy3VNDDgTakFmt0BB
         HXpmpfQVfYqLi12sbWHTFl5UrNkVfNWB/bl9ECFN1Imp0NEMd28dmyQd/qx2BROJmx4l
         aGEU0mG3K9i2OVK9nvdHEEAwNJWGcVmz42xDagrFl6w/Ws+AFqx/FQm7pO6VlJdbxqiW
         y1aKMagzPsjV1GqlvNx9TuqEZUauoKPPUOJIXu7JE9+n4QzsW1yYmkF6Av186kWz1XCm
         nqUV4XsC41DSNOk/7PED85MoDtS36l7PRg6rPjD0pODEdL0b5SxlrqgNWWToBflpbyCz
         oXNA==
X-Forwarded-Encrypted: i=1; AJvYcCWtEiM91DdNvS/7YR5Q+o/w7+06yatpKve+TaxQGvfWJTsbCRnBTzNSOmUsvQQtG/2WE2f2uAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZ3cNLldUEzxgAMX3MptiCdMojtsEcB1fyUyyTCMs3DeA0Gyb
	W2pAIOm9fiKmWRHmTdkdrNPArQP57M7MajagTMmaQIXWHHMSlYr5FXOkOIwtl0fUik4miGru0Yv
	CBrt8GimtBviRp4U2ee16IOx2/I1K/wkSsen22IAobyGny5cqmpk4mgMrXJQHjw==
X-Gm-Gg: ASbGncue9NfiVhgcd6tQMi3wuhzztoOlf8TUF6eC7DQCzms+ui3+dR/ZvbzcsHQj2j0
	MSTdyR8xSy6KMJd0NbY67iYGk7enkushMe6pIkaSh4JEDLx1z2T6HjhZn1MGopOjxhp+QVGEkbF
	+si9Cp9D1lHVpnGiFm3SYWIO6IGzoUy0Gm7g9dBqRiiwFWuJ9DTl1weGtgknl2Rw2DdD2TX8ZmC
	lssjx4hOYCmjhNZMqPb5xjFXsHGy/UzK6JOG7N8my7jvpMTw0s/7dQiDTwW51XtWRXjS5rsGDaO
X-Received: by 2002:a05:600c:1988:b0:434:9c3b:7564 with SMTP id 5b1f17b1804b1-434a9df71d2mr109937035e9.20.1732903361172;
        Fri, 29 Nov 2024 10:02:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzeS/qLX2LHJA77L+VmMNBQOsXUEWFUt1Hfre9KR598u3XejW8ng8g2d+F4ANNeHH3ZB2euQ==
X-Received: by 2002:a05:600c:1988:b0:434:9c3b:7564 with SMTP id 5b1f17b1804b1-434a9df71d2mr109936615e9.20.1732903360785;
        Fri, 29 Nov 2024 10:02:40 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d1a90sm90978955e9.32.2024.11.29.10.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 10:02:40 -0800 (PST)
Message-ID: <14c9b1de-7dd5-4f94-a604-6007991ac17b@redhat.com>
Date: Fri, 29 Nov 2024 19:02:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipmr: tune the ipmr_can_free_table() checks.
From: Paolo Abeni <pabeni@redhat.com>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <fe340d0aaea857d7401b537f1e43e534b69470a2.1732875656.git.pabeni@redhat.com>
 <a4ad9242-2191-4f64-9a92-25d11941cf2b@kernel.org>
 <7eec1423-d298-4fc1-bbbd-b4a7ed14d471@redhat.com>
Content-Language: en-US
In-Reply-To: <7eec1423-d298-4fc1-bbbd-b4a7ed14d471@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 18:13, Paolo Abeni wrote:
> On 11/29/24 18:01, David Ahern wrote:
>> On 11/29/24 3:23 AM, Paolo Abeni wrote:
>>> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
>>> index c5b8ec5c0a8c..d814a352cc05 100644
>>> --- a/net/ipv4/ipmr.c
>>> +++ b/net/ipv4/ipmr.c
>>> @@ -122,7 +122,7 @@ static void ipmr_expire_process(struct timer_list *t);
>>>  
>>>  static bool ipmr_can_free_table(struct net *net)
>>>  {
>>> -	return !check_net(net) || !net->ipv4.mr_rules_ops;
>>> +	return !check_net(net) || !net->list.next;
>>>  }
>>>  
>>>  static struct mr_table *ipmr_mr_table_iter(struct net *net,
>>> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
>>> index 7f1902ac3586..37224a5f1bbe 100644
>>> --- a/net/ipv6/ip6mr.c
>>> +++ b/net/ipv6/ip6mr.c
>>> @@ -110,7 +110,7 @@ static void ipmr_expire_process(struct timer_list *t);
>>>  
>>>  static bool ip6mr_can_free_table(struct net *net)
>>>  {
>>> -	return !check_net(net) || !net->ipv6.mr6_rules_ops;
>>> +	return !check_net(net) || !net->list.next;
>>>  }
>>>  
>>>  static struct mr_table *ip6mr_mr_table_iter(struct net *net,
>>
>> this exposes internal namespace details to ipmr code. How about a helper
>> in net_namespace.h that indicates the intent here?
> 
> Makes sense. What about something alike:
> 
> static bool net_setup_completed(struct net *net)
> {
> 	return net->list.next;
> }
> 
> in net_namespace.h?
> 
> The question is mainly about the name, which I'm notably bad to pick.

Thinking again about it, I would use 'net_initialized', unless someone
has a better option.

Thanks,

Paolo


