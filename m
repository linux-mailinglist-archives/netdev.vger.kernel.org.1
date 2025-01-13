Return-Path: <netdev+bounces-157708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E3A0B50A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C1E18866E3
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E922AE65;
	Mon, 13 Jan 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBwT5Dda"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679D19259F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766281; cv=none; b=jTCtffST9t+B1fv1MjvsOWSzW+lOXIWIRqV7dZPc4cWY2Aj8NHPN75ZSGqYt0uNuNnEbhM8/xbWp/De4EMchwwAKx+RQY1XsrcNF5H/sf0tMf6xBnkEdklbQEJkpW2th5Rbvg9Cc2Lj7yM0+XDli0etEUPY1Z/Q2f3QZvwnA2vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766281; c=relaxed/simple;
	bh=x0D/i+KhhuCkNWXFOseN6c+kFaGTNCz3JhPXI85QHIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDVFkgpBXD3z1CGoPeq9PWNdYQXXXYke3flDtrSvB+CXIMHUKb6X+VnAoLJMMYqePTF25N1ve1eFb+I3H7tI8gSN+AC7G/0uYEu+JZQI2VcQtOlQbhJ2+0EHvU3sGY/Nn+NSQHgqOER8IVvWytl2ZGy9B+zaHzwqDcIpXAtuf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fBwT5Dda; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436381876e2so3773875e9.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736766277; x=1737371077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gEmfuSom1K4g2Z3xa5ZnSesfn3qFrMdTPJjB5HBZZu8=;
        b=fBwT5DdaWrvbZF1h25RN1S3VjpEvxokJF1ERf4nN1z7fYKxSPJDMYjAmCOl2SZ01ZQ
         6AchWcdNJf3AShxjiihGRqZCXdvSfpt3aK75BurZ+199PAXfNiE6xNKArh8uyemDutMc
         cLYvMcV9+AG9D2eZc/Keh+Q3FDOOPllfxrFGzOvmwWK4BSoLjED6nTDYmwIOg3blgX2e
         D4uAz5KxYw5BDmbKSpp8uoN419D7DUS9PZAggOZiB9leYo0g772DJlJbkc8dzx7SyyJp
         z0yW66w8p/8zbXQxkoog24IV+XwrAyzF5aVDM89YLEuLu2HhUWThNs74RzSXVMLFjJKY
         y4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736766277; x=1737371077;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEmfuSom1K4g2Z3xa5ZnSesfn3qFrMdTPJjB5HBZZu8=;
        b=Wsq/ONlHwSlZajFXAwvXoXmpyL3cdBew8l1Lewmv2y8/ztHt2vSzjIBrdcMyzZ5vpq
         S77IwaMNXM3OSuVcd+Kf//rwtpwP+Q/+p0H/COSspAg43jjaNmq/eorlwCZN9+z2/CJv
         N0mgN12Y5V5dlX47GK2C+bMnwcpvtGxTcxRxSWSRwbNi3QsFOjdlvJ5PmiQ+o7qFLBfJ
         ln2PbSSu4f9ncStp+9Lv06xQbrzuYtoWvNB+h+WXBiDv6MWZ1f8frw9pbMDE8WoQjfFx
         jMD+ilTu+WEeBF5rd2bjqLu6T8LH7RM9PBtiWKhJb2t9P1//f2Hd/I+twfLm7YmgxMvg
         vxIg==
X-Forwarded-Encrypted: i=1; AJvYcCUxmM8tSZoSJ2m2em8rMjKdmg9y8JxuRQ/FA/Kgt7Z2aInvVmXL73zxvTlwo39aRTjtGSurCVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLp9hZXjlqMIFG1mR3zE1/qkQVSCMuabMY0obIeGyDGeS4D5+
	aCY+kfhuPvy3c/VqhI4ngzho4Uol9cql/Miyrw8E5KIvquio0Eo+5sfEz+0ihSU=
X-Gm-Gg: ASbGncvLkt0whYtxYQniAkX0jrOdUHU55ou5Vwo7ItwyyfMg0MBhOWvpQvHvsxg5S9Y
	T112Yt5t8RwDa5z0Pj6BagmkFjcdcyfEw5uEuiR4OuR0L++VcFx4wS/AXVxBFXtg3B/fZHs9xu6
	RSLVZ7pCN+Y9uYj4TlFnaAzgiy2nyyyjMvHfVtEsIsrPG9xVbypaLzx3wjjDNnfleihp7QETtxt
	ayEi0tIGOk7xDP4BFK4aQzeF3nf8ihWNegfFXxkOa+VZS/hK1j69oe6MsK0sLgXAVkA5CrBr0G4
X-Google-Smtp-Source: AGHT+IFBhgHEBA9yuB0/M8KWfTrBEJrfmm5y1LllORvx6tSaZm1AW8LC5fWL6ENzzzSz3Irm4PbRow==
X-Received: by 2002:a05:600c:35c2:b0:434:941c:9df2 with SMTP id 5b1f17b1804b1-436e272c89cmr71879115e9.8.1736766277438;
        Mon, 13 Jan 2025 03:04:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37d74sm139859755e9.29.2025.01.13.03.04.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:04:36 -0800 (PST)
Message-ID: <1376b2b3-90c4-4f06-b05c-10b9e5d1535e@linaro.org>
Date: Mon, 13 Jan 2025 12:04:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: ti: icssg-prueth: Use
 syscon_regmap_lookup_by_phandle_args
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 imx@lists.linux.dev
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
 <20250112-syscon-phandle-args-net-v1-2-3423889935f7@linaro.org>
 <0eaff868-f67f-4e8a-ade8-4bdf98d9d094@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0eaff868-f67f-4e8a-ade8-4bdf98d9d094@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/01/2025 09:07, MD Danish Anwar wrote:
> 
> 
> On 12/01/25 7:02 pm, Krzysztof Kozlowski wrote:
>> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
>> syscon_regmap_lookup_by_phandle() combined with getting the syscon
>> argument.  Except simpler code this annotates within one line that given
>> phandle has arguments, so grepping for code would be easier.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
> 
> The patch only touches `drivers/net/ethernet/ti/am65-cpsw-nuss.c`
> however the subject suggests the patch is related to "icssg-prueth".
> 
> I suppose the subject should be changed to "am65-cpsw-nuss" instead of
> "icssg-prueth"

Indeed, copy paste.

Best regards,
Krzysztof

