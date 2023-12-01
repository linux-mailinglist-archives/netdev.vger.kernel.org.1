Return-Path: <netdev+bounces-52992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FA68010B1
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E673281A60
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA704D12E;
	Fri,  1 Dec 2023 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyF4sQnf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F69F3;
	Fri,  1 Dec 2023 09:03:21 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cdcef787ffso2353840b3a.0;
        Fri, 01 Dec 2023 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701450201; x=1702055001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNWn1kdO8blUyQYsaUuU441May+eNH4MGJiwzkp6ycg=;
        b=XyF4sQnf27IlxfPHxB7EfEGGAhlGQBachWONmEClvqy2PRde1vZrM07J5OmNXVNpcx
         8aDXs5l6+iwNm3cmGAumNrKPCCUR5MMlpxj9mfpvzgZn0AuBW+Qn+i0KB8iLHg4ppOup
         +4xgsRQPYLYt8zdErxY6iDGdAPkZhev7Sts3dcRKhDaCgTeToVIOlZ9/Z3JFNZj04FFi
         tNtO3frJh0z054nc1LpLoZjn+UeNtN1tL7VfRiYMO3QzwK8XYQV4SuyHbp5Fy8let2lU
         eWCDjMTSfttEVW8uJZw8ZCjIAgGPQUO6DHlMWeK5W+J2jHp/dZnzs9yc6Ri4S1L0uDCW
         hf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450201; x=1702055001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNWn1kdO8blUyQYsaUuU441May+eNH4MGJiwzkp6ycg=;
        b=RCJgaNIhNYx/I13ksGwwW8xHbSNx7NfaAyDCLgVPxLuXEvf0CsvH3wZulKR0RYPN5f
         PHHJoIovZ7hoJm7YF3ah6YC6hnTBkQchJM+DS2Tws2ghkCViWC+WTCrufeJu3KXjP9/Y
         QYMf7LpTbWliG3nBmdLfHRYP2Vk+IYI/Nkp8wYtTfF7mlYu1A/rI4VSI0ZQ8Y7KQdHtE
         qns6nLDkMPBXnXYiaMliMi5+v00pIF2he7+JFbYNtB3s5iUH7MnP4cBX0BWck6HN4q+G
         7mB8u4HKwo73Kw/WbnLL5cdMgogZ+vHpXRmOcyalPyNcPeXrnnkOGy7y3yqnboIk9LXI
         XG0A==
X-Gm-Message-State: AOJu0YyKGhiUGbZsFJrtUHpysFwzgbYdZ69xUIAQyIOIeq3ivo8Y3Ay0
	puc/1ewrhtK3IFLO7hrODLw=
X-Google-Smtp-Source: AGHT+IGOFtaHoKo25pNZCUcukn0B+nCZPW8yNEXEsoJiDnOrjXmO7oZXnTTp8W69Zu32Vsx754Q6aQ==
X-Received: by 2002:a05:6a00:2e1c:b0:6c6:b5ae:15a4 with SMTP id fc28-20020a056a002e1c00b006c6b5ae15a4mr34841765pfb.20.1701450200769;
        Fri, 01 Dec 2023 09:03:20 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r14-20020aa79ece000000b006c9c0705b5csm3232908pfq.48.2023.12.01.09.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 09:03:20 -0800 (PST)
Message-ID: <36c32191-8cde-4a95-baf4-311b663fe275@gmail.com>
Date: Fri, 1 Dec 2023 09:03:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: phy: micrel: use devm_clk_get_optional_enabled
 for the rmii-ref clock
Content-Language: en-US
To: Heiko Stuebner <heiko@sntech.de>, andrew@lunn.ch, hkallweit1@gmail.com
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20231201150131.326766-1-heiko@sntech.de>
 <20231201150131.326766-2-heiko@sntech.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231201150131.326766-2-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 07:01, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> While the external clock input will most likely be enabled, it's not
> guaranteed and clk_get_rate in some suppliers will even just return
> valid results when the clock is running.
> 
> So use devm_clk_get_optional_enabled to retrieve and enable the clock
> in one go.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


