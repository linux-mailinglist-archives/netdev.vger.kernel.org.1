Return-Path: <netdev+bounces-25642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B14774FAE
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B791C21089
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071187ED;
	Wed,  9 Aug 2023 00:04:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68A7E3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:04:42 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD77A1981
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:04:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3745600a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691539481; x=1692144281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q753MXTz9z1YcPxBtklg+ZM2sNxutssP2J+C7z32EeY=;
        b=O6c22X7L/GLzPl6hJPk8Jro7XqRJmDsV394NNSP7USwH3ELDWmXHweiI2OaNH2dgnJ
         UhLecCM7sf234JhknKgpqlIUC2D/5bJmSo21xVH9NHwRBS/6o5o2R5ehrgVxwLXuUumV
         QV8IhenwEOGj+4uBFV1nZJag2aFk19zt4FyYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691539481; x=1692144281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q753MXTz9z1YcPxBtklg+ZM2sNxutssP2J+C7z32EeY=;
        b=TLFpl1X9UhrTcF7IrQOIhsSSgOP65Yru7hUxZAksAll6TBTMLvauNvk6B6nN0Exc9Y
         9x78iJpsU/cO2ZfG907sy12gE7xOjY+S8vux9ETTqpPkuzH1JITHcOezj2gpG2HmguId
         t4Eij3NZAJStMPI+0CLvL+qXDF8aPGLUF3fkoVaeSN80kpzTJjb3AQXZRAXJNGdK11TE
         c6UF28ySQrraC9R6ArTYCvbL5OBhJY/bu5Vywpy5MoOtitvBFSxeMc5JzyHVyRUQ/Coz
         AAab5YGAIHrYFsvFFzWLXI2MDemtrArij3LN8T7KpNVljHkhjFrpdRlaIGNtft2uSRwN
         oWIg==
X-Gm-Message-State: AOJu0YzqGmXvWJfaVyMXYktt41XpQ5PMqFqwHobUMGJMGivG68QSaCTD
	6dM0vMp2ZHYSw0UIRmW+ErKlJQ==
X-Google-Smtp-Source: AGHT+IE+nVYsSUbToI9ToOHU9cMo6NDjTJ6RPyx/CDUXO/RJo6/8V0QN+CvQIqlQunKKZ/fq2G9gGA==
X-Received: by 2002:a05:6a21:62a:b0:13d:ee19:7725 with SMTP id ll42-20020a056a21062a00b0013dee197725mr898777pzb.12.1691539481236;
        Tue, 08 Aug 2023 17:04:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z1-20020aa785c1000000b00686b649cdd0sm8652697pfn.86.2023.08.08.17.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:04:40 -0700 (PDT)
Date: Tue, 8 Aug 2023 17:04:40 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hardening@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] netfilter: x_tables: refactor deprecated strncpy
Message-ID: <202308081702.2F681E0E@keescook>
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-6-efbbe4ec60af@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808-net-netfilter-v1-6-efbbe4ec60af@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 10:48:11PM +0000, Justin Stitt wrote:
> Prefer `strscpy` to `strncpy` for use on NUL-terminated destination
> buffers.
> 
> This fixes a potential bug due to the fact that both `t->u.user.name`
> and `name` share the same size.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> 
> ---
> Here's an example of what happens when dest and src share same size:
> |  #define MAXLEN 5
> |  char dest[MAXLEN];
> |  const char *src = "hello";
> |  strncpy(dest, src, MAXLEN); // -> should use strscpy()
> |  // dest is now not NUL-terminated
> ---
>  net/netfilter/x_tables.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
> index 470282cf3fae..714a38ec9055 100644
> --- a/net/netfilter/x_tables.c
> +++ b/net/netfilter/x_tables.c
> @@ -768,7 +768,7 @@ void xt_compat_match_from_user(struct xt_entry_match *m, void **dstptr,
>  	m->u.user.match_size = msize;
>  	strscpy(name, match->name, sizeof(name));
>  	module_put(match->me);
> -	strncpy(m->u.user.name, name, sizeof(m->u.user.name));
> +	strscpy(m->u.user.name, name, sizeof(m->u.user.name));

Two hints here are that this is dealing with user-space memory copies, so
NUL-padding is needed (i.e. don't leak memory contents), and immediately
above is a strscpy() already, which means there is likely some reason
strncpy() is needed (i.e.  padding).

-- 
Kees Cook

