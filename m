Return-Path: <netdev+bounces-224167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397DB816D8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A991C26D79
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F82727ED;
	Wed, 17 Sep 2025 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4U0rMPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FE51A315C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136039; cv=none; b=SJo8yTExpanjMknxz1Oz68c6GIuTBoe8xqmWAyafs742g5oari9mbjRLvQv51pdhskTJm0txaV4A4ATHgtKmsk4EXNzyma/QR2XioWbaZogefp0wFA6LYRvRGusFR1XXG0Qj0Np2sd2shHhZ58t7/06OA7mzYCRnwHGXKp5GXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136039; c=relaxed/simple;
	bh=byvrkWcLSc+D3J0J6P6u54xndl8WT+MLirwMnepcsD4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nE5alOHE2IKc1IU0evRHA1ayjQhCfGRDfRN+SN/20GgRIQeyTNaqq58x21vJ5Qst5sZ0lNlW7pWM43/3r5X3p8mEBKCZ3kQOODWcXpZB7jnnC9NcuWR40ujx/aj7I3W+xvUDCO2Gb9GC925Mmo8XKxAHWeaVMCml8WbLaMb/QDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4U0rMPE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8112c7d196eso18178885a.3
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758136037; x=1758740837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byvrkWcLSc+D3J0J6P6u54xndl8WT+MLirwMnepcsD4=;
        b=Z4U0rMPEEQU8FHEzoCKTIvDPQn5rAFZJqUaDbbm8bAQpXeYtwBOxBVjIjJagR/ppT/
         PpcNMEy9tvQ/YR+hcocLq2Rt/21tP3CYUV8rAXTp2ekct/toLKjmYJK99buoF/mmWsEg
         CRpAYha/tcjdY+VMlGuChHR3IJz6kOUkjv5z+BjDd7E+U/atzV6oQ97RRRFfbfTEP/Lr
         Nd0CtHIvyG4cNfhm8HbN51Pje5jaz/GtKfNt1iIaPieCN2yaydrRtUu3fdILelGStnaj
         U/m1ZLii/gqeoM74nF3KAfYJ+QpBgQKZb+AIOjCzDg03ian1xDF/O39DH//I/BKiYNXB
         5pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136037; x=1758740837;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=byvrkWcLSc+D3J0J6P6u54xndl8WT+MLirwMnepcsD4=;
        b=rPxdZjtMFQiJJ2RIXlN8BBKX9sQ2S4FNQjCEQFsa5XfMAQE32rUj1xH9o5pxjLvUGb
         SayTlx5xAzJFq/ASMBPck+wIRXj4tS6ED+m9GwP8ZP8E/DsYG7nR1pdumKFnWNjhcRxG
         eH3mNKdOF3c+sF7NxDF6g+WZYlZGlGTVWBFPRi4k0vbULu2aM3CGWkccFoTKUKXlzS95
         o+1HzjSdQ7TF44E9ny5eHPMvLGPktLUVSU7AqaZJGUhvkdtppC3hva76HYcnl2YbjbXF
         jVJSuCnoPqPDJCcU5wLxjHD4D/hYUqwDTw1qy2j005NKsFSNJArccf7c2NYii6xSe8hM
         MHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYQHFfafKRxJpOibDO5/6S1dXoFtewoeQanbIxslIkcX7FSuezm6NEOxeH46EVZQuLq0+CY48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFm/uyHN0F4YYLcVYetLjINydM2I185UfdyfnfMMmFHtxBjMrM
	kylf9pSwKu9VSRg+UV3kHfXg0sPPGCLL9x/bZdnppREVS1p9RDI8p+Oe
X-Gm-Gg: ASbGncuETle0MvuT5DlEhtyBs6DYnAJOZxy31YqbFkogi/RY1W316MswByJp/w/JHpK
	ytDiebvczf730qJ/yWYdIIiiKXMqXdMYC1Si+S76XjuHq3zgjkWBEbRdaPPh4sCuIg0QmX6/i13
	sN0SvGeDF1IPKJDbkxSKhx+E/fEt1b0WIPhXc0ckdZ/CrRdWXIbamYZdOOhcvx4pAbYmiF5Uqdr
	S0ZP+4zmKfbZ/noVVwAy0eRs8TYt5+8ZC1BGTXVHPz6WIU5sn/jGSzE913EYszC6lLhzic+49WA
	x9ZglsrzyS55tPTQ458nBixrsfeZGjcNHmnZMj2pG/xoK9aVqQ4mCLYvbX2O3b2UTsYHGEFtV+K
	UQR2t227OcSa2ProdVsfYvKldrxmjaMqDRwaTdVM90PVniJFxO+YW++hkW4IkT5QsBWtt/4I5x7
	tTUQ==
X-Google-Smtp-Source: AGHT+IGpIBLiSD6jpr3D6aB/ySS1xNWNfZqMZM6WqsRzP1GM1/T4MasIDqLbkdJfNBB5jOoIhVn3AQ==
X-Received: by 2002:a05:620a:414a:b0:826:474a:9f81 with SMTP id af79cd13be357-8310b5994a0mr388348585a.25.1758136036558;
        Wed, 17 Sep 2025 12:07:16 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-83630299579sm29768285a.41.2025.09.17.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:07:16 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:07:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <willemdebruijn.kernel.1cc75fc0f6dfe@gmail.com>
In-Reply-To: <CAAVpQUCumbFexO9TBhed0G0wGToLc4crVMSh8OxqwLep6kSzuA@mail.gmail.com>
References: <20250916160951.541279-1-edumazet@google.com>
 <20250916160951.541279-6-edumazet@google.com>
 <willemdebruijn.kernel.20220031a140a@gmail.com>
 <CANn89iKPip5QppUDo_NT-KrZ4Lg+maqJ6_zz0-NpVwbuR8yomw@mail.gmail.com>
 <CAAVpQUCumbFexO9TBhed0G0wGToLc4crVMSh8OxqwLep6kSzuA@mail.gmail.com>
Subject: Re: [PATCH net-next 05/10] udp: refine __udp_enqueue_schedule_skb()
 test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima wrote:
> On Wed, Sep 17, 2025 at 8:57=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> > On Wed, Sep 17, 2025 at 8:00=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Eric Dumazet wrote:
> > > > Commit 5a465a0da13e ("udp: Fix multiple wraparounds
> > > > of sk->sk_rmem_alloc.") allowed to slightly overshoot
> > > > sk->sk_rmem_alloc, when many cpus are trying
> > > > to feed packets to a common UDP socket.
> > > >
> > > > This patch, combined with the following one reduces
> > > > false sharing on the victim socket under DDOS.
> > >
> > > It also changes the behavior. There was likely a reason to allow
> > > at least one packet if the buffer is small. Kuniyuki?
> >
> > It should not change the behavior.
> >
> > rmem would be zero if there is no packet in the queue : We still
> > accept the incoming skb, regardless of its truesize.
> >
> > If there is any packet, rmem > 0
> =

> Agreed, this change should be fine.
> =

> The rule comes from 0fd7bac6b6157, and later 850cbaddb52d
> tried to be more strict but caused regression, and the condition
> was converted to the current form in 363dc73acacbb.
> =

> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Interesting. Thanks both!

Reviewed-by: Willem de Bruijn <willemb@google.com>


