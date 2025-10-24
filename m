Return-Path: <netdev+bounces-232349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0695DC046E5
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E1819A71F8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4023A9AE;
	Fri, 24 Oct 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBvRzHTx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796474C14
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285471; cv=none; b=cGJEWYNHAveyFiCkflTYqIgiK414wT91Tg8S8iTMGfhC1V5zX9oAEK4AKI7QUqTpgFILRkBmTT1cnXkYgEZwMOmxCDlvI0inTpEWrXO0ufi1mQ5HRS5egHhSo+vHM7AHhX/d3ds7Xyn6otQqtLsueR58pKgeCHR8tFjxzW2ThSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285471; c=relaxed/simple;
	bh=XVIl18ZAD5yGfNPxi0zhRb8ycf1HDVb0KIdZ35l5s2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxHDo5f0HA4hwkgekElal/E0XJcrnmBdR6EQ2Iv9Z7JSzUnwQOK/ESwJUPZG7ZPNzj/Slya2Xytkes9+d9/mvFG/4eoEWbxRuQMWgA8ghY07x3/iTAy0X1c0q0Sv+yB5q3CmO0n5zD6T2JcpIdaDJVc7eK11mIjhCbj6+Jha9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBvRzHTx; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e891a8980bso22018361cf.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 22:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761285469; x=1761890269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnRYuE3M7E/CSmvUjhWaWfoUWP5EmR5Iz7GoXrsB+UU=;
        b=nBvRzHTx7MMsjZvCOLQTrt9tXpN9hftk/jWMqEIZ02BpIWwhgh3isUuhHfRqmpHU0F
         Hj/fRVEcfrp2lQnJ0n2rcxT6B4axrCWcOnRl6xyazRYhuBprzG/mFUHz1g3kKQmviTPg
         LY4mfb/0kz1RfMCZvIBRfRPAtBgpA3f9KIGW/erwwbBB1HjtC4OmGXZPMSpC0K+/oSfR
         wbSYlWjfUkv1mk5Zw5LBKiIL6U/u/wqNrsCYLNO4mBNOpHrc63vw7DjIPlmDTz5EnQr5
         LqIVkbReO+E8+osypnkPXe4KNX7aQlZYcL7y8QZwZU3sbSe+oLDJF8tMtTZlj8/xlJiW
         k/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761285469; x=1761890269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnRYuE3M7E/CSmvUjhWaWfoUWP5EmR5Iz7GoXrsB+UU=;
        b=pYmPDv5wRdUdDFqtoy1nRw+RW7bLFDEsLt4qKVqzcPzccKNZn/gIROEfbDdizy7wjR
         +xGAxA5ZswOX2S8OjGPwaRYVaJp4ZHFEO6yUkPKj4VXJe7YTz5Gzv2NEboRXi/l8eANU
         D2y/6aSDBGvBM/ckWEgJgquke1jnH0RWrg8cuQm17BhPp0AcNctEMUDWm3zWwKY6uyhu
         zPvyBFYatzBkamw/9UPNYEYkqXT3mDPsVRumX79sBSWUbnXMAobs2jX/PbZHGnVEMcPr
         x+fWSwjFTqCPA1aJKmZ4T6KHVtbxvE3x+zC85Lu3j2Oelz9vgmqPqHYP04ltefGh18j9
         0PZg==
X-Forwarded-Encrypted: i=1; AJvYcCVkNwzBv3iv30W6PnpEIIVi5CtHpGnFaZoq40iy/A28KHKVNAvX4ESBUqAUlZhgqsvyTioL8lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgoWDPXHvuBFjrhkyTfVMicqf0UBkp91WzwMINrMPX0+WQ442
	BjuhQ3V4Xh+mYivh3/71bEiVN8dj9O48a/Kv6NqXmmnubWIt5YJ3GttVFB/yEB1CVH0TwrFXEXK
	0whXzoOSAV+XuoxDCgeeYyeUnKfZJYdr49n32YPBG
X-Gm-Gg: ASbGncsLwrNMrfqdlM0jW77TLnUykCbMcQ2xG5UpnYCj39qm5WsoGS7I38VcbhHAMDl
	4ZxF3JHMo2whsObH3yZrweaOhcN1+LAq+3ATISE+umY8JHb4Nsc99zQBIkWRTc7ZIGRDJKLEEYc
	9Ds2OWiHTR9WI8XE/rq3li8S2KjX9fb7A1m5Y+hzuq/6H2caHCOcv+19UmVbnK1t4npkBKsVI/e
	tlExakkq4+j0vFakNKAdWudl5GwxkrXh0vj4CZWWQQFu50VYAqVR5/p7GXdtkp88ol5mzk=
