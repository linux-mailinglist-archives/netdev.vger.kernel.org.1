Return-Path: <netdev+bounces-157814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A4A0BDF0
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FE9162988
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681EE20AF83;
	Mon, 13 Jan 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FRi4GsrX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A401720AF89
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786909; cv=none; b=siCqVAG7JugK825SrRh85FgJ/e35RItfOKTD9EHL2BSyct2BDDI/KCoSy+/MQzlfJxmPvopbc/Pg3VmvDUCZX+KsNewwxNPPKu8Bt64Gc0E8swYGYgbbstaHa3DWEo7neqj+i+oC4ATy1wYPx8E/Tbg8rJLDCAAfMikG2Wk8Poc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786909; c=relaxed/simple;
	bh=FHN/HUp2go3sqOyTYW6ovcbA6J1JiO5RwNfIe1ESINg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAj6SOkj80byHfG2qe835Kfj7w/xS97Efcv7IL8AKsfemQ20VNy39rmqP3zVcPqgU+u6nr7wAL8JinOR12ZEaB85J8GTN8tjSX4haRcclXEzu6Lgkvhk9dzSb34iLRZZuHQEjMMIqpXII9gu7bAmgISQcRbn6lLIcHYj6kvsi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FRi4GsrX; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4679b5c66d0so402421cf.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736786906; x=1737391706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEoi+asPxQVEmOgdYbS2S6tKKZd7ceQuArvvclgn/8k=;
        b=FRi4GsrX4zxTjmI5lMl60D42OYl3mCnnDG8kCa7PdJMvRA1iJsFztZOXZMNy67jqDR
         DjZ9bg3sOKK9Arol7grhAyVcf0NrPm3ttL2AhnQtvM7RaZd6++dPJCg9pUqWGywRC/Fe
         H5H094dbY+oqWB2Hpw9jh88pi1Dd3BVMORPoFOTjYfrg711cjbLu6lhBQKIdauCgtmTY
         XO6AGW/T2tN15IzMy3XRhHIEPJQ5dawXFLJN1yhLKxAMy5+YqG9xi4zquN5OF5hmQDDG
         3QZlqUZgOBUXe+cyYlF1/1ic9KELvZz22mhoRAH36ENjbn4AD8uS/fTxq8MfXVdnBhtB
         C9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736786906; x=1737391706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEoi+asPxQVEmOgdYbS2S6tKKZd7ceQuArvvclgn/8k=;
        b=WZbIcrYhCnqmbzZWDqalUfHUc9VKK6RlAv5PdTK8THrDbr4aa1q+j+mfp/zc2ky94/
         iQqdwF4s18bUIp42Opmq3AfM2kbpNELOwoygeGqjgvtZYreoxbmOvjUU1WmoQyHBThpo
         86kpxZ0Fm1Ny+EZmMz6rwNVoNp/RJFksM09ycXIH0V6njYswv7JZpBXuW+8xFS4sGj4B
         cwrlmuD200hvHD5/nSfQWNkQJWsbDK+tbN4YKtR7k1sblUhUBTBG36FlAY+DQyC5LFbV
         3VdqzejcepWtfoF3/hFjr0TrvWhcFAa26y2xnzMbLOZEhjWJ22dSeRbGIdyYWa+UX+S7
         wd6A==
X-Forwarded-Encrypted: i=1; AJvYcCU1yOAOGN3iEhwzg0wGKQOvVQArrOUjQIbUJUUnCts+qA/EhUeVXNT0fZZMRT32RIdDmuz7dIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSynfupTdQXpO0zHX3MvGxUmoOYLWvXykYV1EMlheQqXocXfe+
	n2h3UzrV4D8RTvffW58j6NWnbThb1rwQ9LW/+7oE2gT96+7+JZEwhbkm7pFNqN1DwpnJDkdfPLc
	sb/x9WDj1bkql+HYZr6ugv/WtJYQNkn8KmJea
X-Gm-Gg: ASbGncusX/7eZozXrnJa/DYC1nSBWFFJq5Odoggit/fVN9TUJN/kmwMU2j655OE4rtY
	JqZc1ljtNyc+hFvX8WQxcNHcgQHDbNZBG3xtP2FAlBS5aqfht9lDlu3ruIhf0TxiFHcAYSOw=
X-Google-Smtp-Source: AGHT+IFrV4e199mRJdbnpOYYp5ELQJmC3hMiNaEgBUCXOAau0nh7NkTnXfGEP8buIo1orKWlOjgKRZnDQofcIbS+sO8=
X-Received: by 2002:ac8:58c1:0:b0:466:a11c:cad2 with SMTP id
 d75a77b69052e-46c89dad58bmr10334601cf.7.1736786906233; Mon, 13 Jan 2025
 08:48:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113135558.3180360-1-edumazet@google.com> <20250113135558.3180360-4-edumazet@google.com>
 <CADVnQynzjcW4gCf+=O=gn0HBV40m8jBwmeVBTqMbswSmcuON4w@mail.gmail.com>
