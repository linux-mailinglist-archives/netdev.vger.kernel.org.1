Return-Path: <netdev+bounces-90604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D88AEB02
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E9B1C20E5C
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6313BAF1;
	Tue, 23 Apr 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="TLs/MHmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944413BC20
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886062; cv=none; b=q5BXSfl7+xUXItMEvcqg8cAIF+hH99pkhqDaQWicnZsEVnzHYvLbV2KbcBQQi4DccOGY4X//0/pJsbDFiRdShjHk8vdUa3Qhp9EKMOI0xQNFP9w+hHAhaBXAohhtLvPRQyyqRXQUCeRCPnsHtj1eTJ/OoiQdAKKpE2GsHt7AXc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886062; c=relaxed/simple;
	bh=BFypqAv8U50w3WuJDsplwm0E71eqJxHq1OKvdwNETRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKfqQAEFPPZdMYjDPP8hy8zDol2CmnCwI5vdLeg3hEQ6IxwOpO7h3K+owErMZ11Yb+JX3pFgeAENYnphOZzu3nSJVyGLGwZXnG+KGZqp8AhZ0Efb5Uy0lrsyhgEgZn1lKePmCS7kvvkSUejOjlTqMVMl358zilv5edqxl6oo85U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=TLs/MHmm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41a5b68ed5cso24273225e9.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1713886059; x=1714490859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NP4Yxhhvx6O77mwXJVK7IB6oa4CjJexQ7edB4wS0ZM8=;
        b=TLs/MHmmTfMCY+eSqh+DUX0PWlljbaayovjweLde5/f22eP/9e/9WJWiF3XenugLUu
         9CYUJe6S9vT9IsuJ0yWdcnePWkNxJqImdBT0LBKVrFwA5qqZiiVLofD08CABw++8rApE
         0LfBK8rU3+Bk/haQnWzZPFOOnLP37ykhy68rWDf4RPtAOE5k6x0S98vKxJdbf3N3vIKU
         8PNjUMIGGUvnrzNG/U8EteXH77f6m5UMfajUO6Fuq9AmacQgR+Kg67Rg1rTdLtpUiquO
         Ri+P6U9vXmzYRKu3rJxiPpPX0YndQ4tga+8oVEWE+U1dTUIGiZFkXKzbSxw+HCJNuuOX
         qHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886059; x=1714490859;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NP4Yxhhvx6O77mwXJVK7IB6oa4CjJexQ7edB4wS0ZM8=;
        b=LrdqRJSgxVEQYFWCgu6JT1AKkXxLHNI9Fp+MXqaxRVJ28h+585AfzMjs2j5kVnJ4w6
         tTfSnqM72dI7ZOryGxmeMSMxPNvDq+AEkX+B4TqtAR8lDJj8zh4SFF9cnNCwExwEmW8b
         DZd5Qll4+LkqZ8ekYJ6eTXQ1n4daEj2Hadmo5RlC0Psbn9h+oyEF+jg30AvCN3gLI/0t
         RgTT+cLg3m9PYlwIVKBrQYP5trG3yCDWECc9x3vLcjEFv+JfwpOeyMWsLFHoFCd32oqE
         tLPrr/lOCr04BJsQj4dU0p5zz8q+0InGbuQQF1hH89duWMVCprY//cbTPUyBvBbrVRPD
         GJwg==
X-Forwarded-Encrypted: i=1; AJvYcCUqicQAklXk5Czkgts0iBoPoh6JagbbpDHP1nhGoA8+EEF/DM7ceun/GpGBXyx/jrQorni8TEHd8iO9Li1i4UpVDCxU08hW
X-Gm-Message-State: AOJu0Yy4ouD7ufBhbhqm5R0PofDdUXeOrZts6L0b+VrMN2jgsN9gxfyC
	g9I/08uuHH6aLoUmSsxY2uujibZvGAi6DMK4dpB8Nd95CnoDLb3mB8ribyVNCzA=
X-Google-Smtp-Source: AGHT+IFWnWoy+tNdk03XlARg88AIgs8u1Kcmfps3PA7bC804qbYAoPXRgUfZR7wGWs+s28myeSjQRw==
X-Received: by 2002:a05:600c:3d8b:b0:41a:bdaf:8c9c with SMTP id bi11-20020a05600c3d8b00b0041abdaf8c9cmr1816883wmb.35.1713886058802;
        Tue, 23 Apr 2024 08:27:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:286e:b61a:3958:bd85? ([2a01:e0a:b41:c160:286e:b61a:3958:bd85])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm18321795wms.32.2024.04.23.08.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:27:38 -0700 (PDT)
Message-ID: <8ac397dc-5498-493c-bcbc-926555ab60ab@6wind.com>
Date: Tue, 23 Apr 2024 17:27:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v12 3/4] xfrm: Add dir validation to "in" data
 path lookup
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <cover.1713874887.git.antony.antony@secunet.com>
 <f7492e95b2a838f78032424a18c3509e0faacba5.1713874887.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <f7492e95b2a838f78032424a18c3509e0faacba5.1713874887.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/04/2024 à 14:50, Antony Antony a écrit :
> Introduces validation for the x->dir attribute within the XFRM input
> data lookup path. If the configured direction does not match the
> expected direction, input, increment the XfrmInStateDirError counter
> and drop the packet to ensure data integrity and correct flow handling.
> 
> grep -vw 0 /proc/net/xfrm_stat
> XfrmInStateDirError     	1
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v11 -> 12
>  - add documentation to xfrm_proc.rst
> 
> v10->v11
>  - rename error s/XfrmInDirError/XfrmInStateDirError/
> ---
>  Documentation/networking/xfrm_proc.rst |  3 +++
>  include/uapi/linux/snmp.h              |  1 +
>  net/ipv6/xfrm6_input.c                 |  7 +++++++
>  net/xfrm/xfrm_input.c                  | 11 +++++++++++
>  net/xfrm/xfrm_proc.c                   |  1 +
>  5 files changed, 23 insertions(+)
> 
> diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm_proc.rst
> index c237bef03fb6..b4f4d9552dea 100644
> --- a/Documentation/networking/xfrm_proc.rst
> +++ b/Documentation/networking/xfrm_proc.rst
> @@ -73,6 +73,9 @@ XfrmAcquireError:
>  XfrmFwdHdrError:
>  	Forward routing of a packet is not allowed
> 
> +XfrmInStateDirError:
> +        State direction input mismatched with lookup path direction
It's a bit confusing because when this error occurs, the state direction is not
'input'.
This statistic is under 'Inbound errors', so may something like this is enough:
'State direction is output.'


Regards,
Nicolas

