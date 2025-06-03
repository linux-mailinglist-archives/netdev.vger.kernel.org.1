Return-Path: <netdev+bounces-194720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B7BACC222
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C0C7A6401
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A4280A39;
	Tue,  3 Jun 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFrt9hGY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059C449659
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939112; cv=none; b=I546HzPV/XbCdhkSmJViE6Nu9QMHwFBeTz+q2Aiq/MJMrtjY/Gt+rri6zrOCtXRk4npckxkQX4QHBnfHRWCbEjB68W7Z5ZMbvh97QygBo80dVEzJCI3PfKttvO0QGH2YmWxAYj3+B7poEBlCQhKu/b+Q25TyFBMCGqGU/cpJJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939112; c=relaxed/simple;
	bh=AZG0KjzqSjXQ8mmSyRpJHwm4uxvnrlRdzzakG3VXSBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kx5rmViiGXMIFufm+Frur2DymD1wmpAN0ApEolI8+jqSSuP5dwy+z9UFUo/N1QL5awKzpPuLl8y6yBE6DWmGeya1eQenr6sT6+9r/UKkBVQQW5RcxfazXOawk9ZfO98bodAnDDfCCxM3pbBZtDI+0NoC8ONwkw8/Os3CaXLIAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFrt9hGY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748939109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZG0KjzqSjXQ8mmSyRpJHwm4uxvnrlRdzzakG3VXSBA=;
	b=PFrt9hGYukad2+R6m7VbP9DAC+rSGg588TMa8Shq/3coMxdF0/6ESx7nQ9mnTlGPwB4/cp
	gzLfg75nLA9ewZQKrcAgi8u2TvqxiNuxc8ADy2WHS5bnzcFLtj8NKrfDAB0RIu9xgOfUxX
	rdSA1kC1B/hcT9YVVWAZQNScNiZh4PI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Yeze9sa_Nim9UB6eZ609LA-1; Tue, 03 Jun 2025 04:25:08 -0400
X-MC-Unique: Yeze9sa_Nim9UB6eZ609LA-1
X-Mimecast-MFC-AGG-ID: Yeze9sa_Nim9UB6eZ609LA_1748939107
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso28365715e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 01:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748939107; x=1749543907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZG0KjzqSjXQ8mmSyRpJHwm4uxvnrlRdzzakG3VXSBA=;
        b=xFTxS/i1sPUzbG00/CHf3Hx2py9HR2bvXSFH7SE0EAPrJeRVyhdigUHsX3B7oaU+OV
         AGmbR7O5SqiYUsAN6pIz/AlAxnUB8yy3fsYh1MPQA5mDcT36iIQUYx0e4d4P6wU/eSU8
         vfvdrxMCVj/rqAOWaZ2Tlmak3R2eSJu9n4eph721Q4UTDO+66YCPJGR0IWqhT2D4DxwW
         n6SmPsBitZtnUlB2gzNa6wQ2UCK2OMXGwemoHr7gKCv9eYcgMeijKrWqUbee19EXuIPK
         pUxKnt+MfrcskNt7D0CJSbmnT/h0drDXhYE0UTFwC/cDuSzODKGqbb1enWzl3e0ql3WK
         EMYA==
X-Forwarded-Encrypted: i=1; AJvYcCVn+XVxs1CE30oFXbRMGoD6JwwW7M/m0qSm0nsscY4wjETtC8q6aiZtGFF23kbFikOMVxR7wok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcoGQgN7UqhCUuxi6LWT9MtDYLB2ts7fDvRpw4eEcsX6MWV6bt
	l77yfwn1DixXTty4NumSHqcKYc5oDwDszg3jznZZ/f/ZX2xcz49Kpxiw/owmwrfM8za1yvhCk3Y
	fm/WYecn80fGqk5wXW4ELvaAa3mnwayjNgi1q0k9IcChpputc4RUI/PKQ3g==
X-Gm-Gg: ASbGncundhczJm4Eet6vrob/11zvXTxiTLGyi06bGyfhmorX2IQBzgRaCDlVM4H1Ehf
	2+Vxlya7+poOa9JTcUbnjMUsgKVt78vwxhk0hLlo/pqikcpEQy7eelXHr8Wsj1aD9AtJh36v56w
	Trxo3C1s0lpfYb3hnK7NwvCcUSPMbJc7hMAIEsXHN+CeMfKu5L+zA6yiRxJlyM6hQvj/6wkvVCp
	Yi7WkvDXgLZ/TvM/hZaVILBaqGaNbP+BW8YQ9UBWf6ZZAW+yQTgLepxtn/jRqMVm0olV5FpaTXX
	245Vqr0Y5Alnip3fMguw7qjqMEFaL9lybCt0IoQNxHq5a5dsCs4TjDxO
X-Received: by 2002:a05:600c:8417:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-451e5fc2bb6mr16305095e9.6.1748939107327;
        Tue, 03 Jun 2025 01:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz2MKc5q9121L0wKkj9yuqRWUhzQVBfowoznVzcF+ZghAO5FX0vssGu8mOF34AX8Cly0kzQw==
X-Received: by 2002:a05:600c:8417:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-451e5fc2bb6mr16304885e9.6.1748939106990;
        Tue, 03 Jun 2025 01:25:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8f1basm154456805e9.6.2025.06.03.01.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 01:25:06 -0700 (PDT)
Message-ID: <c2025b81-7fbe-46bc-9a20-f9a61b3e22f7@redhat.com>
Date: Tue, 3 Jun 2025 10:25:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] wireguard updates for 6.16, part 2, late
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
 kuba@kernel.org
References: <20250530030458.2460439-1-Jason@zx2c4.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250530030458.2460439-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 5:04 AM, Jason A. Donenfeld wrote:
> This one patch missed the cut off of the series I sent last week for
> net-next. It's a oneliner, almost trivial, and I suppose it could be a
> "net" patch, but we're still in the merge window. I was hoping that if
> you're planning on doing a net-next part 2 pull, you might include this.
> If not, I'll send it later in 6.16 as a "net" patch.

We usually (always AFAIR) send a single PR for net-next, mostly because
there is no additional material due to net-next being closed in the
merge window.

Anyhow I can apply directly this patch to the net tree and it will be
included in this week net PR.

Side note: no need for the cover letter for a single patch series,
unless it's a formal PR.

Cheers,

Paolo


