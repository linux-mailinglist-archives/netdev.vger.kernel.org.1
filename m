Return-Path: <netdev+bounces-21369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D04763643
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27AC1C2128D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C7C144;
	Wed, 26 Jul 2023 12:26:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2438C141
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:26:16 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5226BB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:26:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso1123822966b.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690374368; x=1690979168;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Zw4DRcroK7b/Ks1g/UthzcdQpwOmLzE3yDyhD4mJ/48=;
        b=NRctkvSKs+iRsVWTOZqB7gngDEnfK/LWaunoUHDqBmsl8zHpvn2iWS36/Od0sBmlP5
         bgEFSxuRPtraPIqqbylltCq6p74DT34dqQ8CENZ7S2I/+5XFdRzWfZmSjBqVQSKZctZk
         Pzv6HO/hLOX962lGP2VFYRYV5W4djxSgMgugU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374368; x=1690979168;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw4DRcroK7b/Ks1g/UthzcdQpwOmLzE3yDyhD4mJ/48=;
        b=eGdUQC2rIbEAIhRGXeihCH07HsIxOgO+JsUhtLCuD8kRidvVv4P80VpPMXJGi5Y6vn
         FCfrpv7dIgREKuJ2ksi4giUaxvd6tLkPzaXKwgkQj2OydxNvUbSXQ/ryTC+CT/hazUgN
         aplnBxwuGUOl3sXR4g6M4Si/32gq4N/I5+f1Rj5lHYXLrZ6TOXcovbWRkWxezq3fLkeH
         2ROeW7sVHL7MSggG3hXBT9Jp8ok7S45f7zqmDpD4+XGfvz+uuA5skZRCni88IB5hTB88
         GGqirl9AWeVm74PJtyClcEeTwCGOOED7mHsLsPE3ZTiAhHQ3rxn0Jg4NlcCaAxRTmVa9
         F7mQ==
X-Gm-Message-State: ABy/qLY7GvcchnroVvi4GE0QYCBi6d12Q+h5JpoO5T4lImQtIm7+r5wu
	BB0O3g0kyTB1KruQ6zKekrXbFA==
X-Google-Smtp-Source: APBJJlGUuhYIKX/FLcEg4ECj+YQkaLws6RHjkPmrOYhV3X8HJknZffmI3n4yRUjOAgIU0PfTwQlETw==
X-Received: by 2002:a17:907:a049:b0:994:54e7:1287 with SMTP id gz9-20020a170907a04900b0099454e71287mr1478975ejc.73.1690374367751;
        Wed, 26 Jul 2023 05:26:07 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906378d00b0099b4ec39a19sm9621112ejc.6.2023.07.26.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:26:07 -0700 (PDT)
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, Jordan Griege
 <jgriege@cloudflare.com>, Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Date: Wed, 26 Jul 2023 14:25:38 +0200
In-reply-to: <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
Message-ID: <87ila6yi3l.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 06:08 PM -07, Yan Zhai wrote:
> skb_do_redirect returns various of values: error code (negative),
> 0 (success), and some positive status code, e.g. NET_XMIT_CN,
> NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel
> infrastructure") didn't check the return code correctly, so positive
> values are propagated back along call chain:
>
>   ip_finish_output2
>     -> bpf_xmit
>       -> run_lwt_bpf
>         -> skb_do_redirect
>
> Inside ip_finish_output2, redirected skb will continue to neighbor
> subsystem as if LWTUNNEL_XMIT_CONTINUE is returned, despite that this
> skb could have been freed. The bug can trigger use-after-free warning
> and crashes kernel afterwards:
>
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
>
> Convert positive statuses from skb_do_redirect eliminates this issue.
>
> Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
> Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Reported-by: Jordan Griege <jgriege@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

