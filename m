Return-Path: <netdev+bounces-55373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5506C80AAAC
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DBE281959
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7339861;
	Fri,  8 Dec 2023 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjVfEERi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7934310CA
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 09:23:53 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0bcc0c313so17534125ad.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 09:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702056233; x=1702661033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfBRrQiDkLBq4kbSWxx91dS9hun2XcIUpOw4uVoRhJU=;
        b=bjVfEERimN0gSZtQLetYbKdUOJykosXkQPNL+eoZeNSL9d0ZwIVoOMJPSWH5SRPuDz
         iSEEcn802Dqb0TzwNCcOVkE2pjAy5pujXmgfRRA96KSSETfRdA9Ss/3Hrz0bGPsCqkXi
         FcBqLB5j4QvlAIgKbsiIXvzhKFn4hpcwUU96g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702056233; x=1702661033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfBRrQiDkLBq4kbSWxx91dS9hun2XcIUpOw4uVoRhJU=;
        b=WlxxKXSbkFcUf80zAePGRqO49Yb2zfVIqlh6nPr5UNi/gz+cBVy6U+mM9G9Rf/68A8
         aXHPmTJ8vC95IxdDxKy8PQW/7SKUeH4IsWMdAA07dGgb3QHcPd32/rCDQ1408YUZ+f5g
         yg01yM3fqaMEUt1xD9xonwM+xI2qrO1YD2VRCxOqG8BCexeeeru4lEw3+Rd7e9S6+gLp
         +zTLQ244EdIQgfW+VCIVDkPtjMJ4e1fgJ7UWN3o5WBMyrW79AuBKgCuGywptU/SG1cGc
         Jdhv9KTf2BjCleWoizMI4+47bbwJS70GJ1Na8Cw0JFq5GnTBuqBtTcBINPtTEWOFEiVE
         2g0w==
X-Gm-Message-State: AOJu0YxRWNA1Jg/+ufnlbA2/yN80DWfKSZTevEe4mgveCYGvpxhnLG7z
	3/akDMxLnlP+blH+36vzD8XQIw==
X-Google-Smtp-Source: AGHT+IE8qHxrXclJCxSH/90CYFEd1XJpiKFOZCPJsqVWaeyT4CeJLS6LsiCrvRpWVTVUVOL23Yqu1g==
X-Received: by 2002:a17:902:ab01:b0:1d0:c738:73b5 with SMTP id ik1-20020a170902ab0100b001d0c73873b5mr325670plb.0.1702056232945;
        Fri, 08 Dec 2023 09:23:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001d053ec1992sm1961580pld.83.2023.12.08.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:23:52 -0800 (PST)
Date: Fri, 8 Dec 2023 09:23:51 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: mdio_bus: replace deprecated strncpy with strscpy
Message-ID: <202312080923.7F537BE03D@keescook>
References: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-strncpy-drivers-net-phy-mdio_bus-c-v2-1-fbe941fff345@google.com>

On Thu, Dec 07, 2023 at 09:57:50PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect mdiodev->modalias to be NUL-terminated based on its usage with
> strcmp():
> |       return strcmp(mdiodev->modalias, drv->name) == 0;
> 
> Moreover, mdiodev->modalias is already zero-allocated:
> |       mdiodev = kzalloc(sizeof(*mdiodev), GFP_KERNEL);
> ... which means the NUL-padding strncpy provides is not necessary.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, the subject is distinct now. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

