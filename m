Return-Path: <netdev+bounces-223440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D62B59230
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347057A8021
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65421291C1E;
	Tue, 16 Sep 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SreKXC7j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10882747B
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014900; cv=none; b=Hnb6rjw4A6yFV3qIpTqDlOOX5WMjcP2BOTkrcsA13TYLqth8wu9D1WqOXwrfh+GsF6SCKF3d80fqca7NMnuHL17+AEXV8JRsB9y2HGxW45otCMp5a4VNW4qt9Ahh8/H564ZOthrUWLDPd/etQm4BD5DqFlpOg5qLhl/96eC4quE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014900; c=relaxed/simple;
	bh=BwgE0fZVTpou5PLODf+f62b8c5+XA7mBXcjB5INVY8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1Mvqw4PuOg84F2LaVeTzGG3eOZFUgRDTkiTJcq5twdb30aC18q85tcb5oewijOMAus0AXx8k9hKP3GUfv336eEtfBqOYfBHB7ZVl7Iv7dTd0jw0ZWKHqGrI+xzoJ1xz+KBxWCDtzLSYTiir2LAIpn05Y1a3gL0xDKzx2I/CEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SreKXC7j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758014898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZGtytud95tmaRHsL0gi2KrAJr2S6c/aqPB68a1SH9U=;
	b=SreKXC7jUWKReTtfkr5vEyoknEWqOQebmQ2VvEwqi126oCONl/fhKjqYEKqd5SmyvO5+/a
	RVNaVtdaprL2Ji56qLvBLvZYDGzkhHltGaBMCaagjy85qZpiFvTwNEH4oUsxlzUQqwcocV
	4/JtcQY2jfPA3fanXaVmfzq2wzSbFWg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-C1ndYAQyNSyPgqmKBKWkaQ-1; Tue, 16 Sep 2025 05:28:16 -0400
X-MC-Unique: C1ndYAQyNSyPgqmKBKWkaQ-1
X-Mimecast-MFC-AGG-ID: C1ndYAQyNSyPgqmKBKWkaQ_1758014895
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df19a545c2so691119f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014895; x=1758619695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZGtytud95tmaRHsL0gi2KrAJr2S6c/aqPB68a1SH9U=;
        b=LRvwyu3G5vn0f3oXoPtTZyva3zejJSk0eOGsvxPhFg/e5XNvXO5QT1d/lm8PKbXyaq
         t6jpj2ZqGs7h6nYksnxLTq64318FHHlzvApn/fvH97t9NKMdqg58XgEeLnWCsfJ/hFvL
         qx17+juYmgFKCtKx+NH1bAqxgE+U7PM68CZA/OZHvHVaZd7VkrEkhqPov+erGY4quq5Z
         ef4k39iCaHKEuguJAiBLQOqEvS+6sMDTs+m1zkIg1U25abiJ/bHpI7JnEXRGt+ef5d3M
         NX/9yqcklQZ2GA6z2mcUwJHXTy0f7oFAxdnP85+HgCYlS3DnYqZmIj/Pv9XYB682j49s
         /TZw==
X-Forwarded-Encrypted: i=1; AJvYcCXaphk+DScZaq0awAQX4hAcIb5N62mPfJKjgfjpnbHOS1+b5kkzDiMH/oEihbMT1S9vA9m3LC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYKXvnBGlV0CcLhoiD/Q0i8EATOo/LicxCQDeqZeYAvQKM3iH
	rUF1ObFH9QC7CEkaxYOygEeN0IzM3EpkchN28w3CkY/wyrlzW2iJQmC7838fkbuqIo1GZG9A68c
	/Fsro1a10wvVKUHBUhA8mLfOH6RnTZ6b7s0lEIyBi8ePgfovCvZ/5UaYv3A==
X-Gm-Gg: ASbGncudd+6dDBnfIWQ4sNAcpabZ8eYXOOLjb5qLYRpKWuQYw8zdGNYkBw64S7aI0K0
	UUmzX0xgEHW9BfgH2uFsccr4KYE4rLuC2vO8gFpPh3ipn/JO0LtE4paskOuNJvuCMcYPrjH/R0A
	bIdY9xLo9OA7vCuqc8uqB3fDWCa12Jrm0KBIvkt6Tzfxwqh5rma+qBRaBTGmVB2lLg6prYxEAni
	bhTeb9HhNhcIKi+dHNvRl4AU6aNMLcwK155mbNReSMmVL9vvXEUj5DmtBAr0bVhwbgwOMbEkOME
	bl9olY5Onx0RD4SM3iOToXcvuGcX/JyDJkPp3aKwK+NFLlHNpTqvqyZf61tVRPDix+kj1My7Fef
	phsdRipZguyGd
X-Received: by 2002:a5d:6592:0:b0:3e8:e52:31c5 with SMTP id ffacd0b85a97d-3e80e52323fmr8339971f8f.2.1758014894728;
        Tue, 16 Sep 2025 02:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQKEXO6nFjtGMdgaerRdcKqXIwJME36jj4KIcxvhqrfG77hW4CHdStElBYMZ7IzvBSFlkSZA==
X-Received: by 2002:a5d:6592:0:b0:3e8:e52:31c5 with SMTP id ffacd0b85a97d-3e80e52323fmr8339952f8f.2.1758014894298;
        Tue, 16 Sep 2025 02:28:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm211065015e9.23.2025.09.16.02.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:28:13 -0700 (PDT)
Message-ID: <f8521a23-3b79-4946-b5e4-fb6b4963959a@redhat.com>
Date: Tue, 16 Sep 2025 11:28:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: dst_cache: implement RCU variants
 for dst_cache helpers
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
 antonio@openvpn.net, kuba@kernel.org
Cc: openvpn-devel@lists.sourceforge.net
References: <20250912112420.4394-1-mmietus97@yahoo.com>
 <20250912112420.4394-2-mmietus97@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250912112420.4394-2-mmietus97@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 1:24 PM, Marek Mietus wrote:
> -static struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
> -					       struct dst_cache_pcpu *idst)
> +static void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
> +				      struct dst_entry *dst, u32 cookie)
> +{
> +	if (dst == dst_cache->dst && cookie == dst_cache->cookie)
> +		return;

The additional checks above could possibly make sense, but should never
trigger as the _set operation should follow a failing lookup.

Also are unrelated with the other changes here, they should land in a
separate patch - or be dropped.

Thanks,

Paolo