In-Reply-To: <CADVnQynzjcW4gCf+=O=gn0HBV40m8jBwmeVBTqMbswSmcuON4w@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 13 Jan 2025 11:48:09 -0500
X-Gm-Features: AbW1kvZ16HvcUXJyyOsnK0QOTU6BK0Ri46EB1TLIgmDqAzeEpAqLVJ7y4Q01LBY
Message-ID: <CADVnQy=BMM2e8VokChK1E3bV61-LzWYuKe92eqHKgwvS28qCcg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] tcp: add LINUX_MIB_PAWS_OLD_ACK SNMP counter
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kerneljasonxing@gmail.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:28=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Mon, Jan 13, 2025 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Prior patch in the series added TCP_RFC7323_PAWS_ACK drop reason.
> >
> > This patch adds the corresponding SNMP counter, for folks
> > using nstat instead of tracing for TCP diagnostics.
> >
> > nstat -az | grep PAWSOldAck
> >
> > Suggested-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/dropreason-core.h | 1 +
> >  include/uapi/linux/snmp.h     | 1 +
> >  net/ipv4/proc.c               | 1 +
> >  net/ipv4/tcp_input.c          | 7 ++++---
> >  4 files changed, 7 insertions(+), 3 deletions(-)
>
> Looks great to me. Thanks, Eric!
>
> Reviewed-by: Neal Cardwell <ncardwell@google.com>

Wrote a little packetdrill test for this, and it passes, as expected...

Tested-by: Neal Cardwell <ncardwell@google.com>

neal

ps: the packetdrill test, which I'm tentatively calling
gtests/net/tcp/paws/paws-disordered-ack-old-seq-discard.pkt :
---

// Test PAWS processing for reordered pure ACK packets with old sequence
// numbers. These are common due to the following common case:
// ACKs being generated on different CPUs than data segments,
// causing ACKs to be transmitted on different tx queues than data segments
// causing reordering of older ACKs behind newer data segments
// if the ACKs end up in a longer queue than the data segments.
// For these packets, we simply discard them, since this 2024 commit:
//  tcp: add TCP_RFC7323_PAWS_ACK drop reason

// Check outgoing TCP timestamp values.
--tcp_ts_tick_usecs=3D1000

// Set up config.
`../common/defaults.sh`

// Establish a connection.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

   +0 < S 0:0(0) win 32792 <mss 1012,sackOK,TS val 2000 ecr 0,nop,wscale 7>
   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 1000 ecr 100,nop,wscale 8>
+.010 < . 1:1(0) ack 1 win 257 <nop, nop, TS val 2010 ecr 1000>
   +0 accept(3, ..., ...) =3D 4

   +0 %{ TCP_INFINITE_SSTHRESH =3D 0x7fffffff }%

// Send a request.
   +0 write(4, ..., 1000) =3D 1000
   +0 > P. 1:1001(1000) ack 1 <nop, nop, TS val 1010 ecr 2010>
   +0 %{ assert tcpi_ca_state =3D=3D TCP_CA_Open }%
   +0 %{ assert tcpi_snd_cwnd =3D=3D 10, tcpi_snd_cwnd }%
   +0 %{ assert tcpi_snd_ssthresh =3D=3D TCP_INFINITE_SSTHRESH, tcpi_snd_ss=
thresh }%

// The peer received our request and ACKed it immediately, and then
// sent a data segment in reply. However, the ACK is reordered
// behind the reply data segment.

// First we receive a response packet.
+.010 < . 1:1001(1000) ack 1001 win 257 <nop, nop, TS val 2022 ecr 1010>
   +0 > . 1001:1001(0) ack 1001 <nop, nop, TS val 1020 ecr 2022>

// Reset nstat counters, in case we're not in a new network namespce:
   +0 `nstat -n`

// Then we receive a disordered pure ACK packet with old sequence number.
   +0 < . 1:1(0) ack 1001 win 257 <nop, nop, TS val 2020 ecr 1010>
// Because it fails PAWS but is an expected kind of pure ACK with
// an old sequence number, we don't send a dupack.
// But verify that we increment TcpExtPAWSOldAck.
   +0 `nstat | grep TcpExtPAWSOldAck | grep -q " 1 "`

// Wait a while to verify we don't send a dupack for that disoordered ACK.

// Expect another transmit so that packetdrill will sniff that
// and see any erroneous dupack instead if we sent that.
+.300 write(4, ..., 1000) =3D 1000
   +0 > P. 1001:2001(1000) ack 1001 <nop, nop, TS val 1320 ecr 2021>

