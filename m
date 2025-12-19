Return-Path: <netdev+bounces-245507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B622CCF5C1
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E13E030D03E3
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33994311C09;
	Fri, 19 Dec 2025 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v8Qk6VyX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DF31195C
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139192; cv=none; b=B6XsWNSHwYpHx9BlFJ84BeAnIdPBbcYCaLQPHORzmTn4FB9Becg3/oACrtxm8q3cqVQH9oTOFmUCWEsKb6GKnD1fKjV5QAfpUGbSbo6j1LcTqWMbVt/AOnaarVzO071kiXkHgEhVfeXTuj94krI8mb35jols5P3SWXa5xQp7h6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139192; c=relaxed/simple;
	bh=HjPeugLOo1evBBS7lJJY22KFWIlby4pdlKB2C5ID8h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn6jSRTjYBwVkwBR2vXtZ4eHpUFBoUSvqA2IZTwCpJXzQbkgN4yteOx9Wc5LTA8NPfIp701Dyfwc0iVXey/n2fpNARv3hduVmhaJcLCH31tM4y2XVoKq8iOSAuaed/0mMyFqnKOxmTc+8vUM1hnVYQcySZxyYNxcO69M077J6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v8Qk6VyX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee1939e70bso16063021cf.3
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 02:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766139189; x=1766743989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqsBQLgA5yt65GAyHuh37T7rPyhK/PVYCOgbGiS3Zsc=;
        b=v8Qk6VyX8reBXFoFEhHwblVYLvwKKMEK0zBd0eUjVDAnh8j6FHchgz6hRN/pApfNF2
         88vQW/8Gl2oghuiZ5AGbIQoepF8vq2R8R3Ti3y+LASiYE3nri1J/Jms7Ac95/YnZVFoH
         5S46rpUZfEncs+1ZQxs2bidggjqoOtPsEHydcx4PQVsIiXYtIOPGh1cIG+AZY+RhzyEJ
         032Ngjt5S+31cRSf59YzR1Rs6ilUqU12m2lzYRI5hatJ0stYVbtoiGBja9X6LF/2R+9V
         rBc7ljb31q6qkzGq09A8ZlQCmccybzWLeXXUhnlM0EEBbKqi/IDecesQSeHZHZep10Cs
         3DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766139189; x=1766743989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqsBQLgA5yt65GAyHuh37T7rPyhK/PVYCOgbGiS3Zsc=;
        b=dnK4imX3wcIGNFI3DV/AFrAXULrLNdihdql/Br/y6bPTSJHqYRAtqVYHuZoDvtW7JZ
         XHkKyc7BZBPtf1kJsTjXU0409ePFHoDhM+TKpAjvP+n8PQRXKiV+EndrgX+oEGCukHwo
         LZPLD9m8z3y0kgBGwLNHpx2u6u+eyCAE8keVdlP6BlaHHanYd8y9lMneqL01KQLO3ViY
         ebGK+dIOs7MoYJjYAvqlxFSXAHT/o7YvlJj6SKONbViHtIM62S0iucAS6uTPClL9WMU7
         TOsePYCZmSN/NgXFK1ZT6eqpZijvr6o41eHkf6BLCvPcRi51/m3YZM1oBz1nIylTxe+i
         O94w==
X-Forwarded-Encrypted: i=1; AJvYcCUA4sOitHODrtxahF4MYaTtY3f7Y/H44777twd0rseFpLOur3rb8tJFLMG0yt9/azWb+XXhuuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDQCPt7CoGKNVfTyGhyjtfj5FWD5bXUATQYoDddOErI9e9hZ1
	tU7CBAYxfDegUyt5JHZQubIiwyV/GrokLCGna31qU6uhuhl0s0CE97TVf0Lvn0i4LhH/lUCxPrc
	uXI5hHxmG/IQg2h4eUVr9xnYtLVHjod9TeUCYwi5h
