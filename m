Return-Path: <netdev+bounces-238483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85306C59783
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B84934DC22
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4E26CE25;
	Thu, 13 Nov 2025 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="luJdEnRn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F91494D9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763058644; cv=none; b=YZL7azmyB+GNAePh1Vfqj3JV+T7DK+/oLZBwOazisRC455k1EpHRgsMKuXOMQYsvpA/1K/9YutktLvt6kMszMHJwdVcqTasas1aMgThJpEJ8h7pouf76tmf8dbeGgda7jfFkV7Sr+ru5eNXdMYUnFJzDA+J7n+oeDGodduuZ9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763058644; c=relaxed/simple;
	bh=yVE12btSg951y0TBnCixOTeca0DAsGsY0dTb2B2HXlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qc4I4CNsiwXPlBK1+I7yJ+lm+ChD22UplPHJcJ+xKrp7Xe4py4B/eZL1iUN+4NfWuZSAw42rw+0poC+jsJeeu3x+7E7Yx0zQPXhslfsTgwEo/PsfH6M0Rq7t5cEdloDh3BcGmArQFRoD9lUbXeEOZZP66YmGliHAvV7oS2tiaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=luJdEnRn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2953ad5517dso13615335ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763058642; x=1763663442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AQ5GVaZfPbEYUwTotpI2py2VVLfOmk5tW4nPOZYLD8=;
        b=luJdEnRnvzNAuqrFR3yqLu6Q/630a9VnM/3V40nZ5N6iqrFviX2RPJv4Ig1KFSZ/9n
         pVp+ndSf48D1uCw/xa8k6EgnMZmcQQV9IZvUOvVX7a49gHVGKkM5KQ0VyjfIpSxQ6yZX
         Iq+4Op2dh9MKcq1BGa+0iOkYvLltFGj2TXilgw2DbtaTmyqszl9bSg9VqlBDAyH0Uj/7
         rbGLYT/bFjm2hvQHDRwcrS02FEvKtYNzBYbRDe47tJkqFyaCA0F6ONWXGNdulfiSrgCO
         eny/wS+rQywivGWHo0CUc3nSbbos2lqZrGaTmKtbdc7lxOBHQVVghPD9LjQaj1m003IB
         MJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763058642; x=1763663442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AQ5GVaZfPbEYUwTotpI2py2VVLfOmk5tW4nPOZYLD8=;
        b=wyZhIo4Uwee00sw6KqyFKMWGo0mx4SMpqODCvQNcWLvWBLwls3Xg571xTdWLkmo6o3
         y4MD0uckCLaSM9B+XXtPGqf8l9z0u/DkUwLQ0U0jVQCdWYfjgTBo7NHbjJ0DYevdaqVX
         21b31TZb+mudVoGH3N5Xbv9qoRCqTNrSo/aaZ0RemjN6eL7tiFOw/xuTaIe+XJZtM7w2
         GFHfO5EO/s2j1CUH9AHirjo2Rl+tpYTP+rk7nTUFDNzzUbni/ewl4YcC+wlYH3Ft/u/y
         B+qHVqjeX2oCvg+5ZB/COK23UOwP5Qc8QblC0bV+5PoNU3zaYXESSRN2Ji1dkEWQsqnF
         TmQg==
X-Forwarded-Encrypted: i=1; AJvYcCWeHsgvzlrwXfs8Hi2UcZiWYQ811VxmD3u6wf5BcXkgvzrW2E1XBfjyF0GS/nbWFPF6xivjsBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fgIZjx762dA13KAfFznm7yDXPKPsZDOXp3e2OfO8rGnAHIoV
	KA/AKBSOkmScewtFEQ5dsw1KK2MV62lgRdJvFdAefRsVVdtSDxgs/1sXLcmsnfwnMOLgecehcka
	GcVhBJVsSA/RcS3Y2XSFQYSbJnyN7npREGPl24ANu
X-Gm-Gg: ASbGncuHutvrrR25JNFPUq7Cuqe3DJhPz9LSgkyqqiIjxRs96eQ/AsT1jIyOMLeWlzq
	C0a8N6FR2iUnOn7X/HP2L8qKmJBwr0iT/ONEzqUearQFBeH3DFcCAK41M3ZF0f9ehGBc1QvFxqZ
	mioKbx84NsAdIIxc5/AmT7gZmfcTvSOOaUmff1ijvai5SyyLm+SthuUUpcc4VYGqwGQ123S0RbW
	/rkcCMBZAHezP2CnyMLK1aSfoCtdm+4zTCNtMNWk3X6cdHTmlU6TVU+ct0btYcN5PHahQZZxjo8
	Y9w=
X-Google-Smtp-Source: AGHT+IHBAZcI8FeHu8bwcdqsaCovkzB+4/YjViMHmDx5xcaJSzA8Hn+E6f1KUwI71nmo9E2D+GOStjEHS/o+S2gK6Qk=
X-Received: by 2002:a17:903:244a:b0:295:54cb:a8df with SMTP id
 d9443c01a7336-2984edec25cmr94862975ad.36.1763058642061; Thu, 13 Nov 2025
 10:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com>
 <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com> <CANn89iJ95S3ia=G7uJb-jGnnaJiQcMVHGEpnKMWc=QZh5tUS=w@mail.gmail.com>
