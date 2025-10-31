Return-Path: <netdev+bounces-234606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D74EDC24095
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 10:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9871F4F25D1
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349AC32E133;
	Fri, 31 Oct 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKrI854t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D74328B63
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901624; cv=none; b=fEaVpebhKSzaG/GKBUUeI/1R4T7nlnWNaq6TK3kDWNll8hqNzbTnk6FH6fWcN3rD9u9R79r6tfhZcokUDIFnPK5vHUMNNxKWEoUC68xKlcG2Jy273mIjn9BTnFmpZ3HLDQ+Hi9T6oQUkPNIyb/Hm/tjvprncKudNfx2z8IjIAcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901624; c=relaxed/simple;
	bh=ERdagPRv+LkoTFaZ/CxB3rjCG4W+T1Gro5Cjti5wFr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJv7H6/m+aTDrK8Ma4h4iOaAnzIIBZujVOtakjYC67SpuKIQbhE0/Fu0I0QOw60JbvCNyiG4r2wmEmJ+ifsxj7s0nCcMJea7WA/9M65bjF8cmC5ELRngn3kPmMn4CnU7g9abIf0qeTUBJmou/QnK8hoNTRHiulwYjsxKdxQQonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKrI854t; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-781421f5be6so25937917b3.0
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761901621; x=1762506421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGFvUKmSOc7AqtxYcVpBLrYaTkd6MsJZHg+kLfmRIe0=;
        b=oKrI854tMQgKyjVN2jFnMSihGPcR7K+Pm9yS5yYW6Sy3qy18Wi9Gb8I9VX2rq2XqxI
         KKHcQPvxaMcz3p+T9SLTy9cZNYpwpUxcLV9uMyMU2XzX5IKTGTnsCwj2VIlH/ssu2CEH
         +N7sbqYr4S2D0iwH8evlmtXDboAyKMS1DrSHhwJAIViYy+08fLMkPBEq/p99AmHb+p6m
         FVbOPic+bAF3yJbQ22jXCcVzF1jBbhznFOWH1jAbn8lcxuC3K3CVPENWpx14c1fZvJbH
         jiK/TAON1/GNp23kwNNK6ct28FPBbBwgKQzgx6QzfjUH9Cw/UGNYd1SHYYsgTHc48bCb
         V+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761901621; x=1762506421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGFvUKmSOc7AqtxYcVpBLrYaTkd6MsJZHg+kLfmRIe0=;
        b=X35GB82dNjN57X8xDRkTAUXJiJk9/B3yeLYTKF68OEHt4xtjU8afQB3AYteGrZZuMn
         DtxXp8eSfNrcE03ronBiuaq1o4eueCaqghlGYoZ4G7mW7T5CtRaU59gjcgtAKVh+a+vt
         6X22BrboJ2RtHU05histajzJMJi2WB52kmVLq5C/dPpM9KitLzQeWpoYtRrZw294H9d1
         qe8Qm+4SCHgRWERwQdu2E0NChPDRYFokt41AJx5X3rtj6p8iHBOWxIpHvoxlAa0Jhc1i
         svrc2qLUxzqkfVNzaU2dNxTcaqb8TedX8dvJi/7LlDQD7vzo2Uv/ozZFYPZ0zQrW41WU
         ropQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTxRQcUrxfD4Fe6uZutovylDwEOLMlTTTpej0AGI50Puzb+Y7b0Kv6fDoKoKkGIfzVkUlVMvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYVpqZiYdoEScTw3QciXfDV8EXFEE4wHGYJTpCNyX9I2YyX6N
	sshLctsn5uH7hUYe8qFsCYxuQ7JzqNa2VDcAlxC/XU51GGME7IxhNi5KEWZvORxu6dj9K6CTWXd
	8XWiBXIm27eCbEwL/ylT/jG+31uSucYKf7ZM2WKCR
X-Gm-Gg: ASbGncvrVvt8QUq3Pq1w4Iu+CCqE30QH8i9/G033EP9w1pts0wAj7LslJzrsPn63HLg
	JLM/M9dJPFxAOhuto04I8O4ZhKxOOPv/kksR8tSQua43vgbsR+sbn3lhFbWKYuUqeEwfFRRTaHm
	T3Huij1k0aXjXvzRadhSGzR/xRHRFYBUbF/QBAS3qG5BI0EZ+mM4fxhz7YfPYGthAb/K/JtVImI
	JPoH5t4fhadp9Ztbyf12X8U+NIasm9qRJEG5eo2Xbt0BL4lc3FUz/dZBd8Z
