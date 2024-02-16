Return-Path: <netdev+bounces-72344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA038579E5
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CAC1F22AF5
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89041BF53;
	Fri, 16 Feb 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQoGDFfj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A111BDCD
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077996; cv=none; b=YY5We25tKvr4Lsk3iueruy1iyl0Udn0i4pozE5SoMtFg0y2YpG1f6hmvLg5APm/QtNuxU9b9JvAw2jeJaIJ4zkL7VNPmA0bqpPTuXcqagBNC8hQWyG/GjZpqsylG35SyHaQxnft8h5sghlUNDxGPyrd798dyqJNpz4vkr5iwoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077996; c=relaxed/simple;
	bh=2F+MpjRyG9olzqrFd+uLJrFfg2x9tzG4Dk2d+CHIkJQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sk4E1Vt/qBrzvDji8LzTzP6ayI9hct5mdwjc2b6Zmo+ZWBvanLy2rtmlhrSQurZedFlkE8uFIAof3cqUs4YdfOEBeMc2Uo7GYmgISf0FTKyMqiVTPRarlXWQv8U9wRHfV8bA5VMUybbPYI1oEGR9Px1gCANsT3Ya3GJLQfKIA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQoGDFfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708077993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pC15RX3b7KIDE/bdDRYrYWka79Sh64Q3SQBexq+hSbU=;
	b=bQoGDFfjACZclQ7u/HQ2Fy46ipK/P6RVFfvn5XB2og8vGpcrafH35oPaqZVBBVm0pijD3r
	HAlZvelXvdvmybqEdApEwDHpeF+5Vpl9eINMAvp5tL0SXrRyhfsrAVKObXbhRbBZ2478+6
	/YNg+Dx51L32rEBhe46J7sVhWYdVf4s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-WLTdJO_SOmGsF-940oDGWQ-1; Fri, 16 Feb 2024 05:06:31 -0500
X-MC-Unique: WLTdJO_SOmGsF-940oDGWQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412393ec106so326025e9.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 02:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708077990; x=1708682790;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC15RX3b7KIDE/bdDRYrYWka79Sh64Q3SQBexq+hSbU=;
        b=Zu9SMbh/ypqLhPGBa5lxQQxjbeY/sB0C8O3CpLWREzJkfMW2Er79ntbTloDXQJ37b1
         YADaZ7CysS3goo/Fx/O3ox8Rf99Ptif2Dn8OAMadAeDGTZopljzmCcWHPk3CUoYJrDmP
         XySdGs2qff6VIC6210T/ZMHcA/HjKEXwkvwb7GeOLgd5zBxCd884rR3J2Pnol9UuP2WT
         nWjvpfUUEdtwZloDsnaquJOTqADO+fqxCaGMyaXhunFrgXbnArhwn+6Hv3ck8JZ67SlO
         gSwB7CNs/elxSs7UcqCCgdOSH0o8GYVc9Z7NFZ8/g/0Uzt9OKuxfHYbmEZRyji4WAr38
         Q7bg==
X-Forwarded-Encrypted: i=1; AJvYcCX+iUi9KuOHpEkEegl3M8pYOgp+g46o9CBSE7T04ur9zFi44Wo7xzeLqFvjirycISrWYkkoagRTQ8NfYIuDvhKPm2ZuhBVD
X-Gm-Message-State: AOJu0YyZZd7LN2rD4+psw8+Sh9voz+F8ajmzidiCAI4t01Rc1xaxRqMV
	WzFwHrUbUQCbGg89sZInucJdhbomcy2/9OdIs+0Ff0rOSkHHGuFY6Rxa4lUBCLCo/IkjqwnO2hT
	8z46dOEL9DkWV9XPmHKJsHV6XKwxiGvKsKW5WKSnj5H2MwBrhEtMttw==
X-Received: by 2002:a05:6000:1f97:b0:33b:4d82:a487 with SMTP id bw23-20020a0560001f9700b0033b4d82a487mr3616535wrb.1.1708077990252;
        Fri, 16 Feb 2024 02:06:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCQXqtm6D9eTknKunYB6dLkeY5PHRwSie1CeYqvMa7QyPf2n7FAKKkb+vOowa/6/rvmM+OKg==
X-Received: by 2002:a05:6000:1f97:b0:33b:4d82:a487 with SMTP id bw23-20020a0560001f9700b0033b4d82a487mr3616522wrb.1.1708077989901;
        Fri, 16 Feb 2024 02:06:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-239-108.dyn.eolo.it. [146.241.239.108])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b0033cef5812f6sm1707451wrs.109.2024.02.16.02.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:06:29 -0800 (PST)
Message-ID: <e3953200fb8f0e81f76e62e3cb397b31f9c864b3.camel@redhat.com>
Subject: Re: [PATCH v4 net] ps3/gelic: Fix SKB allocation
From: Paolo Abeni <pabeni@redhat.com>
To: Geoff Levand <geoff@infradead.org>, sambat goson <sombat3960@gmail.com>,
  Christophe Leroy <christophe.leroy@csgroup.eu>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Date: Fri, 16 Feb 2024 11:06:28 +0100
In-Reply-To: <0b649004-4465-404f-b873-1013bb03a42d@infradead.org>
References: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
	 <125361c7ec88478e04595a53aacc406ef656f136.camel@redhat.com>
	 <0b649004-4465-404f-b873-1013bb03a42d@infradead.org>
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

On Fri, 2024-02-16 at 18:37 +0900, Geoff Levand wrote:
> On 2/13/24 21:07, Paolo Abeni wrote:
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
> >=20
> > Thanks,
> >=20
> > Paolo
> > ---
> > diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net=
/ethernet/toshiba/ps3_gelic_net.c
> > index d5b75af163d3..51ee6075653f 100644
> > --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> > @@ -395,7 +395,6 @@ static int gelic_descr_prepare_rx(struct gelic_card=
 *card,
> >         descr->hw_regs.data_error =3D 0;
> >         descr->hw_regs.payload.dev_addr =3D 0;
> >         descr->hw_regs.payload.size =3D 0;
> > -       descr->skb =3D NULL;
>=20
> The reason we set the SKB pointer to NULL here is so we can
> detect if an SKB has been allocated or not.  If the SKB pointer
> is not NULL, then we delete it.
>=20
> If we just let the SKB pointer be some random value then later
> we will try to delete some random address.

Note that this specific 'skb =3D NULL' assignment happens just after a
successful allocation and just before unconditional dereference of such
ptr:

        descr->skb =3D netdev_alloc_skb(*card->netdev, rx_skb_size);
        if (!descr->skb) {
                descr->hw_regs.payload.dev_addr =3D 0; /* tell DMAC don't t=
ouch memory */
                return -ENOMEM;
        }

        descr->hw_regs.dmac_cmd_status =3D 0;
        descr->hw_regs.result_size =3D 0;
        descr->hw_regs.valid_size =3D 0;
        descr->hw_regs.data_error =3D 0;
        descr->hw_regs.payload.dev_addr =3D 0;
        descr->hw_regs.payload.size =3D 0;
	// XXX here skb is not NULL and valid=20
        descr->skb =3D NULL;

	offset =3D ((unsigned long)descr->skb->data) &
	// XXX here              ^^^^^^^^^^=20
	// you unconditionally get null ptr deref
                (GELIC_NET_RXBUF_ALIGN - 1);

unless ENOCOFFEE here which is totally possible.

Cheers,

Paolo


