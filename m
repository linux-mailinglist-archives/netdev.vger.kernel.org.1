Return-Path: <netdev+bounces-248670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DD0D0CDEA
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 04:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D342301BEAE
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 03:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69531DF26E;
	Sat, 10 Jan 2026 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aN++cn0o"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8C219EB
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768016284; cv=none; b=ubUgreIsXoGSOwRzAPr/B2boc/Fqmo8vkgfEM3GrNqjJ7gYSYSaQo4UI6mne8qcPQfW29s4KYcBM7d7+aylCUZsA7EEPLdk91fyBxvkErU3Eie/HvwW/lmHNvh+B1B79DJzMnRUrLBYo05TIWM6IzrzHvYY2Z9X6cPal3dqE2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768016284; c=relaxed/simple;
	bh=rbIr3G/sW7tRGoNZ+lF0F2oYqivDF8mzxOqrDuVr/88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDRpjpHaHbRSD6vJK7Q/0ti2+wVk1UeXDhNc5WLsh5EtZvaa1E/CbNm4NeGYw49plxSYYWH3FqefsyUfTVYYWq9KRQ8hVgWBShA+rH1FarqTOZ4b88lqxDXQMvb7Wx2pluKFP3OxpYLXrp/xnUdra/Dmd8byvQ9KiklqDNwAKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aN++cn0o; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768016280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72prxwM+ojfoTekETnLlr6xQXFg53cmyt9vRtB4B73k=;
	b=aN++cn0otad3+7YNgPtpf0lvNpW7gJJ0oMPXzKHu4GUOuhen3cS4UWUJL0Z6MNoBt/OSk+
	kPJe3RItRF5CtzB15jURXpbkgfkOZUHZ/lQbTAHu0oH+0J29LFdmIv/OSUka/F+E2T4Toh
	famgV50J0xEwONJg6nubm97gPWpQL1g=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
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
Date: Sat, 10 Jan 2026 11:37:36 +0800
Message-ID: <5075208.31r3eYUQgx@7950hx>
In-Reply-To:
 <CAADnVQLj4c-nc6gLbBiaT24KXWEpG3AzFT=P1tszu_akXhyD=Q@mail.gmail.com>
References:
 <20260108022450.88086-1-dongml2@chinatelecom.cn>
 <20260108022450.88086-5-dongml2@chinatelecom.cn>
 <CAADnVQLj4c-nc6gLbBiaT24KXWEpG3AzFT=P1tszu_akXhyD=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/10 10:40, Alexei Starovoitov wrote:
> On Wed, Jan 7, 2026 at 6:25=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > +       } else if (func_id =3D=3D special_kfunc_list[KF_bpf_session_is_=
return]) {
> > +               if (prog->expected_attach_type =3D=3D BPF_TRACE_FSESSIO=
N)
> > +                       addr =3D (unsigned long)bpf_fsession_is_return;
>=20
> ...
>=20
> > +bool bpf_fsession_is_return(void *ctx)
> > +{
> > +       /* This helper call is inlined by verifier. */
> > +       return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> > +}
> > +
>=20
> Why do this specialization and introduce a global function
> that will never be called, since it will be inlined anyway?

Ah, the specialization and the definition of the global function
is not unnecessary. I thought that it's kinda fallback solution
that we define the function even if it is inlined by the verifier.

>=20
> Remove the first hunk and make the 2nd a comment instead of a real functi=
on?

Agree. So it will be:

+static bool bpf_fsession_is_return(void *ctx)
+{
+       /* This helper call is implemented and inlined by the verifier, and=
 the logic is:
+         *   return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
+         */
+        return false;
+}

>=20
>=20





