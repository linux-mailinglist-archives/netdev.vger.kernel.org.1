Return-Path: <netdev+bounces-157616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B49A0B028
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EE5163BF4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC1231A4D;
	Mon, 13 Jan 2025 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="msamu8GC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB113AD0
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736753874; cv=none; b=Y/a1ZBXtcYmLQ+kaDyJEQa12XVblx2xtrGP04EK7FESmypMpK1sWjgRekCRf/5hWHECj8dl+ykWvM2k9/LxXZoBeUW3SC1eAvOisW1yWUCdFp8HBcdWPxUAxZ5mPIIwdfNG6zUtnopRoxWX8O+JjCanrVemNaVLi3/YaTiWk+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736753874; c=relaxed/simple;
	bh=X+wfbWC9jER6Q3l4V/YdCiMnQ5auYUi2ytE+vIBDX5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ojr6FsNgzxUM4KWbwH3poud5OCUzoDE87dx+DyxYBU98H/4XJRUV/b0ifUhrJVjbzn6zdaPb0+KEzPzUo5hbO6i9XyBQPHEG0E7OAA9vQiwShWy9nyb4ISORZs+aAJUIGZwJJ9cxkAQ8eyH0SKXfayOEIcFwCRZAidiVX7XhdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=msamu8GC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so6745308a12.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 23:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736753871; x=1737358671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+wfbWC9jER6Q3l4V/YdCiMnQ5auYUi2ytE+vIBDX5o=;
        b=msamu8GC5Ucw5EhEqV81REcNHBCC0Pt6OYRsk8R1ze7R9mwE3+7Z3zQFjw/rn/FhTF
         q4m6JfRzcWmKfl+693Jr0DI7vbqi9jfUBWD/VsHLlf+MFli3mn0WDFgePCUf0ISTPJi8
         l1Xo7JKZtPdD0RvUuTJZ4oav05vF/RgWvHMaQkJiAuRDbKatFu8j1uWEIzveseYrKUUL
         6dGT0uWkDLQdhkMTdWG6NN0eNJ1BGgoGWFFPb2RaM7/EcHAQSW/bqkZzTF1tSsUgcxik
         qqEvidsYwN6uAu5GruWgsxt2dLdNZhAcKj6Jiwvj234Epcjohbk7LuY0F222SMkaPrvA
         pKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736753871; x=1737358671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+wfbWC9jER6Q3l4V/YdCiMnQ5auYUi2ytE+vIBDX5o=;
        b=UZAuwfwo/9Y224pPL/X/VUrekDOJT4NNmuFhQoTmp+MK1yNQ4f9DAalskhW82Iqc03
         vDvc5OyQ6LBEOlfoewJ3WpnvfH7SnVjHGqzc48/aQ5rl9+IYzmjFjLIDm245n1s5LZmk
         Yx+5Oc/S1yUcJluYCM+xL+pOKwXhNxmus/EFbJys3NaVswT+2CXUKHHTBlXaqoq7JWc9
         eCIN9kjhtN6ooHG+NjKuKF05IQrdMhrEm2Eorm0qYgoBqRD/e+LVkiy44sw6/5g2c8J8
         irGgFIUNtueOrr71C0b0VQSAEoJTVC+DMsIlx3NoigWELgmys+RUCN+aOxB2KQ++DYwR
         QwVA==
X-Forwarded-Encrypted: i=1; AJvYcCUMv/YockZG6MFFiuwKZB23uVrtp/NvNBraWoax/hKxG0kbY7lnIk3/sTa2DxiEEcOrnsZrVAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZV7EhkNObMKiwsQGJopwQKLDZAO5aoZCr/6Cd96rwUzpfYse
	eVxAeAvQgqniMt9+0xZ/LfuoRecqdIvq9A5A3TVNBXNycWPPhxSYrMw1Wx+C9P4NHP+UVAdHjIi
	0mL4tyCkQDUjdqZKcBzDTdxZAtonE7APJGyfm
X-Gm-Gg: ASbGncv8PL1xMogt7ZeX08FMMzo20ZTM1GtoabGsF/7naZX3q7kOacLlpjBe288uMlP
	mj1KQHLxZhZ+K0wYAr0og/JCqEQYVjzOdaM+OQg==
X-Google-Smtp-Source: AGHT+IFKTKxd1ljWvMgBuiLLi7cV6WPX1fA+RQXYVEGqtf0hmtdxckJRmDHbrD8q9kE394qsDrtgFHKFncat1lJRSKo=
X-Received: by 2002:a05:6402:270d:b0:5d0:cfad:f6c with SMTP id
 4fb4d7f45d1cf-5d972e476a8mr15983829a12.21.1736753871097; Sun, 12 Jan 2025
 23:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com> <20250110143315.571872-3-edumazet@google.com>
 <CAL+tcoDit2HQ9r-keyZjkSJF4esj-tB2rBAtFX7QBPueCaA8NA@mail.gmail.com>
In-Reply-To: <CAL+tcoDit2HQ9r-keyZjkSJF4esj-tB2rBAtFX7QBPueCaA8NA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Jan 2025 08:37:40 +0100
X-Gm-Features: AbW1kvaUqOq2kX9VUwH56mb9MsD-MhQX7VJrOgEHm0daY5OjA-CGYUao_2Rg_Fc
Message-ID: <CANn89i+x3mLp=RKDRzs-KjQgZMJxnLqciERt3mbotzE6KPHbXA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add TCP_RFC7323_PAWS_ACK drop reason
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 8:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Fri, Jan 10, 2025 at 10:33=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > XPS can cause reorders because of the relaxed OOO
> > conditions for pure ACK packets.
> >
> > For hosts not using RFS, what can happpen is that ACK
> > packets are sent on behalf of the cpu processing NIC
> > interrupts, selecting TX queue A for ACK packet P1.
> >
> > Then a subsequent sendmsg() can run on another cpu.
> > TX queue selection uses the socket hash and can choose
> > another queue B for packets P2 (with payload).
> >
> > If queue A is more congested than queue B,
> > the ACK packet P1 could be sent on the wire after
> > P2.
> >
> > A linux receiver when processing P2 currently increments
> > LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
> > and use TCP_RFC7323_PAWS drop reason.
> > It might also send a DUPACK if not rate limited.
> >
> > In order to better understand this pattern, this
> > patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.
> >
> > For old ACKS like these, we no longer increment
> > LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,
>
> I'm afraid that not all the hosts enable the XPS feature. In this way,
> this patch will lead the hosts that don't enable XPS not sending
> DUPACK any more if OOO happens.
>
> So I wonder if it would affect those non XPS cases?

Everything is fine. The non XPS cases will be handled perfectly well.

For the record, all TCP packetdrill tests we currently have are passing.

Feel free to cook a packetdrill test to show exactly the issue you are
thinking of,
chances are very high you won't find a concerning problem.

