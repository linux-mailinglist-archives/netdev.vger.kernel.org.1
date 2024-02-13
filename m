Return-Path: <netdev+bounces-71363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E885316A
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EDC1C22864
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36B51C41;
	Tue, 13 Feb 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgAqia67"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22D51028
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829777; cv=none; b=RCjylLw4rPWL141jrL9a6YMsa0HIVEtihqQTibmsWMPyWoFTkGqE3RhbNj9Yv9qhe8EveZ85n9RwUgQ9BbfJdVAIi19h6KdZ+aaKfao6RxJKNr2w16RSHkBa5GvN8L+dF6fzuaG7CyMJ5Nm/OUIjKDKMEiqf0RKzr2y6HpCzzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829777; c=relaxed/simple;
	bh=i+UctJiXmrelGB6a1wWdJxNUYlP1cnk1nH2cwO4RDfA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5dQBBPmHinkuHdnkFJk/4Aijw7NlI0k1UicCwIlAsCL0xhmMXSwot79vrJIld0E+qC5SbqUqePwtZBwWVC5JJKVXQ6kgCQbTb5PSwNN0yGruETi+2q32pkYowPtVlHiB5FlotwcY0WwjyTapLid1zfxc8dOHhZDDKQ5/Vw2oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgAqia67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707829775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+RjXRdg+mQt6dKc9scUjiF1/TvB3AmoGPym2WYUNg/8=;
	b=VgAqia67DUdMAL7UcGt7gU2LPqU/3h6rcgpiYlS/CKRMwfCMuGnk5XdYR+403I0+FthnJK
	hPluQdSghBvqAftvfS8CsoFHV+cOcvQ5HPF5A0+ftpQ1ufRQy7UlvC4i3WJR+1WAnZO1+T
	q0Lac709x3jv2uINs2s5anDjHuD30bM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-tO0USJodMo26NcGeTpYBtg-1; Tue, 13 Feb 2024 08:09:33 -0500
X-MC-Unique: tO0USJodMo26NcGeTpYBtg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78315f4f5c2so191111985a.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829773; x=1708434573;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RjXRdg+mQt6dKc9scUjiF1/TvB3AmoGPym2WYUNg/8=;
        b=T7Wh1FUdA2dzsuqeTK3z1am6vNuDmIUnY2ZHg4wH2uhX/ULV3wPvnncFa+tvWOjN7b
         PNMx+ESpdjYQOJHIFMxnRHT83r0C9P7ICWUVSJ8b51yFj3HCXDuXn8hUEqQU/9T0YM01
         DcI0ycp43KxGHCsHhWD+NUNxH+R2xDBUw2BsL9ICMIDgKYWqiYOTZ6TTLDI+bEvKQEZS
         t5xQNYEGXuLoDix9IIhY7/PMfBQv8tMwmoclDut/Ro/2VZFiOQF//XFRiN8csSZBal8X
         aTQFCJUA28KJ5QN2dxm4w0lx3m2fRr+Dg7TvysVxQ1qYi0vMgAb3WdisTZSk2/meXVFb
         S+WA==
X-Forwarded-Encrypted: i=1; AJvYcCWoKkblb4HqmTvDXErQGnWX2NKfHGHussglt6+Zk/z7+L3pCAHqaasSOJzdiklifwwCIs4NVhekUEMC3Ce2PBoP1kQVvj20
X-Gm-Message-State: AOJu0YzPkDCesqQQ48NylBUD+KzgItw+ro+UKvpyIJmB9aoNZDNpz6Z/
	jCYr7+CFLvWBC8fvgH35kP0lDvA5XBQ5UimG3Uosi9/ipkYWwcE++y+6K3RxS9Ayft/vWGXPVrq
	xJZ32X2oDlViuOwRp+cAXbpcG4BqnXD0Y4r2ShUZ//DccM509kNGP7w==
X-Received: by 2002:a05:620a:890e:b0:785:d092:bb5a with SMTP id ql14-20020a05620a890e00b00785d092bb5amr7382014qkn.7.1707829773260;
        Tue, 13 Feb 2024 05:09:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYhGo6OV/ds4lG2Zl8TT3vEo05lJlQf+HXIw6cwJQPH0haqufnfjg9SQzAkJ2aezUhZ8Jufg==
