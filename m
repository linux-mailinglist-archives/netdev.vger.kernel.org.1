Return-Path: <netdev+bounces-238488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08413C59954
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11E6B343613
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D503313536;
	Thu, 13 Nov 2025 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wc7E7myc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACE2FDC49
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060145; cv=none; b=HwgVfQmL/CR3yxDx1czbsu0Tuu22r+YaVubOARHQtuLaN6QpBtb05vgz49EV2/CF7hGZcznJaUXk4D0G7t8GEkqjr1TyICc4UF1pAeeXW5T54FATO2plUCTP6zt5MVXHOMjzhgkxNOMG/BpY+fRQFx6IJCi+kxp7fzOe9QoRtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060145; c=relaxed/simple;
	bh=htTEOhI9Yz6u6giiwRVyW2C+k1tXyxWTOwXm8pAayK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSuBRjDzstJwYf2a4NVYayuCSaIo3y7ViGXmJ9Z3lwoWyVfCgyzS8lYV8wPyp/b7Xg4pbWXdAwvIvNLd6wWGMxdZcaK9gQrhasgbZ/SFAuwQoJk691d8RU1cHA9UFLg1f1mWKNk/eQbspE4+NsXyUhRxLaCKXjfVAmWguhbXF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wc7E7myc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso1528485a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763060142; x=1763664942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkWinxulOdrO+lKc81tXL3gsW3pquvjBTQ9X/3x2QW4=;
        b=wc7E7mycZ9m3t+TMyq9fURPjP+pPE/nQ8XOElu7GTehXg7o4a8pgiQDTril7HjK9wB
         aIkhtPI/tUn4VSgFagsYjcU0DFEaOB1RMX8ecbWxpiSvyrtn64XrAKAXodsybFThfHMw
         mkaieaFn5XfodDar5FiBu/Z1OIYtVua5WUNgWZKqmoV+aLD+hYzyCTeuQOQ6hUTAJgLq
         fkNDCmdNM1giSwBITWBFM2j2FWPU432j91v6VjiMW2Gww31mTN5AZRvTeB40ZSKKp/ib
         HiwAiKPeSjXLDntqKu/s9J5oK+2Y1T20OpD/n4arj/U0BV/GRXomQHVNsn6fxCghHZaJ
         rkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763060142; x=1763664942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JkWinxulOdrO+lKc81tXL3gsW3pquvjBTQ9X/3x2QW4=;
        b=n0XGU4qY6Pz1A8H4c6sv4h9VhReCjOj0sngFTKMWGmWX9KShn77YCDVXeCdlnIv/XL
         +AtBXDIfKI1BET0jKrqr2jetw7kZAsozJjatm7dc+3vf8HUMniboa0kI9dTqvWs1AcJ/
         jW30csetJMoRJAFT5i+oCnt36QOkOugowMXiqT6EU66pp3HjenNyMFwt+OQpuTPmIbKx
         e/JmUsVg1OwL7FyvZ3CJq+5xMbSLd5JipcP79PMnx6Koez7jiCMILMg5mwp19CoRa3C1
         dFl5Ggp3D9zjjqDdg8SgUJRpqCd6Zfwl4W1JgeFtZoO9YjZ5AfFg13qOF1OteNKq2Rmh
         49ig==
X-Forwarded-Encrypted: i=1; AJvYcCWkKf0FKmcXAcNf3XFhaobiTmtmVP6G0zzXFITXdaDkpwwXOJ/+ean9ROkhMt7WEXwYj6SKB6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKs6r0teiTrDVjoTNL4QV6BswLBJHObnWfGP8yqH4qHvPUaa1S
	ek+mfhH+k9ZZVxDfnNRBXu5KS9PCCACwI0Fsxr3410eamlL5jKwXenBHGRQSw+4c+YfF6B928kY
	UmJJtgr4QONMRyaYIkGsf1IuVETKD8aGjat/X7wRQ
X-Gm-Gg: ASbGncsc7WdvQ3iui3/K3yWZ+hHGnHwNRyhs+YEcjtg6EFj37JTUXu4uLA8Mp89tuTW
	VMqrvrmUMbCvLYlAFh99g0IswUEEc/sLLt+u0EpYwvr4QDAnO2IV1X7cU8/KxbLu65GQDRS+vNt
	9H1KRcZ399lte+9Pa2OpNIycLrjdmpsY1wl+Q+64piVDmBj58JZ8LjJjJDbqSHkIwxJ5ZjaLPo3
	q+TrMIIDG/cFooATDWufVK+jrpwsgIVVrbWkMIJF8hWumJllQDcNx90LNllmJ09UVdARXzLn9lP
	C9I=
X-Google-Smtp-Source: AGHT+IFIRvvbJ08AJAX500MvawIcLmPmG0exXYYIZPRhP7cWmHWDKlD4WHHbZx/ogJUK5wMpywdbCrt0BEE9uygPhzI=
X-Received: by 2002:a17:90b:2ccc:b0:343:6d82:9278 with SMTP id
 98e67ed59e1d1-343fa76032dmr296405a91.30.1763060142585; Thu, 13 Nov 2025
 10:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
 <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com>
 <CANn89iJ95S3ia=G7uJb-jGnnaJiQcMVHGEpnKMWc=QZh5tUS=w@mail.gmail.com>
 <CAM0EoMmPV8U3oNyf3D2F_RGzJgZQiMRBPq1ytokSLo6PcwFJpA@mail.gmail.com> <CANn89iJdK4e-5PCC3fzrC0=7NJm8yXZYcrMckS9oE1sZNmzPPw@mail.gmail.com>
