Return-Path: <netdev+bounces-194746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3963ACC3D6
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74123A780D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F60283131;
	Tue,  3 Jun 2025 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDSgS1lM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68E28312B
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944714; cv=none; b=kDlqAFNkRPKwEUjZqrnjp2NbJArilFha0zE9L3n+TasMxjjx/cwtHUqVIEbjNddJLcU6zhFJBUiz2R/0W+LNRQQGWZ1uvr8brXp5jdax9RNp4CLFCGeRb2BOT9g2BgT+XW/xNDpmUXDzJolMGGooPtsvlwJ2gWCl2Gb1pGxRKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944714; c=relaxed/simple;
	bh=fp6xJOzfnjJAccOY6qpcCcGwIK4ypY0/4Wb8cC5HDKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yk7EPj9OyCjriZxr7qQGkrN7tCs6FfFmRTBY8A5GJ0lS7qWYr09EiX8lvB7zl2/CyUYoJv8PBOldtfLN7NMkhYuMTaNPMpva1sg5vjXLjmfBrzg7NbaWTduc5HaVNxmK0JESYiLaLQQCHpTEAq32KKwvMZsQ1jmKORHDEATbH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDSgS1lM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748944710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNgbvXuMFM7sTYLLmWTANJxME2RYY2SpmN5jc76Au7o=;
	b=SDSgS1lM83wrrD8dzxboRQYOmBiekDGc4foalHUmwSYBXlGGn4JCLfgfoQYFdUJSgvwY74
	TsmE6bDqGqSwJeWBV0cGGgr62ZPXXr/rxKOE3LkqFpA6GiA7qjelgEx0sUq9Yjs63v7/G/
	n2/JCGYkmnjP4WWdmL+uVTwQ3Dya1IQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Z9nw0q9VOReS50gxxf22zw-1; Tue, 03 Jun 2025 05:58:29 -0400
X-MC-Unique: Z9nw0q9VOReS50gxxf22zw-1
X-Mimecast-MFC-AGG-ID: Z9nw0q9VOReS50gxxf22zw_1748944708
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so3430371f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 02:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748944708; x=1749549508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNgbvXuMFM7sTYLLmWTANJxME2RYY2SpmN5jc76Au7o=;
        b=NNrThTk6jgvCryadqStMmchUsso2j13e9FXdhoCE6oZReNTLIbpR/BLPL1PlDjBeu6
         RWZDf1jTUyWWEC2rav7JnHw9LL/YUOuouVu3tj8CiawALmNoqOQfhlszhhh3Xy1vMToU
         IFOWJAuEEFjvTXTSi48OMeuaHxBMruafBpiKhi/pNgE2qZqeGDqQIf6wDyDfxZ1XmkXR
         W3q9x89vX1DR4agmTwumy+I5pwLa3sRttoZkHKk3ngT7mkM7IOpJDM4q7RFZdnwQc5TK
         Ta/xC/wuM8PRDhT8DGGvfDIjyc/Cn3iaiOkI81JgToxghKinQdawN4sFbh48FEatF3qD
         1IGg==
X-Forwarded-Encrypted: i=1; AJvYcCXRn4nfXqeiZL8QCb33G1km2PqKQ8Y3xyfATijmrPe/0FS5XQ6gZ7BLsh/okL8gSbsGynVAspY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqq2e1gcoDiJ/AdV89gDxcm1BQRp45D1Crj19pjzZiyhO/AmrZ
	wvrTnMIbq7UBOMhIBiB986Is6K0zR4b2Pdc82kw0wWx5xYyCx8GX+d5u3K3h/wCgH8523OaN//W
	vCFV/9qdGf1w8kLL8aCWmUWpyQJ50FRhFhGwQnHOBUgjdSadFpyj4zV8uwQ==
X-Gm-Gg: ASbGncuAskz1v53dYz73l7+RCVxLThGEZ+gAvkylNANVI88BGwJXNeEpCh8jfrOSlvH
	15pTrUjGy7ZXwi8PwQc7Rb83XI+itEM7KIaeQqKLpGmsd+iejGUxeX+mKfRQEqk5zFOdyAJCVIi
	UBvcDqqTfrZAB7ir+xv+Bdquhnk37QGnzKpI5hkDDze2jgdbpa+C2wycAxvgk0o3ngp/hz3X2KS
	BeX6Z6bFHxkF+jFozzgsSrQeFUFT1V6q7bVKmFDzMv7kbNkjDdDwfJZ97bfLzUMafsCprcuOh2B
	LDw+FHmtwQ6Rtgl/P2rAgvdFYJG0mQxMXxtQ4opVOl3Nw06lMK8yDBtB
X-Received: by 2002:adf:eed2:0:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3a4f89a47dfmr10789576f8f.10.1748944707926;
        Tue, 03 Jun 2025 02:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERdpGKuvBmSquPjg4ZNRRkccQ1kJDEat2329DpkWEBkq/5nXkFZtzPkKGanHYGUB0t6ULccA==
X-Received: by 2002:adf:eed2:0:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3a4f89a47dfmr10789556f8f.10.1748944707561;
        Tue, 03 Jun 2025 02:58:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a017esm17315541f8f.89.2025.06.03.02.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 02:58:27 -0700 (PDT)
Message-ID: <c259b212-0717-4baa-94f5-fc22da18fbe8@redhat.com>
Date: Tue, 3 Jun 2025 11:58:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20250530101254.24044-1-antonio@openvpn.net>
 <20250530101254.24044-2-antonio@openvpn.net>
 <292bd402-f9de-45ac-829a-9cf04c4ce22d@redhat.com>
 <0b48468a-8635-4211-b7fe-27fd146debe1@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0b48468a-8635-4211-b7fe-27fd146debe1@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 11:08 AM, Antonio Quartulli wrote:
> On 03/06/2025 11:02, Paolo Abeni wrote:
>> On 5/30/25 12:12 PM, Antonio Quartulli wrote:
>>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>>> index aef8c0406ec9..89bb50f94ddb 100644
>>> --- a/drivers/net/ovpn/udp.c
>>> +++ b/drivers/net/ovpn/udp.c
>>> @@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>>>    */
>>>   void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>>>   {
>>> -	struct udp_tunnel_sock_cfg cfg = { };
>>> +	struct sock *sk = ovpn_sock->sock->sk;
>>>   
>>> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
>>> -			      &cfg);
>>> +	/* Re-enable multicast loopback */
>>> +	inet_set_bit(MC_LOOP, sk);
>>> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
>>> +	inet_dec_convert_csum(sk);
>>> +
>>> +	udp_sk(sk)->encap_type = 0;
>>> +	udp_sk(sk)->encap_rcv = NULL;
>>> +	udp_sk(sk)->encap_destroy = NULL;
>>
>> I'm sorry for not noticing this earlier, but you need to add
>> WRITE_ONCE() annotation to the above statements, because readers access
>> such fields lockless.
> 
> I should have noticed the READ_ONCE on the reader side..
> 
> Any specific reason why setup_udp_tunnel_sock() does not use WRITE_ONCE 
> though?

AFAICS, it's a bug being there since the beginning. _ONCE cleanups
started quite later WRT udp tunnel support introduction. I guess it was
left over because syzkaller is less prone to stuble upon it. But it
would be better to deal correctly with such access in new code.

Thanks,

Paolo


