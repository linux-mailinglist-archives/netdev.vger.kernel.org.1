Return-Path: <netdev+bounces-194725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A793AACC22D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1218A188652E
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1957280338;
	Tue,  3 Jun 2025 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMtejok4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27F2690EB
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939412; cv=none; b=mljr63glhctI+m4zFPU/9lvAIcpIgZO1bOxNXEpNGSvoAyuu1YNKs3amgx7u6CL22r7y9BCIVuWnBrhhtBbEdgXhWZnKEvvz6mB1Q/Kyd1X5uP1t+LFIylDIcDJReCnBDy62/x5ResNR99pZYIWd83NRZ/S9ylkaofoyOYvqjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939412; c=relaxed/simple;
	bh=NM5hKygr43dOmoJrxhszf653v1W3nDujh9/gFHnRQ+k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=PQ4yOGqJR6HOAO8qhMNPJzSV6SDKWzn+rZEGnZ8jyZHU/nWDZaz6zzBHd429ZwVR+SvMMwcMI6ndbUXoVLBWAwQ07qGBx63nd1f80RDd8OKqpf3JPDsHWQiiUXcN/ixWBgn1PmGGMqNax0GL9dy8jLdZQgwGUffywOKV64Jvhss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMtejok4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748939409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOjnN0Czy7oxBE7Ou95cHabmenVyP6K+fc9YtVb6CZI=;
	b=UMtejok4wDllj+ZLPHdCuIqFqYzDODoP/iCGd1xpq++OjXSlQNs4TDEGCiPPr41GP2gWHi
	ostkqhzW3G+oLN8ifTu9oUiFb/0VfqTR9/ERSdjdTi1YvtO6v7xVR0e6Df/06jHrsJRSo8
	+fkw/c3jEQ6RgXp9GxRUd54+gxiKBgA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-p8fJY7Y_NgCiYe_Xu57rrg-1; Tue, 03 Jun 2025 04:30:08 -0400
X-MC-Unique: p8fJY7Y_NgCiYe_Xu57rrg-1
X-Mimecast-MFC-AGG-ID: p8fJY7Y_NgCiYe_Xu57rrg_1748939407
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ebd3cfa1so853065e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 01:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748939407; x=1749544207;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOjnN0Czy7oxBE7Ou95cHabmenVyP6K+fc9YtVb6CZI=;
        b=rdX/yLwLROa7QPYH/znDOFIhMsPIj8EJ/q9Q2JZZd4dFxI6tviHaGNQ6wsDLXWH+D8
         VaUy9KffVafIyqP4WIUP17rgtVPRJCxlbeZHNXf87zqwmhctCqcuytdbnmjQMY7Htf5J
         +Vprl8NDN0gUwby0fm+Y/6oFxnIHzyq26Nk6iQ7boLY1gD8w3gI4fRe/tTTOv7PImpc3
         J3Q/EtwNSLfHxa2Nj775sqbWLoPd4iq6Tl5AfOnPXctoC2iDAmjLrgHQ0VB8l9/CBMqH
         D7lh5cDHppf+RXr6Zf91I0UMHFCoUw14whjpn3UfrnG7bMLC+oQkvP1PRn9vdUdOT3M8
         dSmA==
X-Forwarded-Encrypted: i=1; AJvYcCWBVcWzzrAMbMsvx6XMTYjue/wtuMWGODKeoAjWD3L4ogw5sb3PMFe2LO12O7xEGTxZ8K1BcQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqveGiovoEgpVSewojuuxkKz0resVzayrcXIk+LQJrDL/0WYxl
	b//BLMyxI49D6PZI43KdBWDzmrfABFv8uYhFr1F0lWxMmrElvbmonv8g/3f46lmQ1lHsq9Iem0Q
	erZjRiLNNghCYjHohgrhE29DbOy0fXTHED5qtIxFRMsmQ7nx1GiomEUTEJg==
X-Gm-Gg: ASbGncvy1lnGbkVJUEfqDrtdg72/b4s8DkLFQnMK0UIYXcBY8oeGesqOEpZ+RGz7wr6
	CSludAY+gN3QcwgS9nB7zVAVRPTTerHcydebi+MWll4GCM4//pDsi5paS9UZ217M6k5Ff0p6arX
	zCH7MJawVfPDrIKDn7Tw3mZ+jeHrWri/EjlXsmkzP9O4br2pGDT/p6L/NklOyZdTGhd7yIhHxpS
	o2CBCvzMx/054wUQlQCfWShWWpfg+8tt7GIftJO0Ld141tAlFiNCvxEKUqOwnLjoIdk0sWirY4E
	2TCXQ1r8kQIpCab6fwADa1t5RFN/fBsbVFG96ul+sdRQ4htQzqDmadDx
X-Received: by 2002:a05:6000:26d0:b0:3a4:e6c6:b8b1 with SMTP id ffacd0b85a97d-3a4f7a1bfa4mr12863007f8f.17.1748939406954;
        Tue, 03 Jun 2025 01:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqRrkNmOHAbZ39YcMMKj0jouOrajOti1ECJWOYzhZkJ3X24YCAG3yGNJkMcvDoId8mlKAeFw==
X-Received: by 2002:a05:6000:26d0:b0:3a4:e6c6:b8b1 with SMTP id ffacd0b85a97d-3a4f7a1bfa4mr12862983f8f.17.1748939406555;
        Tue, 03 Jun 2025 01:30:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f1afebsm152655835e9.0.2025.06.03.01.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 01:30:06 -0700 (PDT)
Message-ID: <1d85ad0b-8f3f-4ab1-810f-0b5357f561ab@redhat.com>
Date: Tue, 3 Jun 2025 10:30:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] wireguard updates for 6.16, part 2, late
From: Paolo Abeni <pabeni@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
 kuba@kernel.org
References: <20250530030458.2460439-1-Jason@zx2c4.com>
 <c2025b81-7fbe-46bc-9a20-f9a61b3e22f7@redhat.com>
Content-Language: en-US
In-Reply-To: <c2025b81-7fbe-46bc-9a20-f9a61b3e22f7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 10:25 AM, Paolo Abeni wrote:
> On 5/30/25 5:04 AM, Jason A. Donenfeld wrote:
>> This one patch missed the cut off of the series I sent last week for
>> net-next. It's a oneliner, almost trivial, and I suppose it could be a
>> "net" patch, but we're still in the merge window. I was hoping that if
>> you're planning on doing a net-next part 2 pull, you might include this.
>> If not, I'll send it later in 6.16 as a "net" patch.
> 
> We usually (always AFAIR) send a single PR for net-next, mostly because
> there is no additional material due to net-next being closed in the
> merge window.
> 
> Anyhow I can apply directly this patch to the net tree and it will be
> included in this week net PR.

I'm sorry, I rushed my reply a bit. Could you please provide a suitable
Fixes: tag for this patch?

Thanks,

Paolo


