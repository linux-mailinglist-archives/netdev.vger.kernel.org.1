Return-Path: <netdev+bounces-152521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4549F46EF
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B266D188E5D2
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5401DE3A3;
	Tue, 17 Dec 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvXXRBBq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137861DDA35
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426715; cv=none; b=HI5RK8F1FL1en738gZKm8I94WwPD65ZW06N/0tN/+GFEC89YH2Zuy4DKLVuPqZSgPC+/0QbF8L6Hmgfr5f8ho/+kLfFH7SXo43b76TXe0JysUbgCP5B5EzFcfzxTGnf2mQDAS6OoICoQSgOqGjHdb5XgHWGqoOz8bEaAHNNCHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426715; c=relaxed/simple;
	bh=zy4bBYMVL8DP0ir49MZPIYuXMiFWsWtLnt4Gz3ehCmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvqMUfaQwbOPsJQCs4B9dBkidZw3KUwTR0KggF96BiwoHyhOPN0DPHhEb42YfqJ2z80R8kfhq7kltg9BBW41+Gr0Fs0DLFCwyLQCwhHppjh3K0duIIF0GWiNR4d7nnoC0M8TXRoDr0nsH4vpCNJu1rx+yxwMvlo0nu73nYqAqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvXXRBBq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734426711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ESufe5rF/R7zx4d1QNvSHE8yi+nyP2mYtd5r91KpH6k=;
	b=PvXXRBBqpn0TSMBHDBZae/GJw9lqcsckp/Q52rFkgiC5S+9Zw0ElSgKmy34Xf+pCpCzmoO
	ou4BJsHppbeRKaELHT1i2Tue2WglRzWKpb19KuQqxIiwXL4eCy78aF6vOWAoiVTKdcfbvS
	dS/gi3gFw76mCkrtNz2imBZm8nPDOZ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522--25_m6_KMyiOmXR7bV6fxA-1; Tue, 17 Dec 2024 04:11:50 -0500
X-MC-Unique: -25_m6_KMyiOmXR7bV6fxA-1
X-Mimecast-MFC-AGG-ID: -25_m6_KMyiOmXR7bV6fxA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436248d1240so27397235e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426709; x=1735031509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESufe5rF/R7zx4d1QNvSHE8yi+nyP2mYtd5r91KpH6k=;
        b=Pfh6G2mfw6Fvk2ZQvNxP30Fh8qbYFQ2O9BmMzxDVLgfJ6+cZhCCx9cH8UUpFy212ec
         gWfXh6uBx/YyInGqmiyQCRxF9NmNHrQU7sh+zX0txi+yw3Iz5dKOa9etHcCsPydZaUTQ
         eP7Lv0+O9B1YZS+QuVj8coKeQRaTB/8QsD3CyychW9QuQrvp6xqCs0DIB6gbby43OhlM
         65lzKE43mcnLr8YDFWKVbZ3cHaj9cN4w7m5/kez/hryTtU86GCRreizmWY+vmd0wlwht
         PxpoWsCzlORuSXYXrgH+oe45QE1tR8KETt5yfXOtO5kFDqL7J71N0ErgZJF7nUlOOOJi
         12cA==
X-Forwarded-Encrypted: i=1; AJvYcCV+d6Il503VMpTKd07iBI2fT6OhJF8CsMmzIi0n2hDQkp/totSP29FreGkZ8mrVqhvYaDylcsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl0QV3mKG8d3OstrxPCpRofO+Rl0wh6e07HGCuPvvT726rJmPR
	U8K/EwvxQPiguse+mv+WB0sv1C3wadzWPIe3mOUI/wdLOnLPi9MoAXlQXrGg9fPnEA469qCzEUj
	CCD2ohPucQgpLWhlLz9ZQl8QPVKcPot0QuWpBIyt5abYDDw2+qaAUuQ==
