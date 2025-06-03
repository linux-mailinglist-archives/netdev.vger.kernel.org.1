Return-Path: <netdev+bounces-194718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0858ACC20F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C9816BA98
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B426980B;
	Tue,  3 Jun 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCXsKZt1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27962C3244
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938745; cv=none; b=VjavqSSfQU7GrDC9bIp3+cbchM88A7DSZYfJ5pGMs3dpY+zEBP5Mvh5IzWVqfMLaoyAfJ4cvdItii8UN/dBK2+Dlb+Nik7bR2a+8vSRkNs8P147lrrwvV9nuhq71Iu1uIDNE5o1ssDO9lE0Ip3V07A8G79fqqVcQsb3JcpesGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938745; c=relaxed/simple;
	bh=OGlsd1kCiQhTkZBlgIak8v9rv+EKOwBMcl5ptB5aqr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkovHMBCh2O1nZ7P9va1H4xWerO4JX7SDPT+X7e5pzePJ/B+JpBbQ6oAnSzE8UFFXd76oE66UsiZtseJ+4z3FOZy2HMcvUsBOORk5aMuJtOtVjJifnYhWm0M2UbJkV5fBAo1d4vQMpSxlZlLF5nn7clliMcwHksVf9rPvlR9c1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCXsKZt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748938742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGlsd1kCiQhTkZBlgIak8v9rv+EKOwBMcl5ptB5aqr0=;
	b=XCXsKZt1Lq6jLLvp6UaDMxMc1AwY02JlfZRHt5BtP9RZZiOIPDHqEX6zJwgc0nEp73HZKB
	c0A1GBaFQ2nV6Y+asfxS8MSZXBqhttj7sdIEqrparNpbnN/UtIczoszEOZD7Iw5jsgFi9S
	tFhpq2iPfpn2SAt0P3+7bs8I826KjEA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qCaK-GMFNTSO5ICr28SXRA-1; Tue, 03 Jun 2025 04:19:01 -0400
X-MC-Unique: qCaK-GMFNTSO5ICr28SXRA-1
X-Mimecast-MFC-AGG-ID: qCaK-GMFNTSO5ICr28SXRA_1748938740
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f7ebfd00so1901481f8f.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 01:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748938740; x=1749543540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGlsd1kCiQhTkZBlgIak8v9rv+EKOwBMcl5ptB5aqr0=;
        b=ALv9BqJhDvANv5WEQwcfcvziSPZPEgmQef8nU40sYghdt14gXVqfCbyAQKZ3UogbA9
         qowxYcPdfIWjHAEowjkb5jzkAHtrUhI44ioHoH3LP+zn0hY6bOqk0pd6/0NbMxrgWC+7
         N3ncQx2PFQrI8psAmxp+opTrmJz9IxzB90//B1HE3vOqpjv8TCQjpiuOMd60RJ6iwT6v
         0X6A5iFwlyIwRzhloAhy7hHGGY38waIx+xEPAjSX27k8l2PUTLIntjL7nKieiQgxPkkL
         b7S11ap9hwsOogYijVyWD5wq+bQwLZ+j1l0O92kT8vPD/A8tP0qtQH3vVjwYIDQxqqI1
         yZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCX2MV3JrTy0oi6GfR6PWSMtQRJ2FV8c1XgzI2nukXa3/GI//i5ev5MjNZBhx7uFAbWDqpbPix4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwznGW59cp0OVucpJZXBLu8ivUPOmER68EPufV/ftSJpc3wwUKs
	qrnBsDr0OzSQT7XKQkA7hZoU0nGPOI/pdJXthVY9Mj8NxESwWr8zgRmiLGd7VgojvDEFskLDn6e
	+vv+GOtt6iCosqjlrOd3Ag1OEDHCYnxPrf2mNy0dnF32wfAU9xCczCBofcg==
X-Gm-Gg: ASbGncv6OgNoE5cew7WdTpxzRSNZLy6XRj8uA7E/UV5TYtA6mCbVHSbTsAGi84uCzPG
	a2PXyY/NJWU1pgNHhLI3k6zoG/nwpNJQ6N85k/JUwtbEsRlWoEKk+BqoaqCuAgsHAZiSaINopfU
	KbVLm3FTNBPtDT+V6vIH74+O+Uz3/oxCQpY9S4O5KZCoFNiYjuhJGIrwIXAVyUn5kieCYh+URb5
	57zqp3VqbQuOJSNOsEGTdB3TBw2w8d18eshLuHefnGmKBbJPtJX8J5uNFy/TQEnhbN+NCjKdTMn
	0YC+GG2rWO4/lazZYhNCDFUtX+K5cFKUvFusjuxuMO2yr2D8p2UeV17n
X-Received: by 2002:a05:6000:230b:b0:3a4:ef47:99d0 with SMTP id ffacd0b85a97d-3a4f7a64251mr13220926f8f.27.1748938740223;
        Tue, 03 Jun 2025 01:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUfadbp/PLXy3tAU2yIoE7CN2SdcmUB1sLgD/yyO9/LHvTHncHp1k/sONJWjZJYXD98Egarg==
X-Received: by 2002:a05:6000:230b:b0:3a4:ef47:99d0 with SMTP id ffacd0b85a97d-3a4f7a64251mr13220896f8f.27.1748938739820;
        Tue, 03 Jun 2025 01:18:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fc1a84sm154592205e9.35.2025.06.03.01.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 01:18:59 -0700 (PDT)
Message-ID: <440438c8-8cef-4114-9d5a-3a80faa5fcd2@redhat.com>
Date: Tue, 3 Jun 2025 10:18:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] macsec: MACsec SCI assignment for ES = 0
To: Carlos Fernandez <carlos.fernandez@technica-engineering.de>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529124455.2761783-1-carlos.fernandez@technica-engineering.de>
 <20250603080618.1727268-1-carlos.fernandez@technica-engineering.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603080618.1727268-1-carlos.fernandez@technica-engineering.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 10:06 AM, Carlos Fernandez wrote:
> I'll ammend the patch and send it to net-next instead.

While at it:
- please include the changelog comprising a reference (URL) to the prior
discussion after the tag area and a '---' separator
- please include the patch revision in the subj prefix (v5 AFAICS)
- consider extracting the active sci lookup logic in a separate helper,
will probably simplify the code and will reduce the indentation.

Thanks,

Paolo


