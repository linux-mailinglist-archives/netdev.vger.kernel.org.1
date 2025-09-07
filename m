Return-Path: <netdev+bounces-220680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AFB47C29
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209A63B9F36
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CDF27EFFA;
	Sun,  7 Sep 2025 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8zptFWD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6A189F20;
	Sun,  7 Sep 2025 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757261190; cv=none; b=VU1p9b4NzoYLwMZW5OXQxUCBre4Kb5NLLDLlYVhZUqn6mrg58rtbBSpN0LaWXtVNQdzbVyYpPQd9ITqRCfxOOsqmzFHLxxoLStQkUcYCIQW7LonE48SxqFLb4la4DG8zV0W/il0kUEMQvNXpbSstVGlitBKRJGWZvTAQQHf517g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757261190; c=relaxed/simple;
	bh=Tn4SfrPNvGkARcS/vX/j5g6Pe0o1s1eQKk14XZgX0Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJMj1lUqaRTVPxL4O/Auwqvha7Asl1D6wLrnmLT47MCZao2FhR3OG4FGDeyN2fLXILWLAjFUEC0wF2jsl8LyjX/LBqou5ELsjugOHUNEpR2SUe+q2pRcMrnqabuU48mzlx0ZZsdTMX28nHc6vDVSoaiqKnADIoRPEWvi0RJZ1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8zptFWD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-251ace3e7caso13445495ad.2;
        Sun, 07 Sep 2025 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757261187; x=1757865987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cF6ydpI/LQamKkw+0q8FTGzAStuV08pvQoQCdR+Hn5Q=;
        b=C8zptFWDV/Zs7j/g722W9I1ZA0PQLSX0nadaNkvPfqMq0Y6yLfOfwLxr31leJ7CXSC
         Ma6kJF/rw16q88ZmpXHrMNJxRZn3pzjSj6xk7hYGYfm2y4DYnWac6MTapAmpc4YwnHoK
         0Dg0RKeDMmiea5VIlUmNFtOTPBcgm0cLM++/KcPjxo0y5EKzlc23G/JsbWwqcrPy7u8C
         A0jMUwgTIznA6AeLQpTzR6lmM0vdPRvUnpwFj29MzsYIfpkp0GjZWW54vBg5LUSAxd63
         i6nHVwO7fca/pyVucWAEj3MljPmPwFHck2fLkXTUY1y4eyR5DO5YZF4PawxUmpHK5aqs
         C0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757261187; x=1757865987;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF6ydpI/LQamKkw+0q8FTGzAStuV08pvQoQCdR+Hn5Q=;
        b=ar/6s0xxowz3wWU1Y7C7wGcdnjMFBwkrH5KHgGn5vnXCRjyAsNZUEb0fQFvQ+k+STs
         9K5p8zwwg6BFpIrIh1cf+K18wAwf0RNje26qznLLRKrKUkJ1ShitSVYvaonRGqqsuo3N
         FscdEe1FdB0jcu1Urlw0qEk8fcu3efwZ7aVC5/PD6U3jAMQxrvPA6fO9SykVGdr+ZFoE
         mUdaGzHw+pBgMQeT77LuEEW8iCFdIGj8bL0p3X6t6Xlyvet0wfQWhB+Fvr05ui3VEvGb
         3AEibA9qPrwQV56pRamZuAf1Ej9YhOpYDwTG5aRPESZeEIkcaIpt/e+TdtIAlg7TFQL9
         BFSA==
