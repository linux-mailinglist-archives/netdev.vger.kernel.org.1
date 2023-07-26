Return-Path: <netdev+bounces-21371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3B76364D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DF6281D28
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83DC14A;
	Wed, 26 Jul 2023 12:27:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4FDC128
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:27:18 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A51BF8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:27:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9a828c920so25559931fa.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690374434; x=1690979234;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UBWlekeadb6ll5cfrcuV68GqkFWW6y461yJLKCvTOag=;
        b=RQnH4EvQgjKLSCBcnN6qage1q8xr1RAq6uvGWIBvdllBtnnhgDXKzy1D837z4p2fXC
         ei3ZnUBc6aZFLHCOreaU1xSfrElRYNFOa+CVs5sibx1DPKBJZ/nigiCesxFewnuqs1z0
         27sNVpGt60SLq4SuQWUwWBTwKVfiKCbHTxuRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374434; x=1690979234;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBWlekeadb6ll5cfrcuV68GqkFWW6y461yJLKCvTOag=;
        b=jkRTy7FaRihWUH+db3lO+w5bCRNw4ma+8AjrE6yj1uiociSqLteIoWVngPoMnkCuiQ
         Ynwu5dvd9X8m1nl3N3qM7deuRbjRoQSupCpHJQ3fPNKxGCgTAQmbdtZRwJmCvSfRxSH9
         pMe8zjZsD1X4hI5ogz+dM5fcQdNq73vRMOa713qExS1i0PN3dTdJguRFLHDpKZG19NrP
         TPSlYFgBj8YlDJhTsh+0bGAlDQIvKwwttY+CBFPINhDluPHHQ5ws4SkLmL9pXZlo2vpL
         k8oVP4pgQPSr2gS2On+l3PRufv9yr8OVd7S6tRWwHI0vHzYSm6HpNnPv10fTNtMOL/cA
         79Aw==
X-Gm-Message-State: ABy/qLZAK3y7lIQrpYDv1uxjWFo6YJWg+TuCU07njEOB75pHno/2NSli
	Xga2LLQtfVBGSQ0lHDufaq6Sqw==
X-Google-Smtp-Source: APBJJlGe0BnzdEiexUengASClPGYfYEAD6/edtGkc8pSs2d5oo3Xa6dhiLC0n0m2SfnTK3KW/uVebA==
X-Received: by 2002:a2e:6e11:0:b0:2b9:aa4d:3728 with SMTP id j17-20020a2e6e11000000b002b9aa4d3728mr1294382ljc.29.1690374434227;
        Wed, 26 Jul 2023 05:27:14 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id kd7-20020a17090798c700b00992a8a54f32sm9436706ejc.139.2023.07.26.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:27:13 -0700 (PDT)
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
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
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
Date: Wed, 26 Jul 2023 14:26:57 +0200
In-reply-to: <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
Message-ID: <87edkuyi1r.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 06:09 PM -07, Yan Zhai wrote:
> Tests BPF redirect at the lwt xmit hook to ensure error handling are
> safe, i.e. won't panic the kernel.
>
> Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

