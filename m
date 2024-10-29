Return-Path: <netdev+bounces-139989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC609B4EE9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 17:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B806D1F23EE7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860C219754D;
	Tue, 29 Oct 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W47gBuWN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87A197548
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218127; cv=none; b=mLoaWWRMKhnLp0N6SpDzqjXgQ1QkJbOrq6s6ugR0HgIWyUUzqNfI39BOEj4GWMZMd/pGIWxMVhp4fs+LA5VBBcnMVcjLEVF83za2Pfhg6Xv3VlbCMZpJ3Tri46dZDxgfGv0atQKG6PiKH4FlYjPHiStEIQZlxkTl9Kf9DWCTzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218127; c=relaxed/simple;
	bh=MPGLQmU7ZNOTO/y7xL1NDWdPdu/tiTBCqMXBADbFQjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZw8aKnlc9PxZEwzIwH6rogXSsV7Ehr7FsHhR5XmjIhkZ+QPrpzEBdyn9dWRBbKbOeXPsWidviQjGgIWjsAFD7yapVEYHh15oZXnFTNbnbGk9ftG2AE5A3h9FrqBHU7MfurKuz5sxW8Kj9em0nxArvHWJ1IAl80mqJ61KLVgUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W47gBuWN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730218124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXJyHIdY6X+h5a1LLOKuO+CDIKrfF1fFzq6g/lUf9fk=;
	b=W47gBuWN+G47j2PM49Acjjv4gtwQGOnMk+NBQfJWdhqfSzl41ukYnJhPbV3eGugic/WxvE
	6wOOngHsljDAE9JcvaUij6Hmsfjb/itu/wEAWi3iXfOPJDuAY3rQk/Nl4u6duW5wDgnuCB
	Q9ZGVlT+8F0R6vOwm6HlQPvVRGfaYco=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-JpTgQbRkMCGXAJNiRVGr2A-1; Tue, 29 Oct 2024 12:08:42 -0400
X-MC-Unique: JpTgQbRkMCGXAJNiRVGr2A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315a0f25afso42743295e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 09:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218121; x=1730822921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXJyHIdY6X+h5a1LLOKuO+CDIKrfF1fFzq6g/lUf9fk=;
        b=sVwY/0Odh7EhkGRHzY89qH23dANmv0X75mvRtJseqfDW5mkOX+56vo3ij1HwgIIpk0
         Z3eUu/bW+Ui9Ah5EBwsW7NmGh56LuxM1zjm8U+EpzXbw8QceNvMOFktpnkbBQymgQVLM
         lC11jLrBEVKaVP9EbLQGSsK8zmxy9lNMdrBsb1X2MjAPhmzCdPVCUd+WvFF0kkOwQ9jY
         oPAnxPRHOHCmHy1uARlbR3omNGRJrRw0qTTBKMbbm7Fpyo9gVTItbQE7k8XDsls5s9bp
         2NX9OySgxYZqg0t41RUbsQF/Ec9kSelvfrZ8ck0ogL8XMwnDfWbDBDR0C04zf9lAcgE6
         /sSA==
X-Forwarded-Encrypted: i=1; AJvYcCUpJez49aueO5kIB/8zcy5FNldyqmZDKB5Cc05zCYmyCjww42h3uNP0kpohgExPLFMgaiQpFnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEyZoCWR90hU9TwNAkNKJ6YBdsUqiGAF1KEwxdxIEfrkvnal4
	47qNnSh0QEv1zAZCqlBYvu0pmUbP8130iwWbGyRaXN7wKedcZcgOOoNU95UxSmgHYMAeEzVF2Cr
	0uEtQTEnw/XlA8KfPb+deLPPKcbCKE6yThgjboxkCCJ4MVP2poYvb9Q==
