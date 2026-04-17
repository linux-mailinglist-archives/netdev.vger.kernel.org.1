Return-Path: <netdev+bounces-279200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q4f+D3SO4WlQuwAAu9opvQ
	(envelope-from <netdev+bounces-279200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 03:35:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8708541601E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 03:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9C6C301DE3C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 01:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00623D283;
	Fri, 17 Apr 2026 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oHAfSeBf"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A71C5F1B
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776389744; cv=none; b=pb4ddx3LhQdW/Fd9FdJ2Ttm01zLgZvnikpoObmL/u+Lbf0NqXSCFyTA/a2KYjWY87KIYm8KuU8im0J7DBn1XcPxyMgOm8tXizQ3T3aM75RON76QUrAkY5LBSWtT3DDV1wZfLQBVjt4QV3iNysDReLi2gs3lY4Tt9wrXiUyOYOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776389744; c=relaxed/simple;
	bh=m38mPK3/TMPhsgDXtdOvPcXA0HU7wBjC8sj+T52RtZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DII0r3fuRpC3TVGRLChK9u3P/e0mCxpl9vjfmNpHBVxMZ4BBMyaKLhMHVWSopTptozxCum7Q8tLyMepVISsjl7PElEyggNWlvB7pKLQ+H0o9YQnWyMak8gXXX08+rnheyXExAl7MyJDlBQ2etuIAi1s/7SradqTFO8n+3+e/y3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oHAfSeBf; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1b20180cc6127b990e5f83face4ca77bab49e89.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776389740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H5hQUEnmKlUw/TUQjD2ettr9nUmryS/LkDIj0eKGB0=;
	b=oHAfSeBftXqqpxbqcuiRD/KV24YEMdiSmn0zwFaForJy/YWCgekFMyLxz2a51aclr3v/dw
	GbOzU0ZiLKhoTD89mvRb1NsIm7mPB1k3Vac2LOar2GQgfwOXR4yb84QkF/uHqac8o1boHX
	VNCd2ToqxZe02ZVha0wf7SFsnRjZFhA=
Subject: Re: [PATCH bpf v2 1/2] bpf: Reject TCP_NODELAY in TCP header option
 callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,  shuah@kernel.org,
 jiayuan.chen@linux.dev, bpf@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org, Quan Sun
 <2022090917019@std.uestc.edu.cn>,  Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan
 Mei <M202472210@hust.edu.cn>
Date: Fri, 17 Apr 2026 09:35:14 +0800
In-Reply-To: <2026416172759.GIuu.martin.lau@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
	 <20260416112308.1820332-2-kafai.wan@linux.dev>
	 <2026416172759.GIuu.martin.lau@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279200-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org,std.uestc.edu.cn,hust.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8708541601E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-16 at 10:35 -0700, Martin KaFai Lau wrote:
> On Thu, Apr 16, 2026 at 07:23:07PM +0800, KaFai Wan wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fcfcb72663ca..911ff04bca5a 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5833,6 +5833,11 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_s=
ock_ops_kern *, bpf_sock,
> > =C2=A0	if (!is_locked_tcp_sock_ops(bpf_sock))
> > =C2=A0		return -EOPNOTSUPP;
> > =C2=A0
> > +	if ((bpf_sock->op =3D=3D BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 bpf_sock->op =3D=3D BPF_SOCK_OPS_WRITE_HDR_O=
PT_CB) &&
> > +	=C2=A0=C2=A0=C2=A0 IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&=
 optname =3D=3D TCP_NODELAY)
>=20
> IS_ENABLED(CONFIG_INET) is unnecessary.

ok, will remove in next version.
>=20
> pw-bot: cr
>=20
> > +		return -EOPNOTSUPP;
> > +
> > =C2=A0	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, opt=
len);
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.43.0
> >=20

--=20
Thanks,
KaFai