X-Received: by 2002:a05:620a:890e:b0:785:d092:bb5a with SMTP id ql14-20020a05620a890e00b00785d092bb5amr7381985qkn.7.1707829772948;
        Tue, 13 Feb 2024 05:09:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbqmDHNLp1m/hrINz5lVHZlzgceRlzyzfRnN6h1P/p6oHx15Xd+4k/rVFO/JyzldHVWIzKMGyv3tyxLN14ZIjnfX+CS5d7blG42JioZjDUmTuO4wJL7UX4sOdJXAcPUP44TMw4zaTlL4TyJBUotkaVKuUgrSqEylSj/n9Feuc6kSr581C8P2L0ECKnJiWM05h4pxG09NWQ
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a166900b00783f1e600aasm2918879qko.38.2024.02.13.05.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:09:32 -0800 (PST)
Message-ID: <e29708440f07273fe93e3a1a7922428980f3e4a7.camel@redhat.com>
Subject: Re: [PATCH v4 net] ps3/gelic: Fix SKB allocation
From: Paolo Abeni <pabeni@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Geoff Levand
 <geoff@infradead.org>, sambat goson <sombat3960@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date: Tue, 13 Feb 2024 14:09:30 +0100
In-Reply-To: <7b695ae5-f7ce-454e-b94a-295013efddb5@csgroup.eu>
References: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
	 <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
	 <7b695ae5-f7ce-454e-b94a-295013efddb5@csgroup.eu>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 12:56 +0000, Christophe Leroy wrote:
>=20
> Le 13/02/2024 =C3=A0 13:07, Paolo Abeni a =C3=A9crit=C2=A0:
> > On Sat, 2024-02-10 at 17:15 +0900, Geoff Levand wrote:
> > > Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")=
 of
> > > 6.8-rc1 did not allocate a network SKB for the gelic_descr, resulting=
 in a
> > > kernel panic when the SKB variable (struct gelic_descr.skb) was acces=
sed.
> > >=20
> > > This fix changes the way the napi buffer and corresponding SKB are
> > > allocated and managed.
> >=20
> > I think this is not what Jakub asked on v3.
> >=20
> > Isn't something alike the following enough to fix the NULL ptr deref?
>=20
> If you think it is enough, please explain in more details.

I'm unsure it will be enough, but at least the quoted line causes a
NULL ptr dereference:

	descr->skb =3D netdev_alloc_skb(*card->netdev, rx_skb_size);
	if (!descr->skb) {
		descr->hw_regs.payload.dev_addr =3D 0; /* tell DMAC don't touch memory */
		return -ENOMEM;
	}
	// here descr->skb is not NULL...

	descr->hw_regs.dmac_cmd_status =3D 0;
	descr->hw_regs.result_size =3D 0;
	descr->hw_regs.valid_size =3D 0;
	descr->hw_regs.data_error =3D 0;
	descr->hw_regs.payload.dev_addr =3D 0;
	descr->hw_regs.payload.size =3D 0;
	descr->skb =3D NULL;
	// ... and now it's NULL for no apparent good reason

	offset =3D ((unsigned long)descr->skb->data) &
        //                            ^^^^^^^ NULL ptr deref

		(GELIC_NET_RXBUF_ALIGN - 1);
	if (offset)
		skb_reserve(descr->skb, GELIC_NET_RXBUF_ALIGN - offset);
	/* io-mmu-map the skb */
	cpu_addr =3D dma_map_single(ctodev(card), descr->skb->data,
				  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);


The buggy line in introduced by the blamed commit.

>  From my point of view, when looking at commit 3ce4f9c3fbb3=20
> ("net/ps3_gelic_net: Add gelic_descr structures") that introduced the=20
> problem, it is not obvious.

That change is quite complex. It could includes other issues - quickly
skimming over it I could not see them.

Reporting the decoded stack trace generated by the NULL ptr deref could
help.

Cheers,

Paolo


