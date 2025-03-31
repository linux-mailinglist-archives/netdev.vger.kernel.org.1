Return-Path: <netdev+bounces-178356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB20A76BA8
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27ACD166D0C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4C21422A;
	Mon, 31 Mar 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="peFrHoYw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7E1DF75A
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437511; cv=none; b=UfR1opratcru0G4TR8O462LLk49TCsC3/Bf8Mjmeh4uXO4S5iIIBn8FcYhar+9qNCszwCd0byPuUHzWi0prVO1R9C2Y3envCDOtPTshBvUi/JTAF2e8Uefzs26M3129M+yBWpHyVri0IbFIDvweXi/Iy0AIugkHHStPkEFqA6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437511; c=relaxed/simple;
	bh=D0h4VNQP+PK921gcUla5yKBnP985hbMX4nsgHpW2j9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u60hXKdWtuPuF8Bis0NOfSz2m0BwKGMUKa12GZdsJOzh2EKYw3UEsYNRBDFhvFKXKa9biSORuCFoObtVmx5I3oPXZTvBKDPvE92/26HtldHbTjPH8BWsP+1MhtyDyGlDvMV2vHQCdDg76aYTVKLaxRbLEVAiMJQNSSIrxSbtyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=peFrHoYw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476a304a8edso42492411cf.3
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743437509; x=1744042309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To6JPgAW/7HbS4G5u1fW1vC6n8Hiz1fLAs6UmlGPHDM=;
        b=peFrHoYw9sN43qnRF6mM0wTH/p5lGHB1dH+Bt11/4MgMFlNgeIGSz3s3CICfwMiE5v
         dyh3T5KrKX9TxikdRVdKIsrAsDkU4bT1yhNHIaZW1qK8BQo3ahHwY6kRZcbJg6oY3E7y
         bYZFmlPfgalzPRJrVqrNd1fk44pMu/RyuAOfgsZ/Dr5W8xFMpiQyyoyxETJvejcBGzYV
         HLtXsaqOQaVJCTuyGpJblzuDf988aXqiQz18Z7ofKLaugtCZhGJOxFY5XOOIHA0T05E5
         FGkqyIDLPHPct1OTIfI+IpuHvlz0T1uk25Z9CXeayMg7trzCj2/0wifVCxloEsxmUbXL
         I0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743437509; x=1744042309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To6JPgAW/7HbS4G5u1fW1vC6n8Hiz1fLAs6UmlGPHDM=;
        b=akWVrhOtjtfcQWLlEUw4vk8hKWy5kFq+54zhsEwxLMYy13wjBqAxXUYehs+v/SXkTP
         JGYkDCKn+kdUo2IWPWz8SEUfuTpOANrHHDVCpjNQTL/pBw4f+aOZj48mM79xa+fcBqh0
         omVAC5pT+MlnqQ20GBqQgRVSX8r0wb769nh7G3Q9PSFk62yfpzBvEVUvzRBt6QuQfyXR
         1wKWodGyzdSfcebmYambkQX65HHF/ntcKwUYVbeoUWVCW0k/oR6RUJpe1WNAfUXerbeL
         BrsApIdY0dnKOx+c+3BhW6ccR2xEm4TDnOvTwWhw2HCOeAks446L4bUIwjkPotcV3VOj
         pM4A==
X-Forwarded-Encrypted: i=1; AJvYcCWp38yhgL9Gf/AH9ROIXwDUEkjG/eJDg6Fjjs8dn5zFUzOgId8U0M5booApx6Yv6x+oNIZBZXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOl6pMhtqaHy1mO0mBT3ph8jsTxuzgvpP9Dwdyez9osvjrPTP6
	h++aGXypXtZCx/FCVRjldCx1ztRA5a6U0rNFCaxeH53UTqasyEXDpG+HvXj5IKxtkytOkGTDTyE
	tK+JokXuus6/+7s69MbfnBVCvnuXagWWY2UeT9iMVaEC1iZ1kqQ==
X-Gm-Gg: ASbGncs/gu0NGLoVtfM9pu0iESJCiPZtVnRSaCmwO1phwHnRYFJzPBHhEFmoKovWmo9
	+B7PTDkcOlNbKEMkgOyHPb5JqUn39E3YSkgFjU1wL7/WAGr+QNhn2mVrGfy4XRi1fARfhM2Wz+Y
	tizMKbFS9kFceyoSvIdYed4fmU
