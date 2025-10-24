Return-Path: <netdev+bounces-232347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387FC04648
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C171A07715
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 05:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7422259F;
	Fri, 24 Oct 2025 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyPRLprx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AAF1FC3
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283755; cv=none; b=NTjuDh5dIbEkpFnHM5LO+UE/XaysBFUXXfn5bAGQ/W/bXzZMw2l8V3cYAazIiA90C4c8poqDcxov+0hUqQuezasBexx1lhUZcdBO+NT27u1VxRDOoR1Abdo3nWLJzjiZJGTrZP0fXFw89vIG5eH0rH/A/szWJDGkb/UzVIhJYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283755; c=relaxed/simple;
	bh=EGW2YTt66cTLaTBmMO6v6OzfTWN87FdVhhJX9e3jrpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uD+HRZ9hY0MctXtEk0H0BM59h/OilofCLTT51m350+BODk926ttynZoEojMJaY6C0ggDDcCEw/xCIJh+8yvw7/CBqyxlIKpcrYsJ3YdFOLJJtMMm5NB5/e+iSeIFXiNExL4sAge7snkIe38dIgQSS8++/W9tgj6o7x1JOenM+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyPRLprx; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63d8788b18dso1881944d50.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761283752; x=1761888552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtU3Y24Ljw4UIWB6yN2r0XFxelbsz8H3TFrkQC4xpO4=;
        b=nyPRLprxnTIl86MAoKWGrCioJbdCM3qhG+ylKpUySZ38nlitN8JZwCW5ZH/L5db+RY
         bVeRaAtfPWBlOA1svVByurzavjP8BKSfU7EJLv7ROAtbpe6QzgtvVaJR8bTjubjUlBOe
         q3pB6yxxpIXNkV71dklHaCF0ess2gfowlA1hu0zBTYAR9u0J7xg+WXczIDO4XeqPB34w
         kF8+EPOIzHAtNbPnhLfp+7OS5skD+VX8TT92p9Yu0mj/YS7L8mY8ONnRZnvvUWAeJpE8
         DwKDTcqq9kyRjnI5ZVbo8EZ3QR34AkoHR793uFm91NQbZwXixvvgr3zmcIKXYA45YI6y
         icAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761283752; x=1761888552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtU3Y24Ljw4UIWB6yN2r0XFxelbsz8H3TFrkQC4xpO4=;
        b=fQ2PxjbRg0uNwoSGt6oY3BH4e0NMHemQ/jMmPn/oy5Ht8JVVM8uoJnmzIBjn8aaG/D
         Ut5HaSD32bcnjZbeyqmtpwchNDOsjhvQNiE5fSLb/Aa+BlhSQ5N1QYMx6Yn3Twv/YAbY
         4L8XMxlLXa9P6AgIlOf6t6pfAXyK+YbXq+7B2nRqBy9FMtkDYXxcCf2x9LeHwi3TljCO
         oPrY1BRqUgQGa1UVbns14PhrrVZDNd6k54djftA7gqf1HBt4Lh6lq8QVCYdoIYX92MaI
         BbEogBiw+jia+h0TP/QPF/ftWKhiuQK/VHoJwcauJObjCRw2cK5aLsr9marOCp/cQH/2
         2Kxg==
X-Forwarded-Encrypted: i=1; AJvYcCVmRLWQVxzgczCZsxIhErk5xlmNa9o1PRbjMAV4wNlz5Vvz0GXdmkmHZrJLe0++RuGSkx9bwm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYGytTTCIgSxS0tAQBslNuoJr9ENnhAvO6M79mvjYwT9cjaEx
	OFjT0Ve8TzdisgHndhls9kspJxqsR8d8hAP8AemWP82f0I/cSdlk1hpPu3JEJ09LY90kjbR/5c3
	E4FUe4/LbiKwiKpBbHBEiN1SRP2/njVJ8Wfbndvqq
X-Gm-Gg: ASbGncs890yrvv6rOz+EolY7AQ9iaufVW+uIyJxbG70mvrdL1dwwH5oDrsEs5LEINCt
	Z0Pugv8zafrtvIG4N8pETBoyYSxMwJQZ92GZxo0VRHbrE2FnKlIcROUcbUf+mp3iE8HdQB0DNxL
	0eEZBvCfJdjVzytZOU0zD7nmUI7xtOEUUsGU8Bsm/D5X0m0Vj6jQxgqkvRMiC9F4Ph9ErOWq/3v
	12Rtgmv+mNVNBytbbIInmLpYhPEcHLYvxvNpv9nAeToxGVIgqI0NbAfZuQyURXA4yutDgU=
X-Google-Smtp-Source: AGHT+IGEtUrnHJPNh804jqx8cdPFtGHdpuYk90QslCcAvUKwaCYlql8lwi2/KgzteDZ/Dr1mznYWsyOWdHPAiD6aOts=
X-Received: by 2002:a05:690e:11ce:b0:63e:2809:354c with SMTP id
 956f58d0204a3-63e2809357dmr17541566d50.61.1761283752275; Thu, 23 Oct 2025
 22:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
 <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com> <bcff860e-749b-4911-9eba-41b47c00c305@arista.com>
