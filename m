Return-Path: <netdev+bounces-261695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lT65EGERoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:37:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2751B24CD
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 021D1300E5A2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C928331226;
	Fri, 27 Feb 2026 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfDuwwbG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EA330D2A;
	Fri, 27 Feb 2026 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163422; cv=none; b=L7FFM82QxoAPE61EmpoWVmJh17/aiKj4WqJ69V/NLnPKr32PWLS6ABXRpdj5zb5c87LFIC9Upg7vDJ+efbYXNUoJDsDZ94aaDM1MLH7MgtVVBE/3uYN4L6X+jpMICxR/Iu2XzJOKJCo8lST99J5VMSQuvy28J1d32oojtKWdA14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163422; c=relaxed/simple;
	bh=nWTExEdrQu9yWoo1iOv/yeHjYN3D4MEOFAfN3KqdyjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvEG7idIvBLHTcCo/ooDRpQZmm1kGgYbFYKZpUuGoNwOhwb7YGlaJOInxghM2h9PvOCbWaUdKwi0pM3vs/o3xybwmHvxR7ZpjSn0ookPwc2yHRBh6oHHKvpkgqDBjxlmgDirBm6oBN9bJydfVzQNLhDSlguh6Jj15Vp35pV/sso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfDuwwbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01F9C116C6;
	Fri, 27 Feb 2026 03:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772163422;
	bh=nWTExEdrQu9yWoo1iOv/yeHjYN3D4MEOFAfN3KqdyjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfDuwwbGCh+k14jfFWEFl0Zowsnbq2xsK/BwWAjV6lX4GpPIG3N94mxNA+vhA4gfJ
	 tKatDGUYkQfN95+A8FQxoaueQl/zcL3+Bw7LD76uDDDxsM9WJ/m0yXDEB1i+LEB4wB
	 V/v8bVPKT4N332Aw5l+5ZqUWY0X26aKPLrbtBFPqZlNkWLQZpsaP8mUgE5K7eXw8fN
	 QK6ySRSdtibV16EBuj9RCy7xn2Q20/XFwVPBCPv0mzwNkKPw+qGknKn//XhzSbMxZx
	 nYi0tRtXpSStJlJgWO/Pa5GuNbqdI0zsmsqDbvXvGgbJyCqXgn893qGV0Mj0Dfh6rM
	 Wavbhlj3KHEwg==
From: Jakub Kicinski <kuba@kernel.org>
To: jrife@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	daniel@iogearbox.net,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	yusuke.suzuki@isovalent.com,
	willemdebruijn.kernel@gmail.com,
	martin.lau@linux.dev
Subject: Re: [net-next,v1,2/2] selftests/bpf: Ensure dst addr/port are preserved after socket abort
Date: Thu, 26 Feb 2026 19:36:58 -0800
Message-ID: <20260227033658.2599813-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224190516.2102048-3-jrife@google.com>
References: <20260224190516.2102048-3-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,iogearbox.net,fomichev.me,vger.kernel.org,isovalent.com,gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261695-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.963];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC2751B24CD
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
selftests/bpf: Ensure dst addr/port are preserved after socket abort

