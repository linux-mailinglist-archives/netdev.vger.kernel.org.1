Return-Path: <netdev+bounces-271812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CASUKPudxGle1gQAu9opvQ
	(envelope-from <netdev+bounces-271812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:46:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA5D32E77E
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 03:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3273049970
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 02:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EE391500;
	Thu, 26 Mar 2026 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GftbzEJl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMS11hPB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96D38F621
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492908; cv=pass; b=Tr83joUsdE7T4gLj7BvikHYZaG9VvTcDDTNl6bRMxYoa7829bRfIm5fgN6oI17UALDQJt9SHHZFIicuh0Rilb+1PqRyV+6GBbuSaTjFuoOh93j/OAUgHRpe3tSzd62SK+DJIbNyHyB9FzJ5UWA2hiJoWsxlCr66HGWOg3AHQU+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492908; c=relaxed/simple;
	bh=NZuXp9OMgbMNwXIjDFC+3NSoAl7iWLz7wHWTMwoa3bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFlJWo0g7ajg0oLxy+xXOz7hwpfDYUPCrrjJ2QDPVp0Uu3NOUj+XtYmJMph2xkePFv/g4pVSpcZZt7soVJ8loAA2Sj4Fg25oyIS5Jhgh5GsEuxJN7ptWbeCRWI5EGqkS2nT9fDg54jJJ8Wf0nHw1rO5/zx4kuXZv1zn+l9ttfUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GftbzEJl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMS11hPB; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774492904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e03kIxAl55kIcXh5aMreNNyQExpmH90DzHI1x2EvTDI=;
	b=GftbzEJl8bGDF2KNSyw/ljiydj/CxAjBNMAD0JJv7PDvt0HiquY3z9IlTbm7EM8I4Q6HZQ
	GTK/AdCoYlxQhrpskHfhq/eClNi7IWnTCJo0g/TjTirhkZJazP5NCix90Vd39Am2iUwveW
	5BM+/U9qsadVUg/d7kfx9MZn04hXYOI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-NOpvv7dtNDe8PpsZ7NENlA-1; Wed, 25 Mar 2026 22:41:42 -0400
X-MC-Unique: NOpvv7dtNDe8PpsZ7NENlA-1
X-Mimecast-MFC-AGG-ID: NOpvv7dtNDe8PpsZ7NENlA_1774492901
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so594121a91.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:41:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774492901; cv=none;
        d=google.com; s=arc-20240605;
        b=TwBskDQuZHbRx3QXQipMaUFj1vILJabhL6ijNgJFrvymUOoB4Q4ppIO2u0QnJg2EpY
         V1j11WHWFboTbJ3GhS7puYYW6MyB1neSvH6slaX4A+jZw5/ro/sAPf3OnDMrJjEcIcf5
         CGkvi5Cu/IWrMAkiNqwihg7Lo6Uf2iSvT2gNDbTTH3kzRIxqFbiYFMQL7FQq5/s0I9TM
         9wX8QcPIJbrx2n0Mep9ScovxJRFpsDjgqeY1oPOw0yVn4XzZJD/Jpg9De0vdA2vOQ4Ar
         GyFFcEu+tb/QCYjKGHZ5r6DPuzlkvp9KEvvz+UJtfo45tkawwE6cCkmFhVox7i50ZMGe
         RbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e03kIxAl55kIcXh5aMreNNyQExpmH90DzHI1x2EvTDI=;
        fh=ofjdfdEevakEUrTikvvOXR0NhaoPZSUZ/Rh3b+Rn4Bw=;
        b=dvpcvEolOOsH2nY1MpnLrPL9coslCfgwFlmaKGPcLvV8BHk1TTR7jsnVE24/aW4TdN
         Pv033GB6jUG7Fu58VzH4v/BLdb5xOYC1PfnvEGy/iywRcb3Kl+2tdzRMKwOo+6cm2frA
         PyBmg95G9JKOpLAbGyHfOmCS9FoSfvKTAMD8wu9mGkbA20oTrPVzbiEVUrhfBpbzr+3/
         qAODvQN/G4LQ9oMLFgUNsjKRAuAE4yMR5BCqi1hsH/hWMYnT5dLtpk2Z7jeIxoPrgsoE
         k10VYUqxrs0/beAABd9aKgYmbWfGQht3oZos9jxGU55RfgCFvIL/uN12apMwM3nE94Bw
         raRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774492901; x=1775097701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e03kIxAl55kIcXh5aMreNNyQExpmH90DzHI1x2EvTDI=;
        b=EMS11hPBjOVpp6PQEqXTQb9u4+6udRUC/NCHIWfTEy9RAscX0ujZ9+9hIooFjbFbQf
         bG3Szho1Cndm0rv6lVXsI9CLc1pkG+eSEnpj+vlnMPhpueLzl+sNYHa1WM56FMmOy5F5
         qq8Hn5l38MzczdLZvlV32z62WAw7T9rr/dfbsUk+MceERJuGesVs1xM3jWA6X1Y+3oVL
         e0DAaNkgPVSi0mAQkQcrzV1a1QHIdMR4evgTdfKgQPHwpvMWyuP/UkfT8bnLSMFN28tX
         3FRqP9879LIiQ7JVvKn9MhTjTCmOxh7V+27LP0DFEkMexCn2smufOePmbWqer/RFmES7
         jjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492901; x=1775097701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e03kIxAl55kIcXh5aMreNNyQExpmH90DzHI1x2EvTDI=;
        b=byNXDMZVWX9M7AxDJ5YWK3QuPDDyDuTGQAIvtyonpEM1CaA4Muk6m8zbU4WNmalF6l
         TEKCbkJorEODEglm0c2dou77sBI3VQvw2V17zG2l3g9w0NU01bs9LGe/uMH7O7Own/ZD
         Y+TZmE/IWRQOaJv7TS0bgMj1dn6FelYgNiP8Lm5SH4+3tXK77H/WGF2rNf7rwQywi9HL
         K7+nr5enymJHU2z2KRJFc7DNPEgITgCdixVh+dCrxbTnO47gQAw0mtkq3xWXS77rlH4w
         n44WnNm788DtfgSaPrcsSQggJsdPzdJvu9sQYpd/m2fQBwFPuopLJlGoMFbahNLg7Fht
         lgiw==
X-Forwarded-Encrypted: i=1; AJvYcCVfjE5whyZi6djYCdmZLocOCUyWc1wP4YMolpHleaftYptQc9plpeL+KvBjUQq7m2tnArxkH4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNH3SO8Z+5tcdb3s5eCLl3uKba59KmIsLpuD2cwXmZMM75g9qx
	ljcdXQ22+b5r20vQgxZVnEXRnryK8Ainwn9hSPS/4liWOB+2AnornfAFCQAm7gTkswhCbu0+NfL
	F/JjPKnjUChXVPn8Kyf5XitCtLZ80+1a++SsKb+CLSydIt6thZ3fi+Xbzq8y7885C7xod59l3cw
	kta1TYROrOmNvyaBBBTsCHNT4/jiUT9im+
X-Gm-Gg: ATEYQzx553Rll+mB6qBm9//uZHgXDQ2arGU6TLnnR/EheK466BAS0JxkQ4g7UrRfQW7
	ftXO4yosY/Hcffb1sKrAOgMMGJAMsrWvL3T02qk/M6iAaWq6LDylxyBf8T3GwfU/ukeTeRoOTdm
	R5k8anN+80cIvsWYbpHfTaIo6TUCh3lZSHZkUt1Fs7CAfhb3t0RrR3/nmseLSvco+Rn7szvrbwi
	3AQ
X-Received: by 2002:a17:90b:278e:b0:359:8f63:9a25 with SMTP id 98e67ed59e1d1-35c007b464emr8662453a91.3.1774492901091;
        Wed, 25 Mar 2026 19:41:41 -0700 (PDT)
X-Received: by 2002:a17:90b:278e:b0:359:8f63:9a25 with SMTP id
 98e67ed59e1d1-35c007b464emr8662429a91.3.1774492900454; Wed, 25 Mar 2026
 19:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de> <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de> <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
In-Reply-To: <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 10:41:29 +0800
X-Gm-Features: AQROBzCWaeA2at0khp-5AihPvjzqWo4VROly4dD8VgJGx1hCknikvahWTNJja5M
Message-ID: <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271812-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 0DA5D32E77E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:48=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 3/24/26 11:14, Simon Schippers wrote:
> > On 3/24/26 02:47, Jason Wang wrote:
> >> On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
> >> <simon.schippers@tu-dortmund.de> wrote:
> >>>
> >>> This commit prevents tail-drop when a qdisc is present and the ptr_ri=
ng
> >>> becomes full. Once an entry is successfully produced and the ptr_ring
> >>> reaches capacity, the netdev queue is stopped instead of dropping
> >>> subsequent packets.
> >>>
> >>> If producing an entry fails anyways due to a race, tun_net_xmit retur=
ns
> >>> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected becaus=
e
> >>> LLTX is enabled and the transmit path operates without the usual lock=
ing.
> >>>
> >>> The existing __tun_wake_queue() function wakes the netdev queue. Race=
s
> >>> between this wakeup and the queue-stop logic could leave the queue
> >>> stopped indefinitely. To prevent this, a memory barrier is enforced
> >>> (as discussed in a similar implementation in [1]), followed by a rech=
eck
> >>> that wakes the queue if space is already available.
> >>>
> >>> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>
> >> I wonder if we need a dedicated TUN flag to enable this. With this new
> >> flag, we can even prevent TUN from using noqueue (not sure if it's
> >> possible or not).
> >>
> >
> > Except of the slight regressions because of this patchset I do not see
> > a reason for such a flag.
> >
> > I have never seen that the driver prevents noqueue. For example you can
> > set noqueue to your ethernet interface and under load you soon get
> >
> > net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> >                                            dev->name);
> >
> > followed by a -ENETDOWN. And this is not prevented even though it is
> > clearly not something a user wants.
> >
> >>>
> >>> Benchmarks:
> >>> The benchmarks show a slight regression in raw transmission performan=
ce,
> >>> though no packets are lost anymore.
> >>>
> >>> The previously introduced threshold to only wake after the queue stop=
ped
> >>> and half of the ring was consumed showed to be a descent choice:
> >>> Waking the queue whenever a consume made space in the ring strongly
> >>> degrades performance for tap, while waking only when the ring is empt=
y
> >>> is too late and also hurts throughput for tap & tap+vhost-net.
> >>> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >>> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >>> tun/tap+vhost-net.
> >>>
> >>> Test setup:
> >>> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >>> Average over 20 runs @ 100,000,000 packets. SRSO and spectre v2
> >>> mitigations disabled.
> >>>
> >>> Note for tap+vhost-net:
> >>> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >>> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf=
)
> >>>
> >>> +--------------------------+--------------+----------------+---------=
-+
> >>> | 1 thread                 | Stock        | Patched with   | diff    =
 |
