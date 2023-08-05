Return-Path: <netdev+bounces-24671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BD770FC5
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 15:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288EA281D29
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE19C121;
	Sat,  5 Aug 2023 13:01:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29BBE73
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 13:01:37 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B881E6A
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 06:01:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso46152681fa.0
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 06:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1691240494; x=1691845294;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=dRV58ZuqIHr62s8jVTTF7sud2wPl6LgH9o3my4nfupE=;
        b=drkrnYo8zHWRJrA8k21pI/DxDCEvqqKXUhhE50l6oQpsyLeQ89vhwdWKdgJY+iutly
         Xvi9+GZpa/dL5LkAwv4r6dZ0tfeoz3oe5bkuR9gKz9sx7wq1qYiuPIV06cyWPDIfeVry
         Kp9JoOvDLxc+GCjOb/7CwYv6jCkzDqDVsXNSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691240494; x=1691845294;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRV58ZuqIHr62s8jVTTF7sud2wPl6LgH9o3my4nfupE=;
        b=dtJNdrqi9xE38v1BkBDC7v8Vl+AJUWf0xa02M7NYG3yq90ovPFPqlZHUKAo6TkGXmz
         Q//ukoAYc6WElf8l/wB5T36FWAOuEOOGrJ4fDytyHZSFJlI5+3zoZmovZ65RMG54nDwp
         hSa7uHa4yKtonlsD/UsWN3j39YFYUEMCjYlAeI0R15FCmPO/h0x4gWJjQroKixW8fwJS
         fstzlQDHO2pbVtPUK50IMLhRi+TWFxRMKdwiM3ZecnIw3GYr4JS4v3n25EoEXaN4Ywdk
         2ksvwgbeqAYOufBGKs9efe+Ktd9kLMbY+SGBbtEZ4ObrutxdvkLiO0fFrGmCsDBpJLtt
         G1iw==
X-Gm-Message-State: AOJu0YzhhTkXENCXcmGfUrS03oF9oQIjuxS1guTBD0bZzQoKjoOi9Aa8
	ORkXWTClVoCo2eIHKXpVTfwd7Q==
X-Google-Smtp-Source: AGHT+IExKHwUZjQ1vXwuJjYczNX+RYz5WQdOtC4so+TWOm+pJnuR4HaYjKrvXq+Vfe1w6U6Yasrkgg==
X-Received: by 2002:a2e:9190:0:b0:2b6:e651:8591 with SMTP id f16-20020a2e9190000000b002b6e6518591mr3527372ljg.37.1691240493638;
        Sat, 05 Aug 2023 06:01:33 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id fx15-20020a170906b74f00b0099c157cba46sm2659887ejb.119.2023.08.05.06.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 06:01:32 -0700 (PDT)
References: <20230805094254.1082999-1-liujian56@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, sockmap: add BPF_F_PERMANENTLY flag for
 skmsg redirect
Date: Sat, 05 Aug 2023 14:51:44 +0200
In-reply-to: <20230805094254.1082999-1-liujian56@huawei.com>
Message-ID: <87sf8xwslw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 05, 2023 at 05:42 PM +08, Liu Jian wrote:
> If the sockmap msg redirection function is used only to forward packets
> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
> program is the same each time. In this case, the BPF program only needs to
> be run once. Add BPF_F_PERMANENTLY flag to bpf_msg_redirect_map() and
> bpf_msg_redirect_hash() to implement this ability.
>
> Then we can enable this function in the bpf program as follows:
> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENTLY);
>
> Test results using netperf  TCP_STREAM mode:
> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
> done
>
> before:
> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
> after:
> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85
>
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---

Interesting idea. Potentially opens up the way to redirect without
fallback to backlog thread in the future. If we know the target, then we
can propagate backpressure.

If we go this route, we will need tests. selftests/test_sockmap would
need to be extended, and we will also need some unit tests in test_progs
for corner cases. Corner cases to cover that come to mind: redirect to
self, redirect target socket closed.

I'm out next week, so won't be able to give it a proper review.

