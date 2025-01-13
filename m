Return-Path: <netdev+bounces-157740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0FA0B799
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C518867CF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57607237A4A;
	Mon, 13 Jan 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPOu/SFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47674230D2B
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773213; cv=none; b=gtvdQ9Y6Z9mJ4IKeRVYHKzSxHoFbGUWNl9MnEzrfWdKpmje+/c09As0Wmwe7Azbum4WnksPvp2cNwUKagDLOLZ5SCCyAl/l5J1VPQw+vlx191iXJGa82zAnfCZaJfCMbMO4h916Kpl2jAlBe/atoZruYhjPTZadVBiC0BRwUT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773213; c=relaxed/simple;
	bh=2fxUireMw8N0z0m11jkUoAXE6IcsVe7eI+cEK7Fon6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAFBflubca6c/slsKzqL59Fvch9w5s9iT34ug+kfrdKbLfMYJhbUrR7A+iFJ8r9HJXph3cNgxayttIsQqsrmydjMDwfn0000YHkLN4RGDOchQjpVQSk+IdhYelHhOVvQ/oRh5Su09UDs1V/03HidRqOSnq0mAwByutJuOb2Hf7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPOu/SFW; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9caa3726fso13507095ab.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 05:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736773210; x=1737378010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fxUireMw8N0z0m11jkUoAXE6IcsVe7eI+cEK7Fon6o=;
        b=jPOu/SFWyBD8pmI4575QNVDTYHnIBb4ciJT2Fn/EMHCHBsJeA9zjjBrndD/pWnROe+
         x8tVEXrwNf8hCmtqWMvgfAWNgyX7BPKXx010TtBVlp54Uh1/xjsOXuxorU+yu/Ls5xvW
         PFV9x7Pb+O8Cq0Oun+SNDjBiLaUpHz8YPYk73WImAHEueN94lgJ3lLO5GW/5GigkD7y+
         q99kxd79aYJir+cjDyYAZDK8RKOWgDilHKS/xp/lyNzlMVDQpZP0Bgh15w3f87nV9c0t
         3eJLbo6rRLY70qhNYgEVtrsF2t8AltXmb5YFlZE5t9xznUkQxhMljNbLxA01QIrGwwoY
         7acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736773210; x=1737378010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fxUireMw8N0z0m11jkUoAXE6IcsVe7eI+cEK7Fon6o=;
        b=tXvXNZlO1g6THFFE7rVAIigy3r+N+AkKGS9GUsMd4KB9NRnAJS1lDX0Bq4QeO/88nF
         2MnTpfWYk6jOt3cE/kBBnBTVMc6r4dc/KfuE1RGODd+FYN8fd96PJOltjC6rNQEuW0UA
         uFQOTNLxQZPtV6i1eVOuvmlGtOuJk9iVYrFIamha1M1L/QyFzXfk8LoS9x0pPy3A6F3j
         ADXvpu2WIiD/V37GibABQ48BOoRSIqGXmbd9MQtSUT7l1YBxLy4h6UbSSnedEYyOT9k5
         8E6bP1oX7Pr5DI4G8AvIainON/XFiIwaMXFXrgFd6tqGuyoSqWJeAt/L2QO55iZpOL75
         /BvA==
X-Forwarded-Encrypted: i=1; AJvYcCUvMdrlfWkYV2I1ruaxTmnuXQOzAa2jeS51TJDnzzxbVXwoLv0Gua8GtIdeStOJD+rkqAVAcl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SPGux46URNS+YPB5jHe11ZHQNCW5sCVxzxMT2Sfj+LvxY1vW
	lcHBB/T2JvrKJ3jxDwp5Yv2zeRJw5ESKY2ewz/11Ny7WfQdNAvVLB6pvrGYDbdP0Jc3seycKru3
	eO+93ouXBfeL2WTOEEYzjq0ZdW9k=
X-Gm-Gg: ASbGncujiD3b7ZSnhz5b89xu9Opwimyh3Nfippm4sW6S0vK97MReTu/AIw9n2tcDwkF
	MRwl37Sogj18FC6TdamiF1fXofhCL/VoH+SLsZw==
X-Google-Smtp-Source: AGHT+IHPvwIzQY6RXRSMS+152jrlNuF+GTUDqK/fp3edi58AYSOSk1HsxF3QyOnyAl+WcOrVWj+A9OpS4enABfenGk4=
X-Received: by 2002:a05:6e02:b2c:b0:3a7:cff5:16d6 with SMTP id
 e9e14a558f8ab-3ce4b0086dbmr115524725ab.3.1736773210117; Mon, 13 Jan 2025
 05:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com> <20250110143315.571872-3-edumazet@google.com>
 <CAL+tcoDit2HQ9r-keyZjkSJF4esj-tB2rBAtFX7QBPueCaA8NA@mail.gmail.com> <CANn89i+x3mLp=RKDRzs-KjQgZMJxnLqciERt3mbotzE6KPHbXA@mail.gmail.com>
In-Reply-To: <CANn89i+x3mLp=RKDRzs-KjQgZMJxnLqciERt3mbotzE6KPHbXA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 20:59:32 +0800
X-Gm-Features: AbW1kvas5EV6Xdi3JgFvYokn41MSKmU7a3l4mI6aYshTYBIUVy7rSdVhp_7nauQ
Message-ID: <CAL+tcoA8SdpKo94z9MsFyMPEHgns9kzb505v6hybenot4CpCXg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add TCP_RFC7323_PAWS_ACK drop reason
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 3:37=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jan 13, 2025 at 8:22=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > Hello Eric,
> >
> > On Fri, Jan 10, 2025 at 10:33=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > XPS can cause reorders because of the relaxed OOO
> > > conditions for pure ACK packets.
> > >
> > > For hosts not using RFS, what can happpen is that ACK
> > > packets are sent on behalf of the cpu processing NIC
> > > interrupts, selecting TX queue A for ACK packet P1.
> > >
> > > Then a subsequent sendmsg() can run on another cpu.
> > > TX queue selection uses the socket hash and can choose
> > > another queue B for packets P2 (with payload).
> > >
> > > If queue A is more congested than queue B,
> > > the ACK packet P1 could be sent on the wire after
> > > P2.
> > >
> > > A linux receiver when processing P2 currently increments

Maybe P1? If the receiver processes the P2 packet (as you said, with
payload) earlier than P1 (pure ack) and it really returns with a drop
reason, I think it should hit #1 case instead of #2 case.

IIUC, the receiver processes the P1 and finds that P1.seq < rcv.nxt
because P2 already updates rcv.nxt earlier.

> > > LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
> > > and use TCP_RFC7323_PAWS drop reason.
> > > It might also send a DUPACK if not rate limited.
> > >
> > > In order to better understand this pattern, this
> > > patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.
> > >
> > > For old ACKS like these, we no longer increment
> > > LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,
> >
> > I'm afraid that not all the hosts enable the XPS feature. In this way,
> > this patch will lead the hosts that don't enable XPS not sending
> > DUPACK any more if OOO happens.
> >
> > So I wonder if it would affect those non XPS cases?
>
> Everything is fine. The non XPS cases will be handled perfectly well.
>
> For the record, all TCP packetdrill tests we currently have are passing.
>
> Feel free to cook a packetdrill test to show exactly the issue you are
> thinking of,
> chances are very high you won't find a concerning problem.

Thanks for your reply. I don't think it's a concerning issue either
even if it happens. Admittedly, OOO pure ack happens really rarely
from my experience.

Thanks,
Jason