X-Received: by 2002:a05:600c:281:b0:431:3933:1d30 with SMTP id 5b1f17b1804b1-431a0c3b8f4mr85208965e9.5.1730218121371;
        Tue, 29 Oct 2024 09:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfeE9Z+RT5tSkSf5gQ3OsW/sxEyaXehhEVNxFF6wcPRrVmyqrhdc5tp47VVK89gE1zvuR1Iw==
X-Received: by 2002:a05:600c:281:b0:431:3933:1d30 with SMTP id 5b1f17b1804b1-431a0c3b8f4mr85208605e9.5.1730218120813;
        Tue, 29 Oct 2024 09:08:40 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b58b7e8sm182571125e9.48.2024.10.29.09.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:08:40 -0700 (PDT)
Message-ID: <1201dfde-c552-4f61-b2bd-b3415eb7b4ed@redhat.com>
Date: Tue, 29 Oct 2024 17:08:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "dsahern@kernel.org"
 <dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
 "g.white@CableLabs.com" <g.white@CableLabs.com>,
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
 "cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at"
 <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
 <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Cc: Olga Albisser <olga@albisser.org>,
 "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>,
 Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
 <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com>
 <AM9PR07MB7969E939CA6C563F9A4061B4A34B2@AM9PR07MB7969.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <AM9PR07MB7969E939CA6C563F9A4061B4A34B2@AM9PR07MB7969.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 16:27, Chia-Yu Chang (Nokia) wrote:
> On Tuesday, October 29, 2024 1:56 PM Paolo Abeni <pabeni@redhat.com>  wrote:
>> On 10/22/24 00:12, chia-yu.chang@nokia-bell-labs.com wrote:
>>> +/* Default alpha/beta values give a 10dB stability margin with 
>>> +max_rtt=100ms. */ static void dualpi2_reset_default(struct 
>>> +dualpi2_sched_data *q) {
>>> +     q->sch->limit = 10000;                          /* Max 125ms at 1Gbps */
>>> +
>>> +     q->pi2.target = 15 * NSEC_PER_MSEC;
>>> +     q->pi2.tupdate = 16 * NSEC_PER_MSEC;
>>> +     q->pi2.alpha = dualpi2_scale_alpha_beta(41);    /* ~0.16 Hz * 256 */
>>> +     q->pi2.beta = dualpi2_scale_alpha_beta(819);    /* ~3.20 Hz * 256 */
>>> +
>>> +     q->step.thresh = 1 * NSEC_PER_MSEC;
>>> +     q->step.in_packets = false;
>>> +
>>> +     dualpi2_calculate_c_protection(q->sch, q, 10);  /* wc=10%, 
>>> + wl=90% */
>>> +
>>> +     q->ecn_mask = INET_ECN_ECT_1;
>>> +     q->coupling_factor = 2;         /* window fairness for equal RTTs */
>>> +     q->drop_overload = true;        /* Preserve latency by dropping */
>>> +     q->drop_early = false;          /* PI2 drops on dequeue */
>>> +     q->split_gso = true;
> 
>> This is a very unexpected default. Splitting GSO packets earlier WRT the H/W constaints definitely impact performances in a bad way.
> 
>> Under which condition this is expected to give better results?
>> It should be at least documented clearly.
> 
> I see a similar operation exists in other qdisc (e.g., sch_tbf.c and sch_cake). They both walk through segs of skb_list.
> Instead, I see other qdisc use "skb_list_walk_safe" macro, so I was thinking to follow a similar approach in dualpi2 (or other comments please let me know).
> Or do you suggest we should force gso-splitting like in other qdisc?

The main point is not traversing an skb list, but the segmentation this
scheduler performs by default. Note that the sch_tbf case is slightly
different, as it segments skbs as a last resort to avoid dropping
packets exceeding the burst limit.
You should provide some more wording or test showing when and how such
splitting is advantageous - i.e. as done in the cake scheduler in commit
2db6dc2662bab14e59517ab4b86a164cc4d2db42.

The reason for the above is that performing unneeded S/W segmentation
is, generally speaking, a huge loss.

Thanks,

Paolo


