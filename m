Return-Path: <netdev+bounces-170225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550AA47E09
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C883A6FE0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679422DFAE;
	Thu, 27 Feb 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bck2HsvZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C022D7A7
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660071; cv=none; b=borokL5zFhjIxsUKzHaNzPLZom/RoF2vfNnreMXhi+l5wvhETV1lgRKDnquubx1mKQfXwB32D9SzvlZYBspqE5c9oP2S3rOAHgHd/MUymHpn2IvObJ/JiV27YrmM4Oqx/7/rZYS/7+J4ayXheKYqQpFsgMGS5JHyDN/rQE6pPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660071; c=relaxed/simple;
	bh=V/uWrFw0n6vxT69u6H4TPbbmjz5vMH/2lfvgjrvFrO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvFWypzo6oodzxNb5+BAd97c5QM7zPRXslHKWan/aLv7E43M9KM3UobvrdZS5fHxKdMnCFbSVY1Oiey0xpsVM77coGwHq24QG5CJzBwFckic5Hmw5tQFzY466I2oyaJO4uwl0wWMo22Z3QB3sNJRv/x4tQYXxIXQA+IgiklTX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bck2HsvZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740660068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTINDLfPqxfQ8l+8NKRPBU7gjazJ+mnWdXheSYtrXNU=;
	b=bck2HsvZYFQm2uYZxjKDkxTG1a1p2crIdRUHoeFtku5i5ZCzmhG6Tm0prxGHOCf99UjeAq
	7r2UIhpT4I9G5qjKJVJfm0rm8UEBdcD23wN7Fecrz3h8SQx1fK8pH/BaSGNrrtCw2LD6FY
	t5wp++l/8aZxPnLveNijM2Vz7RyaDVI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-dTyja7fuObK6bfC_kvNcwA-1; Thu, 27 Feb 2025 07:41:07 -0500
X-MC-Unique: dTyja7fuObK6bfC_kvNcwA-1
X-Mimecast-MFC-AGG-ID: dTyja7fuObK6bfC_kvNcwA_1740660066
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f4156f3daso601972f8f.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660066; x=1741264866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTINDLfPqxfQ8l+8NKRPBU7gjazJ+mnWdXheSYtrXNU=;
        b=L/sTVH+RO8UuyrpzDYQpeT9JPEtMSFA45nam4MWF3gXjG+RoOjr2bm2GNLZWyNeFy9
         cpPWcxHvgNWkBPSeA0YatYFg/90KO00y8eRhbal6wCM5UV+1qVkOMgoh+kNIni8eRT/3
         4x8Y4x9+L7SMYYDViGNf2OmflXN13RIYqBsncAFX2W8lYZ4+WBG3T599TSbJ1brk3XsM
         0Td7J0ODrbj9F3pbyU72rFVJXUbDLCQTcAITFRx76ReWwUawRINd0bhQ+EUZ7pBhXIyr
         U1AaHqtV7FgSfdeD8Ved1QSsMII2LTojG9+3oHfG73U3C6vQgb0QU/FpXvVRK7BvOxvP
         tdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBWRNnDzflZxwH0Qy+m4c6fj4Z6xchxQj/0afDfQm4/KjC6g0hdXrkQY2N6+9weJSvaN2s/hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3Qam+Zu96gdfXv22d7ixZo0vbcH2KlnIHFXSVqlvpj3+0AdM
	Wq3NrC/dJu/K/xiyWySFVT7MtW6F5yksN9dLEgyp75jNyV0Fho12lwcZoRIEYFm9UOYng6FUvDl
	kHrNMkIpVqCu0BWrIlfRpG8vyZXlNkqrbNdJQdGGPd9SOht2NoU1Uow==
X-Gm-Gg: ASbGncvj0WAyVWkfV9R4T73uEeXtlVSB2S3NIbGGwKWBSii5SNdVoXBMmfaLvNLIXJF
	6m9lkS/O9L6NQWROWo6XqB6wrhmBQFwVG82pepOj59DOyuRlfAoT5kYaDkjt4NhhKkkEdWuhuLV
	MhdFgOyiabwoZK0DqB7Bqc5oGrvbJU1Gdzw79JQPfR2cMD22lQ2MC7WQXd01Bna+p6t95LNnFGu
	IbaxpMX55Bvi50N34uHpexSZh4jB4IGlFkJNmfs5/qRLDTNZ4AW4D/qqMDKdhVbSfIiNEQejhp6
	2TXsz9n6PVGgSNuR/kd4pJG7Gf7JO08cL+aREdGxgdFTSw==
X-Received: by 2002:a5d:6dad:0:b0:390:e018:6435 with SMTP id ffacd0b85a97d-390e0186916mr5028518f8f.45.1740660066127;
        Thu, 27 Feb 2025 04:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrultoF2l5s7HDAAETlWCBL1qdXIxgpD9IuaP0L2TDsWz9fpi9ZRFzjdSJpJiWmnDROX/nCA==
X-Received: by 2002:a5d:6dad:0:b0:390:e018:6435 with SMTP id ffacd0b85a97d-390e0186916mr5028492f8f.45.1740660065714;
        Thu, 27 Feb 2025 04:41:05 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a22sm1912237f8f.74.2025.02.27.04.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:41:05 -0800 (PST)
Message-ID: <7306618e-8c30-4963-96e6-c0b58a5bd88a@redhat.com>
Date: Thu, 27 Feb 2025 13:41:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR
 annotation
To: Arnd Bergmann <arnd@arndb.de>, Jijie Shao <shaojijie@huawei.com>,
 Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20250225163341.4168238-1-arnd@kernel.org>
 <da799a9f-f0c7-4ee0-994b-4f5a6992e93b@huawei.com>
 <c0a3d083-d6ae-491e-804d-28e4c37949d7@app.fastmail.com>
 <3e477135-981f-49bd-8e54-0c3ecdcc8a19@huawei.com>
 <c28e16ce-d535-4af4-972b-e19376833235@app.fastmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <c28e16ce-d535-4af4-972b-e19376833235@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 1:03 PM, Arnd Bergmann wrote:
> On Thu, Feb 27, 2025, at 12:53, Jijie Shao wrote:
>>
>> if CONFIG_ACPI is disabled, ACPI_PTR() will return NULL, so
>> hns_mdio_acpi_match is unused variable.
>>
>>
>> So use #ifdef is possible and has no side effects, and many drivers do so.
> 
> Those should be cleaned up eventually, but that is separate from
> the build warning.
> 
>> Of course, it also seems possible to remove ACPI_PTR(),
>> But I'm not sure if it's okay to set a value to acpi_match_table if 
>> CONFIG_ACPI is disabled.
> 
> Setting .acpi_match_table and .of_match_table unconditionally
> is the normal case. Historically we had some drivers that
> used of_match_ptr() to assign the .of_match_table in order
> to allow drivers to #ifdef out the CONFIG_OF portion of the
> driver for platforms that did not already use devicetree
> based probing.
> 
> There are basically no platforms left that have not been
> converted to devicetree yet, so there is no point in
> micro-optimizing the kernel size for that case, but the
> (mis)use of of_match_ptr() has been copied into drivers
> after that, and most of the ACPI_PTR() users unfortunately
> copied from that when drivers started supporting both.

Makes sense, thanks!

Paolo


