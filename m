Return-Path: <netdev+bounces-38437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCAC7BAEF0
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 00:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id DC569B2099B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4841756;
	Thu,  5 Oct 2023 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuROY2lN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE58E154AB
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 22:46:12 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE6BCE
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:46:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3af65455e7fso1061241b6e.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696545969; x=1697150769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePyskiEJCEOltRf//00HdVQ4cJ67D/wO+W+PB1Wu8iw=;
        b=iuROY2lNaoGjIIE9uohhCqFE4Q/gSKmQAQnrfz2eaypGCLHwS6nnLVL46Qily4BlHV
         CddSMA+7bcZY5bNhiBO+tmSUpHOWNQAsp9HuqcOr7d2dyQ6jrXa/tGKUZA5ue7FtXGQ0
         fqSokBtGSpL3/tcooiE5689m5uIwx+1w3XmTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696545969; x=1697150769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePyskiEJCEOltRf//00HdVQ4cJ67D/wO+W+PB1Wu8iw=;
        b=ucGIdHpc9hUt1kgNjYZqXJusJ16qPN3M66h9azgTO0fgmdMH5LqFDg7onfmhjnJYaS
         FgYTiEKO/kObYpnEvI1FFsefEMOK6QGXlRnZk5s9ltdmmrK2q2sMJusV/lcyvohbICiB
         1YQSfLM8EYS5+Um81qTgoaY8+mfsf7jasu8/dbJYHChod4w06XUIidJliPEqrF0B6tpb
         PM8m9nmZPgozE4JEMtw3X0E3zGiR1ff95Hleb1O4R5UDbOqFJaEoxDZNUcJr9RlfCLHP
         uGFhQyqCL2uXQLDJti1bs6AUa9dFUDHKSy6JpE6y0a22Z7HPFmbSrw/lwWKa6uJGgykY
         DIRw==
X-Gm-Message-State: AOJu0YxYBhr57d+gx1ndkVsy17H1zo0tqzWFSli7WVQtLZ4JpIhPB/eM
	MDNtaMmVAHlwMHMwKtou4e6qgw==
X-Google-Smtp-Source: AGHT+IGaIDqu6BSYW2le6DfTb8YAwAbC27p7HsJYK0cA5SoI/rfP7fY4ed258/zRZ4xNHEbx5qw3Bg==
X-Received: by 2002:a05:6808:110:b0:3ae:87c8:437e with SMTP id b16-20020a056808011000b003ae87c8437emr6462389oie.41.1696545969449;
        Thu, 05 Oct 2023 15:46:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p19-20020a639513000000b00585391d0aafsm1984306pgd.6.2023.10.05.15.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:46:08 -0700 (PDT)
Date: Thu, 5 Oct 2023 15:46:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcm63xx_enet: replace deprecated strncpy with strscpy
Message-ID: <202310051544.822967F55@keescook>
References: <20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-v1-1-6823b3c3c443@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-broadcom-bcm63xx_enet-c-v1-1-6823b3c3c443@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 08:51:40PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is strscpy() [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> bcm_enet_get_drvinfo() already uses strscpy(), let's match it's
> implementation:
> |       static void bcm_enet_get_drvinfo(struct net_device *netdev,
> |       				 struct ethtool_drvinfo *drvinfo)
> |       {
> |       	strscpy(drvinfo->driver, bcm_enet_driver_name, sizeof(drvinfo->driver));
> |       	strscpy(drvinfo->bus_info, "bcm63xx", sizeof(drvinfo->bus_info));
> |       }
> 
> Note that now bcm_enet_get_drvinfo() and bcm_enetsw_get_drvinfo() do the
> exact same thing.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good. Other writers to drvinfo, as you saw, do the same strscpy,
so this looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

