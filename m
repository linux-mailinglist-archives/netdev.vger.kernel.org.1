Return-Path: <netdev+bounces-278463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ+MITtI3mn+pwkAu9opvQ
	(envelope-from <netdev+bounces-278463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:59:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E13BE3FACDF
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 203433007AF2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187539524E;
	Tue, 14 Apr 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gs7/E/on"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5D34750D
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175043; cv=none; b=cdNeW8hYL8msE8d0FhjfTVjkrXydtXZ7qW0OMJUbXmJESZdhIzZMeahQ/nkTIGpFU5Ex7dGqw3yWSU/QA6v1RH4YWcWKJVuUkswdM3z8bwZTeutwOfREoILzWo1F7gJtK0+bqXuWd2csU6nrbkPEQ1XRA/020izNUFlY+ujGOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175043; c=relaxed/simple;
	bh=WdrZQIlF6dqAmWcBYZjdasD1nN4EJsN+jX8ww4GW1rk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W3vCihn/bW2uHiUTpZIt7ilddi2p/D8Tgxg9e1Z57XEN+Fw7/ydHbHy5vVme5vrlRmztMVBx/UPoxyfJGH3xX1kHJyZZcFZaxDMNd1j3GX9ImEmrFH2BStfPzgmUfsUQu89yQYr9bj7oGr2Ph55h1GwqBcgdOYnHY6Ri6m972rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gs7/E/on; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a70e73a95a02a3747925afdfde26591a0cc6bae3.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776175029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nq/O3jFcXuGXkm/xRXy/eNIPKG9sl6o8TkqLD7aFLzo=;
	b=Gs7/E/onVm21TQ0DizrQJ9kIkWd1JeeOPsROBicpQwN78nToieX1UfoM6JJaew1mL7dmdH
	JczeM3DTeg0OSOqm/FYoJc1a7CDid6vFFWuKgcu9uce5DQ+yQrafRRzC8tvgY9S7Ormbod
	n6rNEp+SoOpLs139FL/7tEGykOS8k6Y=
Subject: Re: [PATCH bpf-next 1/2] bpf: tcp: Reject TCP_NODELAY from BPF hdr
 opt callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org,  martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org,  yonghong.song@linux.dev,
 jolsa@kernel.org, shuah@kernel.org, sdf@fomichev.me, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu
 <dddddd@hust.edu.cn>,  Kaiyan Mei <M202472210@hust.edu.cn>
Date: Tue, 14 Apr 2026 21:56:53 +0800
In-Reply-To: <20260414112310.1285783-2-kafai.wan@linux.dev>
References: <20260414112310.1285783-1-kafai.wan@linux.dev>
	 <20260414112310.1285783-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278463-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hust.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid,uestc.edu.cn:email]
X-Rspamd-Queue-Id: E13BE3FACDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-14 at 19:23 +0800, KaFai Wan wrote:

AI is right and I'm late for the issue. Please ignore this. Sorry for the n=
oise.

> A BPF_SOCK_OPS program can enable
> BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG and then call
> bpf_setsockopt(TCP_NODELAY) from BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>=20
> That reaches __tcp_sock_set_nodelay(), which may call
> tcp_push_pending_frames(). The transmit path then computes TCP
> options again, re-enters bpf_skops_hdr_opt_len(), and invokes the
> same BPF callback recursively. This can loop until the kernel
> stack overflows.
>=20
> TCP_NODELAY is not safe from the header option callback context.
> Reject it with -EOPNOTSUPP when TCP header option callbacks are
> enabled on the socket, so the callback cannot recurse back into
> tcp_push_pending_frames() through do_tcp_setsockopt().
>=20
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/d1d523c9-6901-4454-a183-94462b8f3e4e@=
std.uestc.edu.cn/
> Fixes: 7e41df5dbba2 ("bpf: Add a few optnames to bpf_setsockopt")
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---
> =C2=A0net/ipv4/tcp.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 202a4e57a218..7ac4c98be19d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4004,7 +4004,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
> =C2=A0
> =C2=A0	switch (optname) {
> =C2=A0	case TCP_NODELAY:
> -		__tcp_sock_set_nodelay(sk, val);
> +		if (val && BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FL=
AG))
> +			err =3D -EOPNOTSUPP;
> +		else
> +			__tcp_sock_set_nodelay(sk, val);
> =C2=A0		break;
> =C2=A0
> =C2=A0	case TCP_THIN_LINEAR_TIMEOUTS:

--=20
Thanks,
KaFai

