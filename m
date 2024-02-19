Return-Path: <netdev+bounces-73048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7B485AAFE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDAC1C214FF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3476C12E;
	Mon, 19 Feb 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0RhBckc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F514A3B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367517; cv=none; b=SgEjiKA2YYE8T6QW/3wsj3+4AY9+0H0OUQeJ9qzQsehMwO4/0DvmUcVoNJuIJmGUEKSuXBE4izX69SHA84/nCmjVl8f2PisFDUt2j/fd9Kx7NXnn6MEYl7UCX25Itt3OTGOazkFUkvUw85q/9AbFCp6UFge49o33+IOQClsA/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367517; c=relaxed/simple;
	bh=N7qcXWIGRCO+F7bM/CUk8c+OXhuaDHl+ALhhlZX6RM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B62CbDlaF/3l/hiuQ/aqBJeSIFa3O/sAoysLYXhWPrDgUUhLCPVGUNDeH6U59t5mRG/eVvPOJC0fR2mqwaVNlF3iWxhirNaB91FbejRtHwXNJKgZExyJr5ZX1qWoSc1gZuJVZm0EBzX1wUOFV/daIcxztijHATBlg6qL5KoMFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z0RhBckc; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5129b137916so5085e87.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 10:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708367514; x=1708972314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Jioa+rhZv02TaiIAVVRs50ZjE+fYCsmwZjuCKQHqs=;
        b=z0RhBckcBRCMK5Y1DQ+mL4u6y9cw91Bojn2QHZ1loh2qNK9tI81Bqo6UWHz494ik5m
         J8bDjxbSo5leSLBAe126buOqPjMgN+/R72tJPUBXSW0V7DrTi6DHP0iG2QE1vYaVsqDz
         yTkH8yFhqmZfB4ZLyuCdjcdmGp3wiBLqygP4SYy+MPe4VUn5MtW5PFFdDNgpZUWscNZl
         PVHBrQFPv34Du/6/sBa88OP9vgAYrLBXIOa0c8yg699ewb6biCQG/nWWngHNQn04OqVV
         X9pTBh0ev6jB2mleEpBw0jZC4d/SYV4IwCfzDfW4w5xF/lcddxJZsWUZDQjwoupyuaO0
         Pl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708367514; x=1708972314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+Jioa+rhZv02TaiIAVVRs50ZjE+fYCsmwZjuCKQHqs=;
        b=FSiFSNPUi4N0bN6+mkpi0mD2ZnoIIwbnYkjBrvnXhR1LVxe4WAVMT4ozTDGbhbppaE
         vWv+cD6SJW8k5G5ii1NS9xOtwjXI/2Au+zjZg3pi/NI4RKZsGpS09NKGWRuIRuSmMzJH
         PJjSQSGiA/a5S9UNbJFNkRaBhgtp1L0Nx3teyVHkykE3taf840Im0KYXpsO3sVZplRMh
         s4UUSNsMIauGCvi2EdJgIZSWZOxeOz7wyV06GFuty0aMY8B87sNC9k5rYMthErSC/NA7
         U1ZBusmIJbIZi+KuETCoWtbHnWI4h6H3EYNqaFdvPf2KGRYy3ARDICOXeITQ9Nbu+3p1
         q7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXOVA0onN22N/OFobpq9rtduJXRX91gfZXsit3xw9dzD+3SczB3PGLXHzE4vcqveoQWPY3Rvo73KgAxYCs6MUJz8Yc6LVvk
X-Gm-Message-State: AOJu0YyI/7QXMwyBrxtlY8H+oirkAEZIpgVZ10E0IsqssJquE0x2pYFJ
	D4rf/AAyEeuHetDIeQa/lsmsuzfbXOuuycCdZuO+A70STAsxwv2+YEHknbfcRVI2Psdi60tEYsq
	MKIeO1h6d9TGoFr00LfOyN5XG2p92f9+JFcO6OnisMvEFyDppnA==
X-Google-Smtp-Source: AGHT+IFeWv2F1OfoaDupC3rJZp81yipz6vkpsBf9IQIJnjqdAL4eocxCRlFJRzJiimrwBz5cSTIORSLm+hOU23TfwxU=
X-Received: by 2002:a19:7517:0:b0:511:940d:f34d with SMTP id
 y23-20020a197517000000b00511940df34dmr220473lfe.3.1708367513743; Mon, 19 Feb
 2024 10:31:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219141220.908047-1-edumazet@google.com> <8c06807aff1be5f95c1321221f9616d692c9fa4e.camel@redhat.com>
In-Reply-To: <8c06807aff1be5f95c1321221f9616d692c9fa4e.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 19:31:40 +0100
Message-ID: <CANn89iL4WBTKErxc7_31=RpkpznnZGAoijrevUk8xj+q9ZyFkQ@mail.gmail.com>
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-02-19 at 14:12 +0000, Eric Dumazet wrote:
> > syzbot reported a lockdep violation [1] involving af_unix
> > support of SO_PEEK_OFF.
> >
> > Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> > sk_peek_off field), there is really no point to enforce a pointless
> > thread safety in the kernel.
> >
> > After this patch :
> >
> > - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
> >
> > - skb_consume_udp() no longer has to acquire the socket lock.
> >
> > - af_unix no longer needs a special version of sk_set_peek_off(),
> >   because it does not lock u->iolock anymore.
> >
> > As a followup, we could replace prot->set_peek_off to be a boolean
> > and avoid an indirect call, since we always use sk_set_peek_off().
>
> Only related to that mentioned possible follow-up: I'm trying to
> benchmarking the UDP change mentioned here:
>
> https://lore.kernel.org/netdev/725a92b4813242549f2316e6682d3312b5e658d8.c=
amel@redhat.com/
>
> and that it will require an udp specific set_peek_off() variant.
>
> The indirect call in the control path should not be too bad, right?

Not at all ;)

