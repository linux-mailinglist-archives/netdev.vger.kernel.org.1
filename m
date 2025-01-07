Return-Path: <netdev+bounces-155742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E00A03866
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E063A46F7
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611161DB37A;
	Tue,  7 Jan 2025 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr3Zqwxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87AF1AAA10
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233654; cv=none; b=dT3QOtKJRXISKVcoQAGEpBNMX94sEhVuTpalrXzAUaBXpeL/gJrae7S/noTmcHmt/i/hds+5aHmdNDhUn1XuhgW1yME8PgcdySwkjgBeJpdYSY6DUBP9OKChc7RSDDnUn4dGQId4DFzymrisZYq6TRaM+5KQvXdtEBLae1XzRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233654; c=relaxed/simple;
	bh=5g77gNf6M9CMD2TKdz2wmazi7xk+SBprFO6tU5nw4Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6A/SphSR/TicuWyKI51waUUxWMPYCGYJs1ff5MRVq7uKkRDqYRu5ZdtNusKr3is2TrftMVyrUhlNA3/0BJQUGnLf4zCKKryuiFBseMAQ4a6Dh0CwsQ03mDtNsPlSEQUI+tCoqZqJ36pBc1SBo84RSSFvIiLj4mE6lfJ46XWnJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr3Zqwxi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee0b309adso1845953766b.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 23:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736233651; x=1736838451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3teatQk70FCcH1xPC03D7K2Ubrz5FX0NvcfI4Yv0TJg=;
        b=Mr3ZqwxitvSF+iu5My+rA5QQPLitYKz383/mGrV7fzPaWYPpVy1/dAfvVJIBMQrHPM
         LE2kSBxCq1IcnQna/uKFLCROORFg+uwna/0/l3mOUqQHoYvT5wOOTPqpaEW9CXtSMqp1
         ppT4mWAWXW5vjVTGWPUTF9FF23wZP7j0y0ghgpnIAzckNb7tHurKYbI9vzaCXlJeqtLY
         kF9bJ0dk5odaF9SUiURumfavPgbf2SyHfz6RVaGR2Tv5W8zrmNFR97P00EyZn061bZe9
         9wpIcu8yn+1+WxbMrRLMPhEa8NYffsXeQYW7TRoaxfwK1Qcic5Tn01opAwBHnXfWmuGN
         Mevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736233651; x=1736838451;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3teatQk70FCcH1xPC03D7K2Ubrz5FX0NvcfI4Yv0TJg=;
        b=Uo9HpHj529UsSgSKBBbOKwiIXQmO3RO7J+DOSlN+Q48jLHddpX7yGGa6yhtbvA5SIs
         fAzzbDQeZA0ZY+QPU1gq4OVLbYDXy3OgmKs/QGlPn2lcXrG/ugKXWsXgU7jXozmvkydy
         mO1K7j2zg95vJk/UnbHEKM2ZMNp4WWVWH2/nTzQovltjbDW88VYeLAKqQLViYuPGNjYq
         B5Ira49u7xmLsvhQ+fCfc084VpiSw6h1SRLwOkD3fm9S1I8xqGw2+Tqo3i4jDMBOVSAc
         Hh0r+owUXIxQ8XSgrTQBv23Cb6F0X0+ds1qRyDX5NbvUp/oWk0qbbzxT21/LOnKvhK/C
         FBsg==
X-Forwarded-Encrypted: i=1; AJvYcCXF/NAgpcgTF8KiKLsr8shzXTsMMRnzgcjucVCEFkFZp/XnDRfZLjbBB1bKOoz/dXc5J6IYFqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bKMzdn/byu+klNcAAkyxW54C1MtJa87gcXW5FqQFvDHVsXmK
	MjXIK9LprgdIB2i8qQjaYf6k5Ptm6xjPMwRfdIrnCF1jn5ixwzeq
X-Gm-Gg: ASbGnctS3ixwHsDZuJ2mNosN1QEHamAfRleGHkV0H4ocHSltVlBjRvobPvzUQrhYH8I
	TZQUZRQ2LJs1UiP8FEJjftbZychaEm3njavFm9ClPdy2worm1f/EAtz2WszFZv+bpDhKTgVWf2X
	/iEqgEwP0HvnWFjlH3c6RJY7CxC31BYSxZg3s6fsv6+MIYokYge8nwSywiUocbsNDPkF8BN2LUv
	vuGia5PKkcEHdT0P+RRhgFvlDZHOpmuGyOIGoWLtGrOYedCXsWBAuJOmKfmfYEG9smD0AHGHkHf
	lFP7HOAC0CbbDBB3wkY/4+C3/3QIIsi7DLCUhJhbSaF++xNYeLLE20J+HVnkQ3GBech5Q3FnhJg
	vmnIxmzbxhJxIJ03swqZ+wFtubMuW1aXrHjjTQCPqFamPadsW
X-Google-Smtp-Source: AGHT+IHUkfRcE5uX0SG8kicnFHBcTIwuHPO74EkgqKNeUUhvsfvwGeDnTEaDRNRzK9uNDB0UtLQRHQ==
X-Received: by 2002:a17:907:3e21:b0:aac:180e:b1d4 with SMTP id a640c23a62f3a-aac2d41d2e2mr4847460266b.27.1736233650609;
        Mon, 06 Jan 2025 23:07:30 -0800 (PST)
Received: from ?IPV6:2a02:3100:a00f:1000:151b:257e:13b5:4e14? (dynamic-2a02-3100-a00f-1000-151b-257e-13b5-4e14.310.pool.telefonica.de. [2a02:3100:a00f:1000:151b:257e:13b5:4e14])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f0160f8sm2351152766b.168.2025.01.06.23.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 23:07:29 -0800 (PST)
Message-ID: <3d248bb7-45a4-428b-9d21-1a537dd35694@gmail.com>
Date: Tue, 7 Jan 2025 08:07:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] r8169: add support for reading over-temp
 threshold
To: Jakub Kicinski <kuba@kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <97bc1a93-d5d5-4444-86f2-a0b9cc89b0c8@gmail.com>
 <f3e07026-8219-4b36-b230-7f7ddd71c7ab@gmail.com>
 <20250106153032.7def28fc@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250106153032.7def28fc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.01.2025 00:30, Jakub Kicinski wrote:
> On Mon, 6 Jan 2025 19:05:13 +0100 Heiner Kallweit wrote:
>> Add support for reading the over-temp threshold. If the chip temperature
>> exceeds this value, the chip will reduce the speed to 1Gbps (by disabling
>> 2.5G/5G advertisement and triggering a renegotiation).
> 
> If there is a v2 -- please make sure hwmon folks are CCed.
> Looks like get_maintainers doesn't flag it, but since we're charting 
> a new territory for networking a broader audience may be quite useful.

OK. No v2 is planned, but there may be follow-up patches.

