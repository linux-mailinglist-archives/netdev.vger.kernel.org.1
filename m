Return-Path: <netdev+bounces-183323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECBA905FF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992E88A39D4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6321D011;
	Wed, 16 Apr 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nh/LMJEa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA32421C173
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812000; cv=none; b=pjNmdOj47nozQutAZ18qYUyfxq6S7TK+UefWBRm86q8mObzXzfY856ZHyl0tNXY/FF/jA2TL3BidLIf97LUH/L5VfE/FSsDdnj8qS7aPNk/jjfDvHibJmSga2O2XNs9w0YfwteEY9qxTOInUD/D/vANJ4WtfgW27BSc1+sFHlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812000; c=relaxed/simple;
	bh=5uyj5vypSsHA95rB7DQvAQXyeFQzqru8yY7HhYLXmPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbvA/zv7/6l400S1zRdbjT1w4BqaoATkowPGUxnY/IMa94Q1SOMGKPw/cy6wPsutyylJ/Tg4GZrLkuZzq+QevInueyMV/672taaTYZxAN9G74k3S5GcPyMGrqv0eTjncaljbSBntggWcpKG77yWMYLthWW/zrGNHsG+u/xTSZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nh/LMJEa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744811997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRzSt6otmrQplT4W4xhCTutXRj6AuJsOs1OPLY+P2rI=;
	b=Nh/LMJEa45r2dkq2S8br0/Ts5jeJYNbcM9AxMG6Is9x03m2vl+5bhan31XwEoD+EYu2IzO
	2ZMzJqhe113eGc5PxycAGbNw/1nbf6cGCrVK6PUSWrlMAd99Els+06KUJSyiDc0oc1lNL1
	gYl1uw10r+/svy2c+mnteucNvq2o7MQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-uSb7iNSwOWubrX1_0IrSFQ-1; Wed, 16 Apr 2025 09:59:56 -0400
X-MC-Unique: uSb7iNSwOWubrX1_0IrSFQ-1
X-Mimecast-MFC-AGG-ID: uSb7iNSwOWubrX1_0IrSFQ_1744811995
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac2a113c5d8so511283966b.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 06:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811995; x=1745416795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRzSt6otmrQplT4W4xhCTutXRj6AuJsOs1OPLY+P2rI=;
        b=NeXUv1rSTf461RdAI2ar4lu6UUYl51Hvl6I2rXW+rEdyiRH/wCgIZ66v7PTOzI9YQF
         NUt/jRZpJnZhxjHOxCAKvuRKKR9U2efuIEc+CP6fEdCfsdBm2m/5tLyAPZZ+2galjUKf
         QoZxVPjik7mkhrRDiazYEY3BlIZp2UXojKs3EezWIBdI06W3ihhNkjqHF+evIzcHLJFT
         Kbqv8d/nK3K8I1DFd86bg1Tm6c8goWY6OzO4Y1U0RF7Sph7YjU1EKsrIfH4iflai/JfS
         GK2fRZI1hPqpf1nq4fJWONZJIwJpEPKBvKN951xE1OSPfWFDpwjnLZvx5dhxD1qPzzxu
         hOEw==
X-Forwarded-Encrypted: i=1; AJvYcCXTg2yXPSdW8xuSpYr+21/Bm4h2KTY290jMYC5nShNZ3hGxKBGsPCIomgC+Dv0jzLivEQZBWow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzdPqsNMmUxG5FafQiJmTHnd9vpCHFIOHtmIauP4nW04QMwyR
	elF7YEJeypbgmLg0QgbWwAj2TiASnFkJzhgUKTRfsi7jvHpi5PZLliW7etLXrbzBxrUi1Eind+v
	Rj/T/5IPzcYgkO4ws3wOF+tJkDu12bI4q2PcVuWWzqhSFilmsUi0bew==
X-Gm-Gg: ASbGncv5y7Bck/fEsYJ2lBvTvVrOK0Fgx+5Q/1GsYVPPtNCZCJQ+LXP++7A/3IMWUEh
	B/+3vyksuhTJr4kyTPcWjSKdAxUTsPrJ2TkvSzsZffBfdC1sekW3PUernMCEHIqj/iPeHsKiAdM
	cKfxijmZm8g6/GeYAeN5zVLOCySTz7ZUpC6ubtIZEIaBmNr2MW9bNyyZdJw02/cb7S9ICT8dzip
	8RmWHsYnlU0VXjCfGOfs9eHH2Sq665cN0nZCLSPwrN4ym1wfOxgYJXcS7cV/Y/5woF53dgtTadP
	nOZJoW5rdvOXuWmqpPdvAOFBo4EryJkVOABkDLQ=
X-Received: by 2002:a17:907:3d11:b0:ac7:95ae:747f with SMTP id a640c23a62f3a-acb42b6ba7amr169997266b.45.1744811995109;
        Wed, 16 Apr 2025 06:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1fRc+f6+xzbCYqXHoBPnYGNxPSNRogJ+nLy6MhwfZZu5pIWDBaQ7ASA+JaIbOUkdz/0ftEw==
X-Received: by 2002:a17:907:3d11:b0:ac7:95ae:747f with SMTP id a640c23a62f3a-acb42b6ba7amr169995166b.45.1744811994574;
        Wed, 16 Apr 2025 06:59:54 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3cd626acsm134891266b.19.2025.04.16.06.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 06:59:54 -0700 (PDT)
Message-ID: <a319bd25-1a7b-456b-8912-281a10d32da3@redhat.com>
Date: Wed, 16 Apr 2025 15:59:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 12/14] ipv6: Defer fib6_purge_rt() in
 fib6_add_rt2node() to fib6_add().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-13-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-13-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:15 PM, Kuniyuki Iwashima wrote:
> The next patch adds per-nexthop spinlock which protects nh->f6i_list.
> 
> When rt->nh is not NULL, fib6_add_rt2node() will be called under the lock.
> fib6_add_rt2node() could call fib6_purge_rt() for another route, which
> could holds another nexthop lock.
> 
> Then, deadlock could happen between two nexthops.
> 
> Let's defer fib6_purge_rt() after fib6_add_rt2node().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


