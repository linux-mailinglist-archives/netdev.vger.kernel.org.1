Return-Path: <netdev+bounces-241535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 222B0C855B2
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E4534EA05B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2F3246FE;
	Tue, 25 Nov 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap5kYhL0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjOqHMOh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAFB31BC84
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080280; cv=none; b=V/jNL8SuIFwnSm3/lssvG/t/BYVCqin3UYDz1BJekyy1g8dBeAdf0ZMBPiyF1xWVQwmcWWCjdsTv9x/3J2G0BzfaQdkcyt4ZcQSOHTJsrBWa8yi+oF6Ac/+g05zyKnp2Lr7bcYBOMYdwsfjFRNxKwyNOeMzIt+eQe3rqUAI01Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080280; c=relaxed/simple;
	bh=2Ur0OJdRZLxQxQ7Ppyeg130nQxzLy00N2xieou1E18U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQIvrJhoR5bOPeWO6hJuxsFdDdd876qbmYicnEuG5/Gn6iyvjz29JDFEZAthy4VMhHj4TZwZBfli0vKppEITgx4EzTkH9w9zGghvxsbBh9BL/A1Qm7nqEbRpb6c1TSqSunHkerIDb8ddu2X7ZnUQmGe1nDN7xVVpJDhHS4HpGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ap5kYhL0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjOqHMOh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSwJ5fwmRDxewMfNoKhcg97Z3bqu6PXdkjiIvWnFQ9Y=;
	b=ap5kYhL0P7y7uusVIMyTjXiT/lh+174QFDEYS8TzsLgtfKyMSlfNnRzqPpr46xrf/MfCIi
	+tfXVT7QT1BaPi+NICdKbBSr41UxT0yljqTLNzHo1CMYW93Wl9nEEf0fsZKqO3JaMA6wHe
	WQ4oJej7+W1cUdJuM9BO5IdkM+WSZ0I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-j3sq_gwtMim0Xv1AfoERjA-1; Tue, 25 Nov 2025 09:17:55 -0500
X-MC-Unique: j3sq_gwtMim0Xv1AfoERjA-1
X-Mimecast-MFC-AGG-ID: j3sq_gwtMim0Xv1AfoERjA_1764080274
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b736eca894fso449529266b.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764080274; x=1764685074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSwJ5fwmRDxewMfNoKhcg97Z3bqu6PXdkjiIvWnFQ9Y=;
        b=KjOqHMOhkwn0uw0rkWPfTWbEuXImU+ltd5lgURdSdTgO7OC92tLS4D6Z1Dui9Gukq8
         yI00TVFZenRGRtMG67Pj2i2ASbWMCqTzAHCGXN7OJumFQQlsm1rReEsTt4e/3ObXe4CS
         a0QzS8dD9rkISJ9jcSrpdxz/fS5tObG1bR9HpmlwEypVkFN2zH+R84aeaOdrjstlvX45
         5mqpNbdVqjXzaxSZMkmo/uYlC9QLoRB3alXwuGCyz5qIzn5phU7wziJIriDpaSH1o8sp
         SczC7BxWTqMB38XZKpX6C1mFHDY8xOpkIZjusa5UNplSNSwUF1T33l5+1F0/0n5iMdz0
         /tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080274; x=1764685074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSwJ5fwmRDxewMfNoKhcg97Z3bqu6PXdkjiIvWnFQ9Y=;
        b=p9nqQfoVLXKQUho/axbmWT0nNgkA6EFlZ8mpLUQNVOkparGqs40mby657o9bpdxPHv
         P4ng1QRy7+rqN388hz34pNOfQl2KSoyIFDy3imVrIfFfC/slLZreU8cYxLLJWi36SwdA
         oJK87fTQmQbm3XmnxPhUiiJGYp8AfJtWVaCYgVA7Y8Nqe00i7LaQMlBh4s4fnlcKR/px
         JB9g0UMnECiREFkhXaosudv2SsAIvTK7kY5lgUg59cpZCWcaSiCc3Rzc8D2UDocdxg0v
         SFqTqR9ek8OBgULNiRziHRyLM8Tojk5K6DHzuN3pde4+Ch1YD6BC5RDKX54VMIOgt5An
         +XYw==
X-Forwarded-Encrypted: i=1; AJvYcCUde3zXp1F4hjUAoJqFerQewoyF698HNMtw147IgeU/iczIlsQR0a9cEqLa02pMC7PKBse5XFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxibLsuhOLPHhYjT97ecz3wI6l68X7mPVxIQUc1245DaWZ8y00H
	d+QSfhhi9suSzJNG/65ttHiADqN99gb0LQ5uoAr2kvEzWAP64eKBRWEaBxfVh2ErWHfD/iMgHoX
	4kADWPOB6jrTSBCkrcLSWU/VnyIhq3i6W/fNjKwMgDeFyvdPUPaXj6ou/0g==
X-Gm-Gg: ASbGncueeheNiUOShiQhCL2rkCMuo24+zVrsftFFeE8npuQjDRwEBEP392b2WPrV2rw
	FvdyrRU0o4zYcpdUqvwxTZ+wc1r9It1t9/WWeZf8MwC3N6EDscc6YPosX8R8ioMOzKoWln1Tkqt
	Pbk0C5ti2NMBP+aabBHKmvVlrowLe7X2JdBZ/4hcqZjWBrprOiI3lwwwv2PKCkT5hGG9c6U7zs3
	iAN3oMvUoqgyAnx1UkDnGGpdbZL/21di5RhIfyh4llzDX9YIs1uirJh0mMHF3cP+2Tlbwtucx0A
	xi4EcQnY0hxhM5xG9hSxWoFl7zUhxkx3mUfNIbQX6BspZxxXJvJVdhMWnT7BRNpBzPIohGWuXeH
	rtVxJ7QVEPbVTgg==
X-Received: by 2002:a17:906:ee8c:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b767170ccb3mr1838885066b.28.1764080274269;
        Tue, 25 Nov 2025 06:17:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsrmrV2cBWDr+ZSzNL9o2G3mEYj/CXK8Uil/l4NJOy/CwceejmUKWQCZ9oPoMhj102mNMv9w==
X-Received: by 2002:a17:906:ee8c:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b767170ccb3mr1838881166b.28.1764080273904;
        Tue, 25 Nov 2025 06:17:53 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cf0435sm1599810766b.4.2025.11.25.06.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:17:53 -0800 (PST)
Message-ID: <c9d2f2d4-7d8c-4acb-9960-805a3c6d83e0@redhat.com>
Date: Tue, 25 Nov 2025 15:17:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/12] ipvlan: Take addr_lock in ipvlan_open()
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Xiao Liang <shaw.leon@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, edumazet@google.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-7-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120174949.3827500-7-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
> It was forgotten to lock addrs in ipvlan_open().
> 
> Seems that code was initially written in assumption
> that any address change occurs under rtnl_lock(). But
> it's not true for the ipv6 case. So, we have to
> take addr_lock in ipvlan_open().
> 
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>

... same here. This looks like 'net' material and need a fixes tag.

/P


