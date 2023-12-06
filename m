Return-Path: <netdev+bounces-54462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9A80722E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5A11F210AC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408843DBAA;
	Wed,  6 Dec 2023 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vdw2ST3V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4338D59
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701872451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2RBSpfnLYJCeC3HZ4ObHjBnT7unowhTzn5c96YDfUw=;
	b=Vdw2ST3VI7Q59KHR9aM2nNXFxUCPoTw2R92F1J/BNI+wDe8FPkymWNcmW9W09QUOuOPyWn
	ICexkE7oHG3tus5l9oLsr9df/BmPrTBsQUAvQ7m5+yQQ0PGOh23oncQryJ8dKI3PFAepGC
	R9Ft5iGQNeImcPCndP7nAodlczMqeSk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-gS5gCxfHPuGwzrpVat7aDw-1; Wed, 06 Dec 2023 09:20:49 -0500
X-MC-Unique: gS5gCxfHPuGwzrpVat7aDw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54bfb101ef8so4725609a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 06:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872448; x=1702477248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2RBSpfnLYJCeC3HZ4ObHjBnT7unowhTzn5c96YDfUw=;
        b=KZCBJcmEvORgCmWRj3KEI+34SKMRSu4XkdznpISVMWEaXLjIbRcgAIR9DpM8M7O4m1
         sa5EpI9IB/RvyB1zKSse0a/ftnwJb8x0meUvOP2L1SvG6MuYUTcBff/0MF4LqUDXMWWy
         u37V/E9+52yA2cIm3vpLSFuTyo+a6CUO+jpaB+KjY15qI2eBnfsiKJ/7giFIGmUSAbgc
         l+pQUuuxe80mTgHy2WG1HY5b5pv0lFZibrCSQffqhAnJ65Kc7GXmAMCCm6908sbebNTg
         RUlK6qvYqNYBtP1de0zTIKxhO/JG1AEu2LOmYikQSoZgpj4aatffI3mm7wdFgTx0qmjr
         HVwQ==
X-Gm-Message-State: AOJu0YzNovkVNXK8/pckSHX1i+qN8MM8Bg9uvzElkkeiylFB0cBgiROj
	w8or1A8Y7TN4HT4tamvSFwYit8HDT67Uyva4wakw0WfF7KjbwEZ4DmkwnzQD/L7Z6z/QvzGk02R
	kDdtSbf04cYgdtcnn/Nuirdj+GkJdZ+P4zrhBLnCUWyQZBw==
X-Received: by 2002:a50:9fa7:0:b0:54c:5492:da0f with SMTP id c36-20020a509fa7000000b0054c5492da0fmr843686edf.0.1701872448383;
        Wed, 06 Dec 2023 06:20:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrmXvuOGDykGx+e9jdLrCjlRHBBpcHDPjXsnIPrvIMNa4bvVVPqa1dBZZgWoHW6gm3P141RSTRWu7oU5Gygsk=
X-Received: by 2002:a50:9fa7:0:b0:54c:5492:da0f with SMTP id
 c36-20020a509fa7000000b0054c5492da0fmr843670edf.0.1701872448067; Wed, 06 Dec
 2023 06:20:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206063549.2590305-1-srasheed@marvell.com>
 <CADEbmW32rjDJgr4xEArasguWfsSNTJpw__AgsE9n8mwE3qXwFA@mail.gmail.com> <PH0PR18MB473488E1ABF01D5E35A4AAF0C784A@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB473488E1ABF01D5E35A4AAF0C784A@PH0PR18MB4734.namprd18.prod.outlook.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 6 Dec 2023 15:20:36 +0100
Message-ID: <CADEbmW1R64YsLxjZV3FPZDR597OmJQ6J5FaMP0=QHsoEwFCaWA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net v1] octeon_ep: explicitly test for firmware
 ready value
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani <hgani@marvell.com>, 
	Vimlesh Kumar <vimleshk@marvell.com>, "egallen@redhat.com" <egallen@redhat.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"wizhao@redhat.com" <wizhao@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, 
	Veerasenareddy Burru <vburru@marvell.com>, Sathesh B Edara <sedara@marvell.com>, 
	Eric Dumazet <edumazet@google.com>, Abhijit Ayarekar <aayarekar@marvell.com>, 
	Satananda Burla <sburla@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:12=E2=80=AFPM Shinas Rasheed <srasheed@marvell.com=
> wrote:
>
> Hi Michal
>
> > -----Original Message-----
> > From: Michal Schmidt <mschmidt@redhat.com>
> > Sent: Wednesday, December 6, 2023 7:28 PM
> > To: Shinas Rasheed <srasheed@marvell.com>
> > >                 pci_read_config_byte(pdev, (pos + 8), &status);
> > >                 dev_info(&pdev->dev, "Firmware ready status =3D %u\n"=
, status);
> > > -               return status;
> > > +#define FW_STATUS_READY 1ULL
> > > +               return (status =3D=3D FW_STATUS_READY) ? true : false=
;
> >
> > "status =3D=3D FW_STATUS_READY" is already the bool value you want. You
> > don't need to use the ternary operator here.
> >
>
> In some abnormal cases, the driver can read the firmware ready status as =
2. Hence this need for explicitly checking if status
> is indeed 1 or not. If it is 2, the function should understand it as the =
firmware is not ready. (It has to be strictly 1 for the driver
> to understand it as ready)

I'm not disputing that. I'm saying that this:
  return (status =3D=3D FW_STATUS_READY) ? true : false;
is equivalent to:
  return status =3D=3D FW_STATUS_READY;

Michal


