Return-Path: <netdev+bounces-90601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C98AEAD3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D1BB25455
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9413C83C;
	Tue, 23 Apr 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LHBPDBYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51F13C676
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885516; cv=none; b=NR5YXihpdJOhDjlo9sAbBCgJmenDteXiLO7OxBZDPDJQPobnlz3+CUVb/0MPTZcKvwGWqzyBPcoaj/zkQ+0oDaX0pJw/g8RgFTSy5e3W0LQDAfffM/cpCSBUtbpc0ZOViSnsy7x6o8a7jXVfBE8YqiL4qalWGC+aLJlQ5t1/XJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885516; c=relaxed/simple;
	bh=ubwcX6lCNww992uPnISTrFdPWF/KdN2xpgjJH3hhPkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGZEicOk8BrmrBHee960ocKXrAKvjkE67RggUROyEJmrB5HIfTPSFlwH3TU/2B1rVbavjXqRDf+MMv0iRUqKDJt0GzlPAAz3s50xdQSEZJ0gXYRI0jJS3TIsJ6algs33AC6h7ezuhTThJOmNFOyaqISIvB4L9MnR95XxiLIfLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LHBPDBYb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so22026a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713885513; x=1714490313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubwcX6lCNww992uPnISTrFdPWF/KdN2xpgjJH3hhPkE=;
        b=LHBPDBYbUGnOR1XKLdjGhnTirwMG3BH/OE3nCcXH8ADQ+pJFC6QJCTWS2zUhKTpsy2
         h6CwLmjA9XaqOl2bUPCvez3pyjyklwZhzXCY0dNDHrjg3MCpJTPjrrKHrEOT3QhCnysQ
         bVm674VNySndPFGZrrin/04mEVDIGInlo2pfih+UCzn9pa1/6MK+KU+nXtvmJDtqQDL4
         LwqciLQSJ2GT2fB1ELdNDzmc/0WS1JF9/p6z4NIOdUuIDqFVnt5+xslLG9/tKbFzVCYS
         KQMxtJGkDqDYXTxKhheEhm2Jv3lBVGn57qYe7+scYEnwDnAXjIzqoXcCkrM/4mUIMDZR
         PRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885513; x=1714490313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubwcX6lCNww992uPnISTrFdPWF/KdN2xpgjJH3hhPkE=;
        b=NZ5c9jQIny8WIQANV2RixyqD8kCsSc+vhprI4oDdh/atxkNyvU9ufjKaFLSgua6Cb9
         /JC5gapIzr0UzXfbI/ujmsbrSNuzwb6swJzQJboY0IPrwcgjvg64DfqkZ7InDNQUOS7v
         TP7FPzNs3vvKqGKffFP1rGjIoC2jpoJnxhQngpxo/NPkPMNDIEGkOf6q3j/8WJ0/KBNV
         /0rDH3X6S1KakXV07hJvdwdFRpnOtbyspnOYRimUbco7z1fuH6V5a3AkpbFEoAYhqqF6
         +ittOCFZJytn5ESxhCiZ19S2QhlUOq8PWG2B6TrkDGufyfMdtFy9VwnCvQALB5bfIbGV
         1lOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqLeiSs8bXKAyj2cfZpmFA5bM/XgocD2C0Xh+jzRVbMwAU6lPGax8Nd5HYTNmkPOwoQgfpSCZyYDg61Mlz56JCTq2VRXnL
X-Gm-Message-State: AOJu0YzAJiz1rmpRcKY+bNIFbAFgs4BzlznKI7SD0aHaVg2YkRk2yS96
	zem5DGjJ+J8L5ZjoDU6AfXaowEDAShoiKBbuNrt7pBZKbj06zJD7lYp9pFoFyX1A8qaq45bT3Qo
	LSPZcTDGKatEOdNQbzwfxLKdyLvT4iy6IJWLg
X-Google-Smtp-Source: AGHT+IFfHRoK4ExiUYE8yLZN6vrHbEeHWOZz0ecgN/UmYRXJa9CPffhTbvCEIKHSsQd3r/wrIlioJoQO/XuFtVTgq4w=
X-Received: by 2002:aa7:d68c:0:b0:570:49e3:60a8 with SMTP id
 d12-20020aa7d68c000000b0057049e360a8mr177407edr.7.1713885512586; Tue, 23 Apr
 2024 08:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name> <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <7537ed21-4fc5-47c1-9c06-58982a308419@kernel.org>
In-Reply-To: <7537ed21-4fc5-47c1-9c06-58982a308419@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 17:18:17 +0200
Message-ID: <CANn89iK4-qKw0t5eFhKp0372qEEC9odmunzKhYNho8ZgNqwF5g@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: David Ahern <dsahern@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:03=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 4/23/24 4:15 AM, Eric Dumazet wrote:
> > I think we should push hard to not use frag_list in drivers :/
>
> why is that? I noticed significant gains for local delivery after adding
> frag_list support for H/W GRO. Fewer skbs going up the stack is
> essential for high throughput and reducing CPU load.

Felix case is about forwarding, not local delivery (which is fine)

>
> >
> > And GRO itself could avoid building frag_list skbs
> > in hosts where forwarding is enabled.
>
> But if the egress device supports SG and the driver understands
> frag_list, walking the frag_list should be cheaper than multiple skbs
> traversing the forwarding path.

I do not count any relevant (modern) driver supporting NETIF_F_FRAGLIST

>
> >
> > (Note that we also can increase MAX_SKB_FRAGS to 45 these days)
>
> Using 45 frags has other side effects and not something that can be done
> universally (hence why it is a config option).
>
> 45 frags is for Big TCP at 4kB and that is ~ 3 skbs at the default
> setting of 17 which means an skb chain 2 deep. 1 skb going up the stack
> vs 3 skbs - that is a big difference.

45 frags can also be for non BIG TCP, allowing ~64KB GRO packets
without frag_list.

45*1448 =3D 65160

Max number of frags per skb is orthogonal to (BIG) TCP.