X-Google-Smtp-Source: AGHT+IHzKF36Cv/i7Cbwy3Xndrumq0LuNLdY2IqD6c5NFmzLti4Pd4Qp4Evlh1Kfax5MiDnzD4FItEwU93GfeJJFZT0=
X-Received: by 2002:a05:622a:4d:b0:4e8:91fd:979a with SMTP id
 d75a77b69052e-4eb92cad0a4mr21459041cf.35.1761285468548; Thu, 23 Oct 2025
 22:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
 <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
 <bcff860e-749b-4911-9eba-41b47c00c305@arista.com> <CANn89iKRXpKkCzRw_7+VyG6jD2Tm5VUPQ-0bhQKUwh2sgzJZuA@mail.gmail.com>
In-Reply-To: <CANn89iKRXpKkCzRw_7+VyG6jD2Tm5VUPQ-0bhQKUwh2sgzJZuA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Oct 2025 22:57:36 -0700
X-Gm-Features: AS18NWCvpaux_n01lEqLB1EdT_EdpiML30lXvFSEqKoIWtZh6l8ewWtWoT7xhfU
Message-ID: <CANn89iJcLepEin7EtBETrZ36bjoD9LrR=k4cfwWh046GB+4f9A@mail.gmail.com>
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
To: Christoph Schwarz <cschwarz@arista.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:29=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Oct 23, 2025 at 3:52=E2=80=AFPM Christoph Schwarz <cschwarz@arist=
a.com> wrote:
> >
> > On 10/3/25 18:24, Neal Cardwell wrote:
> > [...]
> > > Thanks for the report!
> > >
> > > A few thoughts:
> > >
> > [...]
> > >
> > > (2) After that, would it be possible to try this test with a newer
> > > kernel? You mentioned this is with kernel version 5.10.165, but that'=
s
> > > more than 2.5 years old at this point, and it's possible the bug has
> > > been fixed since then.  Could you please try this test with the newes=
t
> > > kernel that is available in your distribution? (If you are forced to
> > > use 5.10.x on your distribution, note that even with 5.10.x there is
> > > v5.10.245, which was released yesterday.)
> > >
> > > (3) If this bug is still reproducible with a recent kernel, would it
> > > be possible to gather .pcap traces from both client and server,
> > > including SYN and SYN/ACK? Sometimes it can be helpful to see the
> > > perspective of both ends, especially if there are middleboxes
> > > manipulating the packets in some way.
> > >
> > > Thanks!
> > >
> > > Best regards,
> > > neal
> >
> > Hi,
> >
> > I want to give an update as we made some progress.
> >
> > We tried with the 6.12.40 kernel, but it was much harder to reproduce
> > and we were not able to do a successful packet capture and reproduction
> > at the same time. So we went back to 5.10.165, added more tracing and
> > eventually figured out how the TCP connection got into the bad state.
> >
> > This is a backtrace from the TCP stack calling down to the device drive=
r:
> >   =3D> fdev_tx    // ndo_start_xmit hook of a proprietary device driver
> >   =3D> dev_hard_start_xmit
> >   =3D> sch_direct_xmit
> >   =3D> __qdisc_run
> >   =3D> __dev_queue_xmit
> >   =3D> vlan_dev_hard_start_xmit
> >   =3D> dev_hard_start_xmit
> >   =3D> __dev_queue_xmit
> >   =3D> ip_finish_output2
> >   =3D> __ip_queue_xmit
> >   =3D> __tcp_transmit_skb
> >   =3D> tcp_write_xmit
> >
> > tcp_write_xmit sends segments of 65160 bytes. Due to an MSS of 1448,
> > they get broken down into 45 packets of 1448 bytes each.
>
> So the driver does not support TSO ? Quite odd in 2025...
>
> One thing you want is to make sure your vlan device (the one without a
> Qdisc on it)
> advertizes tso support.
>
> ethtool -k vlan0
>
>
> > These 45
> > packets eventually reach dev_hard_start_xmit, which is a simple loop
> > forwarding packets one by one. When the problem occurs, we see that
> > dev_hard_start_xmit transmits the initial N packets successfully, but
> > the remaining 45-N ones fail with error code 1. The loop runs to
> > completion and does not break.
> >
> > The error code 1 from dev_hard_start_xmit gets returned through the cal=
l
> > stack up to tcp_write_xmit, which treats this as error and breaks its
> > own loop without advancing snd_nxt:
> >
> >                 if (unlikely(tcp_transmit_skb(sk, skb, 1, gfp)))
> >                         break; // <<< breaks here
> >
> > repair:
> >                 /* Advance the send_head.  This one is sent out.
> >                  * This call will increment packets_out.
> >                  */
> >                 tcp_event_new_data_sent(sk, skb);
> >
> >  From packet captures we can prove that the 45 packets show up on the
> > kernel device on the sender. In addition, the first N of those 45
> > packets show up on the kernel device on the peer. The connection is now
> > in the problem state where the peer is N packets ahead of the sender an=
d
> > the sender thinks that it never those packets, leading to the problem a=
s
> > described in my initial mail.
> >
> > Furthermore, we noticed that the N-45 missing packets show up as drops
> > on the sender's kernel device:
> >
> > vlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> >          inet 127.2.0.1  netmask 255.255.255.0  broadcast 0.0.0.0
> >          [...]
> >          TX errors 0  dropped 36 overruns 0  carrier 0  collisions 0
> >
> > This device is a vlan device stacked on another device like this:
> >
> > 49: vlan0@parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> > noqueue state UP mode DEFAULT group default qlen 1000
> >      link/ether 02:1c:a7:00:00:01 brd ff:ff:ff:ff:ff:ff
> > 3: parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 10000 qdisc prio state
> > UNKNOWN mode DEFAULT group default qlen 1000
> >      link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
> >
> > Eventually packets need to go through the device driver, which has only
> > a limited number of TX buffers. The driver implements flow control: whe=
n
> > it is about to exhaust its buffers, it stops TX by calling
> > netif_stop_queue. Once more buffers become available again, it resumes
> > TX by calling netif_wake_queue. From packet counters we can tell that
> > this is happening frequently.
> >
> > At this point we suspected "qdisc noqueue" to be a factor, and indeed,
> > after adding a queue to vlan0 the problem no longer happened, although
> > there are still TX drops on the vlan0 device.
> >
> > Missing queue or not, we think there is a disconnect between the device
> > driver API and the TCP stack. The device driver API only allows
> > transmitting packets one by one (ndo_start_xmit). The TCP stack operate=
s
> > on larger segments that is breaks down into smaller pieces
> > (tcp_write_xmit / __tcp_transmit_skb). This can lead to a classic "shor=
t
> > write" condition which the network stack doesn't seem to handle well in
> > all cases.
> >
> > Appreciate you comments,
>
> Very nice analysis, very much appreciated.
>
> I think the issue here is that __tcp_transmit_skb() trusts the return
> of icsk->icsk_af_ops->queue_xmit()
>
> An error means : the packet was _not_ sent at all.
>
> Here, it seems that the GSO layer returns an error, even if some
> segments were sent.
> This needs to be confirmed and fixed, but in the meantime, make sure
> vlan0 has TSO support.
> It will also be more efficient to segment (if you ethernet device has
> no TSO capability) at the last moment,
> because all the segments will be sent in  the described scenario
> thanks to qdisc requeues.

