Return-Path: <netdev+bounces-238484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55954C59864
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C8B3B4403
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F683312825;
	Thu, 13 Nov 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L3JT7XSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EC311944
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058974; cv=none; b=mHlYOpwjKofPY298DlvhNLhuJog8aQ5SlC8jDYdFReYO/c4LnPMi9pmzyjT5Bcyib0k7x1p269IN/mXrTXB8QWyRW9RUcynpiZrqt3y9qEz2UjFag32A7tcQ2D8HJH5tfovb/M3RhUqUjGC7B+OJwuhDm0BOwuqfOWD5QTLAusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058974; c=relaxed/simple;
	bh=gCusZ2CvGn3PT4DpSnnWvn7C9upgZcVl4IHFAhnI1M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrrwXk2hCQzs8Nm1M3Yucg9CRl+0eFC20sOcRVG5eicFpVuaYQyaR6We5tPykVAEPVd9lWsXYyL6hXE1wBhBTnrodDIXG3AGJ9h5hXdKM9KgmTB9wU45D+zdZRRBa+j3wtFr0gihcb3Fcwj518Sxix9U0S02bhm55MzIfqRhwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L3JT7XSJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4eddceccb89so11895671cf.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763058971; x=1763663771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wfn6jnzOozPaW1IElC9f71jjq3WmKJgIxKXaoHpGGA=;
        b=L3JT7XSJzJdB7/7hkWv0qLkfbtpehfN+NuXuJdAAwKV/CvMYnVlp2b8Qas9F6aCZA8
         6jZmFUOO/WKZAJ9s2omOTHc45PPxmK7qmt0WNtHBfNMytT35U1MhI/PvHfrVMJpcBtsj
         naHcc5Fe6oSSB4S6057TWhocUEzc3UOi9z9JBcbnf6ZuHjKGv4LEu4WmbGDY8eIdUck7
         JU6kzx+//YPQT3t2zi4G0MYlIx9KYgewWU/wMe1aXalosdgbhuEFRaEzJfQq8fNANKXC
         prM2h9yzY517IZ7LtWzL+kUjXUnwj3adNpi/NSrGIlz72RIBYmhAd6QzGJ/tmqzdzdbj
         IP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058971; x=1763663771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wfn6jnzOozPaW1IElC9f71jjq3WmKJgIxKXaoHpGGA=;
        b=EfODp7S0pecQhWn14enwhobkK0fm6zxmk1rfgtYdcgJ/pNtIkf0zMpvqIWD6bZuZpu
         Pu1KGmoUA4vlJaOfqd0+hiI4x5wKAkOh+5d7Fr1yWy7nhs6KDYFOtrzy5LB2CVI1I0vE
         P/rPjNWDiUo71CAnkOUHOPb6TIpE/1VTX5esFzsKYc9M6dhtnS5wBPLn2gHz8Dn+Vp+7
         9KpyxutE2nZL+Fel8/0UydTK8Iw6D8mQ9KGwSq3X1yfFf4TnyjWKo9LleHg9gH7GtxvH
         FLFtWKnXGICS/BF3UlfLuqdrwUnJTGkX5c1s7vFG6wWIYVHQZ2bSQgZf67HR3vrybdvi
         tvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKN/HQlIWX8Bnkow7hdAGsnElMBlrrq7rWIwAE+6Yc3gv3NThppfLLQAUhoN6Q+Td96SjmI10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyJ3eTQVDsrCpQ9ubrE6Fcsgyx7lIsfmucjmZTYxhBF2g69Dx
	xbt/d3Cm1N/HrSOog1MQp5Fi3sjxgp/E69WlKOpmY0gmxoMoCBWnN/L6Eoa0x5JsDgU/3y0OC64
	MdD35z0idGhol7lToskCY8Q0MBDNCS10NGs2wf944
X-Gm-Gg: ASbGnctdBoD0Jo4Pha+KY+BJ+31nyqnL76+AWbAPQAhT3/NAp76FBXnjukJZoYpUDch
	QewuKs36lv9AMVO0jnUynL6j1jPBAB0iBj1hDcvHoiBaWWrFEn9sVaC/aOaIjw8FgIEOSyVx5+c
	kuv1ctUh1e6F5WK7LdHFastTQnnhfzPz1iFRpLwQrqOU6Cgh7KTVZt9uURW606cOCqzfSatrCUx
	w7Pf6ZcW+uyILNoFXXNQ6bduUnGrF3pOv2QaZ98SQ+digOBoqEK//B631+LRWoopgrh+UH5ysXc
	26tZI3A=
X-Google-Smtp-Source: AGHT+IHTxhRxpoIbvLkiU8vcGQgzbnSnKXTF1IG3ZtTfyvEoNVDtDk1syfvoQ+hGgrxZsFIAR2Blr9S1PwxnW+sSFvc=
X-Received: by 2002:a05:622a:44d:b0:4ec:f49c:af11 with SMTP id
 d75a77b69052e-4edf210c564mr10132821cf.46.1763058970573; Thu, 13 Nov 2025
 10:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
 <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com>
 <CANn89iJ95S3ia=G7uJb-jGnnaJiQcMVHGEpnKMWc=QZh5tUS=w@mail.gmail.com> <CAM0EoMmPV8U3oNyf3D2F_RGzJgZQiMRBPq1ytokSLo6PcwFJpA@mail.gmail.com>
