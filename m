Return-Path: <netdev+bounces-200595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0DAE634D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5644117976D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670BB28641D;
	Tue, 24 Jun 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLfCm+Ar"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE79221F17
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763348; cv=none; b=uh0gworYypJcj88xVMhnzYfIxNCSO/YCE9skeHEuWBB/XzdBrBMly6MEtm4ZUk36MmHIqCoa17pZPJPTk67JapO9sBanWSQhVi/3SWizLpB16eE2lcA5koHvOZ+afjsqJIe6Yzu52R9dCknujAWUlamzQmFMVa0A3pm29vb56iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763348; c=relaxed/simple;
	bh=xk0K8Y9GNGQRlSmr9+j3AdvLKGa1tXM70MIgWys7z68=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QoN/cpo4ADR5idKw5TeNiktxdAJ9MvDHwuTod2Sy6go2oL9NCD3Li8GkfZA2cFzUsIkcVKcKPpIfr9EARF3h/bHBUY81MRyoaRQY4bLdsbTqtVfGqVVNhaxPKZSAU0LR/Qm20bySVH3wO9DMkoNqyxKDO4F4WfiGFEIQ/YdF1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLfCm+Ar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750763345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGyqpb2hXEKZ5FRzXkAxKuJIK/tLYcR4CdnvTMOm+wA=;
	b=dLfCm+Ar8iMwukT5sqoB4nY24vznzAVJicYQDDC5mVx9kLZGGfc+f6GTyYDlbZOK1+VIUZ
	nsVim8dDp3SuD8A1eX4KcYMMH2f5Ad2tXZTL6y93XnO8HF2e74/8APc0EXZtNmxuCLeq4Q
	kpZOqBDl0vVuKKnDYIxUXrWlmjdRv9k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-P25TdUWxOGOj82Fz8qzHEg-1; Tue, 24 Jun 2025 07:09:04 -0400
X-MC-Unique: P25TdUWxOGOj82Fz8qzHEg-1
X-Mimecast-MFC-AGG-ID: P25TdUWxOGOj82Fz8qzHEg_1750763343
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-453018b4ddeso2518385e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750763343; x=1751368143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGyqpb2hXEKZ5FRzXkAxKuJIK/tLYcR4CdnvTMOm+wA=;
        b=P103Hzok8kB60yCJa9e/7qvxmXUfmua5lglTtvXM6tDILjepdfE1HS7Qz5b1wFoUdH
         qxnnJFfQFZ5y/hD+JDtxcRok2qcJgqoyZ9rTCx6/5TW//arXbcz70SS2luNwYzhz6KGS
         yzxLvElaoXJNRUFsKuT9gnI+uAUMi+9KU79QvldNVNor9laWc3wrq2gwR8yZLkYQk349
         7boZIqoUOA8TmKPZR/+dc09cEenjfoeqVFhqCpCei+tqNv4bDsy2ssuqbi0H5EAWegiq
         p8JkCqe7Gx05Z8DxO3JLcBvja5Gb1DhrV05NwccEa85K2RZ+d5P4NfvsmFVLZPCEpeSW
         HErQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6x/0h1gaVd3ndEGVGyK1TNcgunY2iuYU92axJOc7qu2vaQmP5Q6wzUP2QplJv906bunaAGvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ORx3SR5mNaj9ojXHa71U/vPoufXeuj5eaX+8pn4FgCfxTpIb
	84Rylzacg5cK2gf9+s4BY7RphFe6oDXNx052vBjI4w+8xEjmdZPID1m884epsQBKP5MiC9WVjD5
	szGvcddnH/u5z/KxMMwthQaUpzQ3f8uYr4H7BlGX0E/M8FZkC13JMCIZygQ==
X-Gm-Gg: ASbGncvGug5L/BSbr5BD8r0Rw+/4jc/3Pf7XI1PTe2QXN+TWKn98wsgac/AP7AtM+4J
	rYRfJLHeDbSkv951pM3rEZM1ok4KPfQXhH6Vd79mjnot7f52nVcNHMi4E32qA1YnIy5Oz7/v/mk
	HVQlQav8ce4327e8V3FzsWq/gYvbBrv+rmRa9tQGDswC6+nRblKQSfLOdRsvRzNJdtam5hqtG7c
	v/c3TZCjWoYqUO5Kaad+4biLyV7RbDD3qyoZjGEfTUPLIZHIQnB2OoEpRvjtBZ1Iw3f4GeTakTG
	lCxU6p33ieIHP6wEu4AGHqFbh/2UaQ==
X-Received: by 2002:a05:6000:2003:b0:3a4:dfc2:2a3e with SMTP id ffacd0b85a97d-3a6d12e154dmr13691908f8f.39.1750763343136;
        Tue, 24 Jun 2025 04:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGm18O1vFLDsvo59xhvJ0D87DUDiE63/ilEIWM14hPF8ZubR/QRhwNQIPxsY8BH5HgKlvb0A==
X-Received: by 2002:a05:6000:2003:b0:3a4:dfc2:2a3e with SMTP id ffacd0b85a97d-3a6d12e154dmr13691857f8f.39.1750763342665;
        Tue, 24 Jun 2025 04:09:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ef6edbesm171253365e9.20.2025.06.24.04.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:09:02 -0700 (PDT)
Message-ID: <073dfdc8-dd56-47a3-b43d-4674279325e6@redhat.com>
Date: Tue, 24 Jun 2025 13:08:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 net-next 0/6] DUALPI2 patch
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, ast@fiberby.net,
 liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 9:33 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
>   Please find the DualPI2 patch v20.
> 
>   This patch serise adds DualPI Improved with a Square (DualPI2) with following features:
> * Supports congestion controls that comply with the Prague requirements in RFC9331 (e.g. TCP-Prague)
> * Coupled dual-queue that separates the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
> * Configurable overload strategies
> * Use of sojourn time to reliably estimate queue delay
> * Supports ECN L4S-identifier (IP.ECN==0b*1) to classify traffic into respective queues
> 
> For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

I don't have additional relevant comments, but I would appreciate any
additional review from net_sched maintainers.

Thanks,

Paolo


