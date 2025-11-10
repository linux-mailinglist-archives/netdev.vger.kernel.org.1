Return-Path: <netdev+bounces-237179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D5C46A24
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95993A161F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BD030E0C5;
	Mon, 10 Nov 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="x76XhTkw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731023EA88
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778245; cv=none; b=fW2N92rW4ycipQ1nPjA6vhuHQt1plVbYgNJl73XpPmd+lbA6HCJ1yZbroHaJSZwA+KWwGETmZNHkZ/T9LHClzbITDk7qWwENdcW7FoZhkSmXjeVFX4p1ulKDrNqa2B7Trt0CDsmVuWacZk3GuA4q4NimVx+ewGahSHJptfwiKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778245; c=relaxed/simple;
	bh=DEySSnbf6pYP54dW9sTqUDBM3FZFHwfqhe80nyGUkWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAnq6pDGz/0Cs6SNszDsjaNvzZYsPC4MAbGTDjhiNYqeez8A11nPLb8rW1EeID8f3NfNbJJ8TwXfNicKSCkGchUWYHIm30xD0IWhXABZKU8U8W36CywNKsP9jLp5HkXAmXxkBDFQqoT4QWhlgCzwWOD5tDaPoAceqs/1tYc//DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=x76XhTkw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b5a8184144dso382339466b.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1762778241; x=1763383041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdbKsB+tMJvagrMvYHn0y49jacarMu1zTyH+h0jj2wI=;
        b=x76XhTkwe8Z5f94q1tzj4Q6PQrWFNBf8DOiJEHRXGu9gLYxuzo2nJ4Iw6m5nk2zcj6
         oGhc39FfD96vtf7gncSZZa6Hj0zjub/sLhZFTpHgyfAnXwK7Fgktsr4pQYHJc2JUqyo2
         B+Jg+qAGEK/PFDXR3N+x2BFZtsU2A3hoFDgAy4EsddUIWhl47u3eN24vZN4X60DYjffT
         pv3jx+Idb5ouO9TJVFR8Y0EF9ZcE1Q6cWOjcsj15tuqYvzsaT90hkqK6WqppSdvhS8Wk
         wU8XU4GtGUXyGCkrresdXJLzuQRUmrWQLfrKSmSbja7WZIc37r2O0BnbiiP9aWOTCHcY
         6lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778241; x=1763383041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cdbKsB+tMJvagrMvYHn0y49jacarMu1zTyH+h0jj2wI=;
        b=GAiBrBe7WjUxIbXWTG6VzWqJAD5HGFXFdkaJSxlGa2RmuATe3Y+FzvTJi6JzwtMHyT
         TYlnYSRts8Qf0q/g4km16HlqQusD8RYuaYKKwHaN9RZdfd6afnz0s/hAwd3s1pWZSRhN
         00c0PGJjQvNCrYlAdSZrUMsuxA5KCShJ3yommadWIjR2TzQjL69sqaTu+8bpbot1YSdh
         bQK7KxXiP4dRYFiwK9VwpYLhn3ZqrbutJjWEzqfQmexB0ZT5Pbf2O53AricZwKSJ+p7S
         4hmqxoCNpXxO19w5Z3hbvfiqqkWCQadFkORTq3guhIkdiZgi5lquFqrg2gCBuTCQW93O
         ti5A==
X-Forwarded-Encrypted: i=1; AJvYcCUFqbdLbpTMw/3rdwB9iR/lWosaZz6vEcUJ6jqW+csmRDa17ay3iroKaffKx/TF8tbzb8XcK1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzuJHu8s1xt1XA+heCe/xaNHg0RxGoylGWBM/Rgkpb+rOiB0s
	4xRvRRYYjki6b853e3cvZRDZYJivAJJTyKTFjWC/652RvFRj/9Lm9qokSdCFJJ9iBxG65ivmBhJ
	vHbLPV3QYvIcSyWRmWcXuyNoU9VTfCQjiZHGOeoJu7Q==
X-Gm-Gg: ASbGncurJiNNDyZlHMfL7STLt+266EBqU5NEjwc7/Vr4bpXXrhp3pL8rsCXaZD+Pv/4
	ZOeDaYZ0Q0K5p7cDErRCBCW6n8O0nNW4psKj4cgqIHx0uhne9J19KWaUOPfUg7mAmuByCOe3Xai
	Azuk23YXrCdBYchtLZ0Qpa8KBGvHzlVMS4reINwof9hKNqV0ArFueesJShcrc336UVab1+NTGME
	Cu44AgJKWmIVh2eShx8kV8gPDO6FfzrK5W8Qs8mUZDDB9oTXNipekx53RcQHtsVn5nrfEs=
X-Google-Smtp-Source: AGHT+IE8R0GEPpZSZEercv3oXNopblQ2LRLU4GoX8SS8pCTS+917rMgdDv/cyw05AUmS6nbzIs8krxRmiMby2Y3ip8U=
X-Received: by 2002:a17:906:eecc:b0:b72:dc33:3d36 with SMTP id
 a640c23a62f3a-b72e056d8e5mr574165066b.49.1762778241054; Mon, 10 Nov 2025
 04:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141936.1085679-1-robert.marko@sartura.hr> <20251110065701.rch4wjflap3vicjq@DEN-DL-M70577>
In-Reply-To: <20251110065701.rch4wjflap3vicjq@DEN-DL-M70577>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 10 Nov 2025 13:37:08 +0100
X-Gm-Features: AWmQ_bnmKGMttOuykPTnFw9koAKzfig9Ix0aGoP1qnMvwkAAXQmuYEVNFMiaUPs
Message-ID: <CA+HBbNESaT7SfgJPE-MTQphDQc+vcZUBn5mV+yFq_iqk+PcakA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sparx5/lan969x: populate netdev of_node
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 7:57=E2=80=AFAM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> Hi Robert,
>
> > Populate of_node for the port netdevs, to make the individual ports
> > of_nodes available in sysfs.
>
> Sounds reasonable :-)
>
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/dr=
ivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > index 1d34af78166a..284596f1da04 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
> > @@ -300,7 +300,11 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
> >
> >         for (portno =3D 0; portno < sparx5->data->consts->n_ports; port=
no++)
> >                 if (sparx5->ports[portno]) {
> > -                       err =3D register_netdev(sparx5->ports[portno]->=
ndev);
> > +                       struct net_device *port_ndev =3D sparx5->ports[=
portno]->ndev;
>
> This line exceeds 80 chars and can easily be wrapped.
>
> > +
> > +                       port_ndev->dev.of_node =3D sparx5->ports[portno=
]->of_node;
> > +
> > +                       err =3D register_netdev(port_ndev);
> >                         if (err) {
> >                                 dev_err(sparx5->dev,
> >                                         "port: %02u: netdev registratio=
n failed\n",
> > --
> > 2.51.1
> >
>
> It seems wrong to me to stuff this into sparx5_register_netdevs() - there=
 are
> two better candidates, either: sparx5_create_netdev (where other ndev var=
iables
> are assigned) or sparx5_create_port().


Yeah, I indeed overcomplicated this compared to setting it directly in
sparx5_create_port().
I will update this in v2.

Regards,
Robert
>
>
> /Daniel



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

