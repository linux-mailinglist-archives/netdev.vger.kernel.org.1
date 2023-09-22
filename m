Return-Path: <netdev+bounces-35900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B87AB8FB
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 02E291C20988
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73D045F52;
	Fri, 22 Sep 2023 18:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB642C06
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 18:18:10 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB690AB
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:18:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so22552745ad.1
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 11:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695406688; x=1696011488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4T/fTfBwkAD/muqS7Lm7m+/C+nhl1XGVqC9ttPy9eA=;
        b=MGEnSZ5DvLoOIcKKMbU6bsWVx1QGxFDEfjRso+SeDZ1c0ST9rD35Hw1u3cdnEFlO95
         a85vrPMSDS90VVCy7DbU/JrVvf5SLAfy4IEpnG7XOJfrl5j2yDPYOhSUrOa/pfA2WQJ4
         C4WQbFy+bg3FkEs/NOyLd8UBmheBFHOE7j/qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695406688; x=1696011488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4T/fTfBwkAD/muqS7Lm7m+/C+nhl1XGVqC9ttPy9eA=;
        b=h9i2iyD/QAq6FuBf43k35NC9XUMn7rF+xMnApzkIzQ87jO7XmyodlPoVKQvKWDmTiy
         LFCj9Tvjs9/HcrNG8sDPG9uoB0yBii36AlUvqHaregAla1WX1OikOqP2H/uykU1YonLh
         QwY+d00AUevOP12Or6gM6Yo0TqqiBKZt696C4D9d93T9JaKDpmfsQviA639s0mwaVPxc
         DxuZwqM91XSV+grdFvIJh1Aw7ThPQc2ncd9bpBMi9elvfeqOa+2ljfAG3cS7n6owARbu
         C7x6GapnYeW/9SvbXiSfgo/ia6L7VDcpeMiBJqt5qrKhyCSDcED7m/cS2HWta8TEKuF4
         LxaA==
X-Gm-Message-State: AOJu0Yz/cXdlHDTsYbm9xzJKxRnpMqbnzgsdn/GKM7gbgKNNp36ctK4/
	ym+yvrQET73dq003kdxAcNjNSg==
X-Google-Smtp-Source: AGHT+IH5/bxePU0F2RoHuDHcwpnFv3qhRHMIDj1hzz6KjFthqubQPCi6uc81wCdHv55oKzyGphjbaA==
X-Received: by 2002:a17:902:d48f:b0:1c3:6d97:e89e with SMTP id c15-20020a170902d48f00b001c36d97e89emr297047plg.58.1695406688329;
        Fri, 22 Sep 2023 11:18:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090301c300b001b531e8a000sm3797390plh.157.2023.09.22.11.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:18:07 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:18:07 -0700
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
Message-ID: <202309221117.160257BAB@keescook>
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

Gustavo pointed out that the annotation half of this patch in missing.
My mistake! I will figure out where it went. :P Ah, the joys of
splitting up a treewide patch series...

-- 
Kees Cook

