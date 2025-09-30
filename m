Return-Path: <netdev+bounces-227328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA8BACA06
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A9F1925602
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E79218AAF;
	Tue, 30 Sep 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwnznzr4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912E1B4236
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230196; cv=none; b=CdlJLTSxHYL+ScqrLjbGyUx0f0KKrNp+t0MrhW8phRba3aaQcGpJSjblA/NrwyFjuQ88O1bIF2mJ3pMR33u4Wl3GlhxzUF2QJ6/Q7+FCUu0IkT3yoFYCrT1L+FoPA532ZGMhTI0+3bTC61y3EFeC5AiUR11NdTyN9knfrsk1qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230196; c=relaxed/simple;
	bh=5u6BGMyZg0ZeuMYiYi7YTJmV+4yktA30/Ri8cWBKCfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mhdFDv+l8vx7lOWS9R4X3as8faxa2/YoMp/04dD1/a8B+sUTlH8BeeC5PrZjR1jdny0FH6RGHX1XBm+Rzne1RV3WcWNnDRbmrr4Rt9gfcH1jOD9FVeMcoaV7LRDEqFppfF29El0Rt780ikPAvOJR8VrSEJhCiRMHdGzaovCBZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bwnznzr4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759230192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3hCo/D5uBvIFt5tzpRk70r2TMeNU+1RWRpfUU5oV6g=;
	b=Bwnznzr4DzDI/AYLdCD3Ce+gdlY+Hf4mcXr40J1x2pYeehIksbAZPZ4LmjsqHtQKZhlyqw
	YHD9ndlOQ0YYeK3oAbVyiv68wWojc+d0fveSa421++EoHaMNXqSg03eC2TSJnFkuCItitX
	orqsQbjcTvIR67aM2Eb0GD23hULE8Nk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-FLe8Kb65MBiHB6ULwMT48w-1; Tue, 30 Sep 2025 07:03:11 -0400
X-MC-Unique: FLe8Kb65MBiHB6ULwMT48w-1
X-Mimecast-MFC-AGG-ID: FLe8Kb65MBiHB6ULwMT48w_1759230190
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so29264595e9.2
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 04:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759230190; x=1759834990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3hCo/D5uBvIFt5tzpRk70r2TMeNU+1RWRpfUU5oV6g=;
        b=EDZMgaytTY5Kty8cEKnanqao9Bz+8RuQU547PqxDH4/dT/nYHqxHH1fv1qa6pOOSPA
         Y5r9XypEbfwL3y7JAU8ojdAhOwtB1W+RWSDZ6KcpXnRfalW6j6hsOdhXqrggk+Y+WzCd
         UVGvtnD+p9odTJuQsUQ7rYbUpvGzbMcA1k34JnegYs82GVQpX0QZEuE2viOM8MVCZUwL
         P5OVYZhCGn3NcQVOSM88RFjIsJm54gXIjzErlrH6bisFh/WXdOMqdgjgOjIKeymhm9yD
         GgDmYPhry9DeVrcsxS9M4S2qYngo/84jJsCLsxa4ZilvU1o30wakwaZwJd58/tO9enZR
         2zog==
X-Forwarded-Encrypted: i=1; AJvYcCV0/cXnpVkVkcsOpd7Tntj0skmJyKcEBFbJOCWCnmZTxaBYLwI1xP10A2tOKj/hpvOGPOkVjBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVZEXDdA9kh7UBnEqZBSnP9yY0QM8wPlU0RjC3XUlVODbG3Uc
	G2CSvpn/KIjvtJBGm2ylzhw+JeIqGthk6Jm++uATEnXqa4f19lvt+ziOz77GFMTbjIMZ/HqY5QI
	ljEEezOcQ2t5WPbV28geqgL1e6/H1rLf2V6rwkhwz7IHs8FngwhgSIuxm6g==
X-Gm-Gg: ASbGncudizPBaZWBnKw/ciY0iKjaShDMFOecx4YBlDEAgbtA58s+HTmRitciFzj5j1+
	2ujtc7g49EX3k0YwuX1lTuj8lyKXBCPyMvrkZ504uZ16KLBpvnVnrGCXkDekPZvtEJoPbt0vrnN
	ymgwIX25dMIeV6FHS0zMXGcQNC/Nv+sgGom0JD2kWYHmBQxhgEjB8N3GLu7awPV05mDfAlg/5l6
	JHg/5opANea5+hj3RfdYPI/hBus/8n878AtdTKECuyj54oYsN0B+b9QHpxu8X+l7qnTA5HeIK5y
	/z3mt8M9k15Wny9ldcUuwFWpSK4yIZXDN0aRCrH0ap40bp03M1MQLkSikEFVKkNQlzH6P+0+KP/
	Os+3IaB5zLSlo8bXMOg==
X-Received: by 2002:a05:600c:34ce:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e32a2c1d6mr192325975e9.36.1759230190149;
        Tue, 30 Sep 2025 04:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFj7mxj8Yl0hTsBFdCmnwOPVTMRa5dKLaiRfxfgQ9PMsc+FPZrq9aAN3rhTAERQcDc04InRg==
X-Received: by 2002:a05:600c:34ce:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e32a2c1d6mr192325725e9.36.1759230189782;
        Tue, 30 Sep 2025 04:03:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f3dab0sm51237975e9.1.2025.09.30.04.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 04:03:09 -0700 (PDT)
Message-ID: <49f887d8-a34d-4154-af94-84a3f77700e1@redhat.com>
Date: Tue, 30 Sep 2025 13:03:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 00/12] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 9/27/25 10:47 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> Plesae find the v2 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

This is a quite large series, touching core part bits of the stack, and
we are very late in the cycle - finalizing the net-next PR right now.

Let's defer it to the next cycle, thanks!

Paolo


