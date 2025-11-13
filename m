Return-Path: <netdev+bounces-238478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 526ADC597B3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D11144FC221
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C431248F78;
	Thu, 13 Nov 2025 18:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EajP37gn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E3239E80
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057324; cv=none; b=UOB0hylsJMcrUkTLHOo08qtVv4SIMWcg+Rdz+NJg35y39Jf57SYmPydKDZ5nHGNK7De7SR70J8k58PdPCaYkXDJ6f3RQ3AAV81rbSsPAjNLTK0OcLi6BI6cH03Zj4qL+fLFrBiXTRUP9UvMIOXwcdSB82E9TAH6hv6D9dae3C3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057324; c=relaxed/simple;
	bh=TPj9owb7ElRzwm4Sf1okokwYt3tx8Ju1RG0RisUx9CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1t9wjtD4ddfleWSAQmr6CXBZ5KHtz1H4I61dWERSyHgfsoFPSc/BcqED+CvzwowcfAIsTL9IZTdWdxWKPpx5IILFt6haAayiGtGuk/SEHwNnjJKklzIRb1qfdAYTi8P5qh/0NQoy0uFwHuCW2HRG5TT80I28fsDhZADvEGDQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EajP37gn; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89de04d62so9377201cf.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057321; x=1763662121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOE+7hjXFDqSPg0qZDe6sqr/yDBVryU/1Dzunle7zHc=;
        b=EajP37gnYB0Pu5zPvEqHDmlBlBHs1RU6NtbuMxJiPH2lDE7IYi4UtCsRxQBHk3VWzs
         Uoy4dp9NCpdNE3mGwSfje8ok+Le1l04AYbOY1IL74fk56FxpDAir8ILJixEMLAsf4aom
         lnkiW9Um/l799hk1eG6o1LpekAyjGvFTq0bAjTby68G7yktuloXXaDIrS8eDtkmukFAv
         s74tYPwR+xhmTj68uDjllnYHhnUL93cWTSChl1JnzJ+3dKVMw8LaImvnq2YCHKwwivFm
         0A2nct8kvOp1Y0pDxf8b7BU0WyeiOwKY4dLiRihr/ZFVGl2kmWAX88m5+MsrqxQBtRRR
         P0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057321; x=1763662121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOE+7hjXFDqSPg0qZDe6sqr/yDBVryU/1Dzunle7zHc=;
        b=CutFnetYes+zyhambMAuxA/eQOxzfqvEbobZj7zpfbqZAo1ehWhcKWQvK6wZcDxvnc
         g6AtalcVu90gNQhmAbvhQlzthziy5KQXxik4vxpQbzjCVo0tyhY+YszsOnj3MOJzdOTL
         Y/Ehar3ymm8PCkTNUomNKFWAsbPVX11s2jwOe1piUpBB3arzahVyANTyKyPzU0XUcNrA
         L2hClqhwBJQBjSudXFTj4bgaZbkOnyv28mO9yF4KMYvlotI3wpAwLUT+qgViE/1hlIY7
         djZ9AnVCDqyobqIPrFYRcQMVMAjD/BE6n839+KAUuVD/Zf+aW4+L+/SBUJcnLgLS93Z8
         i3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhV+pgu2SajEsRRL75nP5CaNH7LhTGUNDWY0hDHpZY8CyIMPaHC8UTL5ms0kdEC4qDuUQUQrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7RioVY1GKGExyn54PUpsdT9mXJ30YSk/aLn9JlWmZVOJuWZ/
	u71bNdWAe4HlI2JsZkZX0N2QiNSxFyCdh/66wklyqgR1KxCxeoyC6/Z5STJTBWEnmHwGoKFWOWh
	BoxC63CDaNclkZ7UVPoFCLA/cMW5mzfGYUv2LGWst
X-Gm-Gg: ASbGncv1mBO0igGybjNq8QmAlc6OE3J/ts0Urgyw9C2lCK1BhhWgF5hBmrEoGqkmVDE
	AsWvXVDh3BfhBG+zLGVxgLLvxo9JTt6FHuctlfDR8iwwOJEcHmn1FWJnFSu5AzrWbKihaCJ9o7a
	K///OplQWb+nKjzTwiLe4I3NDjTxIQ6UGSpnmNl3J05SUSuIf/TrQxD+m8X4G+Y9PMP7Q/0oALh
	NDqOrG7kiZnZ9SIiAhasJ1sCXcOEdOxQKU0LnlpLPZV+jxVTiuseeQkEfzp6tNzuwgtYNCNTUua
	nspiaPo=
