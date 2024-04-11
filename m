Return-Path: <netdev+bounces-86904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0B8A0BD1
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A92BB26AF2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A61442F0;
	Thu, 11 Apr 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="V42q5Ai5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08F142E90
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826307; cv=none; b=GoSPNsHZSKdRF54nGk6MI7kjnZiETv9JaIJclrSs8Mn5fGOBAuVGmHP9DVP74HCRJntA2fXIyRRG+1HQgEV9J7+Pk10LufGADeL+2mjyOy/L5qWOOKOMQRWvYRZFTY3mlq4Nos+iXFSIh8I76qLLwCZbIqPnmg19VHc9Z+Zq+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826307; c=relaxed/simple;
	bh=Qw5QknleUfW2+rHxO0I+oHb6keipgokcYQKFS+dFqQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4wOo/+PKmP77Q64poTbYZG8KybRK9UJW1UMXWXFGdyNOk1wWZKMSr5ze6gPOZTEqc8OXZns4VkBdziUaWCvx0TB0IZPYiygWBy1EEvvswOb3ptvUXCScVC8zF+fVLXLEP/cDUFYAGMG0YfVIeCeXFze0NoPGvdGtRzAEb88U1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=V42q5Ai5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-417e51e7aedso912005e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712826304; x=1713431104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=56tWXILzbGsX+SGfAlOjASIci7+f48ziI683RzSGLGA=;
        b=V42q5Ai5SFCsHj0CenwEpCtknonFfkBkLajuheTbA7EDlfowq8vSuBWpY7v00Xs3+6
         FF+wUOFtlauWA8ztJHObC1mZE37+6Z8/jrScIF2Aa38foNApFfAIwuBMbHvXvhGLPLf5
         mqHQ3hCbIhtHBX3e/A3S0CuF6zFCmy9zBE/cmMhb5uQlP+Q6ZtxgjZSY0JQkzWggPrgB
         bGKzKAhF5dESdxccKcPU2NgulD6HGLvURl7NHGoXP6xpzQxCId7qzlVKxOG0JRsmRmbW
         2QFxJyE/dNGV9yjBu12mW4uL2zhIMM+qmm4ru9kVG87qXUFfx5MfrJ/AoIy8JhYIA4PZ
         bQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712826304; x=1713431104;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56tWXILzbGsX+SGfAlOjASIci7+f48ziI683RzSGLGA=;
        b=nxIsSO8lxYLMj23MWmT9R/CrcloM+ZgXUuE+935eHJppxIE3hHmjR/w97/vcgIccE9
         SwdqmeTW7f4/hxxM966jDtT4rnFttgdXonhnzepJWmRcXp3bialEADqaEirqulm5NlzB
         yOAwS2KNWelTuSb+09dj0VAWCErFMqLBkVh+7XSx2x1C+8wf5B/snuviM5iZ0eev7aQf
         p5Qqh9w+qTCAmdBMCW/5PSFVIUMecNn01pt3LxsI0ys4q8gwsNatOOOVELNNV5XXxMSK
         UXVykSYFqUtT2ezy6n7TljyyL4MzzROkY91orZBSh+8Kqxm+7wxWeXKDoKKEhPXrZ0bb
         /m9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+IGhWuR6NmXhujgavV9TGjdbRRqBcc0HOZFCCMzy53rX5w03u1qKkFMPaaTNc/U7oooNOJxysfV/3FLInxUPQDwQLvZRG
X-Gm-Message-State: AOJu0YyEyIho75dy6NqmHp0eJnhJoTInwfdJr1v2+DxOmz0hXoznQUUh
	/YGDpC860FluHjwV8807vXng6h/nU2t5cl/ih6I3e+ml44+QpozY02TR4SEFywHhAe7vghN5tjH
	3
X-Google-Smtp-Source: AGHT+IHx3tHgfVi+rUwJbpS5ZD3NSBNRZiu7wrfdLOhvrMDTvl+Bb8IVakBpn1mIhNCJr5kvYl8MAg==
X-Received: by 2002:a05:600c:3107:b0:417:e4ad:d801 with SMTP id g7-20020a05600c310700b00417e4add801mr348115wmo.31.1712826304309;
        Thu, 11 Apr 2024 02:05:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:99b5:2ce4:3a1:b126? ([2a01:e0a:b41:c160:99b5:2ce4:3a1:b126])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b00416b035c2d8sm4943526wmq.3.2024.04.11.02.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 02:05:03 -0700 (PDT)
Message-ID: <4f23c994-5f1a-4b91-9af9-d9d577a6121a@6wind.com>
Date: Thu, 11 Apr 2024 11:05:02 +0200
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
Cc: Sabrina Dubroca <sd@queasysnail.net>, antony.antony@secunet.com,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
 Eyal Birger <eyal.birger@gmail.com>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com> <ZhY_EE8miFAgZkkC@hog>
 <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com> <ZhZLHNS41G2AJpE_@hog>
 <1909116d-15e1-48ac-ab55-21bce409fe64@6wind.com>
 <ZhePoickEM34/ojP@gauss3.secunet.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZhePoickEM34/ojP@gauss3.secunet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/04/2024 à 09:22, Steffen Klassert a écrit :
> On Wed, Apr 10, 2024 at 10:37:27AM +0200, Nicolas Dichtel wrote:
>> Le 10/04/2024 à 10:17, Sabrina Dubroca a écrit :
>> [snip]
>>>> Why isn't it possible to restrict the use of an input SA to the input path and
>>>> output SA to xmit path?
>>>
>>> Because nobody has written a patch for it yet :)
>>>
>> For me, it should be done in this patch/series ;-)
> 
> I tend to disagree here. Adding the direction as a lookup key
> is IMO beyond the scope of this patch. That's complicated and
> would defer this series by months. Given that the upcomming IPTFS
> implementation has a lot of direction specific config options,
> it makes sense to take that this patch now. Otherwise we have the
> direction specific options in input and output states forever.
I don't understand why the direction could not be mandatory and checked for new
options only (offload, iptfs, etc.) and reject for legacy use cases.

