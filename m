Return-Path: <netdev+bounces-172585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25545A5574E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F73AAB63
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2127004F;
	Thu,  6 Mar 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX6BRc/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D780342A8C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291980; cv=none; b=XMwo1kyG2NK+D9clHGUN43ZPWF7jTCI98Q6ZXBxkBarVw9jWx6p15P3hWotfvPJu8lkiQe0DyKRC2lfheIAflLQKQkCpYzLC6deR1WxfnULmuNIhBlXJv52D8wm5nl9crPxSa0M81CSMl2WJxRo8OJTt6fr4sacUEJObFo4o2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291980; c=relaxed/simple;
	bh=2S1Kp5JkT1qcd1Vk2F/xWaElUr1SPbSMlpkzjmOCq2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8ZDOMjDOVewJXigq6R81SIVhjLbJkLrtGyep/D6xIsmzraxAmh2r4IgaycIUZikXYkSUkXYxu4C2P6k3aKMRlj0f0G1lC5ggm0gsKfIX1pOujvtHun96kxbVcX2xZ8fsNThsRtHV7I7xuZaR0xojhpRb+wCdoRmJBkqv9W2Odg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX6BRc/u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bd03ed604so9769225e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741291975; x=1741896775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XM9NroXNmh9SFHEfObXdCAXMKxLrtNnq7LKRHsgAuB8=;
        b=YX6BRc/ui5UCgDTJy9b8M9EsVuRqOjIIGc+dhKqUWYA/XGACJ3XgcMRyKuvzMul5BB
         V9riQKwt4L/viSY6/o2K3dPiGlWccXs0eaaAv5a2AmmITSs87+unOwfynPJILCnzYe0S
         BY0ChHonhj+loEaHW/nkg2MT9xEjRutjillIsUy1qTuRXmwFurjHhyIlfEW7DjU2Neo1
         RNdPlkF8Hy51d/zMQenS4bvm5WCHpGyVAqpIYoLgoZWiI0koOa/RmFvzswfwMlhCKYUd
         9ikHgS3RpYBaCi7S5THyzgK3pZroQRo3KYzES1bv0lMykbVEzH6h3L4Cbn46UbMMeaw7
         3Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741291975; x=1741896775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM9NroXNmh9SFHEfObXdCAXMKxLrtNnq7LKRHsgAuB8=;
        b=GGxch4gK/c6WdCC9pI7LbY46YxdJXaTfedURS4L6WjBkdwYxpuqPWX4H6lxM/y6lXt
         T/C1XT3mONt/kuQToPAoOCTN6MVSL1KdUn7FzGg2saCAp+5gyWw0toKKogIrbvnjNudR
         nrGYYA9iIn/B1vC6UKkDbT4+OXbRk6yanMFutOQamqFg9O0wNFSLkxh0/N8mCoGhoqIu
         a10bmFC5b9OO6w9fQl35nU5Pylwi2WqZGzpiS2lM7jM/wIc06AA9OmTRtpzFDtV2/Y3+
         CQdH4BTGK0vwFD+yI6xEJwrvc3N5oS3OYqZ3kFcVifzsc4cLKW3hfvpProcI6e4DsBQc
         6UEw==
X-Forwarded-Encrypted: i=1; AJvYcCVeC9qXAO3E/sDM+pG8den6zwuSU6rhbJ2Ftdi8FrWxrYwFVlm5WQ1BJxVdtxNzKuKCydPBXLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRmLv39LQRuvJrG0eDlLn4KRBsXkQUSgRI2TPZtoojMNosbYi3
	5LP8xsyoE8LC0qot4vCFJruR6GPZxq+t4N0bPyvRKgQhmiyg8ko1
X-Gm-Gg: ASbGncsJRJUQaW2XnAy2S8ZpvRgVVfkFEndlKqIS/N7QVQMPc7oKsRG8TeCav2D1BQh
	6K4u2t0pgjAQ6tja5gn1Aib5qV/Y4eBcUAMkSveaUn74Oz61UNGb/OIQ5UeHxtC7f18Az2mpKEI
	8h92ad1qlHXPOaytiX1PT7fWFteXapwic9yKhlCGyaQ08ML55SQv37kP29bbxLKgB+8TUbW/R9i
	F/v3Ul3a4oqDjijELG0mVbLCnRd8jiQKVEsKsh3QoN64QdBTOfyA7FM8B79Y3ITuUGYZyiaI2xs
	qWBzgYTuoYkpWljk0O5Ga7sdR5+WfjKn3ds7uQmudGT9VTWXMetxYvcy3dIG6fs32A==
X-Google-Smtp-Source: AGHT+IHC+zO9mrSmTQ+f9DwcLW6rYm67+tSZr1m4hDMWCEeoiLkyhW46YFvcUh4AAp+GB/KkhIw/2g==
X-Received: by 2002:a05:6000:2cb:b0:391:13d6:c9f0 with SMTP id ffacd0b85a97d-39132dc51a0mr359603f8f.47.1741291974650;
        Thu, 06 Mar 2025 12:12:54 -0800 (PST)
Received: from [172.27.49.130] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba87csm3081376f8f.17.2025.03.06.12.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:12:54 -0800 (PST)
Message-ID: <3faf95ef-022a-412e-879d-c6a326f4267a@gmail.com>
Date: Thu, 6 Mar 2025 22:12:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
 <53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
 <20250305183016.413bda40@kernel.org>
 <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
 <20250306113914.036e75ea@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250306113914.036e75ea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/03/2025 21:39, Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 21:20:58 +0200 Tariq Toukan wrote:
>> On 06/03/2025 4:30, Jakub Kicinski wrote:
>>> On Wed, 5 Mar 2025 20:55:15 +0200 Tariq Toukan wrote:
>>>> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>>>
>>> Too late, take it via your tree, please.
>>> You need to respond within 24h or take the patches.
>>
>> Never heard of a 24h rule. Not clear to me what rule you're talking
>> about, what's the rationale behind it, and where it's coming from.
>>
>> It's pretty obvious for everyone that responding within 24h cannot be
>> committed, and is not always achievable.
>>
>> Moreover, this contradicts with maintainer-netdev.rst, which explicitly
>> aligns the expected review timeline to be 48h for triage, also to give
>> the opportunity for more reviewers to share their thoughts.
> 
> Quoting documentation:
> 

Thanks for the pointer.

>    Responsibilities
>    ================
>    
>    The amount of maintenance work is usually proportional to the size
>    and popularity of the code base. Small features and drivers should
>    require relatively small amount of care and feeding. Nonetheless
>    when the work does arrive (in form of patches which need review,
>    user bug reports etc.) it has to be acted upon promptly.
>    Even when a particular driver only sees one patch a month, or a quarter,
>    a subsystem could well have a hundred such drivers. Subsystem
>    maintainers cannot afford to wait a long time to hear from reviewers.
>    
>    The exact expectations on the response time will vary by subsystem.
>    The patch review SLA the subsystem had set for itself can sometimes
>    be found in the subsystem documentation. Failing that as a rule of thumb
>    reviewers should try to respond quicker than what is the usual patch
>    review delay of the subsystem maintainer. The resulting expectations
>    may range from two working days for fast-paced subsystems (e.g. networking)

So no less than two working days for any subsystem.
Okay, now this makes more sense.

>    to as long as a few weeks in slower moving parts of the kernel.
>    
> See: https://www.kernel.org/doc/html/next/maintainer/feature-and-driver-maintainers.html#responsibilities


