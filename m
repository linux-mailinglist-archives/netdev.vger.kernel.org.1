Return-Path: <netdev+bounces-257230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAOyMpm3hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:30:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0957F4A0F
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A5983006D7D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C22423A8A;
	Thu,  5 Feb 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Na/jxiNJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB642314D
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305406; cv=none; b=KZpcF55qZctYkzV/0ZcAI3/qytlOa1MZYkXbamrmgv54HxyAZG9mBTaN6Y5PbKGEwD0gwBLVHJFQSBQf/YrgB2VLL7aKhq8U0uLZPRNm1R7dCw0Z6OAXhCrvTKujkZdWXB3+YQfLjTIC6Ubq1fjTKyUQYoNXFhNlRzX0tO/vKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305406; c=relaxed/simple;
	bh=8ICOAF+Csaod43QLvuGoAGK2P4g7zOrVzra21zr8IhA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=HrPgBRDjzmmKngWN86e+kTHD+CzIp1BeW04YuwOjDWjiEVNSbSoIJOWJdWvY4tgNNHg9FEmiNXHBpsSHbXU6HpXNLFLM64UB9E4WO+bDzDC4O8Go4qCg6h570g9nz/kMASSBbfB9tHthTvnnAa6BIO264VMR9aCd6lCeK24hs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Na/jxiNJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770305404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pS4CwfUmLVVYEaGKTrnOmaVQ9A+Wa7bM5Pi55GufFW0=;
	b=Na/jxiNJtznifXn9ZUXypnXC16SRxV8wRbUzCvUBSUMKxbatRQGxCNjOjFhVKfWKL20nCK
	nm9ggxyOa7TyXniRaXq30ajaBKlCumyUFOReoRCMFdqTLMRJlFs5onok4QgJAYyaE80Y+9
	PJ1Fg+huopLWPqmI6BC1/sg8AYGxoIM=
Date: Thu, 05 Feb 2026 15:29:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <3864f233d228b86ea89f224e39ed77b05c298e54@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3] xfrm: fix ip_rt_bug race in icmp_route_lookup
 reverse path
To: "David Ahern" <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 linux-kernel@vger.kernel.org
In-Reply-To: <62b51184-cc76-42cc-beea-91b6e815132f@kernel.org>
References: <20260205070203.61560-1-jiayuan.chen@linux.dev>
 <62b51184-cc76-42cc-beea-91b6e815132f@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257230-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e738404dcd14b620923c];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: F0957F4A0F
X-Rspamd-Action: no action

2026/2/5 23:17, "David Ahern" <dsahern@kernel.org mailto:dsahern@kernel.o=
rg?to=3D%22David%20Ahern%22%20%3Cdsahern%40kernel.org%3E > =E5=86=99=E5=
=88=B0:


>=20
>=20On 2/5/26 12:02 AM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> >  index 4abbec2f47ef..35816ac749bc 100644
> >  --- a/net/ipv4/icmp.c
> >  +++ b/net/ipv4/icmp.c
> >  @@ -554,6 +554,22 @@ static struct rtable *icmp_route_lookup(struct =
net *net, struct flowi4 *fl4,
> >  /* steal dst entry from skb_in, don't drop refcnt */
> >  skb_dstref_steal(skb_in);
> >  skb_dstref_restore(skb_in, orefdst);
> >  +
> >  + /*
> >  + * At this point, fl4_dec.daddr should NOT be local (we
> >  + * checked fl4_dec.saddr above). However, a race condition
> >  + * may occur if the address is added to the interface
> >  + * concurrently. In that case, ip_route_input() returns a
> >  + * LOCAL route with dst.output=3Dip_rt_bug, which must not
> >  + * be used for output.
> >  + */
> >  + if (!err && rt2 && rt2->rt_type =3D=3D RTN_LOCAL) {
> >  + net_warn_ratelimited("detected local route for %pI4 "
> >  + "during ICMP sending, src %pI4\n",
> >  + &fl4_dec.daddr, &fl4_dec.saddr);
> >=20
>=20per Paolo comment on the previous revision of this patch, strings sho=
uld
> not be split across lines like this. It should be:
>=20
>=20net_warn_ratelimited("detected local route for %pI4 during ICMP sendi=
ng,
> src %pI4\n",


Sorry about that. I totally misunderstood Paolo's comment.

pw-bot: cr
> >=20
>=20> + dst_release(&rt2->dst);
> >  + err =3D -EINVAL;
> >  + }
> >  }
> >=20=20
>=20>  if (err)
> >
>