Ensure that sock_release hooks see the original dst_ip4, dst_ip6, and
dst_port values for connected UDP and TCP sockets following a socket
abort.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
> new file mode 100644
> index 000000000000..9bd2be4d45a2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy_release.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "network_helpers.h"
> +#include "sock_destroy_release.skel.h"
> +
> +#define TEST_NS "sock_destroy_release_netns"
> +
> +static __u64 socket_cookie(int fd)
> +{
> +	__u64 cookie;
> +	socklen_t cookie_len = sizeof(cookie);
> +
> +	if (!ASSERT_OK(getsockopt(fd, SOL_SOCKET, SO_COOKIE, &cookie,
> +				  &cookie_len), "getsockopt(SO_COOKIE)"))
> +		return 0;
> +	return cookie;
> +}
> +
> +static void destroy(struct sock_destroy_release *skel, int fd, int sock_type)
> +{
> +	__u64 cookie = socket_cookie(fd);
> +	struct bpf_link *link = NULL;
> +	int iter_fd = -1;
> +	int nread;
> +	__u64 out;
> +
> +	skel->bss->abort_cookie = cookie;
> +
> +	link = bpf_program__attach_iter(sock_type == SOCK_STREAM ?
> +					skel->progs.abort_tcp :
> +					skel->progs.abort_udp, NULL);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
> +		goto done;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_OK_FD(iter_fd, "bpf_iter_create"))
> +		goto done;
> +
> +	/* Delete matching socket. */
> +	nread = read(iter_fd, &out, sizeof(out));
> +	ASSERT_GE(nread, 0, "nread");
> +	if (nread)
> +		ASSERT_EQ(out, cookie, "cookie matches");
> +done:
> +	if (iter_fd >= 0)
> +		close(iter_fd);
> +	bpf_link__destroy(link);
> +	close(fd);
> +}
> +
> +static void do_test(struct sock_destroy_release *skel, int sock_type,
> +		    int family)
> +{
> +	const char *addr = family == AF_INET ? "127.0.0.1" : "::1";
> +	int listen_fd = -1, connect_fd = -1;
> +	static const int port = 10001;
> +
> +	listen_fd = start_server(family, sock_type, addr, port, 0);
> +	if (!ASSERT_OK_FD(listen_fd, "start_server"))
> +		goto cleanup;
> +
> +	connect_fd = connect_to_fd(listen_fd, 0);
> +	if (!ASSERT_OK_FD(connect_fd, "connect_to_fd"))
> +		goto cleanup;
> +
> +	memset(&skel->bss->sk, 0, sizeof(skel->bss->sk));
> +	destroy(skel, connect_fd, sock_type);

Does this cause a double close of connect_fd?

The destroy() function closes the fd parameter at line 49:

    close(fd);

But do_test() doesn't update its local connect_fd variable after calling
destroy().

Later in the cleanup code:

> +cleanup:
> +	if (connect_fd >= 0)
> +		close(connect_fd);

connect_fd still holds the closed value and gets closed again.

While this usually results in a benign EBADF error, there's a small window
where another operation could create a new fd with the same number, and the
second close would incorrectly close the reused fd.

Should connect_fd be set to -1 after calling destroy() to prevent the double
close?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_release.c b/tools/testing/selftests/bpf/progs/sock_destroy_release.c
> new file mode 100644
> index 000000000000..add322ab1303
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_release.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_endian.h>
> +#include "bpf_kfuncs.h"
> +
> +volatile __u64 abort_cookie;
> +
> +void maybe_abort(struct sock_common *sk, struct seq_file *seq)
> +{
> +	__u64 sock_cookie;
> +
> +	if (!sk)
> +		return;
> +
> +	sock_cookie = bpf_get_socket_cookie(sk);
> +	if (sock_cookie != abort_cookie)
> +		return;
> +
> +	bpf_sock_destroy(sk);
> +	bpf_seq_write(seq, &sock_cookie, sizeof(sock_cookie));
> +}
> +
> +SEC("iter/udp")
> +int abort_udp(struct bpf_iter__udp *ctx)
> +{
> +	maybe_abort((struct sock_common *)ctx->udp_sk,
> +		    ctx->meta->seq);
> +
> +	return 0;
> +}
> +
> +SEC("iter/tcp")
> +int abort_tcp(struct bpf_iter__tcp *ctx)
> +{
> +	maybe_abort((struct sock_common *)ctx->sk_common,
> +		    ctx->meta->seq);
> +
> +	return 0;
> +}
> +
> +struct bpf_sock sk = {};
> +
> +SEC("cgroup/sock_release")
> +int sock_release(struct bpf_sock *ctx)
> +{
> +	sk.dst_ip4 = ctx->dst_ip4;
> +	sk.dst_ip6[0] = ctx->dst_ip6[0];
> +	sk.dst_ip6[1] = ctx->dst_ip6[1];
> +	sk.dst_ip6[2] = ctx->dst_ip6[2];
> +	sk.dst_ip6[3] = ctx->dst_ip6[3];
> +	sk.dst_port = ctx->dst_port;
> +
> +	return 1;
> +}
> +
> +char _license[] SEC("license") = "GPL";
-- 
pw-bot: cr

