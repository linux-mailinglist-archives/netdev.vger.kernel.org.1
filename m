Return-Path: <netdev+bounces-156808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8FA07E15
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05B2188C645
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A8717C224;
	Thu,  9 Jan 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Kh2/HD+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069911779AE
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441525; cv=none; b=oSADK6GJAknRrwggzxnxshcgPhl/KEFKFBREnDe6sZa/ZJlDcpeoLIfYBzwRv3fteF40imlsom71/rz2eKDrtXt5PS359/qthXharGuyvZOeCSKsDTLWJ+/geeDiJoRlxEu2mWsSOaNCTwrzrW6OQ4GDxyuKjLSwX47lDB5LG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441525; c=relaxed/simple;
	bh=YySeawq2KEQuf7Uws7uatsP2jDl2hdxm4WqJK42uhAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R89VaxMj8eGXbVoIti8bNut0ZKumjVPQgVuLHGyTKP4XeUDO2dSnUAzZAkbZii6U3GsNnMZMd/woIMoaSblNThfbfFO5S/O9mYpQuI7iBQNsk4YMaG1Q0BecaL4L63wHaX4reuQnPnfUMC2yEZKEKsyWCT2pWQWE9ErQOAkYJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Kh2/HD+W; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385dc85496dso55289f8f.3
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1736441522; x=1737046322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7eB49Ih7d7iK5EGw9WPxQ6vRyPGX+exV79r9CHum8gQ=;
        b=Kh2/HD+WTL0SboNRvqDP49cmJmb6rMelyKO4CJ/IMmlgmPy7rFsLoi7DmlG7kVd33Y
         h2xYsxOyIyEYY8WnLXdS/YbLVRylsNmlpkGIKJj6TpG1TJOzlx816qjHb55BJvLt2pRx
         7ZNv3QzCk/J/A9iLZ+N4lACbon/Q8F8yR9YSpnX/KGQzJEr3fQhHw69OrZiZllg+2F7F
         fpbjBgMbG08VfY8/61jFrPCCmAn/dIvGh+7SvxVf8n6137dvU+x0nx/rG6sARWi5UZVL
         JD1ULEuEnGokZBTpZSauJmVmruAqSejiC0MWOCeGwZTXqo+SU0GShfr7H/zGiKrE8cII
         UVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736441522; x=1737046322;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eB49Ih7d7iK5EGw9WPxQ6vRyPGX+exV79r9CHum8gQ=;
        b=qiphGvQf6lPf7lG9FmclUeAoGC/72nxxEXmH3Q35wg58f0PSgHekdXOFIMRoppfm+Y
         Ce2B5uw8Tc6ilYs3CxxTGP/wQtQEVAnpe5Ld+Pb+et3KtWXX7HJpfrJFLZin/xo76AJi
         wML4/o5n7/FJOGZtuZnNB6iuYd1wyknZEu9IgoYjtwR2Ucc97F0qS16XDkFs8gR/f7tZ
         iucXqgvkqtdAc3Uq3pGtit9FwGbbc8l3H5N7AhTikPTh2P3sPmHO/Mo9BXcaZSGab+yR
         Vk+/kvbzHWeuSiCAGJbXOz6GszBmsjEagoNgRTgQWuzi/IcyIKxuOsuxek2tkFkW9go5
         KHgw==
X-Gm-Message-State: AOJu0Yy3iyZbLrHeBt8HdGeQbuZvYPF83BbMboHEwuifjirPGfKa1JtX
	N8cgbSuN0e5uBr77qirY55oXR+fJk2Z+hPXKUAKDuz+Xu8BhI2Nuc4MQGUQTXVU=
X-Gm-Gg: ASbGncs/qwMI+s5D1njzQHfmWurh8FzPJuWjSEemO1S3vQkSTJh5MJxA9taMgKD9ikc
	l4Aim6MDXpCKy0Peey/Scdgz1W0hxirbgj00ravqyH3190xw+5hALrOS5SZ56l/c5NaekY6pXds
	+fIECRZFfr0vMypzX2B3ANMu0HeQTZt/x794DDYW9Hf1qd0pSf5hGxNVP50i77SDf2zxMDwl832
	VZphTH++SKqqvf7OYzlDMF+5c4/cuMnAbGKiVHJWw1ASrwdm4pVczHJaYue2eGhfyrBP5zkPR0q
	u5RzTkvYXJ9Ai6Dkr1joFarJLZ9LHXM1pA==
X-Google-Smtp-Source: AGHT+IEIRy6nG30lmVzSfaGl78Gz+of8RkLk8RmbY+8V+nq6wqjuSyLkRQJTrgKuAij+jBq4NAxhvw==
X-Received: by 2002:a5d:4888:0:b0:38a:8984:888 with SMTP id ffacd0b85a97d-38a89840a5amr1966030f8f.8.1736441522266;
        Thu, 09 Jan 2025 08:52:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:e7da:5a6d:1e09:2e14? ([2a01:e0a:b41:c160:e7da:5a6d:1e09:2e14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e384054sm2276742f8f.36.2025.01.09.08.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 08:52:00 -0800 (PST)
Message-ID: <780d9c80-cc74-4881-9a30-5c7b40c4b2be@6wind.com>
Date: Thu, 9 Jan 2025 17:52:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl-gen-c: improve support for empty
 nests
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 donald.hunter@gmail.com, sdf@fomichev.me
References: <20250108200758.2693155-1-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250108200758.2693155-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/01/2025 à 21:07, Jakub Kicinski a écrit :
> Empty nests are the same size as a flag at the netlink level
> (just a 4 byte nlattr without a payload). They are sometimes
> useful in case we want to only communicate a presence of
> something but may want to add more details later.
> This may be the case in the upcoming io_uring ZC patches,
> for example.
> 
> Improve handling of nested empty structs. We already support
> empty structs since a lot of netlink replies are empty, but
> for nested ones we need minor tweaks to avoid pointless empty
> lines and unused variables.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

