Return-Path: <netdev+bounces-219279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EC6B40DEA
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458E41B62F2F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28D2E5B05;
	Tue,  2 Sep 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrlbrY9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66EC2D6E4C
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841594; cv=none; b=e5Cq1qxvQ9s6CVye5wWMLd7m98OOU/PtJB73A+SlpzHrfn8innjiEBa21Rd9+/mdlnJpwJU4BKAWuiGSJZtEjws6Ph9/BNaQUWWoV0DlRFV7F4JNsS/46/LXOC6L404i2WNjZI3xb0TM2LjhxaV4eukEEsi3PexeiY97cFrl6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841594; c=relaxed/simple;
	bh=DZVG7cD3+F5INllVXM8wY5G9pLWUGigl6+7rZcEMjuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1KKmxROBVVGOv/sZvgiRM1ICl9kXt86Ypl76xeLQkDicWRV9JJ6nEp7JykcjzHHi8o6qaB6w9ZyD38S9k9gJ64DfrSrFxG+P7NjemnPpOxE+GbpZM3uJ5F1h4oWNC7ViucW6hOjay/lkdHI7A2t9tv3lnMa/mnaCyJg0sIXF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrlbrY9M; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso2710699a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 12:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756841592; x=1757446392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYwp8Zr2q1d600NBfnugsNcS1VrI9GFl0s1kI6DYjPE=;
        b=hrlbrY9MGsv5S5rE9ZawGGJ2p9+ExIT67I6FQfc3g3Mz4SYNWYGiKz6y7Tj5JeZeSg
         0sFquzi2WViyZDGhYatn035wCfv/dM0xhYVTkbxWA2PjFTr2R7jgNaPAiE0pEhRu3WqV
         aeC0QiY92qFD8+imZp9JqIoRdihqhCivAl6U0ZTlTTwL9s6K1ysafMGGoSs3DnhsKGD6
         Q8rRHnTZf2z/2I8wfw7VTearwiAPtQltEjDQo8svk8wV60lsIsUQ+GNFmHyoIW8W/HCa
         s2MBHxE3QPC1SFu8kA6JoM8R+n6mnaGRoQMhxL8eajHzEQK6Al9M2hMR15XwF3SH3TnC
         6RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756841592; x=1757446392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYwp8Zr2q1d600NBfnugsNcS1VrI9GFl0s1kI6DYjPE=;
        b=uqPCksIWIl6ULJ/wS4PsUDZwDfnAalkXBmmmrJKpYAYO7zjSasBL33CpU4TX7dVr0r
         Uz5nMwI9mBEHgVK0zYGLJQXi5JRNL6oDgZGcFhKUzvA51U2waXtbjeR7T8vu/8jeSakU
         Lmw87GsmiRQwBcHKOWgbdw7wSijQXPukMr8HiHAs2tdTqG1VeA8yfA7VkbDSYjJ5udSY
         c4Vl+B+8PiyclTvV8WB+FBLS0YPpNeP6qGp8/nQt5jCvm2WKuR8LpeazoLoQAVQy5vz4
         1lLlXGPG2g3zEHJWEjTKXNv05NaQLGIzB6WskCDqF0Ma+CZmtUsb5oPKK+am2gHnEU0Q
         GC/A==
X-Forwarded-Encrypted: i=1; AJvYcCUbE9eZl9kKCCdRg+LB0MtxFZWGz/NAwZ7iMlFVXLlMHZZR7Zey0+EWsi44ELgk1PE1et9WDkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKwIBnOMY3jy/AG6cRTHQ21jfQCMOxKlHLei27AD134jxsJIu
	HPVH7uglo1aPxxfXLG/Hh38MnU8kd2JMnZBT1j9OGRDpooUyqoTPzHco4FTcs2i84IxuI8Z3R3R
	vt/8+zTV25YS0imEuP7Zx4UZqqNW8TQxIwh+KZG/z
X-Gm-Gg: ASbGncs42gr+9LjaW2PciDMAgBzL4z7xe/J2kJh9fbT568SLfmwzv1hnXAnZOftw8HM
	ZlYN3lxvsNCSvGYd2TTuML1bBaFHWYMIxyQkJXJO/orarmTaU8NlOI1W/yDqrDuQ+W5zEYNpDH9
	0X+4+gxl0RMGvw7XpuZC8rGlEwcUjHD2stidEMLel2f3yARlHTSM3OyfelJjIUPa6FKZlzYqq90
	knIickRAPNpA16LDm2rVMFEXj2//9T94cXnORWquMwuFkRhJsb+CDRPZ5IO+zUpzsZDhxAbtK+n
	Cg==
X-Google-Smtp-Source: AGHT+IEATvy9q2b2V7CURED7FUCTkt0VWc77CBS1KVMeBeSUsRNGYkpjgAHH8burand5lFozqhssA7q8awK1+uH5zCs=
X-Received: by 2002:a17:903:46c3:b0:246:cf6a:f009 with SMTP id
 d9443c01a7336-24944b46499mr176478375ad.46.1756841591456; Tue, 02 Sep 2025
 12:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-3-kuniyu@google.com>
 <9bc995b4-d0bd-41a8-8867-97507a55d449@linux.dev>
In-Reply-To: <9bc995b4-d0bd-41a8-8867-97507a55d449@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 12:33:00 -0700
X-Gm-Features: Ac12FXzAhZBeB4p5Hn_96Y1BXB7W98FDKQSN1fHhXlm7f7jXYCMLYEKLpI72O7o
Message-ID: <CAAVpQUBzyT8t1c+8ukk93q_GQMXAxg4WX4fOo4iishJX4wKEkA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:10=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> > +BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level=
,
> > +        int, optname, char *, optval, int, optlen)
> > +{
> > +     return __bpf_setsockopt(sk, level, optname, optval, optlen);
> > +}
> > +
> > +static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto =
=3D {
>
> nit. There is a bpf_unlocked_"sk"_{get,set}sockopt_proto which its .func =
is also
> taking "struct sock *". This one is sock_create specific, how about renam=
ing it
> to bpf_sock_create_{get,set}sockopt_proto. The same for the its .func.

Sounds better to me :)
Will rename both.

>
>
> > +     .func           =3D bpf_unlocked_sock_setsockopt,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_CTX,
> > +     .arg2_type      =3D ARG_ANYTHING,
> > +     .arg3_type      =3D ARG_ANYTHING,
> > +     .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> > +     .arg5_type      =3D ARG_CONST_SIZE,
> > +};
> > +
> > +BPF_CALL_5(bpf_unlocked_sock_getsockopt, struct sock *, sk, int, level=
,
> > +        int, optname, char *, optval, int, optlen)
> > +{
> > +     return __bpf_getsockopt(sk, level, optname, optval, optlen);
> > +}
> > +
> > +static const struct bpf_func_proto bpf_unlocked_sock_getsockopt_proto =
=3D {
> > +     .func           =3D bpf_unlocked_sock_getsockopt,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_CTX,
> > +     .arg2_type      =3D ARG_ANYTHING,
> > +     .arg3_type      =3D ARG_ANYTHING,
> > +     .arg4_type      =3D ARG_PTR_TO_UNINIT_MEM,
> > +     .arg5_type      =3D ARG_CONST_SIZE,
> > +};
>

