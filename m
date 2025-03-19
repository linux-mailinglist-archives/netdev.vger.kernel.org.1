Return-Path: <netdev+bounces-176297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A588DA69ADC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE333AB469
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0A71EDA2F;
	Wed, 19 Mar 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="aLBTGpob"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8671E5207;
	Wed, 19 Mar 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419853; cv=pass; b=RGHtBde6yaWbgBfD40PFl7ajzAuEFPfkw2OzQF/TjSSG8j5yY0SGK4vyMO7w3ibq51wLB1mGeYVtAiu0Ub0WW4m6l0T3Qrm91V8GUNPUjl/S53P2Sjsog50PzOkEzfB2on0kZuWYnVklZVzQm7vlX4PGk/x8jthwCzm5WK1YR+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419853; c=relaxed/simple;
	bh=6Up16T60ksc4r61EGTl8KhHqMrNLP8w8iKeOqRKvaS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SaZv4wltU0tPdFFgbMcb7E+GdGl9Nt4MyQTmzUdrBVS1ACXu4wHnXlmfNTKsFSGU7lwBmaqnqCsWNAR6PQRmGUeO7lVtCe1jxtCU6VrEnT1ZR1hcUSXYQOXNRYIRa0Da93NH3Ch3Fo2gZe28t5zFkATw206vxN8tofrX8GuMDlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=aLBTGpob; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZJ21s1632z49Q8B;
	Wed, 19 Mar 2025 23:30:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742419842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4bOguK0wpS9xDJgwVPC3+Y93JtKP0+CbFkaIzJuIOc=;
	b=aLBTGpobGxy+tat1akSluwj64RBHNvtqC8xB2GS05fJ57ALnrcGdHvgR+jswpxwrw4VguY
	qnefcL2dcJZsa/YtzPhK1aBBBoKLNyULl4g3mMo6iI6g3eWuIg/nZSYyWWv++SOT5UP0Id
	tiOnQxLg2D8Z3/GkYOxhvuvWHtlDxDjSGsCdzXK+N2ZpC7RSUrUfgvAs/C1iHl6pTdErkG
	HFMSMO1/JlmqTHz+whK2orol9qyQIqGekA1qPK8MxWmRg/fBjnSqdUxfYRTd2E82O86S0L
	A2xfl76Q0OyyOTOrLs8P7AR9acPWZyw6rX/fCu3csjnmr2uu0JxkILshFqBc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742419842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o4bOguK0wpS9xDJgwVPC3+Y93JtKP0+CbFkaIzJuIOc=;
	b=JKvHvJU1kZCcjq45aC6r0j/v8rCDEz9hd5CHi4U9qImNMf8fx+CMF6rFTD+lBLVVEEdqHm
	r4FEtevhdK+24mIMBhw1WLD17nzSudvNGD65XVZCPlULi3r5FaipJ4s9mLI1MsIwG6dN4D
	tjBybvvo0jDd+0VQTdiyiOWpWYdi2A2OXH1z7hVeQawZaeafpoKiaD3+g2rvk01xLVmLi4
	tqujH7wJ+xnX2OeIsIMzKolbQCvR4vvhrocmtBF0Hwn0gyVQS/I+W71vzNL64weDZjjgap
	99t1QxqFYZ7NxqvquoRmsxlk99U4yWLW0vJvn04nDo8Klzn+5tGBsR/xIfSexw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742419842; a=rsa-sha256;
	cv=none;
	b=i5EZBnsNfpgreKxbgI1jnF6fiLkqqubEiEe/aAIVImP7metv75MkKc6yAoI1JnLTPpXbXt
	n510sKByzJOzLxRn0jIhFX8ldw8Hu5N3iAQAFLKd9ZjukqgEUk8YTBPPoAdk/Svz6Bea9R
	oS9+EUVxQHw1YO/duHgrgCuXga9VWLO0HaJUOGEJ9B5ma1226ev5bt3Q3TLlhULz1E+g1v
	+kor52BKj63DLUy3VpgfYWi4fBGTdZdgyL05u4Y+WtHhEQYR1GX/Z/4TtFXG9Cjzxp8C4j
	Y5e0GHQXYlzP0VxZadF01X1U4Y1I1I75LU+ENS45wsHRfySDkCYzEsVUb1oVYQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <c49167b08b7af73bc633e1b195a30e0dd23735d7.camel@iki.fi>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION
 timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Xing
	 <kerneljasonxing@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org
