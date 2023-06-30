Return-Path: <netdev+bounces-14702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE10743338
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 05:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D10280F0D
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 03:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EF0187E;
	Fri, 30 Jun 2023 03:33:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFD17F5
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 03:33:03 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942782D5B
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:33:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b816d30140so2745145ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 20:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688095982; x=1690687982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XBHvQH3uIxxLS8CwCiNAKUehD17JfQCMoxGtmhztUI=;
        b=DjiI7a7Z4SMhThUzxj4J8G/r4g1noxCpcWXdJWVB4NChhRaqJB90q5HrWL4sxhHQ/n
         ay23CgSzaTmcdeZBGHOTQZ8YFdAWnqSPO0BwLaG0S7D7eOp2/bA1sRPW4nvCr6VYnFnl
         QAy6ieOQuk3nfS0QOZg+SvW12OGVEl9VB9Awf7SfyVqecid6mfLUnGPhQQLLeEbJ+3XR
         WCjVS7QV/DyoAjXQA1/IvL1ghHFSgOQLjURH7XEgb4clFvuK/MormuQcGpM8ZRgs7URo
         k61+eLggmyk3Ir3wqa/2g4rLsZvkK9eAGeugc9bLFqdefFyTYNO/hScENjbAC7XKXMzv
         RHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095982; x=1690687982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XBHvQH3uIxxLS8CwCiNAKUehD17JfQCMoxGtmhztUI=;
        b=i56opsMUpr7F7OxHKdUiBXoX6j36jW8iBWcmiiTMDJ/MdYL/OKmdYbhqUPE2V2qvHm
         KDPsDp67FyntEddMHL7AMfXU7lIxrqweQuy8htCbGUFsBjf3pylopBZpBSee941shILr
         8fo+8h9SiUnY+WG6f6lOyzvV5K4hT0JVgB+cgKRpsJXHyNH4VsEZoiPeGGmzH8Wc7TzP
         HrrhgUMG+yCR7V8I5fXNGj4yimfqw58NnxaFPAQcbjbitz7oWsPUgH2wN3q12gnxjgLV
         8cuIgEhiG7+IgF3o8NBmJKqp+d1mj4bMrJrAzP4v0P8vRcKSlHMkM5BAu91c/hRYJE0p
         67kA==
X-Gm-Message-State: ABy/qLaxcN5eqiomaPXfbzxxzOkMITMnTQy1DvsN72hNgR9YafPfFxAS
	IuBulesqqUORiADd14YwHgA=
X-Google-Smtp-Source: APBJJlGnYbpWF/mVBqUVpFhoz3G0FuzKKS2ZRpro5B95NAOqOAgBcYD/fjnE/xfJ5h07hwIm1pPmzw==
X-Received: by 2002:a17:902:e74b:b0:1af:a349:3f31 with SMTP id p11-20020a170902e74b00b001afa3493f31mr1158367plf.3.1688095981881;
        Thu, 29 Jun 2023 20:33:01 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b001b3eed9cf24sm9777459plb.54.2023.06.29.20.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 20:33:01 -0700 (PDT)
Date: Thu, 29 Jun 2023 20:32:58 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
	Nathan Chancellor <nathan@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH net v1] ptp: Make max_phase_adjustment sysfs device
 attribute invisible when not supported
Message-ID: <ZJ5M6rGjZuimL06F@hoboy.vegasvil.org>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 04:21:39PM -0700, Rahul Rameshbabu wrote:
> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.
> 
> Fixes: c3b60ab7a4df ("ptp: Add .getmaxphase callback to ptp_clock_info")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/netdev/20230627162146.GA114473@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com/

Acked-by: Richard Cochran <richardcochran@gmail.com>