> >>> | sending                  |              | fq_codel qdisc |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 1.151 Mpps   | 1.139 Mpps     | -1.1%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> |            | Lost/s      | 3.606 Mpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 3.948 Mpps   | 3.738 Mpps     | -5.3%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> | +vhost-net | Lost/s      | 496.5 Kpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>>
> >>> +--------------------------+--------------+----------------+---------=
-+
> >>> | 2 threads                | Stock        | Patched with   | diff    =
 |
> >>> | sending                  |              | fq_codel qdisc |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 1.133 Mpps   | 1.109 Mpps     | -2.1%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> |            | Lost/s      | 8.269 Mpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>> | TAP        | Transmitted | 3.820 Mpps   | 3.513 Mpps     | -8.0%   =
 |
> >>> |            +-------------+--------------+----------------+---------=
-+
> >>> | +vhost-net | Lost/s      | 4.961 Mpps   | 0 pps          |         =
 |
> >>> +------------+-------------+--------------+----------------+---------=
-+
> >>>
> >>> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.=
org/
> >>>
> >>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>> ---
> >>>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>> index b86582cc6cb6..9b7daec69acd 100644
> >>> --- a/drivers/net/tun.c
> >>> +++ b/drivers/net/tun.c
> >>> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff =
*skb, struct net_device *dev)
> >>>         struct netdev_queue *queue;
> >>>         struct tun_file *tfile;
> >>>         int len =3D skb->len;
> >>> +       bool qdisc_present;
> >>> +       int ret;
> >>>
> >>>         rcu_read_lock();
> >>>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> >>> @@ -1063,13 +1065,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buf=
f *skb, struct net_device *dev)
> >>>
> >>>         nf_reset_ct(skb);
> >>>
> >>> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >>> +       queue =3D netdev_get_tx_queue(dev, txq);
> >>> +       qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >>> +
> >>> +       spin_lock(&tfile->tx_ring.producer_lock);
> >>> +       ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> >>> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present=
) {
> >>
> >> So, it's possible that the administrator is switching between noqueue
> >> and another qdisc. So ptr_ring_produce() can fail here, do we need to
> >> check that or not?
> >>
> >
> > Do you mean that? My thoughts:
> >
> > Switching from noqueue to some qdisc can cause a
> >
> > net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
> >                                            dev->name);
> >
> > followed by a return of -ENETDOWN in __dev_queue_xmit().
> > This is because tun_net_xmit detects some qdisc with
> >
> > qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> >
> > and returns NETDEV_TX_BUSY even though __dev_queue_xmit() did still
> > detect noqueue.
> >
> > I am not sure how to solve this/if this has to be solved.
> > I do not see a proper way to avoid parallel execution of ndo_start_xmit
> > and a qdisc change (dev_graft_qdisc only takes qdisc_skb_head lock).
> >
> > And from my understanding the veth implementation faces the same issue.
>
> How about rechecking if a qdisc is connected?
> This would avoid -ENETDOWN.
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f48dc299e4b2..2731a1a70732 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4845,10 +4845,17 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
>                                 if (is_list)
>                                         rc =3D NETDEV_TX_OK;
>                         }
> +                       bool qdisc_present =3D !qdisc_txq_has_no_queue(tx=
q);
>                         HARD_TX_UNLOCK(dev, txq);
>                         if (!skb) /* xmit completed */
>                                 goto out;
>
> +                       /* Maybe a qdisc was connected in the meantime */
> +                       if (qdisc_present) {
> +                               kfree_skb(skb);
> +                               goto out;
> +                       }
> +
>                         net_crit_ratelimited("Virtual device %s asks to q=
ueue packet!\n",
>                                              dev->name);
>                         /* NETDEV_TX_BUSY or queue was stopped */
>