In-Reply-To: <CAM0EoMmPV8U3oNyf3D2F_RGzJgZQiMRBPq1ytokSLo6PcwFJpA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 10:35:59 -0800
X-Gm-Features: AWmQ_blbh-UE2Es61kocd3Zd10GXsJTiVPjRwQBEH6WDn31ZUg8l3hjPRd87wXY
Message-ID: <CANn89iJdK4e-5PCC3fzrC0=7NJm8yXZYcrMckS9oE1sZNmzPPw@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:30=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > [..]
> > > Eric,
> > >
> > > So you are correct that requeues exist even before your changes to
> > > speed up the tx path - two machines one with 6.5 and another with 6.8
> > > variant exhibit this phenoma with very low traffic... which got me a
> > > little curious.
> > > My initial thought was perhaps it was related to mq/fqcodel combo but
> > > a short run shows requeues occur on a couple of other qdiscs (ex prio=
)
> > > and mq children (e.g., pfifo), which rules out fq codel as a
> > > contributor to the requeues.
> > > Example, this NUC i am typing on right now, after changing the root q=
disc:
> > >
> > > --
> > > $ uname -r
> > > 6.8.0-87-generic
> > > $
> > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
> > > 0 1 1 1 1 1 1 1 1
> > >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 requeues 1=
528)
> > >  backlog 0b 0p requeues 1528
> > > ---
> > >
> > > and 20-30  seconds later:
> > > ---
> > > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
> > > 0 1 1 1 1 1 1 1 1
> > >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 requeues 1=
531)
> > >  backlog 0b 0p requeues 1531
> > > ----
> > >
> > > Reel cheep NIC doing 1G with 4 tx rings:
> > > ---
> > > $ ethtool -i eno1
> > > driver: igc
> > > version: 6.8.0-87-generic
> > > firmware-version: 1085:8770
> > > expansion-rom-version:
> > > bus-info: 0000:02:00.0
> > > supports-statistics: yes
> > > supports-test: yes
> > > supports-eeprom-access: yes
> > > supports-register-dump: yes
> > > supports-priv-flags: yes
> > >
> > > $ ethtool eno1
> > > Settings for eno1:
> > > Supported ports: [ TP ]
> > > Supported link modes:   10baseT/Half 10baseT/Full
> > >                         100baseT/Half 100baseT/Full
> > >                         1000baseT/Full
> > >                         2500baseT/Full
> > > Supported pause frame use: Symmetric
> > > Supports auto-negotiation: Yes
> > > Supported FEC modes: Not reported
> > > Advertised link modes:  10baseT/Half 10baseT/Full
> > >                         100baseT/Half 100baseT/Full
> > >                         1000baseT/Full
> > >                         2500baseT/Full
> > > Advertised pause frame use: Symmetric
> > > Advertised auto-negotiation: Yes
> > > Advertised FEC modes: Not reported
> > > Speed: 1000Mb/s
> > > Duplex: Full
> > > Auto-negotiation: on
> > > Port: Twisted Pair
> > > PHYAD: 0
> > > Transceiver: internal
> > > MDI-X: off (auto)
> > > netlink error: Operation not permitted
> > >         Current message level: 0x00000007 (7)
> > >                                drv probe link
> > > Link detected: yes
> > > ----
> > >
> > > Requeues should only happen if the driver is overwhelmed on the tx
> > > side - i.e tx ring of choice has no more space. Back in the day, this
> > > was not a very common event.
> > > That can certainly be justified today with several explanations if: a=
)
> > > modern processors getting faster b) the tx code path has become more
> > > efficient (true from inspection and your results but those patches ar=
e
> > > not on my small systems) c) (unlikely but) we are misaccounting for
> > > requeues (need to look at the code). d) the driver is too eager to
> > > return TX BUSY.
> > >
> > > Thoughts?
> >
> > requeues can happen because some drivers do not use skb->len for the
> > BQL budget, but something bigger for GSO packets,
> > because they want to account for the (N) headers.
> >
> > So the core networking stack could pull too many packets from the
> > qdisc for one xmit_more batch,
> > then ndo_start_xmit() at some point stops the queue before the end of
> > the batch, because BQL limit is hit sooner.
> >
> > I think drivers should not be overzealous, BQL is a best effort, we do
> > not care of extra headers.
> >
> > drivers/net/ethernet/intel/igc/igc_main.c is one of the overzealous dri=
vers ;)
> >
> > igc_tso() ...
> >
> > /* update gso size and bytecount with header size */
> > first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> > first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
> >
>
>
> Ok, the 25G i40e driver we are going to run tests on seems to be
> suffering from the same enthusiasm ;->
> I guess the same codebase..
> Very few drivers tho seem to be doing what you suggest. Of course idpf
> being one of those ;->

Note that few requeues are ok.

In my case, I had 5 millions requeues per second, and at that point
you start noticing something is wrong ;)

