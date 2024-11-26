Return-Path: <netdev+bounces-147507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE4A9D9E60
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A22B24E75
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E21DE880;
	Tue, 26 Nov 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZXYOEPP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650A1DDC2E
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652433; cv=none; b=T+aYATPeelk7G6+gefRKf6Cv5TVuwX74mIYTzGeqrozw5rzR5pl/CPU4UKMT/SYKmDFcZFkvqOD7X1WzD4PeYnuffGhhvqlMkqjRcrmAMZwN62mEj6e/ZdNB+4iebcfV9FJLSJNaLvkUXYFPIliZXWpIt1dRnQbMg/qVU+yzVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652433; c=relaxed/simple;
	bh=hE36GHZAn9bcZ2gX4F+8xhFEnFhrZcCdir62CFrw1Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FABucqvvm8KCTgcUhLhALoNPaK6I2rwJJU4I579inXIPZdQQmNrIAdOlGkXdmsU5oPFM8zWFGSw5mrmBg/QNlvII1k+S6/eWFrWyOmv/Cx/KfBPKX79rXxFo9RM+7dPrPvu2aG31lIPz3H68owbexYQ74H0wHeytu+oa03Jud4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZXYOEPP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa530a94c0eso561601866b.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732652430; x=1733257230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EDIpeb3JMBwFv1oZ+7PJFJMHR0Hd5nE3HVJPYq0ihls=;
        b=FZXYOEPP5C+M6xkG65lF8+AIDiYC+frPwFI30VvI36U/jZFY65fLP6ffLHZ8JQR32u
         YoSSoJsdSW+ll62gih+iNk8daUmJDDfZpDXvjRrYIUFrTgFSbK27iBA3Gi7NKZpO8/qn
         HJWcpzPcfncqkb6W2reM3phqunAdbFl5xKk432+1wz+VqekJdHo8odTLuPlit6wOnsgy
         D8sbsiDq2wimVj2ZCad8pThc/OqRpessdPjwKkWtoiEUZfpRV0REykX323tjLBclyj2Q
         51iOdxP80gJqsDTiI3QelJ5elKuH0k1Ram9F+2ktT/xfanp8ZQgy6cb6ke9vVdBIvr1S
         hAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732652430; x=1733257230;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDIpeb3JMBwFv1oZ+7PJFJMHR0Hd5nE3HVJPYq0ihls=;
        b=r6/T1HZvQYSQTC3p6sDOl+RxYG9WCXjXOJKwW6XS71aqb9QHE+iXnBk6gxMKIa1u3u
         1vGz7+00xfuLPBLKr4d1jdXacUTpOka+XuIdRrxwIfxv9oApmT3ox20NuSbTn8jNdsaC
         yJi9h/cuep2HpH3YxnNGoCueK0kIaLG4q/zX+ZSkCsrJGAaxG0On0vGYdXvRTWXP8NXp
         IksFTZKQn6rkAvg3Cie5OQOEVIZ7/utlAJS0Dks+8WcXJbPa8qF1HJKzTKi5/2zMfnuE
         lo4DcZI5Gb8So0bUYvEZdCwkvhLZcy4ya24VjvtZe6xcUHJ1m767b+ljKBXFiT5PQQv6
         TaSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqb62FBZs5gyRRUBvvAWJj8mV/fu80No7R/hv11wm2WmMkabHGZHf6T1LzU3i822O9MBE/k2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB8MKfOAnEXYq6bCe6moPUdaS4qrlEWMpnToh9uDUO5LWz4PyO
	Km5sXoUr8K+ilLfm4XCKrWR/haUgh/UeAGbxMhXDK5Obl8kKENtu
X-Gm-Gg: ASbGnctsi1kiPKxIwYLp/4ux62PkxL0StUukaBibfUgwRU8k1EdSnBrAWk0+wb01l5M
	zmm9nL3kXBK8oYoOM15Uodtp8HAvQbx5WE9U2kMmTMHFTwqw4EalwWcaeT94yTd1PHBdgNDk5oK
	Etwig6LGamQPo8Fdde9kVyoJJxhQHH38+bxVYWeTDwcdzJYRTWNzVV0/Xz8WsSGLE2g+qkTRiuD
	GkscNKtUcWid5K3d8114hvE7jTVyTEF/J5pZi06IgdoNqucA3Rz/xa0hwycY7ZK+4NtJF6RSltL
	tOUtVDbIeu/eBzodqH4obl2ry5uScYIjmTDRB/tU4WrRBv3idoq+5cPCev+oDUM9jMikL3x4D9Y
	sH2wzeAEyprg/dQvx7vjxojmt//+KSEaIVFkXDlpjZQ==
X-Google-Smtp-Source: AGHT+IEQ+GUY00gDNSfoYzGgyx8asHOxAIhNjERgZcKduGGgVFJK+5xW0EhYGKlEcMvQnyyoY63gFg==
X-Received: by 2002:a17:906:328f:b0:aa5:4b7f:e705 with SMTP id a640c23a62f3a-aa580eee492mr24716366b.1.1732652430538;
        Tue, 26 Nov 2024 12:20:30 -0800 (PST)
Received: from ?IPV6:2a02:3100:b1b1:7000:f43f:954d:8ddd:f91b? (dynamic-2a02-3100-b1b1-7000-f43f-954d-8ddd-f91b.310.pool.telefonica.de. [2a02:3100:b1b1:7000:f43f:954d:8ddd:f91b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa51a449c24sm590832966b.178.2024.11.26.12.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:20:29 -0800 (PST)
Message-ID: <14b3a67f-416a-479c-bd28-887ea06cd435@gmail.com>
Date: Tue, 26 Nov 2024 21:20:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 04/23] net: phy: avoid
 genphy_c45_ethtool_get_eee() setting eee_enabled
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <E1tFv3P-005yhf-Ho@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <E1tFv3P-005yhf-Ho@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.11.2024 13:52, Russell King (Oracle) wrote:
> genphy_c45_ethtool_get_eee() is only called from phy_ethtool_get_eee(),
> which then calls eeecfg_to_eee(). eeecfg_to_eee() will overwrite
> keee.eee_enabled, so there's no point setting keee.eee_enabled in
> genphy_c45_ethtool_get_eee(). Remove this assignment.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


