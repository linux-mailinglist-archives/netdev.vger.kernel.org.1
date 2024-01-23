Return-Path: <netdev+bounces-64963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A383885C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 08:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F99B249B7
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800255C1E;
	Tue, 23 Jan 2024 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="elGjg72i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6153E2E
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996552; cv=none; b=llKsZeo++21anS5jog/3HbYR9hVClmi6UtRxyKE1OJV2SAES5rceubnf3z5uGHcRQHkDkuII3AEvbSnho/7xImpElQyUXU9S20Qso6qaOH4AHkIQ8iRJR8bYPbGjF7V25yOkvKWUv3DA3aNXD+OWHhHbcuz1IhKfm4BLPPkYebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996552; c=relaxed/simple;
	bh=rMGf+CVc1XpOboA/v5hnPFBLZuvKbP8V2WzhkUVFjJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGN9byy+n1och3TJdTfGurJJ8RIv4ubrvjGyFM7UjnCfh8p4te+DG+7/4mo8wO1MUNeMd+4J5dtJWm+S8B6YDidLqJfrKqV2L/rgnmeB+hMsUbbY8vAQV0kISJrBgPp6j6xealwzws3xWbqto5sXhC1lNEkI5UIf1fcDDYugHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=elGjg72i; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso46820531fa.1
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 23:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705996548; x=1706601348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcDZ9mN+FRhUYNa88zGuloBXNab4ChQevtTM4gkLaHM=;
        b=elGjg72idNRYQE6o04kBl6eJWZhk7gMZ3D//pQiiDNlEgeNyCeeKMRipWiHknYd/eA
         bEDgwCKkT0/83ikHRWiUNq2LHrpOhFzqe5AyvqCR/L/HVkuGBLBGd1XMPcQ5vShWxG/K
         6gA17/9szoraGXDG+6qQQ97TgBa/DAhWrkYtoCefjEiS0XSj1N2dDsyySHolukS1l6uE
         XXYwy/K7O6PO99rnlUjK2PnkJfh/gIEHso/OUSXJy2AsECgl54vBA9ge0RAFifNV1Ptl
         wKh9XfosC9cgRJVJBpkbe87hB0CMqc3h/+0OEsepqANi4S5+gI/dSpJMKgvOHebs36vc
         lVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705996548; x=1706601348;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcDZ9mN+FRhUYNa88zGuloBXNab4ChQevtTM4gkLaHM=;
        b=eX/ffcuv6lB4B2ebmPN6A6HsqWlP9ifHVw2AMMhlA3bXqgxYfjXiGO92biqbyobrYn
         R5NI6H/W4xcAcHPgCHiEtKmQaJLJeA0V1a0I/sKsJdNYbSUpGAZfiznVFSurKwegFW3n
         BxqRxZ6hQ29zUjkIMAMKo3W86jy3hpBv2LeeQ9MPwkHaFHx+BUdKcnXlyj0ykiam5AFD
         ZGlCDJjm2JrK5J6kfW9WpHJvK9ybRtkeSd1RqD1A5wD7h400Pls71cBoYUlKHgE+i8FD
         x3hRB4OrW+koGdFnvTeRN8FZh7GCnBfkUxFA4gaz/NyYeKnpY2C/u9Zh9a6K8yxZ+Ar1
         MSTg==
X-Gm-Message-State: AOJu0Ywmgk6c8msTrddNC51Ra5s+XpIUF45xpZ6CHVINDbNk7QyRep3t
	8EHVfOoOFe4S9G0vJWSioQ2pEi+z5k87LbsVk0oePTbo5q4zd4NFjKOfUwBP5g==
X-Google-Smtp-Source: AGHT+IGOFZkXrAicjcWyVjNqJjubZsBeK8Mb6x8RXvRNYGfYb5g2wOo5JsA3FPRz9L6sUcwYs42zyg==
X-Received: by 2002:a05:651c:b0c:b0:2cf:124b:a2aa with SMTP id b12-20020a05651c0b0c00b002cf124ba2aamr266588ljr.2.1705996548598;
        Mon, 22 Jan 2024 23:55:48 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a8-20020a029408000000b0046edc723291sm1426989jai.78.2024.01.22.23.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 23:55:48 -0800 (PST)
Message-ID: <35ff4947-7863-40da-b0e7-3b84e17c6163@suse.com>
Date: Tue, 23 Jan 2024 08:55:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 80/82] xen-netback: Refactor intentional wrap-around test
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-80-keescook@chromium.org>
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20240123002814.1396804-80-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.01.2024 01:27, Kees Cook wrote:
> --- a/drivers/net/xen-netback/hash.c
> +++ b/drivers/net/xen-netback/hash.c
> @@ -345,7 +345,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
>  		.flags = GNTCOPY_source_gref
>  	}};
>  
> -	if ((off + len < off) || (off + len > vif->hash.size) ||
> +	if ((add_would_overflow(off, len)) || (off + len > vif->hash.size) ||

I'm not maintainer of this code, but if I was I would ask that the
excess parentheses be removed, to improve readability.

Jan

