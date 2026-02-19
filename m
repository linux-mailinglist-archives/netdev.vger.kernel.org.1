Return-Path: <netdev+bounces-259389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OKwIzBqlmnlewIAu9opvQ
	(envelope-from <netdev+bounces-259389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:41:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A9815B64F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 02:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BFC4302E790
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD21DF755;
	Thu, 19 Feb 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="buZARvjV"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836713B58A
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771465222; cv=none; b=vBfdvG0TSea5bR475RmAOsT51C4BHjKL4ZQZ3OUJa+/xhWjg5lyI2YHHzFyTDlvWwEdxq2YVlqhiHUHNSaxVPcQk+OLMgjsu/SgQGCek8xtFGr1OgTPMumg47l+JTaaRBlOnhcKacHc9nt6oKa5woPWLNbZQvK6fonRLelDmiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771465222; c=relaxed/simple;
	bh=edZH8GVjhcpoHyWTrz+AskdA2I//P81O54WF+KiRGYM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=JdzyBFJq5uc/TE06Y2Yl/2e71TTTIGbyQpExDKNcsHDEJs3Vw75aj6EGtmmhPOJWTwuoLgp9LBTGW8mkosFX8gJouKdZXzHYlDz0wRBLyEh7TI/ZvwyavRAXDH4fmXRqkW3lNDXGl+tPhK7zLip+1phCmC22vtZ4aYNS0d3k+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=buZARvjV; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771465207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rhlDgjQRcnJlZlAdvy1WgT+vLTyCB0qwPb81xHOXUU=;
	b=buZARvjVi8yPahboMH82huFElwmuB8/gjOKCy3Gz5qYGcjS8f+ua2DRvleV7YBXUCMhEDX
	CRj32TrG/+o7UulYGH6XQxmScyEpq2cxKuU/J8e36SF18Tik06UVkXkcBntQj+roWim9hP
	HPdTx1Q/cDbpZkt1Co9mxxDRP9aa8ss=
Date: Thu, 19 Feb 2026 01:40:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <1be04622bbdace30827f3588b2b721b478bc2c28@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] kcm: fix zero-frag skb in frag_list on partial
 sendmsg error
To: "Paolo Abeni" <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+52624bdfbf2746d37d70@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "Michal
 Luczaj" <mhal@rbox.co>, "Sven Stegemann" <sven@stegemann.de>, "Christian
 Brauner" <brauner@kernel.org>, "Tom Herbert" <tom@herbertland.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <404e29e1-a5b8-4d43-bde6-7409a8b00b57@redhat.com>
References: <20260213061232.338244-1-jiayuan.chen@linux.dev>
 <404e29e1-a5b8-4d43-bde6-7409a8b00b57@redhat.com>
X-Migadu-Flow: FLOW_OUT
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
	TAGGED_FROM(0.00)[bounces-259389-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,52624bdfbf2746d37d70];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6A9815B64F
X-Rspamd-Action: no action

2026/2/17 19:52, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.co=
m?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 2/13/26 7:12 AM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20=20
>=20>  Syzkaller reported a warning in kcm_write_msgs() when processing a
> >  message with a zero-fragment skb in the frag_list.
> >=20=20
>=20>  When kcm_sendmsg() fills MAX_SKB_FRAGS fragments in the current sk=
b,
> >  it allocates a new skb (tskb) and links it into the frag_list before
> >  copying data. If the copy subsequently fails (e.g. -EFAULT from
> >  user memory), tskb remains in the frag_list with zero fragments:
> >=20=20
>=20>  head skb (msg being assembled, NOT yet in sk_write_queue)
> >  +-----------+
> >  | frags[17] | (MAX_SKB_FRAGS, all filled with data)
> >  | frag_list-+--> tskb
> >  +-----------+ +----------+
> >  | frags[0] | (empty! copy failed before filling)
> >  +----------+
> >=20=20
>=20>  For SOCK_SEQPACKET with partial data already copied, the error pat=
h
> >  saves this message via partial_message for later completion. A
> >  subsequent zero-length write(fd, NULL, 0) implies MSG_EOR, which
> >  queues the message to sk_write_queue.
> >=20
>=20AI review noted that the above statement is dubious. Specifically,
> looking it looks like that write(fd, NULL, 0) implies EOR for SOCK_DGRA=
M
> packets:
>=20
>=20 int eor =3D (sock->type =3D=3D SOCK_DGRAM) ?
>  !(msg->msg_flags & MSG_MORE) : !!(msg->msg_flags & MSG_EOR);
>=20
>=20I guess the changelog needs some clarification.
>=20
>=20Thanks,
>=20
>=20Paolo
>

Thanks for pointing this out. I'll update the changelog to clarify that
for SOCK_SEQPACKET, sock_write_iter() automatically sets MSG_EOR
(net/socket.c:1189), which is what makes the subsequent write()
complete the message.