Date: Wed, 19 Mar 2025 23:30:38 +0200
In-Reply-To: <67db224a5412b_2a13f29418@willemb.c.googlers.com.notmuch>
References: <cover.1742324341.git.pav@iki.fi>
	 <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
	 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
	 <67dad8635c22c_5948294ac@willemb.c.googlers.com.notmuch>
	 <5882af942ef8cf5c9b4ce36a348f959807a387b0.camel@iki.fi>
	 <67db224a5412b_2a13f29418@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2025-03-19 kello 16:00 -0400, Willem de Bruijn kirjoitti:
> Pauli Virtanen wrote:
> > ke, 2025-03-19 kello 10:44 -0400, Willem de Bruijn kirjoitti:
> > > Jason Xing wrote:
> > > > On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > >=20
> > > > > Support enabling TX timestamping for some skbs, and track them un=
til
> > > > > packet completion. Generate software SCM_TSTAMP_COMPLETION when g=
etting
> > > > > completion report from hardware.
> > > > >=20
> > > > > Generate software SCM_TSTAMP_SND before sending to driver. Sendin=
g from
> > > > > driver requires changes in the driver API, and drivers mostly are=
 going
> > > > > to send the skb immediately.
> > > > >=20
> > > > > Make the default situation with no COMPLETION TX timestamping mor=
e
> > > > > efficient by only counting packets in the queue when there is not=
hing to
> > > > > track.  When there is something to track, we need to make clones,=
 since
> > > > > the driver may modify sent skbs.
> > >=20
> > > Why count packets at all? And if useful separate from completions,
> > > should that be a separate patch?
> >=20
> > This paragraph was commenting on the implementation of struct tx_queue,
> > and maybe how it works should be explicitly explained somewhere (code
> > comment?). Here's some explanation of it:
> >=20
> > 1) We have to hang on (clones of) skbs until completion reports for
> > them arrive, in order to emit COMPLETION timestamps. There's no
> > existing queue that does this in net/bluetooth (drivers may just copy
> > data & discard skbs, and they don't know about completion reports), so
> > something new needs to be added.
> >=20
> > 2) It is only needed for emitting COMPLETION timestamps. So it's better
> > to not do any extra work (clones etc.) when there are no such
> > timestamps to be emitted.
> >=20
> > 3) The new queue should work correctly when timestamping is turned on
> > or off, or only some packets are timestamped. It should also eventually
> > return to a state where no extra work is done, when new skbs don't
> > request COMPLETION timestamps.
>=20
> So far, fully understood.
>=20
> > struct tx_queue implements such queue that only "tracks" some skbs.
> > Logical structure:
> >=20
> > HEAD
> > <no stored skb>  }
> > <no stored skb>  }  tx_queue::extra is the number of non-tracked
> > ...              }  logical items at queue head
> > <no stored skb>  }
> > <tracked skb>		} tx_queue::queue contains mixture of
> > <non-tracked skb>	} tracked items  (skb->sk !=3D NULL) and
> > <non-tracked skb>	} non-tracked items  (skb->sk =3D=3D NULL).
> > <tracked skb>		} These are ordered after the "extra" items.
> > TAIL
> >=20
> > tx_queue::tracked is the number of tracked skbs in tx_queue::queue.
> >=20
> > hci_conn_tx_queue() determines whether skb is tracked (=3D COMPLETION
> > timestamp shall be emitted for it) and pushes a logical item to TAIL.
> >=20
> > hci_conn_tx_dequeue() pops a logical item from HEAD, and emits
> > timestamp if it corresponds to a tracked skb.
> >=20
> > When tracked =3D=3D 0, queue() can just increment tx_queue::extra, and
> > dequeue() can remove any skb from tx_queue::queue, or if empty then
> > decrement tx_queue::extra. This allows it to return to a state with
> > empty tx_queue::queue when new skbs no longer request timestamps.
> >=20
> > When tracked !=3D 0, the ordering of items in the queue needs to be
> > respected strictly, so queue() always pushes real skb (tracked or not)
> > to TAIL, and dequeue() has to decrement extra to zero, before it can
> > pop skb from queue head.
>=20
> Thanks. I did not understand why you need to queue or track any
> sbs aside from those that have SKBTX_COMPLETION_TSTAMP.
>=20
> If I follow correctly this is to be able to associate the tx
> completion with the right skb on the queue.

