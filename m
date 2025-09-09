Return-Path: <netdev+bounces-221018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6497B49E5B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A3D4E55CD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01B20DD72;
	Tue,  9 Sep 2025 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXVUmUd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF62E41E
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379351; cv=none; b=n0wco9vmf6Mf1YxG/wcCouK63kkxLDKIhwQ2HuUffBYv1DlZg1li2ut3udvumyl9mcAB3K1LIS9Z1CQj/d/giDnikrPHgSfimxstdyBFGJeE+MjQ0Nu5QkXoYvJfsS/X9TQ0zg+yon7cCrJgtgdXQVC+sp7Ra2jV6ecbTa5ucvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379351; c=relaxed/simple;
	bh=yYo7IzJbU6Z6mx7RODDFYoPjW98xKDBaTEKzFt7LVPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRckSZySvp9aaopzLLXd/eg2eZT8ukbJMgaxkA1/mnFURlwMrN3jowf1Z7rn5uWaPjRJWmXJ3jerlophoKUWoiAz38co/Ru8C7QG2BnNgd7EGbXwksqh4KcL7+NwR3nB4siQB3Mi6sNqiGfe30mtCYLXHF5rd2eyZWgA/aNc0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXVUmUd4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2570bf6050bso11036555ad.2
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757379349; x=1757984149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cJBxAEvachaOK44sfQK1ayR3C7n/EK/ryGUnykQsow=;
        b=IXVUmUd4Iv6z53FbCOFMvuE5jBVFJmay2QylI8V4LvX8LUNySQijxt4QjeG38NDC3O
         1T+VOH8efBS3piyReglAWKgf67Yw+mDUNvaDTOBd+i74g8170AxFCSHe2CwKgHnUOmMK
         xO7kAieCAJLR8VfaxQlE5W17RT3zT/0IGrn/EKspulk3xyPB8PEbwBGDouj1v96Sffd1
         avlXwKp0ZQ9f5XYP9eCkKzg/xFNoXN39Q+hx6z4WcVvZjW2h6SF4v6c0K4sqjYq+Uvx3
         sN78BBjlQpgJjGxgPRKDBanGl6Jz2/LyuAwCsZe3+XJXn16hFUOisZokWyTWNfkKAKLi
         dGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379349; x=1757984149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cJBxAEvachaOK44sfQK1ayR3C7n/EK/ryGUnykQsow=;
        b=pVfu7/4D1s2O4Av/CIGKh3GO9MvnUi/oBSaJnRA3VpyojWur2wteeMv0XpHCNsL0Cu
         wxwb0qjSyZJeAuFpHltkXikFb5sfKbop7bX8TUYeiQgDVYS+SVJbxpoA7gsMH1ibWH0+
         JX/jY9vfEECso6osqnYOUNk+a7A8IZbtaSsIznSc7wtFnOpCFrHhTfgU25O0QlZWrYlG
         jLanm2hPYhAzKNco/IvehFx+YZp111CHM4+j2dcRBDtqlWvZNp5yz4NZC+kjUPdjki6q
         AKeMcs7Tx2Je7j3/gF6byEHKXlt6YV1jpJb0BHAplqk/P6bhb10S5zvY2OGVT3iEPVYO
         CI+g==
X-Forwarded-Encrypted: i=1; AJvYcCVA/qQax4/kLQuuiEhyxYlaGnEAq0aGdpndpZyjFDxnnnSxpmjaKrMAqKksdeqv14c2Bf1kJag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9Fg5hYtjdd+X1xYXRjW2RoxZRIPEYAIAnD/3wBiN1fhMUdZ2
	4KgugYb6ieRiJbTFSHFlUEPilFMdUew3RlbxM6YzcAMXXolImkjOE8TlFg0o4F3HJz8D8weqrqx
	kYZww1hhTxOx50Nw0VXNcGZhiqW8bdZctTjt1alCy
