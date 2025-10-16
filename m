Return-Path: <netdev+bounces-230188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D971BE5111
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06BEF3AF3F2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AA229B12;
	Thu, 16 Oct 2025 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya4K4XWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857422424E
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639540; cv=none; b=m/sb74R4Jykc0CF01/MtT0Fy3Y6eZX747v7If6zrST9ngJS8AYoapM+lytZCfWZmAV200wUvIfqB5Dvv1mBB9he0U3QGYD/EZrRDj3WGO9cl4bk1obWXiqkkXcV+2InWTx3HRoADPELS2x4eDl9tTWfEXzcjjQev6bbMJcdn7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639540; c=relaxed/simple;
	bh=MKSdRnBqJwdMO7zJ6/UsEKuD0cigdsWFoUtwS5oSvUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVehlb0/pEffPdHw0fUEznx90pVr8rJPClC5jytIZ7edtg08C7t4L9bRqsYiZtb0iO/57TAvbJ9qzQBEv3t44vM6AsB+QVQ0IDD87rmojMhMAPHKS+XGo3Fl0rU4YRYCLCgOc9JmMhLDUFI8nD37qZjmvCbpBKK/AzcbcXntXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya4K4XWY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7814273415cso10029827b3.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639538; x=1761244338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acBxxK74tPPhNWwsTEIja+sU470IYlwvL6xkl/qOZio=;
        b=Ya4K4XWY0xHWVyPwyHMNdcfts7sxIqwUbPp0By/08ejf3Bnlvphgi37oKvheX4gi6r
         p7GWqkNOfIrm0Ehtq9d/GN2KpdqExnlF8atBOowhWPeqUevtfObGwMmE6fsKjZP8PuMT
         RBOS2TyqGGMp0AUzGOUr1qeU6yK21MCH/8aoLf2kRrzZvj4wjjw7P9+gGo3jYm4DYZuM
         yF9t9XpYIa1b7xhiPrTpt4oJfOcqEiCIOMU0OVWZyshMvJX7gl8ZnsdpCRri6L5031eM
         oj7Q7Rg2sMTiifXXjmgQTNHkdxddMDuGMwKCCPD+UUsE9OKsBtT9ViodIHwq0xtBCgC4
         hS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639538; x=1761244338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acBxxK74tPPhNWwsTEIja+sU470IYlwvL6xkl/qOZio=;
        b=h2jClkgH8OYSEA9E9IZLnKCWYdXkWakOmp3SHexJJC242jpplAuyi6esPxWWVpxrT5
         PLLug6eYREkv2Hvk+7swmdxK8YC8mQmZhQJzj+zZJg+qf/sKK9LvYtd1D0hw5nPlVtP6
         lvX41GZQ0DCHi19XiuRwGgUB9UJeWFuB7hUKqwO3O8yP4ycErGkQFQ2qcoOqZo8AMwWT
         7v09AkQ7FHCz64UiLPb/r50T3amxGwClM1l6i5gStlnqUDM9LcDQdGJmld6XBPwNNc7S
         Knoo4Cd8bO9QrN3ImIbfrhSidHl3vpgifc9PK6W6UQ7dBkmNgrgZ+c5VidnL0ZlMrCsp
         XWKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEx3P8YOk/qaX/LY7OrsEkjiPTLTbd+0v/wW0e+RS8R2ipuTsvVof0HO1IgF6ktrfHdBcoyyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQxtU0DU4wBu/RiFLXyMRQBb5r5q2ROQQtwbHdJApV6+bCC6R
	9Sbz9Ek4HpJN3xFEmVAbGDvgBg/n2RgmXRDVMeXmvS1TOSJrDKYjTJdjIQtZFBfeBjU40vfBvrR
	H2IzBdopbBbB46S8loFSy+bdC1YmUlCc=
X-Gm-Gg: ASbGncsk5F/OFXxuE6AbPwB3ETyewD8mVmT+W7hym/SI4hvoXBrz51W7EeRSgTDH6vB
	Tfnzwk3ofzY0SN2ofJ4auCx6gF6zCADc6/K1b5rp5mpdTLeHFCk0jSLAhjWmDKj0cfytT8hgrfC
	dJV6Q7LyQVK5txM+bf2UEDqfXVROI9d79hr/Gen5prQrbwvgz/U95h+U7G+lYVoooDpwrYKLyrS
	0ZHSdgQPqmK/96gdOD8WOsa8OqeG0Qcs/P8Nm+TupUPkVLw7rPX511QbuwvGqchA/oS/H4BUBON
