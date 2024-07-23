Return-Path: <netdev+bounces-112555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94A939EF5
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 12:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC6A1F22CA6
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E73614E2C0;
	Tue, 23 Jul 2024 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X24l/kxe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5607113B2AF
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721731686; cv=none; b=EXUJMTIurXIOd8QzJJsf+JVwul8sMEr8ajpKoiA/u5NGA5uHwGRgIM19xtLF/I0peB2E+y2LQUAx97zSoXev0jgt/Y5Rjdtpx5fGk26Rj7pAeBSNxO+sRFJ9+QOBaHIHinZfjPWJQO3SZEjz+mmNlc9xhWZmU6d9gMpgPTVGhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721731686; c=relaxed/simple;
	bh=RY7EnsG1MTgKyezKOtin+mxYZEjmtS8rBOlTFH5iXWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJkjrRduJ1v9hUnq/xIzVdA8u4Zz4j+h6Hr1YISLJj83unC+2Kyo187xvk3FDVeZ3X9LeTOo794GU4o5v9nfrCnGqmDKYQYpVTWRudlPuDXko0QTM9CX8E7uOgpskppN63YQGATldR1mae8j+zT+czOGF+Z499V+oYETvmgpGWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X24l/kxe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721731683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=is9xWIZrvGL56gb6eZbS8C1QxeZEh2O1wu5yRn9CgAE=;
	b=X24l/kxeg/RdlXJ0dsgX9ztzX/wqzipTQunTHuMZBLohc2k+OPmb+ANwMlXhOZbBxFrOAP
	IYDX7uhEdoovWbndO08FMo9zaL0X2vvFGWSs3Vt4FketUujJlQWXQfvIVGhxnIrvmGU3fT
	I42lEw3qW/gDG5mn9gp9hVKIfaIz9wg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-wM_qRduGMNmDQGSBGZYfbQ-1; Tue, 23 Jul 2024 06:48:02 -0400
X-MC-Unique: wM_qRduGMNmDQGSBGZYfbQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42669213f26so3356985e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 03:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721731681; x=1722336481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=is9xWIZrvGL56gb6eZbS8C1QxeZEh2O1wu5yRn9CgAE=;
        b=CCllisipho/jJESH4vlTh2yozNvaj6F3Qd0/GGzrhovwaQkvgtLdFq0DsDi//wg8aA
         w+bCT5RHDgqN7RmgTD5vnRIzC7gHXyfwsEPCDC0WVTbEiPRTn+P9s6ROYlsoOwKoxs1t
         sT48b4IRGfmo7fQuLa/x0x7ktZRzqLqIYWVZvvjYzB9kggStbJwHam/w9c2MP8Csbg7K
         9RO3G85b0kMpyOTJE5nTlPNMCXTf7/DcsXdlCOuUD4tptdpBPtEbqI6nAAe5EyFL7Pu+
         X9VXEkZJcub2iPXtpJlAQC7CN2m9Dcl2mOsHBBXD3CJgVZjCr+8Lz2QL1h9DUynOUG2S
         oehw==
X-Forwarded-Encrypted: i=1; AJvYcCVSNCEi/IGXMu0CBgTtef7KwxDG6J1W3PD8y9kspUNCqPyftQmNOUq63RtGfd56VwjdBlObFlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwu8Mmzl4JPPB9Hp3SIdCgoPRjxwZmlxUbg1wvWnDXLAWT5Wh
	czLEA6/90ozgIIFk65816l09z0WXRzQiUP3Iv+80j9/IToDan1KpezhnwYF0tq259DPwEDxH4oD
	TXR1cf0eiDCoxpB7pvNyYL1/M9omFcC0t9jaSVjaFGDbuvgUFsF5/Mg==
X-Received: by 2002:a5d:64aa:0:b0:35f:1edb:4695 with SMTP id ffacd0b85a97d-369b69b281cmr4252147f8f.6.1721731680714;
        Tue, 23 Jul 2024 03:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE94TBZ+l9LWmG3AlUC+F3co0i3kwynKDwsEMBfPu08pu42j4GyNtxN5Bczw3XZRNRFgmnKqA==
X-Received: by 2002:a5d:64aa:0:b0:35f:1edb:4695 with SMTP id ffacd0b85a97d-369b69b281cmr4252128f8f.6.1721731680185;
        Tue, 23 Jul 2024 03:48:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684225sm11265579f8f.9.2024.07.23.03.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:47:59 -0700 (PDT)
Message-ID: <b9517ec9-dbe1-43c6-879a-438defdc201f@redhat.com>
Date: Tue, 23 Jul 2024 12:47:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: fix the mistake of the device tree property
 string of reset gpio in stmmac_mdio_reset
To: Zhouyi Zhou <zhouzhouyi@gmail.com>, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, mcoquelin.stm32@gmail.com, andrew@lunn.ch,
 linus.walleij@linaro.org, martin.blumenstingl@googlemail.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: "zhili.liu" <zhili.liu@ucas.com.cn>,
 wangzhiqiang <zhiqiangwang@ucas.com.cn>
References: <20240720040027.734420-1-zhouzhouyi@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240720040027.734420-1-zhouzhouyi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/24 06:00, Zhouyi Zhou wrote:
> From: "zhili.liu" <zhili.liu@ucas.com.cn>
> 
> According to Documentation/devicetree/bindings/net/snps,dwmac.yaml,
> the device tree property of PHY Reset GPIO should be "snps,reset-gpio".
> 
> Use string "snps,reset-gpio" instead of "snps,reset" in stmmac_mdio_reset
> when invoking devm_gpiod_get_optional.
> 
> Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: wangzhiqiang <zhiqiangwang@ucas.com.cn>
> Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>

Apart from the more relevant concern raised from Andrew, please note 
that you should avoid empty lines in the tag area, between the 'fixes' 
tag and the SoB tag.

Thanks,

Paolo