X-Google-Smtp-Source: AGHT+IGU+At/dii3lBVaDEQ8S16pmFOvcW3o/I1qx3K/pRblEErpndji4CVmGwAVKmt68acqpFsxXKiHXDQi5j+x0UE=
X-Received: by 2002:a05:690c:9981:b0:76c:1926:8029 with SMTP id
 00721157ae682-786485164efmr23156737b3.54.1761901620752; Fri, 31 Oct 2025
 02:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
 <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
 <bcff860e-749b-4911-9eba-41b47c00c305@arista.com> <CANn89iKRXpKkCzRw_7+VyG6jD2Tm5VUPQ-0bhQKUwh2sgzJZuA@mail.gmail.com>
 <CANn89iJcLepEin7EtBETrZ36bjoD9LrR=k4cfwWh046GB+4f9A@mail.gmail.com>
In-Reply-To: <CANn89iJcLepEin7EtBETrZ36bjoD9LrR=k4cfwWh046GB+4f9A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Oct 2025 02:06:49 -0700
X-Gm-Features: AWmQ_bnmjlKbFen4Y4ar7lxaOkieyHDVaRnW0iQSRIEu43gF-ZCOZjtOb18wFe0
Message-ID: <CANn89i+=rqOAi3SJ0yj47x9X=ScDX5-dD2GmAVRsVGNP9XDBEw@mail.gmail.com>
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
To: Christoph Schwarz <cschwarz@arista.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:57=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Oct 23, 2025 at 10:29=E2=80=AFPM Eric Dumazet <edumazet@google.co=
m> wrote:
> >
> > On Thu, Oct 23, 2025 at 3:52=E2=80=AFPM Christoph Schwarz <cschwarz@ari=
sta.com> wrote:
> > >
> > > On 10/3/25 18:24, Neal Cardwell wrote:
> > > [...]
> > > > Thanks for the report!
> > > >
> > > > A few thoughts:
> > > >
> > > [...]
> > > >
> > > > (2) After that, would it be possible to try this test with a newer
> > > > kernel? You mentioned this is with kernel version 5.10.165, but tha=
t's
> > > > more than 2.5 years old at this point, and it's possible the bug ha=
s
> > > > been fixed since then.  Could you please try this test with the new=
est
> > > > kernel that is available in your distribution? (If you are forced t=
o
> > > > use 5.10.x on your distribution, note that even with 5.10.x there i=
s
> > > > v5.10.245, which was released yesterday.)
> > > >
> > > > (3) If this bug is still reproducible with a recent kernel, would i=
t
> > > > be possible to gather .pcap traces from both client and server,
> > > > including SYN and SYN/ACK? Sometimes it can be helpful to see the
> > > > perspective of both ends, especially if there are middleboxes
> > > > manipulating the packets in some way.
> > > >
> > > > Thanks!
> > > >
> > > > Best regards,
> > > > neal
> > >
> > > Hi,
> > >
> > > I want to give an update as we made some progress.
> > >
> > > We tried with the 6.12.40 kernel, but it was much harder to reproduce
> > > and we were not able to do a successful packet capture and reproducti=
on
> > > at the same time. So we went back to 5.10.165, added more tracing and
> > > eventually figured out how the TCP connection got into the bad state.
> > >
> > > This is a backtrace from the TCP stack calling down to the device dri=
ver:
> > >   =3D> fdev_tx    // ndo_start_xmit hook of a proprietary device driv=
er
> > >   =3D> dev_hard_start_xmit
> > >   =3D> sch_direct_xmit
> > >   =3D> __qdisc_run
> > >   =3D> __dev_queue_xmit
> > >   =3D> vlan_dev_hard_start_xmit
> > >   =3D> dev_hard_start_xmit
> > >   =3D> __dev_queue_xmit
> > >   =3D> ip_finish_output2
> > >   =3D> __ip_queue_xmit
> > >   =3D> __tcp_transmit_skb
> > >   =3D> tcp_write_xmit
> > >
> > > tcp_write_xmit sends segments of 65160 bytes. Due to an MSS of 1448,
> > > they get broken down into 45 packets of 1448 bytes each.
> >
> > So the driver does not support TSO ? Quite odd in 2025...
> >
> > One thing you want is to make sure your vlan device (the one without a
> > Qdisc on it)
> > advertizes tso support.
> >
> > ethtool -k vlan0
> >
> >
> > > These 45
> > > packets eventually reach dev_hard_start_xmit, which is a simple loop
> > > forwarding packets one by one. When the problem occurs, we see that
> > > dev_hard_start_xmit transmits the initial N packets successfully, but
> > > the remaining 45-N ones fail with error code 1. The loop runs to
> > > completion and does not break.
> > >
> > > The error code 1 from dev_hard_start_xmit gets returned through the c=
all
> > > stack up to tcp_write_xmit, which treats this as error and breaks its
> > > own loop without advancing snd_nxt:
> > >
> > >                 if (unlikely(tcp_transmit_skb(sk, skb, 1, gfp)))
> > >                         break; // <<< breaks here
> > >
> > > repair:
> > >                 /* Advance the send_head.  This one is sent out.
> > >                  * This call will increment packets_out.
> > >                  */
> > >                 tcp_event_new_data_sent(sk, skb);
> > >
> > >  From packet captures we can prove that the 45 packets show up on the
> > > kernel device on the sender. In addition, the first N of those 45
> > > packets show up on the kernel device on the peer. The connection is n=
ow
> > > in the problem state where the peer is N packets ahead of the sender =
and
> > > the sender thinks that it never those packets, leading to the problem=
 as
