Return-Path: <netdev+bounces-101490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF0F8FF14A
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6636BB22658
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BDC19751B;
	Thu,  6 Jun 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4gUBrfX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA2197517
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688485; cv=none; b=GDkbAO4HvJ/ybkAq41MjMxKqdgwVmttLe674yOttFjqDWLj9I1LW4oYxyklB2yRsSGm7QX1DVCHZz0YsI4pcze/LG49RTmQX3fx81JCqbTUCNacFmq7GvpohPvcND1YOO+ujSIAw556HINzLtyaJZlFFn9RlaJ1PGuwy6jWLj2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688485; c=relaxed/simple;
	bh=+JKQBWeeIbMbBoYpG1guFUUwLherN61SVnlyIXc9AVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ru4rDuzHDqeXs+v9uE3poQ0QCN9iesPbeyL91jI/HjTn2teWji8nlcEYzHtSsd9tgmFcAxXo6bHufKKuQe0Tog8lGytrDMl+PSM6ixLInTaRXPjGl4Mp+kqOsLD8oAq10V//KNcQe12lGqkGzSnlBu4TcfnOYJm4XmhQPSsnVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4gUBrfX; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b9dda4906so1566078e87.2
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688482; x=1718293282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGOufUxQNt7/U6p3w/3M6YcJGX1Q8pi4ATw11ZF0r7s=;
        b=F4gUBrfXq0N/tMl+xeoXF3UIPUK0kUg0SgOQYBgAlTfHprmBCZLHw7RzcTDm3IRMmk
         VidmFSSAYtep/K0vQEKm7BuXqHRowRwIQjjhRSgvvGRQ2yB7FF8b9ufWJELDHMcuBGQl
         SeIfAIM7X8H7SzZeJtJVHYeTzOTcWbWL7QKeZK7yVDDk3yyFeilhdyRe7soEy7manBcu
         fZNJ+3C4yJi7fsaAxkoVupoDHPrb1zfQHMfhPYN1vSrSO/y1FLFVeM1VdH24x1JDboa5
         pSQ/5I6cwF3dGX+umqPZEbZJlnl2vXMtvhuj7Bfq5tNbrFcbt4JFDJx9oI8kInAMpg1O
         4v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688482; x=1718293282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGOufUxQNt7/U6p3w/3M6YcJGX1Q8pi4ATw11ZF0r7s=;
        b=BdAorAIJFKQjiG+MogzDS8VBeg4MwBkCPJXXNOQTfUweVWDPAK8zbMuYbvHRIxrIBg
         IAVQR1/QvQAuAuKgeBSfLtcSZUN6Wd1DjEDfWRz9D4V6WWnOmfQWxpIkeGzZ67YhhH5c
         17AZCa21lWTr60jBhObqK+qHcuWjMh7zYEPFFDmIiRFrAJmWEAufCMFgM4wZHFQAaPkY
         UHmx95yKdFEY1qzYOQBp4EMBHJLqtGa67F3KtS70OgEnJki/OZZJv5r624xj07QgIVWK
         mVoPMmmV7WgqPLu6XZMYulkKaJRIl5no/FFBHxRkIZ6gNCw+swH98pPQo9fKkJ6XgzBa
         Y6mw==
X-Forwarded-Encrypted: i=1; AJvYcCWtBe9GwBCxi6zW5b1HGKhrbSL6zxUldIALf8OEwpaN9JWeKrK30IPqRq0mQk8xbNFi5jHqNrQvXBB293WOZD1HCcwCvdlh
X-Gm-Message-State: AOJu0Yw+LNlrWacFcf1P4ZLOIbkUVAH3+vaUCgPUAxS2FzFY9Xr79CFp
	KuEypJKzYOVKi2WB3zMkdIeWclWDqFM0TqM6JUkGVXMhlRPnJ7oJpFz5Pr0sHgoj8BqCCTSpq1r
	OFCxhHhqgxeFIlmdvN2uMFA9rL9g=
X-Google-Smtp-Source: AGHT+IFnsXYYhCfeGX+oqtI21eM5td9esYoB9/GUfDmrjj6P58jxWE+eqJo0wn1XxUO0Atnytp52u9Td1ah7PLCbDmE=
X-Received: by 2002:a19:5207:0:b0:52a:5fa8:d565 with SMTP id
 2adb3069b0e04-52bab511bb7mr4124968e87.68.1717688481823; Thu, 06 Jun 2024
 08:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606150307.78648-1-kerneljasonxing@gmail.com>
 <20240606150307.78648-2-kerneljasonxing@gmail.com> <CANn89iLe12LJrhsYB6sQ4m90HPeLL=H97Ju2nm+HzUmMqk+yVQ@mail.gmail.com>