X-Gm-Gg: ASbGnctxIbN3OJeoUN6StrOEnuS9l1IdK83AA77yi2yOoeF/euhvGvyPiGoIoOpzi0M
	yrA7JDqCvnOzMDnctl0l0LtKbxrIRzlKMrlN529yQh0xWNmzBAnqSD6APXR2vFHIBM7BmBLJcv8
	BbMpjkKZbWNN0cMfS2wnMTiR9phhzziGZixjpt2v0rgoJqgxudCEd8BnkCq4W+dHu3S2KX8TZYX
	iIQalUzL8uW/BXqqoofpDD1akja37HMut2IVMd4NQxN2bHMFLu2fo2ZMkHuwOtDNDxsr+/6Xi5f
	nR0m1hBwaKqdbHFgJ/xA+P943cKq
X-Received: by 2002:a05:600c:1d96:b0:434:a29d:6c71 with SMTP id 5b1f17b1804b1-4362aaa001fmr136814665e9.27.1734426708695;
        Tue, 17 Dec 2024 01:11:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG62PlSCQyYv8iZE9vFZjgkt8pXh8qLYh5tl0xJPqNVkSzYZkJygFHW/h1q88j/sVq1OT4Wlw==
X-Received: by 2002:a05:600c:1d96:b0:434:a29d:6c71 with SMTP id 5b1f17b1804b1-4362aaa001fmr136814065e9.27.1734426708080;
        Tue, 17 Dec 2024 01:11:48 -0800 (PST)
