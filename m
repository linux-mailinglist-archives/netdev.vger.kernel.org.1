Return-Path: <netdev+bounces-176230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64258A696BD
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DBB160C47
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93421EF372;
	Wed, 19 Mar 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qUImfatA"
X-Original-To: netdev@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AF1DE4FF;
	Wed, 19 Mar 2025 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406198; cv=pass; b=BpFJaonx+NNXmbWHDfSmYjG5r5x2kQxIGs/PZJ3YvPuki5iqwVRU+i4G4a3wTkQyHvrgvxW617CJCg3KQI0I3N1wbTKNW0srfK38lBh9ayl1e8zbFbc+vPB7EJrb5364MjkleANYdmfCKQbgw6OMIN5fVs9VoTfc/p5f+LWrZkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406198; c=relaxed/simple;
	bh=kWNysvDQIFaLfEcCp/sdOFHihRCT2zNonr/JO6RZPrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omdVxwyOolg24CMpzXiKggljpEuXS8qkjAL/9E9xKj1RDUOyljMsF3tRiKpVz7vkw/SFV4NtoN/eQMDeR9VJh9FJVlV9lEof25JERBjeM/K1qnKM3BJtpkq04J51o201xlSa+7T1IgIQ8uNUTgdTclcMijD+CUK88CZRncUSFLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qUImfatA; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZHwzM30scz49Q8B;
	Wed, 19 Mar 2025 19:43:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1742406192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rx741S6iFIcmWZNPRQSbL0sZPYwq4I9jABlZnaPKjOc=;
	b=qUImfatAuqbcyZJjaL15IeEuafN37fvIcId0RmB3naayg+RBQE57j1SuKLv9OK1zaKrAYR
	sUzSYj6JnAooSCQvovBwzKl5R49U2jZF1K/5tGV4ELkjLcTqMqr4bQbmSECnJycopSiZwJ
	KLshovLO8blbZ7om2xvPFCg5nDpgXifHR07n07vvJWJTw4rLBxqkoTGUMlvl9KA5sinMt2
	Lg3noYR/2OkWAhmUDvGilAd2zuNMaLuxC5q6GYpWSbrellCoN1P/wada5tvMKBw06bcCuc
	oSeWGdf0ij+JMmwuDOAlOul7bEffXSZ+HoT3vCMwyquflTAwSji9XoF4gEoYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1742406192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rx741S6iFIcmWZNPRQSbL0sZPYwq4I9jABlZnaPKjOc=;
	b=wDgUVyHU4ZSrOcrpzQqn/f1jmGS3fttRXDUD0ufuse3EuzBHQaL6r98hLCnAeJ+BhAgPIg
	22vpBBt5p4FrDX/0dPVMhcqUSmVLvOXifTll97k9tEliroA0TbscHGe2Cn1if0tfCiwHMp
	PIMDHA3Zl8/iqPuukUTOIEZhlh7PcGOnLnwlXajwdW/WoiO2F3g7k4X/xVh5QuSB3zwAuX
	YFDt7xeKj8+I6Ck7Z6e8kLrl13NtXaDUPFfl6vXMN3sl9jkGuRKqKxDfaad13y7TWxaqLP
	FXsabSGz8eCyXTqN66Akfkjqgou9DenqZuwozqe/9WIKKs/4dWGLMqerU/AhFQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1742406192; a=rsa-sha256;
	cv=none;
	b=JklaRN9sz0OWZfUVmWQ2ltm/XAlq8wwtEzEQ7PQzbDfTcb6jD2QybS35ZWCuEodzeqVYIf
	Ac96W/uAiM7k/kI+rgN682AKwPCXjYeK2AEF+ZygeZ63r4JFOiC4IUmR3mELV1qr61P8TJ
	nFTQ8tuYxDWhUAoBYBEeI92CTjshmq4GgZNAVC66ntEpXTtEKjoN77gV8+Ve19EGHGA2Do
	W+1EoZnQXYH7MdNkXA6DtGCGptyOeBsRIRGszfxVRk23uWierGhNzPRoHqSOrrrSJcCWz3
	CiXUD2HB484chuK0m+cxfFUi9K67EnP2wFG13BtBDuUo+BRoKyXfygrxwkx/oQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <5882af942ef8cf5c9b4ce36a348f959807a387b0.camel@iki.fi>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION
 timestamping
From: Pauli Virtanen <pav@iki.fi>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Xing
	 <kerneljasonxing@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org
Date: Wed, 19 Mar 2025 19:43:08 +0200
In-Reply-To: <67dad8635c22c_5948294ac@willemb.c.googlers.com.notmuch>
References: <cover.1742324341.git.pav@iki.fi>
	 <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
	 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
	 <67dad8635c22c_5948294ac@willemb.c.googlers.com.notmuch>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
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

