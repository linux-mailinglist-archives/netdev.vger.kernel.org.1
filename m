Return-Path: <netdev+bounces-248676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBD3D0D086
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 07:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6A5D3026BFC
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 06:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6571824677D;
	Sat, 10 Jan 2026 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8AMfDgq"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC967258CE7
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768025835; cv=none; b=Qs84s2YhxwvudGQRQOtdbeKcR0VtrXeSqKP2q5lJ5J3hRPOc2kMv8z/FU7SyZ6Sxn9tG/t6aGP9eKrtOI/+7BPq4zEXdRRuJvZxJtszCdx5oEUX8GFK941UWh926j00jBsxvbGu8qMa+suerrUdiXv0hvBfQwW6tzIQuA80T798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768025835; c=relaxed/simple;
	bh=vOplLJEX9isv42WotdBVOkJgDNihHfjDD0O3L5H/tMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbKEBpHkAKkfJq3PgukdbbrCQroEEiQFWgTxedD8qf8zL4YGZkWCqhj1yWkjtrtBY1zIvJbOehjj4rP8bqER1uzeBluaaukm81/vJ9XrF0OTx40hvJ48iKd+1YanlvaLNO6sr9ys1A5tiWm02tIOgkHe8/l0fzvjaf32CVA4i6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8AMfDgq; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768025821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UJEhCFHRTbkOHjEzYSkqsIGSyEYidG74DyThTLA/jbs=;
	b=R8AMfDgqbes+l+8+nfCFf0uaorNU4r8p6SPeRm03Dinj8AewFOMkHKwj8ajbBFqNBtapoR
	UoBXgDBCwoOB/2RO9mXh09X7quIcO4YPVHzDMxckib+ym3ULowBhA0UXXz4LQivPrnC80H
	hQV2AVPm6A1h23I3WI7FQdRYSd2H69k=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v8 04/11] bpf: support fsession for bpf_session_is_return
Date: Sat, 10 Jan 2026 14:16:35 +0800
Message-ID: <2813099.mvXUDI8C0e@7950hx>
In-Reply-To:
 <CAADnVQJTc3qegim-hyzaurnCX-8pRQWoj+r9+0jgBQ-WmpLHuw@mail.gmail.com>
References:
 <20260108022450.88086-1-dongml2@chinatelecom.cn> <5075208.31r3eYUQgx@7950hx>
 <CAADnVQJTc3qegim-hyzaurnCX-8pRQWoj+r9+0jgBQ-WmpLHuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/10 14:05, Alexei Starovoitov wrote:
> On Fri, Jan 9, 2026 at 7:38=E2=80=AFPM Menglong Dong <menglong.dong@linux=
=2Edev> wrote:
> >
> >
> > >
> > > Remove the first hunk and make the 2nd a comment instead of a real fu=
nction?
> >
> > Agree. So it will be:
> >
> > +static bool bpf_fsession_is_return(void *ctx)
> > +{
> > +       /* This helper call is implemented and inlined by the verifier,=
 and the logic is:
> > +         *   return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN)=
);
> > +         */
> > +        return false;
> > +}
>=20
> No need to define an empty function.
> A comment next to 'inline-by-bpf-asm' part explaining what is going on
> will be enough.

Yeah, I see. I'll remove the whole part, and do some comment
in the verifier where I inline this function instead.

Thanks!
Menglong Dong

>=20





