Return-Path: <netdev+bounces-36004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899727AC649
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 04:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 866E6281CAD
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A2262F;
	Sun, 24 Sep 2023 02:03:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA1B63C
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 02:03:31 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B62192
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 19:03:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27702912521so2804769a91.1
        for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695521007; x=1696125807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYVo5GdkTbBgfnivmVoW8KukwKTsj2A6u4CjQwQFBnw=;
        b=SGLLhABuwI73NA3/AHiKeurFZFCrtZ9/z8Ak3RS++VRDkQVMnDFnEOA9U/FpoOUOJH
         N4ab3hpVJ9odTyIIOSnLhEtH8al8lU+sASIYFOYEWniMI7Z33DLBGwR+YvI8GJKJc/DP
         zCPTX3B3mKKdk+gXhtXGAvbgtxQ2ocPZE86qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695521007; x=1696125807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYVo5GdkTbBgfnivmVoW8KukwKTsj2A6u4CjQwQFBnw=;
        b=evkBGTu8mzSGvXaug/xhJeCdA6lcApeaOyFdepfSfw9WDC1cmDLbZf0aOFfrzx3CRL
         jMeq/u3NA8z3kaBF7/+/sRTnn/sXbBbm3pNf1jUeM7NVlVz0pS4tjtFmH666vsguO1gp
         agxQjeOPWM7ih+ylJl1ezl6wr3EF8yauq9c7Qrg4C68fGaL36QDRLz+e82Psk8zQ07ti
         kvZr76zzB8TKPz5JHI+1KR8B9TMKpyv5CBJRrupyinsOp5pyBppSe4UYF3LWOu+uQpgg
         myZAF11CzbQ+b7VOWWmaouw9WY5rHb6czrGwypJuFc+eui2rEYRCgqKsU1xUtLIHPJG4
         xgWA==
X-Gm-Message-State: AOJu0YzLwdmJghA0js9GL/OK2Oj9rkDh/DeFYoC04Lgu1RaHJTlwQzhs
	QHF5Qss0FWsKt/WLUVW7SRkDog==
X-Google-Smtp-Source: AGHT+IGasKw5qGGD+KI5YxzCFxg3lZRJ7Ns/75yx0TF2sBm+b8qXZJKFwUDGZ86xbS0T4ovXuXNpDA==
X-Received: by 2002:a17:90b:11d5:b0:274:ac60:1d57 with SMTP id gv21-20020a17090b11d500b00274ac601d57mr9710054pjb.16.1695521007664;
        Sat, 23 Sep 2023 19:03:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a17090ade8600b002680dfd368dsm5521151pjv.51.2023.09.23.19.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 19:03:26 -0700 (PDT)
Date: Sat, 23 Sep 2023 19:03:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Alex Elder <elder@ieee.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Shaokun Zhang <zhangshaokun@hisilicon.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, dev@openvswitch.org,
	linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 08/14] net: ipa: Annotate struct ipa_power with
 __counted_by
Message-ID: <202309231859.D8467DB23@keescook>
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-8-keescook@chromium.org>
 <6f52f36c-be16-2427-c19f-0e8b3dd2ff5f@ieee.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f52f36c-be16-2427-c19f-0e8b3dd2ff5f@ieee.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 23, 2023 at 07:09:19AM -0500, Alex Elder wrote:
> On 9/22/23 12:28 PM, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> > 
> > As found with Coccinelle[1], add __counted_by for struct ipa_power.
> 
> Looks good, thanks.
> 
> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> Note that there is some interaction between struct ipa_power_data
> and struct ipa_power (the former is used to initialize the latter).
> Both of these contain flexible arrays counted by another field in
> the structure.  It seems possible that the way these are initialized
> might need slight modification to allow the compiler to do its
> enforcement; if that's the case, please reach out to me.

I think it's all okay:

struct ipa_power_data {
        u32 core_clock_rate;
        u32 interconnect_count;         /* # entries in interconnect_data[] */
        const struct ipa_interconnect_data *interconnect_data;
};

"interconnect_data" here is a pointer, not a flexible array. (Yes,
__counted_by is expected to be expanded in the future for pointers,
but not yet.) Looking at initializers, I didn't see any problems with
how struct ipa_power is allocated.

Thanks for the heads-up; I'm sure I'll look at this again when we can
further expand __counted_by to pointers. :)

-Kees

-- 
Kees Cook