Probably not, and we likely won't hit this warning because qdisc could
not be changed during ndo_start_xmit().

I meant something like this:

1) set noqueue to tuntap
2) produce packets so tuntap is full
3) set e.g fq_codel to tuntap
4) then we can hit the failure of __ptr_ring_produce()

Rethink of the code, it looks just fine.

>
> >
> >
> > Switching from some qdisc to noqueue is no problem I think.
> >
> >>> +               netif_tx_stop_queue(queue);
> >>> +               /* Avoid races with queue wake-ups in __tun_wake_queu=
e by
> >>> +                * waking if space is available in a re-check.
> >>> +                * The barrier makes sure that the stop is visible be=
fore
> >>> +                * we re-check.
> >>> +                */
> >>> +               smp_mb__after_atomic();
> >>
> >> Let's document which barrier is paired with this.
> >>
> >
> > I am basically copying the (old) logic of veth [1] proposed by
> > Jakub Kicinski. I must admit I am not 100% sure what it pairs with.
> >
> > [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.or=
g/

So it looks like it implicitly tries to pair with tun_ring_consume():

1) spinlock(consumer_lock)
2) store NULL to ptr_ring // STORE
3) spinunlock(consumer_lock) // RELEASE
4) spinlock(consumer_lock) // ACQURE
5) check empty
6) spinunlock(consumer_lock)
7) netif_wakeup_queue() // test_and_set() which is an RMW

