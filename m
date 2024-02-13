Return-Path: <netdev+bounces-71194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F08529A8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CF01C22799
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF51755B;
	Tue, 13 Feb 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IrQ75Qfu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D2171D8
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808927; cv=none; b=aK4n6MICDVUKYHa6dnecFB5/s5c33SNvzgK0A4Y4flGeIjrykVTOGER0X6XVCmlBarpIEpqvaFfNCJohcb3Os5ShL7o1rZyalaeHqc0mQ4hoYcoYmTSQNbwhQA7UfdS3i0pbT1qFZMp0LF1ZCNE4DmJUEGMGYq4PZNDx57VLLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808927; c=relaxed/simple;
	bh=DONVtGRnA1valXDHvMXR3w+eZ1ofjI09Edkc2KsjAf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPh0YrTkL3m81zIu1HWqPgKscqJBb3K9dH7JJdkj0A/dnmnIDEalJeEAyuVqY1DVlFaL6yBT8AQdQuBsmysySSzeh2FUbHtT0kuh4QNUjJOa4FXvQj0cv4myZ7Z1ZeG2wdx5X8kCkhf4BNbbIbDy4EUzEb2BSk1KcjQULcIbTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=IrQ75Qfu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3122b70439so519077866b.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1707808924; x=1708413724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AD0DXnUm1FBXgA9YUMc+TzzukaEUgpwUDBCCVIkam5I=;
        b=IrQ75QfujO74PbxNkhTLvq9ci591E89y0XThGIjyBgV2RjYNUd3kOnhv9jVZVhxU+L
         2ScAl9rLithDNCVRY4mhuDm/OEA4nyyyesbNEf8I6iYeSzztcWLjv0Kdm5sJuCBYtIBA
         yOzOoLabloeTYQtip4yo57hGjI5CKJdHuX8o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808924; x=1708413724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD0DXnUm1FBXgA9YUMc+TzzukaEUgpwUDBCCVIkam5I=;
        b=P3wR2urgqhe9SQ9ok+DGRn4VrvjK9PmmmXDCFWZtn2tufmuxsclN71ZInv5VH8TpbQ
         EsohJnCJlyW9YVjP6uHJ0qm8R4jxggiF9QLjUxxS+JCPKBRF6cw/zDR+GQf5nbJ7vKXD
         m3TclXBb/HSmZOpNIvq9Kdp5gk1PGP3DoYIEWIIXQydv/gbf+Zci+gJgSnWLub+s5zne
         OeDUd2opT7HI/WPDGpKjKej6P9prjGNuK0/m4lnhmQ4tgA6HwHkIr1TFJyrjgU/25S6f
         dwtSdj1v7apQV7j6wV3UH9lr/JUXCtERgxW1hTgqvLeddzQUzQ2DUSSUic3b5T6y+fLI
         WkBw==
X-Forwarded-Encrypted: i=1; AJvYcCU7X0lmlzWAVwjISKlM7kJwD6F9xME7HF49HAdNjGm3Q84kkCPnOYTjAapj7Y6Iri6B8VJnCyJf2RC/vMIEaCxmvKqI9ccq
X-Gm-Message-State: AOJu0YzVwAeHSjzC8LOJ0Iby92SuSmQNOp2Mlb3mIlrl9gGBHj4N7eRW
	uFJHcf85nDXJgcPyO7ad7NM40yw56yYX7Z+lXSeYXisyFMw6kD9k9NNXYCg5O4DceCfZG8nbWcw
	A3ks=
X-Google-Smtp-Source: AGHT+IGqfRFSCzNsRmUpBjE/amQaT/faAWEXBlMHrAWFflBTmiX9qHATOJ1HJYx7BpFJGLpFDUlwZA==
X-Received: by 2002:a17:906:d118:b0:a3c:98aa:5ad1 with SMTP id b24-20020a170906d11800b00a3c98aa5ad1mr3635223ejz.56.1707808923400;
        Mon, 12 Feb 2024 23:22:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4luXF08VL+zicwLTq9Xh9Y8kYxOhF1kPJ8oNRVthKZvF5fDS8k7GzWn/v2C4YriRdYy6OKFge2XgzXaOfqo+Dacyrr/xdAcYXw2QHv16NvAU0+p1OZ9XCkLVY3W1aEH8W+nJM/QmyL30GQDNC3SpubkgIgY3CFZOZn0Gi4uuTL1N818XMcYBXyOo0c0QYkr+l+0ZDKrzrguP82tn8WI9D27oZYKS3/zTRxlAGVZpcoCaUcleacl/jl2c6hmUejIyVz1/lA0opNJ2mMOHutw2MnE2MqvC9Z3bJU3A/m6RgBaD214WXoF2ChIs5Maf1Q7SlrNK0LMWEOJchld8QTcPwUh5SnCV1LM9CFCqVdAs4TA5FhPdvHpT57nHICPmIdyiHOV68CoqABWDw6UZpkHP0jmLx5ATRMRNGZ/Psly4dQdfUd6dHE2MF+SKITHDjqMOWePMRGoWG5L3achTmGQ==
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a3cfe376116sm379292ejc.57.2024.02.12.23.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 23:22:02 -0800 (PST)
Message-ID: <8ff2496e-925a-4a86-b402-6229767d218d@rasmusvillemoes.dk>
Date: Tue, 13 Feb 2024 08:22:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] stddef: Allow attributes to be used when creating
 flex arrays
Content-Language: en-US, da
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Keith Packard <keithp@keithp.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240210011452.work.985-kees@kernel.org>
 <20240210011643.1706285-1-keescook@chromium.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240210011643.1706285-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02.16, Kees Cook wrote:
> With the coming support for the __counted_by struct member attribute, we
> will need a way to add such annotations to the places where
> DECLARE_FLEX_ARRAY() is used. Introduce DECLARE_FLEX_ARRAY_ATTR() which
> takes a third argument: the attributes to apply to the flexible array.
> 

> - * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> - *
> + * __DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
>   * @TYPE: The type of each flexible array element
>   * @NAME: The name of the flexible array member
> + * @ATTRS: The list of member attributes to apply
>   *
>   * In order to have a flexible array member in a union or alone in a
>   * struct, it needs to be wrapped in an anonymous struct with at least 1
>   * named member, but that member can be empty.
>   */
> -#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> +#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
>  	struct { \
>  		struct { } __empty_ ## NAME; \
> -		TYPE NAME[]; \
> +		TYPE NAME[] ATTRS; \
>  	}

Is it too ugly to not introduce a separate _ATTR macro but instead just do

#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...) \
  ...
  TYPE NAME[] __VA_ARGS__;

?

Rasmus