X-Google-Smtp-Source: AGHT+IGYx8qwsgOK6f5BDSlB3h1TSCEInhHLxMEyR8ML0bjOALTl+Joz+vpAEMHTGB6LHiC6/0Sf0Oc1tMGnb5heKr4=
X-Received: by 2002:a05:622a:e:b0:4e8:9ad9:f3da with SMTP id
 d75a77b69052e-4edf20a188dmr9931171cf.30.1763057320983; Thu, 13 Nov 2025
 10:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109161215.2574081-1-edumazet@google.com> <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
 <CAM0EoMkSBrbCxdai6Hn=aaeReqRpAcrZ4mA7J+t6dSEe8aM_dQ@mail.gmail.com> <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com>
In-Reply-To: <CAM0EoMkw11Usx6N2JJDqCoFdBUhLcQ0FYQqMzaSKpnWo1u19Vg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 13 Nov 2025 10:08:29 -0800
X-Gm-Features: AWmQ_bnAjwR8BctAteuHj1OlBxQYLzHekpkxJbvnAlqSgZOD287eCLVpc8NSjYA
Message-ID: <CANn89iJ95S3ia=G7uJb-jGnnaJiQcMVHGEpnKMWc=QZh5tUS=w@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@google.com, 
	willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	hawk@kernel.org, patchwork-bot+netdevbpf@kernel.org, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 9:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> [..]
> Eric,
>
> So you are correct that requeues exist even before your changes to
> speed up the tx path - two machines one with 6.5 and another with 6.8
> variant exhibit this phenoma with very low traffic... which got me a
> little curious.
> My initial thought was perhaps it was related to mq/fqcodel combo but
> a short run shows requeues occur on a couple of other qdiscs (ex prio)
> and mq children (e.g., pfifo), which rules out fq codel as a
> contributor to the requeues.
> Example, this NUC i am typing on right now, after changing the root qdisc=
:
>
> --
> $ uname -r
> 6.8.0-87-generic
> $
> qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
> 0 1 1 1 1 1 1 1 1
>  Sent 360948039 bytes 1015807 pkt (dropped 0, overlimits 0 requeues 1528)
>  backlog 0b 0p requeues 1528
> ---
>
> and 20-30  seconds later:
> ---
> qdisc prio 8004: dev eno1 root refcnt 5 bands 8 priomap 1 2 2 2 1 2 0
> 0 1 1 1 1 1 1 1 1
>  Sent 361867275 bytes 1017386 pkt (dropped 0, overlimits 0 requeues 1531)
>  backlog 0b 0p requeues 1531
> ----
>
> Reel cheep NIC doing 1G with 4 tx rings:
> ---
> $ ethtool -i eno1
> driver: igc
> version: 6.8.0-87-generic
> firmware-version: 1085:8770
> expansion-rom-version:
> bus-info: 0000:02:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: yes
>
> $ ethtool eno1
> Settings for eno1:
> Supported ports: [ TP ]
> Supported link modes:   10baseT/Half 10baseT/Full
>                         100baseT/Half 100baseT/Full
>                         1000baseT/Full
>                         2500baseT/Full
> Supported pause frame use: Symmetric
> Supports auto-negotiation: Yes
> Supported FEC modes: Not reported
> Advertised link modes:  10baseT/Half 10baseT/Full
>                         100baseT/Half 100baseT/Full
>                         1000baseT/Full
>                         2500baseT/Full
> Advertised pause frame use: Symmetric
> Advertised auto-negotiation: Yes
> Advertised FEC modes: Not reported
> Speed: 1000Mb/s
> Duplex: Full
> Auto-negotiation: on
> Port: Twisted Pair
> PHYAD: 0
> Transceiver: internal
> MDI-X: off (auto)
> netlink error: Operation not permitted
>         Current message level: 0x00000007 (7)
>                                drv probe link
> Link detected: yes
> ----
>
> Requeues should only happen if the driver is overwhelmed on the tx
> side - i.e tx ring of choice has no more space. Back in the day, this
> was not a very common event.
> That can certainly be justified today with several explanations if: a)
> modern processors getting faster b) the tx code path has become more
> efficient (true from inspection and your results but those patches are
> not on my small systems) c) (unlikely but) we are misaccounting for
> requeues (need to look at the code). d) the driver is too eager to
> return TX BUSY.
>
> Thoughts?

requeues can happen because some drivers do not use skb->len for the
BQL budget, but something bigger for GSO packets,
because they want to account for the (N) headers.

So the core networking stack could pull too many packets from the
qdisc for one xmit_more batch,
then ndo_start_xmit() at some point stops the queue before the end of
the batch, because BQL limit is hit sooner.

I think drivers should not be overzealous, BQL is a best effort, we do
not care of extra headers.

drivers/net/ethernet/intel/igc/igc_main.c is one of the overzealous drivers=
 ;)

igc_tso() ...

/* update gso size and bytecount with header size */
first->gso_segs =3D skb_shinfo(skb)->gso_segs;
first->bytecount +=3D (first->gso_segs - 1) * *hdr_len;

>
> We will run some forwarding performance tests and let you know if we
> spot anything..
>
> cheers,
> jamal

