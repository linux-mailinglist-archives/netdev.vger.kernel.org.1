Return-Path: <netdev+bounces-161087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA547A1D40E
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 11:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D96188797B
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B501FDA7A;
	Mon, 27 Jan 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="11UDfTpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F8135A63
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972381; cv=none; b=T7qPvJTPNaslrVNLYSy/5rnb3NrtGVcoL+FbvQeamv83Rh5iaVqZMHhfsHmTWv9oWEACFxnN4ai27A9XNciLnUGrxxz/gUD+bVsE+f6a7pX1RUHk9KoKkvWhM5EkLducV9qMyn5qjppLZA8dZdttJnPaIi/c3vIOStsIM1nZENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972381; c=relaxed/simple;
	bh=5Lifs3KGI40OaqehMKK9Y8v1k7tnm8krtzXb/s3F6Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRANYRqWSjsJBVHwA03IE6rS+TSTrp8lmqwoaGrAiGCITYADtUwIM/TOYIWPGPH+tjiVlwFiQej8smm4SALBzhiO7I0yY6yqYIt0OFDeedRh0UXuB82hlWnG2f2yB6Heu1C0B4e4AvMtHJXWqeh40j+Fx27lWATakyfaKts0pHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=11UDfTpI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so8248112a12.2
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737972378; x=1738577178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH4CnsVoFIKrMW+ju8mTDp4FzGeBRfrpK/9n+IGNSMk=;
        b=11UDfTpIcukuQ4mPIs/gz+FFZcOp3hFFRVEnzMe482mWSPd1CqYJWjxgwhZXgTaKoX
         bZxPC9uSd0NNGuhh5btNKyOi/eX3pxKPIz7fcUPnk1ipDa9lSGOwkGYWgonJoUt4BuLP
         +w4fl48ovtqwgeXyBGVycK3XptrFMuwFuGGy0MubzC6cMtxhzjX4szDtApd93mnzrz/h
         LFyoT/SIQ71f85rl/g5VbP/KyiqIatWtuWC+NaXQAsMK0QJRMFL6cQYOmzn2OGTYf5XN
         m6nlWjdz0172oG/a6zKD4zT8DYbkeq+nr+1HIIg285GBnegAUmGgudoICn9v/urPzUE4
         WVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737972378; x=1738577178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH4CnsVoFIKrMW+ju8mTDp4FzGeBRfrpK/9n+IGNSMk=;
        b=A+EEpZ8zXmUVZIMHlPeFomXKvelG/xp7Eio4rtna4zWdV2Yo0XXR7WfWWbktWO0Pmi
         QkZf35/ayH8/GyEdzqakJW6zLn7NzLzTR5x6SA+GN2FsMY5KSWU85V77mpyWf8GhRdr+
         lRoTdS/L5JN7ejz0JGN7JAKNIU5moWhO/OcAb4hTZZlD9ms4EBQyQS/+VjArW2uV77jo
         NJaiq/Y4VTPUQWUWqPjekwMrKEarm9Ah/R44jklVnPVEgK7ogaGfjokM2/kLzCIMfmnV
         VuiImX+1hNvwvzUYJyMSd9XHLEJI0bVliJ3ULta0y7n274kVr/pp++mmyIMFIgB43g7l
         /9+w==
X-Forwarded-Encrypted: i=1; AJvYcCXe3LAsFEAFlrK0Jx+n7HZwmJilQBBiXo4DdGdvUKmjJA/CO7i1U5fwSE0tcZ5yxSVRsBr719g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pW8n+N021EMNQ+hKzAk3WU8syF7VKhf3+13tLofzC/p7SFti
	A30z4X9JMb6x9xBt8Qk+yhl1HLtxCArLSn+cgygoNX/mNyCyYjq88R8CGBCHxvt2RrFKhxPfBet
	7aVhz0qEjffN2EQi/ED3obFuFstWi5bGIIvKV
X-Gm-Gg: ASbGncv5tM1RdE8FPNv2TfsIsKfvl64gX4HEMml00eEflev2+CgHvySXEDTfzWdPOuJ
	99NnlSU9BJl6obJo7wjboAfTvh26W/msiLmXp5okLWkRiknhGCWscxslUNb6+Iw==
