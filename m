Return-Path: <netdev+bounces-305639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hIVnE3rSTWpd+gEAu9opvQ
	(envelope-from <netdev+bounces-305639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:30:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE572198A
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:30:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="S8thz/mc";
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305639-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305639-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0DA83008603
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 04:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC9307AC7;
	Wed,  8 Jul 2026 04:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DABF3002AB
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 04:30:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485043; cv=none; b=Uyo4GoT+LhmLMFRoQe8dwJhRi4x1JecXm6SedlW6S9y+PiPYJ0zQFr6b6AzogNy8uWzlz4xkn0PXxuf3MsyBkKK2Tdwrgb8c5a6A4ORB3S0lFUpefrlCgNiF5MNreXSIYJNcwlPQhmUxQKLUn1jksLY4oJ3l15xYWiz4cpDPNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485043; c=relaxed/simple;
	bh=74C2TtOu2up1jk2PrAcpqlGMkAYFPs2QXhDSAf8d19U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIoTTLIgdyXWVJ9zDxHquuq+LfOOIODznQZyzNGCKWA6kMJvt8OMACagkEDgBHW0U27+YC10uMFmo6j501J4oC0m1RKlqA7zf1omPJNk4XyHAQJPS8kxa/1wfbBuQtAARyaz3lDkIoh7WhHPfPBFBK36cKKFn8AYjfx94zTLUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S8thz/mc; arc=none smtp.client-ip=91.218.175.186
Message-ID: <22d0ed54-5158-421d-a29a-99bcb69261f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783485038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhvKaMECGUw1fnFs7AF9b48+YMRB23fvuDdwExRvSwo=;
	b=S8thz/mctdI+NuaDs7x+bm7z8lt0sSP8LnCZ8IkNowoXkRFFYYoNDvB2FiRKIyMAqEt9xW
	HxOM5MVxcQiB0RuakQJUw2/a8op6vbVSOJ8TVD5KxcS1YWedX8/bsPyJ7Q0fNWSo+VpU49
	2hcAiE6CZWGhdxjjwhttbnjhkZRVL5E=
Date: Wed, 8 Jul 2026 12:30:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
To: mattia.meleleo@coralogix.com, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mattia.meleleo@coralogix.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[coralogix.com,gmail.com,cloudflare.com];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3BE572198A


On 7/8/26 12:15 AM, Mattia Meleleo via B4 Relay wrote:
> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
> counts bytes in ingress_msg. Without a stream/skb verdict program
> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
> returns 0 even though read() returns data.
>
> Add tcp_inq() to the reported value when the psock has no verdict
> program. The two queues are disjoint, so bytes redirected into
> ingress_msg from other sockets stay correctly accounted through
> msg_tot_len.
>
> Add a selftest covering FIONREAD without a verdict program.
>
> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


I guess udp_bpf_ioctl has same issue. You can fix it if you want.

> ---
>   net/ipv4/tcp_bpf.c                                 | 16 ++++++++-
>   .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++++++++++
>   2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f3..a001b1fff 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>   
>   static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>   {
> +	struct sk_psock *psock;
>   	bool slow;
>   
>   	if (cmd != SIOCINQ)
> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>   		return -EINVAL;
>   
>   	slow = lock_sock_fast(sk);
> -	*karg = sk_psock_msg_inq(sk);
> +	psock = sk_psock_get(sk);
> +	if (unlikely(!psock)) {
> +		unlock_sock_fast(sk, slow);
> +		return tcp_ioctl(sk, cmd, karg);
> +	}
> +	*karg = sk_psock_get_msg_len_nolock(psock);
> +	/* Without a verdict program, ingress data is never diverted to
> +	 * ingress_msg: it stays in sk_receive_queue and is read through
> +	 * the fallback to tcp_recvmsg(), so account for it like
> +	 * tcp_ioctl() does.
> +	 */
> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)
> +		*karg += tcp_inq(sk);
> +	sk_psock_put(sk, psock);
>   	unlock_sock_fast(sk, slow);
>   
>   	return 0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711..f0f368201 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotype)
>   	test_sockmap_pass_prog__destroy(skel);
>   }
>   
> +/* A socket in a sockmap without a verdict program keeps its ingress data
> + * in sk_receive_queue: FIONREAD must account for it.
> + */
> +static void test_sockmap_no_verdict_fionread(void)
> +{
> +	int err, map, zero = 0, sent, avail;
> +	int c0 = -1, c1 = -1, p0 = -1, p1 = -1;
> +	struct test_sockmap_pass_prog *skel;
> +	char buf[256] = "0123456789";
> +
> +	skel = test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	map = bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err = create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
> +		goto out;
> +
> +	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
> +		goto out_close;
> +
> +	sent = xsend(p1, &buf, sizeof(buf), 0);
> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
> +	avail = wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
> +
> +out_close:
> +	close(c0);
> +	close(p0);
> +	close(c1);
> +	close(p1);
> +out:
> +	test_sockmap_pass_prog__destroy(skel);
> +}
> +
>   void test_sockmap_basic(void)
>   {
>   	if (test__start_subtest("sockmap create_update_free"))
> @@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
>   		test_sockmap_skb_verdict_shutdown();
>   	if (test__start_subtest("sockmap skb_verdict fionread"))
>   		test_sockmap_skb_verdict_fionread(true);
> +	if (test__start_subtest("sockmap no_verdict fionread"))
> +		test_sockmap_no_verdict_fionread();
>   	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>   		test_sockmap_skb_verdict_fionread(false);
>   	if (test__start_subtest("sockmap skb_verdict change tail"))
>
> ---
> base-commit: d2c9a99135da931377240942d44f3dea104cedb8
> change-id: 20260707-fionread-no-verdict-a4f8697ac9f9
>
> Best regards,
> --
> Mattia Meleleo <mattia.meleleo@coralogix.com>
>
>

