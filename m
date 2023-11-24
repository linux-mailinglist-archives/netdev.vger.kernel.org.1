Return-Path: <netdev+bounces-50907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036D7F781D
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4226B21361
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0E3172C;
	Fri, 24 Nov 2023 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POsIRmzl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2619A6
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700840952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmYkwjrZaJaOu3DPvilrXKnxuy6wNFKJN/6bdGUy1gs=;
	b=POsIRmzlgT+D1CDpLKK1nukEhS6cxa2bx1eAAezCc3RhtLomdmajjLsMSGOHrDRMt1Vl1/
	pUU3Z8BdVMeN4rqztJTeZn3zs7Tvtav0GMq2xyf2O275d+SWJy5MsEGs+LmS5t0K/K6euv
	wzhePV49ra1r0CnoMfC1SsZ73CD0LQc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-FaoHmn-NMFeMzs8-ItHmiA-1; Fri, 24 Nov 2023 10:49:08 -0500
X-MC-Unique: FaoHmn-NMFeMzs8-ItHmiA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a043b44aec3so43240466b.0
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840947; x=1701445747;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmYkwjrZaJaOu3DPvilrXKnxuy6wNFKJN/6bdGUy1gs=;
        b=pOGdk7R/iZd0KYvzWoPq6fkAWe+pIkmeun+rleYQyFYOAljDI0sCUKPnZ8WuF136VF
         xO+UKeuenviqRtDLyNErQBBinfo/TIwmCUyRH7c9BfWUmQkoRZJ/CrSTxbMMsBXZcBaH
         SnH1Ez4gsT8f3K1r2/cZ/Rfq1/mRfPbez1C7I6Q12mexS1zmwopI7cXadiAgNfXjiba+
         voHpbJeMk92Ny8LLKswGOE0mjjWA8EZjLfB/ILnOiq/WpAP0nmiXdhWYJxTItVsLaTd8
         4hYAPNo6lv8LHRtSip/qTQvVfGXOAMGCoZGR8m1ZyDPG8hmMJm5C6uXAiQBUaqukEIPE
         1PsA==
X-Gm-Message-State: AOJu0YzDXmbticHbaQHP9rMoFtOhc9i7BwrTXVbfIrimLZVxT45M8pf1
	x+49HDsnhajsgzF7cX+sOU4wGSU7uXxXhKYPcEykV/N0rQ7871Ss/cAbK3nOvgtmU/DyQk8ugP7
	1f1Z1iRgMUvoK3PGG
X-Received: by 2002:a17:906:a40b:b0:9c4:4b20:44a5 with SMTP id l11-20020a170906a40b00b009c44b2044a5mr2467430ejz.4.1700840947252;
        Fri, 24 Nov 2023 07:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzU7sedoUm9/hMpec1nsRFKG9QYHWspiwTp8W0AN+aMWC6P4eqkr9yAjzgR5V4Txo37RHZPQ==
X-Received: by 2002:a17:906:a40b:b0:9c4:4b20:44a5 with SMTP id l11-20020a170906a40b00b009c44b2044a5mr2467414ejz.4.1700840946782;
        Fri, 24 Nov 2023 07:49:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906045900b009e655c77a53sm2196512eja.132.2023.11.24.07.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:49:06 -0800 (PST)
Message-ID: <1a4a0b4c013b254d92f8c1d7c4e88e145a5be4a3.camel@redhat.com>
Subject: Re: [PATCH 3/4 net] qca_spi: Fix ethtool -G iface tx behavior
From: Paolo Abeni <pabeni@redhat.com>
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Nov 2023 16:49:04 +0100
In-Reply-To: <0d1cf97c-abbe-4a7a-a634-312caa882fad@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
	 <20231121163004.21232-4-wahrenst@gmx.net>
	 <ea0087881f20dc154ca08a5b748b853246e2b86f.camel@redhat.com>
	 <0d1cf97c-abbe-4a7a-a634-312caa882fad@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-24 at 15:17 +0100, Stefan Wahren wrote:
> Am 23.11.23 um 12:51 schrieb Paolo Abeni:
> > On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> > > After calling ethtool -g it was not possible to adjust the TX ring si=
ze
> > > again.
> > Could you please report the exact command sequence that will fail?
> ethtool -g eth1
> ethtool -G eth1 tx 8
> >=20
> >=20
> > > The reason for this is that the readonly setting rx_pending get
> > > initialized and after that the range check in qcaspi_set_ringparam()
> > > fails regardless of the provided parameter. Since there is no adjusta=
ble
> > > RX ring at all, drop it from qcaspi_get_ringparam().
> > > Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for=
 QCA7000")
> > > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > > ---
> > >   drivers/net/ethernet/qualcomm/qca_debug.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/=
ethernet/qualcomm/qca_debug.c
> > > index 6f2fa2a42770..613eb688cba2 100644
> > > --- a/drivers/net/ethernet/qualcomm/qca_debug.c
> > > +++ b/drivers/net/ethernet/qualcomm/qca_debug.c
> > > @@ -252,9 +252,7 @@ qcaspi_get_ringparam(struct net_device *dev, stru=
ct ethtool_ringparam *ring,
> > >   {
> > >   	struct qcaspi *qca =3D netdev_priv(dev);
> > >=20
> > > -	ring->rx_max_pending =3D 4;
> > >   	ring->tx_max_pending =3D TX_RING_MAX_LEN;
> > > -	ring->rx_pending =3D 4;
> > >   	ring->tx_pending =3D qca->txr.count;
> > >   }
> > I think it's preferable update qcaspi_set_ringparam() to complete
> > successfully when the provided arguments don't change the rx_pending
> > default (4)
>=20
> Sorry, i didn't get. The whole point is that there is no RX ring at all,
> just a TX ring.=C2=A0
> During the time of writing this driver, i was under the
> assumption that the driver needs to provide a rx_pending in
> qcaspi_get_ringparam even this is no RX ring. The number 4 represent the
> maximum of 4 packets which can be received at once. But it's not a ring.

Even if the H/W in charge of receiving and storing the incoming packet
is not exactly a ring but some fixed-size structure, I think it would
be better to avoid changing the exposed defaults given they are not
actually changed by this patch and they represent the current status
IMHO quite accurately.

The change I suggested is something alike the following (note that you
could possibly define a macro with a helpful name instead of the raw
number '4')

Cheers,

Paolo
---
diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c b/drivers/net/ethern=
et/qualcomm/qca_debug.c
index 6f2fa2a42770..05c5450bff79 100644
--- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -266,7 +266,7 @@ qcaspi_set_ringparam(struct net_device *dev, struct eth=
tool_ringparam *ring,
        const struct net_device_ops *ops =3D dev->netdev_ops;
        struct qcaspi *qca =3D netdev_priv(dev);
=20
-       if ((ring->rx_pending) ||
+       if ((ring->rx_pending !=3D 4) ||
            (ring->rx_mini_pending) ||
            (ring->rx_jumbo_pending))
                return -EINVAL;


