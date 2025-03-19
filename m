Return-Path: <netdev+bounces-176306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC2A69AFD
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3527B20D5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446C214A92;
	Wed, 19 Mar 2025 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFGOF/e1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6C20CCDB;
	Wed, 19 Mar 2025 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420161; cv=none; b=awRGZi9MZC4Yk0vj4Se8gABMCGvVN1G34lo0upUxJkX2y0NOX9KmoHkkkoU9CrFqGYmrvpHN3HhMt2OixbfLpglICgBvSu58BOA1ScqG5LOpaEXR24V2zAjpLosP8Oy4KYtpFxqWabegS21RNnIzkgJssyjmzOBIQOWANPeQooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420161; c=relaxed/simple;
	bh=7bGYc57GEzZuisEL2JDhNw+Qr3E4pyQxa5hVpalJuCw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YtElliDD2rS5L7CO/sIJVhTcefsMLEL2/17ql4sHMpKMpDhb+y4VuY0r2Waw/goHD1/MQBU6CC7V9RBE9SAbKSr4fpuACpCFeRO4IruBTFTCkwhlMBynyaH96D87wlLIDCBE02WYp7/IkYbb/ZQFTTCcXnOtZpjPLullBF/z6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFGOF/e1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47663aeff1bso1785131cf.0;
        Wed, 19 Mar 2025 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742420158; x=1743024958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqRmhdrZMBqRj5pKWcdYVhUXAfKNmYPuGgU4Iy10MO8=;
        b=kFGOF/e1Hux5RjfzFNI+5y2FZYrdS1LwnGUGbxSlf7RcHv2/ki/FCxiXWQdRAAc9tL
         JAYmw1HTrvHoFF6+peb7PDlgkbvi/ct2xz2WTSU0AHdTRm8645KfS8uEXXwNbfNkj3hR
         uraMzQqZloNp62dkPbRvchmBWHoPWJtyEulERujfiR1wqCXk+wTi52L8OHtEsL9aHU4u
         E8pJ/Rhy9Ov0HpBUrBLndB4NILDxIU87dY09QjA1odUulSPEfeQgsrvZLEDscokXYHO0
         kUqJqV1YEp2KaEzFWiP5qRz7Pci3+lWBFM/nLmd7q63iTHmsVYQOB2ssI+GlSbNy8z+M
         SyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742420158; x=1743024958;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqRmhdrZMBqRj5pKWcdYVhUXAfKNmYPuGgU4Iy10MO8=;
        b=oLYvkDIb2OEZiuH+IPzd79praUoMxwdbyGOCCE5p7pxnKHAZCe6kkfYZavenedENli
         rdiaBbgdEOcCErPmhMnUvwMidUuhQ/u/+aVWaWmn5Md8hnKGw7bUSDd7BieaPlVRF426
         ThEQOgR3fYKzQplxVFw2PA2xfshabCUMOZAl38XBf1O4HWGnIqCin8jo8Aka3n7neRzV
         O5VLoFP1f0oyBufSNCn/+fi71QX9R2dXWVP3EZjcWUBUhtwwoRmuBL9xbPKQJbdeJh+J
         MwGuISOipYyY2Sc7cwkkare5bpyKxQFwn1JrMIM7i6CWUJDsPaWzv0fStJ+zJRB9SwJp
         Iwzw==
X-Forwarded-Encrypted: i=1; AJvYcCV1r+9T2HtIqA9lwlwqQfKuyK8nvCgplZI87uTObEM/SyR6Q9YMqb6459Rll8SRZPmvGB48TOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/GsVJLIBf7mKerwa2a3NId7rNTWGlJWfWlLQGRcnpjzvmr/k
	nsaIXWAffypjw4jbaZSCDtjf3eb+YxwGssJkfEdVNrgIIalACRDe
X-Gm-Gg: ASbGncss2i4Q/okC9I1Nobt0mQ0/H8Smari6FUahlPaDMX5eD0PV2tNZurhQfLJDwlN
	rav06t6EIomzhvQ3CbmJhKbiwVEJsR+PeZR0i3EP9PCfKBsPnaG9gOJZ6kN1t31NFIRDmkzPCdA
	WqMwM+B3npaJYDqaHGyY8obVq/SzdFAJ1iJE4CBrh+rwDJn0ZyOX3A+3QGu4yNSOmUNZUNmXjcG
	xIO2e5evd1SE4zCWpYIx7QkMF8UUqK53fMEltFG7JfYQWUiNJuw9nqW/lk5b6+iP3BLIUzfVdfb
	yAeE6cdN6cxHPtET/yuW5ySdPNqAGRDTt4uNECWFIpZvWCuFp6KLUhhxQg8cpazctWWDA0VGIHQ
	cw2dLMS8C1bk/t21LCP92pcu+luDCXoZa
