Return-Path: <netdev+bounces-53846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94E804DD9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655471F212AA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDB43E48B;
	Tue,  5 Dec 2023 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPBRrYIf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535E310E9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701768542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWSbeQkndxR8pOH1jrEtRfCn62USiBxMT3pXbunoD3Q=;
	b=MPBRrYIf1Z6Z/mqlAt8B8qdqHsQSE7KeFl+ay5kBQ2M3ciR/lnOCX3cdQiMQGFN//ndPMC
	KBNbMs8dODs2G8bWkO60jSXFFkN9+q5Y4aWYdL9fHzpRAe5BVBxnq2OTBQE0sIIdlCExYG
	XS5a96GrImyH08j3v/L3vNFOWLmSJoo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-zPiF5HBuMJalD6BkmHpsQg-1; Tue, 05 Dec 2023 04:28:59 -0500
X-MC-Unique: zPiF5HBuMJalD6BkmHpsQg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1be0f29061so7048266b.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 01:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768538; x=1702373338;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWSbeQkndxR8pOH1jrEtRfCn62USiBxMT3pXbunoD3Q=;
        b=rm4P/8ac0Ziy4ZfO3YxbhlQGcbYJZtQgGwhnBWreZ/F5X+TIcNU3FC+JYOJXpe9qHw
         4Zr9mto4/NUkUeAOKhgCB6tx/nGmzgiTSq7jvA34Am6Jz0I3UE/ZvFwn2titUZlrsQPm
         IBzZXaCtysQ5Q7tMBCIM92iokGOw1OJTh88NS+YpX8sLbdiN8DjrcGbG/y6QUoLE6xce
         7OLE1yFf7omDc6RJFY6/9BVaLvChIj03bQYx5WsCS8ooEf89O9MCJ+xhlGO5ArHajuBj
         YWcVUjQvl/I88Ojc01jjcUEMfp4iHsB/2OLqft3kMUzFTuunvw+fD7ASwsih0AWC/cbe
         W6uQ==
X-Gm-Message-State: AOJu0YxfhhsuNr65fH/tklNnedsDO15E6KW0/icZYsGK3GLag+v/LYoc
	WnWAQZazKk4416mWgWo6oOqF7UIgCMLrrwzvfSXjgRWPk12g1PQomBSg3KwpxE65ygXbXTzsJvt
	BpNHEupdlN7hHHZpAKrIx0KQ7
X-Received: by 2002:a17:906:3b96:b0:a1c:87a2:c183 with SMTP id u22-20020a1709063b9600b00a1c87a2c183mr484063ejf.5.1701768538131;
        Tue, 05 Dec 2023 01:28:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAbf9T1cl753dwNJrA4r4f5Cd5wzRLvS/Q1MW1BiOQwtPcGxLNeQjBeV3vMyTRD3tSBQzs7w==
X-Received: by 2002:a17:906:3b96:b0:a1c:87a2:c183 with SMTP id u22-20020a1709063b9600b00a1c87a2c183mr484053ejf.5.1701768537730;
        Tue, 05 Dec 2023 01:28:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id b20-20020a17090636d400b009dd98089a48sm6382410ejc.43.2023.12.05.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:28:57 -0800 (PST)
Message-ID: <d657f059d384419fe4df02580a4af9cf69e0e9c2.camel@redhat.com>
Subject: Re: [PATCH net-next v6 1/6] ptp: clockmatrix: support 32-bit
 address space
From: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>, Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Date: Tue, 05 Dec 2023 10:28:56 +0100
In-Reply-To: <20231205092429.GS50400@kernel.org>
References: 
	<PH7PR03MB70644CE21E835B48799F3EB3A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
	 <20231205092429.GS50400@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-05 at 09:24 +0000, Simon Horman wrote:
> On Thu, Nov 30, 2023 at 01:46:29PM -0500, Min Li wrote:
> > From: Min Li <min.li.xe@renesas.com>
> >=20
> > We used to assume 0x2010xxxx address. Now that
> > we need to access 0x2011xxxx address, we need
> > to support read/write the whole 32-bit address space.
> >=20
> > Signed-off-by: Min Li <min.li.xe@renesas.com>
>=20
> ...
>=20
> > diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatri=
x.c
> > index f6f9d4adce04..f8556627befa 100644
> > --- a/drivers/ptp/ptp_clockmatrix.c
> > +++ b/drivers/ptp/ptp_clockmatrix.c
> > @@ -41,8 +41,8 @@ module_param(firmware, charp, 0);
> >  static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_p=
pm);
> > =20
> >  static inline int idtcm_read(struct idtcm *idtcm,
> > -			     u16 module,
> > -			     u16 regaddr,
> > +			     u32 module,
> > +			     u32 regaddr,
> >  			     u8 *buf,
> >  			     u16 count)
> >  {
> > @@ -50,8 +50,8 @@ static inline int idtcm_read(struct idtcm *idtcm,
> >  }
> > =20
> >  static inline int idtcm_write(struct idtcm *idtcm,
> > -			      u16 module,
> > -			      u16 regaddr,
> > +			      u32 module,
> > +			      u32 regaddr,
> >  			      u8 *buf,
> >  			      u16 count)
> >  {
>=20
> Hi Min Li,
>=20
> My understanding of Paolo's review of v5 was that it would be cleaner to:
>=20
> 1. Leave the type of the module parameter as u16
> 2. Update the type of the regaddr parameter to u32

[almost over the air conflict here ;) ]

I think the module parameter as u32 is needed, as later macro
definitions will leverage that.

>=20
> And...
>=20
> ...
>=20
> > @@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
> >  	val =3D SYNCTRL1_MASTER_SYNC_RST;
> > =20
> >  	/* Place master sync in reset */
> > -	err =3D idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
> > +	err =3D idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
> >  	if (err)
> >  		return err;
> > =20
> > -	err =3D idtcm_write(idtcm, 0, sync_ctrl0, &sync_src, sizeof(sync_src)=
);
> > +	err =3D idtcm_write(idtcm, sync_ctrl0, 0, &sync_src, sizeof(sync_src)=
);
> >  	if (err)
> >  		return err;
> > =20
>=20
> ... avoid the need for changes like the two above.

This part is correct/what I meant ;)

Cheers,

Paolo


