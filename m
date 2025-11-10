Return-Path: <netdev+bounces-237226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83CC4799E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C6C4F0119
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D8A26461F;
	Mon, 10 Nov 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkRO7vFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D83258EF6
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789009; cv=none; b=MKwM9b6zhk7qV9ljMWGpxLFPm9SDCVgh+OGSUWC/Zi0EYL0rG3Mtak+kNDpr+aMgdzLQo34nxTheMt7lYyc9exbvXEVybTfFE9/nBrYbX8+XKHunJZZqGOepKGDKNUzWWqwsYxRPbiGtesP4NdmaOTBjP0yg3u0i3Q5iEFROLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789009; c=relaxed/simple;
	bh=qjFrJeuXnw7ptunoSmp7MEgn3dNjwmD1M3D3wk4xLs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/I6NUTUvZHM3Iwz1GJiXtDL1KzLxThfwAnHXG6zy7PkCafEGXl61ghv5EbvecF8WOONcN8ntxE10JHsZSSuS3F8jaOLaYspSnKkvprgpTHYEtX9qExbNwQdeSiXldhSWem2MtOKXVlaQrraVLIRyeqzjjH+XpSWaFZgc237xXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkRO7vFq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2953e415b27so27885535ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762789007; x=1763393807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6CM8ToVrphAYJlsPCEkc+EhncmxuAD5I1ziwDD4hRs=;
        b=ZkRO7vFqOEoNGjBg6c9JAOjBa4objZ0jGsCTVtC8M0Mz2C4RlYJdIZLJO41iHtYupq
         3IG3jhZ1Nm0YAi4phImZeFbu+kb7LIy6CL4ktJ2snXVddKuRUB9rL3fSgSZ1HybIFAzd
         OBH5ORr8SC26RfNFlRl98HzLNj/Quz8rUyP3CJomX9eJil06YRqZc8vXcpyxMUtKMAxA
         DHd1FCtU3R53iAoB9plhZ0ocE8muyqpjKMiv9Zc8/FTEp0ia1atXZVBU7EoY42Q9pMuY
         fe/3pLSzXS7GfFRrbQiS/5sTpMavpH6l4VxW++4AbldQzrjCPT9fDZbJ3/1hzxemkm9y
         R0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789007; x=1763393807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6CM8ToVrphAYJlsPCEkc+EhncmxuAD5I1ziwDD4hRs=;
        b=g7bR+2b/KZEXLTVTerdmF3jyy7BNdFGppKek0Mt3Atxlt+3ssa6y/q+McA3b6iHH04
         DFDFd3YlYMoj8boFEbHLCEoKixqBpS2Dq8XR6QOjLleCZbi6OIXuyMi84RXzWRxAZGfd
         cHuaLgts/1eWcmzaCOqhiGISQ3K6Ny8+vonABL8E9cSkRr5gqLWAuc+dnbCLa13zb/dj
         prqmkJXCH/XU6I80+T84KrSRM1WUXzo+kp12GHXLWSScGwRQ91nqIEmAoY+X2QhqSVAf
         etQiTaOWcMfMgaveGlkqdDS+YOKwoEHko7jF7aOKAUHocqvvHkxrfuVEUMunMN7YNuno
         OLVw==
X-Forwarded-Encrypted: i=1; AJvYcCUcJH6eV0DtkhWWfxuB6tDowFiOGArhjBB0BAc/qVRdGEZOlsVDRAEukcFDBfVqf6pnT2wWzbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddtqrQhp/JMSOUsmrVavmDJsMxB9qBPJ2/gV8XS2jAp7RQgSB
	d+3DABMpFPbcNU3sFIagrgdR4jfWETE29pLUGALqSlgmZssHu2SsSe5AFJsXNaMuO69beLBTL5I
	LPBMzJEMIfYCjG+Z3RtIA/N0h4ooe+vk=
X-Gm-Gg: ASbGncuoG13IOmiBUq1kFfLJ+g3PmLJNsnHdJ9FXXQIvjQBvv17t/U409+o/1v6hnkU
	HD0hoQXXA0fhdUWqKdQWNM/rXVPqmzOf1ehju7hzHvaQ0KmuATkG9p8BPWIFcnYToVNa/W92t9t
	6GbU6CJ5pNQ4BWCvvKVJuhST2Uerpp1yXJI1ZxMf6UmJFhPR3LPxVFaOl6gLhhzh+NnC7tUX81O
	sY8s2EQY3kbpwYSLnM6j3z26tPP23RO+W84VKzIRkQPRt2GGOxKtTGHmGr0l0ZhYH+3or+4tw6V
	4z0Ez+g18BoreNb99jIKgATYzuAp
X-Google-Smtp-Source: AGHT+IFBMX3Z6xR9CqsfUoZchOuDVArlgqrKSaeue9U4SAk3ab6q42pqdmgzlCF4OjTSRbLFwp4rkEAkjRALUBem3lw=
X-Received: by 2002:a17:902:dace:b0:297:e59c:63cc with SMTP id
 d9443c01a7336-297e59c644dmr115082615ad.35.1762789007489; Mon, 10 Nov 2025
 07:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106111054.3288127-1-edumazet@google.com>
