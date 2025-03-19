Return-Path: <netdev+bounces-176289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EDCA69AB3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3D7189C51E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE99214A98;
	Wed, 19 Mar 2025 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwrgY1MC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377151EF36B;
	Wed, 19 Mar 2025 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742419002; cv=none; b=IIEKWVnHDntQjer1xTzNX7aYZL3iLCXZMkVWrWbu7c3w1YeKOTYoB5+NJYExcV7i/BwBaaj+/9n4TJyieE0V1p3tuRbrxsOr4odrCzF5vbgdiQ0evR2tqI01/duHUS3QzLa9n167U3iasRn5i8/45cWoKcEGneKVTOpCBnGJTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742419002; c=relaxed/simple;
	bh=IPx2IenD+3MIUguW7cdHm/VGQ17hO9ylU51t4/LSYFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oyxp225dXE/SlwHPDV5HpmxmCra6EBqBy6k2pUadhECItQXGy+IyJfHtA+OvRcZPKLarOdvJEeuadqsee9RZd2nl3cPbZSfe29CurmBvpZIG73hE/tfihymFU+2eaAGBmDw+NX3YpgummctXoPRJ2bw4nibuPLUC7YDduUMOMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwrgY1MC; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bd11bfec6so1568541fa.0;
        Wed, 19 Mar 2025 14:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742418998; x=1743023798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SolXlEkI4SJqnfdn26rKrFNgCCrMN0Bee2HmMlU2CY4=;
        b=fwrgY1MC6VZEkZaBp7HIn1ep7gmUd9Z+xB6fx7FXHjRMSMRVeVh38uxEsyo4uebb+a
         1EmzbTYrH4xUiQ1T+4xQtBeQ+jwyUbSvbg3Xl1KnolKOn9sqQsTtTdqQULuI8vHDOJWr
         QjTsi/6vmjGMqjTfnqS+fDGisltkFizSiB0lVDeFdvUQ70MeUi1Nmm7/3Aexl1ntB21u
         njwu1yyTfsaU8EgkGPvdXlsfSsZLDfz9Jw1hsYoJ965u2sgU3x1jCzPh+suHr4uj4KWH
         /iMQruBCjxRXr81ccojlbkfGEa0nNhwViuDHY9xhTr1lZHfV1AL5YCVc4KUF8xKJpmM1
         Bt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418998; x=1743023798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SolXlEkI4SJqnfdn26rKrFNgCCrMN0Bee2HmMlU2CY4=;
        b=nQVKnbUfKnqeP8Hbujpv2ZSMCs4cmttm6sHpWbCkCajEeik9wvUA/6ZbNTPTCceZPw
         UIiKyJQWvS31xgcbseg0Qg9Xb3uOALG+X9NHgRMlweEHA9hCs37ipw1nk1imFQg3zcfJ
         I4gU6iwUirN9lfOC4HuZe2EQjorl+Gna2zNjcqyV+u+CNAu919kYgYaIRNmJsmZHoOgK
         wjzBYBQLtsuHoMm06RXwWCFaZwYpY+jLBjm1sgdHp4BPlzR/21MW++wuQwlByspyPh6P
         r3MibCObotTJOTqG39+Uxtoln8XORPL2iTbK4zjVmvmzuHsvgRG4jlLtcMrpaq8CrwZX
         WSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU03Xy4YHDZ2NfTmwFeDSOaPCxm1kw+qGsOWWYhEsh4x0ZknCaLsHH3zSlg8MgOfNg31pkTtJJE@vger.kernel.org, AJvYcCWAz84fqRkObOpgh5x8u5IcmXQyk/9BbQ5yP8PN2qO2YdnsC5Y3u5NfB9YJjICjSd/50d9J3pm8H0WsX2WNDrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJO56qOekO44uRhrOxPM8Owos+U74GlwIKtfjgDowgJzUf1e3
	Vm3EksHiRkobveglpzI2/vNS2qboXyCk+x6BvHGcO6N/cdGKc52yqYGp5qfcifQG4NpNIQKlTUh
	eY7bqzN++xHBgXc0ATe+KQj8Ov5g=
