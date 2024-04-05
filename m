Return-Path: <netdev+bounces-85246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8093A899E51
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFCC91C223BA
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178E316D4D6;
	Fri,  5 Apr 2024 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NUpk5nSa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA816D32D
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323875; cv=none; b=Z7Kw/0WmLdMj55VfTJ4PhOVWz28c4c4Vb55ko3ZEFIMBshk+Oo8xLJsk6C/BYb62+rA2D3uSkN50FXxow1dRQhb3grAEufgyXYQjXLYh0pzIA99YMlpLGpIHC5HssZtZeXaO4Um0BXOu4U82ARVGAuIKOml79a7ekPesDRrdIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323875; c=relaxed/simple;
	bh=JxihC+qfJqTFL7/2ag9lbCqN/tVEemhNNwq0pNruhAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9zbi88md9BisIcUlGFZzKd4DyAgQHqOeS1L7y0ndeA1VWDoRZ851uB7G3zZUI9WElEMs1W2UMEE0LTAlSEMKJt9+FCUxevUYYExX6j+zW5q0kPqh8AVbAbm8Yy1tM93hDesRiItEFVhf8/PLoVpbcdH+V/BV2kG91ToYMKcBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NUpk5nSa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343c891bca5so1096599f8f.2
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712323871; x=1712928671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=By6lcdQLbcLlAHLoATojSqc8SrvrfEcM/+44lt3oYk0=;
        b=NUpk5nSaellpA7+T9j3cTlk0Vp4Yw99ouTz1K+nEvvDiNHPR7peEJQMG+C6sd+ojJ4
         eFjA9MiPEHH1GAj8gHxX/Ue1LfzGIrYm4OeMyhehFsjk7S0X/37HQyQlwdK7L72SOqw/
         BVdlw8c2+Lm30ohgjXqFTBkUDb07rXXMY5xlHer1oYPwJCc8mPbXfjI90stAe1R5DqUS
         OOQueBoOPhw5Yry6KedEWljx4OzQ5nV4TGckEduzDt1NiTQom/aC+bsMXemz1puJZFbB
         PJ0J1aPAceolRCVbWcrsddvxwgwQP6Mq/DI8lDLfofF24Ncz2PW0PKk9/hrRWBrJ1RKh
         kK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712323871; x=1712928671;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=By6lcdQLbcLlAHLoATojSqc8SrvrfEcM/+44lt3oYk0=;
        b=ZdDKI06HROjdlAB+iT6YtXUWqSI6WGyfu+QJm6za8EQoDvlvmRUk6uhc0Gc1rgVKaN
         4yFOI0HtiCqJVvpqraMAwqpsPn2MHnN3JT1ThRKwVswiYjXMzvekgw8zzP0AMrB5+d7i
         QqeLskk+vsAUmyDhK80UDmotajf5qD4lJdCaXZ2KSGflVBXMPoUWyTxC8RQIiNwrP/GJ
         htgZUZiB/kJ4ejBDaCnU4zelamXP33tzc8zkaIWIr7xskuCGnRVY5TLQnwq2RBYvoYau
         MeaPwWPIT3y1tFkziDOAXbtefLNVP4SoG5tPGtO9apxkBlC/aUOMNlZLyPwWjC97FqgD
         58WA==
X-Gm-Message-State: AOJu0Yxr7lZlwmcWyALyedR4VpVHcNukOPFFrtsctmG4vRkonCPpMgiB
	X8fEXkVqvEytdjlhOXB2y/dpMAhjAVl8ZiQFWDsSzqIFiOjUKaSNKrFG4aZEDwNsJGs6h066IiI
	C
X-Google-Smtp-Source: AGHT+IGq009NvB/wq9AiyZ86t1rICgHPvZ2SWt79TB9NAgJeNIU8lMfRaFKFXgiB+pO6FzQxNhBVqA==
X-Received: by 2002:adf:e7c2:0:b0:341:89da:540c with SMTP id e2-20020adfe7c2000000b0034189da540cmr1287367wrn.26.1712323871652;
        Fri, 05 Apr 2024 06:31:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:94eb:2672:19d2:1567? ([2a01:e0a:b41:c160:94eb:2672:19d2:1567])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b00343e1c3298asm1867852wra.0.2024.04.05.06.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 06:31:11 -0700 (PDT)
Message-ID: <b3dc28a7-395c-4699-a418-cc52ca614a5f@6wind.com>
Date: Fri, 5 Apr 2024 15:31:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v6] xfrm: Add Direction to the SA in or out
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/04/2024 à 14:40, Antony Antony a écrit :
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
> Currently, dir is only allowed when HW OFFLOAD is set.
> 
> ---
> v5->v6:
>  - XFRMA_SA_DIR only allowed with HW OFFLOAD
> 
> v4->v5:
>  - add details to commit message
> 
> v3->v4:
>  - improve HW OFFLOAD DIR check check other direction
> 
> v2->v3:
>  - delete redundant XFRM_SA_DIR_USE
>  - use u8 for "dir"
>  - fix HW OFFLOAD DIR check
> 
> v1->v2:
>  - use .strict_start_type in struct nla_policy xfrma_policy
>  - delete redundant XFRM_SA_DIR_MAX enum
> ---
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

