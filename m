Return-Path: <netdev+bounces-245311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF2CCB5CD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B25F4303F804
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B80A3376A9;
	Thu, 18 Dec 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRpb6VN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD4337686
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766052638; cv=none; b=h/gz4/YWwli+bjam6TIwRzq7PLdGms0fXlet7PyI//m19QvGyJVOMFyzYm3k0sUsGaSEWSjn3OGm6/iJzlfrIXgE6zQPmXObARzOnZf+Bi2WiDoJbDyG/Z8R1X8H7/c9ek75W2h3wPbzbfk4ZgX2Znm/LNVR6eF5ouj/dItm5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766052638; c=relaxed/simple;
	bh=xlbltzW98md8Ovv50mGCzQ7+wTXEZ4Dnj+0R+r+HDFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBhP7IPQmN44HdfpqSfs6V5pBzY5xgLoGSNixMXCREIYLALj9imqcqYJVo6EMbYp7qAJM0igYFj2hcnb5MsK/su12rZcNDrRO9n07SOGVL1e5xKcKo8HylVm7TzxIw6FnzrwYszJ7zNcLzDYzxGjJp1rAUnJKSR3/9WOcWYK//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRpb6VN1; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c696717dbso3397217b3.1
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766052636; x=1766657436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2izsuzgBiwcgs1HT3D4MKwQdxz9XkpGFjjyrMiRXPSg=;
        b=lRpb6VN1u7FBwoQWKEDmFro+BG2I1/U21tLf24s/nLXANnd43/c0gHbxWc61mPC98c
         U71boLB/E4URKCotz46y0dMxa2zJ5m9eGBtwFwT4qmyeRzVZqCpY4m05l33CHwXGYtYX
         ZvaL+lqcG7znFVYz4wzMz9/HmTD23gFy5idgzaCzM+tPe5hZ4TvHgkVO+aGtd01bOwk8
         Mkngq+4HTkkJIiUskqZ3Ndj5pxVG83wI1rirLZdWtAPY0c8CQSmDjJat/GVGw4ASJw6z
         t3cNfJez0jTpkxGP8MYv1wuyiRHldWF6RoT60k+G9iom/pSDH2iDhFMiZV1/F0KRpJFW
         qG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766052636; x=1766657436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2izsuzgBiwcgs1HT3D4MKwQdxz9XkpGFjjyrMiRXPSg=;
        b=w9Wfo2luF+RmsidtSRkFocCn4Ds3kTHPJBDG0/itv3HeOfmv+dSnTUvsSBfPPwhZkq
         GyWkZ2CSZM/ZKMmd/JtPGKO9Nr+cDXSXHYCxCWyYkKJtPk9T+R6gEbQ6WoGnL86D2m8d
         b6KXFQQcYcY1oM4CGVqnr/AvPYarn5lpPCXC68tnYmF7ByqFlQiw1nQ2SHFAmAHcdSzj
         P1msB6eJjmy5oBzuCZK1pO7qs4IO04pKpcWD4gUC1yulIXK+N8l3rg7Wdf3AwT+pIN/q
         e7qKbPoljGe2uARPy73Qxr7SHuM98nrX95yqS5SZ17ggLepv1jCMV6UwUaDqH421yF5B
         /fvw==
X-Forwarded-Encrypted: i=1; AJvYcCXZI0VX8XgrFuVQTa8XoAwYAyP5uPyX+nFi0yO7LA34hynh4uJUQbjxgOEeu60HIc2noyj8M3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrw/G259U1OhTo1JP9I64MmEe2NyaiOR9RXVoV3HY+vl5Xt6xK
	YL4sgVcdk6RcLbW67e6GvtmGrO98frZizLRwxYFuU/SFdsHRUTr59U//3QtZCzC4jiQ6tSci9QD
	X7JYd3AzPR6xIZUd3EZCaYPMEnDTuG/rVZ/8hgEA9
X-Gm-Gg: AY/fxX6QwGbJvPyHQQ9/bzQfPaQRqBtUwPlwoOn68fVJCJtJKBMgrZ2wuQii3zSRVaY
	pB2tL6veRlbcs8v+yZImvb32t1Y25m3u8ekQfEXNymwu1vsVqPV3AGgJ+gMspRRc45TmMESEahA
	O0ROvh4hravbovs4dYqN/L4YAer1SnbLcvago05fxMmIE9+1VBRc7Eg4jRqc7p61thflxHdxoSQ
	od7vHc68fh7nvK/IL7F0qplpJeXaLCfOBzupsaB35/e9aCUGG0R64Q9TrhY5WIwGJUhcSse