X-Gm-Gg: ASbGncvqkavpCteUgQHlS1myoLPL0lsi1zfTyuLu8Pj3odQWukjf7c6mrg238dssL3t
	yPLM8SIaLjxcWV8Ze6AzXtqDqQRMT23aihcqB3TedP+mjMQbwgi3Xx0EJDSL6uQQLd0CZDN+IdJ
	WPL25lBecnVL4AvvwmMmAyq94c
X-Google-Smtp-Source: AGHT+IEPqjuvSbV9RhA9B1zZs3VypXZHF4RorDZtUq8npi2M18B7ncDrQeY+yyeR1sj9VZoOBrGFYtxHqhf7n9+2A3I=
X-Received: by 2002:a05:651c:a0b:b0:30b:c3ce:ea1f with SMTP id
 38308e7fff4ca-30d6a3e5ad7mr19134251fa.15.1742418997882; Wed, 19 Mar 2025
 14:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742324341.git.pav@iki.fi> <a5c1b2110e567f499e17a4a67f1cc7c2036566c4.1742324341.git.pav@iki.fi>
 <CAL+tcoCr-Z_PrWMsERtsm98Q4f-RXkMVzTW3S1gnNY6cFQM0Sg@mail.gmail.com>
 <67dad8635c22c_5948294ac@willemb.c.googlers.com.notmuch> <5882af942ef8cf5c9b4ce36a348f959807a387b0.camel@iki.fi>
In-Reply-To: <5882af942ef8cf5c9b4ce36a348f959807a387b0.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Mar 2025 17:16:25 -0400
X-Gm-Features: AQ5f1JqBnZSB32f3tqh6z_pr_3n2ygdXzib3nXoudW-CcDW0F7lsb33eHKtseIM
Message-ID: <CABBYNZJs+ZVeqsN6ozRbHYUKy2YnzU8yDVACmndn-1NPoTSchw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: add support for skb TX SND/COMPLETION timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 19, 2025 at 1:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2025-03-19 kello 10:44 -0400, Willem de Bruijn kirjoitti:
> > Jason Xing wrote:
> > > On Wed, Mar 19, 2025 at 3:10=E2=80=AFAM Pauli Virtanen <pav@iki.fi> w=
rote:
> > > >
> > > > Support enabling TX timestamping for some skbs, and track them unti=
l
> > > > packet completion. Generate software SCM_TSTAMP_COMPLETION when get=
ting
> > > > completion report from hardware.
> > > >
> > > > Generate software SCM_TSTAMP_SND before sending to driver. Sending =
from
> > > > driver requires changes in the driver API, and drivers mostly are g=
oing
> > > > to send the skb immediately.
> > > >
> > > > Make the default situation with no COMPLETION TX timestamping more
> > > > efficient by only counting packets in the queue when there is nothi=
ng to
> > > > track.  When there is something to track, we need to make clones, s=
ince
> > > > the driver may modify sent skbs.
> >
> > Why count packets at all? And if useful separate from completions,
> > should that be a separate patch?
>
> This paragraph was commenting on the implementation of struct tx_queue,
> and maybe how it works should be explicitly explained somewhere (code
> comment?). Here's some explanation of it:
>
> 1) We have to hang on (clones of) skbs until completion reports for
> them arrive, in order to emit COMPLETION timestamps. There's no
> existing queue that does this in net/bluetooth (drivers may just copy
> data & discard skbs, and they don't know about completion reports), so
> something new needs to be added.
>
> 2) It is only needed for emitting COMPLETION timestamps. So it's better
> to not do any extra work (clones etc.) when there are no such
> timestamps to be emitted.
>
> 3) The new queue should work correctly when timestamping is turned on
> or off, or only some packets are timestamped. It should also eventually
> return to a state where no extra work is done, when new skbs don't
> request COMPLETION timestamps.

I don't think it would hurt to put some of the above text as code
comments, but I think it would actually be better if we start doing
some documentation for Bluetooth in general, or we can put as part of
the manpages in userspace though that normally cover only the
interface not the internals, but I think it is a good idea to add
documentation to the likes of l2cap.rst covering the usage of
SO_TIMESTAMPING:

