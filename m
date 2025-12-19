Return-Path: <netdev+bounces-245483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59491CCEF83
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CB13031378
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E5261B9B;
	Fri, 19 Dec 2025 08:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nahs+31y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60799259C84
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132650; cv=none; b=S0Q8ONvEGzIZRhuFC2wG18wG1bKAf65QUk+mfZ7y00jWBfVvkYO1CYXgMwbdN1IPbmEiwWN/hsBwxh5caTAP51n4ug9XzCyypYWvZD96Xz3zUVkoCSF3YuqvsNeWOTGpVOacirfTb7GcJnW1TcvnWxpW+oIFkAeKAkuXdGa4suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132650; c=relaxed/simple;
	bh=wmMqydHXVwVYuxVSHvKKKmlgmtclKGJa9S6QbkFm1gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YhAgiZGufvCAssH4D9Fxjzp983cmVP/Ytwz83G7yibt0cJkXL6SWfxTzzlzZozvlpj/qn56LWdccF7qJ4zMf3MKHD+bb3pPRlkASh70aVG4PHRIMs0L3MU+FNpBJqMWSdU6d78wZD4BpMsfPCH6TBXxwG/LjhB3rDdhcxslgJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nahs+31y; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4eda6c385c0so11586451cf.3
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766132647; x=1766737447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkSGancBaCnna4Do4TaEew5+hf+c6J3xjTdxawApkGI=;
        b=Nahs+31y3lW6SU2BOP0/S5BX+b6wBTM4AvqJVjPYZ/Dep03oeZtWS6E2Oez3/cQlnp
         jffAMt8ZA7huA2PcvMWhACzllavjK6agjbsy4f5CCm62AkmLaruzFLhXKNmO2NxibSve
         Rx+AWi7UlGCVCS9fpX3xWvOGreH7rELlTHUBBOgzQ675tA1Z6PDfQpYF4j38gyjE+7ME
         /Jh0769Q7z4gadMkKjjnOTwGLaUtCrB+JFT9XnYhrQqiRmIIfJOlbBgAD63k6LqTLnMB
         unJG3q0LaUyg06IiolIG2Ws2r8KbRibqSD2omD1JLMERhMvDrCuZjhkQ3V5JDUFmSfr8
         zOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766132647; x=1766737447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkSGancBaCnna4Do4TaEew5+hf+c6J3xjTdxawApkGI=;
        b=v7uqFezonBrym6ujjTTkZDZqYxWUh1zZ9puTS1D5e4bCOp8dg/bB8EC5yEaWsJLL02
         feF7kog6Jp2hsDxvK2QTWKASiLdPBiLFC7rd90ChHZq3X/EgOOeyDPoeXrYcl1Hg80ys
         F7GNwrbuvR97q/H1VuP1zUt+jww4fuBHjGLZN1KR6+8i1ndV+rUsn6XBWuAqBNtKJZBc
         OjqD5eiwNqA81ceC6206j/aMSd4fO4+px8m6U7EaTaFbujdOApbcPRiQW4BtcfY9N8ah
         OCpflWT+Gry/To/CdZ2GWPEQ0azW+wUWLHxgwpUiSRUD4ykL0Z1YakrLu97NKy4mMnYB
         sGxw==
X-Forwarded-Encrypted: i=1; AJvYcCXA2LbwDvyo1xqtMcdV6luyoG+/HgiRdVqrb2o40JEjMeL5IC1zU9Tkzz4PO1e9I+CYGd4sRDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+XOxYQcFBLFrcwH2So1hKl83P02LH/vwZXeX/vabD6MAe+ML
	xjm+KY5HfY6VDK0lu/huXdWVtXcU4Wy0k/AKuoLjS1hWSLFnVofzPqmPPamm3sOaLJ6wnO5cJNP
	FbSD0mBu8Ic7mKO2iuM6fYAK/IfFQn/kuhXKmJ090
X-Gm-Gg: AY/fxX6kO72jRC9BKTjT2kSV+DZ40BApnLDYjdNdFgyx5fzwA/X/Gg4fouRGxLiqR8y
	CT8yuB7pj0qvfADuBQ2gaSZpaLqGGA0NLaXMhZC404tDmmL6+haA7Oa+3LONbQeASSmsEupHY/c
	8FOSHgw/VKuq/XV4o3q4x7yzISBfOt9fb+z22r41BwPb8GUeITNXtg3Wpi7vsvv8+GIK7lKmnca
	ZMb5hCX7uv/KmXDN+8eitrRxWB8rv38nYXcqGtSoAmD2LfLQBUfRz2dzlzmOvL+Z2Rh0Q==
