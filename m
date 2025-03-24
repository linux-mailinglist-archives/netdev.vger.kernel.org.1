Return-Path: <netdev+bounces-177113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F2A6DF29
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5FCA7A470A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FFB13A41F;
	Mon, 24 Mar 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpiMLZEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900E425F987
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831890; cv=none; b=hLYLSxz3XWXTUz8+3iPB4N1xWXK/nL/moyPBY1h6ZemB7Fg1bvu4jTO5a5bjg0bQ9Uv9tVCp+MDpyQ3XVM4rqG5dIJ+YYS6+0YA/sjByOmXnBuGkth5WxWw/HWCiM4aPBuFJEiATKSWj70jca5ja7S7YXRbwEIrERMiGuQbK0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831890; c=relaxed/simple;
	bh=bZtYo5AGmOCbMjLJ5uBJaBBBZucbme4iYv+9tvTYfxs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=en55vJ5AleHzJDQ22HZxtldCayMZfBJLsXmhO6u0CQc9otmrEOqEaIwk103ZfETg9R0wakLkAIYO6RTzIkTYnTuyRW5nmBD2AZk1Fdcz8x1/Pfoz1PRNZFHJoaPIHxyJJJTbY3Rr2UKgecqNk4at6L/Wtb/ilzNMHlV2lTPbl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpiMLZEx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be8f281714so559472285a.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742831887; x=1743436687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR/07hyE3D6EcdjQ82Ck86ccD2hkKmdRS4+4OQg8ZzE=;
        b=ZpiMLZExHGsVSxNANxE7SJWmSLhBqTga4SD09KdAamMEx+4z/elzjwL9AtW7dtM/Xn
         Xtla9ivnO7lFH1avU6hgVqGnxJmdkaDbGAH24FCb5TnOLPQV1xECYuu4HjejfurQw1+L
         EeBbul3zhJ5mxzfYM7czEf8GwWJVzqhDp9coFlHGwTfJcJ79wfABR8mvPT4j2XVFCyPj
         bpoR995s97JxnSoixogoigzJAkE1MU6Uw7N7hLGyYjEdTbiKBlQjboPFlq6YmQTSvQGF
         2tEFKAo2gd7M8wF/ZI72DHkXHf7MqUxVW2F+87ElKkET4Ms+/nU+87cCIZESLNh+iOaP
         Qdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742831887; x=1743436687;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SR/07hyE3D6EcdjQ82Ck86ccD2hkKmdRS4+4OQg8ZzE=;
        b=JwWv9Psywlqqmav2hewJOLZ9dfUdG20Lmx6eEMYY9uyVEdml2+s0Eb0Urrr0CKmSRp
         0oEkkRApcbHN9G418F5h0nB3fiOYGfbeaYih0IbC4V52UZHdhk5FkVaeXj7MeUCA89ck
         S4jfrHgmkwPsUZOFp+gJcRKCf5nTaZX1lDOr45IXGVpvIxMJZlYTEBNeneLrPX2gBMD/
         oD0Tw4eliHXNY5X9sG9mv/mzBDXRRGtgoz7G+PJL7UzN7xAuVsofd0t13IXPzBsMBktc
         mjoh93Q8ujQSqgzcJI5jom+/jzzr0N8r9q0A67v+FNynlKITs06zKltxJuC0bmVXw0sN
         9dnw==
X-Forwarded-Encrypted: i=1; AJvYcCUFwS6H13dFmrSq4FGtM/BLa4j8XNmtUyU+X9Ne3W6TQIlZp+aBB0exq/0VgJ9nNP+FGu4lXhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFI7s6ISDa+uUyfcJojEo4K9zfHOfFOtDcwLxN5OERnTI2h/B
	g6g9DSpm2ZrHPLOzkNLTqjbozkp+PZNCwNSlaLpSvznWcyy3EHfX
X-Gm-Gg: ASbGncsUPy4NFT5Jz5W4jdqm8AQcp11invtX56roHd7wmeV7DBaUYzhOsQUf847cxWv
	W4jsHwJBbiTRjfzXTmRa2/MNhRL17+X8rPZELzQY2uO5sMS/QUy/ay1drjD5sPsYixBcIGNxm7F
	ltecAWJsJGc9QL25vNOtvvmHKOY3nUpCCgsaacj99zJf5j36HA/M7jFjso/QhT4wHfi2se38q+c
	dob957FI7Lh9hidbMZ1Gh7AbuBE10gHJvIUZ/hEbUHWqWiiLmLjoXugfQMqtfJW+oB5VjSfn3C6
	M849uh6q9LO8iY6yCr+0ws8CM7F2wmnjlDG1OlN2jwoaF6MTHOW2P17mbBjXKN5WTNuIGZ7cbuN
	YI61WsjubowH1HSgX0qmsSA==