X-Google-Smtp-Source: AGHT+IHg4+ltsJocMH30bqK9fm3JPGL39cUSEjbekwHRM6g1z8OmtfXuQ7kU+eMAIvpkkg1euy42Fw==
X-Received: by 2002:a05:622a:907:b0:476:7112:4add with SMTP id d75a77b69052e-4770830d865mr81255721cf.18.1742420158001;
        Wed, 19 Mar 2025 14:35:58 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb7f3d6asm84333151cf.55.2025.03.19.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:35:57 -0700 (PDT)
Date: Wed, 19 Mar 2025 17:35:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Xing <kerneljasonxing@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org
Message-ID: <67db38bcbfc23_369fe2947@willemb.c.googlers.com.notmuch>
In-Reply-To: <c49167b08b7af73bc633e1b195a30e0dd23735d7.camel@iki.fi>
References: <cover.1742324341.git.pav@iki.fi>
 <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
 <67dad8635c22c_5948294ac@willemb.c.googlers.com.notmuch>
 <5882af942ef8cf5c9b4ce36a348f959807a387b0.camel@iki.fi>
 <67db224a5412b_2a13f29418@willemb.c.googlers.com.notmuch>
 <c49167b08b7af73bc633e1b195a30e0dd23735d7.camel@iki.fi>
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

> ke, 2025-03-19 kello 16:00 -0400, Willem de Bruijn kirjoitti:
> > Pauli Virtanen wrote:
> > > ke, 2025-03-19 kello 10:44 -0400, Willem de Bruijn kirjoitti:
> > > > Jason Xing wrote:
> > > > > On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki=
.fi> wrote:
> > > > > > =

> > > > > > Support enabling TX timestamping for some skbs, and track the=
m until
> > > > > > packet completion. Generate software SCM_TSTAMP_COMPLETION wh=
en getting
> > > > > > completion report from hardware.
> > > > > > =

> > > > > > Generate software SCM_TSTAMP_SND before sending to driver. Se=
nding from
> > > > > > driver requires changes in the driver API, and drivers mostly=
 are going
> > > > > > to send the skb immediately.
> > > > > > =

> > > > > > Make the default situation with no COMPLETION TX timestamping=
 more
> > > > > > efficient by only counting packets in the queue when there is=
 nothing to
> > > > > > track.  When there is something to track, we need to make clo=
nes, since
> > > > > > the driver may modify sent skbs.
> > > > =

> > > > Why count packets at all? And if useful separate from completions=
,
> > > > should that be a separate patch?
> > > =

> > > This paragraph was commenting on the implementation of struct tx_qu=
eue,
> > > and maybe how it works should be explicitly explained somewhere (co=
de
> > > comment?). Here's some explanation of it:
> > > =

> > > 1) We have to hang on (clones of) skbs until completion reports for=

> > > them arrive, in order to emit COMPLETION timestamps. There's no
> > > existing queue that does this in net/bluetooth (drivers may just co=
py
> > > data & discard skbs, and they don't know about completion reports),=
 so
> > > something new needs to be added.
> > > =

> > > 2) It is only needed for emitting COMPLETION timestamps. So it's be=
tter
> > > to not do any extra work (clones etc.) when there are no such
> > > timestamps to be emitted.
> > > =

> > > 3) The new queue should work correctly when timestamping is turned =
on
> > > or off, or only some packets are timestamped. It should also eventu=
ally
> > > return to a state where no extra work is done, when new skbs don't
> > > request COMPLETION timestamps.
> > =

> > So far, fully understood.
> > =

> > > struct tx_queue implements such queue that only "tracks" some skbs.=

> > > Logical structure:
> > > =

> > > HEAD
> > > <no stored skb>  }
> > > <no stored skb>  }  tx_queue::extra is the number of non-tracked
> > > ...              }  logical items at queue head
> > > <no stored skb>  }
> > > <tracked skb>		} tx_queue::queue contains mixture of
> > > <non-tracked skb>	} tracked items  (skb->sk !=3D NULL) and
> > > <non-tracked skb>	} non-tracked items  (skb->sk =3D=3D NULL).
> > > <tracked skb>		} These are ordered after the "extra" items.
> > > TAIL
> > > =

> > > tx_queue::tracked is the number of tracked skbs in tx_queue::queue.=

> > > =

> > > hci_conn_tx_queue() determines whether skb is tracked (=3D COMPLETI=
ON
> > > timestamp shall be emitted for it) and pushes a logical item to TAI=
L.
> > > =

> > > hci_conn_tx_dequeue() pops a logical item from HEAD, and emits
> > > timestamp if it corresponds to a tracked skb.
> > > =

> > > When tracked =3D=3D 0, queue() can just increment tx_queue::extra, =
and
> > > dequeue() can remove any skb from tx_queue::queue, or if empty then=

> > > decrement tx_queue::extra. This allows it to return to a state with=

> > > empty tx_queue::queue when new skbs no longer request timestamps.
> > > =

> > > When tracked !=3D 0, the ordering of items in the queue needs to be=

