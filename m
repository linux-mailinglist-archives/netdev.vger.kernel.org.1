Return-Path: <netdev+bounces-176283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B109A699E1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00ABB7A24FB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9B2135CB;
	Wed, 19 Mar 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k42dMeGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7D819;
	Wed, 19 Mar 2025 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742414414; cv=none; b=Ak5PwhKqig9/upoD+fhznR6gVA0IgRqKaZKNSrloLOzUXB/OB/tiPZSiSiULPCFK5xHke47D1zE8Fwn90XRUhDDrFePyKHkjNE4Wkg6UNsFLusahpPLTPOU/OVI7atcccLO4roa5IuC7KIDGYAh3Os7jl6r+jEPPsJWZbMWlQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742414414; c=relaxed/simple;
	bh=j8pL7y3wwffigqMXBjxSs3EJnAhEUx1wmdCuADu/rRw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fei2js7o4aQISLbyQnFpEVUvnSgJtCQaQumcZbTAlC//3bnG3klZBUH2xAUwR8KhIK6LyxUhcEDo9va19k8kcTkp7zahZ7sxiUMqQdAFq6xBMwYnVsR5VPZDC+aKzOZzCo8kmdcxthoCAS3kfBzWvBTPMJAhVgFyowEeRxwiuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k42dMeGJ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47664364628so459851cf.1;
        Wed, 19 Mar 2025 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742414411; x=1743019211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBQEFTU9ZJN1Vwj3CU8LBRafYCAjGC1h9OJZyo557s8=;
        b=k42dMeGJLn3OsNM27YxT+OwWxc5cMH7xuPENL6wHmpE6/27YTp7Q7FDMzvkFh7b9Bg
         F4rc3TXOlhzzv+EyZECUvs3dgtOJJYpgELYOjPa6jRYCyBo1b52MK3Ke8lqIeOP5r+WV
         99wqc12mmaIX+kYustpvi8w4AdetS5GmeZv0mdD5jVQN09w6qQ//XYd2fHkktMdjm+gf
         KxxBQadmB3OWHg73WgDcdt/Z3cHTZ3cWG8EkosE3Fpigq8hAVfWUPyvH/35koNJ3QI3s
         O51OaTrONRoeJhFG9DZs0cNJybxOKQLQFH+dl4IkXgStTeW1c4DS3QuRO/Rf7h2AcLUA
         nwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742414411; x=1743019211;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBQEFTU9ZJN1Vwj3CU8LBRafYCAjGC1h9OJZyo557s8=;
        b=eLKI0HGrTBIHW3ZbOXrz49oMFo/Oi1CT3wpCNTfePhImGg7VZyIvXVwe7H/VLDY0Gq
         KLjLklbeuayftTn9/vSendZaZ5Mw7VyMCA8umRuhvsKBnWUcSDmnQUQvGnjGaQi1O/D8
         8rvIYH6sIGhXiy41bsFYdViHV4NvruqfxAFkDTcjXLmDBCwWgjwWK7hp0UNgUUskKUo3
         u649Tr+6GlC7DXsNGXk3AdzyK1UktrJTASDM0OLt0sr7As+8UZLu+aFD1EsdI15R+Z54
         Q4hAhabSR51rwzUzrBWj2/cYwAWuCC9ZXwdgKBe1h9mefIcWCoOUq/kl7gi+IRYaeCmq
         CryA==
X-Forwarded-Encrypted: i=1; AJvYcCW0KCKlO7ZSSi+Rdo7pKggrq338xP8SekGdY5Ku6zbQOey9hQF11y1UeFmZDlewWnUnfgbNa9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD67I3gacYdrMDEV4YsOCLcWutBwzUpHX4Poli0wZ9DwQ5u3x6
	IAoCBhXi0kmWip4edxg3kl2KZxBIyA3/9wIm7btjkZTOWS8O1cY9
X-Gm-Gg: ASbGnctdjrhcGfhHB/v0yfM78f0ke0krlbOtwC1bipOmRsFQCx6Zh21b1w3Dtz7zZcD
	//7QpcgEjrLOzDlcszt901bHGEMQpkz/2WnkWgzggwmALf5qhIAYphoNuW5r3fiw1PnQlnzcf65
	ODo9olX2/BSHGNrx5EaevXrTcO43BFSa3tPsgODSMgwnIih1oeWbolqCq74srvoUQwjXgCPucK2
	QNFkNdGDsgAuz67I3sGh7vqsCPnt99ak2lLuNfOOm0iZch5g5HpXiBwC2H0UcU/Ej0HBcZN224W
	XmXc/H4kALcI9OVZK0GBBwHQXTLHhWgqqjd9SvkeAXLrlztDx0PoaLDwRvigaxvJwwMF20eHYuq
	+q4FanfwziLBKPvb+DgPCwhHCAnVlzKIi
