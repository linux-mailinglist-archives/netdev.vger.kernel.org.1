Return-Path: <netdev+bounces-139927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1679B4A55
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A31C20FA6
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B9205155;
	Tue, 29 Oct 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhWQpdXV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE6204F6C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206590; cv=none; b=CCfcPsRPgBkkEPYZWOElElasrOtUriuuoeoswgzwEWjnw4DvXPO7axtuztW6pYWwVLV8ZlhYCrXFkgNKJpaYCKwYETBJhiWs0ABz/6pX9LvDXVrqjFTQ8rEVUlL6ryFDfSs+TuRSAGRWqcfU9UU7t9nK/Ex2EBk26YueMhldzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206590; c=relaxed/simple;
	bh=0OOVuiAGPFNPuYGLfQqeV1TFTUWmFagEb+gsJZsrJbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1h2v0m2wQ6TlsjoI3UTFgRsDPtCd2Pjlei+15KVX8/FXWLKQaebluz3kjeVncl1hd1sjtQH7KSNPuFBvKrs0LjSRNsWf/iyYdwkUJLVUsMHf2DJH4bml6Xs/26c9lzy3o3sQtPxjLH00KsYGAsRG/cIdAN/sG0v/YiFBWPR10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhWQpdXV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730206587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwBuZrWpwO3hbyJFaAKbeHfqr9bp8kmrlxzsLsjLY4k=;
	b=FhWQpdXVGVlrjQROcEjkG0vGaFdTk9RjetaQFQzllF6D2lH2479v3Qb0NhRKEdMlTE1Bhc
	Fde0+mMNeuQWYCWgWWo380+CUIapBiJEPJNukg/RffrEP8fBhiR3WFjf9If4KNa4x8XOpo
	hZNgRGZXn9i/c39WXQZaPMfNQCf5btg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-21xXuhTMOT2O_t3yMKw9Zg-1; Tue, 29 Oct 2024 08:56:26 -0400
X-MC-Unique: 21xXuhTMOT2O_t3yMKw9Zg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d432f9f5eso2941261f8f.0
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206585; x=1730811385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwBuZrWpwO3hbyJFaAKbeHfqr9bp8kmrlxzsLsjLY4k=;
        b=E8JN/Fn5Ti0UEBAdbaZVLC3VHZY6238QFWjvEqYhg9ULyVboYQ5/SOpxEax7nLTD/C
         pimeRhWkYZbVqrYT+7YfQzsIOuLod9vod2RE6SDMA5aF0vTsQ6n2aHwZQKlKX4v7/4oW
         ZYU3F0Z/KAJ+knnosbrUjKfhYZhEImOyNx84jOmJ7h58vZ2KTthOjSLH8oTM09KA7dj3
         su+WdNX1DDN71CKEoibU3bpZ9kQA30sRRlfIYZAHhRXvDkCwCrv3noql2BYBO9lDSc88
         kapSjhrdHoYX7eL7tteqhRJ6jSMVF9FwF0NaTDNknY8Vspwkp8/2xSyp5Y9p98jFJgbt
         qKTA==
X-Forwarded-Encrypted: i=1; AJvYcCW2c1XVVSLZ3Pd5WZolSRftQlhBGHvV1zOVLRhh9u+yrH5p+76/C19MzeDwLQM/kQDdEM3VL2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYxXfuXnogoC9IlILftZ510t+x4WI/3OET4a9Kr4o6+ZiFaLB
	Jz2+Qr5jpyCh0t2v+oaOcq7dD1UkA7v6U+5+RSvD1c6M2xEeIuLdOyphv7BVotmxdyZdlmv9FYq
	kbYs5gKTTx8HFW0biM5blZelADRAGsZIKUAwJ7crax10kciWk498X7Q==
X-Received: by 2002:adf:f846:0:b0:37d:3a6f:80cf with SMTP id ffacd0b85a97d-380610e6b88mr9312632f8f.6.1730206585106;
        Tue, 29 Oct 2024 05:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2cQXOKwVF0ZGdg8232x0pjMi50CoCeN2294BBrK62xFV3GtiJtgus42LG/H38ZYS3K2Z/nw==
X-Received: by 2002:adf:f846:0:b0:37d:3a6f:80cf with SMTP id ffacd0b85a97d-380610e6b88mr9312609f8f.6.1730206584729;
        Tue, 29 Oct 2024 05:56:24 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb433bsm12391884f8f.112.2024.10.29.05.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:56:24 -0700 (PDT)
Message-ID: <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com>
Date: Tue, 29 Oct 2024 13:56:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 davem@davemloft.net, stephen@networkplumber.org, jhs@mojatatu.com,
 edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olga Albisser <olga@albisser.org>,
 Olivier Tilmans <olivier.tilmans@nokia.com>,
 Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 00:12, chia-yu.chang@nokia-bell-labs.com wrote:
> +/* Default alpha/beta values give a 10dB stability margin with max_rtt=100ms. */
> +static void dualpi2_reset_default(struct dualpi2_sched_data *q)
> +{
> +	q->sch->limit = 10000;				/* Max 125ms at 1Gbps */
> +
> +	q->pi2.target = 15 * NSEC_PER_MSEC;
> +	q->pi2.tupdate = 16 * NSEC_PER_MSEC;
> +	q->pi2.alpha = dualpi2_scale_alpha_beta(41);	/* ~0.16 Hz * 256 */
> +	q->pi2.beta = dualpi2_scale_alpha_beta(819);	/* ~3.20 Hz * 256 */
> +
> +	q->step.thresh = 1 * NSEC_PER_MSEC;
> +	q->step.in_packets = false;
> +
> +	dualpi2_calculate_c_protection(q->sch, q, 10);	/* wc=10%, wl=90% */
> +
> +	q->ecn_mask = INET_ECN_ECT_1;
> +	q->coupling_factor = 2;		/* window fairness for equal RTTs */
> +	q->drop_overload = true;	/* Preserve latency by dropping */
> +	q->drop_early = false;		/* PI2 drops on dequeue */
> +	q->split_gso = true;

This is a very unexpected default. Splitting GSO packets earlier WRT the
H/W constaints definitely impact performances in a bad way.

Under which condition this is expected to give better results?
It should be at least documented clearly.

Thanks,

Paolo