X-Gm-Gg: AY/fxX4MWCQypHOBv2Ne1NIJ9LH0UJWicpLIjpf2Pnp/XfMQKKLAxLJ562x6SFn5wk2
	8rFm3veMnIyofzGFqvVOQyZ2GL4y+Nd8Ah0T+8EugPrNd0v8WVTLxwtoiRWZikalLFVLGzPnbcW
	yfpl05HRPqOHvrVRjN/MoouHnR381B2ltbvTkTXWRMkY4d54hR8QXQzoX4JOONhA9dTBibTMjWW
	fCULnpfe9rWQRHZ0pcE2u2Vk7s2dP7ESLnuSxywHtsOlCpmDu1gDYeLtms7cO4109qx4NoNsngG
	OOun
X-Google-Smtp-Source: AGHT+IEQBZVskQAx9110q6DC9JmlK7PbqkOXkeGLPl0qjwytzTWZbYOQqtQlgVkXEVrplu5ZHaHvXbKtrIz9w/BzsLw=
X-Received: by 2002:ac8:5d04:0:b0:4ed:b570:2d4c with SMTP id
 d75a77b69052e-4f4abd7acadmr32382161cf.43.1766139188380; Fri, 19 Dec 2025
 02:13:08 -0800 (PST)
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
 <CANn89iKhZ=Ofy45PBrvLLE=nqv6X7CTvrpMdYMLKeVjpN6c-3A@mail.gmail.com> <4f1829d0-7d79-45bc-9006-65c4e3449a5e@proxmox.com>
In-Reply-To: <4f1829d0-7d79-45bc-9006-65c4e3449a5e@proxmox.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Dec 2025 11:12:57 +0100
X-Gm-Features: AQt7F2o8EN6GYelDF2nzu598V0gNZQV1ZUDi-GsapeUXNwogOQQ2nSdNCQmDZuU
Message-ID: <CANn89i+G+46d_sruU-ezOSJJU0SONaN6-GDyXAOg2BVSN9Px1w@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Christian Ebner <c.ebner@proxmox.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	lkolbe@sodiuswillert.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 11:00=E2=80=AFAM Christian Ebner <c.ebner@proxmox.c=
om> wrote:
>
> On 12/19/25 9:45 AM, Eric Dumazet wrote:
> > On Fri, Dec 19, 2025 at 9:23=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >>
> >> On Thu, Dec 18, 2025 at 3:58=E2=80=AFPM Christian Ebner <c.ebner@proxm=
ox.com> wrote:
> >>>
> >>> On 12/18/25 2:19 PM, Eric Dumazet wrote:
> >>>> On Thu, Dec 18, 2025 at 1:28=E2=80=AFPM Christian Ebner <c.ebner@pro=
xmox.com> wrote:
> >>>>>
> >>>>> Hi Eric,
> >>>>>
> >>>>> thank you for your reply!
> >>>>>
> >>>>> On 12/18/25 11:10 AM, Eric Dumazet wrote:
> >>>>>> Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rme=
m
> >>>>>
> >>>>> Affected users report they have the respective kernels defaults set=
, so:
> >>>>> - "4096 131072 6291456"  for v.617 builds
> >>>>> - "4096 131072 33554432" with the bumped max value of 32M for v6.18=
 builds
> >>>>>
> >>>>>> It seems your application is enforcing a small SO_RCVBUF ?
> >>>>>
> >>>>> No, we can exclude that since the output of `ss -tim` show the defa=
ult
> >>>>> buffer size after connection being established and growing up to th=
e max
> >>>>> value during traffic (backups being performed).
> >>>>>
> >>>>
> >>>> The trace you provided seems to show a very different picture ?
> >>>>
> >>>> [::ffff:10.xx.xx.aa]:8007
> >>>>          [::ffff:10.xx.xx.bb]:55554
> >>>>             skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic
> >>>> wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000
> >>>> rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478
> >>>> bytes_received:1295747055 segs_out:301010 segs_in:162410
> >>>> data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308
> >>>> lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps
> >>>> delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:9624=
2
> >>>> rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_w=
nd:7168
> >>>>
> >>>> rb7488 would suggest the application has played with a very small SO=
_RCVBUF,
> >>>> or some memory allocation constraint (memcg ?)
> >>>
> >>> Thanks for the hint were to look, however we checked that the process=
 is