X-Google-Smtp-Source: AGHT+IGODJgqVrFF7UeDhNiZ88jqKpgzyBoLvFTeuJZqg883ffoX7opeUwfLhfuFrdYFmzXcDkYUZ7jZqutX5Opfrc0=
X-Received: by 2002:a05:690e:691:b0:63f:b9b3:9bc with SMTP id
 956f58d0204a3-64555600b0fmr12827238d50.42.1766052635464; Thu, 18 Dec 2025
 02:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-8-edumazet@google.com>
 <cd44c0d2-17ed-460d-9f89-759987d423dc@proxmox.com> <8f8836dd-c46f-403c-b478-a9e89dd62912@proxmox.com>
In-Reply-To: <8f8836dd-c46f-403c-b478-a9e89dd62912@proxmox.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Dec 2025 11:10:24 +0100
X-Gm-Features: AQt7F2pdohxoYoJeLYPafoYsfgyag4oMPKq-wU6suXAW30HZ1TqlYEckXLxI1OE
Message-ID: <CANn89iL=MTgYygnFaCeaMpSzjooDgnzwUd_ueSnJFxasXwyMwg@mail.gmail.com>
Subject: Re: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
To: Christian Ebner <c.ebner@proxmox.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	lkolbe@sodiuswillert.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 10:31=E2=80=AFAM Christian Ebner <c.ebner@proxmox.c=
om> wrote:
>
> Hi,
> to add some more information gained.
>
> pcaps obtained via tcpdump of the traffic while in a stale state show
> the following recurring pattern:
>
> 41      0.705618        10.xx.xx.aa     10.xx.xx.bb     TCP     66      [=
TCP ZeroWindow] 8007 =E2=86=92 55554
> [ACK] Seq=3D1 Ack=3D28673 Win=3D0 Len=3D0 TSval=3D2656874280 TSecr=3D1348=
075902
> 42      0.705662        10.xx.xx.aa     10.xx.xx.bb     TCP     66      [=
TCP Window Update] 8007 =E2=86=92
> 55554 [ACK] Seq=3D1 Ack=3D28673 Win=3D7 Len=3D0 TSval=3D2656874280 TSecr=
=3D1348075902
> 90      0.914606        10.xx.xx.bb     10.xx.xx.aa     TCP     7234    5=
5554 =E2=86=92 8007 [PSH, ACK]
> Seq=3D28673 Ack=3D1 Win=3D139 Len=3D7168 TSval=3D1348076111 TSecr=3D26568=
74280
>
> Output of `ss -tim` show the sockets being severely limited in buffer siz=
e:
>
> ESTAB                          0                               0
>
> [::ffff:10.xx.xx.aa]:8007
>        [::ffff:10.xx.xx.bb]:55554
>           skmem:(r0,rb7488,t0,tb332800,f0,w0,o0,bl0,d20) cubic
> wscale:10,10 rto:201 rtt:0.085/0.015 ato:40 mss:8948 pmtu:9000
> rcvmss:7168 advmss:8948 cwnd:10 bytes_sent:937478 bytes_acked:937478
> bytes_received:1295747055 segs_out:301010 segs_in:162410
> data_segs_out:1035 data_segs_in:161588 send 8.42Gbps lastsnd:3308
> lastrcv:191 lastack:191 pacing_rate 16.7Gbps delivery_rate 2.74Gbps
> delivered:1036 app_limited busy:437ms rcv_rtt:207.551 rcv_space:96242
> rcv_ssthresh:903417 minrtt:0.049 rcv_ooopack:23 snd_wnd:142336 rcv_wnd:71=
68
>
> This would indicate that the buffer size not growing while in this
> state, therefore limiting the rcv_wnd?

Can you give us (on receive side) : cat /proc/sys/net/ipv4/tcp_rmem

It seems your application is enforcing a small SO_RCVBUF ?


I would take a look at

ecfea98b7d0d tcp: add net.ipv4.tcp_rcvbuf_low_rtt
416dd649f3aa tcp: add net.ipv4.tcp_comp_sack_rtt_percent
aa251c84636c tcp: fix too slow tcp_rcvbuf_grow() action

After applying these patches, you can on the receiver :

perf record -a -e tcp:tcp_rcvbuf_grow sleep 30 ; perf script

