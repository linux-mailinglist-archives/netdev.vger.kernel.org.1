Return-Path: <netdev+bounces-35901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8B7AB91B
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 20:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id ED2041C20ADE
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47A445F5B;
	Fri, 22 Sep 2023 18:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C642C11
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 18:23:33 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B7BF7
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:23:31 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c434c33ec0so21717605ad.3
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695407011; x=1696011811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yr61q+Y7qYRmoBTJuHgU+TYxnPKaIi9OdQT3qJe9OKQ=;
        b=iCmOCMPCCL9WxWQPipTKjiZkcJbnyvLx9UAPFJ3jfhYVo/UdCh0+xaVLO4N9WYho8k
         kwoYiIC6rCezw41K9BZ5BxuzU58U2S9lh0QTPIiFfbUnsxxQWWZ7K35huxRzNJ/XR+1R
         tR5rhVSDtJqtpZRXG+d9pwjq4V4cuAJtk6ZWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407011; x=1696011811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr61q+Y7qYRmoBTJuHgU+TYxnPKaIi9OdQT3qJe9OKQ=;
        b=ZQ8vGvInkyON7sK87MUPcMGR+88M9XPNZIe8lXCpphd+2gFeydsR79ULK4rtGG5/J/
         NV55Jpy9CueEbApuVVHg0eQcBK0lHODIz1IqhfZxEdvkEZa5AZBSiZvGd5epfB0dBg21
         Qe3RBVIsUykOEkZ9a85hxUUi8rT1nQzeRpsoAJ1qPAh9S90/Zw/KZWyONamlXWxBaTsk
         US/3vbu5GLvbm/wRb6Kb3FTDlnyHz0SPo5AqORz6x8tDpl2giTPFlsVVpcui1x0ZIYOY
         T7m4WvEustTxa4aYAbT4Pc4zYX7SYfBcYXQK5ci+x9/c2d17qcMq0rp8w7Jq8DkSIOZu
         1zZQ==
X-Gm-Message-State: AOJu0Yy9oZcRyEJmCe5GCrtOEHa1j7r1vJS+OtCzNE92svyvmEp3L1J3
	QiQIV/0E+YHxIuuOgrfo/s1SaQ==
X-Google-Smtp-Source: AGHT+IEPfMe5MVG2BsIHv/EtqHgJb805J/3mFScd6v8b4SEGGTa1wBOOaNI8zST/3Yhw8KfpVcqPdA==
X-Received: by 2002:a17:902:b7c9:b0:1c5:cbfb:c16f with SMTP id v9-20020a170902b7c900b001c5cbfbc16fmr265044plz.25.1695407010837;
        Fri, 22 Sep 2023 11:23:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090274c800b001bdc9daadc9sm3775058plt.89.2023.09.22.11.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:23:30 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:23:29 -0700
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
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
	Alex Elder <elder@kernel.org>, Pravin B Shelar <pshelar@ovn.org>,
	Shaokun Zhang <zhangshaokun@hisilicon.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, dev@openvswitch.org,
	linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 14/14] net: sched: Annotate struct tc_pedit with
 __counted_by
Message-ID: <202309221122.74FA902A@keescook>
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-14-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922172858.3822653-14-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 10:28:56AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct tc_pedit.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  net/sched/act_pedit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index 1ef8fcfa9997..77c407eff3b0 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -515,11 +515,11 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
>  		spin_unlock_bh(&p->tcf_lock);
>  		return -ENOBUFS;
>  	}
> +	opt->nkeys = parms->tcfp_nkeys;
>  
>  	memcpy(opt->keys, parms->tcfp_keys,
>  	       flex_array_size(opt, keys, parms->tcfp_nkeys));
>  	opt->index = p->tcf_index;
> -	opt->nkeys = parms->tcfp_nkeys;
>  	opt->flags = parms->tcfp_flags;
>  	opt->action = p->tcf_action;
>  	opt->refcnt = refcount_read(&p->tcf_refcnt) - ref;
> -- 
> 2.34.1
> 

Coccinelle was not happy about the #define ...

struct tc_pedit_sel {
	tc_gen;
	unsigned char           nkeys;
	unsigned char           flags;
	struct tc_pedit_key     keys[0];
};

#define tc_pedit tc_pedit_sel

Also, it's not been converted to a proper flexible array...

-- 
Kees Cook

