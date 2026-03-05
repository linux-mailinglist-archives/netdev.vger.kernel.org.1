Return-Path: <netdev+bounces-264215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPP9BZ46qWkd3QAAu9opvQ
	(envelope-from <netdev+bounces-264215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:11:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6770320D3AE
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 977E8300D457
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 08:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E9D366809;
	Thu,  5 Mar 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wup2vosj"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0A2BFC7B
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772698185; cv=none; b=HJ3wvOroyqrC90CpLyBS38LqWu6vNMFdVrSXEvWt7JuFgC/dem8zfVF4oyvf2GIz+tQwZ5ODe4MrQLec6oPky1+2Kfj/MUuoFpas3PKFAnlPMthKrXURwLWmcLDp02D1b+GGKDSTTwqKrmqWjMLlQk/ennMZH2Ya8uR9elbxeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772698185; c=relaxed/simple;
	bh=2AODVqPJrLUctFGmiF7L8ByXAZ+zeHnXibdRafQXW1g=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=tKkUQOmMyRJFgyRxh/wj9sKxcDTIKQOM12nlEBNtU4BeqFPoIkxkOE9lFwu5cqr6hM82WrnMq/BrcX5jBNmUy6zi4XFOAMMKxyJRd1+PrlNkV2MqAO4qGSnwfSfyFBqe7ozKIYIGKiKLSNScoulemwXd4xWKK6IcEb3iEsXZXFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wup2vosj; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772698181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn2OPtnXRSQsQ1Z46aFxLdCwe5jcVGJR1jtLPB+L6jA=;
	b=Wup2vosjFdhcxPxbfQbzoZhKBDE9FQhugHA39DNP9+cokI9LwYAx2pYB/+6cz/+GgV7iP2
	TaMHBKBHhsXunhKNht5rfthZJqsUuIDxuSU+clMt5I3xKo4icOXgO2/Z6dsC+KZpxxQB2X
	+Vw1eN4qJdPSAji8MihO8oSoEbb6Ylk=
Date: Thu, 05 Mar 2026 08:09:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <fef6bae161f319a188b5b6f157b33498a463e3e6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] net: sched: cls_u32: Avoid memcpy()
 false-positive warning in u32_init_knode()
To: netdev@vger.kernel.org
Cc: "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com, "Jamal Hadi Salim"
 <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Kees Cook" <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260305073343.250702-1-jiayuan.chen@linux.dev>
References: <20260305073343.250702-1-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6770320D3AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264215-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,d5ace703ed883df56e42];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shopee.com:email]
X-Rspamd-Action: no action

March 5, 2026 at 15:33, "Jiayuan Chen" <jiayuan.chen@linux.dev mailto:jia=
yuan.chen@linux.dev?to=3D%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linux.d=
ev%3E > wrote:


>=20
>=20From: Jiayuan Chen <jiayuan.chen@shopee.com>
>=20
>=20Syzbot reported a warning in u32_init_knode() [1].
>=20
>=20Similar to commit 7cba18332e36 ("net: sched: cls_u32: Avoid memcpy()
> false-positive warning") which addressed the same issue in u32_change()=
,
> use unsafe_memcpy() in u32_init_knode() to work around the compiler's
> inability to see into composite flexible array structs.
>=20
>=20This silences the false-positive reported by syzbot:
>=20
>=20 memcpy: detected field-spanning write (size 32) of single field
>  "&new->sel" at net/sched/cls_u32.c:855 (size 16)
>=20
>=20Since the memory is correctly allocated with kzalloc_flex() using
> s->nkeys, this is purely a false positive and does not need a Fixes tag=
.
>=20
>=20[1] https://syzkaller.appspot.com/bug?extid=3Dd5ace703ed883df56e42
>=20
>=20Reported-by: syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69a811b9.a70a0220.b118c.0019.GAE@go=
ogle.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Made-with: Cursor
> ---
>  net/sched/cls_u32.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
>=20diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 9241c025aa74..8f30cc82181d 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -852,7 +852,10 @@ static struct tc_u_knode *u32_init_knode(struct ne=
t *net, struct tcf_proto *tp,
>  /* Similarly success statistics must be moved as pointers */
>  new->pcpu_success =3D n->pcpu_success;
>  #endif
> - memcpy(&new->sel, s, struct_size(s, keys, s->nkeys));
> + unsafe_memcpy(&new->sel, s, struct_size(s, keys, s->nkeys),
> + /* A composite flex-array structure destination,
> + * which was correctly sized with kzalloc_flex(),
> + * above. */);



I'm thinking whether it's more appropriate:

new->sel.hdr =3D s->hdr;
memcpy(new->sel.keys, s->keys, flex_array_size(s, keys, s->nkeys));

>  if (tcf_exts_init(&new->exts, net, TCA_U32_ACT, TCA_U32_POLICE)) {
>  kfree(new);
> --=20
>=202.43.0
>