X-Forwarded-Encrypted: i=1; AJvYcCUOz9QRhPF32oOonrg/WKrmTH1HAhNtp/OfWZ34/SF3mJq7r7iziq+8y1oguTgZboGwmHC6yqWX@vger.kernel.org, AJvYcCWZjxRRD4pjfyaEmv04L1YFEptFQnz1o2OYD1HkJ6ExIU8trarXpE+jZuFc2UiYR6cCS8vZK5AAjrJh@vger.kernel.org, AJvYcCWz5ys31tw0UL9PB7GvDgAi1B/VZUVpMHYF7ea5kUd8gmOwT7aLqRd6I0LpNgvGmxK4/sqykSTzZk83@vger.kernel.org, AJvYcCXXIdezbwZWSrOKF60dGydkmGbCeE1nLKZ5boyL8T+VfKZ2ECytAihD0hLIXktVPXIGh+nEwzEJ/HgkSUL7@vger.kernel.org
X-Gm-Message-State: AOJu0YxdX20lhuxUiju9cHMKUP7jsRF4zMnYjAIr6+9H26h5s0RMNRCk
	JPdJgW1RjpnKzFJdd3Wk6eLTJZdHw7OENln7fAtD/FO3bIEzSxF7CMhf
X-Gm-Gg: ASbGncvPlfPN6ha8sjcCX3PbIOPMcklZgcB3NM1hqF3ex0UR8DGLjlUj3yx2WHaJwgz
	2kbMOqjePossaD8rPa1La9Ljbl9/9bBmlILNBIaS2HuZIy3IJzP0vFMsbgN7kaEqQ/QxOqjgrQw
	udpH9esuv7uwT3DizNPjhLj//s5eb5umrAHzCqgv+bVeiVRM36EIYJBHIUotv8aygcvOZQr2wsy
	0YNE2C7K0WnyVD/puDXFnLWgOlctn2SaZSuWcJEUngn4l8H+InJyfOHgq0ExuanucpCUOenISmV
	BekMf4Usq/sJ8LL7A1a/IKDtRGzLEOxw8blnbS8yw+1qC0S6Mscm/9Lsx/h/igmdX3aiiWvr7b0
	aWTFCY8glMcK/mCAdDvTVgUcjWcyu0Cdy670GwfmpbhDQ/I5R/AAcnJ5C9Q5bjwQYZ6kRCo9zSj
	diUzz91g==
X-Google-Smtp-Source: AGHT+IHjsbItSLGLTbk4bctSoCf2cP3gRfY6Crj1D3TnpuBrHwZZEdKgevr0cSKXCqjST0G8MrJAKg==
X-Received: by 2002:a17:902:d588:b0:24c:d322:d587 with SMTP id d9443c01a7336-2516f050176mr69598395ad.26.1757261187190;
        Sun, 07 Sep 2025 09:06:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd655823sm88157995ad.114.2025.09.07.09.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 09:06:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e7a2570-41ec-4179-96b2-f8550181afd9@roeck-us.net>
Date: Sun, 7 Sep 2025 09:06:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
To: gfuchedgi@gmail.com, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Network Development <netdev@vger.kernel.org>
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Cc: pse-pd maintainers and netdev mailing list

On 9/4/25 10:33, Gregory Fuchedgi via B4 Relay wrote:
> This patch series introduces per-port device tree configuration with poe
> class restrictions. Also adds optional reset/shutdown gpios.
> 
> Tested with hw poe tester:
>   - Auto mode tested with no per-port DT settings as well as explicit port
>     DT ti,class=4. Tested that no IRQ is required in this case.
>   - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ required.
>   - Tested current cut-offs in Semi-Auto mode.
>   - On/off by default setting tested for both Auto and Semi-Auto modes.
>   - Tested fully disabling the ports in DT.
>   - Tested with both reset and ti,ports-shutdown gpios defined, as well as
>     with reset only, as well as with neither reset nor shutdown.
> 
> Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>

This entire series makes me more and more unhappy. It is not the responsibility
of the hardware monitoring subsystem to control power. The hardware monitoring
subsystem is for monitoring, not for control.

Please consider adding a driver for this chip to the pse-pd subsystem
(drivers/net/pse-pd). As it turns out, that subsystem already supports
tps23881. This is a similar chip which even has a similar register set.

This driver could then be modified to be an auxiliary driver of that driver.
Alternatively, we could drop this driver entirely since the pse-pd subsystem
registers the chips it supports as regulator which has its own means to handle
telemetry.

Thanks,
Guenter


