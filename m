Return-Path: <netdev+bounces-278510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJZuNcxf3mn+CQAAu9opvQ
	(envelope-from <netdev+bounces-278510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A83FC044
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A38063024DE4
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127713E959D;
	Tue, 14 Apr 2026 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m3Ugc+N1"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4B2DA768;
	Tue, 14 Apr 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181172; cv=none; b=ngnOXwWB1Vooq5ZXDrlxj2GH/gGWIWj63GNK5fcFNJqCPFLC7gkpj+waWgpZGmKABzJ5othlND6Z1iyLHKjQ/hIr3Hddf+frk4NVjdlEUROH5W1GEZ5qHg/Kgjbrb5pbw19PkB2bFLnIM0/o3XMPUggUOgSeHd/i0USI71OvEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181172; c=relaxed/simple;
	bh=rTCyXEtDUnsotdoEbD/fLLp1IKAltS5fHIoCHSQ1vXQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKUlmjRWZvEyzrKPpoSi0ufEXYDpGtDhySiUXqwH+1bJVYmVMTQW8FK7K4KAIU5GwywvTjrcof3l0mnZ5TaYsMACe7X9FICTXLZlNckoloo9Qd+nvPj5Vn88PDejb1v+RbesSghEU2ER17EVJLDVBZqTGTkLDVYNFL9opGdk2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m3Ugc+N1; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Subject:From:To:Date:Content-Type:
	MIME-Version; bh=Ip1c0a+3297g90+Upi4oiVKn6ZWOXamB2pU1EwVMxx8=;
	b=m3Ugc+N17v/CDZwCXgWK2JH20Pmb+JPhp/GYeXzjAb4bQlu90CuxqJf619xTdq
	z/rlZzhjmTaKUqlGesCih2F1BnSL29bcm3NMiHlINTXG8jR4+QzloqwVjPOU7tFv
	RuiLKeE4arChjdEWm5sdkHu3uBqD8R4tEzCzNkQeKQaEE=
Received: from [127.0.0.1] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3vwo0X95ptSsPEw--.58359S2;
	Tue, 14 Apr 2026 23:37:28 +0800 (CST)
Message-ID: <42c1fed84a84519c2432163aa46f587f2d624fef.camel@163.com>
Subject: Re: [PATCH bpf] bpf,tcp: avoid infinite recursion in
 BPF_SOCK_OPS_HDR_OPT_LEN_CB
From: mkf <message1887@163.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>,  Kaiyan Mei <M202472210@hust.edu.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>, Eric Dumazet <edumazet@google.com>,  Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Tue, 14 Apr 2026 23:37:24 +0800
In-Reply-To: <20260414105702.248310-1-jiayuan.chen@linux.dev>
References: <20260414105702.248310-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:_____wD3vwo0X95ptSsPEw--.58359S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4xZFy8Kr1xWw1kKrW7Jwb_yoWxJw18pF
	Wqy3W5ArsrJrW8Cwn3tFWxCF1Igw4qkF9rCa1xWr1rCwnIgr1xJ3y2krsxur4YkrW8Aa4f
	ZF1jkr15CwnrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpSoXUUUUU=
X-CM-SenderInfo: 5phv2tdjhrmmqx6rljoofrz/xtbCwRr3P2neXzqSRwAA3U
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278510-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[message1887@163.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[std.uestc.edu.cn,hust.edu.cn,google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,hust.edu.cn:email]
X-Rspamd-Queue-Id: C67A83FC044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-14 at 18:57 +0800, Jiayuan Chen wrote:
> A BPF_PROG_TYPE_SOCK_OPS program can set BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FL=
AG
> to inject custom TCP header options. When the kernel builds a TCP packet,
> it calls tcp_established_options() to calculate the header size, which
> invokes bpf_skops_hdr_opt_len() to trigger the BPF_SOCK_OPS_HDR_OPT_LEN_C=
B
> callback.
>=20
> If the BPF program calls bpf_setsockopt(TCP_NODELAY) inside this callback=
,
> __tcp_sock_set_nodelay() will call tcp_push_pending_frames(), which calls
> tcp_current_mss(), which calls tcp_established_options() again,
> re-triggering the same BPF callback. This creates an infinite recursion
> that exhausts the kernel stack and causes a panic.
>=20
> BPF_SOCK_OPS_HDR_OPT_LEN_CB
> =C2=A0 -> bpf_setsockopt(TCP_NODELAY)
> 	-> tcp_push_pending_frames()
> 	=C2=A0 -> tcp_current_mss()
> 		-> tcp_established_options()
> 		=C2=A0 -> bpf_skops_hdr_opt_len()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* infinite recursion */
> 			-> BPF_SOCK_OPS_HDR_OPT_LEN_CB
>=20
> A similar reentrancy issue exists for TCP congestion control, which is
> guarded by tp->bpf_chg_cc_inprogress. Adopt the same approach: introduce
> tp->bpf_hdr_opt_len_cb_inprogress, set it before invoking the callback in
> bpf_skops_hdr_opt_len(), and check it in sol_tcp_sockopt() to reject
> bpf_setsockopt(TCP_NODELAY) calls that would trigger
> tcp_push_pending_frames() and cause the recursion.
>=20
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@=
std.uestc.edu.cn/
> Fixes: 0813a841566f ("bpf: tcp: Allow bpf prog to write and parse TCP hea=
der option")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> =C2=A0Documentation/networking/net_cachelines/tcp_sock.rst |=C2=A0 1 +
> =C2=A0include/linux/tcp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 11 ++++++++++-
> =C2=A0net/core/filter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0net/ipv4/tcp_minisocks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0net/ipv4/tcp_output.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
3 +++
> =C2=A05 files changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst
> b/Documentation/networking/net_cachelines/tcp_sock.rst
> index 563daea10d6c..07d3226d90cc 100644
> --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> @@ -152,6 +152,7 @@ unsigned_int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keepalive_i=
ntvl
> =C2=A0int=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 linger2
> =C2=A0u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bpf_sock_ops_cb_flags
> =C2=A0u8:1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bpf_chg_cc_inprogress
> +u8:1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bpf_hdr_opt_len_cb_inprogress
> =C2=A0u16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 timeout_rehash
> =C2=A0u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rcv_ooopack
> =C2=A0u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 rcv_rtt_last_tsecr
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index f72eef31fa23..2bfb73cf922e 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -475,12 +475,21 @@ struct tcp_sock {
> =C2=A0	u8	bpf_sock_ops_cb_flags;=C2=A0 /* Control calling BPF programs
> =C2=A0					 * values defined in uapi/linux/tcp.h
> =C2=A0					 */
> -	u8	bpf_chg_cc_inprogress:1; /* In the middle of
> +	u8	bpf_chg_cc_inprogress:1, /* In the middle of
> =C2=A0					=C2=A0 * bpf_setsockopt(TCP_CONGESTION),
> =C2=A0					=C2=A0 * it is to avoid the bpf_tcp_cc->init()
> =C2=A0					=C2=A0 * to recur itself by calling
> =C2=A0					=C2=A0 * bpf_setsockopt(TCP_CONGESTION, "itself").
> =C2=A0					=C2=A0 */
> +		bpf_hdr_opt_len_cb_inprogress:1; /* It is set before invoking the
> +						=C2=A0 * callback so that a nested
> +						=C2=A0 * bpf_setsockopt(TCP_NODELAY) or
> +						=C2=A0 * bpf_setsockopt(TCP_CORK) cannot
> +						=C2=A0 * trigger tcp_push_pending_frames(),
> +						=C2=A0 * which would call tcp_current_mss()
> +						=C2=A0 * -> bpf_skops_hdr_opt_len(), causing
> +						=C2=A0 * infinite recursion.
> +						=C2=A0 */
> =C2=A0#define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags =
& ARG)
> =C2=A0#else
> =C2=A0#define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..518699429a7a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5483,6 +5483,10 @@ static int sol_tcp_sockopt(struct sock *sk, int op=
tname,
> =C2=A0	if (sk->sk_protocol !=3D IPPROTO_TCP)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if ((optname =3D=3D TCP_NODELAY || optname =3D=3D TCP_CORK) &&
> +	=C2=A0=C2=A0=C2=A0 tcp_sk(sk)->bpf_hdr_opt_len_cb_inprogress)
> +		return -EBUSY;
> +
TCP_CORK is not support in sol_tcp_sockopt(), return -EINVAL by default. an=
d put the check here
could also prevent us from calling getsockopt(TCP_NODELAY) below.

> =C2=A0	switch (optname) {
> =C2=A0	case TCP_NODELAY:
> =C2=A0	case TCP_MAXSEG:
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index dafb63b923d0..fb06c464ac16 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -663,6 +663,7 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
> =C2=A0	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
> =C2=A0
> =C2=A0	newtp->bpf_chg_cc_inprogress =3D 0;
> +	newtp->bpf_hdr_opt_len_cb_inprogress =3D 0;
> =C2=A0	tcp_bpf_clone(sk, newsk);
> =C2=A0
> =C2=A0	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 326b58ff1118..c9654e690e1a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -475,6 +475,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, st=
ruct sk_buff *skb,
> =C2=A0				=C2=A0 unsigned int *remaining)
> =C2=A0{
> =C2=A0	struct bpf_sock_ops_kern sock_ops;
> +	struct tcp_sock *tp =3D tcp_sk(sk);
> =C2=A0	int err;
> =C2=A0
> =C2=A0	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
> @@ -519,7 +520,9 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, st=
ruct sk_buff *skb,
> =C2=A0	if (skb)
> =C2=A0		bpf_skops_init_skb(&sock_ops, skb, 0);
> =C2=A0
> +	tp->bpf_hdr_opt_len_cb_inprogress =3D 1;
we check the BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG before calling BPF_CGROUP_R=
UN_PROG_SOCK_OPS_SK,
could this flag use for the same purpose? so we don't need to add an extra =
field.

	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
	    !*remaining)
		return;
> =C2=A0	err =3D BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
> +	tp->bpf_hdr_opt_len_cb_inprogress =3D 0;
> =C2=A0
> =C2=A0	if (err || sock_ops.remaining_opt_len =3D=3D *remaining)
> =C2=A0		return;

--=20
Thanks,
KaFai