X-Google-Smtp-Source: AGHT+IG8JhsbZlC+uCgw3wTeA6euWqJA9vQM6oGvPdgJ1bk+RkyHCI113EzH/+5EQol8LMATungW/K9lKxK6aN5bOpw=
X-Received: by 2002:a05:622a:2b49:b0:4f1:cab1:9d3c with SMTP id
 d75a77b69052e-4f4abda9df8mr29328261cf.57.1766132646874; Fri, 19 Dec 2025
 00:24:06 -0800 (PST)
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
 <64d8fa05-63a2-420e-8b97-c51cb581804a@proxmox.com>
In-Reply-To: <64d8fa05-63a2-420e-8b97-c51cb581804a@proxmox.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 19 Dec 2025 09:23:55 +0100
X-Gm-Features: AQt7F2o4OIIIQs1riUaCGwE2JUOsyqMbEdETfS6Lsl_5y1UpK2WRXNSd3GCowBI
Message-ID: <CANn89iKPVPHQMgMiA=sum_nAjDg6hK0WSzHjP4onUJhYkj1xUQ@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Christian Ebner <c.ebner@proxmox.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	lkolbe@sodiuswillert.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:58=E2=80=AFPM Christian Ebner <c.ebner@proxmox.co=
m> wrote:
>
> On 12/18/25 2:19 PM, Eric Dumazet wrote:
> > On Thu, Dec 18, 2025 at 1:28=E2=80=AFPM Christian Ebner <c.ebner@proxmo=
x.com> wrote:
> >>
> >> Hi Eric,
> >>
> >> thank you for your reply!
> >>
> >> On 12/18/25 11:10 AM, Eric Dumazet wrote:
> >>> Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rmem
> >>
> >> Affected users report they have the respective kernels defaults set, s=
o:
> >> - "4096 131072 6291456"  for v.617 builds
> >> - "4096 131072 33554432" with the bumped max value of 32M for v6.18 bu=
ilds
> >>
> >>> It seems your application is enforcing a small SO_RCVBUF ?
> >>
> >> No, we can exclude that since the output of `ss -tim` show the default
> >> buffer size after connection being established and growing up to the m=
ax
> >> value during traffic (backups being performed).
> >>
> >
> > The trace you provided seems to show a very different picture ?
> >
> > [::ffff:10.xx.xx.aa]:8007
> >         [::ffff:10.xx.xx.bb]:55554
> >            skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic
> > wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000
> > rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478
> > bytes_received:1295747055 segs_out:301010 segs_in:162410
> > data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308
> > lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps
> > delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:96242
> > rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_wnd:=
7168
> >
> > rb7488 would suggest the application has played with a very small SO_RC=
VBUF,
> > or some memory allocation constraint (memcg ?)
>
> Thanks for the hint were to look, however we checked that the process is
> not memory constrained and the host has no memory pressure.
>
> Also `strace -f -e socket,setsockopt -p $(pidof proxmox-backup-proxy)`
> shows no syscalls which would change the socket buffer size (though this
> still needs to be double checked by affected users for completeness).
>
> Further, the stalls most often happen mid transfer, starting with the
> expected throughput and even might recover from the stall after some
> time, continue at regular speed again.
>
>
> Status update for v6.18
> -----------------------
>
> In the meantime, a user reported 2 stale connections with running kernel
> 6.18+416dd649f3aa
>
> The tcpdump pattern looks slightly different, here we got repeating
> sequences of:
> ```
> 224     5.407981        10.xx.xx.bb     10.xx.xx.aa     TCP     4162    4=
0068 =E2=86=92 8007 [PSH, ACK]
> Seq=3D106497 Ack=3D1 Win=3D3121 Len=3D4096 TSval=3D3198115973 TSecr=3D304=
8094015
> 225     5.408064        10.xx.xx.aa     10.xx.xx.bb     TCP     66      8=
007 =E2=86=92 40068 [ACK] Seq=3D1
> Ack=3D110593 Win=3D4 Len=3D0 TSval=3D3048094223 TSecr=3D3198115973
> ```
>
> The perf trace for `tcp:tcp_rcvbuf_grow` came back empty while in stale
> state, tracing with:
> ```
> perf record -a -e tcp:tcp_rcv_space_adjust,tcp:tcp_rcvbuf_grow
> perf script
> ```
> produced some output as shown below, so it seems that tcp_rcvbuf_grow()
> is never called in that case, while tcp_rcv_space_adjust() is.

Autotuning is not enabled for your case, somehow the application is
not behaving as expected,
so maybe you have to change tcp_rmem[2] if a driver is allocating
order-2 pages for the 9K frames.

You have not given what  was on the sender side (linux or other stack ?)

