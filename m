Return-Path: <netdev+bounces-264888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFD0KMUQq2kRZwEAu9opvQ
	(envelope-from <netdev+bounces-264888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:37:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FCB226500
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 18:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D788314396B
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AD36AB5F;
	Fri,  6 Mar 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNtzk/ug"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942A344DA4
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817906; cv=none; b=oQ1TAsY5xscxnT9ebOMG5w+HklT3RrWZaGduT2CArHljJLSMBdv9g5efYbEoZfy8Z5XpVLNpjAoezA39ZbIeokxjtVRjr0s+YHSpJHLJcQdlxEIutxElgHyp7kUg4tU+fv9/L35ddkHU7h4ixMEwV6LiQhjiA7K04xVcZn/seFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817906; c=relaxed/simple;
	bh=sJvu5ZIusWpM65LX9/Pg8n9g4CDCjntwYIq9HwVj0AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t0AfTb8ffR+MT3LYyED6vGvw/fP0vxsBwdhsbOnS59ULjVh7Glkojkgg4g6FrVLOZXicuafveA2yyIX0XzlinGu3syOFOQjsJpMwqI5kz9xJY5hgxh24Bg/oDuqdwVnzgCHfPGD3Ik9quSwnMH/nleukU8TJjwkLMjGCLB9jSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNtzk/ug; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso88770245e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772817903; x=1773422703; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXylfdNhh0fJwU2zW8/9CEKJG92aF2DVQNEe8gTW+9U=;
        b=MNtzk/ugkh7TNI2kf4QZodxb03iTssbvZvCmht9gnM8AS8szlGmM77DyKODzuFXsD8
         ZNVl9KSLcHDet9+XkVqEAGSLs9EDJhASW4iSWr/C8h+qemK2GgTmFzNEfMw2FnkkTWVy
         ZPhN6D4jOKVwQueWqHhkeuY68nRCE8SIC5I03J085mo73UuttOayeNQoxlHcCcRe3VVy
         +6qSWcgaeltKjnDkHfj4GBaZ2VwRDRBSYq4z5kOYaCgZ2slT1oqJ8IRQPybghFlN7LVB
         bmMRfKnuHwQElk2pNONnGIaLuK0/krArOyx+X9PQigejjhzxVnIqD0FM4IywtkW63ZCW
         6Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772817903; x=1773422703;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXylfdNhh0fJwU2zW8/9CEKJG92aF2DVQNEe8gTW+9U=;
        b=sc93lQ/ibVRmUCBX6jExrWFDF2EVg992J6N5oCUUPiUUxEi9UpBrjrCR7A7X3o1s5d
         AJ4HmvG58dAgeLeO3oaw4QPLl/vm4EpdUXSEB7/d7U3KW2OyGfpPaCJYBWunEmrewjyE
         HAtJR/gJqEZDkuqOnVAVeHjFX/kG57fYLzQdrwgIPzGKBDqdxpCTTxxUm/DSpLBC5B3g
         4Ynkwf/fcNWv04hocLZrbPar1yFGcxms6E0hndLlo9lMXkY53ti7iiX/53BuRXz4+aUY
         3+CH4yT1+IrQ7PJoQfRKPlnRqVyU3n508GqJg88Zf0T9Gscbgk83jAPvZMw5YHF3x0tS
         6RfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsA4Kyh5HYiD4gFbsp+55x9CQfMMxymqozgEQF+THh9b7ZDXvSRi0Ei++j1jkxu4m/GMHy6K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKazj1SjwmXuQH4uXYhzShOiZOL3rcj8HWVHsyM5gfZ18QtMrR
	hCv6d9TbUwea1LB5iJ9neQcD9bXU74XwnXLu0QZUVXzpGnvQV7Geq1CB
X-Gm-Gg: ATEYQzwU+rcCelQTu+TAFMi+RBS7pnKlXjMCZHngEfHFcUInK2YVrVIcVoMQTAz0ROf
	ZUtrll44m3lARffHsb0EfvgAkA9dVF8VN0NoqxhaEhw1QeuDvE2ANgJo/UipD7opWq+dmlvKOpc
	ucd8L1MGx3rUyBWWJWIMsvRRy12K20BJ4CJC1evyONAzwvbcNRzcdnNhGi3IWcq95hRG5hn1tgz
	n2a1gbJw+HdT06x4nKs5ffJUOW5kl9r82DhGnpopnQ4qqNzNvG3D+3f2Sl9WhRu5xZniax5J3gb
	6m0HQdTLbb6xyO8L7BLDKGpiezqqTrWo86oKV5swYdTjTyK+VCG7JL0/A+2hahqW8qRE4AINBhd
	W99GUircOCHEupPl9zV5rlRb4QFEXLQEtCph9UuISAu0V9vpIYlHIAq7SPIkOWExgKKZPpfXvaV
	R2+tet9SwjSMAk7bKdM1hDHjl7TauLouWbGDxu/A==
X-Received: by 2002:a05:600c:4fc2:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-4852692bfa5mr49036885e9.13.1772817902616;
        Fri, 06 Mar 2026 09:25:02 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527686fa9sm61754555e9.8.2026.03.06.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 09:25:01 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 john.fastabend@gmail.com, jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de
 Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiapeng Chong
 <jiapeng.chong@linux.alibaba.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Michal Luczaj <mhal@rbox.co>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 6/7] selftests/bpf: add splice_read tests
 for sockmap