X-Google-Smtp-Source: AGHT+IEK0mfFCDU+rZIY3KCdjtBVZ94LbVI87w4XHtZxLqFTpobyjupwLsSAXcuDdRgIJurDmKfQLwh2SuyS+UzEkEc=
X-Received: by 2002:a05:6402:1e96:b0:5dc:1239:1e40 with SMTP id
 4fb4d7f45d1cf-5dc12391edamr12713038a12.31.1737972377908; Mon, 27 Jan 2025
 02:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117214035.2414668-1-jmaloy@redhat.com> <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com> <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
 <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
 <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com> <20250127110121.1f53b27d@elisabeth>
In-Reply-To: <20250127110121.1f53b27d@elisabeth>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Jan 2025 11:06:07 +0100
X-Gm-Features: AWEUYZnFUBRn0g4lzs0Ys1IPU6Wx9pJClaC24giX4xaag7aSllHJ2EKBa1kjAvY
Message-ID: <CANn89iJ4u5QBfhc1LC6ipmmmiEG0bCWhRG1obm3=05A_BsPt4w@mail.gmail.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, lvivier@redhat.com, 
	dgibson@redhat.com, eric.dumazet@gmail.com, 
	Menglong Dong <menglong8.dong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 11:01=E2=80=AFAM Stefano Brivio <sbrivio@redhat.com=
> wrote:
>
> On Fri, 24 Jan 2025 12:40:16 -0500
> Jon Maloy <jmaloy@redhat.com> wrote:
>
> > I can certainly clear tp->pred_flags and post it again, maybe with
> > an improved and shortened log. Would that be acceptable?
>
> Talking about an improved log, what strikes me the most of the whole
> problem is:
>
> $ tshark -r iperf3_jon_zero_window.pcap -td -Y 'frame.number in { 1064 ..=
 1068 }'
>  1064   0.004416 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 34482 =
=E2=86=92 5201 [ACK] Seq=3D1611679466 Ack=3D1 Win=3D36864 Len=3D65480
>  1065   0.007334 192.168.122.1 =E2=86=92 192.168.122.198 TCP 65534 34482 =
=E2=86=92 5201 [ACK] Seq=3D1611744946 Ack=3D1 Win=3D36864 Len=3D65480
>  1066   0.005104 192.168.122.1 =E2=86=92 192.168.122.198 TCP 56382 [TCP W=
indow Full] 34482 =E2=86=92 5201 [ACK] Seq=3D1611810426 Ack=3D1 Win=3D36864=
 Len=3D56328
>  1067   0.015226 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 [TCP Zero=
Window] 5201 =E2=86=92 34482 [ACK] Seq=3D1 Ack=3D1611090146 Win=3D0 Len=3D0
>  1068   6.298138 fe80::44b3:f5ff:fe86:c529 =E2=86=92 ff02::2      ICMPv6 =
70 Router Solicitation from 46:b3:f5:86:c5:29
>
> ...and then the silence, 192.168.122.198 never announces that its
> window is not zero, so the peer gives up 15 seconds later:
>
> $ tshark -r iperf3_jon_zero_window_cut.pcap -td -Y 'frame.number in { 106=
9 .. 1070 }'
>  1069   8.709313 192.168.122.1 =E2=86=92 192.168.122.198 TCP 55 34466 =E2=
=86=92 5201 [ACK] Seq=3D166 Ack=3D5 Win=3D36864 Len=3D1
>  1070   0.008943 192.168.122.198 =E2=86=92 192.168.122.1 TCP 54 5201 =E2=
=86=92 34482 [FIN, ACK] Seq=3D1 Ack=3D1611090146 Win=3D778240 Len=3D0
>
> Data in frame #1069 is iperf3 ending the test.
>
> This didn't happen before e2142825c120 ("net: tcp: send zero-window
> ACK when no memory") so it's a relatively recent (17 months) regression.
>
> It actually looks pretty simple (and rather serious) to me.
>

With all that, it should be pretty easy to cook a packetdrill test, right ?

packetdrill tests are part of tools/testing/selftests/net/ already, we
are not asking for something unreasonable.

