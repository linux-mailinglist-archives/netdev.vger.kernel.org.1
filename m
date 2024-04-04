Return-Path: <netdev+bounces-84903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28989899A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8A61C2930D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66DA12AACD;
	Thu,  4 Apr 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Anr8tcxN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E51292DD
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239727; cv=none; b=C9rbMpXnKZRyQA3MTcZEbnHLDE5cOV4z8839lwaBgxeg8Vu4zIj9sFibWpqWgkIPikbqHr2uFa9YIuoY4U9vP0EA/XL1nc4noQFj1MUBEIVu8jPghUHPkodoUGo4FjVnWMcFf2UyhUN9SlAVnQPfn4RD/p8z1AHMUR0NllHQCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239727; c=relaxed/simple;
	bh=hrxAJFwASDfNl3rAya+EMsLNEAoHRcFWT7T7tFj+mwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7Ss61K8S3/cXeq5TXTJsgmXN2GjOCZqcjQ6IO8B15KygV6xlaRpdoeIy4jzPEBK5LBHM9tgUak7QzrCO8sp08tbeoejThl80qn2vQdVtzJfXZYfyKn8LdOASilCCI5f0GjtcQ17M1YWrFWK3XLO+VMCDugdmVQdcrxXe7I11+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Anr8tcxN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-415446af364so13192615e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712239724; x=1712844524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aExDhstFgMLX3GM9LPOJfkL+GlZDL+jzdbp79tNKPx0=;
        b=Anr8tcxNGp3RlHVs8JlbjsUChNZAzsCPH8c++y1H0gUvkWzKuBdV39NQ2RuMbMzu6j
         /TDZIy/6YV45Ho3moDxz8m0PyZvCt9JAeh8IctGzmRLY77F7NGCC7fm+4yZRMZiEWs/f
         w/sLQIOqVjX7moFcdSHBU+3O7QB44vHyAuFiCNUP/WpABLxN6XsYpTX2G9eNeI9NzSed
         mX5CnkLbHC9HdZb6buwymGOVd3HWY18rgH8MFAkJO+zLhzRnhY66lo3lXs2/mq5QxeQr
         nkeVJD82PtoE1D3/Rl1RtouYZLAxlsDjcLZQ2BTqENwoXEjwvgPGOBH6Emk/LUmjWvLG
         VDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712239724; x=1712844524;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aExDhstFgMLX3GM9LPOJfkL+GlZDL+jzdbp79tNKPx0=;
        b=ZZmJNYqVqbaUa8zXw8R3KS2giyn8Suxi4Dd/zSHH123p3IrRvGrNNjEaOyEV5Tixe8
         iYzrIfVICBhrlx5hP6Wx2I+5nHZlyfyqpBNYr8M2KMNsvwBLXobA+6zSsxQVpC5U34vJ
         +zIY5DxKyOFqhMLljbLUQQxbcYPiJEEdThFs9nyFU2Nef93iZN2+PM2oBLpD1dQktJLL
         0fEaWMHd7ArtktNU3W/vSFP51/zcUL9HXwG6qDoUVC1o3YFEZu5XwxUQ2gIQbpbVX7xN
         cXQdGgrhqeD3s6OplhAj6PVgCtnBDYmOQGlJvtQXCloblpGxL5IJiHRcO1+zL6UykKgf
         ueIA==
X-Gm-Message-State: AOJu0YzXJobgu5PfTR83xxkUl3BvhZGy6/F3x+CduV1ju46Ljf6JTIgz
	Pqp3ivmWJfWOrsZg3aLKXFwQydHbwVEr64VlcrnVIJsXu+5RutYVX767dK79ROnsIhbdpbuOdMv
	0
X-Google-Smtp-Source: AGHT+IE03XJROIMG5S/BAbknvt/QHBDdHgq2kw4KZuNkV0OkAdP8V4iUaWvxeS1BezvfeA4WrccPlA==
X-Received: by 2002:adf:ee90:0:b0:343:83a8:96e with SMTP id b16-20020adfee90000000b0034383a8096emr2622736wro.8.1712239724365;
        Thu, 04 Apr 2024 07:08:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:258f:a4c6:9d5e:37c1? ([2a01:e0a:b41:c160:258f:a4c6:9d5e:37c1])
        by smtp.gmail.com with ESMTPSA id bp8-20020a5d5a88000000b00343300a4eb8sm20026270wrb.49.2024.04.04.07.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 07:08:43 -0700 (PDT)
Message-ID: <13307e0d-11c8-4530-8182-37ecb2f8b8a3@6wind.com>
Date: Thu, 4 Apr 2024 16:08:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v5] xfrm: Add Direction to the SA in or out
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>
References: <0baa206a7e9c6257826504e1f57103a84ce17b41.1712219452.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <0baa206a7e9c6257826504e1f57103a84ce17b41.1712219452.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/04/2024 à 10:32, Antony Antony a écrit :
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
> 
> This feature sets the groundwork for future patches, including
> the upcoming IP-TFS patch. Additionally, the 'dir' attribute can
> serve purely informational purposes.
> It currently validates the XFRM_OFFLOAD_INBOUND flag for hardware
> offload capabilities.
Frankly, it's a poor API. It will be more confusing than useful.
This informational attribute could be wrong, there is no check.
Please consider use cases of people that don't do offload.

The kernel could accept this attribute only in case of offload. This could be
relaxed later if needed. With no check at all, nothing could be done later, once
it's in the uapi.


Regards,
Nicolas

