Return-Path: <netdev+bounces-21118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3747627F9
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD3E281B0A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39D10E9;
	Wed, 26 Jul 2023 01:07:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB77C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:07:10 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8EC211F
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:07:08 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79a23db59c3so906961241.2
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690333628; x=1690938428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdwBWxmoC8jWTGG50vXsFsrbHYhobVYe8zMui4535MQ=;
        b=XA63LcB9VKrUs3pNggkpMfJamzRch4vGpdmmh6PwlAH3APOY7XGBx0fy8etlhxP1lz
         Q52+dLUQNIc/9qZ06aIc2H1T3NnY9UtzyAXLAl/zzzu6XeiBtdBEhggxvBYqcUs3hDPe
         0oaywFZ21cnoBDtVPm9np78YHPOHUZk+HDBO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690333628; x=1690938428;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdwBWxmoC8jWTGG50vXsFsrbHYhobVYe8zMui4535MQ=;
        b=Z7iYncaYvQpJCIDBcY4F6cIp0kTuPh+RNHQm5eAXW0DS5/lVMPRmGP2JMiqZ33hCT7
         NJrpraYKzU9WfFwq+b2464LZpPTci4nCaVx4pnlU2diXVbWKYkl2GjioKl7JdUq/7aTq
         ELlTUKW+KBoKQnVe0zCOW+lt6zZyu4RV87soSVtRjSzK9kClVK0maGF7QOWDD+7BrTH2
         FuFudKuUtk5+qnR3OIChrsr9enwPoLRnCJqbUJ50jP0flUQ9Xves1U0W9cFlN4Xfm14q
         GIBnkLGQvyqSrUAsMJMwjTBI9HqmhZMEd5FhHYkSdGKj9V/0YpVRDmLJUWG7J6Efw/41
         lFzw==
X-Gm-Message-State: ABy/qLbE3A9XhoFvG+4raUXqO85pF+DNehZqofIkYOLfHbxwC6NUaCJm
	ERlLV9eRP0EPFjg77m4C9zC9xA==
X-Google-Smtp-Source: APBJJlHg6hZeDGvlQaspCRybUMZ7BXtzCybEQyrhLiY03Jvht5I5Hk0u379XAnTpp5OJ3bfjj12Jsg==
X-Received: by 2002:a05:6102:282e:b0:443:7572:598b with SMTP id ba14-20020a056102282e00b004437572598bmr275284vsb.13.1690333627937;
        Tue, 25 Jul 2023 18:07:07 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e7-20020a0ce3c7000000b0063757aea986sm4710610qvl.28.2023.07.25.18.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 18:07:07 -0700 (PDT)
Date: Tue, 25 Jul 2023 18:07:04 -0700
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Jordan Griege <jgriege@cloudflare.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH v4 bpf 0/2] bpf: return proper error codes for lwt redirect
Message-ID: <cover.1690332693.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

lwt xmit hook does not expect positive return values in function
ip_finish_output2 and ip6_finish_output2. However, BPF redirect programs
can return positive values such like NET_XMIT_DROP, NET_RX_DROP, and etc
as errors. Such return values can panic the kernel unexpectedly:

https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48

This patch fixes the return values from BPF redirect, so the error
handling would be consistent at xmit hook. It also adds a few test cases
to prevent future regressions.

v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com/ 
v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/

changes since v3:
  * minor change in commit message and changelogs
  * tested by Jakub Sitnicki

changes since v2:
  * subject name changed
  * also covered redirect to ingress case
  * added selftests

changes since v1:
  * minor code style changes

Yan Zhai (2):
  bpf: fix skb_do_redirect return values
  bpf: selftests: add lwt redirect regression test cases

 include/linux/netdevice.h                     |   2 +
 net/core/filter.c                             |   9 +-
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/test_lwt_redirect.c   |  66 +++++++
 .../selftests/bpf/test_lwt_redirect.sh        | 174 ++++++++++++++++++
 5 files changed, 250 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
 create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh

-- 
2.30.2


