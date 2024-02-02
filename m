Return-Path: <netdev+bounces-68492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4BF847066
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5421F227D6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9607E6;
	Fri,  2 Feb 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQMUc4Uq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560E15A5
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877213; cv=none; b=LDtHkbe0B7O5mUzB1ornMvoSZwh35Lifx15+fO22SZcdhL2LZzLTzrnBlFK/R2DAcifYnovGkugTC/ha06j3jXyvQNo7JcSoZeLxzW38J7pKMFrdIjusFkFGiPgddBJzTnrt22AGo/f2uMrMtTtO0lAVRzdZxGqykONR94MgMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877213; c=relaxed/simple;
	bh=h+Amv6onEGbNxVWJO5o04TL8T2HyEQLNho/dPvfHClw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQaWJ/aBGPsRS+lrxpy/uAphqi2YP4hyPjKbDvW1RMLH31p7XDlKNKNZ6Rkn14CzhpFe6+Oz7jShaFxS0Za9w0iFeoHatWcy9eCwqCxxZedQghTKx6LK345XqcovZj+zLtJwKOH0pp7mduGqDGidAs6Rq1Bn5zbw13HojaMUKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQMUc4Uq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42ab03a5aeeso10956171cf.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706877211; x=1707482011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBT/3nIvDe9coaQLoLxjGMcxKqgLfHw7hcXI4TcXiEU=;
        b=QQMUc4UqKuG/6Yi/CojGudoTMZpn5ptE/znRpqZZv11MDME+hrQ5w2C/RRq62eFWpY
         H2IkTZVA4oKz/dkShRseTYXffxYX3aDd9SBuEm58MLNAXCHIIgJWUw/SWC5ecgqlKJHj
         YZk3Tefxth4jhHP7b6LmQMhSPEwL0VG+e5NdhJvSwah+65oVYugQzjw5alh0nL8UIVE6
         eTc41NXGQTtvt9NnqZYArbAIQUg4S49qDfryyDDk4PQcc+LzMEzvtO2kH+AFIb/2SGqF
         dQoEq6M9V5zVu/70dMAbTlGkejlbcgI38ZXzq10qHtIPGE8WBJeK//jcfIzXcNZmIfZs
         27Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877211; x=1707482011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBT/3nIvDe9coaQLoLxjGMcxKqgLfHw7hcXI4TcXiEU=;
        b=XfDLNYZI+CFqpYlegaphsClSGF/eeLHYmfBcbnue0ayB0o9opVN1RUWhEU3ZHffYNc
         Y82ef5G0U51lU31tVhnED5ZXUOiC/Xzi8tXOFhJc5KJXlFm/I4oWb2xDwtEyD9L99bxQ
         54Aw789eEAlEDQ1tF/5127sTmmNtKqvEzX2goYJHADuuF2VwO3jF9aEvMmgaDqUbtMhd
         7tQvSqJ1dZMkxYj2yFGpX4GizPU6QhjzT7x4Y+Baibm4yGL43PaDBNHOibpCIAw4nubr
         zRCpi84FCg6Tmlc0ZyxvDk6j0zyTtV7pE9N+NVXdIj4Oj/QcDswMpsEaKFyOVYVdgEcV
         CkNg==
X-Gm-Message-State: AOJu0YwQYtWTPa9xRH9NHd5/LowZ4yJhPFQwQVWEvFMc+087cpc33AFu
	Z0ib9wYqrVqQfSuyZC2b8Lw69mtE0ZeiYQwti7rWhQO3sN9nmC39
X-Google-Smtp-Source: AGHT+IE20AIbd8As8Te62hIQFDH7Ya3V7jm6e1twaKn9aBgqZ9d7825xKgH/Ry4UEUE/sVYC6dyxzA==
X-Received: by 2002:a05:622a:1a07:b0:42a:75a9:7cb with SMTP id f7-20020a05622a1a0700b0042a75a907cbmr8110353qtb.65.1706877211271;
        Fri, 02 Feb 2024 04:33:31 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVFhkC12zROUxIORe2VoTNSbOBUmHOtI57XJ0B8hnFH1f2X5C5WBq8c/6oGFAV/U1rCFefk38oFBiEHHAkQVQt/5pPSPag5lfgX97sJfb7aPI5YPKl6l5lPq4ksYryCpgNDn2/+xGyzN4PPnwj4ayOavhf+zgb/qw2DFB0QnftpvTM5UUL1gfK5D9qHA7rBhbOU09p72xyD3l1L6Mnd0iM/gk1+
Received: from [192.168.1.1] (pool-100-16-13-166.bltmmd.fios.verizon.net. [100.16.13.166])
        by smtp.gmail.com with ESMTPSA id qp16-20020a05620a389000b00783e70cf38asm633733qkn.130.2024.02.02.04.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 04:33:30 -0800 (PST)
Message-ID: <b202546a-b8ca-4277-8f34-883beba46f1c@gmail.com>
Date: Fri, 2 Feb 2024 07:33:29 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: realtek: add support for
 RTL8126A-integrated 5Gbps PHY
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com>
Content-Language: en-US
From: Joe Salmeri <jmscdba@gmail.com>
In-Reply-To: <0c8e67ea-6505-43d1-bd51-94e7ecd6e222@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 15:24, Heiner Kallweit wrote:
> A user reported that first consumer mainboards show up with a RTL8126A
> 5Gbps MAC/PHY. This adds support for the integrated PHY, which is also
> available stand-alone. From a PHY driver perspective it's treated the
> same as the 2.5Gbps PHY's, we just have to support the new PHY ID.
>
> Reported-by: Joe Salmeri <jmscdba@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   drivers/net/phy/realtek.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 894172a3e..132784321 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -1047,6 +1047,16 @@ static struct phy_driver realtek_drvs[] = {
>   		.resume         = rtlgen_resume,
>   		.read_page      = rtl821x_read_page,
>   		.write_page     = rtl821x_write_page,
> +	}, {
> +		PHY_ID_MATCH_EXACT(0x001cc862),
> +		.name           = "RTL8251B 5Gbps PHY",
> +		.get_features   = rtl822x_get_features,
> +		.config_aneg    = rtl822x_config_aneg,
> +		.read_status    = rtl822x_read_status,
> +		.suspend        = genphy_suspend,
> +		.resume         = rtlgen_resume,
> +		.read_page      = rtl821x_read_page,
> +		.write_page     = rtl821x_write_page,
>   	}, {
>   		PHY_ID_MATCH_EXACT(0x001cc961),
>   		.name		= "RTL8366RB Gigabit Ethernet",

Tested-by: Joe Salmeri <jmscdba@gmail.com>


