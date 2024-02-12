Return-Path: <netdev+bounces-71011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B18518DC
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401CE1F21CD4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D540E3D0D1;
	Mon, 12 Feb 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZZGasnA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180B3D387
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754792; cv=none; b=oHTMnRLKN+em4Qmfqhh7uPGeDfoNpLli7HJLeNPXE2T0gqRaEV2Dz9apq0TMR350A3vV6UDPSKwAaPSrvpV1d8/TAwkKL0uo2X/UUQWAo3GIdbvLfn4PqqvTGbLQcEWPRYerFaRSxsILp1putqI9JA0+TiWTxEnQBBgneVX4qdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754792; c=relaxed/simple;
	bh=XoUz+JKRRyLBDRgZff9NiMYOcittU3kWQe3W6ehgHx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP5U7eCv5EC/WNZOgBcxxePu+s2t4YkIuRBNClO/EQuoziQJqvGbQ5/YfrYq1DPI+Ul1UG0Rm6WEWbEaA1UkR8eD9zwUWl2vI9+VBxfeSc/jUaSW8uzMOgm64q5PSdmTI4qiwbq+ODELIkdUDLg4/6dnR1aYnZd2nGA+F+LijMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZZGasnA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so13892a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707754789; x=1708359589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHOo/eJwLxH5gqaZ8Efiem03bhq9rE//mMgm98xwZ0M=;
        b=kZZGasnAbeAWv0GkmdckuGHq2mJKEvbibwyRmU3Sb2TwFDA0/E0StS+k6vICV/M0MG
         /RRwrEg5lJBzaDGnfnUu9Ml9Vijnv6yhRfJ4e6xJVq3XmXAY0+aXthei6/AlgZ3MH+4b
         76wC2F0SaXPG1Jri7+OUENDRlYwg0JLEt3LRoFL3v6nyV0qpOQmronMPaagq/Om9pbWx
         /zupa6p4Ge8vBriYBgNSC+C7lNWKCsLsPvpFKZQfwXk4/Y8g78Djia2YtHHIg9y5k/DX
         3Z/G0H7T/MDbt9Wk9r3f4s2j4ROKTx9L+YYwT5bCN/2CDcaC5eW4jFVLDZ2W6YjQYnNv
         3m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754789; x=1708359589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHOo/eJwLxH5gqaZ8Efiem03bhq9rE//mMgm98xwZ0M=;
        b=wcewL/gE1Y/eQvHucND8/0hjH6DKF4fefEAWzReFum9LYQcLY9vJZR9UdgmnN2gOXZ
         4ooGJKNcyUYgnMCegrQRq/dR8Bh38oV80lymI4UqFVJ44ryI+HNXJ/DYG+tuBmhYxQLp
         AdTfcYsUgP+W2jB4vw3okCTV/3lczJ7FIBxfrbLDsdnOxEi074hnjHFmP8k7RBjn1Cs8
         Phr98H12O2nqzwyX1BE3DbmHYKX987mRnpntS7xWSEUSTJP5NE6YuYCNeobZGtJUsmV+
         5JgqXL+dTopxnQzliePT0uQAkb7CXY8FskUy8LwfE80glvvCdgwACbE3TDy+Cb5lqY/D
         3FSQ==
X-Gm-Message-State: AOJu0YyyOyy5dh26du2RTP05HVZvO2t6EG2+/edvwddUtF8iZmwGFJB3
	HEFv03GBOxRYkF10KBekeoGZcIipclKRuuLXmWwNtcoaqiuVZ+gW4Fk4M8KFigsTxhjzx0rWyQ/
	7tnl+FMxsT+HC0HvBL1FRdSxeE66Zyfz3lxDY
X-Google-Smtp-Source: AGHT+IFCRIRy84fDApqf2UdgmngwajlGLdvGMKaatN1SzMnDKVtC1bFmAf9BjuMw6aVrq4xcPiL+uSeAAaMxs/hGdL0=
X-Received: by 2002:a50:9fc7:0:b0:561:a93:49af with SMTP id
 c65-20020a509fc7000000b005610a9349afmr257869edf.7.1707754789130; Mon, 12 Feb
 2024 08:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
 <CAL+tcoDFGt47_V8R7FkDN8OD-mj8pY41XysoGY7dpddo08WHMw@mail.gmail.com>
In-Reply-To: <CAL+tcoDFGt47_V8R7FkDN8OD-mj8pY41XysoGY7dpddo08WHMw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 12 Feb 2024 17:19:37 +0100
Message-ID: <CANn89iKEb_1kCPHjRDErmusqjGzK9w3h_tDYBxS+r-0nNHzhyg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:53=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Mon, Feb 12, 2024 at 11:33=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Mon, Feb 12, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> >
> >
> > >                         if (!acceptable)
> > > -                               return 1;
> > > +                               /* This reason isn't clear. We can re=
fine it in the future */
> > > +                               return SKB_DROP_REASON_TCP_CONNREQNOT=
ACCEPTABLE;
> >
> > tcp_conn_request() might return 0 when a syncookie has been generated.
> >
> > Technically speaking, the incoming SYN was not dropped :)
> >
> > I think you need to have a patch to change tcp_conn_request() and its
> > friends to return a 'refined' drop_reason
> > to avoid future questions / patches.
>
> Thanks for your advice.
>
> Sure. That's on my to-do list since Kuniyuki pointed out[1] this
> before. I will get it started as soon as the current two patchsets are
> reviewed. For now, I think, what I wrote doesn't change the old
> behaviour, right ?
>

Lets not add a drop_reason that will soon be obsolete.

