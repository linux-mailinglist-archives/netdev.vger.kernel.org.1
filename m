Return-Path: <netdev+bounces-218896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DCFB3EF8B
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AB7A10B3
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A2D27144A;
	Mon,  1 Sep 2025 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="LYUgtez/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A826CE3A
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758117; cv=none; b=rgsMgl7sqco2HocJii9oOpTPuMvtQcyirTbA/XABYWt11TOhFLqInOJdSc2qDuUrnWhQckDLlFb/9NmPReYg9zgF3ezroMqkmoVcQ9CqldJ6ThRVxTCTx7Eb9dVPNQhzdhHyKlUKGcrqa30/+5H9McOe90I9jUethKgpm0/YYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758117; c=relaxed/simple;
	bh=hY+GAjOTQdyd/B9W6ODCGz3C+u6ohc7450epHyqcbtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQp893lsJ6uHmcBuLUfjJsvGxlMsJPl4DsMK29COeumhoqrW/XgX1zaRBxknGs3wnF3lVsBtrpxckVoKoj2rYEdjVYcbpRvqj5X+2CN7FneU4pEGNbpFpxJ/lTEGT0IonL38SM5I/u3CrraaxuGUBicFlp8QyPEcnZQ6FtAXTsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=LYUgtez/; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9bukFxnzDaCh0fpWxhxHKD/5rTkG4jMIYMzGpzZwxBA=; t=1756758116; x=1757622116; 
	b=LYUgtez/2LMWpwxxuhs2HuRGpcAjm2dOYmPs7gfu+MEPP2IB7WQ8w3xlYklQSyUypX5y8dZHV3j
	MQ+aVaVKd2MwRBcxGJA8fY7XheAyGTBo6uHmVoYPq5hDizhO/DfZqGaFup5SNX54Jcbq7KMaHkHlz
	q8qeh/tauge/tFljH8nYwIFFC1NwA2+gRqfhZD7BlxctjFzCXPw4Kodthgf9D12KFTlCofAg8wWnL
	99QUTYyLALiPYX8L96XIXwk+cnv7yWYSkoJzZ7hQLhWz5piGGueDZkBcFXG2KT+Y8OhmI3nAYqCnI
	ng7ReZjE6WoHHF8XzcgnToKUhc/0LOUYA5ig==;
Received: from mail-ot1-f49.google.com ([209.85.210.49]:59644)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1utB2I-0004Y5-TZ
	for netdev@vger.kernel.org; Mon, 01 Sep 2025 13:21:55 -0700
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74526ca7d64so3995033a34.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 13:21:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQladkyz3+XsAS74TGvjOhC6MzpgXuLiMsLwm2OUASeO7Ngvyz
	OUlEVRGSDoy1qVE9ifHegatMOL+wW4CaNM8ZqEB9Y3ioUyOd3FF7WFP0Mf+ZgIWWd5RJlgRePHq
	KhMijGg0ekYl5YkQo9hjHKGtvQY/tkuw=
X-Google-Smtp-Source: AGHT+IG9AmvpyJnUi9vTSyqJhX5dfZJjYJMFZ1i0Z5Q8JkNV5EIdf7N9MWMBd1lHbX94GElaJkzK6l3KXzAFiwFbxsg=
X-Received: by 2002:a05:6808:138a:b0:40a:533c:c9cb with SMTP id
 5614622812f47-437f7da76ccmr4158430b6e.38.1756758114267; Mon, 01 Sep 2025
 13:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-11-ouster@cs.stanford.edu>
 <31aab5bd-7775-4fec-90a1-59e3120d500b@redhat.com>
In-Reply-To: <31aab5bd-7775-4fec-90a1-59e3120d500b@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 1 Sep 2025 13:21:18 -0700
X-Gmail-Original-Message-ID: <CAGXJAmy3xy1hVjFAVjVS=diYLeOTV1kQ9wGQ1usoDa1D5xk0Gg@mail.gmail.com>
X-Gm-Features: Ac12FXyW4pTBWkSnrNYoT0rsZfCj4QUb6vSsJ9mWDDe6QMA8yLVFtEcehxv_64k
Message-ID: <CAGXJAmy3xy1hVjFAVjVS=diYLeOTV1kQ9wGQ1usoDa1D5xk0Gg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 10/15] net: homa: create homa_outgoing.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 72f97ea9660f372cf635c7c250d627db

On Tue, Aug 26, 2025 at 4:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:

> > +/**
> > + * homa_rpc_tx_end() - Return the offset of the first byte in an
> > + * RPC's outgoing message that has not yet been fully transmitted.
> > + * "Fully transmitted" means the message has been transmitted by the
> > + * NIC and the skb has been released by the driver. This is different =
from
> > + * rpc->msgout.next_xmit_offset, which computes the first offset that
> > + * hasn't yet been passed to the IP stack.
> > + * @rpc:    RPC to check
> > + * Return:  See above. If the message has been fully transmitted then
> > + *          rpc->msgout.length is returned.
> > + */
> > +int homa_rpc_tx_end(struct homa_rpc *rpc)
> > +{
> > +     struct sk_buff *skb =3D rpc->msgout.first_not_tx;
> > +
> > +     while (skb) {
> > +             struct homa_skb_info *homa_info =3D homa_get_skb_info(skb=
);
> > +
> > +             /* next_xmit_offset tells us whether the packet has been
> > +              * passed to the IP stack. Checking the reference count t=
ells
> > +              * us whether the packet has been released by the driver
> > +              * (which only happens after notification from the NIC th=
at
> > +              * transmission is complete).
> > +              */
> > +             if (homa_info->offset >=3D rpc->msgout.next_xmit_offset |=
|
> > +                 refcount_read(&skb->users) > 1)
> > +                     return homa_info->offset;
>
> Pushing skbs with refcount > 1 into the tx stack calls for trouble. You
> should instead likely clone the tx skb.

Can you say more about what the problems are? So far I have not
encountered any issues and this approach is pretty useful (it will
become even more useful with additional Homa mechanisms that aren't in
this patch).

I have fixed all of the other comments on this patch in the way you suggest=
ed.

-John-

