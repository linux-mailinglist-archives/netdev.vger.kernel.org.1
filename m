Return-Path: <netdev+bounces-280277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNVhFGoO6GmBEgIAu9opvQ
	(envelope-from <netdev+bounces-280277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DBC440BDC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B9F1300B298
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7343F3A640B;
	Tue, 21 Apr 2026 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TU+fxFtT"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9CB39D6F7;
	Tue, 21 Apr 2026 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776815693; cv=none; b=NQFKhymhM8AmAxK4YgothYqqVZeE2nFKOuX5opkV5k0Dfz4CS0fAhiemuGQOKLxhKe3GB3ViWVhb/7vMU/vV50P4CQK1etiksE0du3K+BEHifEUlDreTpegfCDjb7tNYwnSBeRghnx+hnAogJhgCWObpzssXgyqLoeE9uSZSpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776815693; c=relaxed/simple;
	bh=SBDHdYB3pdwLacODa+1Rx3u7gy9ZKcOefmzfiSp2Xjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzBckulnyZYnjCprkxMcQP/TSk0HzdbZ2a4MeXncmeQ/G8jDzoxmH33czRI8U629c/QC1YeoGxDIiLTProxOe4y76zpMm8vIUp0xcTvLV6rdcixQA6rTsdjg5FIz/fU1TQOE7SGN2VId5nJz4g0cGcJYaxYooHx0+PFo4g7D/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TU+fxFtT; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25b43a7f8fafcaf5e1f5cbb000d7e4ef430decf7.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776815679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NdUjOdkoim+eC3jkTDv+T/Uc8ZOHJpFzinqX2Cu1/t0=;
	b=TU+fxFtT+e4t+D1rep5vVMRLehgoKqzw+x8NXR/cvabMuMlcIImw8v3x5tIfN8x6PtR+KH
	bZNUmAejf9KehGlhacu6b4b5nQs6XUWdhtlFCNInuVLmttUsf2lQp11D7v04Qy8w5q0DU2
	t4niEyMh7zUiyCFvxubw1xDhyiCm7Gc=
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Reject TCP_NODELAY in TCP header
 option callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev,  jolsa@kernel.org, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com,  kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,  shuah@kernel.org,
 ihor.solodrai@linux.dev, jiayuan.chen@linux.dev,  hoyeon.lee@suse.com,
 ameryhung@gmail.com, bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kselftest@vger.kernel.org
Cc: 2022090917019@std.uestc.edu.cn, dddddd@hust.edu.cn,
 M202472210@hust.edu.cn,  martin.lau@kernel.org, clm@meta.com
Date: Wed, 22 Apr 2026 07:53:58 +0800
In-Reply-To: <158599be54ab5be12aa6394a30c5d1e8f155abf8f580214ea78103a2ff8cfe3e@mail.kernel.org>
References: <20260421155804.135786-2-kafai.wan@linux.dev>
	 <158599be54ab5be12aa6394a30c5d1e8f155abf8f580214ea78103a2ff8cfe3e@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280277-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,davemloft.net,google.com,redhat.com,suse.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 58DBC440BDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 16:51 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5fa9189eb772..96849f4c1fbc 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5833,6 +5833,12 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_s=
ock_ops_kern *, bpf_sock,
> > =C2=A0	if (!is_locked_tcp_sock_ops(bpf_sock))
> > =C2=A0		return -EOPNOTSUPP;
> >=20
> > +	/* TCP_NODELAY triggers tcp_push_pending_frames() and re-enters these=
 callbacks. */
> > +	if ((bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 bpf_sock->op =3D=3D BPF_SOCK_OPS_WRITE_HDR_O=
PT_CB) &&
> > +	=C2=A0=C2=A0=C2=A0 level =3D=3D SOL_TCP && optname =3D=3D TCP_NODELAY=
)
> > +		return -EOPNOTSUPP;
> > +
>=20
> Does this same recursion vulnerability exist for BPF TCP congestion
> control algorithms using BPF_PROG_TYPE_STRUCT_OPS?
>=20
> If a BPF congestion control algorithm invokes bpf_setsockopt(TCP_NODELAY)
> from its cwnd_event callback when handling CA_EVENT_TX_START, could it
> trigger unbounded recursion through this path:
>=20
> BPF_PROG_TYPE_STRUCT_OPS cwnd_event callback (CA_EVENT_TX_START)
> =C2=A0 -> bpf_setsockopt(TCP_NODELAY)
> =C2=A0=C2=A0=C2=A0 -> tcp_push_pending_frames()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_write_xmit()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_transmit_skb()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_event_data_=
sent()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> cwn=
d_event()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -> BPF congestion control cwnd_event callback
>=20
> The author confirmed this issue in the v3 discussion thread and Martin
> KaFai Lau suggested creating a new func_proto
> (bpf_sk_setsockopt_nodelay_proto) to reject TCP_NODELAY for all struct_op=
s
> programs, but this patch only addresses BPF_SOCK_OPS callbacks.

patch#2 ("bpf: Reject TCP_NODELAY in bpf-tcp-cc") fix this, pls check.
>=20
> Reference: https://lore.kernel.org/bpf/20260418092235.98444C19424@smtp.ke=
rnel.org/
>=20
>=20
> Does this fix also need to block TCP_CORK when the value is 0?

TCP_CORK is not support, return -EINVAL by default in sol_tcp_sockopt().
>=20
> When bpf_setsockopt() is called with SOL_TCP and TCP_CORK with value 0
> (disabling cork), the call path goes through __tcp_sock_set_cork() in
> net/ipv4/tcp.c, which unconditionally calls tcp_push_pending_frames(sk)
> when cork is disabled:
>=20
> __tcp_sock_set_cork()
> =C2=A0 -> tcp_push_pending_frames()
> =C2=A0=C2=A0=C2=A0 -> tcp_current_mss()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_established_options()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> bpf_skops_hdr_opt_len()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> BPF_SOCK_OPS_HD=
R_OPT_LEN_CB
>=20
> This triggers the same recursion chain described in the commit message,
> but the patch only blocks TCP_NODELAY, not TCP_CORK with value 0.
>=20
> Reference:
> https://lore.kernel.org/bpf/5fea6b5e9d1a13e72edf8222a8ebe50cbb660b37e62b8=
7b65dab6f6f317943ec@mail.kernel.org/
>=20
> > =C2=A0	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, opt=
len);
> > =C2=A0}
> >=20
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/247333=
56810

--=20
Thanks,
KaFai

