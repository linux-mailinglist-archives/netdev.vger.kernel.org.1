Return-Path: <netdev+bounces-20985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AFF7620EC
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DEBF2819C9
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701C32593C;
	Tue, 25 Jul 2023 18:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66623BF5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:05:24 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B31FDA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:05:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e6ecb52dso3367592b3a.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 11:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690308322; x=1690913122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3CgSLVd+ZJZDKViTXj5kj6HukYvGzOacB2xw6mmHcM=;
        b=V1janKDTCtoEJMuRDBKb4bK0rLgCDBydI2KJlrsUASSn3OoghO1mOl7fqbQprhWQZZ
         nypUqx6QourAeNau9sNh0O87GrJYPESRKXV0a/aUvIIpXov5RiXC0j8Ron4DuYkXVMft
         gwDyzcjrSs6nK9Jg1VGz/vAK8QcLeMouBOS9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690308322; x=1690913122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3CgSLVd+ZJZDKViTXj5kj6HukYvGzOacB2xw6mmHcM=;
        b=Ed09haDFDb/bKuDnj+F+rtCm5VboUorfSJNYBT2dLpJpp2ZRRojS9f/mG0w/dRBWrG
         pclb0074gSC5WijGKJiGQCrlCOXfYYJLilIjcOg2Y6rhz83Absdkem4WQG7XLHi+gWeK
         YvesYQhvtMJQ1QHZN9nowViynxngLRR4S6O0xdjiw76GEXMinaPXppupbYoUJhaa09n/
         kyBUMacOdcy33nRW/UNKQXQdeeujcWh8q5Y4xBmQgZb6wBv22WHXeoJrcdrnAd2hBTM4
         T5JWdH69g5rtx3LfxtQvPiTeJ6+9r7hSGfqXH4lO5kpgS5GsdqMk2i0tpzXJD6um1WAQ
         bOkw==
X-Gm-Message-State: ABy/qLZT0LnqjELYsAhvLJx9Ks1/D6nxB9Emhxx2MhvZTxwlL6zy1np9
	EThx5fMiAr8P48V/URWaIxhoFA==
X-Google-Smtp-Source: APBJJlGvAuwT7k+zZsz3aTxOIAebyGVrDMgqWiqCkTi96U8qv/Bp0HFGepay6fLgvRxh3A+XiJWKYQ==
X-Received: by 2002:a17:902:a607:b0:1b9:ea60:cd91 with SMTP id u7-20020a170902a60700b001b9ea60cd91mr25793plq.7.1690308322503;
        Tue, 25 Jul 2023 11:05:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001bb9883714dsm5612090plx.143.2023.07.25.11.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 11:05:22 -0700 (PDT)
Date: Tue, 25 Jul 2023 11:05:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net 0/2] net: Fix error/warning by
 -fstrict-flex-arrays=3.
Message-ID: <202307251104.74C96AF830@keescook>
References: <20230724213425.22920-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724213425.22920-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 02:34:23PM -0700, Kuniyuki Iwashima wrote:
> df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") started applying
> strict rules for standard string functions (strlen(), memcpy(), etc.) if
> CONFIG_FORTIFY_SOURCE=y.
> 
> This series fixes two false positives caught by syzkaller.
> 
> 
> Changes:
>   v3:
>     * Drop Reviewed-by
>     * Patch 1: Use strnlen()
>     * Patch 2: Add a new flex array member
> 
>   v2: https://lore.kernel.org/netdev/20230720004410.87588-1-kuniyu@amazon.com/
>     * Patch 2: Fix offset calc.
> 
>   v1: https://lore.kernel.org/netdev/20230719185322.44255-1-kuniyu@amazon.com/
> 
> 
> Kuniyuki Iwashima (2):
>   af_unix: Fix fortify_panic() in unix_bind_bsd().
>   af_packet: Fix warning of fortified memcpy() in packet_getname().
> 
>  include/uapi/linux/if_packet.h | 6 +++++-
>  net/packet/af_packet.c         | 2 +-
>  net/unix/af_unix.c             | 6 ++----
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> -- 
> 2.30.2
> 

Thanks for updating and testing!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

