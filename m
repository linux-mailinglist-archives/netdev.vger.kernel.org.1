Return-Path: <netdev+bounces-153879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596099F9F06
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCA0188D57B
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 07:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521811E9B30;
	Sat, 21 Dec 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zgoga0QS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC91AAA3D
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765746; cv=none; b=M7kYvMcvpPeZMHNfyQnabQLO+StvF9YYhVd1TgcqneZXkbx5aUaEvtV7xMxxlY0aCemt60vSFUdPm04p5HG+eaTLlUZEMZRnRcgwuc9Gh1jhhJAVKvBgMsadxR/t8GhkEVec/6QjXXBMppQ9ejpaUr5bnKVhMnZ/SbTLJmU2078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765746; c=relaxed/simple;
	bh=37a/v6V/qVTYj75OLJ0gfzJnVO9B2xvI3YKnXrcIlW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyzzV+PsUPyI1nmITLhfkOcJFOWYUxmzIQ03mcC578DCmQG1QQJb5PrJw7PYlT29/WS858uCEK9r4K3Czt0Mb2/yrG+/WI2EZfcqEI0gygcjBiOiAlP6zvqDHaIEDIKWi2hSp97TCfLkM6FP8pSQUDKT9nmwTFw5gvM5W9wg748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=zgoga0QS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436202dd730so19059875e9.2
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 23:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765743; x=1735370543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDuHJJaQb5fwBxcoZeTtCnujI4Vxi85W3MczCC/iP6k=;
        b=zgoga0QSs/FSgmWkPC34lIGH65A4rdwERvxYqaWx5t+WCKyHXuthfWAROfxECnxzxG
         Ywbb6u7QDCvn+KpLR+wdqRQG3gXBEN98WVApTkE0DTG5SCrKO/8bXhpJZdJM8DeyiYmr
         AT3o0ne+JxmsZLuWH8zaY91JgeKh3LQFWMIpC+7SJ66ZmiuImlhpXLQJ6ypoHitagjK5
         reTCagvVeO7/ozbLaS/kJJ000xt2WO6hZpN15oNYBYmFKuWNPq929cBKtvrX1cl/OOGB
         Cgzcr+1hXHAzA5S35LlHCOwDAaX65o2cA1T5piFp+O8ULfgvrPQdHjoOQiX/mkJllIFs
         oBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765743; x=1735370543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDuHJJaQb5fwBxcoZeTtCnujI4Vxi85W3MczCC/iP6k=;
        b=fpxqXdMsGhZB17NNduP/tXCa32rKcMb56GjZC2v1jo1DF7e9zdACatSvM0jt3w5GKR
         JLUwh7HolHPT1qQwnuLycLZCbERjoXDuKHzSq7qbOaTbsjMHfDThIyqPxl0h1/Wi8upA
         SrAX65ra1F/mYzslnuwVXyj8GYrvkMhU/6d0amCRDg2l3hHrcZB5epEh9mmlq6UuidFJ
         POrFf3mt0wKo0U8i3RDOg6FE6RruKvrJ4PnjhIllfUz57U9JjP6qrxWJaacmHxbZqADu
         nz4nMl3TeI8h2zW4tKjLHJSfTNZ9gDmLN2RqPs5E0Rx1GD5yk455nlc0N/MWBmA2h1Dr
         yP3A==
X-Forwarded-Encrypted: i=1; AJvYcCVtRkd7PQQe8kTp3nssHpF5ijLad0Dim64IecWkLskMhG3Cqj7WsSp80hEQTPC2+OIR7b1kS84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fJ+hMhF0Ir9QrjCpOSkQtXUAC5ogpE1pyDfb8eAE+e7BWttT
	aR+sbNoGiypi5fO9PgVsMOdGvcDOUsW+VNU/vJsTylOG/3B+YHp7hzAiQUwHFakyxNEPyxPqZeR
	U
X-Gm-Gg: ASbGncuyjUlzo9GxpGmcO8kheJCO5aetxowU0Xq94BFQwtpLlTBnCVVMz/WzIPr9/IH
	86HxUdJthianQZZITZzISi6J19JPDGn8jDgDqENW8IHMHGYJA7U+V34DYTjea2mBmgCJUoUl9b1
	VuFAyjul0et/f5MHbQWBfEYHJaEAMMwfOG4aSFXQGC6xgbk4i62kHzBFPe2DnusPm14xEHxh/uN
	1XY7s1t+Afzenssw0cHwpxF0YBKFN6O9JXcFDSV2FUWhxqi8JuW8POU5k5dYRQX4HhDVZPVNPgJ
	1O5fwdNARmHz
X-Google-Smtp-Source: AGHT+IHfdIN3rLQI8OJcOpR3tltD5UI8SyUBOxEPS8cqsdqsJyiKRr61UnJbs/KMz699DK7W2DbVXA==
X-Received: by 2002:a05:600c:4710:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-43668b5dff4mr42643005e9.25.1734765742814;
        Fri, 20 Dec 2024 23:22:22 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c4esm101601405e9.4.2024.12.20.23.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:22:22 -0800 (PST)
Message-ID: <5338e487-0e6a-4b90-affd-328d8c471d62@blackwall.org>
Date: Sat, 21 Dec 2024 09:22:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] netkit: Add add netkit {head,tail}room to
 rt_link.yaml
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241219173928.464437-1-daniel@iogearbox.net>
 <20241219173928.464437-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219173928.464437-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 19:39, Daniel Borkmann wrote:
> Add netkit {head,tail}room attribute support to the rt_link.yaml spec file.
> 
> Example:
> 
>   # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
>    --do getlink --json '{"ifname": "nk0"}' --output-json | jq
>   [...]
>   "linkinfo": {
>     "kind": "netkit",
>     "data": {
>     }
>   },
>   [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  Documentation/netlink/specs/rt_link.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
> index 9ffa13b77dcf..dbeae6b1c548 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -2166,6 +2166,12 @@ attribute-sets:
>          name: peer-scrub
>          type: u32
>          enum: netkit-scrub
> +      -
> +        name: headroom
> +        type: u16
> +      -
> +        name: tailroom
> +        type: u16
>  
>  sub-messages:
>    -

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


