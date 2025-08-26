Return-Path: <netdev+bounces-216819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BEB354B8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D2B203664
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A7D2641CA;
	Tue, 26 Aug 2025 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaDkmvbV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC71F956
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190793; cv=none; b=oQpGPbLERuMenBuCOtyic1oWYlbsgc4hbJNOutm/1Auk4oNuC0G5OgnBDUXv+crc3CrotCBhbb5GDpuXj7focQc2retRhWVk2BWeg0LAcuMboRq9RKK1++ZBXT+HSyZH2ztXLgbqiGC6oJtaSA3Xr8jy4oj+ja4tol1f/0C0Kq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190793; c=relaxed/simple;
	bh=pNd8zYaxJjaMB0P/gSYzaOHXASxlY193DgQSeu4cM84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajCgrCqmuduOoqU92PGqV78UOCWUH+LSEJuvAvhHHoshmAicAQBKdP3JJ/CZWLvDzG1p5DvPN9rLEsW/+esEJgMp/hni6vwvBQlUv8Qn+bP5Nup7asvzMuctDrD2NPAjdyreShQZuGgJwGiA+Aq7en4FlrEukAnVnLUodUhNmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaDkmvbV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e87031ce70so354726385a.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756190790; x=1756795590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbVNv2qV2DdHcmdCOaaEDJ7QGyZmBRcpezE2sZOq8TU=;
        b=kaDkmvbVOMNss9QrtGYiawOTpm/840hcv2WhqZUTH7tcK7CvT3gxz3Nl6wwFuKKN0z
         Wa0bTDhiP6iy7u0EmAW3aSgruPG7mmVkEiojOkbn1V/TjxjZqXkQk0ztabG0sNeuRB2Y
         9/dGwvv6ZDQsy6od3SxXCLNm3CXBnEEQf2+yhgkXVmkev9aTjJzpn9CM7LPDyvXfbgbx
         3N3fuGoFE8nAZ//2uLrg8pyhqJ0nLmx2CvshuZKKjf2OpC7CX0C2i54rLkhqOgOQIii9
         KcOBtLvJvBDdmVbq9QTq14ugpFG0G7qtO9EJpqZUkb3YN4Z4YYRP5tG8d0B4hluCexje
         lbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190790; x=1756795590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbVNv2qV2DdHcmdCOaaEDJ7QGyZmBRcpezE2sZOq8TU=;
        b=ue9sCDmEcebBXYrOLPxb4R/ysV/ETdy/aeMqCcTcIjJ2zn1nHnKUeWxvAvMumeL921
         dseTEA9660K+Uun1JCZ6w3GJ7XXYQSLI1enDKa++N2X0+VRmfcsvniSoB7vzrH9uJkUU
         8v9tXpOBt9bN3fpjYOnMSO2TDFI6tjgMq1C4KLnOpfcdbvox1D9O2XMBXvHQVZXTfFO4
         XRDTiCOgx7QNG1yJVI/NtmDPpjubqeIUzYAv7LVgsiRvpHbB8Br3VLswjkcQUVHqNSS8
         V9cZ4kNvB9+B2xl0wV5EWG2TOpxb7d6+o/+3MyOW9pA14nKQ9/q9y6IullSrAIH3PotL
         EaLA==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZzbZ5rv9BZil7Vw3Ce1Pt7K847LQbPeqvYdOeliVkvnvyTzyRlOq70TFjsXF54A2C3LXAcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWRUItLNjF2eNElkO9oadKbxgglIXZATikYkQgF+s+1Mw9fnM
	L43cW+qXY/D+zQYgtkxpnS8Go831Wi8KT3euF33pLVhhUYiBsHHvsUCtkViFO13g1LZABYBAyGH
	aYRgDSNREvsFv6O9it6fFkV6usPPVbc3pnpQDrotlWxSSOTaaNWZf7sDgJVw=
X-Gm-Gg: ASbGncv3PTPvpZj+kP63sXmG6YJX2hoU82ojwHaSCwPUhr4rLfX7KZ7KXQdiXLpYoME
	9zT9WKinYGJha53A6M8U8K78P9P10hLPqsf7NRTWM8drQ5BTgneCHNC0CwcXxINcj6X9R/QdHU/
	9U+07bUxwp7lmgTL+lOI9A4zLOl25kJUYx1l80chui/CmHs90mv4m4M45lFlw/tDgQmNyjYHZ3I
	e6IlWjltNjBPkw=
X-Google-Smtp-Source: AGHT+IGMiyLrJ2UUEwmYhmkcuhQR3usFPeU+r7yQNv9qty0IEm3w8j2/Y62h873eLD4aOI9nqdRLR+2nhhMvI7rPGy0=
X-Received: by 2002:a05:620a:3199:b0:7e8:1a87:af55 with SMTP id
 af79cd13be357-7ea1106966cmr1384238285a.62.1756190789271; Mon, 25 Aug 2025
 23:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com> <20250825195947.4073595-4-edumazet@google.com>
 <6e645155-1d2d-4b64-a19a-a6e90a12b684@redhat.com>
In-Reply-To: <6e645155-1d2d-4b64-a19a-a6e90a12b684@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Aug 2025 23:46:18 -0700
X-Gm-Features: Ac12FXzLYa8JeyJSu9pqGOmlCWZuHn9RW0c2YyxSCQ0rqcTenda9KDegre-i21I
Message-ID: <CANn89iLNnYXH0z4BOc0UZjvbuZ5gWWHVTP1MrOHkVUq26szCKA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 8/25/25 9:59 PM, Eric Dumazet wrote:
> > sk->sk_drops can be heavily contended when
> > changed from many cpus.
> >
> > Instead using too expensive per-cpu data structure,
> > add a second sk->sk_drops1 field and change
> > sk_drops_inc() to be NUMA aware.
> >
> > This patch adds 64 bytes per socket.
>
> I'm wondering: since the main target for dealing with drops are UDP
> sockets, have you considered adding sk_drops1 to udp_sock, instead?

I actually saw the issues on RAW sockets, some applications were using them
in a non appropriate way. This was not an attack on single UDP sockets, but
a self-inflicted issue on RAW sockets.

Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Mar 7 16:29:43 2024 +0000

    ipv6: raw: check sk->sk_rcvbuf earlier

    There is no point cloning an skb and having to free the clone
    if the receive queue of the raw socket is full.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: Willem de Bruijn <willemb@google.com>
    Link: https://lore.kernel.org/r/20240307162943.2523817-1-edumazet@googl=
e.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>


>
> Plus an additional conditional/casting in sk_drops_{read,inc,reset}.
>
> That would save some memory also offer the opportunity to use more
> memory to deal with  NUMA hosts.
>
> (I had the crazy idea to keep sk_drop on a contended cacheline and use 2
> (or more) cacheline aligned fields for udp_sock only).

I am working on rmem_alloc batches on both producer and consumer
as a follow up of recent thread on netdev :

https://lore.kernel.org/netdev/aKh_yi0gASYajhev@bzorp3/T/#m392d5c87ab08d6ae=
005c23ffc8a3186cbac07cf2

Right now, when multiple cpus (running on different NUMA nodes) are
feeding packets to __udp_enqueue_schedule_skb()
we are touching two cache lines, my plan is to reduce this to a single one.