https://github.com/bluez/bluez/blob/master/doc/l2cap.rst

It is on my TODO to do something similar to SCO and ISO(once it is
stable) sockets.

>
> struct tx_queue implements such queue that only "tracks" some skbs.
> Logical structure:
>
> HEAD
> <no stored skb>  }
> <no stored skb>  }  tx_queue::extra is the number of non-tracked
> ...              }  logical items at queue head
> <no stored skb>  }
> <tracked skb>           } tx_queue::queue contains mixture of
> <non-tracked skb>       } tracked items  (skb->sk !=3D NULL) and
> <non-tracked skb>       } non-tracked items  (skb->sk =3D=3D NULL).
> <tracked skb>           } These are ordered after the "extra" items.
> TAIL
>
> tx_queue::tracked is the number of tracked skbs in tx_queue::queue.
>
> hci_conn_tx_queue() determines whether skb is tracked (=3D COMPLETION
> timestamp shall be emitted for it) and pushes a logical item to TAIL.
>
> hci_conn_tx_dequeue() pops a logical item from HEAD, and emits
> timestamp if it corresponds to a tracked skb.
>
> When tracked =3D=3D 0, queue() can just increment tx_queue::extra, and
> dequeue() can remove any skb from tx_queue::queue, or if empty then
> decrement tx_queue::extra. This allows it to return to a state with
> empty tx_queue::queue when new skbs no longer request timestamps.
>
> When tracked !=3D 0, the ordering of items in the queue needs to be
> respected strictly, so queue() always pushes real skb (tracked or not)
> to TAIL, and dequeue() has to decrement extra to zero, before it can
> pop skb from queue head.
>
>
> > > > +void hci_conn_tx_queue(struct hci_conn *conn, struct sk_buff *skb)
> > > > +{
> > > > +       struct tx_queue *comp =3D &conn->tx_q;
> > > > +       bool track =3D false;
> > > > +
> > > > +       /* Emit SND now, ie. just before sending to driver */
> > > > +       if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> > > > +               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, SCM_TSTAM=
P_SND);
> > >
> > > It's a bit strange that SCM_TSTAMP_SND is under the control of
> > > SKBTX_SW_TSTAMP. Can we use the same flag for both lines here
> > > directly? I suppose I would use SKBTX_SW_TSTAMP then.
> >
> > This is the established behavior.
> > >
> > > > +
> > > > +       /* COMPLETION tstamp is emitted for tracked skb later in Nu=
mber of
> > > > +        * Completed Packets event. Available only for flow control=
led cases.
> > > > +        *
> > > > +        * TODO: SCO support without flowctl (needs to be done in d=
rivers)
> > > > +        */
> > > > +       switch (conn->type) {
> > > > +       case ISO_LINK:
> > > > +       case ACL_LINK:
> > > > +       case LE_LINK:
> > > > +               break;
> > > > +       case SCO_LINK:
> > > > +       case ESCO_LINK:
> > > > +               if (!hci_dev_test_flag(conn->hdev, HCI_SCO_FLOWCTL)=
)
> > > > +                       return;
> > > > +               break;
> > > > +       default:
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       if (skb->sk && (skb_shinfo(skb)->tx_flags & SKBTX_COMPLETIO=
N_TSTAMP))
> > > > +               track =3D true;
> > > > +
> > > > +       /* If nothing is tracked, just count extra skbs at the queu=
e head */
> > > > +       if (!track && !comp->tracked) {
> > > > +               comp->extra++;
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       if (track) {
> > > > +               skb =3D skb_clone_sk(skb);
> > > > +               if (!skb)
> > > > +                       goto count_only;
> > > > +
> > > > +               comp->tracked++;
> > > > +       } else {
> > > > +               skb =3D skb_clone(skb, GFP_KERNEL);
> > > > +               if (!skb)
> > > > +                       goto count_only;
> > > > +       }
> >
> > What is the difference between track and comp->tracked
>
> I hope the answer above is clear.
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz

