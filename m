Return-Path: <netdev+bounces-213811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D2FB26D53
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA39A602378
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9E1FCF7C;
	Thu, 14 Aug 2025 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeUsM6uF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4236417332C
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191564; cv=none; b=co62GBi27vCnRmI56PMj0zd4ZEa0pWdkY31V5r5781NHG/hfsjT3BRdZTCwNI98dmMhji+EpqLkxp34Rh2Yru2l43EUjJl7AfA99hSiU5ohKlBZair7OXwwcEhXbmAWZaZ17U22l3ehoXUFkTwwWgkD4kCQYMb6DAEnnNoeZ670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191564; c=relaxed/simple;
	bh=gHSf81LGLRwDP1mwI37qiuUh7BYpYfxx3GdN0l/03Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZgq/qT89Mm1jcAougssPeMh3TzlDFABkTZKVBSWkCBTXdDiRxxr2B2jGEyVk7iQyCTDyYC7MYITNqTww9ZhNhf6ny7bwaCVlbmRU5cefpCDx1kEWum47I8TEKU+yWQzS52IAPzmSCq7L3QWPV7CU1mysEBDGvjL/qKe6CZDsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeUsM6uF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70a928dd059so10488036d6.2
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755191562; x=1755796362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Zx/QsMeq6IAlPUb9S7uGQ2oCk6k1YPaPbZO4fv60H4=;
        b=SeUsM6uFVzY3gQX2ebUFcAkxfTWxSGjjAWESC6kbiYySYiHGSAiX/BXizDqCOh1aX3
         VhzjFrUDyHfs5n71pD4r+v9tyK2FhSBZd+eFGKwFTRjJTfLanyGKAPEbKhpvqP6yYbE0
         TgRgQvxeZ5ippynjfrvBDmzO6x8KdD46ZhRhkb3lZ2xuYFYZ6AQcrW8Yt6IRsTtx9kLa
         51ygyIXvNDatTaI59IV+wAB0jIYEdNHPF53H3noVjbkAmoHzmwJRgmqnEI8hEoc2ElXt
         kioXBXJmP2/f1NJbQUYmG8jAEGlvrW2W305/0Jy/eH0Ec1DjuhyV/fCk7LWQokcFzK7b
         OtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191562; x=1755796362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zx/QsMeq6IAlPUb9S7uGQ2oCk6k1YPaPbZO4fv60H4=;
        b=nusao9+uJuN3y+5BCQh7GdftjclPtuWa9Y1+j5xs5HrpJaeVyHjqaH/SYOtNNxKUJ5
         17P2T0Hk9TZfgs4DGNQjkOQ+Tj9vkUo91jFvBIQGsco9r/9FeKYOoyGK3fJTFF5l+WzQ
         RLGKPY8grhJtGYEoxGUNrF4l0BAzKzwR+KCNXN8UKqakZerxZDVzJyLjpVAwkTPByMLa
         JBcjGgU14InK4pjMt7v+xUtirSz8LWesnbgOMLjCXcXIibqSI3vvdPC2skKR5Ami6Fai
         gMeGvHQkkk0AnPV8g8S40ILKcFS3FpwctJkglEedKu8cC1LzYkGt7vbqIo5/qN5Xz87x
         HfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc70eTmXZakZeqDa7NBhhOz855ya21IgqeehGxNkca0qEyhfmV81BQlSritFIfyerd56p8qvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRh4pcWMp+mKFPyAvk8TMBu/ax/MDveFUsHxVyQgIlOFbzXx9M
	3aIfWS/5Jw+0HHsS82T0J579kSIbZcpthdLBUIGtg4Hh7G9tx1s6zooe
X-Gm-Gg: ASbGnctLsYh1EvOFqBesB5WvfUqZgysLIGCinzlbj9EdvrELec2KsFvNkN+vvmh3zNl
	Kz4haKuUoM8mBvD7j3MdUy4EgkqQR+OybnxkMrPudxpz7EAXR37b/OCXYIFhlkyFiHPx08ndDpb
	1ua4cfVy5MVTK3Rc7Xg3DoyESVnRdGR8VHPyLvZlKybNKBA/lbnRQwhJup2Pf13FQpA+58AmVhQ
	4Z4YvP/ovI1znX+/Wh5yy7S1q9MB4mCp2HJvlJMDkwYJLMro9DnOf7j+69LpphT+1i+I7VuYinA
	A0m90X6Krezfr7tNeyHxOHPV0ePmZCfVwYocvMH9BZ+Ui2xZYX+7A9H/9U09nIRMyQQlc1p/7Vq
	r7G6mR7lwWFmCzc4yMAsii20qPZBhe6IygQ50v2q8XeQu7iV9pvl4Wxmt/7XvKKe9h5MtlyTR0F
	b/
X-Google-Smtp-Source: AGHT+IHVb+BaPiVd/VoJGBJsJKH9isCiY6PBk5jSW1m0rgT9N4O+BknC9vIxAfA2dSFIVtdVHctYMw==
X-Received: by 2002:ad4:5bca:0:b0:707:4d3f:c3ae with SMTP id 6a1803df08f44-70af5e43783mr64144266d6.36.1755191561831;
        Thu, 14 Aug 2025 10:12:41 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b55afasm15281396d6.56.2025.08.14.10.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:12:41 -0700 (PDT)
Message-ID: <f1c1cee8-4e21-41c3-886a-5ce5fbcaa426@gmail.com>
Date: Thu, 14 Aug 2025 13:12:40 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 09/19] net: psp: update the TCP MSS to reflect
 PSP packet overhead
To: Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
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
 <20250812003009.2455540-10-daniel.zahka@gmail.com>
 <a6635ce0-a27f-4a3b-845a-7c25f8b58452@redhat.com>
 <d78db534-b472-47c4-829d-83384b537ea2@gmail.com>
 <ed68e6a2-f9e8-4523-9104-98a97b54b153@redhat.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <ed68e6a2-f9e8-4523-9104-98a97b54b153@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/14/25 12:38 PM, Paolo Abeni wrote:
> On 8/14/25 4:50 PM, Daniel Zahka wrote:
>> On 8/14/25 9:58 AM, Paolo Abeni wrote:
>>> On 8/12/25 2:29 AM, Daniel Zahka wrote:
>>>> @@ -236,6 +237,10 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
>>>>    	tcp_write_collapse_fence(sk);
>>>>    	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
>>>>    
>>>> +	icsk = inet_csk(sk);
>>>> +	icsk->icsk_ext_hdr_len += psp_sk_overhead(sk);
>>> I'm likely lost, but AFAICS the user-space can successfully call
>>> multiple times psp_sock_assoc_set_tx() on the same socket, increasing
>>> icsk->icsk_ext_hdr_len in an unbounded way.
>> If it were possible to execute the code you have highlighted more than
>> once per socket, that would be a bug. This should not be possible
>> because of the preceding checks in the function i.e.
>>
>>       if (pas->tx.spi) {
>>           NL_SET_ERR_MSG(extack, "Tx key already set");
>>           err = -EBUSY;
>>           goto exit_unlock;
>>       }
> AFAICS the nl code ensures the SPI attribute must be present, but also
> allows a 0 value, so the above check could be eluded.

I think you are right that we need some extra validation for the SPI. 
The PSP spec states that 0 is a reserved value for SPI, and our 
implementation does indeed depend on that here.

