Return-Path: <netdev+bounces-245490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE74CCF10F
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24CBD300E830
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23F247DE1;
	Fri, 19 Dec 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Frhd7DbG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ndkcv2dz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F49241CB7
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134685; cv=none; b=QEKWdi9tNsxerUCn9oS0vec5eww+FgAeNL0cAlKrECHJ9Z5YBigcaO/Hf5amO1LP0aVx77AyeJqIiztUizQYwDCQAQ53bfAladTYFzMucQ7Ulz42VmYDiVK0OFntLyhcuQsh8nW1HEpwdS8Mmi/zvz4kh5aEksFfGIeiB2M0BJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134685; c=relaxed/simple;
	bh=lqdLSlV/+AAZvMvBSqFuAhhiAAi9gRXTfKrs46fdedc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkrZOQ+S6NGXEFWDFtYWSbMEc+k82JxbFFRP/ZZvjZyas4BhmBkEzoBYUXMhmE7CE9G203F/5tZW/bnQvblgiU+xXQXY1sLJCDGfRc2o472WxgNgFGpZ0qininz/uIZCp+5jnEO8+pp19EHqdCHpIk2td//nTtNn/zWfbEAkXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Frhd7DbG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ndkcv2dz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766134681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJMoqd1fKO8OEBbwlJWa4SvNhhMZvfEzTXvf7u+dka0=;
	b=Frhd7DbGjGPCMcdhdp09rrgELOGsA32Z/nxjibbKQj4Cal3haLodmbbP3OUeCjuZr+QSvT
	AMLARzdVUsu0de9NOovSAu7dL1Ue+rqXywtvWlJLmH9Jhi1NgHmTpu5gqmQDvGLTWkyI41
	V5cocbItyYFW5ySLY8gnanRkMcnjeLM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ivTOqLZSMKS_YkPDl5U13A-1; Fri, 19 Dec 2025 03:58:00 -0500
X-MC-Unique: ivTOqLZSMKS_YkPDl5U13A-1
X-Mimecast-MFC-AGG-ID: ivTOqLZSMKS_YkPDl5U13A_1766134679
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4310062d97bso683357f8f.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766134679; x=1766739479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJMoqd1fKO8OEBbwlJWa4SvNhhMZvfEzTXvf7u+dka0=;
        b=Ndkcv2dzxfjzgHnWSIQr0WMcd4J7T9tBBJIftDaTp8b+RM4+WP/QrXzFcxKJlpTBAG
         F3HyFDYplKgsEweah0e205/x5Sq/thqHOuiqP1Q3CJFoPy05wC6JwwTRo0tuDGMZ6opD
         qifTfnMWMO+wW6mTGWxvYMLBXq9ZdYh2w2Uz350zJAdT6n5H7WKxO58UCTnWsMOn5KZj
         VrxTvzWxENaN2nnfZkSjXq/B7/nl/9kfcWG1GoviyTCPFE08j8qX2xQDGsX78qkQAkN/
         7SNIsOJRrfvCkyQskvIqLd4QL+Jd8OGoVozLslMF3rggOgOZlxQTQEuzzei4miIemQqh
         jxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134679; x=1766739479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJMoqd1fKO8OEBbwlJWa4SvNhhMZvfEzTXvf7u+dka0=;
        b=LYl+1Dk4PiywQukic74x8VttAX0Y1KrPWDrpNSenFNn1Ww1NWaewc4nklk6/4bEIly
         q1b/LuzyR1ms+2hYgSOTkSG2NujKLEU2e8L4eu2CnWviLWomnJN2QX8AZ3nUPbGu0F22
         WL+awoDCWPkLgvK3PRkfTp8J89xU44+RMP/DZJR+sgs0Pu+XPJqZSlQzEldkO2kdumgB
         XnPyMK6D4KL2MJVSYJiaYFq3l0rHgpPFxGFl4dS73F/HiwMo6SKkNK53vL/7YGhJBlge
         XTg3CNvhnXi/B06mbl3JOtMEjDcXNsrxDJliFVzyk6VTucs5bEsxRBItzfeApYslhaoW
         6ldw==
X-Forwarded-Encrypted: i=1; AJvYcCU8hq6vAeu4BG6IIql+5m1YUwEbuu6v4L3sQ4pNoZlRRgxpv9ezw+datzkFYgwOSy49+Mn4zek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9w1b0ka7AqvEvyrejnZdgd+e9Yy3iJgW0MiCKIf7S0OM3oswt
	DUzqyYcjaBn7pOZdYs6GtwCjZpH6GxCFKLG+k5YVT2xsMLG2y6zp9VGfBZO/xx7skjX5q+O9G11
	lkhcNl/zuhbfCZNcjZ/kkW/i9IeAgSzXZTAK4Jg/ZJYaxB9lIWpLvTUk6mA==
X-Gm-Gg: AY/fxX4xT4cFNGpo8uzk0RZlmLWeD4Mhl0z9w2b7tVr91T1aCRqRlSP2GFC8uih7BsN
	eVV1d8WxOR8REvdrvO7Op5yrLfKfdGRRe8r6bQlnFp1gQi9SgTUDDohTQEp8Y2vYGtfPl2SJuY8
	opDIdrMir7wXdciHYQRao9/vtprasXaiSxjeKlHEY1hYgFQrHPjWYvBlr0GIkOhtXGupEyN85r5
	3AIEOJFLeKPFxpWvUKkzBc/7O3F/HzENX4hNrQBq7+MtGohEDdbSu5cwhJv+QF/lvVZNJLnqpTX
	YvoI5xrZiJD2BofmblSe387NtWpLkrActWyNUZStLSDpuI9txXbS93cnenMVRj17gVGCLzqdz4W
	iry3nQ81WTchG
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr2398202f8f.46.1766134679126;
        Fri, 19 Dec 2025 00:57:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDZdQNlBKsvc8iTNlAZZskbFNld0WQ7P6WHIzHRIlQXsffoYDVBtRn4k62GVMfIP/FzJevzw==
X-Received: by 2002:a05:6000:2dc7:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-4324e50b88emr2398183f8f.46.1766134678751;
        Fri, 19 Dec 2025 00:57:58 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm3532794f8f.2.2025.12.19.00.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 00:57:58 -0800 (PST)
Message-ID: <a9bbd491-28fe-4ecf-86db-629ac8a2d187@redhat.com>
Date: Fri, 19 Dec 2025 09:57:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] dsa: mxl-gsw1xx: Support R(G)MII slew
 rate configuration
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, netdev@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
References: <20251216121705.65156-1-alexander.sverdlin@siemens.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216121705.65156-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 1:16 PM, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Maxlinear GSW1xx switches offer slew rate configuration bits for R(G)MII
> interface. The default state of the configuration bits is "normal", while
> "slow" can be used to reduce the radiated emissions. Add the support for
> the latter option into the driver as well as the new DT bindings.
> 
> Changelog:
> v2:
> - do not hijack gsw1xx_phylink_mac_select_pcs() for configuring the port,
>   introduce struct gswip_hw_info::port_setup callback
> - actively configure "normal" slew rate (if the new DT property is missing)
> - properly use regmap_set_bits() (v1 had reg and value mixed up)
> v1:
> - https://lore.kernel.org/all/20251212204557.2082890-1-alexander.sverdlin@siemens.com/

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


