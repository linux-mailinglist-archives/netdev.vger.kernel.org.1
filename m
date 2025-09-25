Return-Path: <netdev+bounces-226441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC719BA06AC
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83078173197
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2B53019B9;
	Thu, 25 Sep 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClfXzqC6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3F502BE
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815199; cv=none; b=XwxZoW5L0EZUEGlmIuZ1N+g17WQwKaf0Nmv2kZicg8tlO+58W/WJdDwtxhw09LtoD3KtKCvKpuR5WfHQbgEJvFxLiuJgH1/lDbKg8kxWyiIKFtnnAt1oUMsCujRdCicmVPShhGUknQEQ8ROgOFWL7K1GTDNjyTDsgQ0WoMehx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815199; c=relaxed/simple;
	bh=5CJLjTtW546J8tpkufLvEmsJirZuPDW94Wu+LVkFf3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f9VXt07NLbjns0Ry5EkYX9hvJ08JHkIJOE02/m6Hrwocmi0ZVS8Rdr6nf8l8ev4n4mMm7ZZGVP/NXB3ivARWS+54/VSEyiFgd5KX/kXWohvii1U8MqlJyFdWD3/PoyJi5goIsXf51Sw1uX0qmAo/8CqgqiHyy62dqoRN0bCdkbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClfXzqC6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758815197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qxessgCFqOIjkxN8E3V+AacX2DwtplcyNFIAKPJSduY=;
	b=ClfXzqC6mJ6sG8IFk3EEoQ3Kck1umyIGSlwRetwurPqPwwhjRudKMFvDKBmBGzyzRrWnZe
	XBgKDOc6s2LiJLaCbgYI0gHM03abN4uQuMWIQekVcf3HrxXH9vSLfmbwW2sjFCfcJN8H1o
	aEuNKRCnk3yo7M0Zv7Go/rJwBoTZmHM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-PdbKRGbqO9yJeuhwe2AihQ-1; Thu, 25 Sep 2025 11:46:35 -0400
X-MC-Unique: PdbKRGbqO9yJeuhwe2AihQ-1
X-Mimecast-MFC-AGG-ID: PdbKRGbqO9yJeuhwe2AihQ_1758815194
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so705068f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 08:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758815194; x=1759419994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxessgCFqOIjkxN8E3V+AacX2DwtplcyNFIAKPJSduY=;
        b=ItcA6xPsjhLm/KlNL5rxSbd4CUKg/y5wrFH347As7iniG/7iCcX3I7pkYNtzaeYBQg
         bWjeDB3ftoJUuZmci5ZvvSL1rrtbd8shcfkuyW68elYooRJws2dxkDu1Ps0Hwg3gPV8b
         b+uDvfn+SLK2w2X0mnbGu3gPJeFzFwLv9YVHqGntyLkKjQfnMPUa6d5DSgnX97UtV0YG
         77zmwUA/uhfbGXkhZ5Y8idKn6P+8loOJbHXfMTnvJ9JjZPQXr3FkMS5TR3o/bGN82UFR
         L3EkDffFmvZeyMUD+DHjZxv26XwAOJ9YpF9YPTzx3y/VGMZNduot4z3nB93ATWnKRDpG
         cvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwrcQ5F9G4gAvuat90G2I7ACzBPRBaG/5tC2E9xP9M7xNkEv2EKmYHiC5nn12SiW37DcKIO1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CeQLzHohU5g72z3UEPKlTuaJKGiaWCBgWY1aZiTiveckywx6
	t0HV2jOA4P8Z5xx7KJlDOlcS4IAuARvhprAzU38Nnts7FFjJZ6yjnjtWWK2a6pm1bw1KUU2tk/q
	UIcc8RFV1v04/CyT4JG5qgGyhAHAY93csxYwKlTOExcPqFK2+gp/0IMt95Q==
