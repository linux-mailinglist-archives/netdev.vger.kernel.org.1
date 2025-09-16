Return-Path: <netdev+bounces-223388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5540AB58FA3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A32525D58
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3330A283138;
	Tue, 16 Sep 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV3Y/2ct"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F8281356
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008934; cv=none; b=fYDzHwSExGV+iRu4xT/OBnHvdAnsUjd2N4GSObBgPbBd0//uHb4NXQO47pLEauyn08gHVJW9k9qv9kLc4KyNCJ5UaHWJJ/9qFLhXKlv7N7mfGzK46+wjF3N1T7/b3djMSsqcMx9PmawGfMAPk3AtmoNV1Z7MZVyZwxe8zq60rIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008934; c=relaxed/simple;
	bh=7SHV3jCyT405G3CY4vB7yAVjSGoBgTp2zKolMAlPbOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlqnoJ6OoHnF0r21UT24/Jgx4vQJL6Pnw4vfG9Llrp1G98CoXYXD1uc16ROzf9kVm66ECMqlmFWkmsWs1X+vsc3PeBm6HL4NCKmuTCZkGDt5GUe9jgOfMnYNUZERm9IIXcvi8EB61iJulAmdw9qRXyg9JjWJsPOuqtrqFL9hcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XV3Y/2ct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758008931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GjeY1PcOXMyOovo+WVNpcVTDlDd9blbv4pX7GoSf+q8=;
	b=XV3Y/2ct1ghQL9OQ7d3+hpx7i05xC5BeZl50UavyurgPv5OLDgpIUU8gg7hCnaT/mhQmlp
	1TqqMmaQ6eN4BLo7CFv62dyeOdMfXwP0SKoz20hBA3478Jb2XdJ0WBJZepCl9RCBgp5cjn
	O0V649Z62qgU4KFggbdEYoTdiHj7m+k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-05m_qnteMyySM2Cl7x_r3Q-1; Tue, 16 Sep 2025 03:48:50 -0400
X-MC-Unique: 05m_qnteMyySM2Cl7x_r3Q-1
X-Mimecast-MFC-AGG-ID: 05m_qnteMyySM2Cl7x_r3Q_1758008929
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecb2ea566aso230434f8f.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008929; x=1758613729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjeY1PcOXMyOovo+WVNpcVTDlDd9blbv4pX7GoSf+q8=;
        b=fcMta881ZFO3sbTgApE94go0q+Z2QbB2+7UgXVExkDAZN417d5Y70yvHDNkcJcBc3H
         ch9nzoS0Vlw/fgX4Igzw1n21pqyMEUwg6iZrtANTip5Bxko0z67l81p3HPJs6ZTUGf6V
         9m/u18rAms7kYwp2Y3A06DREJYG0PWIknKFAKeu/JC2y9wuhsOu59zK9N3MxGh3O+8Xc
         vfnseCBRuq3x10E8NxdLLVe+UM3h96C3ZwGmVTrphqJP7YMu3I5MGU0dUj07jZbMZnQ+
         HTn8Dcv57q/ZBSh99Dhxnv/leWm0/utXozTIbMVPojcf6SZVRQ/ZoORebWzITysJYRrM
         rIQg==
X-Forwarded-Encrypted: i=1; AJvYcCVHR0RcG5sp0K/KGmYs8JiNOwIDfrzVCP3u6+sfW/t5yJhmiRJRcyg+cZOlcHFlbzJIhKvl9cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQrfr+RyxFNqVlyu581ygLJjCc7tzop/dgoMLijSBsN9+s4f7a
	kw3daKMErcEK08u0UM7sIWOevT+nucMhJ84hWDUIXLp4EuYZvPDsHJc1Zf4QLZDP1OsSXkw7QeY
	UHhRA3vzafVXtgcK3HhqmlvBb0gKhpVFwU3VjCdCa9Fm3fzSUwL0ZoEXH4w==
X-Gm-Gg: ASbGncuGZ3i+XVbGyYA1jMnQCipC4AWtx3Y6Ismuq9Q88TLfSLgJPyh05S8u4AdRxeb
	g5A45GlzQncYV4xvUvyNNbdUiXxqIAf0gsxOt4mInNs6UOt83dqJ1quD8raceHTdolIEJaShgV3
	Ntywanjl+HI2ULF7oO7UQFEq3YT8ZSvxOUJEIQgbDDhxwxi8RJxFuGrC809nYMDArsCNvYL2BoB
	roUn7pcfwVJo8opEYsa2WD7W23q8FFyY7CeymH9PupNHiDsq6AlSZmg7RnPqdUggMAk/0GY2p+E
	0soCVaIHsjCaqFaf8fBQpnEoO/m+A9cNp4LXjwcpeHwTVdgv7ctA3ewWP5PCbbtW0+XaeZgS6ki
	hCvkDePENcDF2
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ea6680924dmr5605812f8f.2.1758008928869;
        Tue, 16 Sep 2025 00:48:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVnUKCp6fBmJpCDpTscXGYwqYkke2xti3MVIaeuGunlb5OGmsVBlB0Es1Ojij7wpr4gLKLYw==
X-Received: by 2002:a05:6000:1841:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ea6680924dmr5605763f8f.2.1758008928399;
        Tue, 16 Sep 2025 00:48:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c4490sm210698005e9.19.2025.09.16.00.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 00:48:47 -0700 (PDT)
Message-ID: <451ec7d0-d4a8-4318-bac7-0a344d969cac@redhat.com>
Date: Tue, 16 Sep 2025 09:48:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/14] dibs: Register ism as dibs device
To: Alexandra Winter <wintera@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
 Aswin Karuvally <aswin@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Harald Freudenberger <freude@linux.ibm.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>
References: <20250911194827.844125-1-wintera@linux.ibm.com>
 <20250911194827.844125-6-wintera@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911194827.844125-6-wintera@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 9:48 PM, Alexandra Winter wrote:
> diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
> index 2b43f6f28362..92985f595d59 100644
> --- a/drivers/s390/net/Kconfig
> +++ b/drivers/s390/net/Kconfig
> @@ -81,7 +81,7 @@ config CCWGROUP
>  
>  config ISM
>  	tristate "Support for ISM vPCI Adapter"
> -	depends on PCI
> +	depends on PCI && DIBS
>  	imply SMC
>  	default n
>  	help


Similar consideration here... don't we need an additional

	depends on m || DIBS != m

?


