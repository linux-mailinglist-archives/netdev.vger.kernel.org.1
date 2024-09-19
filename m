Return-Path: <netdev+bounces-128897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3897C5CB
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04171B22D3E
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EACB1990D8;
	Thu, 19 Sep 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWaVL2D5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B211990A7
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734413; cv=none; b=OFip9dtNcLLlmy9GCaTczi9WjjFHML6wqqyw5++eRU2ZqCaDKGnDLofth5+gzMTDfpg/lZyJFiC6+3jFp7wscPheB8X15/X0chWWKI6+F+NuCzz3WVMK5sU0E+ejXQbZWDaKWt0ziUbcV21XbdUeT0bzQqF++6mCz7MiWxzWfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734413; c=relaxed/simple;
	bh=dYRXd6FDREmGuCeNlhWySa0+zkeJcyv2/+5FEfbhIZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMZXPyQ+A+RNvp/IJogSzhWXaOXW6PaA38Mr3BxvYqdJXY4mvPsAn11OWyg2HNnF0CIwB0Tbh8fSAk9EeDMdV7i2OThkAoMaJyQKCSBT8m/IlSUah1WKpp6R3lLnpdYoQ/VpidndTRXBskc9PjjCSJso57TNcAb240eSV9dzVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IWaVL2D5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726734410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqhC0wpBsYX5sC0cLoRKsp0VJjTCpEKkewewenMyOfg=;
	b=IWaVL2D5/NabhPZ5lsJZajhH5+dvGbmZHhu9OeZNLbz4fb6nBdBn9FT21jxV/PFeJGQOB0
	pz3CiUkRMhbhUXx+Rizy69jzzYdfU80WQ8X9bw95pxCbYl5zovK4qm0386+GKPCwWIQA8m
	qSjf6mrIM4WonXBbuDK4w4MU2WZVi4k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-E8ykk1eGP_eiblXXNz-oGQ-1; Thu, 19 Sep 2024 04:26:48 -0400
X-MC-Unique: E8ykk1eGP_eiblXXNz-oGQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f7538dc9d7so3830651fa.1
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734407; x=1727339207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqhC0wpBsYX5sC0cLoRKsp0VJjTCpEKkewewenMyOfg=;
        b=jLCDJWrkTEGq6jKX9dgSUaanizmXPZV+j1st32Pw8izu1XGjR8QphqcUM8BTrsIbYf
         cpOx+f6YUMs6zpQZgZ8bhY6k9oA6nwnIhDcvA3ZnfgltZPZ6KPI9MKhnsjA3wMQKVbDw
         4SO7+pop+MuZRYQKlGFNPlX/s51NFI/tPOcYN/pDzAeiNg/sFd/eHOP2KwVKdW6gJ+Uh
         gVub79pnkeL6Y2aT+YWmGy2vzVjIxox4XsP/7nGWqsLwap9L0kXCkY9df+5vyag59AX7
         C2HtIOiu5sVzl2gOhcM9cl3jR7+VYH9sXY7nZ+Gm2gNIOjNrP9ST3ZpQRLTeL8uYsjUc
         BMmQ==
X-Gm-Message-State: AOJu0YwFHiXZJ4dzSp+bPstA9NbkUycQ3HkMmufUnTsOwEBwzxaCVdl7
	7ArvLMcmP5CnaG4uPhIHikBMCadGYkDs0QvNTOjLcd2IF5s8XKkARIz98TIPLUi4BPZQ9BhhTrB
	GBYRMlxmcsCQ2yrG7LFmUXiwF4KhtbP7RRdPBxcT2GlsihquXBVqgLA==
X-Received: by 2002:a05:651c:1544:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2f787f432a5mr134483131fa.40.1726734407180;
        Thu, 19 Sep 2024 01:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtcmy7e84CThTJr6C7Y2pMRiyMOC3s+a/wSmAi31apvwn8jqB0EzCmgZOZqgYWmVjBKgQqTw==
X-Received: by 2002:a05:651c:1544:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2f787f432a5mr134482971fa.40.1726734406714;
        Thu, 19 Sep 2024 01:26:46 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0600sm14565562f8f.9.2024.09.19.01.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:26:46 -0700 (PDT)
Message-ID: <9b668881-b933-4bae-a0da-a107d2b531e9@redhat.com>
Date: Thu, 19 Sep 2024 10:26:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: qcom/emac: Find sgmii_ops by
 device_for_each_child()
To: Zijun Hu <zijun_hu@icloud.com>, Timur Tabi <timur@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240917-qcom_emac_fix-v5-1-526bb2aa0034@quicinc.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240917-qcom_emac_fix-v5-1-526bb2aa0034@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/24 03:57, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but emac_sgmii_acpi_match(), as the old
> API's match function, indeed modifies relevant match data, so it is
> not suitable for the new API any more, solved by implementing the same
> finding sgmii_ops function by correcting the function and using it
> as parameter of device_for_each_child() instead of device_find_child().
> 
> By the way, this commit does not change any existing logic.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>


## Form letter - net-next-closed

The merge window for v6.12 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