In-Reply-To: <bcff860e-749b-4911-9eba-41b47c00c305@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Oct 2025 22:29:01 -0700
X-Gm-Features: AWmQ_bmo0xU0IlinU9NmBUCchlhM_NBOi14wTFghmp4M_7C7ZIwYFVEJ4jPdfjg
Message-ID: <CANn89iKRXpKkCzRw_7+VyG6jD2Tm5VUPQ-0bhQKUwh2sgzJZuA@mail.gmail.com>
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
To: Christoph Schwarz <cschwarz@arista.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:52=E2=80=AFPM Christoph Schwarz <cschwarz@arista.=
com> wrote:
>
> On 10/3/25 18:24, Neal Cardwell wrote:
> [...]
> > Thanks for the report!
> >
> > A few thoughts:
> >
> [...]
> >
> > (2) After that, would it be possible to try this test with a newer
> > kernel? You mentioned this is with kernel version 5.10.165, but that's
> > more than 2.5 years old at this point, and it's possible the bug has
> > been fixed since then.  Could you please try this test with the newest
> > kernel that is available in your distribution? (If you are forced to
> > use 5.10.x on your distribution, note that even with 5.10.x there is
> > v5.10.245, which was released yesterday.)
> >
> > (3) If this bug is still reproducible with a recent kernel, would it
> > be possible to gather .pcap traces from both client and server,
> > including SYN and SYN/ACK? Sometimes it can be helpful to see the
> > perspective of both ends, especially if there are middleboxes
> > manipulating the packets in some way.
> >
> > Thanks!
> >
> > Best regards,
> > neal
>
> Hi,
>
> I want to give an update as we made some progress.
>
> We tried with the 6.12.40 kernel, but it was much harder to reproduce
> and we were not able to do a successful packet capture and reproduction
> at the same time. So we went back to 5.10.165, added more tracing and
> eventually figured out how the TCP connection got into the bad state.
>
> This is a backtrace from the TCP stack calling down to the device driver:
>   =3D> fdev_tx    // ndo_start_xmit hook of a proprietary device driver
>   =3D> dev_hard_start_xmit
>   =3D> sch_direct_xmit
>   =3D> __qdisc_run
>   =3D> __dev_queue_xmit
>   =3D> vlan_dev_hard_start_xmit
>   =3D> dev_hard_start_xmit
>   =3D> __dev_queue_xmit
>   =3D> ip_finish_output2
>   =3D> __ip_queue_xmit
>   =3D> __tcp_transmit_skb
>   =3D> tcp_write_xmit
>
> tcp_write_xmit sends segments of 65160 bytes. Due to an MSS of 1448,
> they get broken down into 45 packets of 1448 bytes each.

So the driver does not support TSO ? Quite odd in 2025...

One thing you want is to make sure your vlan device (the one without a
Qdisc on it)
advertizes tso support.

ethtool -k vlan0


> These 45
> packets eventually reach dev_hard_start_xmit, which is a simple loop
> forwarding packets one by one. When the problem occurs, we see that
> dev_hard_start_xmit transmits the initial N packets successfully, but
> the remaining 45-N ones fail with error code 1. The loop runs to
> completion and does not break.
>
> The error code 1 from dev_hard_start_xmit gets returned through the call
> stack up to tcp_write_xmit, which treats this as error and breaks its
> own loop without advancing snd_nxt:
>
>                 if (unlikely(tcp_transmit_skb(sk, skb, 1, gfp)))
>                         break; // <<< breaks here
>
> repair:
>                 /* Advance the send_head.  This one is sent out.
>                  * This call will increment packets_out.
>                  */
>                 tcp_event_new_data_sent(sk, skb);
>
>  From packet captures we can prove that the 45 packets show up on the
> kernel device on the sender. In addition, the first N of those 45
> packets show up on the kernel device on the peer. The connection is now
> in the problem state where the peer is N packets ahead of the sender and
> the sender thinks that it never those packets, leading to the problem as
> described in my initial mail.
>
> Furthermore, we noticed that the N-45 missing packets show up as drops
> on the sender's kernel device:
>
> vlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>          inet 127.2.0.1  netmask 255.255.255.0  broadcast 0.0.0.0
>          [...]
>          TX errors 0  dropped 36 overruns 0  carrier 0  collisions 0
>
> This device is a vlan device stacked on another device like this:
>
> 49: vlan0@parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> noqueue state UP mode DEFAULT group default qlen 1000
>      link/ether 02:1c:a7:00:00:01 brd ff:ff:ff:ff:ff:ff
> 3: parent: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 10000 qdisc prio state
> UNKNOWN mode DEFAULT group default qlen 1000
>      link/ether xx:xx:xx:xx:xx:xx brd ff:ff:ff:ff:ff:ff
>
> Eventually packets need to go through the device driver, which has only
> a limited number of TX buffers. The driver implements flow control: when
> it is about to exhaust its buffers, it stops TX by calling
> netif_stop_queue. Once more buffers become available again, it resumes
> TX by calling netif_wake_queue. From packet counters we can tell that
> this is happening frequently.
>
> At this point we suspected "qdisc noqueue" to be a factor, and indeed,
> after adding a queue to vlan0 the problem no longer happened, although
> there are still TX drops on the vlan0 device.
>
> Missing queue or not, we think there is a disconnect between the device
> driver API and the TCP stack. The device driver API only allows
> transmitting packets one by one (ndo_start_xmit). The TCP stack operates
> on larger segments that is breaks down into smaller pieces
> (tcp_write_xmit / __tcp_transmit_skb). This can lead to a classic "short
> write" condition which the network stack doesn't seem to handle well in
> all cases.
>
> Appreciate you comments,

Very nice analysis, very much appreciated.

I think the issue here is that __tcp_transmit_skb() trusts the return
of icsk->icsk_af_ops->queue_xmit()

An error means : the packet was _not_ sent at all.

Here, it seems that the GSO layer returns an error, even if some
segments were sent.
This needs to be confirmed and fixed, but in the meantime, make sure
vlan0 has TSO support.
It will also be more efficient to segment (if you ethernet device has
no TSO capability) at the last moment,
because all the segments will be sent in  the described scenario
thanks to qdisc requeues.

