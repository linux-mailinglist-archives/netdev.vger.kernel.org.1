Return-Path: <netdev+bounces-142708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC29C00F0
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA24628388E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298E1CC16C;
	Thu,  7 Nov 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0h5XFmM1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8C192B73
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730971028; cv=none; b=MYw2SgmVzOcMhu7oDkQQ9sZNfOutb6+Eh41RHdJwOgZBHeYu/elgLz4ObgEjlAE9iufdTlPBKxK47mer04bTjbW4/fck1n8Ctlf1IOcDOp4LIZhYAYlMAynuwmjZ75WwIM0czNG8UQbnRkcJgdHkMmJ/wXYCethNM1u3Al4/6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730971028; c=relaxed/simple;
	bh=blNHLzKVHO6DcrVFuLeTQ+4ekd4YcIcxVGOQTIuPzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIVg3ijetkGN+S+p2XORlDoOVl6qCG74S3yZwD8SXWW/MNLbPJJ6msg4Bjbu8qOxvuJ6+1WupkP4a5f+xGPvyCjYotWFuGwsCY9zhfvzny0uBlj2euEBX6eFX3qNAqeec+XIq1uCFjSFa6fl51b7q7ndyx+7ODqzxoUsxLT0JwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0h5XFmM1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cb6ca2a776so1016945a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730971025; x=1731575825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9FLGSqjaPcXujXKKAaAvnKAQR1QYT3B2QZtTLdsg1E=;
        b=0h5XFmM1jta0Y9ptMD/xbmNQHvOAvMa86DcfnoxQdKZQGSCdSbxCUrFCCcFs/o2Pmp
         Tt1m31l4MY11gvz72/IsPnNs8n0F22J0bDZ4uVmyF/sXEhXfOIMiGH2qvg3Zcy45YGfX
         7NNJQTRyPyruvefaunbD4nbURsdqtACYCdpmS6h4SUmtKcBkAnfgZJeGAEFSk+Y+kxMM
         feup+g0+MAG141oXJfXz5XfbCyEkTRUJ4mMvFly8WLEKhGHzN3NCFAK2pb7di/QBJsVW
         gQpmp0pz7K4J7L9Y0YPk5tF0kRkxglj+5JuyJo+Gi2Oo65+N12LtTrqaG9xQ74AHrT+W
         sRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730971025; x=1731575825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9FLGSqjaPcXujXKKAaAvnKAQR1QYT3B2QZtTLdsg1E=;
        b=kBkNswva+PEtG7NNE8T9/apJ9SnqRl0o+Q+/0z9W/oaChiR9W/v/7FD9uKLunGUL+f
         uvjX73ZCQVWwXT84r09S+6pfHlIj/xjAAkDj3KN5zphCqvyeHSLXvraZpAo/AccRl3L7
         f2CSvb+s7cF1tNa0HKRXhDIvc7Sk61fgThMjXVjC2S239enKjWEEhFzPfDOV/zDfq7ry
         2nC3OGJYI58aC6t9z87PvvQTPGWlulRwoC43WryBt4jIEG4f4Pdmx+O5yj6++7kHub6/
         JQplF624hFTwqdM9Eh2lucsKzXM0ck3ae0G0nTIyE9NEIgOGM6LwfV58WmenNKbJ/uGP
         IQKA==
X-Forwarded-Encrypted: i=1; AJvYcCVNA8swZBawJ7Qz4u1rHP78Ghz+JfZmhAjf5tiKxapRDozB4woGeww/OasX42hV3ZUblYdxMDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbZxQEP/3DLUTrMd7ElqTF6hPOYyG+TUXknZvfhxCHvXSRtmG
	dCNHycM+Sh5Amq5yy1kinDOnhPk2HbhL45W7RQnKJiauIaYhzEsS3Xmaote22p4fh3BXZkSurVL
	KecUKNGk2eEKrwJ1fzJuJDOIoI+nbK9jPJqpe
X-Google-Smtp-Source: AGHT+IEErrzgWdUaiwRmJHBzKA9roe+yPrpt0k5jO/ApQGdcegrjtkKP/rlIte6g6AUajWJnpXkoioocBr9tJVj6zUs=
X-Received: by 2002:a05:6402:2554:b0:5ce:acf1:e667 with SMTP id
 4fb4d7f45d1cf-5cf05a33e5cmr424338a12.26.1730971024685; Thu, 07 Nov 2024
 01:17:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
 <92c1d976-7bb6-49ff-9131-edba30623f76@linux.alibaba.com> <CAL+tcoBZaDhBuSKHzGEqgxkzOazX3K-Vo2=mCdOy+iLp4sPAhg@mail.gmail.com>
 <75708260-7eb4-42fe-9d9b-605f8eef488b@linux.alibaba.com> <CAL+tcoBA78svT_vTMOLV-pbwKM1o_SDbjs7AAZLhHOtrd8akBg@mail.gmail.com>
 <CANn89iL5df5_EiDX7JxaFbfmZ9gDo=8ZyLXhbZs+-yp8zVD=GA@mail.gmail.com> <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com>
In-Reply-To: <CAL+tcoBCqXiQ33XZv61vCes7_XV83DC0HSPy_w6eCn4pzzJeqA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 10:16:53 +0100
Message-ID: <CANn89iLEPSBnvVe+qPZ1SeQ86JYh3CoR_LioDGwdPNumqyYWLw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to
 failure in tcp_timewait_state_process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Philo Lu <lulie@linux.alibaba.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:01=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Nov 7, 2024 at 4:37=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Nov 7, 2024 at 9:27=E2=80=AFAM Jason Xing <kerneljasonxing@gmai=
