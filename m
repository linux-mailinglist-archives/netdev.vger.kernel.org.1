Return-Path: <netdev+bounces-39762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885697C45BF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F201C20CF8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611AB3D98D;
	Tue, 10 Oct 2023 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MNV0Y+cv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F63D3BF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:58:19 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD8694
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:58:17 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c4cbab83aaso4133369a34.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696982296; x=1697587096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOb3GWppFGUQUo6fDVKv/7BVVJ3kmc+fs0b3MYzsoHo=;
        b=MNV0Y+cvtkfIb8P5OLrIntPSq+CZzdI+ENcqpvT5vQRX5QnU7q7e0QZ30G6hjAZJVZ
         IkSsLh3zl77N+MiaBPRB3MPo9L28AR9Dm1Vs3MoWFIdPKwKdqVzVx/8Ar+BUxYin3cj4
         nVQx1vfzYowHReeA48KQXXqRm7yrNaRzGdi2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982296; x=1697587096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOb3GWppFGUQUo6fDVKv/7BVVJ3kmc+fs0b3MYzsoHo=;
        b=SwCUNDU/k1fZDr/DfOYGmdwcoobK0Vdhct3fuzOrwTX1m8eR6kIy611hAWDyNaW+Je
         2dkRkamURHuPvVDnl0eDL0+el3IDP7G5121OEV1oXBt5yMud+1TwMUOqPkKZ7hNLmLTV
         wb0GIk4SwmwkCQJ8iQK+tBbOXcIJdM6cQKaWzGX1HQZy75XjtHPxUpKPy0Ec0ZwZ26Y+
         y5qIYWpf8pigyTvzTwGxsZ8qn/KALTGAL1KUx1CTEuKUdf6IlPswMZMnWJWsvw+aCVMN
         GHMbIJaaKZsM1lAqAN3JS23r04fbLd7cBZaeWQNQc/GkwbJmSPm/gZpQfIT9IcUzHdQT
         fIGQ==
X-Gm-Message-State: AOJu0YyAu8q0jpDEPGvR3VGndO5hvbuI7ZspcVM7wZYfkfD2tc0VIyMe
	btUXODndV3dDS2fZJ2Zn7iXalg==
X-Google-Smtp-Source: AGHT+IFpqAZvTTfdymMa3R5nbAmknFwysoqVA/dwXwkjpL1QCgv8PmS1IKni1deEEaUquQKaMJYecw==
X-Received: by 2002:a05:6830:1da7:b0:6b9:4d79:e08a with SMTP id z7-20020a0568301da700b006b94d79e08amr19908023oti.32.1696982296583;
        Tue, 10 Oct 2023 16:58:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b00565e96d9874sm9441495pgf.89.2023.10.10.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 16:58:16 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:58:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310101658.84E1C724@keescook>
References: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 10:32:35PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> This change could result in misaligned strings when if(cnt) fails. To
> combat this, use ternary to place empty string in buffer and properly
> increment pointer to next string slot.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Nice; much more readable.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

