Return-Path: <netdev+bounces-101494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F78FF0FE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196101C212DF
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E4197A61;
	Thu,  6 Jun 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJ4eTutM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAAB19752A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688641; cv=none; b=aA8H0obKOeMgLpAm/uz+bAiDcwfvoGc98asdDIY7kOWyfcsSoSCfRWEbWonp/J3SeAttjtn2/z4GTvyKMTIAluTJ4Doev6AQPPyDuGvDCgnKemAeDKeaoet5NH/cUjpmAXj6H8n8I4EH8I0EiDt12BYurgsElL80DYjRsLpBeHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688641; c=relaxed/simple;
	bh=qZd5s/uMRWrIIDma4YAXKlZ0x2JKHE6nGefGlNRZ0f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+2HmxuP4PKJqBPMR9RFmsGxb8KgOrCatFmPfZcxvz4Hejeh9UWzmz4NpS9TCrtJkXg2LO/usXV2AaHuof9+bTAt7eUY/wZrjkwSzUFbJE7wPXAHEtvGdKS3T7ONYFNXRfgDEO2vsEc2jsLI76pbwnqmusg3Y7aNIXL/ltOOamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJ4eTutM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso14258a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717688638; x=1718293438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imIDWWcoMBVbwZlIPom94fAG+chtz1YGCZXWnnpacYA=;
        b=IJ4eTutMoloSVYd43AfwXJcEg/sThDOIWlWbv2GZjH1soJ+MpAOfXBSMa3q3vQIGHh
         cIwV7bmE5QZFfgiT/G6P+hE7r8KFYzoqJ1DA76KTeWTSV6dLpqBgs7zZdO2C2SYBN+Ke
         +i3e8DHapih4jjUwddsS+rW0Bm9caBLKeKP0ERoXIwjOaPEBA4VgbDV44He15JQL7fvZ
         ac+NbSIXmDjCxwUVwWCxoBRBHPI1WbxUvzvZ+y90C68Yhuu/5Fa4fESOZQMCBvM32Z5Q
         c5GpboKruUiCg7BfIjk0pNgZhF59r7hRWaAr41YayAiS5rque6jPQfnN1tLa7k13FL7C
         bfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688638; x=1718293438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imIDWWcoMBVbwZlIPom94fAG+chtz1YGCZXWnnpacYA=;
        b=Cy+Ye8G+O7DXPkLMLOrbUsX6nq4QxQ2cgDfYloYC1XxshYuQbVXmyCFtaggP39WG7E
         8fpK+9aTT/o7WkOgmHyI9Wj3W5YvpNzy8eFg40E0yitJbA0jtLX50bnANCPBnFToDR9S
         NdHxvrBEiFpCpADWr+M8NAPIPy36/penuffp+z+PP6vzj9hfeVWA/ntJ2L+QkE13rLgM
         Cu78QZo02mJg5vUnT+SgbFWHsAhprz0K9+jGfyIDVSzUehVF0m+azGpdGK9qazGSvO2/
         FV0UTZzHHvUQOz9FoJriCmyWsveB01UzthPgDnEJq0szm+xCgpU6y1mp7L4Qa160drMD
         MKbw==
X-Forwarded-Encrypted: i=1; AJvYcCV3z4hciyC9NZOxHCNxkjZjDFnDLVkrhUW+e4TBrZYpl42T2yk7jhtQ/9Ir1FlDvWMWtSbRmDrCLusnEs1cM8sjlQjs+l5l
X-Gm-Message-State: AOJu0YzqHUbN7FezcWISkgM5FxLUNO9X+OqSdPmhxwMjIyS0oX90zASG
	BgnA53SVGvPCBGRtOMDc6OQsVWkuaG8hClYMOkgWcTsuKM92wHGEsi9FF02GNvpmQQcbbfN/V2k
	xnD8Tl+RaSW6DQyL4z2Y+jawO6IuYdHblsysU
X-Google-Smtp-Source: AGHT+IH8KGOjDt428nktOCRFgCBivqINuycBCLeC6n/MQZia+kIrF4pQUJS6jmwbho2u2beDUegr2swTzBKzB6ezFyQ=
X-Received: by 2002:a05:6402:8c2:b0:57a:1a30:f5da with SMTP id
 4fb4d7f45d1cf-57aa6bd3be2mr302548a12.2.1717688637685; Thu, 06 Jun 2024
 08:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606150307.78648-1-kerneljasonxing@gmail.com>
 <20240606150307.78648-2-kerneljasonxing@gmail.com> <CANn89iLe12LJrhsYB6sQ4m90HPeLL=H97Ju2nm+HzUmMqk+yVQ@mail.gmail.com>
 <CAL+tcoB3j7-uWVzYAcrcmn4Vg9Ng0xptk3-1hGuGWgVHwSYG=g@mail.gmail.com>