Received: from localhost (net-93-146-37-148.cust.vodafonedsl.it. [93.146.37.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436362c6818sm111537805e9.38.2024.12.17.01.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 01:11:47 -0800 (PST)
Date: Tue, 17 Dec 2024 10:11:46 +0100
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <Z2FAUuOh4jrA0uGu@lore-desk>
References: <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <20241216194641.b7altsgtjjuloslx@skbuf>
 <Z2CpgqpIR5_MXTO7@lore-desk>
 <20241216231311.odozs4eki7bbagwp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="APQ17BrPyud3HNQ8"
Content-Disposition: inline
In-Reply-To: <20241216231311.odozs4eki7bbagwp@skbuf>


--APQ17BrPyud3HNQ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Dec 16, 2024 at 11:28:18PM +0100, Lorenzo Bianconi wrote:
> > > ndo_setup_tc_conduit() does not have the same instruments to offload
> > > what port_setup_tc() can offload. It is not involved in all data paths
> > > that port_setup_tc() has to handle. Please ack this. So if port_setup=
_tc()
> >=20
> > Can you please elaborate on this? Both (->ndo_setup_tc_conduit() and
> > ->port_setup_tc()) refer to the same DSA user port (please take a look =
the
> > callback signature).
>=20
> I'd be just repeating what I've said a few times before. Your proposed
> ndo_setup_tc_conduit() appears to be configuring conduit resources
> (QDMA, GDM) for mt7530 user port tc offload, as if it is in complete and
> exclusive control of the user port data path. But as long as there are
> packets in the user port data path that bypass those conduit QoS resources
> (like for example mt7530 switch forwards packet from one port to another,
> bypassing the GDM1 in your drawing[1]), it isn't a good model. Forget
> about ndo_setup_tc_conduit(), it isn't a good tc command to run in the
> first place. The tc command you're trying to make to do what you want is
> supposed to _also_ include the mt7530 packets forwarded from one port to
> another in its QoS mix. It applies at the _egress_ of the mt7530 port.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D23020f04932701d5c8363e60756f12b43b8ed752
>=20
> Let me try to add some squiggles based on your diagram, to clarify what
> is my understanding and complaint.
>=20
>                =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=90                                   =E2=94=8C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                =E2=94=82 QDMA2 =E2=94=82                                 =
  =E2=94=82 QDMA1 =E2=94=82
>                =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=98                                   =E2=94=94=E2=94=
=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>                    =E2=94=82                                           =
=E2=94=82
>            =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>            =E2=94=82                                                     =
       =E2=94=82
>            =E2=94=82       P5                                          P0=
       =E2=94=82
>            =E2=94=82                                                     =
       =E2=94=82
>            =E2=94=82                                                     =
       =E2=94=82
>            =E2=94=82                                                     =
       =E2=94=82    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90
>            =E2=94=82                                                     =
    P3 =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA GDM3 =E2=94=82
>            =E2=94=82                                                     =
       =E2=94=82
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=
=82                                                            =E2=94=82
> =E2=94=82 PPE =E2=97=84=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4 P4  =
                      PSE                              =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=
=82                                                            =E2=94=82
>            =E2=94=82                                                     =
       =E2=94=82    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90
>            =E2=94=82                                                     =
    P9 =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA GDM4 =E2=94=82
>            =E2=94=82                                                     =
       =E2=94=82    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98
>            =E2=94=82                                                     =
       =E2=94=82
>            =E2=94=82        P2                                         P1=
       =E2=94=82
>            =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>                      =E2=94=82                                         =
=E2=94=82
>                  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=
=E2=94=80=E2=94=90                                   =E2=94=8C=E2=94=80=E2=
=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                  =E2=94=82 GDM2 =E2=94=82                                =
   =E2=94=82 GDM1 =E2=94=82
>                  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=98                                   =E2=94=94=E2=94=80=E2=
=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>                                                                =E2=94=82
>                                                 =E2=94=8C=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>                                                 =E2=94=82            CPU =
port          =E2=94=82
>                                                 =E2=94=82   =E2=94=8C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98                =E2=94=82
>                                                 =E2=94=82   =E2=94=82    =
     MT7530           =E2=94=82
>                                                 =E2=94=82   =E2=94=82    =
                      =E2=94=82
>                                                 =E2=94=82   =E2=96=BC    =
     x                =E2=94=82
>                                                 =E2=94=82   =E2=94=8C=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=8C=E2=94=80=E2=
=94=98                =E2=94=82
>                                                 =E2=94=82  lan1  lan2  la=
n3  lan4      =E2=94=82
>                                                 =E2=94=94=E2=94=80=E2=94=
=80=E2=94=80=E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>                                                     =E2=96=BC
>=20
> When you add an offloaded Qdisc to the egress of lan1, the expectation
> is that packets from lan2 obey it too (offloaded tc goes hand in hand
> with offloaded bridge). Whereas, by using GDM1/QDMA resources, you are
> breaking that expectation, because packets from lan2 bridged by MT7530
> don't go to GDM1 (the "x").

ack, I got your point. I was assuming to cover this case (traffic from lan2=
 to
lan1) maintaining the port_setup_tc() callback in dsa_user_setup_qdisc() (t=
his
traffic is not managed by ndo_setup_tc_conduit() callback). If this approac=
h is
not ok, I guess we will need to revisit the approach.

>=20
> > > returns -EOPNOTSUPP, the entire dsa_user_setup_qdisc() should return
> > > -EOPNOTSUPP, UNLESS you install packet traps on all other offloaded d=
ata
> > > paths in the switch, such that all packets that egress the DSA user p=
ort
> > > are handled by ndo_setup_tc_conduit()'s instruments.
> >=20
> > Uhm, do you mean we are changing the user expected result in this way?
> > It seems to me the only case we are actually changing is if port_setup_=
tc()
> > callback is not supported by the DSA switch driver while ndo_setup_tc_c=
onduit()
> > one is supported by the mac chip. In this case the previous implementat=
ion
> > returns -EOPNOTSUPP while the proposed one does not report any error.
> > Do we really care about this case? If so, I guess we can rework
> > dsa_user_setup_qdisc().
>=20
> See above, there's nothing to rework.
>=20
> > > > nope, I am not saying the current Qdisc DSA infrastructure is wrong=
, it just
> > > > does not allow to exploit all hw capabilities available on EN7581 w=
hen the
> > > > traffic is routed from the WAN port to a given DSA switch port.
> > >=20
> > > And I don't believe it should, in this way.
> >=20
> > Can you please elaborate on this? IIUC it seems even Oleksij has a use-=
case
> > for this.
>=20
> See above, I'm also waiting for Oleksij's answer but I don't expect you
> 2 to be talking about the same thing. If there's some common infrastructu=
re
> to be shared, my understanding is it has nothing to do with ndo_setup_tc_=
conduit().

ack

>=20
> > > We need something as the root Qdisc of the conduit which exposes its
> > > hardware capabilities. I just assumed that would be a simple (and sin=
gle)
> > > ETS, you can correct me if I am wrong.
> > >=20
> > > On conduit egress, what is the arbitration scheme between the traffic
> > > destined towards each DSA user port (channel, as the driver calls the=
m)?
> > > How can this be best represented?
> >=20
> > The EN7581 supports up to 32 different 'channels' (each of them support=
 8
> > different hw queues). You can define an ETS and/or TBF Qdisc for each c=
hannel.
> > My idea is to associate a channel to each DSA switch port, so the user =
can
> > define independent QoS policies for each DSA ports (e.g. shape at 100Mb=
ps lan0,
> > apply ETS on lan1, ...) configuring the mac chip instead of the hw swit=
ch.
> > The kernel (if the traffic is not offloaded) or the PPE block (if the t=
raffic
> > is offloaded) updates the channel and queue information in the DMA desc=
riptor
> > (please take a look to [0] for the first case).
>=20
> But you call it a MAC chip because between the GDM1 and the MT7530 there's
> an in-chip Ethernet MAC (GMII netlist), with a fixed packet rate, right?

With "mac chip" I mean the set of PSE/PPE and QDMA blocks in the diagram
(what is managed by airoha_eth driver). There is no other chip in between
of GDM1 and MT7530 switch (sorry for the confusion).

> I'm asking again, are the channels completely independent of one another,
> or are they consuming shared bandwidth in a way that with your proposal
> is just not visible? If there is a GMII between the GDM1 and the MT7530,
> how come the bandwidth between the channels is not shared in any way?

Channels are logically independent.
GDM1 is connected to the MT7530 switch via a fixed speed link (10Gbps, simi=
lar
to what we have for other MediaTek chipset, like MT7988 [0]). The fixed lin=
k speed
is higher than the sum of DSA port link speeds (on my development boards I =
have
4 DSA ports @ 1Gbps);

> And if there is no GMII or similar MAC interface, we need to take 100
> steps back and discuss why was the DSA model chosen for this switch, and
> not a freeform switchdev driver where the conduit is not discrete?
>=20
> I'm not sure what to associate these channels with. Would it be wrong to
> think of each channel as a separate DSA conduit? Because for example there
> is API to customize the user port <-> conduit assignment.
>=20
> > > IIUC, in your patch set, you expose the conduit hardware QoS capabili=
ties
> > > as if they can be perfectly virtualized among DSA user ports, and as =
if
> > > each DSA user port can have its own ETS root Qdisc, completely indepe=
ndent
> > > of each other, as if the packets do not serialize on the conduit <-> =
CPU
> > > port link, and as if that is not a bottleneck. Is that really the cas=
e?
> >=20
> > correct
>=20
> Very interesting but will need more than one word for an explanation :)

I mean your paragraph above well describes hw architecture.

>=20
> > > If so (but please explain how), maybe you really need your own root Q=
disc
> > > driver, with one class per DSA user port, and those classes have ETS
> > > attached to them.
> >=20
> > Can you please clarify what do you mean with 'root Qdisc driver'?
>=20
> Quite literally, an implementer of struct Qdisc_ops whose parent can
> only be TC_H_ROOT. I was implying you'd have to create an abstract
> software model of the QoS capabilities of the QDMA and the GDM port such
> that we all understand them, a netlink attribute scheme for configuring
> those QoS parameters, and then a QoS offload mechanism through which
> they are communicated to compatible hardware. But let's leave that aside
> until it becomes more clear what you have.
>=20

ack, fine.

Regards,
Lorenzo

[0] https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/file=
s-6.6/arch/arm64/boot/dts/mediatek/mt7988a.dtsi#L1531

--APQ17BrPyud3HNQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ2FAUQAKCRA6cBh0uS2t
rNWJAQC2TX2a8UedAxuGvvMdEIq0ypTIq2993JgkRtFyPlpl4wD/UntEScaaAywH
nu18YuD9E9C24UCuYP8QA+aIG++EYQc=
=xU0B
-----END PGP SIGNATURE-----

--APQ17BrPyud3HNQ8--


