Return-Path: <netdev+bounces-81272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01910886C68
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829B51F2382D
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A37446BF;
	Fri, 22 Mar 2024 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="n1F7BO9w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A72B446A0
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112088; cv=none; b=jB0BMnuXS8c343/RgIC6zejMq5NI0G2DCclFuhpsJ459oyuinFNOqqPlTHSbeMU6OR77pwMD4U1llTIJy4S7Kn3OGtfcKSJMyjYFhY29wgKqA45u0BXbboC+wyIFNIEkc/6nyWHWcgB5ulyIYK/baZuELFP1nCnjCG8IwR1NgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112088; c=relaxed/simple;
	bh=qUID3mZSQIA6An1Y3lJr2Guwz4uyB38nOJOdjkA63jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA0DcRrUPVJlSXKSJWT7963MoAczCEhdgo1OQ3DpCJ4tF15A1E0lBZtpKjwig5yGmF29mN2FZ0G5J3TpTej+Gssn+OZ4GhEFBJ6wPEeUrgAUAVTgHOO2HxbUYJVsX1TZYTnYlyS476smCNXCcQkA9ElXqgOMEjxPs8ZssJug+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=n1F7BO9w; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5157af37806so2409405e87.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1711112084; x=1711716884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nO3bLdBvKpvF/4JLicbn4vnf6TMOKC5qR7Lasn1JfQU=;
        b=n1F7BO9wt7pSJYQVcLZe6rtmXtVfsk6PEuKw7c71XgpTdDDrFC1ijYtBUawuofUIMC
         ajrZHlPMQJMQXlRECfpg+pLkZOYi9njvsL/wCYsnjsux3jD9IvgYSsL2Y6jhaoYAORyY
         wZhrXMgCZdXO1AQQEci7DqDHPXnrKuqoaMgqva090vsNDKzEXWJT/xCWG3eq7ZTCISJW
         gBs3vS4D+8VQpaSagvHkiDNnrpUsXU1h/m6vx03N7QkzmYmG/TxgSSSSwEa6tOiIE2re
         eXsDlhEOm5JLxdO2VUCb7Whrc8v5112LcSfXIL0ii0WyUfKbfc8yR2J8OUKcDvaFondk
         t4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711112084; x=1711716884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nO3bLdBvKpvF/4JLicbn4vnf6TMOKC5qR7Lasn1JfQU=;
        b=tDJUmPER+QsqIohW3EqsNgVOWg2rb6rmZ+YNJ5eE1YOHcKRVoR/++4fNUcuOIdB6/d
         Ij/DuBd/J+6geMwcqySui2c08lSykqf9US9IJ31HTP9HL8Fvs4LpTNKiU+b15ODzehe/
         rUgH1QyhLcNOhdwPDdeQZCbQMQbwd7RV8aiJI17QJQa0gJzZD98Oi7ZIYKaSDM3eLP29
         PjGF+6ENl6sWuCQ82cl6LKzodOEzJrX15LXHbrOpkLslcczYlxAfTz5iqpJqcCwazTQ+
         6sMR8eweWce9CDWBsXRA3l1cLmaU0MZQIYl6sYGaRCVPC1Ibtxk3tzYRPSB3YJTI/hxb
         zqSQ==
X-Gm-Message-State: AOJu0Yx+OZClSqTwrW1QPcKi2pHlpEUr/Udt87KOAesFEV2M4gbPQ02S
	HMAMXxZc31YAPGsqteolvSaDsdnx0Mt2WgsgFapIVyi7Of2bj1pGkG3Fa44mnPCIlfzrCGEByOP
	f
X-Google-Smtp-Source: AGHT+IF2FmLRiyJWG3aBET98LmEM8Iy1aRGSNxJMJbjg9nQmG4wOrKzN129FIU2JTpMMfNrZbUlREw==
X-Received: by 2002:a19:8c55:0:b0:515:8625:ae97 with SMTP id i21-20020a198c55000000b005158625ae97mr1792909lfj.37.1711112084197;
        Fri, 22 Mar 2024 05:54:44 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id f6-20020a1709067f8600b00a4674ad8ab9sm980245ejr.211.2024.03.22.05.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 05:54:43 -0700 (PDT)
Message-ID: <1315d24a-f8b4-442f-af24-baf4c7a3df05@blackwall.org>
Date: Fri, 22 Mar 2024 14:54:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 1/2] bridge: vlan: fix compressvlans
 usage
Content-Language: en-US
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com, jiri@resnulli.us
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
 <MAZP287MB05030EB14BE2BDAC9E1DB01EE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MAZP287MB05030EB14BE2BDAC9E1DB01EE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 14:39, Date Huang wrote:
> Fix the incorrect short opt for compressvlans and color
> in usage
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>   bridge/bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bridge/bridge.c b/bridge/bridge.c
> index f4805092..ef592815 100644
> --- a/bridge/bridge.c
> +++ b/bridge/bridge.c
> @@ -39,7 +39,7 @@ static void usage(void)
>   "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
>   "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
>   "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
> -"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
> +"                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
>   	exit(-1);
>   }
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


