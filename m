Return-Path: <netdev+bounces-146230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEA59D2550
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD031F21DA1
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC2E1CC16D;
	Tue, 19 Nov 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiN8h2Gg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3AF1CC15F
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018254; cv=none; b=BuVV6FMDIV71qTSwcNxG97cSMoFBctRLDJVP4bIkkPc9g/EZmOaEtIYdrZ6UYZzryFkM1il0lOpZc+BPRHkFd+bdh50MQGz5f1pVN/lRO+XE8NK/kEqf6lvIFX9TayarncuHqoE61IDHhvj5zQMjC049/KH9W3fTMvzXyM/ry08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018254; c=relaxed/simple;
	bh=97z/Gm5W0YgwUVmW3w2UjsTwCfbwhF0j4B51gnvW3mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL3NNYnzsd9AgphWgCPiVXiHVwQH7/ddZVdnyGjmgQjKt0LBAc2DN6cNREvSWVXGg3hCWglmERqSv1FRshwpV0PwYgMVa+VM8JrEOLNecgq3577DuaAUkKITn7v4zA12U/sQ/xqNlZfiCrkWrsimuzmw5W0beUDsfjpXV6LkUKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiN8h2Gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732018252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V19Ya12INaruja5xgKtoM9S+Eb1KuycGcgEePA62pRM=;
	b=KiN8h2Gg0+LeXfaqO+TEnM+s2kSABoRiOlRBNECPR8n/bzY4oiraZ2buGKRoGDanDhPVN/
	QTG9vdmZz0vjvWsQW1wcx2onIN4m/r70zvANxmGW8N0KM0ElpsTonRlskmpuTSLgdC2Xfl
	e2ztBIAOMSraPCvkgUylKCq47LSwol0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-czq0Sra0PZyDna6wZx5QSQ-1; Tue, 19 Nov 2024 07:10:50 -0500
X-MC-Unique: czq0Sra0PZyDna6wZx5QSQ-1
X-Mimecast-MFC-AGG-ID: czq0Sra0PZyDna6wZx5QSQ
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b15a8e9ff1so120493085a.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 04:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732018249; x=1732623049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V19Ya12INaruja5xgKtoM9S+Eb1KuycGcgEePA62pRM=;
        b=AaNnHXQo9TFxDf0GHp8f0jHnzdTfNTe1sCMxQyZjStcFzT93ZL/id5QV/o2ftWJp+q
         35E9GByDkc1mB3R17v2F3V2ZVRTFUDdMWyLSIJf7wLFRCBRKLIVKrp9JDL7yBiO7rVbM
         U0AT4ax0qQiDZhgwTBONl1YTEPeQLte2L4SIZ32ILYl/qc49HixwjQLpU8rc83uAM6lq
         xlXKWug7+rXUf7StTfwdEW9eW/X2SMd0tpOrWdPPXAeSCBd+/ia+ubPwQsYN0ns9V5P7
         Ofn7e8B0GaQjDyDQTeGE9KUPJL/T2HcN4A8NHxv+6Odq+UNhBOSYgn+Qnhzax65CsY/w
         d2zw==
X-Forwarded-Encrypted: i=1; AJvYcCULS7bZrDdKwkDSlv7rHHs+l0lFzd7fDgakvInrwP8fNfHpbKiIoKu6PeWxN4iJX2KXX1WcyGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwkvXCau+w3XTgCkgov461NgUa6dmwZkwh6IbMwvkZg+d9SVzH
	sixk4aL5AH/5uyEtHZHyUqHd9gyC4U2CAf5KnPt/7TZdjZqVtZzjROgySvoZb5e2BTyueDtCV9L
	gSxiz/i7yQAu8SvVn4PsF0w6L4+vjMHoBNL5TZKE04MyXWJd3Zdtfrg==
X-Received: by 2002:a05:620a:4542:b0:7b1:171a:5abf with SMTP id af79cd13be357-7b362313b03mr1883691185a.45.1732018249603;
        Tue, 19 Nov 2024 04:10:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMbtjHKgFac/5mFPP3oc8kjaqVAGlVb6Gdr68/K9F9bV4eFsZzOvSXddCUV6uPiYTI1loHww==
X-Received: by 2002:a05:620a:4542:b0:7b1:171a:5abf with SMTP id af79cd13be357-7b362313b03mr1883689485a.45.1732018249275;
        Tue, 19 Nov 2024 04:10:49 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a866159sm86471585a.67.2024.11.19.04.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 04:10:48 -0800 (PST)
Message-ID: <1a4af543-d217-4bc4-b411-a0ab84a31dda@redhat.com>
Date: Tue, 19 Nov 2024 13:10:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v2] netlink: add IGMP/MLD join/leave
 notifications
To: Yuyang Huang <yuyanghuang@google.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, nicolas.dichtel@6wind.com,
 andrew@lunn.ch, netdev@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>,
 Patrick Ruddy <pruddy@vyatta.att-mail.com>
References: <20241117141137.2072899-1-yuyanghuang@google.com>
 <ZzxAqq-TqLts1o4V@fedora>
 <CADXeF1GEzTO4BuVnci0Vvorah+vCcrTZR9EE3ohQrN_TKnfL0A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADXeF1GEzTO4BuVnci0Vvorah+vCcrTZR9EE3ohQrN_TKnfL0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 10:21, Yuyang Huang wrote:
>> Why the IPv4 scope use RT_SCOPE_LINK,
> 
> I'm unsure if I'm setting the IPv4 rt scope correctly.
> 
> I read the following document for rtm_scope:
> 
> ```
> /* rtm_scope
> 
>    Really it is not scope, but sort of distance to the destination.
>    NOWHERE are reserved for not existing destinations, HOST is our
>    local addresses, LINK are destinations, located on directly attached
>    link and UNIVERSE is everywhere in the Universe.
> 
>    Intermediate values are also possible f.e. interior routes
>    could be assigned a value between UNIVERSE and LINK.
> */
> ```

I think the most important thing is consistency. This patch is
inconsistent WRT rtm_scope among ipv4 and ipv6, you should ensure
similar behavior among them.

Existing ip-related notification always use RT_SCOPE_UNIVERSE with the
rater suspect exception of mctp. Possibly using RT_SCOPE_UNIVERSE here
too could be fitting.

/P