> > > described in my initial mail.
> > >
> > > Furthermore, we noticed that the N-45 missing packets show up as drop=
s
> > > on the sender's kernel device:
> > >
> > > vlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> > >          inet 127.2.0.1  netmask 255.255.255.0  broadcast 0.0.0.0
> > >          [...]
> > >          TX errors 0  dropped 36 overruns 0  carrier 0  collisions 0
> > >
> > > This device is a vlan device stacked on another device like this:
> > >
> > > 49: vlan0@parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> > > noqueue state UP mode DEFAULT group default qlen 1000
> > >      link/ether 02:1c:a7:00:00:01 brd ff:ff:ff:ff:ff:ff
> > > 3: parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 10000 qdisc prio sta=
te
> > > UNKNOWN mode DEFAULT group default qlen 1000
> > >      link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
> > >
> > > Eventually packets need to go through the device driver, which has on=
ly
> > > a limited number of TX buffers. The driver implements flow control: w=
hen
> > > it is about to exhaust its buffers, it stops TX by calling
> > > netif_stop_queue. Once more buffers become available again, it resume=
s
> > > TX by calling netif_wake_queue. From packet counters we can tell that
> > > this is happening frequently.
> > >
> > > At this point we suspected "qdisc noqueue" to be a factor, and indeed=
,
> > > after adding a queue to vlan0 the problem no longer happened, althoug=
h
> > > there are still TX drops on the vlan0 device.
> > >
> > > Missing queue or not, we think there is a disconnect between the devi=
ce
> > > driver API and the TCP stack. The device driver API only allows
> > > transmitting packets one by one (ndo_start_xmit). The TCP stack opera=
tes
> > > on larger segments that is breaks down into smaller pieces
> > > (tcp_write_xmit / __tcp_transmit_skb). This can lead to a classic "sh=
ort
> > > write" condition which the network stack doesn't seem to handle well =
in
> > > all cases.
> > >
> > > Appreciate you comments,
> >
> > Very nice analysis, very much appreciated.
> >
> > I think the issue here is that __tcp_transmit_skb() trusts the return
> > of icsk->icsk_af_ops->queue_xmit()
> >
> > An error means : the packet was _not_ sent at all.
> >
> > Here, it seems that the GSO layer returns an error, even if some
> > segments were sent.
> > This needs to be confirmed and fixed, but in the meantime, make sure
> > vlan0 has TSO support.
> > It will also be more efficient to segment (if you ethernet device has
> > no TSO capability) at the last moment,
> > because all the segments will be sent in  the described scenario
> > thanks to qdisc requeues.
>
> Could you try the following patch ?
>
> Thanks again !
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 378c2d010faf251ffd874ebf0cc3dd6968eee447..8efda845611129920a9ae21d5=
e9dd05ffab36103
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4796,6 +4796,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> net_device *sb_dev)
>                  * to -1 or to their cpu id, but not to our id.
>                  */
>                 if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
> +                       struct sk_buff *orig;
> +
>                         if (dev_xmit_recursion())
>                                 goto recursion_alert;
>
> @@ -4805,6 +4807,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> net_device *sb_dev)
>
>                         HARD_TX_LOCK(dev, txq, cpu);
>
> +                       orig =3D skb;
>                         if (!netif_xmit_stopped(txq)) {
>                                 dev_xmit_recursion_inc();
>                                 skb =3D dev_hard_start_xmit(skb, dev, txq=
, &rc);
> @@ -4817,6 +4820,11 @@ int __dev_queue_xmit(struct sk_buff *skb,
> struct net_device *sb_dev)
>                         HARD_TX_UNLOCK(dev, txq);
>                         net_crit_ratelimited("Virtual device %s asks
> to queue packet!\n",
>                                              dev->name);
> +                       if (skb !=3D orig) {
> +                               /* If at least one packet was sent, we
> must return NETDEV_TX_OK */
> +                               rc =3D NETDEV_TX_OK;
> +                               goto unlock;
> +                       }
>                 } else {
>                         /* Recursion is detected! It is possible,
>                          * unfortunately
> @@ -4828,6 +4836,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct
> net_device *sb_dev)
>         }
>
>         rc =3D -ENETDOWN;
> +unlock:
>         rcu_read_unlock_bh();
>
>         dev_core_stats_tx_dropped_inc(dev);

Hi Christoph

Any progress on your side ?

Thanks.