In-Reply-To: <CANn89iLe12LJrhsYB6sQ4m90HPeLL=H97Ju2nm+HzUmMqk+yVQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Jun 2024 23:40:43 +0800
Message-ID: <CAL+tcoB3j7-uWVzYAcrcmn4Vg9Ng0xptk3-1hGuGWgVHwSYG=g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: fix showing wrong rtomin in snmp file
 when using route option
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 11:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jun 6, 2024 at 5:03=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > TCP_MIB_RTOMIN implemented in tcp mib definitions is always 200, which
> > is true if without any method to tune rto min. In 2007, we got a way to
> > tune it globaly when setting rto_min route option, but TCP_MIB_RTOMIN
> > in /proc/net/snmp still shows the same, namely, 200.
> >
> > As RFC 1213 said:
> >   "tcpRtoMin
> >    ...
> >    The minimum value permitted by a TCP implementation for the
> >    retransmission timeout, measured in milliseconds."
> >
> > Since the lower bound of rto can be changed, we should accordingly
> > adjust the output of /proc/net/snmp.
> >
> > Fixes: 05bb1fad1cde ("[TCP]: Allow minimum RTO to be configurable via r=
outing metrics.")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/tcp.h  | 2 ++
> >  net/ipv4/metrics.c | 4 ++++
> >  net/ipv4/proc.c    | 3 +++
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index a70fc39090fe..a111a5d151b7 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -260,6 +260,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
> >  extern int sysctl_tcp_max_orphans;
> >  extern long sysctl_tcp_mem[3];
> >
> > +extern unsigned int tcp_rtax_rtomin;
> > +
> >  #define TCP_RACK_LOSS_DETECTION  0x1 /* Use RACK to detect losses */
> >  #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
> >  #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in=
 RACK */
> > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > index 8ddac1f595ed..61ca949b8281 100644
> > --- a/net/ipv4/metrics.c
> > +++ b/net/ipv4/metrics.c
> > @@ -7,6 +7,8 @@
> >  #include <net/net_namespace.h>
> >  #include <net/tcp.h>
> >
> > +unsigned int tcp_rtax_rtomin __read_mostly;
> > +
> >  static int ip_metrics_convert(struct nlattr *fc_mx,
> >                               int fc_mx_len, u32 *metrics,
> >                               struct netlink_ext_ack *extack)
> > @@ -60,6 +62,8 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
> >         if (ecn_ca)
> >                 metrics[RTAX_FEATURES - 1] |=3D DST_FEATURE_ECN_CA;
> >
> > +       tcp_rtax_rtomin =3D metrics[RTAX_RTO_MIN - 1];
> > +
> >         return 0;
> >  }
> >
> > diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> > index 6c4664c681ca..ce387081a3c9 100644
> > --- a/net/ipv4/proc.c
> > +++ b/net/ipv4/proc.c
> > @@ -428,6 +428,9 @@ static int snmp_seq_show_tcp_udp(struct seq_file *s=
eq, void *v)
> >                 /* MaxConn field is signed, RFC 2012 */
> >                 if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_MAXCONN)
> >                         seq_printf(seq, " %ld", buff[i]);
> > +               else if (snmp4_tcp_list[i].entry =3D=3D TCP_MIB_RTOMTIN=
)
> > +                       seq_printf(seq, " %lu",
> > +                                  tcp_rtax_rtomin ? tcp_rtax_rtomin : =
buff[i]);
> >                 else
> >                         seq_printf(seq, " %lu", buff[i]);
> >         }
> > --
> > 2.37.3
> >
>
> I do not think we can accept this patch.
>
> 1) You might have missed that we have multiple network namespaces..

Thanks for the review.

For this patch, indeed, I think I need to consider namespaces...
For the other one, I did.

>
> 2) You might have missed that we can have thousands of routes, with
> different metrics.

Oh, that's really complicated...

>
> I would leave /proc/net/snmp as it is, because no value can possibly be r=
ight.

It cannot be right if someone tries to set rto min by 'ip route' or 'sysctl=
 -w'.

Thanks,
Jason

