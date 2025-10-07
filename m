Return-Path: <netdev+bounces-228084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E00BC10B4
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 12:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E62194E28AB
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBD514658D;
	Tue,  7 Oct 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAPjYPgN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731C2D73A7
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759833970; cv=none; b=J3dA8zd9jvAjratQDqkLukj9Z+iedyDVUurjsDxnAvlgNmPhbJew9V85G1AY8VhVcMWcPKPKjWtOfO3odI2neFApug0AU0x8yQfVsLE2UWMOR9uJe0Ff3vXzoOJUBSFbtVDSmJGd/3xbEq+3q8PjJ2CehqTUgJ05XUqgiH90Xl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759833970; c=relaxed/simple;
	bh=Y0k0amP3nuDhEI8J1gHNZ81t5g8iY/ZgH1kXTCtwBZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cC6xXoIe4T+p/Qu/JKygLo/qp2698SgJ5+o/jsepj7jEbwu6qDYUK9KZCuz3Z2WT93wHR/s/ESu19t+t1IMA+Vw6JctuCS4XG6KF4GZ12EnmNs3wMKbtM3xgbcDIS/pCFfLcldc8jI0De31z0d71kk4ikUtabrLm+ARjtjCZGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAPjYPgN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759833967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9VU+jqnwVitkeTtQ8eX0acgMofsePeWo2o0ZHkAt40=;
	b=BAPjYPgN0a8/PRPuV3UZs7xyiODJrlCx2Y1JlZq1pUoW+gc6lpkk7WFjUf4e7AV9Ufpgt9
	zc0qIUvmQfdMQbYTqsdJTlq2NRFkMvqY128m9tlTnDhjQu/Y1Y6oZP3vsCPMPsQcFK0crO
	5ZQYyVMs7GWMcwZ8eEBIfKSOrDdS1No=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-hxNlty9JNt-Yg-GAiiZwFA-1; Tue, 07 Oct 2025 06:46:05 -0400
X-MC-Unique: hxNlty9JNt-Yg-GAiiZwFA-1
X-Mimecast-MFC-AGG-ID: hxNlty9JNt-Yg-GAiiZwFA_1759833964
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ee1365964cso4609404f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 03:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759833964; x=1760438764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9VU+jqnwVitkeTtQ8eX0acgMofsePeWo2o0ZHkAt40=;
        b=pJSp7nU4DXd3zB5nXJA6yxOoRtpqlSMaEhFCUaGFxHfKSBaqNHTKauB4ZkncFE3fT4
         nGzUQKngNBfpIwd0pdrONKfLxIqk7vtC/x7bPZtuueYTvToawf17D0+fwtAh2QQsa2Cr
         J4DYMVrCfOoRxrabqLv8wqc1BJhlg7U5Bwc/xq1vieD6hx3KTseSMO2OMHa/LppgI9Zb
         QmRkkXTs0dFvUM93FgnTzNLIGowyl5PIWQy+HK7Ah4dk+6wzaEpXrYXnesmj1mTiuOdk
         kNBjzgZQvxpTyb+VHSD6sBZHq5IZrT04Cd/7uahiLWrjZ4A62AkalCb9vK47Twt8hL9h
         M7fA==
X-Forwarded-Encrypted: i=1; AJvYcCV0EDlocsyQnBYvUS0glx38K68f1thoIJsr+gpDUtsB/NLjybhDQVqFLckZZeo6hgfDHAzR9XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzxRYaN0c62u3AE0er2EsAuQrBSgWvVAXOW58Zxfhi1HkZ/sQ
	Z8yz7/7YTYTIoKjjdfAApuwX7I+2kn2JjvqbeDiHteWpSFhfsnWPDrQ5pSavQAw2MxD695tyc8b
	con0jCu0gifrf6RsYYJoA/sIEwgyHuefjMLcePEjmYSGQkNI0BZXRhHu5lQ==
X-Gm-Gg: ASbGnctEsiqVZEgq/J2p3Mxq1/uJTgJPYiwfTyQ7rdVmD2+rP1MIMhjz1S0WwxbtWIm
	BphuOO7pPg04YkLIGnUOmaMxSzFu8QrvNwe7E8iLVhEwCEGSvRXdgn8FqOJN0cnEWz12U2FbnGJ
	SLdoRYyN2mkGgMJWdKhI1X4FJJENTzWzhtrPDb//Ku1ZkCcmpuupA8xP8lR1RLkGf7Kmc8/F5Nm
	NuKh420iOR4ugOcnPAmr6vDWPlI+HBlzE2BGJAnva9LkpAz79JsKCZQ2zZBzHzTi3AysIJND46C
	K3mJZ4XEX+LuoyCceJdN+MAFQEs2nz6a6ioU6/Q+fYED8r46Q1V/MUpOg8aVvT2SimW0tLPcnHl
	8NFQypR+tVZvn9rTB8w==
X-Received: by 2002:a05:6000:22ca:b0:425:8462:b72e with SMTP id ffacd0b85a97d-4258462bbfdmr1377566f8f.3.1759833964469;
        Tue, 07 Oct 2025 03:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBvJuFM0sqIDpEJ2XvBbC5K5crNEII49Po+HSOIfY3+6fboEgfBtuEHBtoVUPTDo55dxcAXg==
X-Received: by 2002:a05:6000:22ca:b0:425:8462:b72e with SMTP id ffacd0b85a97d-4258462bbfdmr1377552f8f.3.1759833964096;
        Tue, 07 Oct 2025 03:46:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a0204fsm301706355e9.14.2025.10.07.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:46:03 -0700 (PDT)
Message-ID: <71dda358-c1f7-46ab-a241-dffc3c1c065d@redhat.com>
Date: Tue, 7 Oct 2025 12:46:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>, khc@pm.waw.pl,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
 <m3o6qotrxi.fsf@t19.piap.pl>
 <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
 <d8fb2384-66bb-473a-a020-1bd816b5766c@redhat.com>
 <m37bx7t604.fsf@t19.piap.pl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <m37bx7t604.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/7/25 11:28 AM, Krzysztof Hałasa wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>> If v2 is not ready yet, I think it would be better returning "unknown"
>> instead of "LCP" when the protocol id is actually unknown.
>>
>> In the current code base, such case is unexpected/impossible, but the
>> compiler force us to handle it anyway. I think we should avoid hiding
>> the unexpected event.
>>
>> Assuming all the code paths calling proto_name() ensure the pid is a
>> valid one, you should possibly add a WARN_ONCE() on the default case.
> 
> Look, this is really simple code. Do we need additional bloat
> everywhere?
> 
> The compiler doesn't force us to anything. We define that, as far as
> get_proto() is concerned, PID_IPCP is "IPCP", PID_IPV6CP is "IPV6CP",
> and all other values mean "LCP". Then we construct the switch statement
> accordingly. Well, it seems I failed it slightly originally, most
> probably due to copy & paste from get_proto(). Now Kriish has noticed it
> and agreed to make it perfect.
> 
> Do you really think we should now change semantics of this 20 years old
> code (most probably never working incorrectly), adding some "unknown"
> (yet impossible) case, and WARNing about a condition which is excluded
> at the start of the whole RX parser?

Note that the suggested change is not going to change any semantic, just
make it clear for future changes that such case is not really expected.

And that in turn is my point. If someone else is going to touch this
code in the (not so near) future, such person will not have to read all
the possible code paths leading to proto_name() to understand the
assumption in the current code base.

Cheers,

Paolo


