Return-Path: <netdev+bounces-135587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEA199E487
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9141F23E08
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DEF1E4110;
	Tue, 15 Oct 2024 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwZHP7Y/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBB4683
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989481; cv=none; b=HcIymVGlva8FmPTGBLAx6riCnMfUua6I765hHeQLOc4cDZS/40A8Y2BPuWtosCs93E6i83nhh66Udts2fVfpV1FwEn5uKvW3XQ000A1g+FSIbpwrf7IzBZ+gBqNl5LHneuJH7pJfoV1oNVZBT0t9kfkNEX3qpF9GSG9O36ynXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989481; c=relaxed/simple;
	bh=OlSRe+v89BUVEzFTyw8ZODIjlKrNeb6AifaPvdYS1Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HumBkHyNcIGZ5qHRqTGpFcvkYX/kjPIzzdAtFrccL3iukIzM66/L4CFQD56haXOZnHYWTdCR7IQPyx6/L3z2opA6xR/zAnHnuGuf+DTHf76VfpOTD+eO9p85baMuEK5R7YKjYiG12axi98BKF1FdR6Q2Cb957nDsvdmE54KzgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwZHP7Y/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728989478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACwYefm6l2URot12EcphyQyGwsZDzRGyFtbx+GsFfYo=;
	b=dwZHP7Y/UrzjTrTKN0yY7AyIJTb9YXbYEtp7b0k1+yDk7E3q5WnJWGo70Rq0oU709SczK2
	CZuEO45R+1L8vsWm9LuOVOe3JpmmrGH2HBTAhfcipgccFNPmN/WElMH/zyEGOI84prKCj8
	mzSPrAr7jbl5dMDvydRW3xqiUIEU5fg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Npdi_-GrPeSemTpDB6Y41g-1; Tue, 15 Oct 2024 06:51:17 -0400
X-MC-Unique: Npdi_-GrPeSemTpDB6Y41g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43117b2a901so44267885e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 03:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989475; x=1729594275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACwYefm6l2URot12EcphyQyGwsZDzRGyFtbx+GsFfYo=;
        b=orOGORxd41uVatNAJCgBqDO2v4zHpk8lda6kaVt3dJ7tn4/Wbma6C3vjOmQStYhQou
         iaMGs4ahLnT0+WN0WRmpDzKkKbxcc6mojesoISXAIvhfzwU937u/bwW8P3/2UnpKuBx3
         jUq+4mtEhtXegvZvYY2dqxC6olDmbyfJxDyjGxgncm7ZKLEy9kDH+E2+vJCO0KEjwP7p
         hZLeugSZCnPg/gCoz91UC/8lIAQGkUjIJJKy9cq6yxj6CzPHNOMPljTc27TBcvxvCxAq
         0FX0cE+vKgR1UaVdVzS7FE4+inLh2LKBKvk66l9APwvfciXNVC70qLN23LeqfQBx9Lmw
         88Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXBgrf4DGmWUfn2Po26xKtuPRZ7768AlB4vGmST8KlHDdFwA2IhNzPF7GEm61yQNdhe+YsvOO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Z8yE7iJ7zkGkh7XFG5UjczwyJRiD6OqfqBvZNFiZnuxIZw1J
	U9F9dcGMH9RV4inV1dujtYsmqijmqbLP3LuiWUF4ZFr7zhxqkMpZWqHDsW17ZaBjnEHuGqXBwH1
	lKCFpALgB+FnaWhCC2VIcouB58hhNDE4ITlzjhtKgLQO4BGh3fiZKpI1S08QsvF4X
X-Received: by 2002:a05:600c:5251:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-43125607846mr127978865e9.23.1728989475170;
        Tue, 15 Oct 2024 03:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQsG9eFlpSFRtHVQa6oYNquUnAwW0xQdK+boCE3bIwFJUEd05YYAi4+xVVwrzWhiWMkiPsgw==
X-Received: by 2002:a05:600c:5251:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-43125607846mr127978665e9.23.1728989474795;
        Tue, 15 Oct 2024 03:51:14 -0700 (PDT)
Received: from [192.168.88.248] (146-241-22-245.dyn.eolo.it. [146.241.22.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f55e0b2sm14320075e9.4.2024.10.15.03.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:51:13 -0700 (PDT)
Message-ID: <dc3db616-1f97-4599-8a77-7c9022b7133c@redhat.com>
Date: Tue, 15 Oct 2024 12:51:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/44] DualPI2, Accurate ECN, TCP Prague patch
 series
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 12:28, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Please find the enclosed patch series covering the L4S (Low Latency,
> Low Loss, and Scalable Throughput) as outlined in IETF RFC9330:
> https://datatracker.ietf.org/doc/html/rfc9330
> 
> * 1 patch for DualPI2 (cf. IETF RFC9332
>    https://datatracker.ietf.org/doc/html/rfc9332)
> * 40 pataches for Accurate ECN (It implements the AccECN protocol
>    in terms of negotiation, feedback, and compliance requirements:
>    https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28)
> * 3 patches for TCP Prague (It implements the performance and safety
>    requirements listed in Appendix A of IETF RFC9331:
>    https://datatracker.ietf.org/doc/html/rfc9331)
> 
> Best regagrds,
> Chia-Yu

I haven't looked into the series yet, and I doubt I'll be able to do 
that anytime soon, but you must have a good read of the netdev process 
before any other action, specifically:

https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/process/maintainer-netdev.rst#L351

and

https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/process/maintainer-netdev.rst#L15

Just to be clear: splitting the series into 3 and posting all of them 
together will not be good either.

Thanks,

Paolo