> > > respected strictly, so queue() always pushes real skb (tracked or n=
ot)
> > > to TAIL, and dequeue() has to decrement extra to zero, before it ca=
n
> > > pop skb from queue head.
> > =

> > Thanks. I did not understand why you need to queue or track any
> > sbs aside from those that have SKBTX_COMPLETION_TSTAMP.
> > =

> > If I follow correctly this is to be able to associate the tx
> > completion with the right skb on the queue.
> =

> Yes, it was done to maintain the queue/dequeue ordering.
> =

> > The usual model in Ethernet drivers is that every tx descriptor (and
> > completion descriptor) in the ring is associated with a pure software=

> > ring of metadata structures, which can point to an skb (or NULL).
> > =

> > In a pinch, instead the skb on the queue itself could record the
> > descriptor id that it is associated with. But hci_conn_tx_queue is
> > too far removed from the HW, so has no direct access to that. And
> > similarly hci_conn_tx_dequeue has no such low level details.
> > =

> > So long story short you indeed have to track this out of band with
> > a separate counter. I also don't immediately see a simpler way.
> > =

> > Though you can perhaps replace the skb_clone (not the skb_clone_sk!)
> > with some sentinel value that just helps count?
> =

> It probably could be done a bit smarter, it could eg. use something
> else than skb_queue. Or, I think we can clobber cb here as the clones
> are only used for timestamping, so:
> =

> =

> struct tx_queue {
> 	unsigned int pre_items;
> 	struct sk_buff_head queue;
> };
> =

> struct tx_queue_cb {
> 	unsigned int post_items;
> };
> =

> static void hci_tx_queue_push(struct tx_queue *q, struct sk_buff *skb)
> {
> 	struct tx_queue_cb *cb;
> =

> 	/* HEAD
> 	 * <non-tracked item>  }
> 	 * ...                 } tx_queue::pre_items of these
> 	 * <non-tracked item>  }
> 	 * <tracked skb1>     <- tx_queue::queue first item
> 	 * <non-tracked item>  }
> 	 * ...                 } ((struct tx_queue_cb *)skb1->cb)->post_items
> 	 * <non-tracked item>  }
> 	 * ...
> 	 * <tracked skbn>     <- tx_queue::queue n-th item
> 	 * <non-tracked item>  }
> 	 * ...                 } ((struct tx_queue_cb *)skbn->cb)->post_items
> 	 * <non-tracked item>  }
> 	 * TAIL
> 	 */
> 	if (skb) {
> 		cb =3D (struct tx_queue_cb *)skb->cb;
> 		cb->post_items =3D 0;
> 		skb_queue_tail(&q->queue, skb);
> 	} else {
> 		skb =3D skb_peek_tail(&q->queue);
> 		if (skb) {
> 			cb =3D (struct tx_queue_cb *)skb->cb;
> 			cb->post_items++;
> 		} else {
> 			q->pre_items++;
> 		}
> 	}
> }
> =

> static struct sk_buff *hci_tx_queue_pop(struct tx_queue *q)
> {
> 	struct sk_buff *skb;
> 	struct tx_queue_cb *cb;
> =

> 	if (q->pre_items) {
> 		q->pre_items--;
> 		return NULL;
> 	}
> =

> 	skb =3D skb_dequeue(&q->queue);
> 	if (skb) {
> 		cb =3D (struct tx_queue_cb *)skb->cb;
> 		q->pre_items +=3D cb->post_items;
> 	}
> =

> 	return skb;
> }
> =

> void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
> {
> 	/* Emit SND now, ie. just before sending to driver */
> 	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);
> =

> 	/* COMPLETION tstamp is emitted for tracked skb later in Number of
> 	 * Completed Packets event. Available only for flow controlled cases.
> 	 *
> 	 * TODO: SCO support without flowctl (needs to be done in drivers)
> 	 */
> 	switch (conn->type) {
> 	case ISO_LINK:
> 	case ACL_LINK:
> 	case LE_LINK:
> 		break;
> 	case SCO_LINK:
> 	case ESCO_LINK:
> 		if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
> 			return;
> 		break;
> 	default:
> 		return;
> 	}
> =

> 	if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP))
> 		skb =3D skb_clone_sk(skb);
> 	else
> 		skb =3D NULL;
> =

> 	hci_tx_queue_push(&conn->tx_q, skb);
> 	return;
> }
> =

> void hci_conn_tx_dequeue(struct hci_conn *conn)
> {
> 	struct sk_buff *skb =3D hci_tx_queue_pop(&conn->tx_q);
> =

> 	if (skb) {
> 		__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> 				SCM_TSTAMP_COMPLETION);
> 		kfree_skb(skb);
> 	}
> }

Neat. To be clear, your call. Just if the expectation is that
timestamped packets are rare even when enabled (e.g., due to
sampling, or enabling only for one of many sockets), then avoiding
the skb_clone in the common case may be worthwhile.


