Return-Path: <netdev+bounces-150714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCF9EB39D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED4FE1882396
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C841AF0D3;
	Tue, 10 Dec 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9MIdspN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC621A2C0B
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841623; cv=none; b=gG8PLpBukH/HwXod8CmPmJahGfinSQBUIa77qzARhkJwBfjJuoRcp2OvG/9WZc0jXZmifF33fM60YgE0d5zHi/pUagEBueSTdwsH1yyUqTlGPPV4gCdZleSmvdesvuxNGePvM+dD/XIuWZzssUHf3KhwW4TwNF4DLTXRC2z/sag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841623; c=relaxed/simple;
	bh=K04cMagaBpchuVVK8mi6jAZ+WlawF0uKa62wWPIK7pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/pmWoZgAvjk9jr3chmUAmXc8psXBx/Z1Cty8e+zqK4DpiEtxZvmEewpcVxgTGFSZQNgSSHstbAg2CWiOh00CHo75bqd3bs7h9gqF+Geri1UqucEbmBaU3Lb1Coajysu2FgAr3qDxrqFasecIalMeDwkmuRYJmYJ6YplP4wgyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9MIdspN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sf+dpYJ7q1nurpJx2AFEbC9t4IXGmhqZeGI1iMAPf6k=;
	b=G9MIdspNFDtDMfhqJ4pS9TXJsc2iuh0g7mCUc71sXzImyDhl9zCMBIrs6IEIpmVwuT6B1G
	9+XM2TeyCv1wDlx4XvxsfJwd4kAtqN1/x8NMKBYKOuhpvrEUp0/nl4YA2r/wXn4Gzz+kIc
	4371Q1tv+SX4CfX0bOdOr2daSW//Shc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-EOxzC-lnONmDbnGqYPsPsw-1; Tue, 10 Dec 2024 09:40:19 -0500
X-MC-Unique: EOxzC-lnONmDbnGqYPsPsw-1
X-Mimecast-MFC-AGG-ID: EOxzC-lnONmDbnGqYPsPsw
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6e5c9ef38so77210585a.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 06:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841619; x=1734446419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sf+dpYJ7q1nurpJx2AFEbC9t4IXGmhqZeGI1iMAPf6k=;
        b=WLrrKcQuNwOt+b6sZ3+rlyJfK6HjAaa6UPCHeEMSehsNU2g+n7IXs0Ujxk9jvDTYT9
         EhhtfezirVa4EiVAZn0ymk3MEYLsOKDTP5XnUmFWRnEHuYw1JiByFXtd5RA+yrATI3bY
         IzH1xF3Fgj56Bw+I2fPmnjfPRnV68b4a21PprUyKIzXzsoJm8rEsAIZSNcfnkhQ5HoUj
         PU0vc1pp46DcktPjzT4XKnPi3oCeZKv3k1/vzj0h+2Gvt9Oupm61fskY6GflfEQaplRD
         O3kGOb+qEPO6XhGn+98ZAdUlXPwt9Egy30ePdLvYaeTv8+yROb3jfNNwH3+hrNN0vLvw
         Bmuw==
X-Forwarded-Encrypted: i=1; AJvYcCUwKGxyA2+RxTlgKn9rVop9Cwi/Dt/xLDfYlYOIf7pakpu35EeFgD2N+rY6CDGtoHFIO5zgkT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5zvtd1h/nIbIoTlII8X5v3xPUBuscd6dqc1XOc/u05q4sg1q
	VGsV1re6ARdZ2KZuzEbk9QH4WdAvMt31ur8peq6GULtKsuE/iaYHWjdFw8kGF+DtMRKyXcqQ6Ib
	DxbVP4T7v6xbue1ArYrSmnvk/M73nYIL7Dhn+GigwurS4LxbbM7WUuA==
X-Gm-Gg: ASbGncseG1hnVr3uPN5C7IX8TobFIKqhvNkTK1CI3dSBtfCfQcQkXJkixZzA5y6r3Kr
	PQnH4oZHWU2e+jmPlzZ3Tt8tBpiNWmplh3omhcFO3SH/+wERPPqCU/PhCKmzD9yUqKXpWZFmxfv
	56A9tHJcx67rtNFAgFXcu1anIPVPmFUgZxHNZ1JoLyGbsSmAHIFTlrxkUUMF3Ct9zfds6HjplBV
	Nfdf7XJ0BvO5m6gUbfDRw+7hfRCDm6BMTbuobUq2wGsGprphXx4xsdHVy0Kd2eYrHkZZNjLcTWs
	C05YrF1zm8RDkUjwDFp4ysJSxA==
X-Received: by 2002:a05:620a:1722:b0:7b6:d9c1:15a8 with SMTP id af79cd13be357-7b6de7b093dmr611274985a.31.1733841619071;
        Tue, 10 Dec 2024 06:40:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHmvzoW21wgEuDp1BlADeEYTJ+RIX216Dit7w7DCCkJf0bTKTUo78yfn9yMfiaBq4vcl2Mng==
X-Received: by 2002:a05:620a:1722:b0:7b6:d9c1:15a8 with SMTP id af79cd13be357-7b6de7b093dmr611272385a.31.1733841618768;
        Tue, 10 Dec 2024 06:40:18 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a67193sm543037985a.61.2024.12.10.06.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 06:40:18 -0800 (PST)
Message-ID: <8727425d-4012-4ce7-85b6-ee46d38d1b5c@redhat.com>
Date: Tue, 10 Dec 2024 15:40:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 0/2] qca_spi: Fix SPI specific issues
To: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: chf.fritz@googlemail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241206184643.123399-1-wahrenst@gmx.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206184643.123399-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 19:46, Stefan Wahren wrote:
> This small series address two annoying SPI specific issues of
> the qca_spi driver.
> 
> Changes in V2:
> - drop member clkspeed from struct qcaspi as suggested by Jakub Kicinski
> - add new patch "Make driver probing reliable"
> 
> Stefan Wahren (2):
>   qca_spi: Fix clock speed for multiple QCA7000
>   qca_spi: Make driver probing reliable
> 
>  drivers/net/ethernet/qualcomm/qca_spi.c | 26 +++++++++++--------------
>  drivers/net/ethernet/qualcomm/qca_spi.h |  1 -
>  2 files changed, 11 insertions(+), 16 deletions(-)

Even if the bot did not notice, this has been applied by Jakub.

Thanks,

Paolo