In-Reply-To: <CAL+tcoB3j7-uWVzYAcrcmn4Vg9Ng0xptk3-1hGuGWgVHwSYG=g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 17:43:46 +0200
Message-ID: <CANn89iJMx1ZAt4tuCKH6L33OgEcdjd6mLRWjuvRXvbWeckZmYg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: fix showing wrong rtomin in snmp file
 when using route option
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 5:41=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Jun 6, 2024 at 11:14=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Jun 6, 2024 at 5:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > TCP_MIB_RTOMIN implemented in tcp mib definitions is always 200, whic=
h
> > > is true if without any method to tune rto min. In 2007, we got a way =
to
> > > tune it globaly when setting rto_min route option, but TCP_MIB_RTOMIN
> > > in /proc/net/snmp still shows the same, namely, 200.
> > >
> > > As RFC 1213 said:
> > >   "tcpRtoMin
> > >    ...
> > >    The minimum value permitted by a TCP implementation for the
> > >    retransmission timeout, measured in milliseconds."
> > >
> > > Since the lower bound of rto can be changed, we should accordingly
> > > adjust the output of /proc/net/snmp.
> > >
> > > Fixes: 05bb1fad1cde ("[TCP]: Allow minimum RTO to be configurable via=
 routing metrics.")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/net/tcp.h  | 2 ++
> > >  net/ipv4/metrics.c | 4 ++++
> > >  net/ipv4/proc.c    | 3 +++
> > >  3 files changed, 9 insertions(+)
> > >
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index a70fc39090fe..a111a5d151b7 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -260,6 +260,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
> > >  extern int sysctl_tcp_max_orphans;
> > >  extern long sysctl_tcp_mem[3];
> > >
> > > +extern unsigned int tcp_rtax_rtomin;
> > > +
> > >  #define TCP_RACK_LOSS_DETECTION  0x1 /* Use RACK to detect losses */
> > >  #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
> > >  #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold =
in RACK */
> > > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > > index 8ddac1f595ed..61ca949b8281 100644
> > > --- a/net/ipv4/metrics.c
> > > +++ b/net/ipv4/metrics.c
> > > @@ -7,6 +7,8 @@
> > >  #include <net/net_namespace.h>
> > >  #include <net/tcp.h>
> > >
> > > +unsigned int tcp_rtax_rtomin __read_mostly;
> > > +
> > >  static int ip_metrics_convert(struct nlattr *fc_mx,
> > >                               int fc_mx_len, u32 *metrics,
> > >                               struct netlink_ext_ack *extack)
> > > @@ -60,6 +62,8 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
> > >         if (ecn_ca)
> > >                 metrics[RTAX_FEATURES - 1] |=3D DST_FEATURE_ECN_CA;
> > >
> > > +       tcp_rtax_rtomin =3D metrics[RTAX_RTO_MIN - 1];
> > > +
> > >         return 0;
> > >  }
> > >
> > > diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> > > index 6c4664c681ca..ce387081a3c9 100644
> > > --- a/net/ipv4/proc.c
> > > +++ b/net/ipv4/proc.c
> > > @@ -428,6 +428,9 @@ static int snmp_seq_show_tcp_udp(struct seq_file =
*seq, void *v)
> > >                 /* MaxConn field is signed, RFC 2012 */
> > >                 if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_MAXCONN)
> > >                         seq_printf(seq, " %ld", buff[i]);
> > > +               else if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_RTOMT=
IN)
> > > +                       seq_printf(seq, " %lu",
> > > +                                  tcp_rtax_rtomin ? tcp_rtax_rtomin =
: buff[i]);
> > >                 else
> > >                         seq_printf(seq, " %lu", buff[i]);
> > >         }
> > > --
> > > 2.37.3
> > >
> >
> > I do not think we can accept this patch.
> >
> > 1) You might have missed that we have multiple network namespaces..
>
> Thanks for the review.
>
> For this patch, indeed, I think I need to consider namespaces...
> For the other one, I did.
>
> >
> > 2) You might have missed that we can have thousands of routes, with
> > different metrics.
>
> Oh, that's really complicated...
>
> >
> > I would leave /proc/net/snmp as it is, because no value can possibly be=
 right.
>
> It cannot be right if someone tries to set rto min by 'ip route' or 'sysc=
tl -w'.
>

Or eBPF.

There is no way a /proc/net/snmp value can be right.

Why would anyone care, since thousands of TCP sockets can all have
different values ?

