Return-Path: <netdev+bounces-26557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523E778205
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A61C20D0D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D3D23BCE;
	Thu, 10 Aug 2023 20:18:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7737200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:18:50 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A332728
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:18:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bbc87ded50so9796245ad.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691698729; x=1692303529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kJtbeMd1DC0iwf7dIt5vaIqCFoNN1NxlZ/NfDv5F7k=;
        b=FCF+Wwv3S/8SqhDJAVj3HEgDOxOPixLgcJvqdYQAH1j+YW245ZFcnvNZjGujwYtR0Q
         pn2gvaHu8I+Ng7lyB5MFXtbXBmVybora9cdXqKw8ZPiDnqRcELg9poV0ZQDoytGeUxh/
         NyhU472SfwlDvshlui960Ud23rM35VCRAtME8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698729; x=1692303529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kJtbeMd1DC0iwf7dIt5vaIqCFoNN1NxlZ/NfDv5F7k=;
        b=HnchZaDHtdzG6VTb0G55V+EmjN7bAKl2oeT6iQ7B5lcjuyedIcW5DWjHIgdiC2T7s9
         xQAh6C/7cNr7XLJg5kXHYEoo4KQnlw9Oua7g5pZNaYlvDAfeIPWk1TU1maW4J+Z7Eoia
         cP1aAlX2oo/BbBYnEADPYUeBjo+Yc9zBFSNYtsDepXkF8uMK6o9urf5HrvyAGaHSxLjX
         637FdeCW2S/vrVocog05X/ututjB3JVXNm/isk3n47DKcdBKUUlfAwZJ3uFGtoQ+c+xq
         hSCqVtw1xAGdo2c20v8Jj+Q+uvo3raQ4QFBTXSGjNBMKd1Yx+d8oEZMzoSssvTJ2gAC+
         bdYA==
X-Gm-Message-State: AOJu0YzrH70PZKauiO3oEShJi/KKvLf/SKFghzTe7A5PppP9LFK6Uj7/
	xgF/rhmvEDki7MXHgUpB49ObXA==
X-Google-Smtp-Source: AGHT+IFT1Y7VV5nno22ITJV4ENgNNpdHnyB1CYiMpLWZvConebc8vMlqaaHPcnrsW/4L73D14eVMcQ==
X-Received: by 2002:a17:903:2285:b0:1b8:9044:b8ae with SMTP id b5-20020a170903228500b001b89044b8aemr3583313plh.11.1691698729615;
        Thu, 10 Aug 2023 13:18:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001b9de67285dsm2190933plb.156.2023.08.10.13.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:18:49 -0700 (PDT)
Date: Thu, 10 Aug 2023 13:18:48 -0700
From: Kees Cook <keescook@chromium.org>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH] netfilter: ebtables: replace zero-length array members
Message-ID: <202308101317.7AAED4DF6A@keescook>
References: <20230809075136.1323302-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809075136.1323302-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 03:51:36PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> As suggested by Kees[1], replace the old-style 0-element array members
> of multiple structs in ebtables.h with modern C99 flexible array.
> 
> [1]: https://lore.kernel.org/all/5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org/
> 
> Link: https://github.com/KSPP/linux/issues/21
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

In theory, this should be fine. It is possible there are userspace tools
that are doing (already) buggy things that will now turn into build
failures. If the userspace ebtable tools still build happily with these
UAPI changes, I imagine that would be a sufficient test.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