X-Google-Smtp-Source: AGHT+IH9HOt8qW6aD9BlCzmT8TlKJ9XK5qbhvUKZot2KcsbPVa5vVlLDaaZrKI8EBHCt/kpZ+3sB/A==
X-Received: by 2002:ac8:5dc6:0:b0:471:b32e:c65d with SMTP id d75a77b69052e-47710caaff7mr11305471cf.19.1742414411104;
        Wed, 19 Mar 2025 13:00:11 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82e879sm83355201cf.71.2025.03.19.13.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 13:00:10 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:00:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org
Message-ID: <67db224a5412b_2a13f29418@willemb.c.googlers.com.notmuch>
In-Reply-To: <5882af942ef8cf5c9b4ce36a348f959807a387b0.camel@iki.fi>
References: <cover.1742324341.git.pav@iki.fi>
 <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
 <67dad8635c22c_5948294ac@willemb.c.googlers.com.notmuch>
 <5882af942ef8cf5c9b4ce36a348f959807a387b0.camel@iki.fi>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION
 timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pauli Virtanen wrote:
> Hi,
> =

> ke, 2025-03-19 kello 10:44 -0400, Willem de Bruijn kirjoitti:
> > Jason Xing wrote:
> > > On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > =

> > > > Support enabling TX timestamping for some skbs, and track them un=
til
> > > > packet completion. Generate software SCM_TSTAMP_COMPLETION when g=
etting
> > > > completion report from hardware.
> > > > =

> > > > Generate software SCM_TSTAMP_SND before sending to driver. Sendin=
g from
> > > > driver requires changes in the driver API, and drivers mostly are=
 going
> > > > to send the skb immediately.
> > > > =

> > > > Make the default situation with no COMPLETION TX timestamping mor=
e
> > > > efficient by only counting packets in the queue when there is not=
hing to
> > > > track.  When there is something to track, we need to make clones,=
 since
> > > > the driver may modify sent skbs.
> > =

> > Why count packets at all? And if useful separate from completions,
> > should that be a separate patch?
> =

> This paragraph was commenting on the implementation of struct tx_queue,=

> and maybe how it works should be explicitly explained somewhere (code
> comment?). Here's some explanation of it:
> =

> 1) We have to hang on (clones of) skbs until completion reports for
> them arrive, in order to emit COMPLETION timestamps. There's no
> existing queue that does this in net/bluetooth (drivers may just copy
> data & discard skbs, and they don't know about completion reports), so
> something new needs to be added.
> =

> 2) It is only needed for emitting COMPLETION timestamps. So it's better=

> to not do any extra work (clones etc.) when there are no such
> timestamps to be emitted.
> =

> 3) The new queue should work correctly when timestamping is turned on
> or off, or only some packets are timestamped. It should also eventually=

> return to a state where no extra work is done, when new skbs don't
> request COMPLETION timestamps.

So far, fully understood.

> struct tx_queue implements such queue that only "tracks" some skbs.
> Logical structure:
> =

> HEAD
> <no stored skb>  }
> <no stored skb>  }  tx_queue::extra is the number of non-tracked
> ...              }  logical items at queue head
> <no stored skb>  }
> <tracked skb>		} tx_queue::queue contains mixture of
> <non-tracked skb>	} tracked items  (skb->sk !=3D NULL) and
> <non-tracked skb>	} non-tracked items  (skb->sk =3D=3D NULL).
> <tracked skb>		} These are ordered after the "extra" items.
> TAIL
> =

> tx_queue::tracked is the number of tracked skbs in tx_queue::queue.
> =

> hci_conn_tx_queue() determines whether skb is tracked (=3D COMPLETION
> timestamp shall be emitted for it) and pushes a logical item to TAIL.
> =

> hci_conn_tx_dequeue() pops a logical item from HEAD, and emits
> timestamp if it corresponds to a tracked skb.
> =

> When tracked =3D=3D 0, queue() can just increment tx_queue::extra, and
> dequeue() can remove any skb from tx_queue::queue, or if empty then
> decrement tx_queue::extra. This allows it to return to a state with
> empty tx_queue::queue when new skbs no longer request timestamps.
> =

> When tracked !=3D 0, the ordering of items in the queue needs to be
> respected strictly, so queue() always pushes real skb (tracked or not)
> to TAIL, and dequeue() has to decrement extra to zero, before it can
> pop skb from queue head.

Thanks. I did not understand why you need to queue or track any
sbs aside from those that have SKBTX_COMPLETION_TSTAMP.

If I follow correctly this is to be able to associate the tx
completion with the right skb on the queue.

The usual model in Ethernet drivers is that every tx descriptor (and
completion descriptor) in the ring is associated with a pure software
ring of metadata structures, which can point to an skb (or NULL).

In a pinch, instead the skb on the queue itself could record the
descriptor id that it is associated with. But hci_conn_tx_queue is
too far removed from the HW, so has no direct access to that. And
similarly hci_conn_tx_dequeue has no such low level details.

So long story short you indeed have to track this out of band with
a separate counter. I also don't immediately see a simpler way.

Though you can perhaps replace the skb_clone (not the skb_clone_sk!)
with some sentinel value that just helps count?

