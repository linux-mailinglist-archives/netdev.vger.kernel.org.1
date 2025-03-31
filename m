Return-Path: <netdev+bounces-178390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C51A76D0C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D8B168DF2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C55215047;
	Mon, 31 Mar 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgzdzZc5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359D8635B
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447043; cv=none; b=PRzv99ks1UxhxOqXsMCti9+/wj0wugs1segXdLWElAv3RRRcCdyntgUY02v+mgg4+7pB+pF6u+HcXPqYWqIsSTRq5M2hl31kkMyzqIxQXWbd+88rOYDu/CY8oNatYmM6u9gvKNYR2/rTAMkkym5+OV2vxaSJeLtiYvLhoj8lUe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447043; c=relaxed/simple;
	bh=lIyI9ULTZNVFT5sZEbWYSjJgDUKFOZfHySz2T3WTlQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBwyUVdCnp5uNNue4rix5i62s0+NRPsopVjsvRB7/jOShqT+CezRy57zmVn34V7/qLL2cNYJ4qFGl6Fu+5fvyM4inTDulVVe3UkWOQ9tAMzy4C5vNmNtsrTMVx6X3s6HVx001gddd86wFbp0YI2+afPQsjAX1m/VhwuiBDdirgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgzdzZc5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1efc457bso463133f8f.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743447040; x=1744051840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtVwBC5WHSvWRUiKgxBTmjtyD5tidVvCVhxZ/oMTg30=;
        b=fgzdzZc5g6TRXrgItedJSWhJPAuu4Wjq9V2FO/CSqRXWA8Zc4B6XaM9UhTTCwFaHhM
         Z8uWp08lYN7v7vhq35894syFCas7y1YfSZ5K5h/zoUJSNOv1IYw6umGjbLUiT+LSOS8G
         grrgLieGs4AjLX3/oYgY2pv1T9F6GB1eitz5dcuDz2pcJf18oDWB5t/R4oHUIRkaazhJ
         mQ35E99b7jCuVbm4/KXfI1dDfKJfhv+lp2NP5Z3kIrbH+7q6mBpnqQP0JWRFgqTDDHHo
         uTkGNQiAVDVJEuCfERapONq4WD432sUrBJGzJlfSPU1v6b679LEy9hPWoo7AhqyQc7IG
         e4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447040; x=1744051840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtVwBC5WHSvWRUiKgxBTmjtyD5tidVvCVhxZ/oMTg30=;
        b=iwIVHgWGfYGbzmAO8iEsnRCpkqWF+Qfl/2A1ALq4Ge1o2Dp21VG6d/81SLP7VaZrbO
         4YEQ8A7NjGOkY4+G5OAprWwymKo3TokGn9fu2mrbgdBo+sDC7iKoW1VqNFmzlFHaBwVc
         eTatg0VhK58Igoq76LPlcnAG2lsdp1kHxuIgvezVsjVbBx+q3ErWVWJ1vvGCPNq1k+3l
         +h+L+eSy7AkynKSqg6/sZJwVfGzxZupCxdRETHv572UqUjbrJ8O1cZB+J0kGroc+EhOE
         KxPlyjaY77qOipBlQLZ7TMQzRsBJZwYoPqVae76dMkRSd5qmPjovjdiHRKYOQ0jqH1Z3
         Toow==
X-Forwarded-Encrypted: i=1; AJvYcCW551U9JAZDci/SKZ6eVlFOFcuGuOuu5d0GVJ3wlTkHvmXV3rlAy6N7vDbmXRYah9vVXgl2iTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1VPGq/B2qOrwWxLBVnSbyegs41Nl+jD80XdWbnEO/+VWRBDTD
	bjUHBhYcXOhRnpac91V8kRX2uXLiEMUmngg306LYSVd5fjf3mmFX
X-Gm-Gg: ASbGnctkJFCmqFPdnOS6mgFynSWKpMFI2dtd0Uy9CnIz9zCgw2nJubieBxbyKc9j0gd
	s45ZGX4KBuV6mQKfmlesfkgwT88qTmNt7v5D1avGbABcFqoFHck+rMwQTm0zKK1K0pTjbmCTSyr
	zOySP+7MdoHh+cxtFnqmZEytpfdniZPQCow2V2vvko09iSYuTE4V3deg6B62xB7GAzqw4TU1yc1
	fIIfew2UzkZLBgY3fvQnRvaLtu4hvAo2SuGaEGTOljswAAVsctJ3U3NjYp3GEcc24Twv3OcNJq1
	yyjwfkIl73jR2vcqsUXsjJm+J85KQz9AA03whrvq9a0t5wXdyBjpars7V/zNo9jwSWOOn2iBojP
	aALbvQABVdq6AGi9jyg==
