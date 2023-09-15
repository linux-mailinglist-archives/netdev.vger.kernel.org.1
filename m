Return-Path: <netdev+bounces-34184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CD7A2774
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5509A1C20A78
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C91B265;
	Fri, 15 Sep 2023 19:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B090F1B261
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 19:53:24 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFD91BC7
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:53:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fc292de9dso1869704b3a.0
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694807602; x=1695412402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CERIXMszobECCcmTb35olIeJedTz3jO0YWogNpKALzc=;
        b=k0XG+2aoqM+iN/MfW6LcKsFc1Iofq/lBwx3qPRLKj8qZ8eedBy5PZVuts7KdPhew/3
         nfPin5P6gPOoLJD3dJKjeumHylWN1FRu+2mfI4nQ3ceYLUrI1W9UiY3+d7DJpxFzgBOz
         mo94Et0y6Kj/mnHO6zc/aMTjM/um9IBEvOK3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807602; x=1695412402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CERIXMszobECCcmTb35olIeJedTz3jO0YWogNpKALzc=;
        b=qAgzoqWZpZ0OuQlLA09pi28J+RCsyKpUXbjbeOVHtHOVhBcJBFrBqItUAP3y4OhUnR
         gErret6jO3gGmqjftPe7Q4OJzkY2CvDfB0TjpKdxr89w1PX/+uxlZMkyz1M6+R05EoSR
         qiIu1qKXPaslo0Y/SNUp3ftpYBfZkSOZonbdgk6wCG2aQdwfvf0tMA5/SKRZon2q05Up
         dYmpCpDGlYr0ekMpPUU0qAJAjq+auI4QXh8wFcpxhOg6fteX39AUZRV4iPhO07D+HuMf
         sKdj+lZHxCTxhcSomYIrLBUmagbZ5kUjBZLdPIi/zXrBVJnoBxNN6r3oIBv9A8wSeLGY
         Yu9w==
X-Gm-Message-State: AOJu0Yxh6a3vjdmQ5L2k5BRhksqJnaWjOGwXIGhR/MH8CBc3YzWPG37q
	emZiEyzMGLFiANgZnZJ3yeIBBQ==
X-Google-Smtp-Source: AGHT+IEPvKFh8vTTzZWluYNsudPUjGFO4rE/xMIMo+tGYyEr5KiifbvSDLT3mH3As6hXoBlLo3SNkA==
X-Received: by 2002:a05:6a00:1a11:b0:68e:2c2a:5172 with SMTP id g17-20020a056a001a1100b0068e2c2a5172mr3314996pfv.6.1694807601720;
        Fri, 15 Sep 2023 12:53:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78551000000b006878cc942f1sm3307731pfn.54.2023.09.15.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:53:21 -0700 (PDT)
Date: Fri, 15 Sep 2023 12:53:20 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
	Geoff Levand <geoff@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: spider_net: Use size_add() in call to
 struct_size()
Message-ID: <202309151253.844C8BFCA3@keescook>
References: <ZQSvsLmJrDsKtLCa@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSvsLmJrDsKtLCa@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 01:25:36PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: 3f1071ec39f7 ("net: spider_net: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

