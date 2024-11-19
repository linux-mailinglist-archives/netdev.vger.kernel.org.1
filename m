Return-Path: <netdev+bounces-146214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A99D24AD
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 12:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5192283A08
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A9D1C4A36;
	Tue, 19 Nov 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwTp4ote"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB711B0F2C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015093; cv=none; b=FA/2wI6JcvIN5sti7T/IKqrMNX8ALqxGoB2LKk148Z/H7EeJYSQ5acMrACaD6/M4dFvpISv5zW9IX152NXpyZzE8M9OE/Zy1IfHFX2fiGpFaBbcms0V4XVso/EBw6CCO4P2/OOXF1cYg0pxSrrkuuTiPFahGOqxCtIAZhCzaixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015093; c=relaxed/simple;
	bh=7KnqngzIweImov/bg+EQOYAdCfmPCJgVOCZnMrcp46Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCowg70WFW4jJi/ukWG9ubzaRp0jL71VWnP1h9MjaW+jRm9zFwPRCvCqvr3vhV6ExMIqFntd/A7U/bjlU1/hsOo4SOncZe37421clXfdXrWWmv26lmEOYw8+e+k0CWiv0iiyZtmYIreaG/xoIyamJcAmz3EWR5ZUjuk8v2Y+5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwTp4ote; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732015090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSBouoRatInqJbfUCy4gUiCHF5kDVST7sA6zTlqHn1A=;
	b=IwTp4ote9IueFqjdrOqb80yFNlFWNE3R/MdBi+Baga4oH+PXOF22U5lC6FaMH2IY4DEowY
	o7+3RiYKCOybspGmokhMBGYA0xQZDWKGaQ/Zle8JPF0vDv27PljrvIB/ruzFOrye4U623d
	CCo0KKx2KmSpzXOg2PbchL0FHH+41Io=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-hQK-KUmKPGeLt91iTZ6ieg-1; Tue, 19 Nov 2024 06:18:08 -0500
X-MC-Unique: hQK-KUmKPGeLt91iTZ6ieg-1
X-Mimecast-MFC-AGG-ID: hQK-KUmKPGeLt91iTZ6ieg
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e388c4bd92bso4032667276.1
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015088; x=1732619888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSBouoRatInqJbfUCy4gUiCHF5kDVST7sA6zTlqHn1A=;
        b=CrCjIr8h4Q+KtldUUOoIgDIY+9FqYx6GnozGQHBft7uN6aT7i1HvJBf7XIz2BTSaKO
         2mrBdEyjB6JrmqtNJvCJQTFxYEBlzWYsciv7mi4irGZrySflcu4OQBgh3ToR6iD8kc4b
         HMUa0qhwT6hAoR/+T1FpUyionaq+QMoHz6RebRkZQZmxNWbT+PtZwEXJbdY2qbpYwjv+
         Zz3seIRHwyP1mHSGzPdYzoR+7tC0myaVMOVrULIeIixWNSDwZFbNx9hON/6b+MkLfyUv
         dxUHCyQ2APzig0FzrArEnh9lzPefRuzOD+MA97Zj2NXHx7qZtMAEzC2NlgzBis/aSls6
         TejQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhAKDgeRg5TGcDLF9se1zORpXO38ZC2YXSDzzkfMhWiPBMmfiwbe4CEVfMJwoDO8Bk3/z9Lxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrUGiv4p9SHraj7ah2PJCVbub1rnxBtqoQFy5wGVFwzhE/K1x
	NUgkObo8PZFRBSrlvrIKvScfE5kIYPRmGf25SGJI9O6Y6yhe2x30y2A2vIh+FsDk8Xv/I/fBFhM
	EGaHAI6+23oxVm8FVMCPbFlM4YaFJEINilGSHuuXTZHoa1kc2APbNqQ==
X-Received: by 2002:a05:6902:298a:b0:e30:cc00:b010 with SMTP id 3f1490d57ef6-e382614f9c8mr10200264276.25.1732015088320;
        Tue, 19 Nov 2024 03:18:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE96zkhRwyQeB2qy8231vJaIKfZPGcGVKna3QNScGbU8jvugvr7WKVQycq/NpiNX4wDg/wBiQ==
X-Received: by 2002:a05:6902:298a:b0:e30:cc00:b010 with SMTP id 3f1490d57ef6-e382614f9c8mr10200247276.25.1732015088026;
        Tue, 19 Nov 2024 03:18:08 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392c44142sm9845691cf.85.2024.11.19.03.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 03:18:07 -0800 (PST)
Message-ID: <3cfc2e90-c9b4-425d-80f4-ddace9aff021@redhat.com>
Date: Tue, 19 Nov 2024 12:18:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add standalone ethernet MAC entries for qcs615
To: Yijie Yang <quic_yijiyang@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, quic_tingweiz@quicinc.com,
 quic_aiquny@quicinc.com, quic_tengfan@quicinc.com, quic_jiegan@quicinc.com,
 quic_jingyw@quicinc.com, quic_jsuraj@quicinc.com
References: <20241118-schema-v1-0-11b7c1583c0c@quicinc.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241118-schema-v1-0-11b7c1583c0c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 07:16, Yijie Yang wrote:
> Add separate EMAC entries for qcs615 since its core version is 2.3.1,
> compared to sm8150's 2.1.2.
> 
> Signed-off-by: Yijie Yang <quic_yijiyang@quicinc.com>
## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle



