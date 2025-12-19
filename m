Return-Path: <netdev+bounces-245486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35392CCF050
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7418F300E929
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AEC2DF3CC;
	Fri, 19 Dec 2025 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qwr0qURZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7953A1E9E
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766133962; cv=none; b=FxRa76spzKpR9inEP0S09+M4tICNiHUDO5TMkMt/l3/HAFsT0aVEZ8n3gMaODeOwOj4DYAFSBmEMYmBCV6H93L/2rekEA75Aq4VWPnvcWBzzieq2rA+N/GgXEVrr4pkYFBDD4NO2IxO0/aFd9QGrg9KPq0qTnrXZHrJyTVFf+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766133962; c=relaxed/simple;
	bh=UPp5jXeYiYmHYmLqZeIb/XYMrk+d2yhwBE9nTU0yYHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffMuWefWS/pt5pwimjVDZzVo7VHOKqoRowigGa11+q/3om278ZipIfHJq41WqBdUcrIS/VhPvNLPIaaK0kQNng27CEhXPssfr/sSuJYHn54A3Qej3VBcrSONF8OsySZHMxl6bSNGL0otc8d76f1JoHHO9y3NX4BqBQWhpWwCaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qwr0qURZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b5ccceb382so174290585a.1
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766133959; x=1766738759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4qUWAJSqSJdIDM6w+n372g6r53Iod/UGsz9hXTuXwo=;
        b=Qwr0qURZAxZRSmBlOA2ehBiLnQTkUtJxicSEjWX71vf6xWLYlZKv/Hwn1iH5lrrbOQ
         NXLyhfQAouaNiNTKwre4P34By0FqohmspMi0ORvIALbnRRi3xtAlgSlaYCuXQXItM+br
         lDJf156GGR1EOqsH4hu3uIbXb6WwOcxfNEA6ImsRcIi3Ep2SDMiSfGMZqQ2IMLz1NOrw
         u2sbadSs67kgZrnNHsGsjuUrpNXVUZUneRQZ05acOMyRokO5uPU/+FtaZ3n84BAyJOOy
         sA8x8FcjKqZndOh+B5Ub87v2xsnE2txojUfsD6AXiw7iEeYhGpnsiQlX5EuzblCBckSB
         Ho+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766133959; x=1766738759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4qUWAJSqSJdIDM6w+n372g6r53Iod/UGsz9hXTuXwo=;
        b=q1pCwfiQXSQLod5YCcJefYLniMg5amcu3LjeHKvPX0tc2ERtHftkKeMiF1EsgioR1b
         paPpzxwzZazfUGZEfQpqDRVfGt/l7Ixp8ZPp8y5SFFt3u3goLvSoBNTkNAEte7EYbbme
         YWico7+UWcedXzo3ig3rFiywZNuHsRj8Z/lVCj+PECusiOw0swuSemlP9RBIHxK/CXCH
         lNsecVVBA42N0hS/acq2Cpt4L5sxWzWVe/f9dK//LJH3xSRQZwUjsmWvRCvrj7I9Kj4j
         uSfI52XMtuObbo0W8sjZb1ry/lNDqHpxIwR6ZhE3xPt8kTkTLEiQuYfhh/hx72YOZiwA
         tdUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+3bxlwEH3JncTGm++zC4WicIIbTyx+OWxU7IJuf2/LODe2BpLDAa1hiLasstgYsmHB3u9VZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNAoL4HXKj4uURXx0rrYdM+74P1CxcrjiQsAwNhJzP13WB/+OK
	+MX1aWtE2OPGBfia/jZ9xuQwuiT/3IoM9FZ3Z/oTxd2b2PPgSrGuE8oIU77+snUcDCMao3+DtYb
	r7OWeYWSBd+H0yYKgSV1GvcI+mJzdL56GDSBMevQN
X-Gm-Gg: AY/fxX54JFvSssmhQTsM/Dtx7RD323hQbQ6KFdS1uR1rTxLKcmgi7Y9x2/+ZK7Opr7B
	9IhXBXe0Xc4YK76a+lu2tdQ3ornrBsM7vPzSRmQHcbRb5pfLaI7v7NtLinuWaj57Ex54NNJ3XHA
	wt2xg4DTg6rAA9ofP8zcd9fi87n/96N54MUQjd5uLVPB5r2tvXgxM/QqA214Q+X8FM5c9Qw24JZ
	UjoEPhvSR3Fwx7LJa5ugSas7HUmdbAtuCMQMzFSg6sIwvu6ytIwEQymkmH/1GG2zyS7RQ==
