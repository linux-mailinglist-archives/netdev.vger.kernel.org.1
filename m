Return-Path: <netdev+bounces-39286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87087BEAE4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 21:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3521C20B65
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BC3D38D;
	Mon,  9 Oct 2023 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWElXZGn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314E23CCE1
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 19:52:24 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D103A4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:52:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-692c70bc440so3707785b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881142; x=1697485942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECdanhzOxtDDxERtqv/UtAtSdohUg2Ey1r8KRkz22Os=;
        b=JWElXZGnI5Dho7NxO3SuCZkcyzvidcN5myX62MJIO7GAE7k8B6ISh9zNAImkmqz5nC
         1xTANb9oWsDi347SpprOLccVgJnpARsfMpKAbEuyADH40gX/KAifC3aX73ihxChP2gSn
         jh8qOYfcguBeYOrZ4cABpIKcqGhyCeSWqhDMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881142; x=1697485942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECdanhzOxtDDxERtqv/UtAtSdohUg2Ey1r8KRkz22Os=;
        b=EgCqBc0RH4kECIrsE0dYuOJ0FR67Z5+n0rwmciCCU6aOVTuXpdju58KEayG0Oddo1L
         jL00Ff9IjTa8MUVeqkJn25UvO28HbxHGAVX/56fYtkcUE7ReO35Wt5wQN9fx04GxfFw0
         puA48y+0/ywPcFlr6O0Yao87qoe7VmnU2+4BESZKdVrK+Lup9/fQTTyE0wM3iL8Yk87g
         QZUQoZbKDQi2foAntvGauGKFrxqYhnMJW3mL5XjXP3FOx3kgmORjIyRoVVsGUXcnVa4c
         /05p5vvxpnJ1+lCI+aHaWSoKdQiOeDpWsmU8GMIMuTqCAY1QI14TW7TmJmCDlUPLwAei
         J4jA==
X-Gm-Message-State: AOJu0YwRqXLDszmbygpO/lPKcp/AZ2I53a43o105QLJspEgQgH9EGP+Y
	DOO/cjwf5w7XgyMy0RHftQq4cw==
X-Google-Smtp-Source: AGHT+IGxomcr53n06/4wdgutrpZT4ccy1wmPL5cHdWAhB0pnoeCW+Oz5hR6WVVrKGNtF+Q44ODG3dA==
X-Received: by 2002:a17:90b:24a:b0:27c:e015:1160 with SMTP id fz10-20020a17090b024a00b0027ce0151160mr446092pjb.0.1696881142614;
        Mon, 09 Oct 2023 12:52:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cu18-20020a17090afa9200b0027463889e72sm8693809pjb.55.2023.10.09.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:52:22 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:52:20 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: dsa: qca8k: replace deprecated strncpy with
 ethtool_sprintf
Message-ID: <202310091251.98B21057EF@keescook>
References: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 06:34:45PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks! Yes, a happy ethtool_sprintf(&data, ...) replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