X-Google-Smtp-Source: AGHT+IHT9gefD4xxIzecw5B9l1q7JyER0RBV3e3hYH/EgjZG4ruraXXMMjAmScKDJGDBVdA6kDQSag==
X-Received: by 2002:a05:6000:250f:b0:39c:1f04:a646 with SMTP id ffacd0b85a97d-39c1f04a683mr2672383f8f.13.1743447040114;
        Mon, 31 Mar 2025 11:50:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66ad1esm12145523f8f.52.2025.03.31.11.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 11:50:39 -0700 (PDT)
Date: Mon, 31 Mar 2025 19:50:38 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] sctp: add mutual exclusion in
 proc_sctp_do_udp_port()
Message-ID: <20250331195038.7aafa82a@pumpkin>
In-Reply-To: <CANn89i+xpmBDQBPPG_QDfACHL=8h5=1bKqJjvD+e4=SHU7t76A@mail.gmail.com>
References: <20250331091532.224982-1-edumazet@google.com>
	<CADvbK_eneePox-VFbicSmt55g+VJdc+5m_LoS2bu_Pezatjq0g@mail.gmail.com>
	<CANn89i+xpmBDQBPPG_QDfACHL=8h5=1bKqJjvD+e4=SHU7t76A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Mar 2025 18:11:38 +0200
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Mar 31, 2025 at 5:54=E2=80=AFPM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Mon, Mar 31, 2025 at 5:15=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote: =20
> > >
> > > We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_sta=
rt()
> > > or risk a crash as syzbot reported:
> > >
> > > Oops: general protection fault, probably for non-canonical address 0x=
dffffc000000000d: 0000 [#1] SMP KASAN PTI
> > > KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
> > > CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller-g=
7f2ff7b62617 #0 PREEMPT(full)
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 02/12/2025
> > >  RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
> > > Call Trace:
> > >  <TASK>
> > >   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
> > >   sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
> > >   proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
> > >   proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
> > >   iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
> > >   do_splice_from fs/splice.c:935 [inline]
> > >   direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
> > >   splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
> > >   do_splice_direct_actor fs/splice.c:1201 [inline]
> > >   do_splice_direct+0x174/0x240 fs/splice.c:1227
> > >   do_sendfile+0xafd/0xe50 fs/read_write.c:1368
> > >   __do_sys_sendfile64 fs/read_write.c:1429 [inline]
> > >   __se_sys_sendfile64 fs/read_write.c:1415 [inline]
> > >   __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
> > >   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > >
> > > Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
> > > Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/netdev/67ea5c01.050a0220.1547ec.012b.=
GAE@google.com/T/#u
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > Cc: Xin Long <lucien.xin@gmail.com>
> > > ---
> > >  net/sctp/sysctl.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > > index 8e1e97be4df79f3245e2bbbeb0a75841abc67f58..ee3eac338a9deef064f27=
3e29bb59b057835d3f1 100644
> > > --- a/net/sctp/sysctl.c
> > > +++ b/net/sctp/sysctl.c
> > > @@ -525,6 +525,8 @@ static int proc_sctp_do_auth(const struct ctl_tab=
le *ctl, int write,
> > >         return ret;
> > >  }
> > >
> > > +static DEFINE_MUTEX(sctp_sysctl_mutex);
> > > +
> > >  static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int wr=
ite,
> > >                                  void *buffer, size_t *lenp, loff_t *=
ppos)
> > >  {
> > > @@ -549,6 +551,7 @@ static int proc_sctp_do_udp_port(const struct ctl=
_table *ctl, int write,
> > >                 if (new_value > max || new_value < min)
> > >                         return -EINVAL;
> > >
> > > +               mutex_lock(&sctp_sysctl_mutex);
> > >                 net->sctp.udp_port =3D new_value;
> > >                 sctp_udp_sock_stop(net);
> > >                 if (new_value) {
> > > @@ -561,6 +564,7 @@ static int proc_sctp_do_udp_port(const struct ctl=
_table *ctl, int write,
> > >                 lock_sock(sk);
> > >                 sctp_sk(sk)->udp_port =3D htons(net->sctp.udp_port);
> > >                 release_sock(sk);
> > > +               mutex_unlock(&sctp_sysctl_mutex);
> > >         }
> > >
> > >         return ret;
> > > --
> > > 2.49.0.472.ge94155a9ec-goog
> > > =20
> > Instead of introducing a new lock for this, wouldn't be better to just
> > move up `lock_sock(sk)` a little bit? =20
>=20
> It depends if calling synchronize_rcu() two times while holding the
> socket lock is ok or not ?
>=20
> What is the issue about using a separate mutex ?
>=20

Don't they need locking against a different path that is using the socket?
Not only against concurrent accesses to the sysctl?

Presuming the crash was because of the net->sctp.udp4_sock =3D NULL
assignment in sock_stop(), if 'min' is zero allowing 'new_value' zero
then the pointer is left NULL.

IIRC sctp_sk(sk) is fixed, so the sock_lock() doesn't do much apart
from stop some unlikely 'data tearing'.

	David