X-Google-Smtp-Source: AGHT+IE5lpfln5PpERcfZxHwkaH7BBahCDvlCBdKIPsJ4uPnTakiAvM9i8QtHCuy5BK9pv3NvgT0F8udRST/S9q9KM0=
X-Received: by 2002:ac8:5882:0:b0:4ee:4126:661c with SMTP id
 d75a77b69052e-4f4abdcb96emr28730731cf.81.1766133958752; Fri, 19 Dec 2025
 00:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-8-edumazet@google.com>
 <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com> <8f8836dd-c46f-403c-b478-a9e89dd62912@proxmox.com>
 <CANn89iL=MTgYygnFaCeaMpSzjooDgnzwUd_ueSnJFxasXwyMwg@mail.gmail.com>
 <c1ae58f7-cf31-4fb6-ac92-8f7b61272226@proxmox.com> <CANn89iJRCW3VNsY3vZwurvh52diE+scUfZvwx5bg5Tuoa3L_TQ@mail.gmail.com>
 <64d8fa05-63a2-420e-8b97-c51cb581804a@proxmox.com> <CANn89iKPVPHQMgMiA=sum_nAjDg6hK0WSzHjP4onUJhYkj1xUQ@mail.gmail.com>
In-Reply-To: <CANn89iKPVPHQMgMiA=sum_nAjDg6hK0WSzHjP4onUJhYkj1xUQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Dec 2025 09:45:47 +0100
X-Gm-Features: AQt7F2rHLV9pYwtzuO4yUHRL3Bj2UPzGXcPeHP8mW9wSHfYXIIaGIgbyqv2O1Bo
Message-ID: <CANn89iKhZ=Ofy45PBrvLLE=nqv6X7CTvrpMdYMLKeVjpN6c-3A@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Christian Ebner <c.ebner@proxmox.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	lkolbe@sodiuswillert.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Dec 18, 2025 at 3:58=E2=80=AFPM Christian Ebner <c.ebner@proxmox.=
com> wrote:
> >
> > On 12/18/25 2:19 PM, Eric Dumazet wrote:
> > > On Thu, Dec 18, 2025 at 1:28=E2=80=AFPM Christian Ebner <c.ebner@prox=
mox.com> wrote:
> > >>
> > >> Hi Eric,
> > >>
> > >> thank you for your reply!
> > >>
> > >> On 12/18/25 11:10 AM, Eric Dumazet wrote:
> > >>> Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rmem
> > >>
> > >> Affected users report they have the respective kernels defaults set,=
 so:
> > >> - "4096 131072 6291456"  for v.617 builds
> > >> - "4096 131072 33554432" with the bumped max value of 32M for v6.18 =
builds
> > >>
> > >>> It seems your application is enforcing a small SO_RCVBUF ?
> > >>
> > >> No, we can exclude that since the output of `ss -tim` show the defau=
lt
> > >> buffer size after connection being established and growing up to the=
 max
> > >> value during traffic (backups being performed).
> > >>
> > >
> > > The trace you provided seems to show a very different picture ?
> > >
> > > [::ffff:10.xx.xx.aa]:8007
> > >         [::ffff:10.xx.xx.bb]:55554
> > >            skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic
> > > wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000
> > > rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478
> > > bytes_received:1295747055 segs_out:301010 segs_in:162410
> > > data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308
> > > lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps
> > > delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:96242
> > > rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_wn=
d:7168
> > >
> > > rb7488 would suggest the application has played with a very small SO_=
RCVBUF,
> > > or some memory allocation constraint (memcg ?)
> >
> > Thanks for the hint were to look, however we checked that the process i=
s
> > not memory constrained and the host has no memory pressure.
> >
> > Also `strace -f -e socket,setsockopt -p $(pidof proxmox-backup-proxy)`
> > shows no syscalls which would change the socket buffer size (though thi=
s
> > still needs to be double checked by affected users for completeness).
> >
> > Further, the stalls most often happen mid transfer, starting with the
> > expected throughput and even might recover from the stall after some
> > time, continue at regular speed again.
> >
> >
> > Status update for v6.18
> > -----------------------
> >
> > In the meantime, a user reported 2 stale connections with running kerne=
l
> > 6.18+416dd649f3aa
> >
> > The tcpdump pattern looks slightly different, here we got repeating
> > sequences of:
> > ```
> > 224     5.407981        10.xx.xx.bb     10.xx.xx.aa     TCP     4162   =
 40068 =E2=86=92 8007 [PSH, ACK]
> > Seq=3D106497 Ack=3D1 Win=3D3121 Len=3D4096 TSval=3D3198115973 TSecr=3D3=
048094015
> > 225     5.408064        10.xx.xx.aa     10.xx.xx.bb     TCP     66     =
 8007 =E2=86=92 40068 [ACK] Seq=3D1
> > Ack=3D110593 Win=3D4 Len=3D0 TSval=3D3048094223 TSecr=3D3198115973
> > ```
> >
> > The perf trace for `tcp:tcp_rcvbuf_grow` came back empty while in stale
> > state, tracing with:
> > ```
> > perf record -a -e tcp:tcp_rcv_space_adjust,tcp:tcp_rcvbuf_grow
> > perf script
> > ```
> > produced some output as shown below, so it seems that tcp_rcvbuf_grow()
> > is never called in that case, while tcp_rcv_space_adjust() is.
>
> Autotuning is not enabled for your case, somehow the application is
> not behaving as expected,
> so maybe you have to change tcp_rmem[2] if a driver is allocating
> order-2 pages for the 9K frames.

I meant to say : change tcp_rmem[1]

echo "4096 262144 33554432" >/proc/sys/net/ipv4/tcp_rmem

>
> You have not given what  was on the sender side (linux or other stack ?)

