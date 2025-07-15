Return-Path: <netdev+bounces-207146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACF3B05F84
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AC53A64A2
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B66D2E611E;
	Tue, 15 Jul 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gw5yogSB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959C2E6106
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587415; cv=none; b=CAIhky3gXeduJpC5QvI5womGWLTJabDGT+Sz6+ruhzI5aZ36RMIg4gOIL09Ba2mDFLDVr3YEq5z/7LfPron0y93jeio+jRuge9r4EawTHfdTkTZOXl0jOhKT/vs8wRwuThV1c/5+X12OccSjYUo8LFLfZWXastMaNhDE27NYK7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587415; c=relaxed/simple;
	bh=P+Ag3CpHVYqC0PMxRCTmPq9+gOsuc36KZLKWUlmgvPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1TfswOigw+LxU0BdAMpcJp+rgTcAus/whBFHGiZVwtkjZiXb0ruRQ6h9+l2Tcmk6ygOyw+x1as/5bJ8pOTzH48VjaGP7LSpqif2pvu/bE6NkczjzDVj/wpI1knNzCSNqgn20DnuRjMIfT74b4JDmr3iLM7QbRF0DnTJAkKxGzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gw5yogSB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752587413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/5Kal+h1ZC7VqPLjnC3GHu/uLr/x1AdCe10DVQDPRA=;
	b=Gw5yogSBtoxqax61XevprNRUOUnylUYyFieEFHel3KRE/cbVfVQ15bRGt5ZzV5Mrx9gVGV
	49YDwscqmtpGfsJ50SW1cBszpjx30KAEiNle4XgAJHMxQIShkZUPjb90CwDuLN7jlCK+1D
	uQGzCQ9DyLieXBKU7iqLdECM9tQAo/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-35UKzNeRMqmYrMNeWE8fUw-1; Tue, 15 Jul 2025 09:50:12 -0400
X-MC-Unique: 35UKzNeRMqmYrMNeWE8fUw-1
X-Mimecast-MFC-AGG-ID: 35UKzNeRMqmYrMNeWE8fUw_1752587411
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4538f375e86so46485705e9.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 06:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587411; x=1753192211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/5Kal+h1ZC7VqPLjnC3GHu/uLr/x1AdCe10DVQDPRA=;
        b=VrkLv8W7xoLeknkOMs1k/jRj0pHAy0gZ4WTLlujl5btu+MENjQrVa/JrTA7Nq7sXFf
         fnK/7HyT+i3Do/76L0Xhq0o3c+hAZU7Q9KOfq0pt/3whve493J8wMDa7BmHyE2D1odea
         XgcOMxmhDSVVyGEBX0divJFKQNwiCqV7YRe/E9YzpcSmTjvu6qlHuF3Ej6a5XRf98aCi
         Ki0x+9VEMXhc4bYp7eWlNDUFlGcQT5V/Q9jng3TaPeK+qzzE0YD66MyawtkDR+seW+Y3
         KWsQOFeoXvfxRvY/BWKT/4Z8t37+GZAz67sq4jAZWOl+pqbTI1F53fxhnpdBoS0Ut8hh
         S8HA==
X-Forwarded-Encrypted: i=1; AJvYcCWCiHbhwkcJGU3PcIr/1DfoJdhFQkTCbeCI/6rA3kbRGzCsyEIIfePQEWYRc3lVEugqLFv0JjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNsd/zPTqlB7q93gvWBHwmTEHNufoHfbp8Sb1wOM3PuhrbH+2y
	Y3iP00QJjVV1IftBcqXWrQ7W6HzamIwEQ0/JUHRyBqqVfL4A43EGX2i/qLYbHrf+z0sxvwyLgv2
	JY0PXMJBFEPm1equ/fFNnY/9mHkF/xFA5ik+OA1e3Kqm/LTNBU+DvJHjRZw==
X-Gm-Gg: ASbGncsaDtvd+Tns6JOFR0gb98KGAxsKsQNTuzUo1ewkNFaBAwVpjNpJrlCZ0Xs38l1
	BXHND1lhJYxlrVrIf2lNPWgzoE43k17aaLOKCHtUuvMe9mq8mqq1IqbAsXNkA3aynr8znUwAbhQ
	86asg8uR0LCN3yx4fvROJsYsbQxF38kV4Kyn779M4ttf8CjabreRnGuSZ1sTkuvpbGpvV5PsvAV
	flHGo72UILmfkKFOqoA06gOt7GpG3AlibeQok3+/1Bsg+X7lUr+K8Kfv9MbC7WBwT/0BfHy5wyy
	yqBwi/ybnKeyZVivrcwIXehFktkcBct6oWxYIZqaAF8cO5VShnkpDsczCz6fS5uOhALZhkfCrtq
	ZWhp3k2463K8=
X-Received: by 2002:a05:600c:4e8f:b0:456:2397:817 with SMTP id 5b1f17b1804b1-456272ed401mr28017355e9.13.1752587410758;
        Tue, 15 Jul 2025 06:50:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeYqh+g4OaKXu3+Ri9RxoMt8ajuVKOqr/6JFiWdn+XUDnVSlmGlftemTzOj4dY5B0ex62u9Q==
X-Received: by 2002:a05:600c:4e8f:b0:456:2397:817 with SMTP id 5b1f17b1804b1-456272ed401mr28016895e9.13.1752587410340;
        Tue, 15 Jul 2025 06:50:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm15031492f8f.24.2025.07.15.06.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:50:09 -0700 (PDT)
Message-ID: <bd47870b-e266-4b1b-a806-b8db1b06e1d4@redhat.com>
Date: Tue, 15 Jul 2025 15:50:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] tcp: receiver changes
To: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, "David S . Miller" <davem@davemloft.net>
References: <20250711114006.480026-1-edumazet@google.com>
 <a7a89aa2-7354-42c7-8219-99a3cafd3b33@redhat.com>
 <d0fea525-5488-48b7-9f88-f6892b5954bf@kernel.org>
 <6a599379-1eb5-41c2-84fc-eb6fde36d3ba@redhat.com>
 <20250715062829.0408857d@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250715062829.0408857d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 3:28 PM, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 12:14:34 +0200 Paolo Abeni wrote:
>>> Eventually, because the failure is due to a poll timed out, and other
>>> unrelated tests have failed at that time too, could it be due to
>>> overloaded test machines?  
>>
>> Not for a 60s timeout, I guess :-P

FTR, the above was referred to the mptcp selftest failure/timeout.

/P


