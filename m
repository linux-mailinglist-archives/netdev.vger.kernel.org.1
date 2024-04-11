Return-Path: <netdev+bounces-86902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A98A0BBF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC11B22DAC
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB6140396;
	Thu, 11 Apr 2024 09:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="g2AKEd9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0D62144
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826098; cv=none; b=H4IVQPeFH8HefmgMxIqKM1VAe4ZWPfsBAg/JfCIghzaCOV+kqSrXB6/JQMdi5KRoE9Lxko8yHqcJu4oNMTe3wsHXFOMdwiW08KJDR0xhW2YRcG1BigJj0N3d5OJKIG0L+ZJt57uiCCz2eM9k3odOX17JfbHCKecfmhV80L8i5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826098; c=relaxed/simple;
	bh=GSoQQEhObTZqKNbNTjbmw2Pu8jRd277ESfN2R35ml/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3ZOtBjrXFTzpJvHW1Q7P1bv6ixBkUPiGYj2pqyEWXjwsvZbABFTLwS/m4FrcYbZNWYabuU0WDYig+i7EkLpR0Ir4Iu/qQyxs27xPINV04Rq+eNEDsI65regBdoZydJvImLNFMHy61ULUaSyxiT1FOyFb3U31YFGymDRGgSEztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=g2AKEd9M; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so5463181e87.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712826094; x=1713430894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qR2uulpByHN+MqCDRk2ZfluHjqnd6wrT47zQr7TwNYo=;
        b=g2AKEd9MenVKAh9xdRJjSG0+s0aLRXfXzJkknWQRmIxa/jMDcdlr9Is68l1o33dYf1
         DoyyYgb7enaRQbmghE0sapCLdiPUohIy880gammON+zbvXcDQlc8nbKysvpgcXd+sc0a
         eA5b4SQo6Ay7EtzUyEJJJ9P71BxQh1LTJ9vbUofffklJG88tYCLv9A1881RN1sAfn0St
         1O2H8X8EvAxp7hmpvQNbp4q8e6GLiludL27Lm7Y7sxiAvDM8V8SHhilC9m7EqwztxuHP
         hIf7B3aNSfW0e+bGbJwDvmVSn1qFDzbif3ExA20ZcXf2Eco9e/0FHO7c/Ohrl8KToG+n
         65EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826094; x=1713430894;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qR2uulpByHN+MqCDRk2ZfluHjqnd6wrT47zQr7TwNYo=;
        b=UYqxGSmEirPocLzcp8wxbeoDFEAPCkuAw9Rdw3nXlvpy/q8NDPlDstGRoC1Z0+PdLa
         uC718iuZgBSIOW+GaKDpgoCX2kOEVDwgvLYecBgMsmg1Fb/FAxyXZ7kNkhGr598NyZAy
         QcZdKZXGnnvEmgBSGX3SApCEip12Eg6nXxsXMZ/jGo3wVUfE9lw7irWmSRlrU8BcwGjY
         jfGxIrbCnNYAWYt3WI8cMD+wWZ+XoPALlwASIyAfts27wUyibdZ5ZoSAF7vO6T5Y5YRE
         PfqsZBxBGmEmthSv25IhNnuOvchddA9VLKLXkxFM3Ju7UndHh+9X/EMqqvJ1L4sKFe1e
         atNw==
X-Forwarded-Encrypted: i=1; AJvYcCVC4zaHWTRziOycErv/ayQVu7XgmJyY1KWrODO5UE6r4ilk0FA1n/vYlxBW1M5Uq8An6uZkMnmk5Ix0/qVUG3OJiF1GPvFl
X-Gm-Message-State: AOJu0YxWOYjkEhVMwpixYnW9uzKo82PqmXGY5ZpYp5r54JAD6c0n+lj/
	9Cpx44jZmJDeGPHZf66ICfyPRqm2PpRRQNCmCdxKQzAaBF5gVmUViFTOtgHb5nwDaamLsuVs3Qo
	o
X-Google-Smtp-Source: AGHT+IHac3n4GzsYEA88zxdddbyTLvCZAug3Gr+tyla+TbnsbArQx1Ad7HL+/ha+JGZQ5dJc2yCFtw==
X-Received: by 2002:a05:6512:4021:b0:516:a6ff:2467 with SMTP id br33-20020a056512402100b00516a6ff2467mr4600228lfb.0.1712826094400;
        Thu, 11 Apr 2024 02:01:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:99b5:2ce4:3a1:b126? ([2a01:e0a:b41:c160:99b5:2ce4:3a1:b126])
        by smtp.gmail.com with ESMTPSA id q3-20020adfb183000000b00343cad2a4d3sm1287937wra.18.2024.04.11.02.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 02:01:33 -0700 (PDT)
Message-ID: <39ed70fe-ee5d-4e9c-8fba-d3b2dd290cde@6wind.com>
Date: Thu, 11 Apr 2024 11:01:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com>
 <ZheNx5AYKzmRjrys@gauss3.secunet.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZheNx5AYKzmRjrys@gauss3.secunet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 11/04/2024 à 09:14, Steffen Klassert a écrit :
> On Wed, Apr 10, 2024 at 08:32:20AM +0200, Nicolas Dichtel wrote:
>> Le 09/04/2024 à 19:56, Antony Antony a écrit :
>>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
>>> xfrm_state, SA, enhancing usability by delineating the scope of values
>>> based on direction. An input SA will now exclusively encompass values
>>> pertinent to input, effectively segregating them from output-related
>>> values. This change aims to streamline the configuration process and
>>> improve the overall clarity of SA attributes.
>>>
>>> This feature sets the groundwork for future patches, including
>>> the upcoming IP-TFS patch.
>>>
>>> Signed-off-by: Antony Antony <antony.antony@secunet.com>
>>> ---
>>> v8->v9:
>>>  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
>>>
>>> v7->v8:
>>>  - add extra validation check on replay window and seq
>>>  - XFRM_MSG_UPDSA old and new SA should match "dir"
>>>
>>> v6->v7:
>>>  - add replay-window check non-esn 0 and ESN 1.
>>>  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
>> Why? I still think that having an 'input' SA used in the output path is wrong
>> and confusing.
> 
> I don't think this can happen. This patch does not change the
> state lookups, so we should match the correct state as it was
> before that patch.
This is the point. The user can set whatever direction in the SA, there is no
check. He can set the dir to 'output' even if the SA is used in input.

> 
> On the long run, we should make the direction a lookup key.
> That should have happened with the initial implemenatation
> already, now ~25 years later we would have to maintain the
> old input/output combined SADB and two new ones where input
> and output states are separated. 
> 

