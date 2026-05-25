Return-Path: <netdev+bounces-291361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHWiDkltFGoTNQcAu9opvQ
	(envelope-from <netdev+bounces-291361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4CC5CC64C
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 202803002D0E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE6B2E7F3A;
	Mon, 25 May 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieKLrjcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E9329BD8C
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723575; cv=none; b=gYdcYG3JwW1RbXME0soGJGsF6CXQbfEHBCZnxBJjLZFiJhuGfru1xEuQFpPM2Jt4YpspTL3AMlEWjqyr802tYAYFWuYCVMUArix2SX3EOC+kednEx+mL6Fp2Vrj8nghMhGo54A4ByMMWVlU7JSTNd/nRBgLAuGrTb3tQ2fOdQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723575; c=relaxed/simple;
	bh=iBT1nuOs3faFSnYWj6SACREyHDpwpiFZwFvdRkUHwPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3Wi9lYLANbw7+3JITmnj6b3PmS/7GvM3EqgyA3aOLd0rQZNm2z0bUeWd2BA+Ck704I+0OK5s3o+Q5AIB6AFN513VXvmxVLx2qr+p6eWfG3LS+UzJzK/4oAWvGqTy/Pi41Leg8pxB11s23CdV+oAHmSzfQisFsAkK2tptjJT8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieKLrjcy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7D51F000E9;
	Mon, 25 May 2026 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723574;
	bh=T48BC/lMg0afV6Z98MwAGIxOs9OS5KsF2E+mZNy7oK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ieKLrjcyYcyD7Ul/1nB1a92DoMPERKBKov6VwdePhJE+xntkwb1yAE3zujGT4Ct9n
	 x4G8+ZWygphtrw9KYkIZQsY3PkaNmFdncGhF/l85295Qa1iw/LbtBwvmgS2Fslj2ET
	 L5YFc4wtLtYFwRia843F53RLVyRAHqwSxp7XnEn7JArgUYLMAl6jtJxpo1nUhVKhSG
	 S9euyl+028dNG8Az2wfneqYXVAAy/QlchF6beye/a6vf1iGQEYIC/azYBS3pVFDCpk
	 6LSpAsFK62g0fp0/DZz9l9nBml1PiGU9C/0RF2V4tGlD59IYYNi7Jl5TUlc3QbdEJw
	 RLlKMyKTcryjg==
Date: Mon, 25 May 2026 08:39:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260525083932.234f26df@kernel.org>
In-Reply-To: <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
	<20260521084640.683c1ee6@kernel.org>
	<CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
	<20260522084611.390fd0a6@kernel.org>
	<CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
	<CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
	<20260522175507.02b4fe83@kernel.org>
	<CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
	<CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
	<20260523094641.2bef6580@kernel.org>
	<CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	TAGGED_FROM(0.00)[bounces-291361-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2F4CC5CC64C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 12:57:08 -0400 Jamal Hadi Salim wrote:
> On Sat, May 23, 2026 at 12:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote: =20
>  [...] =20
>  [...] =20
> > >
> > > The other thing (i may be over thinking) with pskb_may_pull is: if the
> > > data is already linear (in a clone), wouldn't we corrupt the shared
> > > linear data of the clone? =20
> >
> > I said
> >
> >   for the portion of the problem that's "we are writing to frags"
> >
> > IOW not replacing the rest of the patch (assuming we care). =20
>=20
> So as an alternative to the piece i posted? i.e this:
>=20
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index 79921b8d89ba..8f0f84b50c85 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *=
skb,
>                 if (write_offset < 0) {
>                         if (skb_cow(skb, -write_offset))
>                                 goto bad;
> +                       if (write_offset + (int)sizeof(hdata) > 0) {
> +                               if (skb_ensure_writable(skb,
> +                                               min_t(int, skb->len,
> +                                                     write_offset + (int=
)sizeof(hdata))))
> +                                       goto bad;
> +                       }
>                 } else {
>                         if (unlikely(check_add_overflow(write_offset,
>                                                         (int)sizeof(hdata=
),

Yup! Even better.

