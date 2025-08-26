Return-Path: <netdev+bounces-216902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FDB35EA1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B4B1BA42B5
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B275299957;
	Tue, 26 Aug 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwQqIHf1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAC20330
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209187; cv=none; b=B2zU2SLQ3ZTyzkhIgV+6e/HlIaxhX4DBnpS5koNOh7RmBBrZp/JRrcv5CtFfQbzltQLfc/aKviUzGts/82G5SbcgeBDKXUVS5UFs6ZUCZ+p+xmtsp2BsZcbNP6SsUk2drgajTbfIyl3HkUXe7xshbwQcOq5HfHTSJkCpUjahcOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209187; c=relaxed/simple;
	bh=NDY/SwlkCskTiU4icgKxgI5F0uGxa/BbQNvFd9RELIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxbeRrI1SxwOVeHdPCuSaoEeHqlZ7Of8g1M/3upe71p9oSwE/x/Y2t9UDyHMchEy7Zl7rPleYAygoiPvvUvNKDXBXL9LwCe4WXijNnd9TZAic5M1D/NmxjcE7tToergJv6zSit3bBOWImqOfL0DHh894P465Px5XJf2OGki/j1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KwQqIHf1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756209185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztUAxwLEs43JGnz5F3qH0FG0kdLuFnw3IzEnw7hmsUs=;
	b=KwQqIHf1XDRrWTOpDLTpgbHMvKVjnMEpoCnXaIkvKbDF7y67Q72Pzxu/ryeEhibETmoJcb
	HIAC8DBIdsWIDF5r4okxw72gswegaXQyriIXATf7lM3G9U2BAj8G+TqkElxJXear9qckgn
	n8ifx4EtvIq17I92/IcmPXAaZt12zg4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-nh5xYbnVPlmkmZn3aIhuUg-1; Tue, 26 Aug 2025 07:53:03 -0400
X-MC-Unique: nh5xYbnVPlmkmZn3aIhuUg-1
X-Mimecast-MFC-AGG-ID: nh5xYbnVPlmkmZn3aIhuUg_1756209182
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c7d6923834so1873027f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209181; x=1756813981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztUAxwLEs43JGnz5F3qH0FG0kdLuFnw3IzEnw7hmsUs=;
        b=QapJInJWJpdE+wfIuqBvM9If2gGcMZENCLGsi1pEPo8DtLO7Hqp3FeVYYiCV3E9t5n
         KO4aOV2+nZR/byG2+lCBOCBXm3+w5oQAgnpSW+9SYwbV2dVI+QShWdK9fBnAw8H6KbCu
         gLRpsEpVbVoiNLmrjK1Hn9yufCnmHYiVQycwqO9pPZm4VHJ8jn79QZjc5ZQgkCSD84VE
         vGqfyJY6rkJsO1Ufv9EBDa1QYULq2QI8lu/1MENKgjSMlFSiSYgj0L1u4A8pDKGa5UZL
         px6iegwvubPV8eHqmYWP3lTk1tM5favYAAmhALzmZXKtBEtKoJAqx9qqc1HYeQtV4Qzj
         vYTw==
X-Forwarded-Encrypted: i=1; AJvYcCXf7pJoLU4okxv+E7YpcSiijqJdqEP86S2Ak50apDZ28ualkaZSJeE+hMzNuuaWHhWrONiQKnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0k/u5BlMliEUsbjy2xNad8fIpXWfTsYrw3b429gV3nu17quV
	Bq727HzBYCFI45L3inlnZjmHg/Ckq6wrAnhZkWF1acto3LMg3GKA4EbnYMgC74vPKtJjXEq34sn
	i5bdGUg5idS93DtRcc9RDO6GCI6BRKZDIjU64nEVWtZP3MaFgdAlO8SWO3EZeFEPwLg==
X-Gm-Gg: ASbGncszrEtg8G9OR4yB27f2sa8QZos6aydS0ZLHH0m3Iz/uA2F2vpZnB5duV3VGidU
	r1YRf5SIzND2djEMZ+XsORf7qU6dczauKSsKO9hNgMnYqtXiJIzkCqLBe9OakHQtBy1atEOTXQl
	2B1PQ8//BaE901iVtZ9j8OnSrr7J5JiylKsYQF0qQ2uKyfSxGC2Msqn+0zjs5BQUm4SJ2n1lwyv
	6a/2jJgyLRjB3uaVGANciJzZbcHeiqiZqUafsdYPNtnGgRnDG72xr7mogLdIUdLcLL5/QahM21u
	Bm6kYDauFgtdddyPsdKpg7OC12hc6AsJCJCds41hGjjfu36W8Jz2r3piL0BlxnQiq0LJR6d3JXY
	9pYs4V5jyEPc=
X-Received: by 2002:a05:6000:3105:b0:3ba:cff3:2e9 with SMTP id ffacd0b85a97d-3c5daa27683mr9975804f8f.1.1756209181167;
        Tue, 26 Aug 2025 04:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhojhUbyv76zSOyFAZfkYCxrK2NRS4KtaV9nVL8OmTvVkTLnqcTJRHVafvTv0cVWOgK2BnlA==
X-Received: by 2002:a05:6000:3105:b0:3ba:cff3:2e9 with SMTP id ffacd0b85a97d-3c5daa27683mr9975790f8f.1.1756209180763;
        Tue, 26 Aug 2025 04:53:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711ca6179sm15721273f8f.58.2025.08.26.04.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:52:59 -0700 (PDT)
Message-ID: <7c990c8a-9546-4bab-9438-9760090978c0@redhat.com>
Date: Tue, 26 Aug 2025 13:52:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 11/15] net: homa: create homa_utils.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-12-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-12-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
+/**
> + * homa_spin() - Delay (without sleeping) for a given time interval.
> + * @ns:   How long to delay (in nanoseconds)
> + */
> +void homa_spin(int ns)
> +{
> +	u64 end;
> +
> +	end = homa_clock() + homa_ns_to_cycles(ns);
> +	while (homa_clock() < end)
> +		/* Empty loop body.*/

		cpu_relax();

/P


