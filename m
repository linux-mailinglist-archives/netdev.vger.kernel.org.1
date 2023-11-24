Return-Path: <netdev+bounces-50899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA67F77E0
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6A7280F10
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C82C1AD;
	Fri, 24 Nov 2023 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQC/kx1W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F29A19D
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700839991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRK+vExLgDNmQIkKz5bLbrtvkKYmpG6qoQ5cgKImwFM=;
	b=iQC/kx1Wi5Mv14CHV8Z2GoA5KXTPH4YJikBd+XWJvS704nUZ6LtS/zboazOeXVrHcqgEDz
	r7YPpQEpbs2rixBY4JSlV5dka5kfcRw7gKprZbwaN2ualEViM38w7t4dS9FXYSTa5xXU+V
	gRzJEinjptRCqo1yuqKyve+VOgZEQs0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-Zt3Jhz0PPF2KovtG1hdqpg-1; Fri, 24 Nov 2023 10:33:08 -0500
X-MC-Unique: Zt3Jhz0PPF2KovtG1hdqpg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a03389a0307so27959566b.0
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 07:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839987; x=1701444787;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRK+vExLgDNmQIkKz5bLbrtvkKYmpG6qoQ5cgKImwFM=;
        b=EWBGSNRNpAUdUFOh08C/NKZne03jTcdY9jc1TOgiPGe6DKfZGLRe5eolTgWBkhSgcq
         ojtp76mnd2/kLEyDYXvCG51O52qM9UDP2H9/ShbYaQCidQLM9PxIW0dc8EZcr+s+HgzV
         l+MvfUMuePWJTVrUeGpdrH6x7WOo835Abueu/M7/BLkl0g58waRMaB1V1vhMn7JVP9jl
         0IUOFGJl1KhfNby/zkDEkHOzbfQQ8uZHNbFZMwRIaNHOsHK37VLielA33qcNTtWi+xnL
         nwpQf0b4rZ99Jv9ry5qNpGAetq3ywG041HcBmN5bZf5C1YVYgXrBAXBn7tGAFebWPKuI
         TY1Q==
X-Gm-Message-State: AOJu0YxygsOraZUD6fP8cMy9Nj9Rs0Tu00JbO8kIaYEepnxUTFyD6OTq
	P6UKQWztgleZwJDmY1qvJx2/vw7cP8ESk3fTdqvaL8nG/PdDAmMP76pcHzFWRHa3Y/hfV6489Fa
	A4A7jj0hbVIvYHU0B
X-Received: by 2002:a50:ec96:0:b0:543:6222:e37c with SMTP id e22-20020a50ec96000000b005436222e37cmr2170176edr.0.1700839986937;
        Fri, 24 Nov 2023 07:33:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMQm2y5BRnwFeyXXHsc020p1XoBKA0tSPDi4Pl/fWInC6PUZFDeh/YRiMPUG/d1pjbHHz+rg==
X-Received: by 2002:a50:ec96:0:b0:543:6222:e37c with SMTP id e22-20020a50ec96000000b005436222e37cmr2170168edr.0.1700839986567;
        Fri, 24 Nov 2023 07:33:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-213.dyn.eolo.it. [146.241.241.213])
        by smtp.gmail.com with ESMTPSA id n3-20020aa7c783000000b0054901c25d50sm1876098eds.14.2023.11.24.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:33:06 -0800 (PST)
Message-ID: <9e2bba3c98cd24ebf1b6d9fde2e0b9229ad6b99f.camel@redhat.com>
Subject: Re: [PATCH 2/4 net] qca_spi: Fix SPI IRQ handling
From: Paolo Abeni <pabeni@redhat.com>
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, Florian Fainelli
 <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Nov 2023 16:33:04 +0100
In-Reply-To: <bf3dd03e-a1f2-4586-8f00-7003848016aa@gmx.net>
References: <20231121163004.21232-1-wahrenst@gmx.net>
	 <20231121163004.21232-3-wahrenst@gmx.net>
	 <a24433f86e39cbb45a9606621e01446e7ad6fa53.camel@redhat.com>
	 <bf3dd03e-a1f2-4586-8f00-7003848016aa@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-24 at 15:01 +0100, Stefan Wahren wrote:
> Hi Paolo,
>=20
> Am 23.11.23 um 12:37 schrieb Paolo Abeni:
> > On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
> > > The functions qcaspi_netdev_open/close are responsible of request &
> > > free of the SPI interrupt, which wasn't the best choice. Currently
> > > it's possible to trigger a double free of the interrupt by calling
> > > qcaspi_netdev_close() after qcaspi_netdev_open() has failed.
> > > So let us split IRQ allocation & enabling, so we can take advantage
> > > of a device managed IRQ and also fix the issue.
> > >=20
> > > Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for=
 QCA7000")
> > > Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> > The change makes sense, but the changelog is confusing.
> >=20
> > qcaspi_netdev_close() and qcaspi_netdev_open() are invoked only via
> > ndo_open and ndo_close(), right? So qcaspi_netdev_close() will never be
> > invoked qcaspi_netdev_open(), failure - that is when IFF_UP is not set.
> sorry, i missed to mention an important part. This issue is partly
> connected to patch 3.
> Please look at qcaspi_set_ringparam() which also call ndo_close() and
> ndo_open().=C2=A0

Ah, I see it now. IMHO root cause of the problem is there. The ethtool
op should not flip the device state.=C2=A0

A more narrow fix would be to park/unpark the thread inside
set_ringparam() - instead of the whole patch 1 && 2 I suspect.

IMHO the changes in this still make sense - a refactor for net-next.

Cheers,

Paolo


