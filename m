Return-Path: <netdev+bounces-53049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F7780128D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D911BB20FCE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C34F5ED;
	Fri,  1 Dec 2023 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fl8/1gzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB3106
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:22:36 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cdfb721824so1058836b3a.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701454956; x=1702059756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mglnl7bfM6Y0YVkLlQ4iNPVutgU9A9KDI02bPJDXRE=;
        b=fl8/1gziK0fEyA+8IuBwnqNWzCEJqbEr81UIF8tzxxkmRxy26V/p47qn9zHKQv04P/
         6C3k1MdmxZYJmIQ15z9Cd7uNPWtDaH6y1RLxw8iVSko5K6MnZ6hjlW9bRhN/cw9Tkl9v
         2ovvpgxUlOBE3LzpN555PXVzNU3uIptEeulIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454956; x=1702059756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mglnl7bfM6Y0YVkLlQ4iNPVutgU9A9KDI02bPJDXRE=;
        b=iPMTgRTh4s8rb9VXlthpsSL8RxY9h9Rbk8x7cB1q+YeRvnAKXLeNgzHafebUwo4tSH
         153QWcxztlS6uZGli1RjnxhtL/9aebfYZgRe27Z53T2Dd8IK6/qI6EKduOpUX266sBIZ
         U7bfiCxMuEipjH1Ba8X89EoZ+7e3ZyUV09YluhepYqqtOTbxrwmqStLtlfUAZ1B6fhFq
         waOTsR1tPD9HgLjeeq0ifm2a2vNlAQ13jBLM936ojOJAyrR4Mu8tiPHRVlz/K/xQky6j
         LMh4nEqQp+RjvMJmmMYy3RORvLl/ER1DNboRMKdfsSedm84DKypgYULvw1cIEIsXmJZI
         n+oA==
X-Gm-Message-State: AOJu0YwTZGz0HEY7QIzkoYT4DO5pFd0FIIHaFLV8RGVYeTLtaK28lpRO
	uFRzC9Trw13hcE8HGGcCvlu47w==
X-Google-Smtp-Source: AGHT+IGWAHYOF/izXvc1zLVxRIH/rhrsb5iI71mf7AC+4lN/W9r1fOGKIihcP48w13Ut6cfw0D8Qfw==
X-Received: by 2002:aa7:88cb:0:b0:6ce:a8b:15c6 with SMTP id k11-20020aa788cb000000b006ce0a8b15c6mr1809797pff.16.1701454956020;
        Fri, 01 Dec 2023 10:22:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7938e000000b006be047268d5sm3413788pfe.174.2023.12.01.10.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:22:35 -0800 (PST)
Date: Fri, 1 Dec 2023 10:22:35 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <202312011021.FDB24FD0@keescook>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
 <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
 <20231130224334.1c1f08c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130224334.1c1f08c9@kernel.org>

On Thu, Nov 30, 2023 at 10:43:34PM -0800, Jakub Kicinski wrote:
> On Thu, 30 Nov 2023 14:00:33 -0800 Kees Cook wrote:
> > Applied to for-next/hardening, thanks!
> > 
> > [1/1] net: mdio: replace deprecated strncpy with strscpy
> >       https://git.kernel.org/kees/c/3247bb945786
> 
> newer version of this was posted...

Hm, I didn't see anything land for this for the other with the same
subject. I've dropped both from my tree now.

Justin, can you chase down the mdio patches?

-- 
Kees Cook