X-Google-Smtp-Source: AGHT+IEAJL2kL+B28UyibpUl7AKAk2gFrXtEQuhwlzSAZp0ZZZHUX6c3h54ed0PRaPjRrquIFdurjuhx+EIfToC/kgQ=
X-Received: by 2002:ac8:594a:0:b0:476:9252:ce8 with SMTP id
 d75a77b69052e-477ed6b766dmr102334581cf.10.1743437508852; Mon, 31 Mar 2025
 09:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331091532.224982-1-edumazet@google.com> <CADvbK_eneePox-VFbicSmt55g+VJdc+5m_LoS2bu_Pezatjq0g@mail.gmail.com>
In-Reply-To: <CADvbK_eneePox-VFbicSmt55g+VJdc+5m_LoS2bu_Pezatjq0g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 31 Mar 2025 18:11:38 +0200
X-Gm-Features: AQ5f1JpmtQJ1mcLIfaI0R6gmxfDbt2V4k4xXRwJzOYeu5FBRnduWiHVHy_2urxQ
Message-ID: <CANn89i+xpmBDQBPPG_QDfACHL=8h5=1bKqJjvD+e4=SHU7t76A@mail.gmail.com>
Subject: Re: [PATCH net] sctp: add mutual exclusion in proc_sctp_do_udp_port()
To: Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 5:54=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Mon, Mar 31, 2025 at 5:15=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_start=
()
> > or risk a crash as syzbot reported:
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc000000000d: 0000 [#1] SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> > CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller-g7f=
2ff7b62617 #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 02/12/2025
> >  RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
> > Call Trace:
> >  <TASK>
> >   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
> >   sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
> >   proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
> >   proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
> >   iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
> >   do_splice_from fs/splice.c:935 [inline]
> >   direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
> >   splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
> >   do_splice_direct_actor fs/splice.c:1201 [inline]
> >   do_splice_direct+0x174/0x240 fs/splice.c:1227
> >   do_sendfile+0xafd/0xe50 fs/read_write.c:1368
> >   __do_sys_sendfile64 fs/read_write.c:1429 [inline]
> >   __se_sys_sendfile64 fs/read_write.c:1415 [inline]
> >   __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
> >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >
> > Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> > Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/67ea5c01.050a0220.1547ec.012b.GA=
E@google.com/T/#u
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > Cc: Xin Long <lucien.xin@gmail.com>
> > ---
> >  net/sctp/sysctl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > index 8e1e97be4df79f3245e2bbbeb0a75841abc67f58..ee3eac338a9deef064f273e=
29bb59b057835d3f1 100644
> > --- a/net/sctp/sysctl.c
> > +++ b/net/sctp/sysctl.c
> > @@ -525,6 +525,8 @@ static int proc_sctp_do_auth(const struct ctl_table=
 *ctl, int write,
> >         return ret;
> >  }
> >
> > +static DEFINE_MUTEX(sctp_sysctl_mutex);
> > +
> >  static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int writ=
e,
> >                                  void *buffer, size_t *lenp, loff_t *pp=
os)
> >  {
> > @@ -549,6 +551,7 @@ static int proc_sctp_do_udp_port(const struct ctl_t=
able *ctl, int write,
> >                 if (new_value > max || new_value < min)
> >                         return -EINVAL;
> >
> > +               mutex_lock(&sctp_sysctl_mutex);
> >                 net->sctp.udp_port =3D new_value;
> >                 sctp_udp_sock_stop(net);
> >                 if (new_value) {
> > @@ -561,6 +564,7 @@ static int proc_sctp_do_udp_port(const struct ctl_t=
able *ctl, int write,
> >                 lock_sock(sk);
> >                 sctp_sk(sk)->udp_port =3D htons(net->sctp.udp_port);
> >                 release_sock(sk);
> > +               mutex_unlock(&sctp_sysctl_mutex);
> >         }
> >
> >         return ret;
> > --
> > 2.49.0.472.ge94155a9ec-goog
> >
> Instead of introducing a new lock for this, wouldn't be better to just
> move up `lock_sock(sk)` a little bit?

It depends if calling synchronize_rcu() two times while holding the
socket lock is ok or not ?

What is the issue about using a separate mutex ?

