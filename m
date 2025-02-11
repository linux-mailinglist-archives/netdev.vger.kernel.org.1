Return-Path: <netdev+bounces-165032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BAFA30211
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 04:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B13188B59E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133AE846D;
	Tue, 11 Feb 2025 03:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jplkkkuz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87326BD8B
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 03:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739243814; cv=none; b=sbEf6aWfaQbIZvR3gIl/W5oAUVmV45eTqCzFv06dG1qn4/Wnl1/O3Rawff5BN3hH9eoIypJ4z+jgjiu85JSbD44cvnIXxXddF7qsMBXUPSIowqRyztj3OnR9SzfcT/Cy6FxERXRSpNW6WksdlMgKzdXIs8WD1V542Y0vr2t8Y4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739243814; c=relaxed/simple;
	bh=8kVuivHUC6yORyccTDqpEyQjbg/OtQ9BlDiPCg0Pja4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I8ptAQJVoWDoiUcp9TA1NvNAWUnll0+GalB+JxgU2iZr8TuIfpztk16HTdSetT3irW0mfJF2G3iSLqM14v38sJo4fG+yf8OLsPqmc8zyBUwWrjgen8ULhiO4F4KamqU0W7JTTJNwvvP3FiSqvASF+Lg7du/VMczuQR4eRTMVHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jplkkkuz; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0506ec9b3so286143785a.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739243811; x=1739848611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ovoozo/+yxAVm/dkUK69z9KT8kTLhJAIVgB1jLc3arI=;
        b=Jplkkkuzhe14Ef4ArWQFtn8gmA42zOv8Qedamh+fVKtyMBsadacqigXIZdD/tROOOF
         +53uvHYHrDDXAZbhDUczzxDUhlLrQc6VFGpZyiHuvPtHsizLvd4Vc31MDTRTLsEdx25h
         5ps7sBZKdbntv3OJGJ45QYa49ayWnnuFHMgESCwEhxg8yq6zhLgcV1nlDh9WnTw64tUw
         ieeLE/Stv6UnKxnE7LeYw/3VOPHx+wOc3tWM0MIuu2D1soKFy/xLHivjRj/LNveRloTu
         XhUqmnyIpG3WTlMdcrY163hi3pi49neBl+HDEiRMh8xtiN+qL3gHltetGy+Qh9pFF+Z1
         HtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739243811; x=1739848611;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ovoozo/+yxAVm/dkUK69z9KT8kTLhJAIVgB1jLc3arI=;
        b=YJCaSJbtZP8uYDhYxz2od7UzCdU5uf3WrbwK+oRQUdGUaCKytWTtKKuwOAjdl0zxqr
         J34uv7cNYRUcerHJiba+cGTuROtPtPMMmmSMfeytRzPFIGUpyJQhqYH2BPVJjaitGJj0
         MC3K0F0UcLPTel/17PFeRLxZcQlC3miDwiy13m19oGk13nFTbGwj9rcdpjtXOH+g7qzQ
         g/bsI8s86yaVUCO3XSGWwZsl1JhH8k4VvfMZPlx8fbKNYU+aqahFMSJYa4zse/uHDB/M
         5CEZSHaBrENI6/0wcjX9+h7S/c8LOJO5mKv6sgBuCyuHgu9mJT3MiKf2YNQFY/mEGhDo
         qmGA==
X-Forwarded-Encrypted: i=1; AJvYcCUmO+2449WV/GWgeELa+4fxkOBIyYlkrO9kyV6pNIzbVpltCUns43bMZbqMtuCn8ZRcZG7iihI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxttm0W/nJqne0bccZSd8+7cUmFYgvpTaVMBbKQkol8epOuuooV
	GVDjAEI/9IHuKu32YkIsZs7iexATina3vtrpYXK8PSxsb5xYJIEZ
X-Gm-Gg: ASbGncuhgA2fIqRlic5294yOPECmTviDrtcjzUiI/97w4U96IoL+FUtNqDvWOjfP9yF
	8Ol5Erir0HDjYzy2zxbwDKAPUt1UaQQfXhJ0P3ItiKNw/iEjtvTsGJVWyapJsVsU9PWIm+5G0BD
	6tfbnfwKdp8m2QQfydaJ7wh1Y54VgU6cQiDPpadUNeadiZnXb/wCEv9ikHhEbninnvbv50Qzxv7
	8KklgPESHRjRHFOoG/wrF2Y8rKCT6AepRfDPstojTakRtiqKgT05MGe2Z6NwHva14l+vNwYKJ5f
	h7Eb8vZDy9TZZNPMp/JBM+EyMabNCAJMAKAG4NchoqMlzy3P0woMaJi29Qjk7Ho=
