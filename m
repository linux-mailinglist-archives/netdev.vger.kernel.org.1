Return-Path: <netdev+bounces-101499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9A88FF13A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31069286020
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3803A198831;
	Thu,  6 Jun 2024 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDFLZciL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E28E1974E7
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689077; cv=none; b=GDYmVGBj74sKtIys7zr5Smwg0YgcsQUjM87yS/cvr+sTYLBQg15OPeasBUNmIZ4SJYfsNmGZ0RbmJrZFCt863IfPb9C3v+6OX7dyd2qzsRnUE31sdQWH85z67877H/CxrUCqRAuzXSIIQ+sNJ6mTtzpiOu/ujzJDLFTG661Z8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689077; c=relaxed/simple;
	bh=BiaZpuXtE262MKkeXKMMBZ6Gsxt/ZA2uGimhSj3N1RM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuvsCuRjfgiXCN8Qppbn9mZYVw/ZWwdW7wlu4/xEsksnEICM0NmJmEicBT5XNSy0oDnzctj/1S+iWNYRLPM/TmEUrHjIpF0e0NnacjdNdFBT0uyBtG267V9aJWZodSo3xQQX5/gbpNfgMKpncrKYFHg6ubM5L4r9fad0zbpUx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDFLZciL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a50ac2ca1so1483142a12.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717689074; x=1718293874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3cUNUJBhtAkMvQkshenigi1QMNGnp2VQTGwzfrrrto=;
        b=EDFLZciLseUE8RCO6o1idsgNQUjJZTWfKg/mGPzg2Quyv5RW6egGPAoC7wXr+Tvp3g
         q2VbQ+0IXhCkhIDdLJoYwdbC+z60MPYQjc8Kr1H7okD9tTDbxXXELWQa13xeinFmUlGc
         F0/3+TOhLW7s6daO0f2nZcZcwpJn6FkTLqPobWok/1s30PVsNIkQ+BAIssSilAwIZD4j
         gjc7d2ffavPQoIN2X8AzGFUWggKhbWSgB8IUi0lKZJasRfqVBQxu/XwygvlAW5Zf04JE
         xXzajxaiug5IGDeA9qBxr4qWcj6DTqPYtQU48pTAwnRXk9qOrIDTG2w0N1UpRyEZSgYd
         tavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689074; x=1718293874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3cUNUJBhtAkMvQkshenigi1QMNGnp2VQTGwzfrrrto=;
        b=PUulvK6BjoLhjifGiLiBbrFLpEEDoubBhGA9UWIze0Yi25RRfig8Xu8osJv/fR9g11
         i55qUueapY4arE3LCX852XqYQLGEGXfSR0XI9aqmiNrUnlPCwvzfrYohD83rvUGQfs9D
         vHWgALpcTZq0ditpu9mbfpjGrbaEEVJIb3zX7jnuMpZpmLNSw//GrlsWkc9z5jpD25yz
         IlhkgF/EXLpQkHbdA1fGdw2FgmX3H+BsrdwAmVe51yfEw7TvnHz78/bSYVRcF7rb5j0J
         c6To6Bjewi+xVJCIRVGtewh0XIhP7B8YSiAkV39Yl1iqfTWII8oc5SDzaGlUi3zUJwjQ
         6QJg==
X-Forwarded-Encrypted: i=1; AJvYcCXiusGo8Wk3rGcaQvHC6oxi/qZUfnTQi1GNgzvvmt4GmL97dsyBr9fhd7ppzCRJy9xCW37jJUbBz/MLQY8dmDlEoPzo2nQ5
X-Gm-Message-State: AOJu0Yx6yy79Gj978ptjt9b0zXKEXuc04HXqHEJHvKv8hg9RMbQ53xBx
	9BG15SN0MgAKCnNrD2SSreVRWdejaLW5XmBKUii5ukq0lIUxW9R6dWthmCq39hrLGcXfAOdma4H
	B7V6qEsQwDVyik24sYgdbrC259+c=
X-Google-Smtp-Source: AGHT+IH6NlOqQKsOAAsEW+SdBvJezgCaNwZ++ETVYxcbvYzlwLZBubVQrsDuq3msgsyhy++t76nggwaRgXgPgPa1cpQ=
X-Received: by 2002:a17:906:cc5c:b0:a69:68db:6f39 with SMTP id
 a640c23a62f3a-a699fad1746mr412872266b.32.1717689073448; Thu, 06 Jun 2024
 08:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606150307.78648-1-kerneljasonxing@gmail.com>
 <20240606150307.78648-2-kerneljasonxing@gmail.com> <CANn89iLe12LJrhsYB6sQ4m90HPeLL=H97Ju2nm+HzUmMqk+yVQ@mail.gmail.com>
 <CAL+tcoB3j7-uWVzYAcrcmn4Vg9Ng0xptk3-1hGuGWgVHwSYG=g@mail.gmail.com> <CANn89iJMx1ZAt4tuCKH6L33OgEcdjd6mLRWjuvRXvbWeckZmYg@mail.gmail.com>
