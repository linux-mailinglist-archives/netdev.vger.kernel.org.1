Return-Path: <netdev+bounces-264823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAv+DljlqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:31:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C067222B8A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B0553006082
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082922D877D;
	Fri,  6 Mar 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qZy+q37Z"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDD2848B2
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807478; cv=none; b=KVMdNtGiXryUDqqOfJVhDPXXsQHJ9I90hKGwpjTjvtXwbl8oxSKoqiqHDR7Dq5YEeftDLeJCfwOiqnhAnYlnPA/CpJxosMRXSSnwGJshEd3HurmyVq/Sxr0DVmJt41uho4IIJkI0MNL1e7KqcSSc1RIaEW6oZ7qSdkOB792LXvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807478; c=relaxed/simple;
	bh=1n+l2Bzc+WhA/mNo+1CsZbayb8kjrNbESsp74sL5bu8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=KK3o8OUzUwg3sUjqIg1KFwE1ESwBZA8mg6RFOSe3y2Qg/uRA18E9oNI8jXw1zl6Hn5tbaMrkwi8CApk3yZkwubqyyU+wTdAujYwg1nB86+gY9vpW6svCH3aQ4GJkqRnxXS+Q2FcgDbgU9B16tYQuTSxU+rprxCSwp5pUbwSzWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qZy+q37Z; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772807465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNQUkMOoo/a3N+T0p4O65J8ZNkrPkw2iUb6uTXqG8PU=;
	b=qZy+q37ZcWNPjsJ4NJNcV4l3pusknZ710FL9RUFVG5VJ4ye9Sjai7xnDTbig5lAuuqeJw/
	SbPQJ5pHjFBkugbeiAMDizXNXcwkoiPQk4+CFoi2O8AESz/y2uLnfOJMIwEQAhrbqfR0Zr
	rLjThuf1vAt1s2A7WuRmhzrTSQUJ1k4=
Date: Fri, 06 Mar 2026 14:31:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <834c065e89ccb2d9c3dbeda2677cd6e429cb8f28@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf v3 3/5] bpf, sockmap: Fix af_unix iter deadlock
To: "Michal Luczaj" <mhal@rbox.co>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Eric Dumazet" <edumazet@google.com>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Yonghong Song" <yhs@fb.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo"
 <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Cong Wang" <cong.wang@bytedance.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <6b02c177-69a2-4e08-a936-65bfa8e85b7e@rbox.co>
References: <20260306-unix-proto-update-null-ptr-deref-v3-0-2f0c7410c523@rbox.co>
 <20260306-unix-proto-update-null-ptr-deref-v3-3-2f0c7410c523@rbox.co>
 <b2218c30-a704-4395-a67e-95c62b75586f@linux.dev>
 <6b02c177-69a2-4e08-a936-65bfa8e85b7e@rbox.co>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5C067222B8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264823-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[rbox.co,gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,rbox.co:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

March 6, 2026 at 22:06, "Michal Luczaj" <mhal@rbox.co mailto:mhal@rbox.co=
?to=3D%22Michal%20Luczaj%22%20%3Cmhal%40rbox.co%3E > wrote:


>=20
>=20On 3/6/26 07:04, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> On 3/6/26 7:30 AM, Michal Luczaj wrote:
> >=20
>=20> >=20
>=20> > @@ -3729,15 +3729,14 @@ static int bpf_iter_unix_seq_show(struct =
seq_file *seq, void *v)
> > >  struct bpf_prog *prog;
> > >  struct sock *sk =3D v;
> > >  uid_t uid;
> > >  - bool slow;
> > >  int ret;
> > >=20=20
>=20> >  if (v =3D=3D SEQ_START_TOKEN)
> > >  return 0;
> > >=20=20
>=20> >  - slow =3D lock_sock_fast(sk);
> > >  + lock_sock(sk);
> > >=20=20
>=20> >  - if (unlikely(sk_unhashed(sk))) {
> > >  + if (unlikely(sock_flag(sk, SOCK_DEAD))) {
> > >  ret =3D SEQ_SKIP;
> > >  goto unlock;
> > >  }
> > >=20
>=20>=20=20
>=20>=20=20
>=20>  Switching to lock_sock() fixes the deadlock, but it does not provi=
de mutual
> >  exclusion with unix_release_sock(), which uses unix_state_lock() exc=
lusively
> >  and does not touch lock_sock() at all. So a dying socket can still r=
each the
> >  BPF prog concurrently with unix_release_sock() running on another CP=
U.
> >=20
>=20That's right. Note that although the socket is dying, iter holds a
> reference to it, so the socket is far from being freed (as in: memory
> released).
>=20
>=20>=20
>=20> Both SOCK_DEAD and the clearing of unix_peer(sk) happen under
> >  unix_state_lock() in unix_release_sock(). Without taking unix_state_=
lock()
> >  before the SOCK_DEAD check, there is a window:
> >=20
>=20>  iter unix_release_sock()
> >  --- lock_sock(sk)
> >  SOCK_DEAD =3D=3D 0 (check passes)
> >  unix_state_lock(sk)
> >  unix_peer(sk) =3D NULL
> >  sock_set_flag(sk, SOCK_DEAD)
> >  unix_state_unlock(sk)
> >  BPF prog runs
> >  =E2=86=92 accesses unix_peer(sk) =3D=3D NULL =E2=86=92 crash
> >=20
>=20>  This was not raised in the v2 discussion.
> >=20
>=20It was raised in v1[1]. Conclusion was that bpf prog bytecode directl=
y
> accessing unix_peer(sk) is not an issue; bpf machinery will handle any
> faults. That said, should a "bad" value of unix_peer(sk) end up as a
> parameter of a bpf helper, yes, that is a well known[2] problem (that h=
ave
> a solution unrelated to this series).
>=20
>=20[1]:
> https://lore.kernel.org/bpf/6de6f1bf-c8ee-4dfb-9b8c-f89185946630@linux.=
dev/
> [2]:
> https://lore.kernel.org/bpf/CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs=
4ox0HhAA@mail.gmail.com/
>

Thanks for letting me know.

