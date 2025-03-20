Return-Path: <netdev+bounces-176423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE679A6A397
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEA53B2F63
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85B8223324;
	Thu, 20 Mar 2025 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhNlYo1B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827A22332A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466326; cv=none; b=I/noW+5XIkvm78TnUZ7qbUro5K5yE/hakuCy3rWBLuzhDJMgRhX57hzSg8Xj4Qi5qmXwOTX0xmHoMQs9V9Ei9yTLwDtC9Cr42oTOJjD78KQVoiXA32XbJ+i5kpxiz8JJR97azAAHRoFV5L7j6bjm5DLTSS8VqZrGoQ89F+x4ifU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466326; c=relaxed/simple;
	bh=gD8RaJl7wrB8uXOQ/81jmlUzWRtlE3XCnPhAdc+CSHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtEDCpxRvDGzAuRt/IoC1A6EVidGRNUK9yi4COFm6c31rc6GWYl3ljqcNBT54H1uMQKg2afgAW00+D3IgHc45njTtR6EPtWsV/bWy66vL32lCN3WSra/y8OI9YCQ58wu7aqrz/PtvJoL4aD/e6g0Me0KoHNliLMUkLmHI/NZxJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhNlYo1B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742466323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gD8RaJl7wrB8uXOQ/81jmlUzWRtlE3XCnPhAdc+CSHo=;
	b=FhNlYo1B/Dc+a0prExfZbE7CKjq9smiwbaICeSzanoxXBn5ZWKA9mnLlY55BVYLxIkqAHe
	ew4dEHTy7kIjVNYYW6JQXE4m8BF9mzTNyb0Qb5vjNRGfvqkQh9Y6LcDx1XNdvLm0nP9bsy
	H4sZp+czLQQlIeoDkrMvUjrM2JLWxa0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-KrB5OgwOOYKBdF_bumqfcQ-1; Thu, 20 Mar 2025 06:25:22 -0400
X-MC-Unique: KrB5OgwOOYKBdF_bumqfcQ-1
X-Mimecast-MFC-AGG-ID: KrB5OgwOOYKBdF_bumqfcQ_1742466321
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39979ad285bso329509f8f.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466321; x=1743071121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gD8RaJl7wrB8uXOQ/81jmlUzWRtlE3XCnPhAdc+CSHo=;
        b=X+fOCUjIhw1Q1oeu5XIZ25pdKvQqF11sF9XVhdTJBJqNo/1+8v3w4LG0NWXNoK3Z4S
         Ci6A+VzbAymi4loldKEC5nLkIq8iFN6a1U5fVivvW0VISoCTrBNBO9oemAYTl4KtM+i8
         INRJduiqtKqQ/tv/d9E0J5T7MZlBPv4LL4FNqPCV0I2CJX2l8i+DjUpQRRTSZwQYL4ef
         uxnJZU98I/nSRKfnZH40M47dj40J3mVqh5grimm4dpPWlDCBy/IcwzPK42MOXP2YJoTu
         0fZzYuGz3clxLDWe4pqdpPv61qykWuuqeYWlpYExVggz4G44EGSKBpETdBwtH+RfpfTX
         R3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz3HO2pF6LHxnejD/h1JbqwwXZuedRRvovHOx8glEGQiKlcVkS/4Dq9NA9KoM8KRm85Wc56qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRA5IZF9/DG3KTgX5ItNAqIWFmC7eTZMEEQ2/2vACQfWg2AlEC
	itwn5AbR05Sd4FlfioIBKkvN+oEStvTOM1/xys8ItEuJEZKwg+ibBY06jyA5k7v+DK6mVtmGKwh
	+3+g1TjDC7eNWqlmsgD23WHaOnCO/zpLymFhLppHhB+GrMx0Hrb1Pdg==
X-Gm-Gg: ASbGncu7yI/McbPBNkrEJF2gGjNPAZBqXyX1zv+pueO6V1L8b48dV5zQDHjy9qR8rEz
	EyioYAq9LIOarYdQgrRc5Msp1QtR5oSblx+Xoapj1vANy9PyZHh46wP7/zxfes8rAgVBorKB3DS
	yEaLjinnY6VVjFhwAfSJNVX9Vwl+qiPI6cC6td/c1ukydbz+GGV/Mn/b3VLYlQV8NZ+vgT7jjhL
	hRP1ZSc3ym3aYT0btxy72XsQ00xJog1P055WtdKtiGhUnec2dAXXyC97r8UQa9PYZ9gbWJ594/v
	Zo+XWism3gTjloafr+hqH9gpzYDgCyF5WKXSD6bugvpx/A==
X-Received: by 2002:a5d:47c9:0:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-399795d8a4cmr2444037f8f.42.1742466321161;
        Thu, 20 Mar 2025 03:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFilRbQgcg6RKfKJHQWtM6ap5iAjquy8GFpgrzkvNWIO3lRerhAQf7zHt1rXURfOUeFjczK3A==
X-Received: by 2002:a5d:47c9:0:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-399795d8a4cmr2444013f8f.42.1742466320737;
        Thu, 20 Mar 2025 03:25:20 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7ebbc3sm23193708f8f.88.2025.03.20.03.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:25:20 -0700 (PDT)
Message-ID: <ffc4c4ba-7159-4a89-be52-9802ef21153e@redhat.com>
Date: Thu, 20 Mar 2025 11:25:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] selftests: net: test for lwtunnel dst ref
 loops
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20250314120048.12569-1-justin.iurman@uliege.be>
 <20250314120048.12569-4-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314120048.12569-4-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 1:00 PM, Justin Iurman wrote:
> As recently specified by commit 0ea09cbf8350 ("docs: netdev: add a note
> on selftest posting") in net-next, the selftest is therefore shipped in
> this series. However, this selftest does not really test this series. It
> needs this series to avoid crashing the kernel. What it really tests,
> thanks to kmemleak,

As a net-next follow-up you could force a kmemleak scan and check the
result after each test case to really output a pass/fail message.

Also, still for net-next, please investigate if dropping or reducing the
many sleep below could be possible (it's not clear to me why they are
needed).

I'll take is as-is to avoid blocking the fixes for trivial matters.

Thanks,

Paolo


