Return-Path: <netdev+bounces-68024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A867845A67
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F44A2911DA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AB5D497;
	Thu,  1 Feb 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYSJZJ/v"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6D5D490
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798197; cv=none; b=EX1FpcZgj6//kqMymt1/0Fe0KrYNY6DXJToPOsnGdYkCQU9bI9L0FmrFnjp+b6iVcF9/jp5qN4gXS+0ShGFOVJbZwguUkAzMMp30UM2CAxZHP2pzpIDLGBf1f+XYhEP5zxnilxBbagFEwHY3tbW/q1NN1AZ4swwHK/asXH4lEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798197; c=relaxed/simple;
	bh=OrdCn+r6vmsf7DBvYgv4kvUT1B9hA1zeSfwieTwNj5g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRglatVfapFF8qkpn3OBpD2kU1X3UF5um9n3JFGWJLqC07CmztDNQLYFlIfpfVbZLpbUAielUadtdMHzl10uaYdNK6TwDYMmLTQ8ese7/+EJSFtb4olzovE0vtrMv2H65hr8ddxJB63KX79E+lUPQgQZf2HLoAGUam8EmWvsc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYSJZJ/v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706798194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RTfac5o9676Rrt1+vbuqh9bPdV1AyEd6/D5zYvjDTAE=;
	b=gYSJZJ/vGHWXHmxnb+Xc7+c9EnfOD9Q/xCkQmCZmrR05aOZy2S/Pgn+ZARxC1PidqzCm3G
	91lY12nFpHBb9u1X1ZW5TNDWo/lHuBMuzLavLLpvQXdfUg0m6EB7Rop4TTdK9BOiM/w1OR
	EwWZrZSnFqpKhyIhEGyAMdUs2wLsV4M=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Mi08tPjdMtibxPLYdxKLLg-1; Thu, 01 Feb 2024 09:36:33 -0500
X-MC-Unique: Mi08tPjdMtibxPLYdxKLLg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d0744e70aeso1686141fa.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 06:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798191; x=1707402991;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTfac5o9676Rrt1+vbuqh9bPdV1AyEd6/D5zYvjDTAE=;
        b=rnHlBfo74AeXB4TgE102Px+BWbzDB3kqHQYpTyd0GKxZuSTZmOtl31D2xpuzAvQ+8I
         Lx5CHDfAu/BokjDmpMt+RQyAzAo67aMZJGSKIk/xNpN2w9msTeCc57u+zrTir6yu7KQt
         VksF4OtOHRx0Cqck7Fvw9de7kLZzsP1AgsuFdPHMt6BmmM+NY5tRxy7p6AaBKAKBv94R
         j+hGRtlBG5B7GTe+JH+Yxc/Hmbif77vOKT6z0G2+PADK+CA6v1aju1AS41KN6o2pjfBk
         qK0eKR4pPCA+3xzgyxeoYhLDoBdUPlcZ/0xQh4r0Gu78pw9x8dhMd+XakwVmo+kySIny
         AumA==
X-Forwarded-Encrypted: i=0; AJvYcCWSsJsKrUqt6y4U6F5Uj1xmyOMb6BJlEKp/t1cBiwxk56a0aum1n1oPUaH5r3uwEFW5E04RJOMjWyFKdhqRnUmmW4O53KPX
X-Gm-Message-State: AOJu0YwSoDHsp8dzUrVfyjbuYuNXsy59VG3H4k8csnyS6N5CqlVIshzx
	KYN4WG9dVx6be4Oij/l+IbEu4NIp4+vG/EdtkK3Z51tmfvRCACxR8R9pHj4CqdPSrUXINu6bDnA
	+p3D3zDHhFo2qCc6Btw/PYeQUSFdWcjfkTSw86OgobdtFbou3r7+CMw==
X-Received: by 2002:a2e:4c0a:0:b0:2cc:e68b:ee59 with SMTP id z10-20020a2e4c0a000000b002cce68bee59mr1579205lja.1.1706798190848;
        Thu, 01 Feb 2024 06:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm/cMif22Rwfsc5RYMvYeHc7igG1kyQ+6o59UQf+jbs9I3bqXloLAUGjlr2/YG6ItgLOoClg==
