Return-Path: <netdev+bounces-60825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E6A821977
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C3FAB20EE3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F3CA7F;
	Tue,  2 Jan 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kE2vkBlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2CD26A
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso96895a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 02:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704190329; x=1704795129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adfFbKWEYub2oIsxBc06RRpotskmDpfu15gSAWSV6Ss=;
        b=kE2vkBlQiq6OFgjW549bGyIKg+Y1aAiaX1nfmpkxgewuACBI+9Mt14O80tk51Hn72w
         b1308Ou+mw+6TGgW2fZTOw8Gd3guze3CMXg1iMKlhXp2TZwwDPSAbJ4q8lohDzHY1RBy
         bVK2gPo5SL0+WXJiC7WojfZ/5+1i0SSHbvilCv5g/Opeg4RuOnQTh1vUuO8qeLpGOsBh
         3tAGVtqot+vrAzJ4par65hjt4lSv8vusrRS3qyRRxscB6GpUeutJiyPRHd1GOlOcBxbR
         UW8jxnJvvkaXdcEmAN6yeIxjJCl1wxRQATHvdJXSm12FijBpNi9isaNvB1sX8s8S9zCB
         BDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704190329; x=1704795129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adfFbKWEYub2oIsxBc06RRpotskmDpfu15gSAWSV6Ss=;
        b=b3STgrW821U6vCL7h5DOikUvieQu7JyIj/nbK6pG3Wrqaq5HjivNqPmTbMlMrHwa6M
         22LnCguvPRPYpdQxF63m0HMFCNTlonvMNDznylyJM+jiRb2+0ZdlcIzqR5+XUU5N+dtQ
         3EutJ5EX7suY92QoKMvwkEZYVCVvSwbr7V9V8R5ArT64iGArTCgSj/4xIGfTf6f4Ughm
         RUskm6asSOixwaa/PIlCTg3/AxPLCyBitco9ybJR14Xf4JTYK3rG2+uw8jI4w9Sn6jGL
         YfcNrYmAGsX5jdM94cErIDx3L9QEJtG8aghw/CsbW3QjS5mu7bNwySHi8oBNAuIUtOaG
         +1MA==
X-Gm-Message-State: AOJu0YxsZe230plUHPcGr3nRYFGglalo7l4F0FwSMCn3a2KQ5P9HqNrJ
	HaurZnEBbisaGquJXom3abL8AFDqgUN/X2jzHcjqBieS5KtuercAYjTTizYsZ4iy
X-Google-Smtp-Source: AGHT+IFzaknXrDGkhXAV0rWqm5K9wz520QfVV4cnfCIsyZt86hJvt/oj49dizFpVvYTM1Gf5dfMMOdSInecy4jbVyFw=
X-Received: by 2002:a05:6402:5249:b0:554:98aa:f75c with SMTP id
 t9-20020a056402524900b0055498aaf75cmr770762edd.5.1704190328723; Tue, 02 Jan
 2024 02:12:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14459261ea9f9c7d7dfb28eb004ce8734fa83ade.1704185904.git.leonro@nvidia.com>
 <CANn89iLVg3H-GuZ6=_-Rc5Jk14T59pZcx1DF-3HApvsPuSpNXg@mail.gmail.com>
 <20240102095835.GF6361@unreal> <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>
In-Reply-To: <CANn89iLd6EeC3b8DTXBP=cDw8ri+k_uGiCrAS6BOoG3FMuAxmg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Jan 2024 11:11:55 +0100
Message-ID: <CANn89i+ad_7nisbJ8Z6Xcpv1jUjUvhfZLmpmGZ-2tJJNyN4v3A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Revert no longer abort SYN_SENT when
 receiving some ICMP
To: Leon Romanovsky <leon@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shachar Kagan <skagan@nvidia.com>, 
	netdev@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:03=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jan 2, 2024 at 10:58=E2=80=AFAM Leon Romanovsky <leon@kernel.org>=
 wrote:
> >
> > On Tue, Jan 02, 2024 at 10:46:13AM +0100, Eric Dumazet wrote:
> > > On Tue, Jan 2, 2024 at 10:01=E2=80=AFAM Leon Romanovsky <leon@kernel.=
org> wrote:
> > > >
> > > > From: Shachar Kagan <skagan@nvidia.com>
> > > >
> > > > This reverts commit 0a8de364ff7a14558e9676f424283148110384d6.
> > > >
> > > > Shachar reported that Vagrant (https://www.vagrantup.com/), which i=
s
> > > > very popular tool to manage fleet of VMs stopped to work after comm=
it
> > > > citied in Fixes line.
> > > >
> > > > The issue appears while using Vagrant to manage nested VMs.
> > > > The steps are:
> > > > * create vagrant file
> > > > * vagrant up
> > > > * vagrant halt (VM is created but shut down)
> > > > * vagrant up - fail
> > > >
> > >
> > > I would rather have an explanation, instead of reverting a valid patc=
h.
> > >
> > > I have been on vacation for some time. I may have missed a detailed
> > > explanation, please repost if needed.
> >
> > Our detailed explanation that revert worked. You provided the patch tha=
t
> > broke, so please let's not require from users to debug it.
> >
> > If you need a help to reproduce and/or test some hypothesis, Shachar
> > will be happy to help you, just ask.
>
> I have asked already, and received files that showed no ICMP relevant
> interactions.
>
> Can someone from your team help Shachar to get  a packet capture of
> both TCP _and_ ICMP packets ?
>
> Otherwise there is little I can do. I can not blindly trust someone
> that a valid patch broke something, just because 'something broke'

Alternative to a packet capture would be  a packetdrill test.

Following test passes with the new kernel, and breaks with the old ones.



// Set up config.
`../common/defaults.sh
 ../common/set_sysctls.py /proc/sys/net/ipv4/tcp_syn_retries=3D12 \
    /proc/sys/net/ipv4/tcp_syn_linear_timeouts=3D4
`

// Establish a connection.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) =3D 0
   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)

  +0 > S 0:0(0) win 65535 <mss 1460,sackOK,TS val 80 ecr 0,nop,wscale 8>

  +1 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 0, tcpi_backoff}%
+0 %{ assert tcpi_total_rto =3D=3D 1, tcpi_total_rto}%

   +1 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 0, tcpi_backoff}%
+0 %{ assert tcpi_total_rto =3D=3D 2, tcpi_total_rto}%

   +1 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 0, tcpi_backoff}%
+0 %{ assert tcpi_total_rto =3D=3D 3, tcpi_total_rto}%

// RFC 6069 : this ICMP message is ignored while in linear timeout mode
+.5 < icmp unreachable host_unreachable [0:0(0)]

+0.5 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 0, tcpi_backoff}%
+0 %{ assert tcpi_total_rto =3D=3D 4, tcpi_total_rto}%

   +1 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 1, tcpi_backoff}%
+0 %{ assert tcpi_total_rto =3D=3D 5, tcpi_total_rto}%

   +2 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 2, tcpi_backoff}%
+0 %{ assert tcpi_total_rto =3D=3D 6, tcpi_total_rto}%

   +4 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 3, tcpi_backoff}%
+0 %{ assert tcpi_total_rto =3D=3D 7, tcpi_total_rto}%

// RFC 6069 : this ICMP message should undo one retransmission timer backof=
f
+.5 < icmp unreachable host_unreachable [0:0(0)]
+0 %{ assert tcpi_backoff =3D=3D 2, tcpi_backoff }%
// RFC 6069 : this ICMP message should undo one retransmission timer backof=
f
 +.4 < icmp unreachable host_unreachable [0:0(0)]
+0 %{ assert tcpi_backoff =3D=3D 1, tcpi_backoff }%
// RFC 6069 : this ICMP message should undo one retransmission timer backof=
f
 +0 < icmp unreachable host_unreachable [0:0(0)]
+0 %{ assert tcpi_backoff =3D=3D 0, tcpi_backoff }%

+.1 > S 0:0(0) win 65535 <...>

+0 %{ assert tcpi_backoff =3D=3D 1, tcpi_backoff }%

// RFC 6069 : this ICMP message should undo one retransmission timer backof=
f
+.6 < icmp unreachable net_unreachable [0:0(0)]

+0 %{ assert tcpi_backoff =3D=3D 0, tcpi_backoff }%

+.4 > S 0:0(0) win 65535 <...>

+0 %{ assert tcpi_backoff =3D=3D 1, tcpi_backoff }%

//RFC 6069 : other ICMP messages should not undo one timer backoff
+0 < icmp unreachable source_route_failed [1:1(0)]
+0 < icmp unreachable net_unreachable_for_tos [1:1(0)]
+0 < icmp unreachable host_unreachable_for_tos [1:1(0)]

+0 %{ assert tcpi_backoff =3D=3D 1, tcpi_backoff }%
+2 > S 0:0(0) win 65535 <...>
+0 %{ assert tcpi_backoff =3D=3D 2, tcpi_backoff }%