In-Reply-To: <CANn89iJMx1ZAt4tuCKH6L33OgEcdjd6mLRWjuvRXvbWeckZmYg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Jun 2024 23:50:35 +0800
Message-ID: <CAL+tcoCS7_znUvpQY=s3m6cme8zwWn2N+jCaJw+nMBhg=43HcA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: fix showing wrong rtomin in snmp file
 when using route option
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 11:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jun 6, 2024 at 5:41=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > On Thu, Jun 6, 2024 at 11:14=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Jun 6, 2024 at 5:03=E2=80=AFPM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > TCP_MIB_RTOMIN implemented in tcp mib definitions is always 200, wh=
ich
> > > > is true if without any method to tune rto min. In 2007, we got a wa=
y to
> > > > tune it globaly when setting rto_min route option, but TCP_MIB_RTOM=
IN
> > > > in /proc/net/snmp still shows the same, namely, 200.
> > > >
> > > > As RFC 1213 said:
> > > >   "tcpRtoMin
> > > >    ...
> > > >    The minimum value permitted by a TCP implementation for the
> > > >    retransmission timeout, measured in milliseconds."
> > > >
> > > > Since the lower bound of rto can be changed, we should accordingly
> > > > adjust the output of /proc/net/snmp.
> > > >
> > > > Fixes: 05bb1fad1cde ("[TCP]: Allow minimum RTO to be configurable v=
ia routing metrics.")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/net/tcp.h  | 2 ++
> > > >  net/ipv4/metrics.c | 4 ++++
> > > >  net/ipv4/proc.c    | 3 +++
> > > >  3 files changed, 9 insertions(+)
> > > >
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > > index a70fc39090fe..a111a5d151b7 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -260,6 +260,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX)=
;
> > > >  extern int sysctl_tcp_max_orphans;
> > > >  extern long sysctl_tcp_mem[3];
> > > >
> > > > +extern unsigned int tcp_rtax_rtomin;
> > > > +
> > > >  #define TCP_RACK_LOSS_DETECTION  0x1 /* Use RACK to detect losses =
*/
> > > >  #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
> > > >  #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshol=
d in RACK */
> > > > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > > > index 8ddac1f595ed..61ca949b8281 100644
> > > > --- a/net/ipv4/metrics.c
> > > > +++ b/net/ipv4/metrics.c
> > > > @@ -7,6 +7,8 @@
> > > >  #include <net/net_namespace.h>
> > > >  #include <net/tcp.h>
> > > >
> > > > +unsigned int tcp_rtax_rtomin __read_mostly;
> > > > +
> > > >  static int ip_metrics_convert(struct nlattr *fc_mx,
> > > >                               int fc_mx_len, u32 *metrics,
> > > >                               struct netlink_ext_ack *extack)
> > > > @@ -60,6 +62,8 @@ static int ip_metrics_convert(struct nlattr *fc_m=
x,
> > > >         if (ecn_ca)
> > > >                 metrics[RTAX_FEATURES - 1] |=3D DST_FEATURE_ECN_CA;
> > > >
> > > > +       tcp_rtax_rtomin =3D metrics[RTAX_RTO_MIN - 1];
> > > > +
> > > >         return 0;
> > > >  }
> > > >
> > > > diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> > > > index 6c4664c681ca..ce387081a3c9 100644
> > > > --- a/net/ipv4/proc.c
> > > > +++ b/net/ipv4/proc.c
> > > > @@ -428,6 +428,9 @@ static int snmp_seq_show_tcp_udp(struct seq_fil=
e *seq, void *v)
> > > >                 /* MaxConn field is signed, RFC 2012 */
> > > >                 if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_MAXCONN)
> > > >                         seq_printf(seq, " %ld", buff[i]);
> > > > +               else if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_RTO=
MTIN)
> > > > +                       seq_printf(seq, " %lu",
> > > > +                                  tcp_rtax_rtomin ? tcp_rtax_rtomi=
n : buff[i]);
> > > >                 else
> > > >                         seq_printf(seq, " %lu", buff[i]);
> > > >         }
> > > > --
> > > > 2.37.3
> > > >
> > >
> > > I do not think we can accept this patch.
> > >
> > > 1) You might have missed that we have multiple network namespaces..
> >
> > Thanks for the review.
> >
> > For this patch, indeed, I think I need to consider namespaces...
> > For the other one, I did.
> >
> > >
> > > 2) You might have missed that we can have thousands of routes, with
> > > different metrics.
> >
> > Oh, that's really complicated...
> >
> > >
> > > I would leave /proc/net/snmp as it is, because no value can possibly =
be right.
> >
> > It cannot be right if someone tries to set rto min by 'ip route' or 'sy=
sctl -w'.
> >
>
> Or eBPF.
>
> There is no way a /proc/net/snmp value can be right.
>
> Why would anyone care, since thousands of TCP sockets can all have
> different values ?

I think you're right because there are too many kinds of situations.

For kernel developers or knowledgable admins, they are aware of this
'issue' (If I remember correctly, there is one comment in iproute
saying this field is obsolete.).
For some normal users, they are confused because someone reported this
'issue' to me.

I'll drop this series. There's no good way to solve it.

Thanks, Eric.