In-Reply-To: <CANn89iJ95S3ia=G7uJb-jGnnaJiQcMVHGEpnKMWc=QZh5tUS=w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 13 Nov 2025 13:30:30 -0500
X-Gm-Features: AWmQ_blTVoi0Spitn6I0HFJnZGxFNOliKpe70CpZXmMhcnpuqd30171BuviR_4U
Message-ID: <CAM0EoMmPV8U3oNyf3D2F_RGzJgZQiMRBPq1ytokSLo6PcwFJpA@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 1:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > [..]
> > Eric,
> >
> > So you are correct that requeues exist even before your changes to
> > speed up the tx path - two machines one with 6.5 and another with 6.8
> > variant exhibit this phenoma with very low traffic... which got me a
> > little curious.
> > My initial thought was perhaps it was related to mq/fqcodel combo but
> > a short run shows requeues occur on a couple of other qdiscs (ex prio)
> > and mq children (e.g., pfifo), which rules out fq codel as a
> > contributor to the requeues.
> > Example, this NUC i am typing on right now, after changing the root qdi=
sc:
> >
> > --
> > $ uname -r
> > 6.8.0-87-generic
> > $
> > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
> > 0 1 1 1 1 1 1 1 1
> >  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 requeues 152=
8)
> >  backlog 0b 0p requeues 1528
> > ---
> >
> > and 20-30  seconds later:
> > ---
> > qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
> > 0 1 1 1 1 1 1 1 1
> >  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 requeues 153=
1)
> >  backlog 0b 0p requeues 1531
> > ----
> >
> > Reel cheep NIC doing 1G with 4 tx rings:
> > ---
> > $ ethtool -i eno1
> > driver: igc
> > version: 6.8.0-87-generic
> > firmware-version: 1085:8770
> > expansion-rom-version:
> > bus-info: 0000:02:00.0
> > supports-statistics: yes
> > supports-test: yes
> > supports-eeprom-access: yes
> > supports-register-dump: yes
> > supports-priv-flags: yes
> >
> > $ ethtool eno1
> > Settings for eno1:
> > Supported ports: [ TP ]
> > Supported link modes:   10baseT/Half 10baseT/Full
> >                         100baseT/Half 100baseT/Full
> >                         1000baseT/Full
> >                         2500baseT/Full
> > Supported pause frame use: Symmetric
> > Supports auto-negotiation: Yes
> > Supported FEC modes: Not reported
> > Advertised link modes:  10baseT/Half 10baseT/Full
> >                         100baseT/Half 100baseT/Full
> >                         1000baseT/Full
> >                         2500baseT/Full
> > Advertised pause frame use: Symmetric
> > Advertised auto-negotiation: Yes
> > Advertised FEC modes: Not reported
> > Speed: 1000Mb/s
> > Duplex: Full
> > Auto-negotiation: on
> > Port: Twisted Pair
> > PHYAD: 0
> > Transceiver: internal
> > MDI-X: off (auto)
> > netlink error: Operation not permitted
> >         Current message level: 0x00000007 (7)
> >                                drv probe link
> > Link detected: yes
> > ----
> >
> > Requeues should only happen if the driver is overwhelmed on the tx
> > side - i.e tx ring of choice has no more space. Back in the day, this
> > was not a very common event.
> > That can certainly be justified today with several explanations if: a)
> > modern processors getting faster b) the tx code path has become more
> > efficient (true from inspection and your results but those patches are
> > not on my small systems) c) (unlikely but) we are misaccounting for
> > requeues (need to look at the code). d) the driver is too eager to
> > return TX BUSY.
> >
> > Thoughts?
>
> requeues can happen because some drivers do not use skb->len for the
> BQL budget, but something bigger for GSO packets,
> because they want to account for the (N) headers.
>
> So the core networking stack could pull too many packets from the
> qdisc for one xmit_more batch,
> then ndo_start_xmit() at some point stops the queue before the end of
> the batch, because BQL limit is hit sooner.
>
> I think drivers should not be overzealous, BQL is a best effort, we do
> not care of extra headers.
>
> drivers/net/ethernet/intel/igc/igc_main.c is one of the overzealous drive=
rs ;)
>
> igc_tso() ...
>
> /* update gso size and bytecount with header size */
> first->gso_segs =3D skb_shinfo(skb)->gso_segs;
> first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;
>


Ok, the 25G i40e driver we are going to run tests on seems to be
suffering from the same enthusiasm ;->
I guess the same codebase..
Very few drivers tho seem to be doing what you suggest. Of course idpf
being one of those ;->

cheers,
jamal

> > We will run some forwarding performance tests and let you know if we
> > spot anything..
> >
> > cheers,
> > jamal

