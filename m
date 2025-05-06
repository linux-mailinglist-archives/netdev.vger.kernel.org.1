Return-Path: <netdev+bounces-188331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B9AAAC34F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE21A3A9182
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07EE27D795;
	Tue,  6 May 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeJ+1APU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E555427D79F
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746532898; cv=none; b=f03YrVhD3NWI+t0Xsyl41DHflcpOVWTHUsfK/WAgH4dOVNASnbTeWImd0Pc3o20VvNO2EC7+A0AWoNhofiK0zo50Yv6xw4KuDKurQtHWnkNvERNoojtXc56BV5bvDcFWt5I51Cm2kybdDpSyGGUAMtjIHc8HN1CGLfG1vaSEwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746532898; c=relaxed/simple;
	bh=Z37gF02B/OfMnXVFT/5Jd8BluHb2CJn2o1PFfxyt644=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfNBKBCIh/p7Y8iKZYYGxNtuttY8M6srn5Dw65yM02OBu9faYKP1WzD3Hmugyfy7ngXdpcx10niZUNSFDesChdYyBWJvwQPyHm2Oe0dUZIUx+PMPJ+g1ahzokzoNz+pCrRy8hYfZNEmXCC7gVb5Tu8oQK+ALLPubvHoLl5qN+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeJ+1APU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746532895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEGFWrosl3VoqVbXokjUoudcmxyIe2gM75ojNt42FAg=;
	b=BeJ+1APUcBUtNarMaqO45juEgjlBuiBYHK7qDlV2hB8qdk2vaPWh7LIBMHd86YuMEy9dSG
	y4M+WB+d+GvEFEjq3yZXpxzDnKIc94QyerlTGKGCRgDsl0bAOiWA2aVXreUBV8Deq/kG5E
	/6h3z21cC/7TxUSsKHvEGjiYh/TM1k0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-BENtlOd2PeSXJdgUPXgkHA-1; Tue, 06 May 2025 08:01:33 -0400
X-MC-Unique: BENtlOd2PeSXJdgUPXgkHA-1
X-Mimecast-MFC-AGG-ID: BENtlOd2PeSXJdgUPXgkHA_1746532892
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so31255725e9.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 05:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746532892; x=1747137692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEGFWrosl3VoqVbXokjUoudcmxyIe2gM75ojNt42FAg=;
        b=dQ8G9+7ZS2wUBHuP7e+33OJrjQv8F3tynWK/dW8vE27YZRCRN/L9J7hfh1AFwgZ4pO
         DNgM99FPcci7buPoxpZjIWXow1zl4VTlswCgUx1ZtkITKb62AUAn7Vdr+YlJq1QRqzYn
         b807I0imrPCOHeYT/UcJdsYVtS44V2at2nj+GNuucJTIt6Uw9I34+V02mIS03WHha8T6
         FoPRt46h8rfCyoFHWmGCvtVa4ZAWeQaB3BuQOOuLi5+PPj8rO9CfC61fjQc77lZymBS1
         LYo8bqlz2KqxkVHHfpOeQwhYYL6giMytgCg7CzMardMzMOk4yAXjSgvF40acibED7x1K
         OYjg==
X-Forwarded-Encrypted: i=1; AJvYcCWm+H1zQjtBPzCkfPaHPL0OfWIMgW/rwHalTZ0vzk82sNRT0+IEwrD3wcWqrfX0waLVhar2dgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcjbm2vI+uogUPhEsz5QdNL4aX3Vv/jDlixvgYLnvTLq2rRMW+
	V7vvyKHrEXdhlXzvPSD+tt6yG1Pz0rnZ8A7jzTozO+/Ad3tl4ID/hxQaHw4iC5GdZb/25EK0Q50
	h/7FvulETGc8EelzuK6QaYeQGI2/Av4AJPpVNpzVDO+gBrqmo3FHQYQ==
X-Gm-Gg: ASbGncsii9XIyJeCHpnhbZuRpxMHbT4KeoRxqWd3vT5aJKKwF2VdgFC1/Eto17aXEta
	/E9FEyVVhG77CGpwR5bSyN+UeQ4c513MMGZis6R6IZTgRGfBfa2j/R4Er4ISgK4kIWlgVn7VJth
	GyAehc+cz1AIY4d8660f5PkL+vq3rUBvivjg4D9k56XoxLBwVLxOS5OC33XMC8JutNDX3nH6ZbW
	HXAkiJAoagASNu03ne3zo/+3/y6FFAEUs9vtjODLZWfn71GLsRv1hi8KkPFylxcbWNh8xFvMJI+
	vji8GD+cBmteI/a+vx8=
X-Received: by 2002:a05:600c:1c9a:b0:441:b3eb:5720 with SMTP id 5b1f17b1804b1-441c494727amr86568455e9.29.1746532891923;
        Tue, 06 May 2025 05:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGew/auOGbxpBOlRwO/E2Pbf6uXGwBgr0lqqeeBhap+yJc8684jCWwviQSnaF02EszU0QJdVg==
X-Received: by 2002:a05:600c:1c9a:b0:441:b3eb:5720 with SMTP id 5b1f17b1804b1-441c494727amr86568075e9.29.1746532891622;
        Tue, 06 May 2025 05:01:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010::f39? ([2a0d:3344:2706:e010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2aecb54sm210786005e9.10.2025.05.06.05.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 05:01:31 -0700 (PDT)
Message-ID: <d44a2ddc-0cb5-482f-b208-7f866463fc42@redhat.com>
Date: Tue, 6 May 2025 14:01:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 00/15] Begin upstreaming Homa transport
 protocol
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <CAGXJAmxWSoP6=WHBBpafcpJB90Di9rpZ7TCG4qDNg8qtHE6LzQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAGXJAmxWSoP6=WHBBpafcpJB90Di9rpZ7TCG4qDNg8qtHE6LzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/6/25 7:04 AM, John Ousterhout wrote:
> On Fri, May 2, 2025 at 4:38 PM John Ousterhout <ouster@cs.stanford.edu> wrote:
>>
>> This patch series begins the process of upstreaming the Homa transport
>> protocol....
> 
> For some reason patchwork has not run any tests on this version of the
> patch series.

There has been a transient bad state for the nipa CI infra. A bunch of
series did not enter testing, among them the homa one.

> Is there something I need to do (differently?) to get
> the tests to run?

The series should be (hopefully) tested on the next submission.
Important node: do not rely on the nipa CI for testing: the patches are
expected to go through similar checks before the submission.

Cheers,

Paolo