l.com> wrote:
> > >
> > > On Thu, Nov 7, 2024 at 4:22=E2=80=AFPM Philo Lu <lulie@linux.alibaba.=
com> wrote:
> > > >
> > > >
> > > >
> > > > On 2024/11/7 16:01, Jason Xing wrote:
> > > > > On Thu, Nov 7, 2024 at 3:51=E2=80=AFPM Philo Lu <lulie@linux.alib=
aba.com> wrote:
> > > > >>
> > > > >> Hi Jason,
> > > > >>
> > > > >> On 2024/11/5 10:55, Jason Xing wrote:
> > > > >>> From: Jason Xing <kernelxing@tencent.com>
> > > > >>>
> > > > >>> We found there are rare chances that some RST packets appear du=
ring
> > > > >>> the shakehands because the timewait socket cannot accept the SY=
N and
> > > > >>> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> > > > >>>
> > > > >>> Here is how things happen in production:
> > > > >>> Time        Client(A)        Server(B)
> > > > >>> 0s          SYN-->
> > > > >>> ...
> > > > >>> 132s                         <-- FIN
> > > > >>> ...
> > > > >>> 169s        FIN-->
> > > > >>> 169s                         <-- ACK
> > > > >>> 169s        SYN-->
> > > > >>> 169s                         <-- ACK
> > > > >>> 169s        RST-->
> > > > >>> As above picture shows, the two flows have a start time differe=
nce
> > > > >>> of 169 seconds. B starts to send FIN so it will finally enter i=
nto
> > > > >>> TIMEWAIT state. Nearly at the same time A launches a new connec=
tion
> > > > >>> that soon is reset by itself due to receiving a ACK.
> > > > >>>
> > > > >>> There are two key checks in tcp_timewait_state_process() when t=
imewait
> > > > >>> socket in B receives the SYN packet:
> > > > >>> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> > > > >>> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < =
0)
> > > > >>>
> > > > >>> Regarding the first rule, it fails as expected because in the f=
irst
> > > > >>> connection the seq of SYN sent from A is 1892994276, then 169s =
have
> > > > >>> passed, the second SYN has 239034613 (caused by overflow of s32=
).
> > > > >>>
> > > > >>> Then how about the second rule?
> > > > >>> It fails again!
> > > > >>> Let's take a look at how the tsval comes out:
> > > > >>> __tcp_transmit_skb()
> > > > >>>       -> tcp_syn_options()
> > > > >>>           -> opts->tsval =3D tcp_skb_timestamp_ts(tp->tcp_usec_=
ts, skb) + tp->tsoffset;
> > > > >>> The timestamp depends on two things, one is skb->skb_mstamp_ns,=
 the
> > > > >>> other is tp->tsoffset. The latter value is fixed, so we don't n=
eed
> > > > >>> to care about it. If both operations (sending FIN and then star=
ting
> > > > >>> sending SYN) from A happen in 1ms, then the tsval would be the =
same.
> > > > >>> It can be clearly seen in the tcpdump log. Notice that the tsva=
l is
> > > > >>> with millisecond precision.
> > > > >>>
> > > > >>> Based on the above analysis, I decided to make a small change t=
o
> > > > >>> the check in tcp_timewait_state_process() so that the second fl=
ow
> > > > >>> would not fail.
> > > > >>>
> > > > >>
> > > > >> I wonder what a bad result the RST causes. As far as I know, the=
 client
> > > > >> will not close the connect and return. Instead, it re-sends an S=
YN in
> > > > >> TCP_TIMEOUT_MIN(2) jiffies (implemented in
> > > > >> tcp_rcv_synsent_state_process). So the second connection could s=
till be
> > > > >> established successfully, at the cost of a bit more delay. Like:
> > > > >>
> > > > >>    Time        Client(A)        Server(B)
> > > > >>    0s          SYN-->
> > > > >>    ...
> > > > >>    132s                         <-- FIN
> > > > >>    ...
> > > > >>    169s        FIN-->
> > > > >>    169s                         <-- ACK
> > > > >>    169s        SYN-->
> > > > >>    169s                         <-- ACK
> > > > >>    169s        RST-->
> > > > >> ~2jiffies    SYN-->
>
> It doesn't happen. I dare to say the SYN will not be retransmitted
> soon which I can tell from many tcpdump logs I captured.
>
> > > > >>                                 <-- SYN,ACK
> > > > >
> > > > > That's exactly what I meant here :) Originally I didn't expect th=
e
> > > > > application to relaunch a connection in this case.
> > > >
> > > > s/application/kernel/, right?
> > >
> > > No. Perhaps I didn't make myself clear. If the kernel doesn't silentl=
y
> > > drop the SYN and then send back an ACK, the application has to call
> > > the connect() syscall again.
> >
> > My suggestion to stop the confusion:
>
> Oh, right now, I realized that Philo and I are not on the same page :(
> Please forget that conversation.
>
> My points are:
> 1) If B silently drops the SYN packet, A will retransmit an SYN packet
> and then the connection will be established. It's what I tried to
> propose and would like to see. It also adheres to the RFC 6191.
> 2) As kuniyuki pointed out on the contrary, sending an ACK (like the
> current implementation) instead of silently dropping the SYN packet is
> actually a challenge ack. If so, I think we need to consider this ACK
> as a challenge ack like what tcp_send_challenge_ack() does.

Like where ? Again, a packetdrill test will clarify all of this.

>
> I'd like to hear more about your opinions on the above conclusion.