X-Gm-Gg: ASbGncsasH9hYAWCFhPY7f74Yw9/T1XpkfRErKDt1LASlGRm8fEjpZxl24uyMBfg9Wf
	p7+UrTVvKRpp01bCWpZ3Mygi9NmOcsK8yyKMQCJfaOlMgAruRfSEAdAN3JssT/l0XzKxSG57E7B
	FAZzoveyI0DnwalFYPfYEitXaOHkMx16yLd5eWNPmF9OiEhnvi5s46j/sGkQnC14PeBhA43/VC8
	io2HwgcAulmjKP34UpIgbMtzM2x82FeNlkfdv7RXuE48Y7HFJs=
X-Google-Smtp-Source: AGHT+IEe5vFzXTZoRUvMqOuRmHzLn12OaUZoPOT/hwkLqob1mpYmqc43GujGhTWLgDwZw16W77b5Y8QtWA5EWP21sJE=
X-Received: by 2002:a17:903:1a30:b0:24e:2b3d:bb08 with SMTP id
 d9443c01a7336-2516fbdd4c2mr119092605ad.20.1757379348947; Mon, 08 Sep 2025
 17:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908223750.3375376-1-kuniyu@google.com> <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
In-Reply-To: <hlxtpscuxjjzgsiom4yh6r7zj4vpiuibqod7mkvceqzabhqeba@zsybr6aadn3c>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Sep 2025 17:55:37 -0700
X-Gm-Features: Ac12FXyqQhG5nuTIx8tfds3pQmQ2VcQBVbSOrZvKYPalpd022CkZjOvgHEHN60A
Message-ID: <CAAVpQUC1tm+rYE07_5ur+x8eh0x7RZ2sR1PGHG9oRhdeAGBdrQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next/net 0/5] bpf: Allow decoupling memcg from sk->sk_prot->memory_allocated.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 4:47=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> Let me quickly give couple of high level comments.
>
> On Mon, Sep 08, 2025 at 10:34:34PM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) have their own memory accounting for
> > socket buffers and charge memory to global per-protocol counters such
> > as /proc/net/ipv4/tcp_mem.
> >
> > When running under a non-root cgroup,
>
> Remove this non-root cgroup as we may change in future to also associate
> with root memcg for stat purpose. In addition, we may switch sk pointing
> to objcg instead of memcg.

Makes sense.  Will remove the part.

>
> > this memory is also charged to
> > the memcg as sock in memory.stat.
> >
> > We do not need to pay costs for two orthogonal memory accounting
> > mechanisms.
> >
> > This series allows decoupling memcg from the global memory accounting
> > (memcg + tcp_mem -> memcg) if socket is configured as such by BPF prog.
> >
>
> I understand that you need fine grained control but I see more users
> interested in system level settings i.e. either through config, boot
> param or sysctl, let the user/admin disable protocol specific accounting
> if memcg is enabled.

Considering tcp/udp/sctp sockets are not created in the early
boot stage, I think sysctl would be enough and we don't need to
control the default value with a boot param (sysctl.conf would be
early enough).


>
> Please rename SK_BPF_MEMCG_SOCK_ISOLATED to something more appropriate.
> The isolated word is giving wrong impression. We want something which
> specify that the kernel is only doing memcg accounting and not protocol
> specific accounting for this socket. So, something like
> SK_BPF_MEMCG_ONLY make more sense.

Maybe _EXCLUSIVE would be a bit clearer ?

net.core.memcg_exclusive (sysctl)
SK_BPF_MEMCG_EXCLUSIVE

or much clearer but lengthy ones ?

net.core.memcg_no_per_protocol_account
SK_BPF_MEMCG_NO_PER_PROTOCOL_ACCOUNT

net.core.memcg_no_global_account
SK_BPF_MEMCG_NO_GLOBAL_ACCOUNT

I'm bad at naming.  Do you have any preference ?