X-Google-Smtp-Source: AGHT+IF/hdBgyO4kG7dzyGe9CJct1k9oJqNc5coqJ4u9muhQPhTpf7UmSSg384rnxaoXHJR7sR5Z2A==
X-Received: by 2002:a05:620a:26a0:b0:7c5:4949:23f3 with SMTP id af79cd13be357-7c5ba19046amr1745472185a.27.1742831887025;
        Mon, 24 Mar 2025 08:58:07 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92d68f3sm526183785a.40.2025.03.24.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:58:06 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:58:06 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <67e1810e3b460_2f662329482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250323231016.74813-4-kuniyu@amazon.com>
References: <20250323231016.74813-1-kuniyu@amazon.com>
 <20250323231016.74813-4-kuniyu@amazon.com>
Subject: Re: [PATCH v1 net 3/3] selftest: net: Check wraparounds for
 sk->sk_rmem_alloc.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> The test creates client and server sockets and sets INT_MAX to the
> server's SO_RCVBUFFORCE.
> 
> Then, the client floods packets to the server until the UDP memory
> usage reaches (INT_MAX + 1) >> PAGE_SHIFT.
> 
> Finally, both sockets are close()d, and the last assert makes sure
> that the memory usage drops to 0.
> 
> If needed, we can extend the test later for other protocols.
> 
> Without patch 1:
> 
>   #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
>   # so_rcvbuf.c:160:rmem_max:Expected pages (524800) <= *variant->max_pages (524288)
>   # rmem_max: Test terminated by assertion
>   #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
>   not ok 1 so_rcvbuf.udp_ipv4.rmem_max
> 
> Without patch 2:
> 
>   #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
>   # so_rcvbuf.c:167:rmem_max:max_pages: 524288
>   # so_rcvbuf.c:175:rmem_max:Expected get_prot_pages(_metadata, variant) (524288) == 0 (0)
>   # rmem_max: Test terminated by assertion
>   #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
>   not ok 1 so_rcvbuf.udp_ipv4.rmem_max
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  tools/testing/selftests/net/.gitignore  |   1 +
>  tools/testing/selftests/net/Makefile    |   2 +-
>  tools/testing/selftests/net/so_rcvbuf.c | 178 ++++++++++++++++++++++++
>  3 files changed, 180 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/so_rcvbuf.c
> 
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 28a715a8ef2b..befbdfb26581 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -41,6 +41,7 @@ sk_so_peek_off
>  socket
>  so_incoming_cpu
>  so_netns_cookie
> +so_rcvbuf
>  so_txtime
>  stress_reuseport_listen
>  tap
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 8f32b4f01aee..d04428eaa819 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -83,7 +83,7 @@ TEST_GEN_PROGS += sk_bind_sendto_listen
>  TEST_GEN_PROGS += sk_connect_zero_addr
>  TEST_GEN_PROGS += sk_so_peek_off
>  TEST_PROGS += test_ingress_egress_chaining.sh
> -TEST_GEN_PROGS += so_incoming_cpu
> +TEST_GEN_PROGS += so_incoming_cpu so_rcvbuf
>  TEST_PROGS += sctp_vrf.sh
>  TEST_GEN_FILES += sctp_hello
>  TEST_GEN_FILES += ip_local_port_range
> diff --git a/tools/testing/selftests/net/so_rcvbuf.c b/tools/testing/selftests/net/so_rcvbuf.c
> new file mode 100644
> index 000000000000..6e20bafce32e
> --- /dev/null
> +++ b/tools/testing/selftests/net/so_rcvbuf.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright Amazon.com Inc. or its affiliates. */
> +
> +#include <limits.h>
> +#include <netinet/in.h>
> +#include <sys/socket.h>
> +#include <unistd.h>
> +
> +#include "../kselftest_harness.h"
> +
> +static int udp_max_pages;
> +
> +static int udp_parse_pages(struct __test_metadata *_metadata,
> +			   char *line, int *pages)
> +{
> +	int ret, unused;
> +
> +	if (strncmp(line, "UDP:", 4))
> +		return -1;
> +
> +	ret = sscanf(line + 4, " inuse %d mem %d", &unused, pages);
> +	ASSERT_EQ(2, ret);
> +
> +	return 0;
> +}
> +
> +FIXTURE(so_rcvbuf)
> +{
> +	union {
> +		struct sockaddr addr;
> +		struct sockaddr_in addr4;
> +		struct sockaddr_in6 addr6;
> +	};
> +	socklen_t addrlen;
> +	int server;
> +	int client;
> +};
> +
> +FIXTURE_VARIANT(so_rcvbuf)
> +{
> +	int family;
> +	int type;
> +	int protocol;
> +	int *max_pages;
> +	int (*parse_pages)(struct __test_metadata *_metadata,
> +			   char *line, int *pages);
> +};
> +
> +FIXTURE_VARIANT_ADD(so_rcvbuf, udp_ipv4)
> +{
> +	.family = AF_INET,
> +	.type = SOCK_DGRAM,
> +	.protocol = 0,
> +	.max_pages = &udp_max_pages,
> +	.parse_pages = udp_parse_pages,
> +};
> +
> +FIXTURE_VARIANT_ADD(so_rcvbuf, udp_ipv6)
> +{
> +	.family = AF_INET6,
> +	.type = SOCK_DGRAM,
> +	.protocol = 0,
> +	.max_pages = &udp_max_pages,
> +	.parse_pages = udp_parse_pages,
> +};
> +
> +static int get_page_shift(void)
> +{
> +	int page_size = getpagesize();
> +	int page_shift = 0;
> +
> +	while (page_size > 1) {
> +		page_size >>= 1;
> +		page_shift++;
> +	}
> +
> +	return page_shift;
> +}
> +
> +FIXTURE_SETUP(so_rcvbuf)
> +{
> +	self->addr.sa_family = variant->family;
> +
> +	if (variant->family == AF_INET)
> +		self->addrlen = sizeof(struct sockaddr_in);
> +	else
> +		self->addrlen = sizeof(struct sockaddr_in6);
> +
> +	udp_max_pages = (INT_MAX + 1L) >> get_page_shift();
> +}
> +
> +FIXTURE_TEARDOWN(so_rcvbuf)
> +{
> +}
> +
> +static void create_socketpair(struct __test_metadata *_metadata,
> +			      FIXTURE_DATA(so_rcvbuf) *self,
> +			      const FIXTURE_VARIANT(so_rcvbuf) *variant)
> +{
> +	int ret;
> +
> +	self->server = socket(variant->family, variant->type, variant->protocol);
> +	ASSERT_NE(self->server, -1);
> +
> +	self->client = socket(variant->family, variant->type, variant->protocol);
> +	ASSERT_NE(self->client, -1);
> +
> +	ret = bind(self->server, &self->addr, self->addrlen);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = getsockname(self->server, &self->addr, &self->addrlen);
> +	ASSERT_EQ(ret, 0);
> +
> +	ret = connect(self->client, &self->addr, self->addrlen);
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +static int get_prot_pages(struct __test_metadata *_metadata,
> +			  const FIXTURE_VARIANT(so_rcvbuf) *variant)
> +{
> +	char *line = NULL;
> +	size_t unused;
> +	int pages = 0;
> +	FILE *f;
> +
> +	f = fopen("/proc/net/sockstat", "r");
> +	ASSERT_NE(NULL, f);
> +
> +	while (getline(&line, &unused, f) != -1)
> +		if (!variant->parse_pages(_metadata, line, &pages))
> +			break;
> +
> +	free(line);
> +	fclose(f);
> +
> +	return pages;
> +}
> +
> +TEST_F(so_rcvbuf, rmem_max)
> +{
> +	char buf[16] = {};
> +	int ret, i;
> +
> +	create_socketpair(_metadata, self, variant);
> +
> +	ret = setsockopt(self->server, SOL_SOCKET, SO_RCVBUFFORCE,
> +			 &(int){INT_MAX}, sizeof(int));
> +	ASSERT_EQ(ret, 0);
> +
> +	ASSERT_EQ(get_prot_pages(_metadata, variant), 0);
> +
> +	for (i = 1; ; i++) {
> +		ret = send(self->client, buf, sizeof(buf), 0);
> +		ASSERT_EQ(ret, sizeof(buf));
> +
> +		if (i % 10000 == 0) {
> +			int pages = get_prot_pages(_metadata, variant);
> +
> +			/* sk_rmem_alloc wrapped around too much ? */
> +			ASSERT_LE(pages, *variant->max_pages);
> +
> +			if (pages == *variant->max_pages)
> +				break;

Does correctness depend here on max_pages being a multiple of 10K?

> +		}
> +	}
> +
> +	TH_LOG("max_pages: %d", get_prot_pages(_metadata, variant));
> +
> +	close(self->client);
> +	close(self->server);
> +
> +	/* Give RCU a chance to call udp_destruct_common() */
> +	sleep(5);
> +
> +	ASSERT_EQ(get_prot_pages(_metadata, variant), 0);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.48.1
> 