X-Received: by 2002:a2e:4c0a:0:b0:2cc:e68b:ee59 with SMTP id z10-20020a2e4c0a000000b002cce68bee59mr1579185lja.1.1706798190439;
        Thu, 01 Feb 2024 06:36:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtO9j4rNUnL9XK3zRmlwDyZ+XRgvp8LAX/ou6GhVmOQOfNGMFZMcbRmv0YOZR9kq04PLB2P9bjgwQeMXZ0+2o07zgTa4Y82y/z8H4x+iYIme2fkXrU/F4bibP+6lCtyzG65iajzfuevXVifMytJIWPQ4p/uYeD94yrcPPKZArQIwS7z9xA0UeJd6Cu5je1YwBwuPRqTXkbxNu88uic+tNGrKBt/eaRici+EJpDWbzhpikIdmPvcgKIKGm4Lctq3NSkU3gI7II0vbXLDgOWzOZo1ucrUKirmPaU4uNt8fhZEma5Z9wxlM7ADBmxyS8ikYoKlxJXt6OJq18F5BP1jL2hv82JD0cDlgWIAjoMvm+nQG0Mmna/ED6PesJD62OahGVP8vLmw3twFIbUiFDokwzS+7mqatweGpXjTYxdzwHvmAS8VPxqVy0Q3trdbPXKtFOn/rB7tNO6txxUb6MI6P3SKUie3bKZOa3lKPUM1fV9jsJ4luGO3OwPjAgeQuWPz8+2QoDdHerzDLhJB/sgQdqlMFqcFyFmvcoGYV7Vs0W9CuKZD+PdJxzzuCIiJJWgClrV2XureStlqIJSZJhzOI/lLnIkNoSOpLA=
Received: from gerbillo.redhat.com (146-241-238-90.dyn.eolo.it. [146.241.238.90])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c41d100b0040ee0abd8f1sm4505403wmh.21.2024.02.01.06.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:36:29 -0800 (PST)
Message-ID: <1878748538c778a0f0d7fb23cafc4a661132097d.camel@redhat.com>
Subject: Re: [PATCH v2 net-next 07/11] net: ena: Add more information on TX
 timeouts
From: Paolo Abeni <pabeni@redhat.com>
To: "Arinzon, David" <darinzon@amazon.com>, "Nelson, Shannon"
 <shannon.nelson@amd.com>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Cc: "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
 <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
 "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Koler, Nati" <nkoler@amazon.com>
Date: Thu, 01 Feb 2024 15:36:27 +0100
In-Reply-To: <b5ab983d43284d298fdc0d1268b33053@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
	 <20240130095353.2881-8-darinzon@amazon.com>
	 <1fd466f101f22db4ea57f2c912e1fa25803d233b.camel@redhat.com>
	 <b5ab983d43284d298fdc0d1268b33053@amazon.com>
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

On Thu, 2024-02-01 at 13:21 +0000, Arinzon, David wrote:
> > On Tue, 2024-01-30 at 09:53 +0000, darinzon@amazon.com wrote:
> > > @@ -3408,25 +3437,45 @@ static int
> > check_missing_comp_in_tx_queue(struct ena_adapter *adapter,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adapter->mis=
sing_tx_completion_to);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0if (unlikely(is_tx_comp_time_expired)) {
> > > -                     if (!tx_buf->print_once) {
> > > -                             time_since_last_napi =3D jiffies_to_use=
cs(jiffies - tx_ring-
> > > tx_stats.last_napi_jiffies);
> > > -                             missing_tx_comp_to =3D jiffies_to_msecs=
(adapter-
> > > missing_tx_completion_to);
> > > -                             netif_notice(adapter, tx_err, adapter->=
netdev,
> > > -                                          "Found a Tx that wasn't co=
mpleted on time, qid %d,
> > index %d. %u usecs have passed since last napi execution. Missing Tx
> > timeout value %u msecs\n",
> > > -                                          tx_ring->qid, i, time_sinc=
e_last_napi,
> > missing_tx_comp_to);
> > > +                     time_since_last_napi =3D
> > > +                             jiffies_to_usecs(jiffies - tx_ring->tx_=
stats.last_napi_jiffies);
> > > +                     napi_scheduled =3D !!(ena_napi->napi.state &
> > > + NAPIF_STATE_SCHED);
> > > +
> > > +                     if (missing_tx_comp_to < time_since_last_napi &=
&
> > napi_scheduled) {
> > > +                             /* We suspect napi isn't called because=
 the
> > > +                              * bottom half is not run. Require a bi=
gger
> > > +                              * timeout for these cases
> > > +                              */
> >=20
> > Not blocking this series, but I guess the above "the bottom half is not=
 run",
> > after commit d15121be7485655129101f3960ae6add40204463, happens only
> > when running in napi threaded mode, right?
> >=20
> > cheers,
> >=20
> > Paolo
>=20
> Hi Paolo,
>=20
> The ENA driver napi routine doesn't run in threaded mode.

... unless you do:

echo 1 > /sys/class/net/<nic name>/threaded

:)

> We've seen cases where napi is indeed scheduled, but didn't get a chance
> to run for a noticeable amount of time and process TX completions,
> and based on that we conclude that there's a high CPU load that doesn't a=
llow
> the routine to run in a timely manner.
> Based on the information in d15121be7485655129101f3960ae6add40204463,
> the observed stalls are in the magnitude of milliseconds, the above code =
is actually
> an additional grace time, and the timeouts here are in seconds.

Do I read correctly that in your scenario the napi instance is not
scheduled for _seconds_?  That smells like a serious bug somewhere else
really worthy of more investigation.

Cheers,

Paolo


