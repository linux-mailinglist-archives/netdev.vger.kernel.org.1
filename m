Return-Path: <netdev+bounces-184619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6E5A96729
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC343BA990
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971D27BF99;
	Tue, 22 Apr 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYWRSjHD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B405F27BF8A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320890; cv=none; b=mtWE+9oaqRjfG7mOJMUnmbU2AvMk6zKw0ETP4BptoWREfWhKbnsqLjrkDVAvGdgYD4R5W6M6F8NxXfarvNfQyuBowlgARS2r2iCpH1E47TMHjSkGto/pFHypuZfqe8/KulEYrHyPJvR0VMJdBF5U8M2BDGMsZZBXFYcz/1M+oos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320890; c=relaxed/simple;
	bh=LOHUJaOBu9fx92MvTl3OOu94QQjgc2MlHsiOjpTPGLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYZl440gqtgcjvsnXTwLeseg5uZ7sjrKyHO6JuKUp8Ay08jsMdR7UCaoeFh42cg0+z/h2mClws5lbAp8R76bkmAnj/vAtWV3BCZhVo8qaWfrFdkXItA60t0y4WOq098K171n3FoZy6hlCukq+04T44yT34s/WtwcYuHS6IAwHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYWRSjHD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745320887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKG0eL38cZu3bVSx5kxtTnZXXnfWIcWYJQcyLj2ESXI=;
	b=YYWRSjHDWfPRu3CU0+6aErQJ1k2D4++AtKJQncYDvnWJqrtKRrQkSXqRg9D33JPMlFeWBl
	CNLqXO3QgknwvbFZUZjnt5BGE3CSNKXz9FSV3rledyNstRe+NWDZ99/BYZwxqz62aUQO8M
	L6KwTRjS1TcrP4pieQZdyTEo8nWEN2Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ApzMoHhTOkKw5mY-5L5PTA-1; Tue, 22 Apr 2025 07:21:25 -0400
X-MC-Unique: ApzMoHhTOkKw5mY-5L5PTA-1
X-Mimecast-MFC-AGG-ID: ApzMoHhTOkKw5mY-5L5PTA_1745320884
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so38148795e9.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 04:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320884; x=1745925684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKG0eL38cZu3bVSx5kxtTnZXXnfWIcWYJQcyLj2ESXI=;
        b=kGgwRRGgHC02+oqknrwuHZrgUqnP6JeyIF31JiOZZq4dg5j/IekjeWhOlDnZJA1EUu
         hmxjPz2dSI7sR7R/H1l0Hx/11EI7xUEviM+1kbSEDcBENRnjwkLoIo5ccJd9vHT2WUJ7
         gD9jgBFgj3uVt2Zmf+gGmVu4fj6ocbE2Ja74gWEYxe/mbtNysf+SlkUBRG/cGhX139xk
         7eGeyOsPbrl7AimxXjMr7QUSSOxcMF/rYulG+svt/axhPiWq2YkbakQxro/Hthfrmjh9
         XUQ5ARNNXe8EzB9yGcqP80NUYXX6Fu5Ts5hZPP2s+4UXnYd+j9J6IPRBY2bPtL1iI1a5
         xUbw==
X-Gm-Message-State: AOJu0Ywk82iHtMXssgy0GTNYihT0MWLRdVnlD561C1Q6RQHeNJIMGoNK
	IVgMgJZTHZZENSjnJd/ffhey8xIWMhey7J2tg+pkfM4GIyTpRCwzY3MP3jkl/O7vFb3HubnqwaC
	g7aUuQOgoiAcQlF4d14ovgb6gjShOAl03uRe3Qa8Y9vozTheKNfZlRg==
X-Gm-Gg: ASbGncugne8IqaAwLvxW5AkLviaNn2UkFXkKPHEAFdF6eovtajeH3WzSp0SIvaAp0Nz
	gt5sXvrB07zIsoJWPoGCvLupzu1ZQdXypHmmllrm1FdKGaEUnGZJNArh987omVc7J48WWAuMwMJ
	leC5PdpNJeeykO75ByHvGodsezsHbvgrizYWBge22m1E5BJ8udC9lEIeFY3Pj2uoeySR+O/BeLt
	qp1J3uzK5J4wV9Fi5KHOIAX8cHa98ZTJhQ/TCOPz+L4oC66rYlTQu8CfwQbctrng7v3ryc8H/8Y
	9CZ+ZB/sHbO23YLiqR+wmMAKHxtuDy8hCDt4
X-Received: by 2002:a05:600c:a03:b0:43d:fa59:a685 with SMTP id 5b1f17b1804b1-4406ac1fd14mr119514245e9.33.1745320884457;
        Tue, 22 Apr 2025 04:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGplotxDPB920nypCKNl9i/KI8zpbcKRLisikZGQ0MYpm1TgB1xlMfm36zbOlraGnWr5iKrJQ==
X-Received: by 2002:a05:600c:a03:b0:43d:fa59:a685 with SMTP id 5b1f17b1804b1-4406ac1fd14mr119514055e9.33.1745320884127;
        Tue, 22 Apr 2025 04:21:24 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d7a3dsm167207845e9.38.2025.04.22.04.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:21:23 -0700 (PDT)
Message-ID: <4295ec79-035c-4858-9ec4-eb639767d12b@redhat.com>
Date: Tue, 22 Apr 2025 13:21:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
To: Cong Wang <xiyou.wangcong@gmail.com>,
 Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, toke@redhat.com,
 gerrard.tai@starlabs.sg, pctammela@mojatatu.com
References: <20250416102427.3219655-1-victor@mojatatu.com>
 <aAFVHqypw/snAOwu@pop-os.localdomain>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aAFVHqypw/snAOwu@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 9:23 PM, Cong Wang wrote:
> On Wed, Apr 16, 2025 at 07:24:22AM -0300, Victor Nogueira wrote:
>> As described in Gerrard's report [1], there are cases where netem can
>> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
>> qfq) break whenever the enqueue callback has reentrant behaviour.
>> This series addresses these issues by adding extra checks that cater for
>> these reentrant corner cases. This series has passed all relevant test
>> cases in the TDC suite.
>>
>> [1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/
>>
> 
> I am wondering why we need to enqueue the duplicate skb before enqueuing
> the original skb in netem? IOW, why not just swap them?

It's not clear to me what you are suggesting, could you please rephrase
and/or expand the above?

When duplication packets, I think we will need to call root->enqueue()
no matter what, to ensure proper accounting, and that would cause the
re-entrancy issue. What I'm missing?

Thanks,

Paolo


