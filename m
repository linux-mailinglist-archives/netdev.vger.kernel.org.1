Return-Path: <netdev+bounces-86412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F0A89EAE6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08179B2126E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC7C15D;
	Wed, 10 Apr 2024 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="UJlhDRxu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F4946C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730747; cv=none; b=es5fzDmvV7eIRNTuZGTFZnUOXXTx4enyTkgzacfrr6toEOhS0JvvPnWmT9xXhqbLHO/DrM5TLYFq3F1LyJOiuEweNHqVKKLfMhIZfzvYnHJ/XRmELBrrg84xDrd8BdFF/+GV4sU2e66vaI5Hxl8rBS6eI2TfQMH72kBk4FjeS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730747; c=relaxed/simple;
	bh=FVHjvHWCCKAfWdDVFdPLlJPgJ6K8npiB9BsouyxqL1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q11EKqK2TMj1A0exK3oGQfh6sxCLEtSAHt9zi7CxD/TK3ECE3naFqb9XU6OCk9aGum23uqXWxpF5khC3KDO/Owf6RWq0zhmB7ZLIvurRqVy1ovkW00iCZFVaNYGvPg5lRxsy58MoiCo85V4xfEFyGxaz9GWK1xf/ePOnum4mfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=UJlhDRxu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4155819f710so50633205e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712730742; x=1713335542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=byZ2fzEV3Nigcoml3fzvC/ATVqTbhJfX1w6V9jkj85U=;
        b=UJlhDRxuNkV9FkhslJbmRhisR4wXVyYGY+Ut1mYVoBzw6WPB4+eWhZc7u6+jY3oOo8
         Ay7OeP+wcVKVQnjMtQuh4foa80zC70MWm83M+2zlzzqCHAViIYvcc2oqcuZm+8Uph5bK
         2xIuOoj3zCz0L2w6KEK5+of7BOGUc1nxA4gjl99g1PnizZfH5vspKb67CShpQCVN1FjK
         8yUSgvewbdFo/SpeNhyb6qYdWZeb6K4K68XkqOE++HwaJs9ChkdntMV8yQ4wcxU8sIs4
         4mmi9ERNNxE4OgPVk5QoQEvtp/12OnQrDuoDxpjGwpnsLRKo0cmwVArTJ/GPFaCgQX8E
         AI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730742; x=1713335542;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byZ2fzEV3Nigcoml3fzvC/ATVqTbhJfX1w6V9jkj85U=;
        b=Eq+XKBr5MfLS/wSoeHz8ZkuPxb8JptQeAyWnLFY2r+2tD9enQO0sp+98fL8Mhu09gu
         rkeo6I2e+1rzbKUSn5yNH52OmJ8lKU/+RNH0hmpGBuN4yBttPvRsRlYKIxuVccjp06Ak
         SGtQTFo2kaB1cF11Os8zcCqj2/ITOm1L9tYOYKN40dpuOOl6hvLQP4OkHTAxeGsv8dqW
         IFVrEOY7h1Pi4ComJftm7JMbq9R1VdlLoUsKYDHyNK02lAEl4sMkjc0ylOBrHpX8R4wD
         vr+S3vVHxcop07V2twgEsfnHtHD/vqinDKx6xO6ifkW5PhlxT5A+p2ftSdwkKJ3IMSvd
         Argg==
X-Forwarded-Encrypted: i=1; AJvYcCWSnJ5v8LXyQJLhHl19uXarBv5BUqZ9xTMp616/CdBPXRbGYwTa/mkq7ykX8nOY+bp1ZdkN1K+pAzSPqhnTfA5qtnhd4aym
X-Gm-Message-State: AOJu0YyZrC7RChRz0hR7d0Sjwj6DhTjAZJBPJD9Dh2zQ6Ovi6EWmBcQz
	5Z9cfS1GFY1BQqRcbYxUrDuq53Ooj/uBROSAXHtIgbA74LiOP/GltgrHgvFdA2Y=
X-Google-Smtp-Source: AGHT+IEaUL7sHQeV3J9lGbAGfPM1O22iAet+mbhXRT2/iUB63lsIQJf3K93ZvbZU7NBjIj7rTONajQ==
X-Received: by 2002:a05:600c:1388:b0:415:46be:622f with SMTP id u8-20020a05600c138800b0041546be622fmr1646605wmf.14.1712730741962;
        Tue, 09 Apr 2024 23:32:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ea6e:5384:4ff9:abac? ([2a01:e0a:b41:c160:ea6e:5384:4ff9:abac])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b004149536479esm1270128wmo.12.2024.04.09.23.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 23:32:21 -0700 (PDT)
Message-ID: <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
Date: Wed, 10 Apr 2024 08:32:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/04/2024 à 19:56, Antony Antony a écrit :
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
> 
> This feature sets the groundwork for future patches, including
> the upcoming IP-TFS patch.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v8->v9:
>  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
> 
> v7->v8:
>  - add extra validation check on replay window and seq
>  - XFRM_MSG_UPDSA old and new SA should match "dir"
> 
> v6->v7:
>  - add replay-window check non-esn 0 and ESN 1.
>  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
Why? I still think that having an 'input' SA used in the output path is wrong
and confusing.
Please, don't drop this check.


Regards,
Nicolas