RELEASE + ACQUIRE implies a full barrier

I see several problems

1) Due to batch consumption, we may get spurious wakeups under heavy
load (we can try disabling batch consuming to see if it helps).
2) So the barriers don't help but would slow down the consuming
3) Two spinlocks were used instead of one, this is another reason we
will see a performance regression
4) Tricky code that needs to be understood or at least requires a comment t=
weak.

Note that due to ~IFF_TX_SKB_SHARING, pktgen can't clone skbs, so we
may not notice the real degradation.

> >
> >>> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >>> +                       netif_tx_wake_queue(queue);
> >>> +       }
> >>> +       spin_unlock(&tfile->tx_ring.producer_lock);
> >>> +
> >>> +       if (ret) {
> >>> +               /* If a qdisc is attached to our virtual device,
> >>> +                * returning NETDEV_TX_BUSY is allowed.
> >>> +                */
> >>> +               if (qdisc_present) {
> >>> +                       rcu_read_unlock();
> >>> +                       return NETDEV_TX_BUSY;
> >>> +               }
> >>>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >>>                 goto drop;
> >>>         }
> >>>
> >>>         /* dev->lltx requires to do our own update of trans_start */
> >>> -       queue =3D netdev_get_tx_queue(dev, txq);
> >>>         txq_trans_cond_update(queue);
> >>>
> >>>         /* Notify and wake up reader process */
> >>> --
> >>> 2.43.0
> >>>
> >>
> >> Thanks
> >>
>

Thanks


