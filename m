Return-Path: <netdev+bounces-219488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1974B41968
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F717C976
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988972EFD8E;
	Wed,  3 Sep 2025 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIFVLS3N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0A2ED143
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889866; cv=none; b=tJxjagY8EiV8G2OVR5r5N8I7cK9b1avnMessFCUcuAob8+KCNlChpSjY/1DoMhrntxM8rZ2IsjKn1FTOVVAIfCSOjZLfqCKpppdnMgzxMxLYGPJsqpHfifLmrDmpz5Dw6FyWdylLBooW3Uxm/rNnXDngXVslyHvJiHNrcY0tdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889866; c=relaxed/simple;
	bh=n44lZlrjL9/Lg/nWMnKZiu9dgkRT7hVExph0iAz1s+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7GABwUZ30xfC7xFaDXRfcQu2sBdlN8OSI8bNImfTjmFAikycLe3f8SKDUsvKnGRUbafzJVSSTFJHZCsIyANVsHqHYEpW+P2vHZ8ihqTGL8jWwZFuEAg84SIlYIYn6qOuE9bKyslzO1r+eOZxpBt0nTrayXLkQYxntebgM1RR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIFVLS3N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756889863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHKnaz0Jn8iVx38hVF6qYtOxGljhhmQSWi77U/NJ55o=;
	b=DIFVLS3NMkdRAfVQdt2xUfgFQeNyiEHlZOZpBCVS7O7JOGyOpPOzG6aY7fZT1UJBwJJtRK
	0U2QO/Y4wkca+dgA40cwdigWVFG4sEBMAZEqXAlI01b+7sxYMJCEoql0d8T0llloZ5kP0+
	xJfnXLepXOiT0BLSv0BuLaALj6zRyy8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-OmT09oKBNFWTBNDfbvOK_A-1; Wed, 03 Sep 2025 04:57:41 -0400
X-MC-Unique: OmT09oKBNFWTBNDfbvOK_A-1
X-Mimecast-MFC-AGG-ID: OmT09oKBNFWTBNDfbvOK_A_1756889860
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b71eef08eso32938735e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 01:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889860; x=1757494660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHKnaz0Jn8iVx38hVF6qYtOxGljhhmQSWi77U/NJ55o=;
        b=lOSn/sy+Cr/ekI01/TD4jiDF47cL19U3Ci40Uc3PQkJvLetl6vRTe8cYWDRkhkkigB
         UT2vmyEOXLjHFoICPQkVBfWy2Q+NGaukHszOyDoJAxe0RiqAW2MPlo3qydnngNqLH5q1
         cvCVwBKEPsOmVT9LZnq2wyHSiqmxf/aAEKlJLXYPy74VAyK29rbhaG5cz3ULKSHxVUK7
         g8KleuzI2KfRm5inFUawP3bd5zm4f/afP3PSA9UJYFyOjTwciuirKPF216lu+iwqxisl
         CH/vr+TImEuSsSbMi61fv1FPf7rw/Lo7so/G/9YrJsT5nLl1Tpx510ZDlf3NyKi9ET7x
         XVLw==
X-Forwarded-Encrypted: i=1; AJvYcCUhboQSBopY5LyCx9qpoXx0OVMikaHVE1igG4Jqmm8a2IUZiLCsBtjq0ahN1ysJRvcpNWxWB2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysR36rfUgnL0e09G2CKS1miyEy3xVL2c98rMZTPfPcJ8JAld+
	Uc6nj6u4k0J3RCuO7o35+vZk8HhHDL7BA8XzmgJt+enCkZrHd5lq646DApQczzfRAPinGOABC5F
	EfJ5FSwRAwRLxBreU2HJgxSGlTo3Vtzp5MZzzfOtR73e8FDf1IsNeBvd2yw==
X-Gm-Gg: ASbGnctlNALO7NmWEiGwISH+t3E/yUjadbw9Yrnj3eOHeoOm3oriMW5TfIxxzBh4wVq
	uiVrGRDlEpdX5PwAFAGzN54K7tcoyScWHnEXE3JO/RbE2qYvyJpYbuxZp6JrDwDINbYkxJuRwCD
	wrJQY/L2cSpP1CuY7e7d41vZxuHE0DuINefMieT3Ybhnzc1++nF4IYDK72tDJ1D1/pNPdhjbotc
	KumbDvkeyfwA6EVT0+wwAjJXVJHjj0fikqhvyZU53E5AJpuYoIUGXlbI9wjKbhVu/o++xminwQo
	xg4wrY4BlvmyuRjBhuVR5faf80p4gx2UjTPceLxPPHYJO6IADmwVjdixTd6T5t5B9Gp4zhDFCG2
	IPExj/8HyEgE=
X-Received: by 2002:a05:600c:3145:b0:45b:6b6e:ea37 with SMTP id 5b1f17b1804b1-45b85570c73mr102665245e9.19.1756889860573;
        Wed, 03 Sep 2025 01:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKyN4Nw4LFfOWJLslVk30dcvSghsLaNDNt+Zy6K29DTsukagnMTf3vjZQiaECM6nVbzLXzdg==
X-Received: by 2002:a05:600c:3145:b0:45b:6b6e:ea37 with SMTP id 5b1f17b1804b1-45b85570c73mr102664875e9.19.1756889860114;
        Wed, 03 Sep 2025 01:57:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e50e30asm231611455e9.24.2025.09.03.01.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:57:39 -0700 (PDT)
Message-ID: <f1ba09c0-7a31-4929-b2f3-70797a60cd80@redhat.com>
Date: Wed, 3 Sep 2025 10:57:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 08/19] net: psp: add socket security
 association code
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
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <20250828162953.2707727-9-daniel.zahka@gmail.com>
 <c282cd8e-96c5-41ab-a97b-945cc33141ac@redhat.com>
 <a30deb61-92e9-445e-a3c0-5ba9dab52b72@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a30deb61-92e9-445e-a3c0-5ba9dab52b72@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 4:58 AM, Daniel Zahka wrote:
> On 9/2/25 6:43 AM, Paolo Abeni wrote:
>> It's not clear to me if a family check is required here. AFAICS the RX
>> path is contrained to IPv6 only, as per spec, but the TX (NIC) allows
>> even IPv4.
>>
>> What happens if the psp assoc is bound to an IPv4 socket? What if in
>> case of ADDRFORM?
> 
> PSP transport mode with IPv4 as the l3 header is permitted by the spec. 
> You are right that the series only really supports IPv6 as it is now, 
> given how psp_dev_rcv() and psp_dev_encapsulate() are implemented. I 
> will update both of these functions to support IPv4 in the next version.
> 
> I am a fairly ignorant to how IPV6_ADDRFORM works. Will this still be an 
> issue if IPv4 is fully supported, or do we need to disallow this sockopt 
> on psp sockets?

It was not clear to me if PSP supported an IPv4 L3, and ADDRFORM allows
the user-space to change an ipv6 TCP/UDP sock in an IPv4 one. In case
IPv4 was not supported such transformation could cause problems.

Since IPv4 is going to be fully supported, there should not be
additional problems from ADDRFORM.

Thanks,

Paolo


