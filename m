Return-Path: <netdev+bounces-35918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBCE7ABB9E
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 00:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3F89A282064
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1BF47C77;
	Fri, 22 Sep 2023 22:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8A4177F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 22:04:30 +0000 (UTC)
Received: from out-198.mta0.migadu.com (out-198.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69C83
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:28 -0700 (PDT)
Message-ID: <fa7e6c01-87d0-be3a-f4cd-d6d1df4db6c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695420267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+G5yRvQv+1OSNUjcHw7wy/eIeFI1qmcseH4S/j35w8=;
	b=KaBbwCUgOnR93z1slb+xH8/BCqBudPh+K+MfKJPgSsL188yNPNkyoLfYsBwyNYetv6Pa+E
	8zzLp+xBnNg9RJX6ivr328WV1H7v+bMXWzwK3DVpmNOHBYNXxLwu5KC+ydb9DcWGxBd0YY
	DbzO5ntMV5RFzzwvEEfc2cYeTSDnu30=
Date: Fri, 22 Sep 2023 15:04:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 9/9] selftests/bpf: Add tests for cgroup unix
 socket address hooks
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230921120913.566702-1-daan.j.demeyer@gmail.com>
 <20230921120913.566702-10-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230921120913.566702-10-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/21/23 5:09 AM, Daan De Meyer wrote:
> ---
>   tools/testing/selftests/bpf/bpf_kfuncs.h      |  14 +
>   tools/testing/selftests/bpf/network_helpers.c |  34 ++
>   tools/testing/selftests/bpf/network_helpers.h |   1 +
>   .../selftests/bpf/prog_tests/section_names.c  |  25 +
>   .../selftests/bpf/prog_tests/sock_addr.c      | 570 ++++++++++++++++++
>   .../selftests/bpf/progs/connectun_prog.c      |  40 ++
>   .../selftests/bpf/progs/recvmsgun_prog.c      |  39 ++
>   .../selftests/bpf/progs/sendmsgun_prog.c      |  40 ++
>   8 files changed, 763 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr.c
>   create mode 100644 tools/testing/selftests/bpf/progs/connectun_prog.c
>   create mode 100644 tools/testing/selftests/bpf/progs/recvmsgun_prog.c
>   create mode 100644 tools/testing/selftests/bpf/progs/sendmsgun_prog.c

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
> new file mode 100644
> index 000000000000..f92e5f5fb08d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <sys/un.h>
> +
> +#include "test_progs.h"
> +
> +#include "connectun_prog.skel.h"
> +#include "sendmsgun_prog.skel.h"
> +#include "recvmsgun_prog.skel.h"
> +#include "getsocknameun_prog.skel.h"
> +#include "getpeernameun_prog.skel.h"

The patch is missing the new getsocknameun_prog.c and getpeernameun_prog.c file.

[ ... ]

> +void test_sock_addr(void)
> +{
> +	int cgroup_fd = -1;
> +	void *skel;
> +
> +	cgroup_fd = test__join_cgroup("/sock_addr");
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
> +		goto cleanup;
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(tests); ++i) {
> +		struct sock_addr_test *test = &tests[i];
> +
> +		if (!test__start_subtest(test->name))
> +			continue;
> +
> +		skel = test->loadfn(cgroup_fd);
> +		if (!skel)
> +			continue;
> +
> +		switch (test->type) {
> +		case SOCK_ADDR_TEST_BIND:
> +			test_bind(test);

Considering it will help migrating tests from the existing 
"bpf/test_sock_addr.c", don't mind to leave the SOCK_ADDR_TEST_BIND and 
test_bind in this patch even it is not used now. Please mention a few words in 
the commit message and also add a comment here to avoid any future cleanup attempt.

> +			break;
> +		case SOCK_ADDR_TEST_CONNECT:
> +			test_connect(test);
> +			break;
> +		case SOCK_ADDR_TEST_SENDMSG:
> +		case SOCK_ADDR_TEST_RECVMSG:
> +			test_xmsg(test);

It also needs a recvmsg prog test for the connected stream case.