In-Reply-To: <CANn89iJdK4e-5PCC3fzrC0=7NJm8yXZYcrMckS9oE1sZNmzPPw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Nov 2025 13:55:31 -0500
X-Gm-Features: AWmQ_blqG4YCU3Cw4cxGIpLpNg_sHaxrPi1tcUjnUMGGSBZ4xJWqZ-A-WNHXbKc
Message-ID: <CAM0EoMkw6mKtk-=bRQtjWsTphJHNJ0j4Dk1beYS181c5SHZv4Q@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Nov 13, 2025 at 10:30=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > [..]
> > > > Eric,
> > > >
> > > > So you are correct that requeues exist even before your changes to
> > > > speed up the tx path - two machines one with 6.5 and another with 6=
.8
> > > > variant exhibit this phenoma with very low traffic... which got me =
a
> > > > little curious.
> > > > My initial thought was perhaps it was related to mq/fqcodel combo b=
ut
> > > > a short run shows requeues occur on a couple of other qdiscs (ex pr=
io)
> > > > and mq children (e.g., pfifo), which rules out fq codel as a
> > > > contributor to the requeues.
> > > > Example, this NUC i am typing on right now, after changing the root=
 qdisc:
> > > >
> > > > --
> > > > $ uname -r
> > > > 6.8.0-87-generic
> > > > $
> > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2=
 0
> > > > 0 1 1 1 1 1 1 1 1
> > > >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 requeues=
 1528)
> > > >  backlog 0b 0p requeues 1528
> > > > ---
> > > >
> > > > and 20-30  seconds later:
> > > > ---
> > > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2=
 0
> > > > 0 1 1 1 1 1 1 1 1
> > > >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 requeues=
 1531)
> > > >  backlog 0b 0p requeues 1531
> > > > ----
> > > >
> > > > Reel cheep NIC doing 1G with 4 tx rings:
> > > > ---
> > > > $ ethtool -i eno1
> > > > driver: igc
> > > > version: 6.8.0-87-generic
> > > > firmware-version: 1085:8770
> > > > expansion-rom-version:
> > > > bus-info: 0000:02:00.0
> > > > supports-statistics: yes
> > > > supports-test: yes
> > > > supports-eeprom-access: yes
> > > > supports-register-dump: yes
> > > > supports-priv-flags: yes
> > > >
> > > > $ ethtool eno1
> > > > Settings for eno1:
> > > > Supported ports: [ TP ]
> > > > Supported link modes:   10baseT/Half 10baseT/Full
> > > >                         100baseT/Half 100baseT/Full
> > > >                         1000baseT/Full
> > > >                         2500baseT/Full
> > > > Supported pause frame use: Symmetric
> > > > Supports auto-negotiation: Yes
> > > > Supported FEC modes: Not reported
> > > > Advertised link modes:  10baseT/Half 10baseT/Full
> > > >                         100baseT/Half 100baseT/Full
> > > >                         1000baseT/Full
> > > >                         2500baseT/Full
> > > > Advertised pause frame use: Symmetric
> > > > Advertised auto-negotiation: Yes
> > > > Advertised FEC modes: Not reported
> > > > Speed: 1000Mb/s
> > > > Duplex: Full
> > > > Auto-negotiation: on
> > > > Port: Twisted Pair
> > > > PHYAD: 0
> > > > Transceiver: internal
> > > > MDI-X: off (auto)
> > > > netlink error: Operation not permitted
> > > >         Current message level: 0x00000007 (7)
> > > >                                drv probe link
> > > > Link detected: yes
> > > > ----
> > > >
> > > > Requeues should only happen if the driver is overwhelmed on the tx
> > > > side - i.e tx ring of choice has no more space. Back in the day, th=
is
> > > > was not a very common event.
> > > > That can certainly be justified today with several explanations if:=
 a)
> > > > modern processors getting faster b) the tx code path has become mor=
e
> > > > efficient (true from inspection and your results but those patches =
are
> > > > not on my small systems) c) (unlikely but) we are misaccounting for
> > > > requeues (need to look at the code). d) the driver is too eager to
> > > > return TX BUSY.
> > > >
> > > > Thoughts?
> > >
> > > requeues can happen because some drivers do not use skb->len for the
> > > BQL budget, but something bigger for GSO packets,
> > > because they want to account for the (N) headers.
> > >
> > > So the core networking stack could pull too many packets from the
> > > qdisc for one xmit_more batch,
> > > then ndo_start_xmit() at some point stops the queue before the end of
> > > the batch, because BQL limit is hit sooner.
> > >
> > > I think drivers should not be overzealous, BQL is a best effort, we d=
o
> > > not care of extra headers.
> > >
> > > drivers/net/ethernet/intel/igc/igc_main.c is one of the overzealous d=
rivers ;)
> > >
> > > igc_tso() ...
> > >
> > > /* update gso size and bytecount with header size */
> > > first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> > > first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
> > >
> >
> >
> > Ok, the 25G i40e driver we are going to run tests on seems to be
> > suffering from the same enthusiasm ;->
> > I guess the same codebase..
> > Very few drivers tho seem to be doing what you suggest. Of course idpf
> > being one of those ;->
>
> Note that few requeues are ok.
>
> In my case, I had 5 millions requeues per second, and at that point
> you start noticing something is wrong ;)

That's high ;-> For the nuc with igc, its <1%. Regardless, the
eagerness for TX BUSY implies reduced performance due to the early
bailout..

cheers,
jamal

