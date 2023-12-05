Return-Path: <netdev+bounces-53819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 344BA804BB8
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B39B20D63
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBD635F13;
	Tue,  5 Dec 2023 08:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWjHr+v0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED5127
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701763463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QG11b661HftUVVcgqj8uwD4Zdvva2ZlfcVebX4a7hqE=;
	b=LWjHr+v0WEUMyIbA0xKxky1nnywLvZ99+RyvJWBVBI2HAaGkiCtQ9rkB1ixIEB3TkQwZoq
	RdPRdNEDnwIIWxSuqQI7k1sPmIjFSRngfFPbIrmmjFCEebYprKOhp0GOxlC5sA5RHYAWQF
	AwbhQQanrnxYmSQ875LFm4Hs0zoUmiU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-gr-Pc9FpNsKsW_kC6bvpTQ-1; Tue, 05 Dec 2023 03:04:15 -0500
X-MC-Unique: gr-Pc9FpNsKsW_kC6bvpTQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54c8febd0b0so223125a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 00:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701763454; x=1702368254;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QG11b661HftUVVcgqj8uwD4Zdvva2ZlfcVebX4a7hqE=;
        b=UM0H8/qJ+wc8D/kajxgRH/cKtDGFW6AUjJaV+VW7SqV2QGgj9YmE9hBKSX+5Bdng61
         qNmKPcu1TBPDBMvsibbeBd1OoxiCf5E0hEBEjW0a9lefRwpvKzvMIEs4KLbu6rnF9Vwz
         b5meFE6QOkaAu/ORMT5ENf5TAWt9NnhTB6p6PPhh/LPnTH7kqFVHB2PkZmp2Q3iERPJd
         vzlACFKXXn++f0aMuybTvpxvyaxPfpx9IO5A1YC16UQvNY7j5NzQuC1bx86VrvICuZEE
         4s8avNJGbO8nW7Vhb6ye1hmc544Av1Z+cTcQE/85OJJG2tV/KW6gFtgpqlVrrTyiTQaN
         XByQ==
X-Gm-Message-State: AOJu0YzbmkFPASLuolUzNKDGbgoUnP/CNFz84wSOdC3P3wa39ASU5/wU
	VKXpHfViNsy6eMr3neulYszvAYTL5DOHEVLtCh9QeFL0dUodQRhT63Y17eTcBIRzZBmlSyKnTSc
	z8B3G8dO9ViTfew/o
X-Received: by 2002:a05:6402:26c5:b0:54c:d1a2:4607 with SMTP id x5-20020a05640226c500b0054cd1a24607mr3368988edd.3.1701763454003;
        Tue, 05 Dec 2023 00:04:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtXpMsawMsuFwRkEnoQMMcXKCPnk2BWpymAzqEFedNYhFu5lgiRc7w0ozIKmOHNaM1R42zQw==
X-Received: by 2002:a05:6402:26c5:b0:54c:d1a2:4607 with SMTP id x5-20020a05640226c500b0054cd1a24607mr3368977edd.3.1701763453676;
        Tue, 05 Dec 2023 00:04:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id n10-20020aa7c44a000000b0054cd6346685sm720230edr.35.2023.12.05.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:04:13 -0800 (PST)
Message-ID: <73ef03a1607f221c7939cb0646c17c5435dcecd1.camel@redhat.com>
Subject: Re: [PATCHv2] USB: gl620a: check for rx buffer overflow
From: Paolo Abeni <pabeni@redhat.com>
To: Oliver Neukum <oneukum@suse.com>, dmitry.bezrukov@aquantia.com, 
 marcinguy@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  linux-usb@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 05 Dec 2023 09:04:11 +0100
In-Reply-To: <20231122095306.15175-1-oneukum@suse.com>
References: <20231122095306.15175-1-oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 10:52 +0100, Oliver Neukum wrote:
> The driver checks for a single package overflowing
> maximum size. That needs to be done, but it is not
> enough. As a single transmission can contain a high
> number of packets, we also need to check whether
> the aggregate of messages in itself short enough
> overflow the buffer.
> That is easiest done by checking that the current
> packet does not overflow the buffer.
>=20
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

This looks like a bugfix, so a suitable Fixes tag should be included.

> ---
>=20
> v2: corrected typo in commit message
> =20
>  drivers/net/usb/gl620a.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/usb/gl620a.c b/drivers/net/usb/gl620a.c
> index 46af78caf457..d33ae15abdc1 100644
> --- a/drivers/net/usb/gl620a.c
> +++ b/drivers/net/usb/gl620a.c
> @@ -104,6 +104,10 @@ static int genelink_rx_fixup(struct usbnet *dev, str=
uct sk_buff *skb)
>  			return 0;
>  		}
> =20
> +		/* we also need to check for overflowing the buffer */
> +		if (size > skb->len)
> +			return 0;

I think the above is not strict enough: at this point skb->data points
to the gl_packet header. The first 4 bytes in skb are gl_packet-
>packet_length. To ensure an overflow is avoided you should check for:

		if (size + 4 > skb->len)

likely with a describing comment.

Cheers,

Paolo