> >>> not memory constrained and the host has no memory pressure.
> >>>
> >>> Also `strace -f -e socket,setsockopt -p $(pidof proxmox-backup-proxy)=
`
> >>> shows no syscalls which would change the socket buffer size (though t=
his
> >>> still needs to be double checked by affected users for completeness).
> >>>
> >>> Further, the stalls most often happen mid transfer, starting with the
> >>> expected throughput and even might recover from the stall after some
> >>> time, continue at regular speed again.
> >>>
> >>>
> >>> Status update for v6.18
> >>> -----------------------
> >>>
> >>> In the meantime, a user reported 2 stale connections with running ker=
nel
> >>> 6.18+416dd649f3aa
> >>>
> >>> The tcpdump pattern looks slightly different, here we got repeating
> >>> sequences of:
> >>> ```
> >>> 224     5.407981        10.xx.xx.bb     10.xx.xx.aa     TCP     4162 =
   40068 =E2=86=92 8007 [PSH, ACK]
> >>> Seq=3D106497 Ack=3D1 Win=3D3121 Len=3D4096 TSval=3D3198115973 TSecr=
=3D3048094015
> >>> 225     5.408064        10.xx.xx.aa     10.xx.xx.bb     TCP     66   =
   8007 =E2=86=92 40068 [ACK] Seq=3D1
> >>> Ack=3D110593 Win=3D4 Len=3D0 TSval=3D3048094223 TSecr=3D3198115973
> >>> ```
> >>>
> >>> The perf trace for `tcp:tcp_rcvbuf_grow` came back empty while in sta=
le
> >>> state, tracing with:
> >>> ```
> >>> perf record -a -e tcp:tcp_rcv_space_adjust,tcp:tcp_rcvbuf_grow
> >>> perf script
> >>> ```
> >>> produced some output as shown below, so it seems that tcp_rcvbuf_grow=
()
> >>> is never called in that case, while tcp_rcv_space_adjust() is.
> >>
> >> Autotuning is not enabled for your case, somehow the application is
> >> not behaving as expected,
>
> Is there a way for us to check if autotuning is enabled for the TCP
> connection at this point in time? Some tracepoint to identify it being
> deactivated?

tcp_rcv_space_adjust() has a tracepoint.

You can also use bpftrace to collect more fields from TCP sockets.

If trace_tcp_rcvbuf_grow() is not called, then the application drains
its receive queue too slowly
for autotune to quick in, or the sender is limited.


>
> >> so maybe you have to change tcp_rmem[2] if a driver is allocating
> >> order-2 pages for the 9K frames.
>
> Same here, is there a way for us to check this? Note however that we
> could not identify a specific NIC/driver to cause the behavior, it
> appears for various vendor models.

I don't have this issue using regular tcp_stream tests and 9K traffic.
Can you try standard programs instead of in-house ones ?
(netperf, neper, iperf3...)

Use a bpftrace program to gather tp->scaling_ratio

bpftrace -e '
k:tcp_rcv_space_adjust {
  $sk =3D (struct sock *)arg0;
  if ($sk->sk_rcvbuf > 20000) { return ; }
  $tp =3D (struct tcp_sock *)arg0;
  @scaling[$tp->scaling_ratio] =3D count();
}
'


>
> >
> > I meant to say : change tcp_rmem[1]
> >
> > echo "4096 262144 33554432" >/proc/sys/net/ipv4/tcp_rmem
>
> Okay, thanks for the suggestion, let me get back to you with results if
> this changes anything.
>
>
> >> You have not given what  was on the sender side (linux or other stack =
?)
>
> Clients are all Linux hosts, running kernel versions 6.8, 6.14 or 6.17.
> No other TCP stacks.
>
> Best regards,
> Christian Ebner
>

