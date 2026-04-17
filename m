Return-Path: <netdev+bounces-279287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHSlEZT/4Wna0QAAu9opvQ
	(envelope-from <netdev+bounces-279287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DBF41962E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3320C30C17F9
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE953BC675;
	Fri, 17 Apr 2026 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lu/fJe4q"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8D3BB9E4
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776418086; cv=none; b=BRZg1rxDETjPHGMDimfDviaPk6GCAD81cWUR6ZeNYaY03tbE9X3yCI/sszWzyl57F50SGWTFOqn7XGf3nvLmGcL1GBuM100TbgmKa7WHrh+e3UL2uBDpjFqD4O+FTtTGSyf9zhQg0e/xB/axdpssa5+7A5iTU+oLmWwQJ5QI0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776418086; c=relaxed/simple;
	bh=LzAJF/FmkAqdlVvZY2fTdc22L5n729dJwqViP4n+Eyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BATA89FvOGzK5W1kiwniC6rEBPbxPWifaZxZ8gI+DWTxBAccFHohOY7IaE3+cYlHbY4WeWo+bT6cV1/SXLJ11yEYytiMFCyO47EJ2w/S5TZPqI//n9gfuagWCSDXNViQH1qhw4SbROvKZJGr3cCxByo5FxuDz2eqLUkRhEzu9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lu/fJe4q; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d1d87bf52477d0170366ca83694dc9f7755ccdec.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776418071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i7InGljGZEKZAmpSEkbXjkOBCSclolAPEwl4w3xfvzc=;
	b=lu/fJe4qghAYGUbAqPoKARQP91hI1335ELyfUsJhpgNqiVEFFe5IIxgkGrOyZ26hRswwJz
	5C5uE1xtO7ELW2KN2/fwezgEDaWXwuO6DR/w6LZs+48uWBPCVLTgbmVjwBMQ0Jr4UWFRMn
	tK828SMLs6vK+bh/PQKo1gjg9MHA6bw=
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, martin.lau@linux.dev, 
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org,  andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org,  yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,  shuah@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>,  Kaiyan Mei <M202472210@hust.edu.cn>
Date: Fri, 17 Apr 2026 17:27:11 +0800
In-Reply-To: <ce2019d0-c127-4c0a-8d2a-f373a68d1bd2@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
	 <20260416112308.1820332-2-kafai.wan@linux.dev>
	 <ce2019d0-c127-4c0a-8d2a-f373a68d1bd2@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279287-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_SPAM(0.00)[0.584];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,hust.edu.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uestc.edu.cn:email]
X-Rspamd-Queue-Id: D5DBF41962E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 10:43 +0800, Jiayuan Chen wrote:
>=20
> On 4/16/26 7:23 PM, KaFai Wan wrote:
> > A BPF_SOCK_OPS program can enable
> > BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG and then call
> > bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB or
> > BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
> >=20
> > In these callbacks, bpf_setsockopt(TCP_NODELAY) can reach
> > __tcp_sock_set_nodelay(), which can call tcp_push_pending_frames().
> >=20
> > =C2=A0From BPF_SOCK_OPS_HDR_OPT_LEN_CB, tcp_push_pending_frames() can c=
all
> > tcp_current_mss(), which calls tcp_established_options() and re-enters
> > bpf_skops_hdr_opt_len().
> >=20
> > BPF_SOCK_OPS_HDR_OPT_LEN_CB
> > =C2=A0=C2=A0 -> bpf_setsockopt(TCP_NODELAY)
> > =C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_push_pending_frames()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_current_mss()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_established_opt=
ions()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> bpf_sko=
ps_hdr_opt_len()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -> BPF_SOCK_OPS_HDR_OPT_LEN_CB
> >=20
> > =C2=A0From BPF_SOCK_OPS_WRITE_HDR_OPT_CB, tcp_push_pending_frames() can=
 call
> > tcp_write_xmit(), which calls tcp_transmit_skb().=C2=A0 That path recom=
putes
> > header option length through tcp_established_options() and
> > bpf_skops_hdr_opt_len() before re-entering bpf_skops_write_hdr_opt().
> >=20
> > BPF_SOCK_OPS_WRITE_HDR_OPT_CB
> > =C2=A0=C2=A0 -> bpf_setsockopt(TCP_NODELAY)
> > =C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_push_pending_frames()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_write_xmit()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_transmit_skb()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> tcp_est=
ablished_options()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -> bpf_skops_hdr_opt_len()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> bpf_sko=
ps_write_hdr_opt()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -> BPF_SOCK_OPS_WRITE_HDR_OPT_CB
> >=20
> > This leads to unbounded recursion and can overflow the kernel stack.
> >=20
> > Reject TCP_NODELAY with -EOPNOTSUPP in bpf_sock_ops_setsockopt()
> > when bpf_setsockopt() is called from
> > BPF_SOCK_OPS_HDR_OPT_LEN_CB or BPF_SOCK_OPS_WRITE_HDR_OPT_CB.
> >=20
> > Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4=
e@std.uestc.edu.cn/
> > Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
> > =C2=A0 net/core/filter.c | 5 +++++
> > =C2=A0 1 file changed, 5 insertions(+)
> >=20
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fcfcb72663ca..911ff04bca5a 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_s=
ock_ops_kern *, bpf_sock,
> > =C2=A0=C2=A0	if (!is_locked_tcp_sock_ops(bpf_sock))
> > =C2=A0=C2=A0		return -EOPNOTSUPP;
> > =C2=A0=20
> > +	if ((bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 bpf_sock->op =3D=3D BPF_SOCK_OPS_WRITE_HDR_O=
PT_CB) &&
> > +	=C2=A0=C2=A0=C2=A0 IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&=
 optname =3D=3D TCP_NODELAY)
> > +		return -EOPNOTSUPP;
> > +
> > =C2=A0=C2=A0	return _bpf_setsockopt(bpf_sock->sk, level, optname, optva=
l, optlen);
> > =C2=A0 }
> > =C2=A0=20
>=20
> A simple comment is recommended:
>=20
> /* TCP_NODELAY triggers tcp_push_pending_frames() and re-enters these=20
> callbacks. */
>=20
ok. Added in new version.
>=20
> Also like Martin pointed before, BPF_SOCK_OPS_HDR_OPT_LEN_CB /=20
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB
>=20
> can only be produced under CONFIG_INET so IS_ENABLED(CONFIG_INET) is dead=
.
>=20

--=20
Thanks,
KaFai

