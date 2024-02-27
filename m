Return-Path: <netdev+bounces-75272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EE868E53
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FAF1F23F84
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFE4139567;
	Tue, 27 Feb 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="TGC2W6md"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DA130ADF
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031936; cv=none; b=JQSbkIv04xu/SNuJnpC4/cvmSxHHK+83MgxJQrK3Yre3yWkWCs7qSxs2YpcDRMDc/DpzcxwPBW7rq3ZgV1pVUL6VfklFsNXT5nPzVyYHWaHi6oX2rZT37+vt4Bn2P7LVjchfz0Tz5ufARByyeZQKL2qgR8MvB/OvDXOq78I1gYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031936; c=relaxed/simple;
	bh=H0SxN+C2WGdavINaWUISIod68ncTsOT4kVTjlIMSDjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPr+Wmm/XQuoz/4qptAuWYtGCV4BBMaz8pqU4rDCuj7DfKW1dY2D5H8W7IW8wZ8CkQQPXfBnUM0oPKWUfJFQSsnH/0dNdyl/ar7t74gqXBo1r71n/ozY47ES3OwsV7Ow2cQZxBlL2bf8JyNXcEy/seKP+ELrONjHTNfyh2eN8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=TGC2W6md; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso5045722e87.3
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 03:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1709031933; x=1709636733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xcL9n/sS9fnhNsHQPGVrECIFe8YF8r01e2Y94m5UeCQ=;
        b=TGC2W6mdsaWhIq7K0IgbWwzZWGAHgo0YK906nYQgI+KrrL7nzDzFgSo9nzWlIs9xTS
         cK/bvyqCXLqAvPXkPDns/e9orqpoDOb4qFGfO8uxNBUxzZHceH0q6PeNNrHiD5s2kLvg
         E/o1UrOhbraXt8fMgcNzN1tz+VQ0hEWqqBrFmRqDwmwkTf2vHySOHUBmgbIkRcP4IQyk
         bLsQAG9PDJg4QDWzs9tIB+73E3mRyIACAgCVRBOvVEccMKptTRGdiepNz03qpLm5oXYx
         5ROxx9Fg3gGL51woRsN6rISxjGZv/1mYpixwkPcslBZ+AzJFUQQyLdK0hCkJ5Mv0nuX9
         QoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709031933; x=1709636733;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcL9n/sS9fnhNsHQPGVrECIFe8YF8r01e2Y94m5UeCQ=;
        b=c1M5JJyPNeBU+oBa42ocKWJybqCXgHWSuqJd6rO2uHD/dOYHED3THNV5EK1MM+ol/b
         EYqrTDhaaNrgSa1UNvD5MNcneJ/ouBtAjXfBVOGvVQ6JPyz4VqxI6+Vtqrq0yILZCiAR
         jmsRK1Ci44qlMeef6SZ0SxguF/8ljmC8VOgE1agQXFS4+xuVTwZkZ2k9QxMNOx2HY2ZP
         hZfuTU3Pwg0SY3LaYcHyZTtFh2lGdvzuOKnxuMrwtnxjxS1W5nw5wljv/ikbnTiy5s7H
         RxfPI+pdHvWAx+PeW+2Jh+GsOawghsXpHmJfwvvSUmUBobOGV4kG//Y+lH9LD8ewfgIE
         bX0A==
X-Gm-Message-State: AOJu0YxQYkKwCbNqlq+8J2MydwUQglYEE7ndGSEdMD5wL2JQJiBdXBTU
	fszXOrUMbRY9EzFb9IoT/ulrpZBvgGwD6cABa84dAKcXtUktGJF6vkRUjhNw4HyFmbc9K49IEnw
	X
X-Google-Smtp-Source: AGHT+IFcr5no1X67raTmaTOVyznDGrTY5Nqkr1yxgfXK/nZdOKxbJdzUaJQus2JMcTubzshWTs3Niw==
X-Received: by 2002:a05:6512:3ba1:b0:512:f17f:2b31 with SMTP id g33-20020a0565123ba100b00512f17f2b31mr7582066lfv.43.1709031932942;
        Tue, 27 Feb 2024 03:05:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:535b:621:9ce6:7091? ([2a01:e0a:b41:c160:535b:621:9ce6:7091])
        by smtp.gmail.com with ESMTPSA id bo28-20020a056000069c00b0033b406bc689sm11493630wrb.75.2024.02.27.03.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:05:32 -0800 (PST)
Message-ID: <8047ae8d-e2c0-4818-942d-2581ab56ad6d@6wind.com>
Date: Tue, 27 Feb 2024 12:05:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2 02/15] tools: ynl: create local attribute
 helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, jiri@resnulli.us, sdf@google.com
References: <20240226212021.1247379-1-kuba@kernel.org>
 <20240226212021.1247379-3-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240226212021.1247379-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/02/2024 à 22:20, Jakub Kicinski a écrit :
> Don't use mnl attr helpers, we're trying to remove the libmnl
> dependency. Create both signed and unsigned helpers, libmnl
> had unsigned helpers, so code generator no longer needs
> the mnl_type() hack.
> 
> The new helpers are written from first principles, but are
> hopefully not too buggy.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> v2:
>  - NLA_ALIGN(sizeof(struct nlattr)) -> NLA_HDRLEN;
>  - ...put_strz() -> ...put_str()
>  - use ynl_attr_data() in ynl_attr_get_{str,s8,u8}()
[snip]
> +static inline __s8 ynl_attr_get_s8(const struct nlattr *attr)
> +{
> +	return *(__s8 *)ynl_attr_data(attr);
> +}
> +
> +static inline __s16 ynl_attr_get_s16(const struct nlattr *attr)
> +{
> +	__s16 tmp;
> +
> +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));
The same would work here, am I wrong?
return *(__s16 *)ynl_attr_data(attr);

Same for all kind of int.

