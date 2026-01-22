Return-Path: <netdev+bounces-252141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGapK9qJcWk1IAAAu9opvQ
	(envelope-from <netdev+bounces-252141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:22:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D3A60D72
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A1CE443EB3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134838A2B5;
	Thu, 22 Jan 2026 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KGkGdzjL"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82B366DD3;
	Thu, 22 Jan 2026 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769048354; cv=none; b=f1fekd09wVE2IdcQVsXhwUzI9UKlVDy38GC7c8RenrjvLOXIwRkT1zDl8JR+bp3+AGzweoDtMP2dFIfgkjgvibWYQJVzCATHtpDyoSVU9zwbilcNFmJ5C+L5yZlTeQiYVe7gASS7REvnhKBGNLdL8BWhceW7d6rtrBbSjtZH6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769048354; c=relaxed/simple;
	bh=Kvn6VPfyD/U0mLjZB0Ft/G5z91RGUm4tOb8c3bUKP3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxTr5uzETe1sGiWheOWcamesGvEBurl0oJNL6DWM1ObBHqitSDVZdf8Uqg3FcBog23rYXnenELcIm1fHOlJ1h76eyT7jKEX0++pZDs7gICwLvhPg/U+SWBe40FRmrcChY467Qj0kOxvq4W2cijdwlbxMs4S0agM9JgBq6vZN32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KGkGdzjL; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769048350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXqqueVFqtnCEm0tFpdWrG/4leUbjtc2Mx6W7HQQM9w=;
	b=KGkGdzjL24/fn4Id8ci30l2I+FfV8nFO2gH9jZS3UKYsxnzJrO1rqimdIB80ZZc/e16JE0
	NaxHnTcyJOaoy9R3LH4PdFVL/0p9ZBMMB0Q36kNiwh5T4ysfQ4PRipvv1hoLDE7/c/5iUP
	Y9IntE6xmVO5Y97Bbx7skTbPI+iwCvc=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v10 11/12] selftests/bpf: add testcases for fsession
 cookie
Date: Thu, 22 Jan 2026 10:18:58 +0800
Message-ID: <2814828.mvXUDI8C0e@7940hx>
In-Reply-To:
 <CAEf4BzYbzSf_jXwFxni0viHRHhYQ=k=Ggq79S=FRNmxQGdcS1w@mail.gmail.com>
References:
 <20260115112246.221082-1-dongml2@chinatelecom.cn>
 <20260115112246.221082-12-dongml2@chinatelecom.cn>
 <CAEf4BzYbzSf_jXwFxni0viHRHhYQ=k=Ggq79S=FRNmxQGdcS1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252141-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 63D3A60D72
X-Rspamd-Action: no action

On 2026/1/22 08:07 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Thu, Jan 15, 2026 at 3:24=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Test session cookie for fsession. Multiple fsession BPF progs is attach=
ed
> > to bpf_fentry_test1() and session cookie is read and write in the
> > testcase.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v3:
> > - restructure the testcase by combine the testcases for session cookie =
and
> >   get_func_ip into one patch
> > ---
> >  .../selftests/bpf/progs/fsession_test.c       | 53 +++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/=
testing/selftests/bpf/progs/fsession_test.c
> > index f504984d42f2..4e55ca67db46 100644
> > --- a/tools/testing/selftests/bpf/progs/fsession_test.c
> > +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> > @@ -108,3 +108,56 @@ int BPF_PROG(test6, int a)
> >                 test6_entry_result =3D (const void *) addr =3D=3D &bpf_=
fentry_test1;
> >         return 0;
> >  }
> > +
> > +__u64 test7_entry_ok =3D 0;
> > +__u64 test7_exit_ok =3D 0;
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test7, int a)
> > +{
> > +       __u64 *cookie =3D bpf_session_cookie(ctx);
> > +
> > +       if (!bpf_session_is_return(ctx)) {
> > +               *cookie =3D 0xAAAABBBBCCCCDDDDull;
> > +               test7_entry_ok =3D *cookie =3D=3D 0xAAAABBBBCCCCDDDDull;
>=20
> you are trying to double-check that writing into *cookie preserves the
> written value, is that right? Do we need volatile read here to ensure
> that compiler doesn't optimize this?

Yeah, you are right. READ_ONCE and WRITE_ONCE should be used
here. I'll use them next version.

Thanks!
Menglong Dong

>=20
> > +               return 0;
> > +       }
> > +
> > +       test7_exit_ok =3D *cookie =3D=3D 0xAAAABBBBCCCCDDDDull;
> > +       return 0;
> > +}
> > +
> > +__u64 test8_entry_ok =3D 0;
> > +__u64 test8_exit_ok =3D 0;
> > +
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test8, int a)
> > +{
> > +       __u64 *cookie =3D bpf_session_cookie(ctx);
> > +
> > +       if (!bpf_session_is_return(ctx)) {
> > +               *cookie =3D 0x1111222233334444ull;
> > +               test8_entry_ok =3D *cookie =3D=3D 0x1111222233334444ull;
> > +               return 0;
> > +       }
> > +
> > +       test8_exit_ok =3D *cookie =3D=3D 0x1111222233334444ull;
> > +       return 0;
> > +}
> > +
> > +__u64 test9_entry_result =3D 0;
> > +__u64 test9_exit_result =3D 0;
> > +
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test9, int a, int ret)
> > +{
> > +       __u64 *cookie =3D bpf_session_cookie(ctx);
> > +
> > +       if (!bpf_session_is_return(ctx)) {
> > +               test9_entry_result =3D a =3D=3D 1 && ret =3D=3D 0;
> > +               *cookie =3D 0x123456ULL;
> > +               return 0;
> > +       }
> > +
> > +       test9_exit_result =3D a =3D=3D 1 && ret =3D=3D 2 && *cookie =3D=
=3D 0x123456ULL;
> > +       return 0;
> > +}
> > --
> > 2.52.0
> >
>=20