X-Gm-Gg: ASbGncuX1JXQmxoIoCF8yEOLXh0BVWRXY8ndacFE5MOcsYueF3XwoEh2l+3QbXkdfNu
	8Mg+7vPb0UJH4+zoWmxmPj2kd+vbC93Uo9jAfJ1NqaoO4KDTqHGJ4eOIvxxl6ta6bMBFMnhv7M9
	36sqqqyyCg7NLD+tXfjlQ/+jTUteYdr1Kq4CE4s4PU5FyxOPmAM/cmknOC2DBV4/s10ZOfeEpjU
	Djr9aKq+nJnG0/RTdrE/kmG6koAlZHylcRNOPU82nWVnReEMCTNzJPpTBB9GqexMQN6oT2ms/SJ
	UFYrndZdg8uZsKYZzaHJ/J6zLldt+YGuHRyOjEaWOw6h2CCVvvFv76Ih3UIYpn39qbJp3PKs4So
	D9tcQNUB9LTn0
X-Received: by 2002:a05:6000:4305:b0:3ea:63d:44a8 with SMTP id ffacd0b85a97d-40f625fb96amr3794192f8f.15.1758815193835;
        Thu, 25 Sep 2025 08:46:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/k0nNfesW/BrVX/GL2okFEQbeth/drP6MINltdb5SEkxjqx61LbE6DaCG/45opkpod6jG0w==
X-Received: by 2002:a05:6000:4305:b0:3ea:63d:44a8 with SMTP id ffacd0b85a97d-40f625fb96amr3794161f8f.15.1758815193392;
        Thu, 25 Sep 2025 08:46:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602f15sm3410601f8f.39.2025.09.25.08.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 08:46:32 -0700 (PDT)
Message-ID: <b2a0cbdc-776a-42c8-8e19-051a12a1a7bc@redhat.com>
Date: Thu, 25 Sep 2025 17:46:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 13/14] tcp: accecn: stop sending AccECN opt
 when loss ACK w/ option
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
 "dsahern@kernel.org" <dsahern@kernel.org>,
 "kuniyu@amazon.com" <kuniyu@amazon.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "dave.taht@gmail.com" <dave.taht@gmail.com>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "ast@fiberby.net" <ast@fiberby.net>,
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
 <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@cablelabs.com" <g.white@cablelabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-14-chia-yu.chang@nokia-bell-labs.com>
 <03d6dba8-2586-4ae9-8a16-26b84cf206eb@redhat.com>
 <PAXPR07MB7984B98035A3D3A1570F4AF4A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <PAXPR07MB7984B98035A3D3A1570F4AF4A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 4:46 PM, Chia-Yu Chang (Nokia) wrote:
>From: Paolo Abeni <pabeni@redhat.com> Sent: Tuesday, September 23, 2025 12:52 PM
>> On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
>>> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>>>
>>> Detect spurious retransmission of a previously sent ACK carrying the 
>>> AccECN option after the second retransmission. Since this might be 
>>> caused by the middlebox dropping ACK with options it does not 
>>> recognize, disable the sending of the AccECN option in all subsequent 
>>> ACKs. This patch follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
>>
>> Is this really useful/triggers in practice?
>>
>> AFAICS it will take effect only it the retransmission happens just after an egress AccECN packet, i.e. will not trigger if the there are more later non AccECN packets pending.
> 
> Hi Paolo,
> 
> This is a simplied implementation than what is mentieond in the RFC9768: 
> "Such a host detect loss of ACKs carrying the AccECN Option by detecting whether the acknowledged data alwaysreappears as a retransmission. In such cases, the host disable the sending of the AccECN Option for this half-connection."
> 
> However, to implement the case that not that just after egressing the ACK with AccECN, I was thinking to modify struct tcp_sack_block but that maybe an over engineering.

I agree touching tcp_sack_block looks overkill. I think that the
simplified implementation is a bit too far from the RFC specification
and too simplistic to be effective. I suggest dropping this change.

Thanks,

Paolo


