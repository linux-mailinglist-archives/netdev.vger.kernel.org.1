Return-Path: <netdev+bounces-174839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D96A60EAD
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF88B170273
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A101D1F4168;
	Fri, 14 Mar 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4j2XU+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91401EB5D4
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947791; cv=none; b=X9VwjotozKMLLkQJMP7xIYLVFz95RaNL9j/BTBfnH4YpIbAbZBbbqpvo7KWDiEbTYKAy991WMKtVrmnUNojv3fK0B/tdpZ89+MMlKYMqCB7JcKWYZxf+NIh2WC0qVMpFxlX1kV2kWittsb9jNG5O8ohJsMmnqZvHbhQavDgF1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947791; c=relaxed/simple;
	bh=WBU+CqR3yz92iSXDvmq3Q+OgZZFN5BVnmf7h0Py7uNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1ySl2Fs1uqpcpa6Tt4TOgsIj4k2eVPIlsvBbbyBckr2S0OnTZnqqDDxjEekpAu2eGBkbR1r0bPu5Po858QvGxjU2rEOf7eylN9mFY7UbReO0aINxW2oXl3ca5nTvwMPKlq30EFXeUtZdYkX7bdq0G5m40Pjiy/DX/fftR3xSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J4j2XU+m; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so12086265e9.3
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741947788; x=1742552588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9qhYFO2Mz5BK+5cb8bKbZyFz3Gd+W4DhIesU6ilFo8=;
        b=J4j2XU+mmEj6MWR1QhuF3a2pw6PeqgtXilwO6TplPZdWGgS5xtvxFVwVxzAg7GO8Tw
         BZIAGpLd92QosdnX+DVw8HYtlpurYFquyTVeBckfp2+UCm6aYHvGJ/TL0ywl+fIl5Avr
         TnsKVaDiGx03qp1crmX2dOwVI2HovbPp1EnoJtCoH9Vv1gG+nPibSaCJAOlHwkyredlo
         GnyO+GWJZQ8bYlNpwtlsJDNR+Jo6BA4xf3COrjk2fGVh1XVqIhTDF2koGDSFUu8SxAGY
         B7KRnaO4ntMwHmRI6LDfr3e5kB+I/GEpBkW0nSsnvp92cjOgK4EFK9rC6aJdogAVejgi
         Y9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947788; x=1742552588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9qhYFO2Mz5BK+5cb8bKbZyFz3Gd+W4DhIesU6ilFo8=;
        b=ZANFm3gcZmPscrG2qqAtNDkkafwzrpCybOxbwcXjroVj6SVi1B6ZpenbIQfgQZo275
         GrT8vwwoeRhIRxgaRvjQW6UHxqK6oT7jqBsRLoQmk6Lk/rX3rfd6/+2AeRKcszjC0FKQ
         q3BYVCY7qsfnpIWSwWwBWG5R0FfRI4qNk+pT49MmXEyFj69j7ZNPqjUv+/mhS+HZgtCS
         6kxPl6e+LwzFruiXZhakfHDe8PRetespmj1Bf75+clzR5jELXCnHl2qU02XIiUvXbx7i
         k9vb3PHYKDHaUJOkk43VaRX0DxTL6/5DZwwsauEfCqA34s0t3jpjkqlMfZ+Wx8Sa7X9C
         ZJzQ==
X-Gm-Message-State: AOJu0YymuJMMUxn1mBGsezMHBvk6YGqKJbTRgUgzjVOKSfL3xNeGi57m
	E25oKQaYeQANvVSFjppJSxGy7smBzGg9GfX2XeQ8yJSCDRk0avn/ZFKm/DoHIg0=
X-Gm-Gg: ASbGncvaMFcOxS4kuwSR8qpvolXTWzMzr5SYhSMn7JOLiZEFPnUEHajCPnT+576zDV1
	DyhgI1LtCjCooML0DqK1HMO+rIb+GQdPI9HxERTJiAaCsJjrKoAlFTkaOW7kJrWZl6LmQ9gMd5r
	za2U4u4ubG4muqfNScMlxfZpCfZpDwi1zlYjdwhmm/NoVPmi6SDwWVztzIRNwTDYlmlEou49wRU
	JhBH78A4vRcYk/i129QiIyMKhfc84E26Y35Y3UZkkvyFOPVQWJGpwHEvXBC6EzyrxgnInH4ciot
	SuE+NGR5TcoQXUfMr2w3aygvcOLuDh2BbTfvQ8NwOt/CPn5pWA==
X-Google-Smtp-Source: AGHT+IEPf4tx/8o7szBqHf8eAYY/FeTSSO0PREgglbEkbzyNp/0GBJrTe1d2hM3HG47ZIFBOIaTS8g==
X-Received: by 2002:a05:600c:3b10:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43d1ec66f29mr26789495e9.5.1741947788051;
        Fri, 14 Mar 2025 03:23:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1ffb629dsm12728145e9.3.2025.03.14.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:23:07 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:23:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Wilcox <willy@infradead.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
Message-ID: <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>

On Wed, Mar 12, 2025 at 10:52:48AM +0100, Michal Swiatkowski wrote:
> Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
> from xa_alloc_cyclic() in scheduler code [1]. The same is done in few
> other places.
> 
> v1 --> v2: [2]
>  * add fixes tags
>  * fix also the same usage in dpll and phy
> 
> [1] https://lore.kernel.org/netdev/20250213223610.320278-1-pierre@stackhpc.com/
> [2] https://lore.kernel.org/netdev/20250214132453.4108-1-michal.swiatkowski@linux.intel.com/
> 
> Michal Swiatkowski (3):
>   devlink: fix xa_alloc_cyclic() error handling
>   dpll: fix xa_alloc_cyclic() error handling
>   phy: fix xa_alloc_cyclic() error handling

Maybe there should be a wrapper around xa_alloc_cyclic() for people who
don't care about the 1 return?

int wrapper()
{
        ret = xa_alloc_cyclic();
        if (ret < 0)
                return ret;
        rerturn 0;
}

regards,
dan carpenter

