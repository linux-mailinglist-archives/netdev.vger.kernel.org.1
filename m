Return-Path: <netdev+bounces-305540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0lapDjI1TWptwgEAu9opvQ
	(envelope-from <netdev+bounces-305540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:19:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A319C71E392
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:19:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=uGrBTLTG;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305540-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305540-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18F56300363C
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407943784C;
	Tue,  7 Jul 2026 17:19:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3581437871
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:19:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444778; cv=none; b=iAbnJsTbOYcFVMSr4MN9h5cS+TGiVXX8j39lCdfhVIWuqRcJc2SlVA+KPJ6ysd4sSCX5IN/8KGaicx+NzIgn+maaBEstlLIyBdoKnJibgQDjT7ss0aXpjRvBTT7Af5cBIDaSlEMptBEj/4E9up9IaGlYBIwLvlDIAdD0fA9k6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444778; c=relaxed/simple;
	bh=uPrZr0iPVAccotWTb0olrTCBCteVhIpn+zqUu39DbfU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u3QqSfgU2QTuf7Mb1n5XFcJtdBQvYp1LHoB/Ha5T3rWX/yYTPa5auBQ8zVgMDL/O++V0n6CSLgpjE/amKqbo1B3wWoDpdT2vyu5U9Uw4FO+54fLs7w0ngdl7Essap/ypfG6i83cMcg9HWgL2ziLeAZLR1n2YdR8yHWZmSevcL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=uGrBTLTG; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8475eca3a66so6358067b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 10:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783444776; x=1784049576; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jfN5epMTrTiNcBZABNNCrA6guMm8dgTEPl6doYRQ6BU=;
        b=uGrBTLTGhrBeqno2q/X6/XjS/TRQN+AFUkqekixE7qH5iUVv0Ct/LxTIE2xb7w6B+O
         5B76dZWbMdU/S9Cm9aZeUOxOPxIN3bGcAKbDBdqH6HrOeok8UaySq5eK8Lc4XtwqXqAk
         wowZ9azz6tPQQ+v25oBM/P3dJL23wtwWM5pjUidqp2wF8y7B1+Y7PLJJ4xKTtA6wNUFt
         6bMPvoWq03kimJz3fSXiC9UUWJJgeXICVTkqc5jCrCuJDmVrQ4ga584EEtIe8QPZYrVV
         iL4BAegQlunlDkEdl7kNEBTAzPm+EXR1oAV5CiAZb+Xy5pg94WDJwXlAYRwX0xe2WUXc
         FGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783444776; x=1784049576;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfN5epMTrTiNcBZABNNCrA6guMm8dgTEPl6doYRQ6BU=;
        b=D1+xkrvXgYM7BTu3Ru9KgzocrXaq4sqyAp5Qgu4C0D5X2Zdi1ZxI9R41YbSmWWTWwC
         31gYhKE8kD8EgrI80CFfGRDQB9Fou6k95rglyYyT3Vf/rTTPBq/aoT9BCNK1MZcbImu9
         mIStlcLn8nHZiE8QRyCLsh/ysASyO/YJbEWEwypCSClkODbv/jyFSuQBXzet8Zip0VHC
         7aDYBBNt3C5/BxpWYzyrJl6wlf+d+jnt4awOK97Ggc1z3v+K+QspTR9LHnuW4ZxKxlCI
         X+c5jzvRLoY9WyGNf0zZke5U9RuNCQFkU9imig15vnM3tVPabd0A48kD2Ov6I/pLJkZV
         j5dQ==
X-Gm-Message-State: AOJu0YwBPrMJzNCgPBDCySaXvqjMQcihLmmR1/9tCQP38HQYtw+pobgM
	ikx4InhqY4WOXCzaAip/JbAvzMo7jk7Ldq1llIxKOadiGQ6IIVO7YQ7+uxsN9W1c1ng=
X-Gm-Gg: AfdE7ckKfRHnyj7WWDG8pwzxk+cvytvtDwKv4U+ktp+GcU5VTLhaO3ww9MdZFKlrrVF
	FbEhlBCpWYYhxjn+0+lQpOserh5ool9ZMdbjypSuDL77yFTfwrW4/1+GIteExu5l+iFMPFE+fLy
	o5lVYnfKGtfsag3AAaBy3dAVy1ZXGoT45e+zTYS2VuMbgkS92BsYf3YxXnU+IDQhej7dE9cuEfy
	NH5RTTFkAVnl60h21Wr78OqbusiNGRysypXorZucoEX/I4fDpedgEqX3liu+bWUQj/eHAojmEOQ
	FUgK7WwEbGaypfx+HaSko/Yw3aXNzYarU3EE9hkMvg84EovTzVU20jRRN0Xuk+8FlOlczERUN5G
	C2FtYEjZBAos/nXtL75oGule2CgyT2so6UY2Moj7R0HFIEho3AJMb56ErCaqt+zu8hwBu8npZ4e
	XE3J3AZkJ/izHorMv3090EWM759kTzqQY4T7BB7Enscg==
X-Received: by 2002:a05:6a00:4f93:b0:848:2f77:e2d7 with SMTP id d2e1a72fcca58-8482f77f29dmr3429036b3a.64.1783444775844;
        Tue, 07 Jul 2026 10:19:35 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afdb7534sm1321918a12.12.2026.07.07.10.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 10:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 13:19:34 -0400
Message-Id: <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
In-Reply-To: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:mattia.meleleo@coralogix.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[coralogix.com,gmail.com,cloudflare.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305540-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,coralogix.com:email,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A319C71E392

On Tue Jul 7, 2026 at 12:15 PM EDT, Mattia Meleleo via B4 Relay wrote:
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

I don't think the Sashiko READ_ONCE() recommendation is that important,
we're just checking for the pointers' existence and I don't see how the
reads can be moved/optimized out/merged in a way that breaks this code.

> ---
>  net/ipv4/tcp_bpf.c                                 | 16 ++++++++-
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++++=
++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f3..a001b1fff 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
> =20
>  static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>  {
> +	struct sk_psock *psock;
>  	bool slow;
> =20
>  	if (cmd !=3D SIOCINQ)
> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, i=
nt *karg)
>  		return -EINVAL;
> =20
>  	slow =3D lock_sock_fast(sk);
> -	*karg =3D sk_psock_msg_inq(sk);
> +	psock =3D sk_psock_get(sk);
> +	if (unlikely(!psock)) {
> +		unlock_sock_fast(sk, slow);
> +		return tcp_ioctl(sk, cmd, karg);
> +	}
> +	*karg =3D sk_psock_get_msg_len_nolock(psock);
> +	/* Without a verdict program, ingress data is never diverted to
> +	 * ingress_msg: it stays in sk_receive_queue and is read through
> +	 * the fallback to tcp_recvmsg(), so account for it like
> +	 * tcp_ioctl() does.
> +	 */
> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)
> +		*karg +=3D tcp_inq(sk);
> +	sk_psock_put(sk, psock);
>  	unlock_sock_fast(sk, slow);
> =20
>  	return 0;
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711..f0f368201 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int sotype=
)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
> =20
> +/* A socket in a sockmap without a verdict program keeps its ingress dat=
a
> + * in sk_receive_queue: FIONREAD must account for it.
> + */
> +static void test_sockmap_no_verdict_fionread(void)
> +{
> +	int err, map, zero =3D 0, sent, avail;
> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
> +	struct test_sockmap_pass_prog *skel;
> +	char buf[256] =3D "0123456789";
> +
> +	skel =3D test_sockmap_pass_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> +		return;
> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
> +
> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1);
> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
> +		goto out;
> +
> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
> +		goto out_close;
> +
> +	sent =3D xsend(p1, &buf, sizeof(buf), 0);
> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
> +	avail =3D wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
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
>  void test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
> @@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
>  		test_sockmap_skb_verdict_shutdown();
>  	if (test__start_subtest("sockmap skb_verdict fionread"))
>  		test_sockmap_skb_verdict_fionread(true);
> +	if (test__start_subtest("sockmap no_verdict fionread"))
> +		test_sockmap_no_verdict_fionread();
>  	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>  		test_sockmap_skb_verdict_fionread(false);
>  	if (test__start_subtest("sockmap skb_verdict change tail"))
>
> ---
> base-commit: d2c9a99135da931377240942d44f3dea104cedb8
> change-id: 20260707-fionread-no-verdict-a4f8697ac9f9
>
> Best regards,
> -- =20
> Mattia Meleleo <mattia.meleleo@coralogix.com>