Could you try the following patch ?

Thanks again !

diff --git a/net/core/dev.c b/net/core/dev.c
index 378c2d010faf251ffd874ebf0cc3dd6968eee447..8efda845611129920a9ae21d5e9=
dd05ffab36103
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4796,6 +4796,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
net_device *sb_dev)
                 * to -1 or to their cpu id, but not to our id.
                 */
                if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
+                       struct sk_buff *orig;
+
                        if (dev_xmit_recursion())
                                goto recursion_alert;

@@ -4805,6 +4807,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
net_device *sb_dev)

                        HARD_TX_LOCK(dev, txq, cpu);

+                       orig =3D skb;
                        if (!netif_xmit_stopped(txq)) {
                                dev_xmit_recursion_inc();
                                skb =3D dev_hard_start_xmit(skb, dev, txq, =
&rc);
@@ -4817,6 +4820,11 @@ int __dev_queue_xmit(struct sk_buff *skb,
struct net_device *sb_dev)
                        HARD_TX_UNLOCK(dev, txq);
                        net_crit_ratelimited("Virtual device %s asks
to queue packet!\n",
                                             dev->name);
+                       if (skb !=3D orig) {
+                               /* If at least one packet was sent, we
must return NETDEV_TX_OK */
+                               rc =3D NETDEV_TX_OK;
+                               goto unlock;
+                       }
                } else {
                        /* Recursion is detected! It is possible,
                         * unfortunately
@@ -4828,6 +4836,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
net_device *sb_dev)
        }

        rc =3D -ENETDOWN;
+unlock:
        rcu_read_unlock_bh();

        dev_core_stats_tx_dropped_inc(dev);

