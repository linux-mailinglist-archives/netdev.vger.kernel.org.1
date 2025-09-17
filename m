Return-Path: <netdev+bounces-224109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACFDB80CF5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD121768B8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B3A2DC320;
	Wed, 17 Sep 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1mOB0RtT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0836D
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124679; cv=none; b=iIPp6qCcJ1jke6xC6vmzUIa7h5qzGNtKY+trKPNY9wRWSpV3daNc1um9jrzZUCKKCA80unsjErM0pTUA9lqlg5b0qlF1MqVr36E20/F2SA6kmqgsYn85D4rq8WPX3jO8m3dkR9tapEXrpogywE06PXmnYiTZj7X6uzyHFfWHQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124679; c=relaxed/simple;
	bh=g23Vl4s7sVPeOs12IPrIc6kuM1XO8eqHcH/L0hf81F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su7O0QYOmPFMneAsjGIm5KSjdiFkAvqaQn1pOYW5G3aGkhGh/ng4lQD9E6xqy3IY3kScUWJYQ//MAOU+jfin2+TW7ekIBbUm5gXbQ3km3msgcc6NwyHJnzEVpy2FELksntaY/VEB/thS5TWhQEofMKgsse9WlsdW728g7YLpB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1mOB0RtT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-80bdff6d1e4so689682385a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758124677; x=1758729477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RllVTnlbxT2BTLxcI8WuouN/0cluJXUiO+bDCrgBw/o=;
        b=1mOB0RtT77YA/DDCz/D9f4ssCw/V2gO0s9vs/RiGR170er8RaUZrIkqIzmNgqWuRMM
         5qUV8vaBIM4EXBvyQdCyNYlw1TfHaYme9/iEg1dm4H4zJC7/SAu08t7cLOp8xM04SZ4Z
         zR4lqYCi9wm5GqVmUhUoSCLF1LClsmSGbdInBHCS26pJuXLfQ1eGV5Ta64weXK1F9uQI
         Pht4Hl5uMvWUWuxL6IqIYZmCmkRtUDcwwuTI/9MTJpx8oouVY9fZFTM8ZYVi48r/xV71
         2X692UDNzpOCIE7TON4DJrDi/OLfmxvE2tipJqmOwiiV+2hq+v3xNv7vkRwyhQToAvNM
         i7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124677; x=1758729477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RllVTnlbxT2BTLxcI8WuouN/0cluJXUiO+bDCrgBw/o=;
        b=meVDd+V0Ud5VYxVSsDPKZLYPP+Ng/VZ2Blt8+v4cDmjZwV0avIY5yXvf1HYZzPYTVo
         cXOVjbW12Xgq4QDexvOQKzIgpewhpjNKE4OjQ2Xi95pmeK9Vn/YS3Vun/JXtwqEHq9Pp
         RDVgw+1++d1vrOEGKiM6dnmUAxK1KDdFlL7uOpi956moYiFHbeQSsjPXGPTMLVtJd9Yz
         mBnzPeeDp8eGkSr43tTcjfkK8BqNmwPtn7+4uc0TZV9+Q9eVLUk35I4hr08A1ReDAWr2
         SyO4wPLgPPQ5pkYJ0ZATqP0dAn6rMk2LUUefc9g9XcdBWZGthh/7n5R2SWATUEwmCjM2
         xVXw==
X-Forwarded-Encrypted: i=1; AJvYcCXC05+f8kpqDQImLAujxVsUIVMBOesv5eQvxmQX8NmYin3ud8VFpWRz4WwmO3ZfC/9PZ3olV7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzszSJ0wZHlLFwuXdXWb2GAahSbqJ8BOaHhtb8AOvalz0QWqqUl
	a+Pq0KXhQAp0gYW9w8d6pNqcX5xE+yNeR/hLw8v29im21+eWMkJ7zO8946XWsioTHfKVnYCMoze
	Ju9MTEy0uXpykKfPPDaJAawQBnqyzSSNYYzo46xB+
X-Gm-Gg: ASbGncu6rJshp3F/p3jgy9DeZ72dS1B5d7+NxYyKX/fLIHbXjIRqvqlM8ZHYaufnJN5
	ympyNi1sr2pfHIkB7IoCaGPJr9Q8lfzy74HTVj/CauQG1bnQ0Z+aB+d8IBiFBNtL+bjh2rkTtPz
	d9jNBWVLFkP35nB+wT5AdGpxsIdE7R7wkU52Cal1ke++p8Du/E+oK960droXlL5yA8QPhXahQoa
	868SOE01Fq+
X-Google-Smtp-Source: AGHT+IE0BHag8NcffnUos0k6lIP3+hrW6o+zD+KsLwLaMVpSgnczmljkkxAk91Gu9Lwo9O6uXavHsm59GRGRovehdTQ=
X-Received: by 2002:a05:620a:4142:b0:7e8:239:f829 with SMTP id
 af79cd13be357-83108e4c124mr311891185a.31.1758124676625; Wed, 17 Sep 2025
 08:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-6-edumazet@google.com>
 <willemdebruijn.kernel.20220031a140a@gmail.com>
In-Reply-To: <willemdebruijn.kernel.20220031a140a@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 08:57:45 -0700
X-Gm-Features: AS18NWDxUxw9HZQsCiDxVbcnhOqF9I0oIMPe3JvnresOv95kH27ZQ5sRwOGXF88
Message-ID: <CANn89iKPip5QppUDo_NT-KrZ4Lg+maqJ6_zz0-NpVwbuR8yomw@mail.gmail.com>
Subject: Re: [PATCH net-next 05/10] udp: refine __udp_enqueue_schedule_skb() test
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:00=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Commit 5a465a0da13e ("udp: Fix multiple wraparounds
> > of sk->sk_rmem_alloc.") allowed to slightly overshoot
> > sk->sk_rmem_alloc, when many cpus are trying
> > to feed packets to a common UDP socket.
> >
> > This patch, combined with the following one reduces
> > false sharing on the victim socket under DDOS.
>
> It also changes the behavior. There was likely a reason to allow
> at least one packet if the buffer is small. Kuniyuki?

It should not change the behavior.

rmem would be zero if there is no packet in the queue : We still
accept the incoming skb, regardless of its truesize.

If there is any packet, rmem > 0

>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/udp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index cca41c569f37621404829e096306ba7d78ce4d43..edd846fee90ff7850356a5c=
b3400ce96856e5429 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1739,8 +1739,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, s=
truct sk_buff *skb)
> >               if (rcvbuf > INT_MAX >> 1)
> >                       goto drop;
> >
> > -             /* Always allow at least one packet for small buffer. */
> > -             if (rmem > rcvbuf)
> > +             /* Accept the packet if queue is empty. */
> > +             if (rmem)
> >                       goto drop;
> >       }
> >
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
>
>

