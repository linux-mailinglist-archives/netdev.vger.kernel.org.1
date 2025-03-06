Return-Path: <netdev+bounces-172470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 754EDA54DD2
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49A83B282E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BCB16DEB3;
	Thu,  6 Mar 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRqJ0mIO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AC158DD9
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271416; cv=none; b=jFYJWQeg/iKAG4t39DQUuaR68WWWT1l7RMGTzi/AJU8AurFJ8SdN0woPVgWOvhWHdle9X7ofkri583FMgnPILH4AWXa/FYISadEk19dYl5myGdyIh8cNStgBjNLtJ50VkNweM2rAiHAf0C5Eioa62NYfI/S+f6Z2+0DAM2snPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271416; c=relaxed/simple;
	bh=tdngADQvbAIOi7rpWve4EPmXndFqmD+MDTRj1HNgtAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOwPQpI9XCbWUy4tJ5fiHxWs12bxi9QKWZpJ9EnTbtAAnB53xO9Uo/AOS1t5TNOx94H64hcCCTu4Ry9OY3SdiInmynlchKP4jmhojqHWZffUePt2HfXv2ZHsrCw2HNXfDx1uJRc6iEAowHmvrV6Y9CcrXCnDWAgGliFxFftBUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRqJ0mIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741271413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+s8Sa65V/9ddeKgx8N3fRnLsd8R6GrlW9UDyXRKo1Ek=;
	b=QRqJ0mIO0SYhrKU9/BOXehedhTgAfhJn0hRLCRNNd0W7UBY8PFzqQb7aUT7O0Xre7wGOWE
	I3hfqnLzb3xsGnTfNyO3umIvvcFiLo96F9MH/aOvPNwowHJc3tNiUdHrnIYy8ItzDTcHAM
	IbhsE7DUf7Tj/aWLTXpKlzsvirZe4pI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-44UCaZuFPt2Wpqw6cvARSw-1; Thu, 06 Mar 2025 09:29:52 -0500
X-MC-Unique: 44UCaZuFPt2Wpqw6cvARSw-1
X-Mimecast-MFC-AGG-ID: 44UCaZuFPt2Wpqw6cvARSw_1741271391
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390e62ef5f6so295887f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 06:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271391; x=1741876191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s8Sa65V/9ddeKgx8N3fRnLsd8R6GrlW9UDyXRKo1Ek=;
        b=qocPpeAGKMPkxc7MQyvbJF5fIL/aou2aTTVEcujHT0Y3xn2KY0RcfM8INF258aUpex
         Z7I37FDM9yL2I0fUV9PR3HbrOJellNDy4aDqOSVh3VLDdkf5P2r+gQB9UhLkek1PkHYz
         BndFB27FWPgF2/qV7yvh2XD5UpBGUhyzamQEtVVgAyS7p1i5t6q+Wrljso0VvJNRYaNy
         NyGwCovN4vfNmZGwtdJ0HIf+FBnTXVCyQ9mUjdmzSkR3DnUd9tZ/ADCJqo91SlHngV2q
         M0nZOxg5NX+JKjisjM2a6sJqye6dI92DmfliZZ5KHqglLsAGQVxQjVy150dNoxW0V69b
         3RWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV76aa6uuyjePTCmHXm13QaTfv1eCHR3E6CMoWmeA0i8h4y7lyO9Tzlt/lxHbkqItHPpIsnk+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRojay1FniZrKOTguu1aUQS9wGYv+ZsvKz10Utrvm74F8c0EdF
	azvvsSYosCfzqBfavBEhOmJsrh/TGuTHsow56LT8oOiaI54SxceHf9Ho+saqmK1EqEoa00fClka
	RlxU2WNPBfrfQJP5nwYDZtF8/BwlSNYljAMJ2XCmEnRVBmvhP+8ETag==
X-Gm-Gg: ASbGncv2nl+f4NqSvnLRkzNgVjzOqw77/T++PfWXuSo50B5TSsfFIVyv1WN+HMxFm4D
	9tfgOwF2xo69x0FsZRMTWJJ4edZnHpbJFth0qNLDcCfpqq+rQU+9X14wqeYJU1DzbrjsDW4Pp1S
	Lzv7cn6QhGZbJAxn8zO0YCvP5AIhPzxurgcrYk4CYSvLkgKxekf2jqlvu0bG/JaS4gt/6NbcYNU
	Gn2ApEnh6UEn5YazukB+vRVKPT1fI1eupjfj0HEOIz4qRCyAnWhoxORwDgFSTYfGgCBu+zk1a87
	mNdIlSj734IfMUINKJTFDiaCrWeJFDOKWix6yKBfAyGmKw==
X-Received: by 2002:a5d:47c3:0:b0:391:300f:7474 with SMTP id ffacd0b85a97d-391300f7814mr755630f8f.18.1741271391437;
        Thu, 06 Mar 2025 06:29:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNrvNwgj8JP10FUTkFjkayzhqglMLbK2EPOM2dy9cPE1fLkIBgeqVz0hx1d6bSuhoE5j+XQ==
X-Received: by 2002:a5d:47c3:0:b0:391:300f:7474 with SMTP id ffacd0b85a97d-391300f7814mr755608f8f.18.1741271391040;
        Thu, 06 Mar 2025 06:29:51 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm2234126f8f.93.2025.03.06.06.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 06:29:50 -0800 (PST)
Message-ID: <03492277-b7e8-4cd1-b92e-699ee0d7dc85@redhat.com>
Date: Thu, 6 Mar 2025 15:29:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 04/13] net: enetc: add MAC filter for i.MX95
 ENETC PF
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20250304072201.1332603-1-wei.fang@nxp.com>
 <20250304072201.1332603-5-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304072201.1332603-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 8:21 AM, Wei Fang wrote:
> +static void enetc_mac_list_del_matched_entries(struct enetc_pf *pf, u16 si_bit,
> +					       struct enetc_mac_addr *mac,
> +					       int mac_cnt)
> +{
> +	struct enetc_mac_list_entry *entry;
> +	int i;
> +
> +	for (i = 0; i < mac_cnt; i++) {
> +		entry = enetc_mac_list_lookup_entry(pf, mac[i].addr);
> +		if (entry) {
> +			entry->si_bitmap &= ~si_bit;
> +			if (!entry->si_bitmap) {


Minor nit: here and elsewhere you could reduce the level of indentation
restructoring the code as:

		if (!entry)
			continue;

		entry->si_bitmap &= ~si_bit;
		if (entry->si_bitmap)
			continue;
/P


