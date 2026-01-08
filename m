Return-Path: <netdev+bounces-248276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F410D065A9
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 22:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFE103038F61
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9023F33D4FE;
	Thu,  8 Jan 2026 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqQXkztT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2C329C6A
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767908618; cv=none; b=g1eEj24qfknH2di486tnJm7K8Ld1PgPGUy+SzdUBX9WhtN5+JEQZmImNoJ7Guw/3uEEDbi4+kt5P4w33pfrdf0nl7m8EKY+M2OJIyv3wht172dR8v4q60DA6a7guL++aa+maeROCtdRIRS7MDj30ZW9Ap2w1BitkYRtpSeE2Elo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767908618; c=relaxed/simple;
	bh=fmxiSBWVDk1vJjcA2pz8P8m02hTWUbmVu5dfvA2DDi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g39e+yYwq8msTzHYxApVteFEr4BurJggXJzchgYSPkpWB3RV6mvGtZntvEgbQKyRjufOfW5eE4Rbztj0AdKfi5e4D5GJ1GvHkymqP+SuRkoaFiJBZJCJwKanuItLJlAUXaiIUxBFHhkqwSxa5l2nhoH4yRd4/6a16EyVGjabsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqQXkztT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-432d256c2e6so745269f8f.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 13:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767908615; x=1768513415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pu0wRyydytWJO9gvWuImfkZVNSnne90b1xi/m4393gs=;
        b=nqQXkztTmSEomYLFSh329y/AlShbA9NaAJEUCnEc9+AiTOwsqJdRg0FGWSh/jlpz5Q
         t+MXwy18ElAaAr6YxDB+5Ojvv3Xe4dKxvrvo1N5gl6gNkPSjFC2S1aYSP6fxWf5h3Of4
         +haFSr0tK375kA8s4hCNHNj1gWYnOOjT5H7yxAVUTMDJpoIruHOpRLXYTg/fuGgHE7Fa
         hPp89zApGbG0YjFlfywPDfuoox7b8dosCFQctdkrVBB1Y252+1uVo+VGh8FQ9/XTd9wO
         pG9m0gOuoRWHlExDA9qQN0AsIPPOBeR8rHsZ6lcUYNqMi/nHI0srMbnucpnXCSzpitfo
         jcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767908615; x=1768513415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pu0wRyydytWJO9gvWuImfkZVNSnne90b1xi/m4393gs=;
        b=BrLhXxLPEvBJlJh9vAF27KG0jECir3oJr2a0fDEMQW2+v3O6P1+Yfi13R52Jh2nH9X
         a4/cOlx/Pixqs0Mqr4ztr36qlAt16Rkwufse46Emq/x9PLU/K+/Dpbx95rb5wvaQkR25
         6+bzIL5irq9h5ezi7GGsUFXYJ0gaClJ/+Das3J8Om7c4Ej3/nI++6PggBXoAgk9P38KA
         8EuVXKRP/pY8l1Tqcmk/S6Y7H4a5RSs6EG5AzccCv60Ci/dmPPfO+8BG4NL3id0G8llD
         ljTjsp+o54iuqV1vPW3VYjpeHRnY8aL79h5f+2J33wtmwS4ZDxSr1AoJOe51pP0vdvEJ
         kt3A==
X-Forwarded-Encrypted: i=1; AJvYcCXqaXlAJSegPjlEhVSrsyey8jvQoitd5vNhYleJxGKSbpOhMFk8LBXpUGASIhdEVvB7OV9hGCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsW0XkLUhObEcxjKT//x6Exs4BfDIQ9O+B46oc5R8Ucaj8TKh3
	rdRIPk5V7PuupobWCFKdRALLqp4FbtCiscAnBvMWkZtWZ6tR9Qlep/MgF3Cl/FWjGlEHSzzTASH
	wh2H/k7bRTrhJQGeAJTpGu33PhLxbVfc=
X-Gm-Gg: AY/fxX47W8+WTPACulOFEG5KguJ4qoSQ4kNUbidw9tVuM649vsJoWE9HG1PE/pA8v5b
	n5/iuqwtRf1aQCUCECsox5JoSOUpzR0E34xnVmb/Zd2G5SDwTEm7VUTg09XIRXSWR+7kPviIMyJ
	kI/7A7MYXcqcH+gMfbMdwPdW9bGM1D2GagTNcsoRXwr6K4IjLg191xXAgzGVAUn4Qt5FyZ+X6ye
	yp4KUVhE1gE2cpyHBkYZSQpdPNdId0OvTtl5EaRc7dC9J+ndTvGu7t+K0w6BYonriiVnVOc/ix8
	WPbbVmLAaGeNaoXYAIlaciQGoId1
X-Google-Smtp-Source: AGHT+IFj++Ne6lFRwroGe93rzSv2rM0ga2g/nqL8gz/t2f87BXA6Eu+2upiiNQZhGZGwpLyAs/n6YhkCeEt+NDvKfoE=
X-Received: by 2002:a05:6000:2384:b0:42b:4185:e58a with SMTP id
 ffacd0b85a97d-432c37758c0mr9257435f8f.14.1767908614642; Thu, 08 Jan 2026
 13:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQ+oMVuUjZi0MtGf52P3Xg9p4RBFarwZ_PiLWMAu+hU=rg@mail.gmail.com>
 <tencent_1F9A6FB02D856F9C9550E80AEC3ECD30790A@qq.com>
In-Reply-To: <tencent_1F9A6FB02D856F9C9550E80AEC3ECD30790A@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Jan 2026 13:43:23 -0800
X-Gm-Features: AQt7F2qeSyjzelCPrIW0p6Y5Qfeyox0gxojkeuDYLifeWUIgRe0ilKPfAzDldSA
Message-ID: <CAADnVQJrrWL-YvUqsfJJHzrTYUpnm9HTSJQp8g3Dyor6=doEKQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Format string can't be empty
To: Edward Adam Davis <eadavis@qq.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzbot+2c29addf92581b410079@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:52=E2=80=AFPM Edward Adam Davis <eadavis@qq.com> w=
rote:
>
> On Wed, 7 Jan 2026 19:02:37 -0800, Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index db72b96f9c8c..88da2d0e634c 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -827,7 +827,7 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_=
size, const u64 *raw_args,
> > >         char fmt_ptype, cur_ip[16], ip_spec[] =3D "%pXX";
> > >
> > >         fmt_end =3D strnchr(fmt, fmt_size, 0);
> > > -       if (!fmt_end)
> > > +       if (!fmt_end || fmt_end =3D=3D fmt)
> > >                 return -EINVAL;
> >
> > I don't think you root caused it correctly.
> > The better fix and analysis:
> I am keeping my analysis and patch.
> The root cause of the problem is that the format string does not contain
> a null terminator ('\0').
> Filtering out map type 0x22 to solve the problem is too hasty, as it
> would prevent all instructions from calling functions with constant
> string arguments.

If you think it's still possible to construct a program that
passes empty const string into this helper then please craft
a selftest that demonstrates that.

