Return-Path: <netdev+bounces-20865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1FE7619BA
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 15:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564101C20EB1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E91F926;
	Tue, 25 Jul 2023 13:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2751F924
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:21:06 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2FB1FF7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:20:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9891c73e0fbso1161457966b.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690291257; x=1690896057;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Re/z3nObvtjSOuqc2XvuozwPKWBuW5694/qbzOrvreM=;
        b=avOtOUW+Cj7SR0Q9peI/1FD6B3M1N5Hr+fpAclHpm7L8hzrxsUoV1RTF4m5DA/Dq6a
         YJrqZXEXN7nHdcOkn45MQip/pZDwfl59O6sLsgxXu550emMbxOb105bU8WmyRsMyqKeR
         DiZpVUvn/srF5U00xeHXv3iBuwmiPGmWrnWb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291257; x=1690896057;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re/z3nObvtjSOuqc2XvuozwPKWBuW5694/qbzOrvreM=;
        b=OJ7gBmcXPBkcoe/1mxJEnC/7rC5pRwZATl2kGZFeeJ1+pKaGbzxOfrvfak2MiiVtos
         fUPIcVFJyZ/bhZS9bIcvZCDKlXYocmfme/Ey/lP7X4SdILUDL26mIgzwL948Qy1bH3Hj
         tYoFd5KRPz9uwNJ/wxbqgmUgEwQuBT5UpdyJlW45M233nq285dWgFhrvVfg7F4B3SZic
         DLy+UnsKyZLQ7mKChV/sIiHtmM1AxxLP5IOpR1OnuccUz0InrVHTqL2tXoYWlkkFF1El
         NGCN0rtJ3hiSB2Wh1aPGkIrL6YMWKIJr27kfhFN5ZH4MMykuK/BP642q8+idWwRahZtc
         vIMw==
X-Gm-Message-State: ABy/qLYij1091bUAdsKk57nUg1+oTVRLU5cP53OBxl1jKoazXe0AjECe
	+CPrLoJ0BaFXQCYQ+zAD6l/N0g==
X-Google-Smtp-Source: APBJJlH+qEf1EkwtzcMEpjPEgMFdKkhYpww/2/CnlXcjZ72gg/UoQUeciPbGIm5RrLkuaIIGMvU/lQ==
X-Received: by 2002:a17:907:2c4f:b0:993:d632:2c3 with SMTP id hf15-20020a1709072c4f00b00993d63202c3mr2315057ejc.21.1690291256910;
        Tue, 25 Jul 2023 06:20:56 -0700 (PDT)
Received: from cloudflare.com (79.184.214.102.ipv4.supernova.orange.pl. [79.184.214.102])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906254100b00992076f4a01sm8117208ejb.190.2023.07.25.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:20:56 -0700 (PDT)
References: <cover.1690255889.git.yan@cloudflare.com>
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
 linux-kselftest@vger.kernel.org, Jordan Griege <jgriege@cloudflare.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH v3 bpf 0/2] bpf: return proper error codes for lwt redirect
Date: Tue, 25 Jul 2023 15:20:06 +0200
In-reply-to: <cover.1690255889.git.yan@cloudflare.com>
Message-ID: <87mszkxh3c.fsf@cloudflare.com>
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

On Mon, Jul 24, 2023 at 09:12 PM -07, Yan Zhai wrote:
> lwt xmit hook does not expect positive return values in function
> ip_finish_output2 and ip6_finish_output2. However, BPF redirect programs
> can return positive values such like NET_XMIT_DROP, NET_RX_DROP, and etc
> as errors. Such return values can panic the kernel unexpectedly:
>
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
>
> This patch fixes the return values from BPF redirect, so the error
> handling would be consistent at xmit hook. It also adds a few test cases
> to prevent future regressions.
>
> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
>
> changes since v2:
>   * subject name changed
>   * also covered redirect to ingress case
>   * added selftests
>
> changes since v1:
>   * minor code style changes
>
> Yan Zhai (2):
>   bpf: fix skb_do_redirect return values
>   bpf: selftests: add lwt redirect regression test cases
>
>  net/core/filter.c                             |  12 +-
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../selftests/bpf/progs/test_lwt_redirect.c   |  67 +++++++
>  .../selftests/bpf/test_lwt_redirect.sh        | 165 ++++++++++++++++++
>  4 files changed, 244 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
>  create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh

For the series:

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>