X-Google-Smtp-Source: AGHT+IFAtPPL+YAcDMa18gA92cHxrb6w0UrtbYIzo572pNcb5+PVb4Uwk98FWeCR+j1twci3L2Nf8wGY1O8rc7VeiK0=
X-Received: by 2002:a05:690e:150b:b0:63c:f70d:900 with SMTP id
 956f58d0204a3-63e1613dfe5mr1253403d50.28.1760639537533; Thu, 16 Oct 2025
 11:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-5-ameryhung@gmail.com>
 <CAEf4BzYVn=TQnF-Wfum=eQG0PsKwzySow+WFjon8D_1624ZnDA@mail.gmail.com>
In-Reply-To: <CAEf4BzYVn=TQnF-Wfum=eQG0PsKwzySow+WFjon8D_1624ZnDA@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 Oct 2025 11:32:05 -0700
X-Gm-Features: AS18NWCvO1zkh2AOpN4UkP8SaQs3ZFmLeKYHgwj2eBZDb36QE349J-AFzbNldY4
Message-ID: <CAMB2axN-4TH7+BDg7J9NhPWOw61qe43tYFRamhD4stdp9ZOyHw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 4/4] selftests/bpf: Test
 BPF_STRUCT_OPS_ASSOCIATE_PROG command
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 10, 2025 at 10:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > Test BPF_STRUCT_OPS_ASSOCIATE_PROG command that associates a BPF progra=
m
> > with a struct_ops. The test follows the same logic in commit
> > ba7000f1c360 ("selftests/bpf: Test multi_st_ops and calling kfuncs from
> > different programs"), but instead of using map id to identify a specifi=
c
> > struct_ops this test uses the new BPF command to associate a struct_ops
> > with a program.
> >
> > The test consists of two set of almost identical struct_ops maps and BP=
F
> > programs associated with the map. Their only difference is a unique val=
ue
> > returned by bpf_testmod_multi_st_ops::test_1().
> >
> > The test first loads the programs and associates them with struct_ops
> > maps. Then, the test exercises the BPF programs. They will in turn call
> > kfunc bpf_kfunc_multi_st_ops_test_1_prog_arg() to trigger test_1()
> > of the associated struct_ops map, and then check if the right unique
> > value is returned.
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  .../bpf/prog_tests/test_struct_ops_assoc.c    |  76 +++++++++++++
> >  .../selftests/bpf/progs/struct_ops_assoc.c    | 105 ++++++++++++++++++
> >  .../selftests/bpf/test_kmods/bpf_testmod.c    |  17 +++
> >  .../bpf/test_kmods/bpf_testmod_kfunc.h        |   1 +
> >  4 files changed, 199 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_=
ops_assoc.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_assoc.=
c
> >
>
> [...]
>
> > +/* Call test_1() of the associated struct_ops map */
> > +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, v=
oid *aux__prog)
> > +{
> > +       struct bpf_prog_aux *prog_aux =3D (struct bpf_prog_aux *)aux__p=
rog;
> > +       struct bpf_testmod_multi_st_ops *st_ops;
> > +       int ret =3D -1;
> > +
> > +       st_ops =3D (struct bpf_testmod_multi_st_ops *)prog_aux->st_ops_=
assoc;
>
> let's have internal helper API to fetch struct_ops association, this
> will give us a bit more freedom in handling various edge cases (like
> the poisoning I mentioned)

I will poison st_ops_assoc when struct_ops programs get reused and add
an API to access this field.


>
>
> > +       if (st_ops)
> > +               ret =3D st_ops->test_1(args);
> > +
> > +       return ret;
> > +}
> > +
> >  static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
> >  {
> >         struct bpf_testmod_multi_st_ops *st_ops =3D
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h=
 b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > index 4df6fa6a92cb..d40f4cddbd1e 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> > @@ -162,5 +162,6 @@ struct task_struct *bpf_kfunc_ret_rcu_test(void) __=
ksym;
> >  int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
> >
> >  int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __=
ksym;
> > +int bpf_kfunc_multi_st_ops_test_1_prog_arg(struct st_ops_args *args, v=
oid *aux__prog) __ksym;
> >
> >  #endif /* _BPF_TESTMOD_KFUNC_H */
> > --
> > 2.47.3
> >

