Return-Path: <netdev+bounces-231240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A75ACBF6621
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 302EF347748
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680D17BED0;
	Tue, 21 Oct 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HKL5p3Pz"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BB355021
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049009; cv=none; b=bHTNBqL1nQh1Dz/NZBzcvL8IFIvUWDBqZuBUNffAUcA+EhfAhFCu+BORt46MV3WAUIpyxZRQrf5pRqqmwrwpCPndiJMcJn9tgpsqxJUMgczwAmfm+HYapT4Yi/ZY4X7Y7aoZR+8GDsSwlNRvGre+ozFaR8cDMbc1iC16LhpIEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049009; c=relaxed/simple;
	bh=PZPgEIrqSEsFtFBAc9XPMhwq3tBIfsIZD0Sxnshjqx8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=aAnPDve6SuUnGbslbvM/yh7eA6Q5DPf41QgMdBr/NwJ08P2gJ/EQA9OGelNZYUCBHCXoa/Gj6abBbBUAoy07X1MkWmMDni960QJOZGiZ+P92ezadSde4yjHZHh93hJhGCN5ney+u2XGiHyBvgoTkdJTvhfNGqgesOVldeTg7JeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HKL5p3Pz; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761049003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYvStWX6Ci/N/2j+0vFU9W5LcAG8n9087r7VsvwlyY4=;
	b=HKL5p3PzWCZI9q1Dgkjkaz8op07T5e3Xs3ru6Ia2dbqiu0C3py7r9TnSNZAmgS71junlgo
	hbFLl5R4TcEXK2/SW8anS5goRXfCJoHSf0V58rYDUnEPTXng0dCSraKUuI4oSMPVaDMIM0
	cVVoFcUI1EeF/ctDh/G0mUu0e9UwbCQ=
Date: Tue, 21 Oct 2025 12:16:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <f03db434053928c2bc19fe8ffbae06cd06425668@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v2 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap updates
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org, "Eric
 Dumazet" <edumazet@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Willem de Bruijn"
 <willemb@google.com>, "John Fastabend" <john.fastabend@gmail.com>, "David
  S. Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Matthieu Baerts"
 <matttbe@kernel.org>, "Mat Martineau" <martineau@kernel.org>, "Geliang
 Tang" <geliang@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin  KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP  Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao  Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Florian
 Westphal" <fw@strlen.de>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <87cy6gwmvk.fsf@cloudflare.com>
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
 <20251020060503.325369-3-jiayuan.chen@linux.dev>
 <87cy6gwmvk.fsf@cloudflare.com>
X-Migadu-Flow: FLOW_OUT

October 21, 2025 at 18:49, "Jakub Sitnicki" <jakub@cloudflare.com mailto:=
jakub@cloudflare.com?to=3D%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.=
com%3E > wrote:

>=20
>=20On Mon, Oct 20, 2025 at 02:04 PM +08, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> MPTCP creates subflows for data transmission, and these sockets sho=
uld not
> >  be added to sockmap because MPTCP sets specialized data_ready handle=
rs
> >  that would be overridden by sockmap.
> >=20
>=20>  Additionally, for the parent socket of MPTCP subflows (plain TCP s=
ocket),
> >  MPTCP sk requires specific protocol handling that conflicts with soc=
kmap's
> >  operation(mptcp_prot).
> >=20
>=20>  This patch adds proper checks to reject MPTCP subflows and their p=
arent
> >  sockets from being added to sockmap, while preserving compatibility =
with
> >  reuseport functionality for listening MPTCP sockets.
> >=20
>=20>  Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  ---
> >  net/core/sock_map.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
>=20>  diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> >  index 5947b38e4f8b..da21deb970b3 100644
> >  --- a/net/core/sock_map.c
> >  +++ b/net/core/sock_map.c
> >  @@ -535,6 +535,15 @@ static bool sock_map_redirect_allowed(const str=
uct sock *sk)
> >=20=20
>=20>  static bool sock_map_sk_is_suitable(const struct sock *sk)
> >  {
> >  + if ((sk_is_tcp(sk) && sk_is_mptcp(sk)) /* subflow */ ||
> >  + (sk->sk_protocol =3D=3D IPPROTO_MPTCP && sk->sk_state !=3D TCP_LIS=
TEN)) {
> >  + /* Disallow MPTCP subflows and their parent socket.
> >  + * However, a TCP_LISTEN MPTCP socket is permitted because
> >  + * sockmap can also serve for reuseport socket selection.
> >  + */
> >  + pr_err_once("sockmap: MPTCP sockets are not supported\n");
> >  + return false;
> >  + }
> >  return !!sk->sk_prot->psock_update_sk_prot;
> >  }
> >=20
>=20You're checking sk_state without sk_lock held. That doesn't seem righ=
t.
> Take a look how we always call sock_map_sk_state_allowed() after
> grabbing the lock.
> Same might apply to sk_is_mptcp(). Please double check.
>

Thank you for the suggestion. It seems more appropriate to place this log=
ic
inside sock_map_sk_state_allowed().

