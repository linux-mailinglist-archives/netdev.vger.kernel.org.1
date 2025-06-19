Return-Path: <netdev+bounces-199426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F202EAE0425
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A35A165B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2A22A4FA;
	Thu, 19 Jun 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkqPDTsX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE692264DD
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333425; cv=none; b=qilW2pwKYprm9z/wW1fAvTgLhbzlw4P5mUiRs8Mhdcv8dbw8n0w2O8K2L+02G3n5DtN0D5POYzmcQ7RgugVbGbBLQxYyhJAk0eK3Wo3GNbOdGasYNpts1XurCm+Q5N/zuK68LVGpEhObM1oip6daP+n/QRKTEGzYjCb1hsvgeWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333425; c=relaxed/simple;
	bh=ka2YSkd/50tKtAy/Sw1F5sNt6obV6O6uUBbncHAvZq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7d7gK1w89ePAi1/H+vI2fllUEErZRaI+OIhTtxyd1crv9jaRKjafyeYT2JzOj1Yq77uf5jS6oms9VwGY7HAF9Opw/shvIb7/Txgcl152qQhhPwauFem464DwFo+tc1qi/5h7EyMCK3HaczZGomJ351IIJwrdUc9DGJCvxeE/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkqPDTsX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750333423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir5AYNLTrc0GzMJeSFP3PI0RqKk+EXKa8y1NWCrMv88=;
	b=CkqPDTsXxTiU7c9SLf1QmaZfa4IK/XgsJ18iG9RyqHGwWpea/P0/7T52XGuMnjRMlmDe1n
	mpRi+ky6fTLLHPvbo6Osrn+LXmys7/arwnrgnGNe+1lOOQo4UXsuXJ1SzNC57iTz9KgTFp
	PkfNUYFUx7xpt/DqQdh1y3VRXPJRZ2A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-tt4iU5kGN8CJIWLRqh7ZUA-1; Thu, 19 Jun 2025 07:43:42 -0400
X-MC-Unique: tt4iU5kGN8CJIWLRqh7ZUA-1
X-Mimecast-MFC-AGG-ID: tt4iU5kGN8CJIWLRqh7ZUA_1750333421
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so310140f8f.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 04:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750333421; x=1750938221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir5AYNLTrc0GzMJeSFP3PI0RqKk+EXKa8y1NWCrMv88=;
        b=cn06MP5KtmopCB/kFjJ9whDtlksnVNdAqO30D5DVaNr2JI0tWNlCidZprgD1Yf6Qrf
         YULDLxbvc/E5yErc+C2hMr5L6uhbC2faj70OntQw72KDQ1vO8XxPy7nDG+nfTEm4ScSc
         UDjQ4s3QOpoGC6Z+cT0APGYvpgOpVZjd561kEAIKVhx1NL5k6SRjsIb7TQpG2dN/k4Zy
         vwqIU2G9Kvc9vSfwOZOimMZp6GYZN9qR8zRTWhLiDUEYJ7VcIZKPz/DOt+J5w70kJmJy
         3jL6eOkzXWABTcp3ViynTp1Z+1LLVDqsIW4sGWuwXT0Eof+rmRHf0GF4LpPLNq2iM4+j
         zOYA==
X-Gm-Message-State: AOJu0Yy+LV4aFWxR3JhzNzlvIz1m18S/mCUKThxe4G3vTJBvBEwWNoV7
	M8DX8rsP2B89d8DP/Xz2Yw0v6BcRLHuLmyesmDeuKhPCspVIk0dGU2ENnkUjpOqB8HgpeuWirFv
	vyIKn5peBSgtKhAZIsQS02VspUvI5i6WR9ek1yX7wosV9Jkw3jUeAVn0ldw==
X-Gm-Gg: ASbGncvS3W7S7cLZXLJAJFRsMRNNuX68t4MuLhaGOP0McivLsNgee2PDKfAtIn99lhK
	TdAZGSH1rFxZAliX10b5wnR1iApF2N/Jw2O2soPo7Hf+WzyThq1OiTYnLm6EPc/EAetoZaRwVdg
	EHFLdHCp+OeLzuklng8/PLgNUZHFIXBbLTWyAh+za7bBg1EIq63qIIo7X8qrhLlXPS1qZvKSrW4
	dkUe96gvs+Lg8Lk0zhe0NhdLDV/0wCy51ZH+xxImfgXNum91OYXgREk3Cfn+RMehUjufRjBDvGh
	E8nROjNRpr4jsJuw+hXWcKJMQ8/WFI+H9pI4cKunGB8hnYiLYSzBkUHQ/UF6/KFqn31daQ==
X-Received: by 2002:a05:6000:310e:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3a572370c21mr17233786f8f.13.1750333421201;
        Thu, 19 Jun 2025 04:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0K+Q0JwDwTLL6eL8TmMJg3/Y1q/iQX/C0mLF/RXcygjsYcsKNMqXFMDf/NmEIVFEjZ5Prcg==
X-Received: by 2002:a05:6000:310e:b0:3a5:58a5:6a83 with SMTP id ffacd0b85a97d-3a572370c21mr17233741f8f.13.1750333420729;
        Thu, 19 Jun 2025 04:43:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a5405asm19680062f8f.13.2025.06.19.04.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:43:40 -0700 (PDT)
Message-ID: <15618298-4598-472e-9441-8b1116a34de2@redhat.com>
Date: Thu, 19 Jun 2025 13:43:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/14] dpll: Add basic Microchip ZL3073x
 support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250616201404.1412341-1-ivecera@redhat.com>
 <20250616201404.1412341-4-ivecera@redhat.com>
 <20250618095646.00004595@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250618095646.00004595@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/25 10:56 AM, Jonathan Cameron wrote:
> On Mon, 16 Jun 2025 22:13:53 +0200
>> +static int zl3073x_spi_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev = &spi->dev;
>> +	struct zl3073x_dev *zldev;
>> +
>> +	zldev = zl3073x_devm_alloc(dev);
>> +	if (IS_ERR(zldev))
>> +		return PTR_ERR(zldev);
>> +
>> +	zldev->regmap = devm_regmap_init_spi(spi, &zl3073x_regmap_config);
>> +	if (IS_ERR(zldev->regmap)) {
>> +		dev_err_probe(dev, PTR_ERR(zldev->regmap),
>> +			      "Failed to initialize regmap\n");
>> +		return PTR_ERR(zldev->regmap);
> 
> return dev_err_probe();
> One of it's biggest advantages is that dev_err_probe() returns the
> ret value passed in avoiding duplication like this and saving
> a few lines of code each time.

@Ivan: since patch 13 requires IMHO a fix, please also take care of the
above in the next revision, thanks!

Paolo


