Return-Path: <netdev+bounces-225546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DBFB954F6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEB31691CB
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637231E0F4;
	Tue, 23 Sep 2025 09:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNokWGAa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DB2741B3
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620872; cv=none; b=chLU94a2cPIStNhqmCFuejVZlPL7A+enS/TE8B3V5AbC4oI2vkRJZNdoMhB0gAmyMmMV7AvXq6q4vPJ87nyYrGhlKQQsfF2tPdpMI3dhvdvDVbBZHlfSzL4H3FzAo+P6+2UvwQ/MIX82tv7SRiZySFmk+q4ihBns9qUM83HD0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620872; c=relaxed/simple;
	bh=6NephiHlDDWZjUDgQSNZd+O1MAHNoJ8Zj4QSD6tMBlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJADc0X+95Fupcv45tdTOj98b7b0IpJHK+8BOCEfyPPosKcDl0LLh88SbVRDvtNYQp00aDF89LbQhUTdmezIV6kyvUejOeLJs6xYOCcx+LgZOXb5c21jypF17SYvsIkbjjNiu+/rM4r4el7Rj+kFKsFgAmtHVr2EJ/YMXVcZhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNokWGAa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758620870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3zbNBHZeX4u7pe1g8MFTz/QKax3NsVn23uV23hW5+U=;
	b=XNokWGAaoUAJ/P1KyfRmVDV9bYGvfZPQj8Tyxr+FQeu1D2+7tCn9c4gQHonAxN8SJUNv6g
	aKMcjOicXB2t85XbCFW4cPxhH2U06WqjQAm1SLsnZjIclY67JM+FW82xak4WU7Z+09j2Go
	CIGRSE5IOib5NKtjMhbw2jyEbgT2ZIg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-0By-Z1XFPLi68gzMbm_FIw-1; Tue, 23 Sep 2025 05:47:48 -0400
X-MC-Unique: 0By-Z1XFPLi68gzMbm_FIw-1
X-Mimecast-MFC-AGG-ID: 0By-Z1XFPLi68gzMbm_FIw_1758620868
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45df9e11fc6so31327985e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620868; x=1759225668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3zbNBHZeX4u7pe1g8MFTz/QKax3NsVn23uV23hW5+U=;
        b=oD2ktF8KZaAnnjkn4lzKDSE6DAFx7+thL3KP0PUen5YXQ7Avep7xA9Wx3zsV1QnXcL
         IlOo4jIl66z9c6m68J9V0zxt8Bp89lVnpkEeE8EGSXEUDonnYCR5O3BscQmIAbscMhd3
         0CtVpXg1zU6JlDLgp9dCmxiAm8RsGDCATPHtqGhbFoWGqFa+wZqKpzVAeyU4GfB7jnrD
         wmpBT+f0q6wUT4QuU09Uz3Z3hWVrx5Z1o82aK0/e9/1GB7a/3WnsRmkaGqTKvTEIlxOa
         8wvpzttWxkyh2U2WE8Hm26wHXgp/y0fTxN/WuDJ14KKupXQjNW/SPsXirBmB0vvkD3q5
         WYIw==
X-Forwarded-Encrypted: i=1; AJvYcCWnuOvhj8BrmN3VwuoddI3riMgQ27DfXqYYmhRPMxsl0/nEwkLXhpcd+gz2JsL8/a82wQosOKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgl0tWd/25J6MUVu9uvejK3VuYMt7W/JYkhFrGz9C1dXVg6Xpm
	W/NKwsxjL9vpN63mk2dvCiRpRNBWr3NK4mEfHuEageCRSriZPojbUKy29C8KwhyiY0q9A17zOvq
	cm7M4cWczBTbmkoNwYFakOLB+0ldFrxF/gLe0ZX1hblKGst+YfQ1xFi7LrQ==
X-Gm-Gg: ASbGnctUE6eubiwjCMJAnqeJYywSH+sM49bJBFpFYBeyCWsyR91bLXQHf4u1fqzRS0+
	3L857HqY5+V9e7OLRdSLwc6SpVHNnKkJIjEAIwVMFbi6gUrFgycRU2xWoSDoGu1swPBz/LqdLPa
	PmOBJ/+LT3lxkwlHyPnGFcnxQ/5gh6TBHHHhrmR2TsEm0v8DoxfclnZbI+TjmckRnLsmQYislo4
	mSa4M22TZY9OhxaoExjCZ0PrfYL7KrzMtgRovN52D8AL4Vbpf2E3w/FA3CYXEbJ5VYgmu0EiUTv
	/m31R+qYhn0tJPq9agDqcSekSpzbmd8MjxgiKPBVAjoVLGigKuUd5PMDJImbIP4kqM1fSog1FF1
	Hczq4DhU/dn/v
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr18916215e9.30.1758620867686;
        Tue, 23 Sep 2025 02:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEejj73xYyvJhtG+80Oo+hw9FL95RSTSMEQ7BHTRfIVzB184Xe9dwz7Q3l23RiwZ/8pTX9Nhw==
X-Received: by 2002:a05:600c:4692:b0:45d:d609:1199 with SMTP id 5b1f17b1804b1-46e1dac9639mr18915955e9.30.1758620867259;
        Tue, 23 Sep 2025 02:47:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm22603388f8f.53.2025.09.23.02.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:47:46 -0700 (PDT)
Message-ID: <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
Date: Tue, 23 Sep 2025 11:47:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Include echoed CE count into rate_sample. Replace local ecn_count
> variable with it.

Why? skimming over the next few patches it's not clear to me which is
the goal here.

Expanding the commit message would help, thanks!

Paolo