ke, 2025-03-19 kello 10:44 -0400, Willem de Bruijn kirjoitti:
> Jason Xing wrote:
> > On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >=20
> > > Support enabling TX timestamping for some skbs, and track them until
> > > packet completion. Generate software SCM_TSTAMP_COMPLETION when getti=
ng
> > > completion report from hardware.
> > >=20
> > > Generate software SCM_TSTAMP_SND before sending to driver. Sending fr=
om
> > > driver requires changes in the driver API, and drivers mostly are goi=
ng
> > > to send the skb immediately.
> > >=20
> > > Make the default situation with no COMPLETION TX timestamping more
> > > efficient by only counting packets in the queue when there is nothing=
 to
> > > track.  When there is something to track, we need to make clones, sin=
ce
> > > the driver may modify sent skbs.
>=20
> Why count packets at all? And if useful separate from completions,
> should that be a separate patch?

This paragraph was commenting on the implementation of struct tx_queue,
and maybe how it works should be explicitly explained somewhere (code
comment?). Here's some explanation of it:

1) We have to hang on (clones of) skbs until completion reports for
them arrive, in order to emit COMPLETION timestamps. There's no
existing queue that does this in net/bluetooth (drivers may just copy
data & discard skbs, and they don't know about completion reports), so
something new needs to be added.

2) It is only needed for emitting COMPLETION timestamps. So it's better
to not do any extra work (clones etc.) when there are no such
timestamps to be emitted.

3) The new queue should work correctly when timestamping is turned on
or off, or only some packets are timestamped. It should also eventually
return to a state where no extra work is done, when new skbs don't
request COMPLETION timestamps.


struct tx_queue implements such queue that only "tracks" some skbs.
Logical structure:

HEAD
<no stored skb>  }
<no stored skb>  }  tx_queue::extra is the number of non-tracked
...              }  logical items at queue head
<no stored skb>  }
<tracked skb>		} tx_queue::queue contains mixture of
<non-tracked skb>	} tracked items  (skb->sk !=3D NULL) and
<non-tracked skb>	} non-tracked items  (skb->sk =3D=3D NULL).
<tracked skb>		} These are ordered after the "extra" items.
TAIL

tx_queue::tracked is the number of tracked skbs in tx_queue::queue.

hci_conn_tx_queue() determines whether skb is tracked (=3D COMPLETION
timestamp shall be emitted for it) and pushes a logical item to TAIL.

hci_conn_tx_dequeue() pops a logical item from HEAD, and emits
timestamp if it corresponds to a tracked skb.

When tracked =3D=3D 0, queue() can just increment tx_queue::extra, and
dequeue() can remove any skb from tx_queue::queue, or if empty then
decrement tx_queue::extra. This allows it to return to a state with
empty tx_queue::queue when new skbs no longer request timestamps.

When tracked !=3D 0, the ordering of items in the queue needs to be
respected strictly, so queue() always pushes real skb (tracked or not)
to TAIL, and dequeue() has to decrement extra to zero, before it can
pop skb from queue head.


> > > +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
> > > +{
> > > +       struct tx_queue *comp =3D &conn->tx_q;
> > > +       bool track =3D false;
> > > +
> > > +       /* Emit SND now, ie. just before sending to driver */
> > > +       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > > +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAMP_=
SND);
> >=20
> > It's a bit strange that SCM_TSTAMP_SND is under the control of
> > SKBTX_SW_TSTAMP. Can we use the same flag for both lines here
> > directly? I suppose I would use SKBTX_SW_TSTAMP then.
>=20
> This is the established behavior.
> >=20
> > > +
> > > +       /* COMPLETION tstamp is emitted for tracked skb later in Numb=
er of
> > > +        * Completed Packets event. Available only for flow controlle=
d cases.
> > > +        *
> > > +        * TODO: SCO support without flowctl (needs to be done in dri=
vers)
> > > +        */
> > > +       switch (conn->type) {
> > > +       case ISO_LINK:
> > > +       case ACL_LINK:
> > > +       case LE_LINK:
> > > +               break;
> > > +       case SCO_LINK:
> > > +       case ESCO_LINK:
> > > +               if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL))
> > > +                       return;
> > > +               break;
> > > +       default:
> > > +               return;
> > > +       }
> > > +
> > > +       if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETION_=
TSTAMP))
> > > +               track =3D true;
> > > +
> > > +       /* If nothing is tracked, just count extra skbs at the queue =
head */
> > > +       if (!track && !comp->tracked) {
> > > +               comp->extra++;
> > > +               return;
> > > +       }
> > > +
> > > +       if (track) {
> > > +               skb =3D skb_clone_sk(skb);
> > > +               if (!skb)
> > > +                       goto count_only;
> > > +
> > > +               comp->tracked++;
> > > +       } else {
> > > +               skb =3D skb_clone(skb, GFP_KERNEL);
> > > +               if (!skb)
> > > +                       goto count_only;
> > > +       }
>=20
> What is the difference between track and comp->tracked

I hope the answer above is clear.

--=20
Pauli Virtanen