X-Google-Smtp-Source: AGHT+IGkcF6EOPKQfWBZtsyn7xgLmEzdoMAXpv8AJLD2JsWboB48LPAIOhQXGUj9av5Bukxyn9WIBQ==
X-Received: by 2002:a05:620a:254b:b0:7b6:cb4c:10e8 with SMTP id af79cd13be357-7c047c1f50dmr2267033985a.11.1739243811176;
        Mon, 10 Feb 2025 19:16:51 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c06b490746sm19446885a.96.2025.02.10.19.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 19:16:50 -0800 (PST)
Date: Mon, 10 Feb 2025 22:16:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67aac121f14e6_a7f6e2949b@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89iJA1FRWAcwxwDCYxOV-AnCrdT5UEvdAhRnuCKafnwT7ug@mail.gmail.com>
References: <cover.1738940816.git.pabeni@redhat.com>
 <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
 <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com>
 <0a7773a4-596d-4c14-9fbe-290faa1f8d01@redhat.com>
 <CANn89iJA1FRWAcwxwDCYxOV-AnCrdT5UEvdAhRnuCKafnwT7ug@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 10:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >
> > On 2/10/25 5:16 PM, Paolo Abeni wrote:
> > > I expect the change you propose would perform alike the RFC patches=
, but
> > > I'll try to do an explicit test later (and report here the results)=
.
> >
> > I ran my test on the sock layout change, and it gave the same (good)
> > results as the RFC. Note that such test uses a single socket receiver=
,
> > so it's not affected in any way by the eventual increase of touched
> > 'struct sock' cachelines.
> >
> > BTW it just occurred to me that if we could use another bit from
> > sk_flags, something alike the following (completely untested!!!) woul=
d
> > do, without changing the struct sock layout and without adding other
> > sock proto ops:
> >
> > ---
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8036b3b79cd8..a526db7f5c60 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -954,6 +954,7 @@ enum sock_flags {
> >         SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
> >         SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet =
*/
> >         SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with =
packet */
> > +       SOCK_TIMESTAMPING_ANY, /* sk_tsflags & TSFLAGS_ANY */
> >  };
> >
> >  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL <<
> > SOCK_TIMESTAMPING_RX_SOFTWARE))
> > @@ -2665,12 +2666,12 @@ static inline void sock_recv_cmsgs(struct msg=
hdr
> > *msg, struct sock *sk,
> >  #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)                    =
   | \
> >                            (1UL << SOCK_RCVTSTAMP)                   =
   | \
> >                            (1UL << SOCK_RCVMARK)                     =
   |\
> > -                          (1UL << SOCK_RCVPRIORITY))
> > +                          (1UL << SOCK_RCVPRIORITY)                 =
   |\
> > +                          (1UL << SOCK_TIMESTAMPING_ANY))
> >  #define TSFLAGS_ANY      (SOF_TIMESTAMPING_SOFTWARE                 =
   | \
> >                            SOF_TIMESTAMPING_RAW_HARDWARE)
> >
> > -       if (sk->sk_flags & FLAGS_RECV_CMSGS ||
> > -           READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
> > +       if (sk->sk_flags & FLAGS_RECV_CMSGS)
> >                 __sock_recv_cmsgs(msg, sk, skb);
> >         else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
> >                 sock_write_timestamp(sk, skb->tstamp);
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index eae2ae70a2e0..a197f0a0b878 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -938,6 +938,7 @@ int sock_set_timestamping(struct sock *sk, int op=
tname,
> >
> >         WRITE_ONCE(sk->sk_tsflags, val);
> >         sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=3D SO_TIME=
STAMPING_NEW);
> > +       sock_valbool_flag(sk, SOCK_TIMESTAMPING_ANY, !!(val & TSFLAGS=
_ANY));
> >
> >         if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
> >                 sock_enable_timestamp(sk,
> =

> This looks nice indeed.

+1

I thought we could refine to use RX bits rather than TSFLAGS_ANY.
But not trivial, and today already uses TSFLAGS_ANY so out of scope
for this patch. sock_recv_timestamp has weird behavior: returning a
timestamp also if SOF_TIMESTAMPING_SOFTWARE is set without an RX flag.