In-Reply-To: <20251106111054.3288127-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Nov 2025 10:36:34 -0500
X-Gm-Features: AWmQ_bmxD6IbMC1I_4LlVCbXVjSMEwRyz0nCgyWdKg3kBNHzVCCd81TV7GMNB2U
Message-ID: <CADvbK_fZABufnbF9vsS_GZ6OgYfKb7nT3NDdT+iO-C7Rw9K6mw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: prevent possible shift-out-of-bounds in sctp_transport_update_rto
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 6:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> syzbot reported a possible shift-out-of-bounds [1]
>
> Blamed commit added rto_alpha_max and rto_beta_max set to 1000.
>
> It is unclear if some sctp users are setting very large rto_alpha
> and/or rto_beta.
>
> In order to prevent user regression, perform the test at run time.
>
> Also add READ_ONCE() annotations as sysctl values can change under us.
>
> [1]
>
> UBSAN: shift-out-of-bounds in net/sctp/transport.c:509:41
> shift exponent 64 is too large for 32-bit type 'unsigned int'
> CPU: 0 UID: 0 PID: 16704 Comm: syz.2.2320 Not tainted syzkaller #0 PREEMP=
T(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
>   ubsan_epilogue lib/ubsan.c:233 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x27f/0x420 lib/ubsan.c:494
>   sctp_transport_update_rto.cold+0x1c/0x34b net/sctp/transport.c:509
>   sctp_check_transmitted+0x11c4/0x1c30 net/sctp/outqueue.c:1502
>   sctp_outq_sack+0x4ef/0x1b20 net/sctp/outqueue.c:1338
>   sctp_cmd_process_sack net/sctp/sm_sideeffect.c:840 [inline]
>   sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1372 [inline]
>
> Fixes: b58537a1f562 ("net: sctp: fix permissions for rto_alpha and rto_be=
ta knobs")
> Reported-by: syzbot+f8c46c8b2b7f6e076e99@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/690c81ae.050a0220.3d0d33.014e.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  net/sctp/transport.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/net/sctp/transport.c b/net/sctp/transport.c
> index 0d48c61fe6adefc1a9c56ca1b8ab00072825d9e6..0c56d9673cc137e3f1a64311e=
79bd41db2cb1282 100644
> --- a/net/sctp/transport.c
> +++ b/net/sctp/transport.c
> @@ -486,6 +486,7 @@ void sctp_transport_update_rto(struct sctp_transport =
*tp, __u32 rtt)
>
>         if (tp->rttvar || tp->srtt) {
>                 struct net *net =3D tp->asoc->base.net;
> +               unsigned int rto_beta, rto_alpha;
>                 /* 6.3.1 C3) When a new RTT measurement R' is made, set
>                  * RTTVAR <- (1 - RTO.Beta) * RTTVAR + RTO.Beta * |SRTT -=
 R'|
>                  * SRTT <- (1 - RTO.Alpha) * SRTT + RTO.Alpha * R'
> @@ -497,10 +498,14 @@ void sctp_transport_update_rto(struct sctp_transpor=
t *tp, __u32 rtt)
>                  * For example, assuming the default value of RTO.Alpha o=
f
>                  * 1/8, rto_alpha would be expressed as 3.
>                  */
> -               tp->rttvar =3D tp->rttvar - (tp->rttvar >> net->sctp.rto_=
beta)
> -                       + (((__u32)abs((__s64)tp->srtt - (__s64)rtt)) >> =
net->sctp.rto_beta);
> -               tp->srtt =3D tp->srtt - (tp->srtt >> net->sctp.rto_alpha)
> -                       + (rtt >> net->sctp.rto_alpha);
> +               rto_beta =3D READ_ONCE(net->sctp.rto_beta);
> +               if (rto_beta < 32)
Wouldn't be better to do:

rto_beta =3D min(READ_ONCE(net->sctp.rto_beta), 31U); ?

so that when rto_alpha >=3D 32, the update will not be skipped entirely.

> +                       tp->rttvar =3D tp->rttvar - (tp->rttvar >> rto_be=
ta)
> +                               + (((__u32)abs((__s64)tp->srtt - (__s64)r=
tt)) >> rto_beta);
> +               rto_alpha =3D READ_ONCE(net->sctp.rto_alpha);
> +               if (rto_alpha < 32)
> +                       tp->srtt =3D tp->srtt - (tp->srtt >> rto_alpha)
> +                               + (rtt >> rto_alpha);
>         } else {
>                 /* 6.3.1 C2) When the first RTT measurement R is made, se=
t
>                  * SRTT <- R, RTTVAR <- R/2.
> --
> 2.51.2.1026.g39e6a42477-goog
>