Yes, it was done to maintain the queue/dequeue ordering.

> The usual model in Ethernet drivers is that every tx descriptor (and
> completion descriptor) in the ring is associated with a pure software
> ring of metadata structures, which can point to an skb (or NULL).
>=20
> In a pinch, instead the skb on the queue itself could record the
> descriptor id that it is associated with. But hci_conn_tx_queue is
> too far removed from the HW, so has no direct access to that. And
> similarly hci_conn_tx_dequeue has no such low level details.
>=20
> So long story short you indeed have to track this out of band with
> a separate counter. I also don't immediately see a simpler way.
>=20
> Though you can perhaps replace the skb_clone (not the skb_clone_sk!)
> with some sentinel value that just helps count?

It probably could be done a bit smarter, it could eg. use something
else than skb_queue. Or, I think we can clobber cb here as the clones
are only used for timestamping, so:


struct tx_queue {
	unsigned int pre_items;
	struct sk_buff_head queue;
};

struct tx_queue_cb {
	unsigned int post_items;
};

static void hci_tx_queue_push(struct tx_queue *q, struct sk_buff *skb)
{
	struct tx_queue_cb *cb;

	/* HEAD
	 * <non-tracked item>  }
	 * ...                 } tx_queue::pre_items of these
	 * <non-tracked item>  }
	 * <tracked skb1>     <- tx_queue::queue first item
	 * <non-tracked item>  }
	 * ...                 } ((struct tx_queue_cb *)skb1->cb)->post_items
	 * <non-tracked item>  }
	 * ...
	 * <tracked skbn>     <- tx_queue::queue n-th item
	 * <non-tracked item>  }
	 * ...                 } ((struct tx_queue_cb *)skbn->cb)->post_items
	 * <non-tracked item>  }
	 * TAIL
	 */
	if (skb) {
		cb =3D (struct tx_queue_cb *)skb->cb;
		cb->post_items =3D 0;
		skb_queue_tail(&q->queue, skb);
	} else {
		skb =3D skb_peek_tail(&q->queue);
		if (skb) {
			cb =3D (struct tx_queue_cb *)skb->cb;
			cb->post_items++;
		} else {
			q->pre_items++;
		}
	}
}

static struct sk_buff *hci_tx_queue_pop(struct tx_queue *q)
{
	struct sk_buff *skb;
	struct tx_queue_cb *cb;

	if (q->pre_items) {
		q->pre_items--;
		return NULL;
	}

	skb =3D skb_dequeue(&q->queue);
	if (skb) {
		cb =3D (struct tx_queue_cb *)skb->cb;
		q->pre_items +=3D cb->post_items;
	}

	return skb;
}

void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
{
	/* Emit SND now, ie. just before sending to driver */
	if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
		__skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_SND);

	/* COMPLETION tstamp is emitted for tracked skb later in Number of
	 * Completed Packets event. Available only for flow controlled cases.
	 *
	 * TODO: SCO support without flowctl (needs to be done in drivers)
	 */
	switch (conn->type) {
	case ISO_LINK:
	case ACL_LINK:
	case LE_LINK:
		break;
	case SCO_LINK:
	case ESCO_LINK:
		if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
			return;
		break;
	default:
		return;
	}

	if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_TSTAMP))
		skb =3D skb_clone_sk(skb);
	else
		skb =3D NULL;

	hci_tx_queue_push(&conn->tx_q, skb);
	return;
}

void hci_conn_tx_dequeue(struct hci_conn *conn)
{
	struct sk_buff *skb =3D hci_tx_queue_pop(&conn->tx_q);

	if (skb) {
		__skb_tstamp_tx(skb, NULL, NULL, skb->sk,
				SCM_TSTAMP_COMPLETION);
		kfree_skb(skb);
	}
}


--=20
Pauli Virtanen