In-Reply-To: <20260304063643.14581-7-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
 <20260304063643.14581-7-jiayuan.chen@linux.dev>
Date: Fri, 06 Mar 2026 17:25:01 +0000
Message-ID: <87eclwyioi.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 23FCB226500
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264888-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.dev,vger.kernel.org,gmail.com,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mykytayatsenko5@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Jiayuan Chen <jiayuan.chen@linux.dev> writes:

> Add splice_read coverage to sockmap_basic and sockmap_strp selftests.
> Each test suite now runs twice: once with normal recv_timeout() and
> once with splice-based reads, verifying that data read via splice(2)
> through a pipe produces identical results.
>
> A recv_timeout_with_splice() helper is added to sockmap_helpers.h
> that creates a temporary pipe, splices data from the socket into
> the pipe, then reads from the pipe into the user buffer. MSG_PEEK
> calls fall back to native recv since splice does not support peek.
> Non-TCP sockets also fall back to native recv.
>
> The splice subtests are distinguished by appending " splice" to
> each subtest name via a test__start_subtest macro override.
>
> ./test_progs -a sockmap_*
> ...
> Summary: 5/830 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 28 ++++++++-
>  .../bpf/prog_tests/sockmap_helpers.h          | 62 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/sockmap_strp.c   | 28 ++++++++-
>  3 files changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index dd3c757859f6..ea0b49ec9a93 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -18,6 +18,23 @@
>  
>  #include "sockmap_helpers.h"
>  
> +static bool use_splice;
> +
> +static bool __start_subtest(const char *name)
> +{
> +	if (!use_splice)
> +		return (test__start_subtest)(name);
> +
> +	char buf[MAX_TEST_NAME];
> +
> +	snprintf(buf, sizeof(buf), "%s splice", name);
> +	return (test__start_subtest)(buf);
> +}
> +
> +#define test__start_subtest(name) __start_subtest(name)
> +#define recv_timeout(fd, buf, len, flags, timeout) \
> +	recv_timeout_with_splice(fd, buf, len, flags, timeout, use_splice)
Not sure if this is a good idea to redefine test__start_subtest and
recv_timeout.
It looks like recv_timeout() is called 5 times in this file, so maybe
handling recv_timeout_with_splice() explicitly won't be too messy. 
> +
>  #define TCP_REPAIR		19	/* TCP sock is under repair right now */
>  
>  #define TCP_REPAIR_ON		1
> @@ -1314,7 +1331,7 @@ static void test_sockmap_multi_channels(int sotype)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
>  
> -void test_sockmap_basic(void)
> +static void __test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
>  		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
> @@ -1391,3 +1408,12 @@ void test_sockmap_basic(void)
>  	if (test__start_subtest("sockmap udp multi channels"))
>  		test_sockmap_multi_channels(SOCK_DGRAM);
>  }
> +
> +void test_sockmap_basic(void)
> +{
> +	use_splice = false;
> +	__test_sockmap_basic();
> +
> +	use_splice = true;
> +	__test_sockmap_basic();
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index d815efac52fd..1f0da657243f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> @@ -80,4 +80,66 @@ static inline int add_to_sockmap(int mapfd, int fd1, int fd2)
>  	return xbpf_map_update_elem(mapfd, &u32(1), &u64(fd2), BPF_NOEXIST);
>  }
>  
> +static inline ssize_t recv_timeout_with_splice(int fd, void *buf, size_t len,
> +					       int flags,
> +					       unsigned int timeout_sec,
> +					       bool do_splice)
> +{
> +	ssize_t total = 0;
> +	int pipefd[2];
> +	int fl;
> +
> +	int sotype, protocol;
> +	socklen_t optlen = sizeof(sotype);
> +
> +	if (!do_splice || (flags & MSG_PEEK) ||
> +	    getsockopt(fd, SOL_SOCKET, SO_TYPE, &sotype, &optlen) ||
> +	    sotype != SOCK_STREAM ||
> +	    getsockopt(fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen) ||
> +	    protocol != IPPROTO_TCP)
> +		return recv_timeout(fd, buf, len, flags, timeout_sec);
> +
> +	if (poll_read(fd, timeout_sec))
> +		return -1;
> +
> +	if (pipe(pipefd) < 0)
> +		return -1;
> +
> +	/*
> +	 * tcp_splice_read() only checks sock->file->f_flags for
> +	 * O_NONBLOCK, ignoring SPLICE_F_NONBLOCK for the socket
> +	 * side timeout. Set O_NONBLOCK on the fd so the loop won't
> +	 * block forever when no more data is available.
> +	 */
> +	fl = fcntl(fd, F_GETFL);
> +	fcntl(fd, F_SETFL, fl | O_NONBLOCK);
> +
> +	/*
> +	 * Pipe has limited buffer slots (default 16), so a single
> +	 * splice may not transfer all requested bytes. Loop until
> +	 * we've read enough or no more data is available.
> +	 */
> +	while (total < (ssize_t)len) {
> +		ssize_t spliced, n;
> +
> +		spliced = splice(fd, NULL, pipefd[1], NULL, len - total,
> +				 SPLICE_F_NONBLOCK);
> +		if (spliced <= 0)
> +			break;
> +
> +		n = read(pipefd[0], buf + total, spliced);
> +		if (n <= 0)
> +			break;
> +
> +		total += n;
> +	}
> +
> +	fcntl(fd, F_SETFL, fl);
> +
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +
> +	return total > 0 ? total : -1;
> +}
> +
>  #endif // __SOCKMAP_HELPERS__
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> index 621b3b71888e..2226399eee0d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> @@ -6,6 +6,23 @@
>  #include "test_skmsg_load_helpers.skel.h"
>  #include "test_sockmap_strp.skel.h"
>  
> +static bool use_splice;
> +
> +static bool __start_subtest(const char *name)
> +{
> +	if (!use_splice)
> +		return (test__start_subtest)(name);
> +
> +	char buf[MAX_TEST_NAME];
> +
> +	snprintf(buf, sizeof(buf), "%s splice", name);
> +	return (test__start_subtest)(buf);
> +}
> +
> +#define test__start_subtest(name) __start_subtest(name)
> +#define recv_timeout(fd, buf, len, flags, timeout) \
> +	recv_timeout_with_splice(fd, buf, len, flags, timeout, use_splice)
> +
>  #define STRP_PKT_HEAD_LEN 4
>  #define STRP_PKT_BODY_LEN 6
>  #define STRP_PKT_FULL_LEN (STRP_PKT_HEAD_LEN + STRP_PKT_BODY_LEN)
> @@ -431,7 +448,7 @@ static void test_sockmap_strp_verdict(int family, int sotype)
>  	test_sockmap_strp__destroy(strp);
>  }
>  
> -void test_sockmap_strp(void)
> +static void __test_sockmap_strp(void)
>  {
>  	if (test__start_subtest("sockmap strp tcp pass"))
>  		test_sockmap_strp_pass(AF_INET, SOCK_STREAM, false);
> @@ -452,3 +469,12 @@ void test_sockmap_strp(void)
>  	if (test__start_subtest("sockmap strp tcp dispatch"))
>  		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
>  }
> +
> +void test_sockmap_strp(void)
> +{
> +	use_splice = false;
> +	__test_sockmap_strp();
> +
> +	use_splice = true;
> +	__test_sockmap_strp();
> +}
> -- 
> 2.43.0

