Return-Path: <netdev+bounces-261339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMgbFFdDoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:57:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C81A5FAB
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E7E3302641E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C92DB785;
	Thu, 26 Feb 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g/+ySRV1"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182A2DA749
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110671; cv=none; b=eBBPbMDy1Svvll2Ias/r73d8h/1Z58PtC2fod/GDurC0m3ffRT4UPLIRTqIeLHamm4LQHidelIuiqUkxVCnXzWPEuKPkcMfYHPmoo7CiO0wY7pTRh+SObHDunRKcWQtJ0IC0w1z7qqUQpdkwDpdhl8KWJovqYI2TdFNfwYSshWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110671; c=relaxed/simple;
	bh=irALN3T00J/ivDQLCP39g36pjWOy4DCRCyKbVN7mMrg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=EMrZJv8bd7A6twnCCRbO3qKiHejov8f5xzLpMba/4fQ7o5S2cYx4mI+u2vK9PM33d1NZ6QJoeJKQE/G3r0Oy6gmr3glsKGIxOh7pPPrf1Xz9c4Ic1njuFNHe6qKJ8SqgYopLBnVIxwXti46KVFbWPGW+k4LCPZtZpkQdTbv9g3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g/+ySRV1; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772110667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FgOOpgkX5YNsXP5gZs5nXmJh9pEodVW2WxIYRj4mQco=;
	b=g/+ySRV1eAXyikJbUGR3VHGIeTxIkRP1iHT+bzH+IOxWL1hOEM/HkUzKfba7j03cAKrbrh
	xlNCyva3xY50y7hGUpQ0VQhnNmNMOe8EpUq+VtuU3BFfK8Zg0TG3/5HRInEvGL4k6IQwJS
	OaKMPhtfNezz5++P5hn7+V4iAGFVJBU=
Date: Thu, 26 Feb 2026 12:57:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <77167c3125d7db5daa958c30e24e87dae308d7b6@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf v1 1/2] net/bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "KP Singh" <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri
 Olsa" <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Jussi Maki" <joamaki@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260226095859.hLxDgGdn@linutronix.de>
References: <20260224112545.37888-1-jiayuan.chen@linux.dev>
 <20260224112545.37888-2-jiayuan.chen@linux.dev>
 <20260226095859.hLxDgGdn@linutronix.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261339-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,syzkaller.appspotmail.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 6A4C81A5FAB
X-Rspamd-Action: no action

2026/2/26 17:58, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de mailt=
o:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%22%20%3Cbig=
easy%40linutronix.de%3E > wrote:


>=20
>=20On 2026-02-24 19:25:41 [+0800], Jiayuan Chen wrote:
>=20
>=20>=20
>=20> --- a/net/core/filter.c
> >  +++ b/net/core/filter.c
> >  @@ -4387,6 +4387,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> >  struct net_device *master, *slave;
> >=20=20
>=20>  master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> >  + if (unlikely(!master || !netif_running(master)))
> >  + return XDP_TX;
> >  +
> >=20
>=20I'm not sure this check belongs here as this is not bond specific, is
> it? Also nothing stops the admin to put the device right after the
> netif_running() check so it fails later but the race window is not as
> wide as it is now.
>=20
>=20The per-CPU memory could be allocated while the bond device is create=
d.
> I don't think delaying it until "device up" brings any advantages.
> One creates the device with the intention to use it so the "up" is
> inevitable.
> The bond_xmit_get_slave() callback has the same logic. Couldn't this
> scenario also occur to the ->ndo_get_xmit_slave() user?
>=20
>=20>=20
>=20> slave =3D master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
> >  if (slave && slave !=3D xdp->rxq->dev) {
> >  /* The target device is different from the receiving device, so
> >=20
>=20Sebastian
>

I agree with your points, especially allocating
rr_tx_counter unconditionally at device creation time in bond_setup().

This eliminates the NULL possibility from the root, fixes both the
ndo_xdp_get_xmit_slave and ndo_get_xmit_slave paths, and keeps the
change within the bonding subsystem.

I'll wait a bit to collect more feedback before sending a v2.

