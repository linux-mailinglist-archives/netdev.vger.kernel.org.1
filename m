Return-Path: <netdev+bounces-112038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3828F934AC0
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6199E1C21333
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5D80038;
	Thu, 18 Jul 2024 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBqHFeOU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3078C8F
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294265; cv=none; b=gUuguN/YU6vcZUFVSynzFhlLYEJoE1mjDla0kV+h20LxMhAk287OEFiOJFCPmuR59TKpPdlVpdZe/MArdPZB8bFZho/BD8UK1nKbd6kvgER67qYHJGI0t3kTTZUo6YGDRQMm2uwzH4KSWfaxteD1ppzdYeCk0s7kfVKsyANqSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294265; c=relaxed/simple;
	bh=vPy/nMMk1C76qqZRHaFBx0D6uZVQfOEera0mnUKS1Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoOJkfw854AzJbSybgPXijUk/n8cvPmhB9MCpNbTvPrq8Nxckwni7YnCNVyjOOEqMdD5I8TjijDHQ1jBeZY+IpwiaXcEvYRHzlelic3690VwvtyoiLG2ljsJL5zGY2I8whKKhp3Ftibl6uOScGUUXrlgKrUd+j5K78Mfx0isndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBqHFeOU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721294263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ZwV4xC2XIy0bnRWnXbVpRjb1sT4l2/9bWUdXm5/n8k=;
	b=CBqHFeOU9l+6SlpTHKzkvtWhcBkESBBc8PzjL5PtS3v09wnFpVumwmhoUK2eFTGIAPIcA0
	JsqVIXXPfRrsX0R6E1WMmYnyKOrtiO9iYqq0xgTgSwFuER6/tmjoHP7Vqiu3mlFWaTYSYX
	Vtn/Q8szuM0YxpSt7pIgAHDiVUMZPLk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-3weJ9z_OOnG-_rxyCTK9HQ-1; Thu, 18 Jul 2024 05:17:41 -0400
X-MC-Unique: 3weJ9z_OOnG-_rxyCTK9HQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ee85581565so307141fa.2
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 02:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294260; x=1721899060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZwV4xC2XIy0bnRWnXbVpRjb1sT4l2/9bWUdXm5/n8k=;
        b=AkSstkk7PxuRrGL6NZO+TITxSyYGmqwCiUxi5xmiKGwdryrbqALDe+dq1+gEgU1agw
         3w5V9E2Epoc++ToggYJa4mNxZLEgmGVOTNYstkv+fmOIf9S5UBsr4kFwTHVV81TwUA1M
         y/WIceCaiy9OWzcehPvDDXpaFaLMEzTGX1CjD1noYo2LuWu7EzSDc4XeaF/tVb86xnEP
         +UpyNPaBwU80883Z0zZm5iJn7ioObOhSzf/LLZwtJHVYjKvv7i3xDHAjtL5U1UtwLhQV
         40spJp7+gOxukVJv+BxuWi5uZmLciy7kviVnirS3emmKWGGI9sl1oyEl62Ku+yvraIIj
         UH8w==
X-Forwarded-Encrypted: i=1; AJvYcCVzL0oM4hbB817CuC6Ps+9cPE5WC0QaR3v8KAfO+5SolgKe5c6/onKCMYLzpI62NpB/pFKgBtLW0sfzGbuYnxGqQhkLA6Mk
X-Gm-Message-State: AOJu0Yz9nbcEeWBMIVjEF+GpFHfMdy2WTwUVohyjd1eBIDWXqG/fGLmy
	YAYqrxE0U8AlYz0pJbbbHjlxE0koOzqindEimSrgtfl6l8nz6lZhJ0urwPCxxL1bQmaFVKHAToI
	7ccFdSc6X2SO2g8DCoQ/vW1pPR8/iUixwjrShzO4iHWKtn2xMAai/Cw==
X-Received: by 2002:a2e:8396:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2ef05d33113mr7422711fa.5.1721294259910;
        Thu, 18 Jul 2024 02:17:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC7SAChnVTkqMThBZ6Thcv9r82ds9BHgKpNdZmhfu9sRo1Nqg7wv+mY+GC+hLh5U6SiIVSmw==
X-Received: by 2002:a2e:8396:0:b0:2ee:8071:5f03 with SMTP id 38308e7fff4ca-2ef05d33113mr7422601fa.5.1721294259439;
        Thu, 18 Jul 2024 02:17:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24? ([2a0d:3341:b08b:7710:c7b:f018:3ba3:eb24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2920313sm2848755e9.0.2024.07.18.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:17:38 -0700 (PDT)
Message-ID: <cfc3ba0a-4c91-4c58-9c98-6285720473c8@redhat.com>
Date: Thu, 18 Jul 2024 11:17:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp: process the 3rd ACK with sk_socket for for
 TFO/MPTCP
To: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240716-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v1-1-4e61d0b79233@kernel.org>
 <CANn89iKrHnzuHpRn0fi6+2WB_wxi5r-HpZ2jrkhrZEPyhBe0HQ@mail.gmail.com>
 <310de142-e263-4bcd-b499-69e0640de51e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <310de142-e263-4bcd-b499-69e0640de51e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/24 17:09, Matthieu Baerts wrote:
> On 17/07/2024 16:57, Eric Dumazet wrote:
>> I had no time yet to run all our packetdrill tests with Kuniyuki patch
>> because of the ongoing netdev conference.
>>
>> Is it ok for you if we hold your patch for about 5 days ?
> 
> Sure, no problem, take your time!
> 
>> I would like to make sure we did not miss anything else.
> 
> I understand!
> 
>> I am CCing Neal, perhaps he can help to expedite the testing part
>> while I am busy.
> 
> Thank you, no urgency here.
> 
> If it's OK with you, I can send a v2 using Kuniyuki's suggestion --
> simply limiting the bypass to SYN+ACK only -- because it is simpler and
> ready to be sent, but also to please the CI because my v1 was rejected
> by the CI because I sent it just before the sync with Linus tree. We can
> choose later to pick the v2, the previous one, or a future one.

I think it would be better to have this patch going through the netdev 
CI, so a repost would be appreciated. I also thing Kuniyuki's suggestion 
should be preferred, so I would say go for it :)

@Neal could you please run the pktdrill tests on the new, upcoming 
version, instead?

Thanks,

Paolo


