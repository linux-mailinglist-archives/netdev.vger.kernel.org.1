Return-Path: <netdev+bounces-26558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3914E77820F
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD341C20CDD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED523BCF;
	Thu, 10 Aug 2023 20:21:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C243200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:21:27 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE5A2723
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:21:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f25d045cso1037965b3a.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691698886; x=1692303686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niZ+vrNDQ4GMStTL9kRLMxjukCY/VFRh2rGg2sfT98M=;
        b=CA/+LIC3HH9ropBEzZi69+cyKgmDHdEThksaK6msMAFhGvl2Mfm7X9HAK0vbjKxE95
         TmA846t5rsevs1uu52TwWWlPzCWbBqVYRHx7+imft5hL5eJH3YrFgq4/zcUnm3VaJC0Q
         2+j1Be3W3YLcg3WUDICYJbn7LwvaGudzZ0KSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691698886; x=1692303686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niZ+vrNDQ4GMStTL9kRLMxjukCY/VFRh2rGg2sfT98M=;
        b=SSNfjxkYlhuDTKeJ574v1qcBife07gjV6r+/dcbmkAHCZUMJZ5mL7d1m74We6oNcmR
         DZF+RAZaDjogpgO3oWICFpwBl77su74Nz+VRoEzmZEusgHRyV80HEbwcVaKbaLEIgb/t
         qN9QN5zK5fH2tJEJcZCDXFdU5RPcNjfIdm2av7MQXczBEVICiIE5/5e73MRIvyOi4AJq
         HqDbWCUTTsqpbbGV7pXbgxTT2sRlLp7FauwOQ6FNFMOK8RRDjHRi0A3QfeEQ5A53rAlO
         aTCfLlPerLerdz1MFueauHuWaVTGkFoMljqB++QQ91t7N81Jg0ZLoYPcVsDoUWbjtX/N
         vhEQ==
X-Gm-Message-State: AOJu0YxBwYzGFBX+Nz7q9lZyrk+Jbh9bn4wNLWM63lFInQoaq0bJioA2
	4OjYFIpu2J7gCnWQjGhyz167aw==
X-Google-Smtp-Source: AGHT+IH+bWBYIE/hcCSfEGYoeswt2A5wZB8OQT2bN7ubfqIok10sb3G5WtjpwJDeHbU8icCF5iuJIA==
X-Received: by 2002:a05:6a00:1acd:b0:687:4dd1:92f8 with SMTP id f13-20020a056a001acd00b006874dd192f8mr3900114pfv.10.1691698886324;
        Thu, 10 Aug 2023 13:21:26 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b006661562429fsm1982331pfu.97.2023.08.10.13.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:21:25 -0700 (PDT)
Date: Thu, 10 Aug 2023 13:21:25 -0700
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
Subject: Re: [PATCH v3] netfilter: ebtables: fix fortify warnings in
 size_entry_mwt()
Message-ID: <202308101321.2FDE98DC57@keescook>
References: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 03:45:03PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler is complaining:
> 
> memcpy(&offsets[1], &entry->watchers_offset,
>                        sizeof(offsets) - sizeof(offsets[0]));
> 
> where memcpy reads beyong &entry->watchers_offset to copy
> {watchers,target,next}_offset altogether into offsets[]. Silence the
> warning by wrapping these three up via struct_group().
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

If a v4 is sent, please fix the "beyong" typo that was pointed out.
Otherwise, it looks okay to me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

