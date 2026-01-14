Return-Path: <netdev+bounces-249669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F6D1C16B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9006300F279
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50832F260E;
	Wed, 14 Jan 2026 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQQo3i0k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD8E555
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356308; cv=none; b=upNxAvCcsESQ65doxpbgAhqDqDHeIdCEIFenfhuL2N01FagQGCgR92YhzlQPzfLRoFFkVrPnBnskIU0FFnNXgxRxnmQcoRyjOR48ZsxmpL4whfHnQRxVJrsYZDH2tL0psrpmdPGe/zymPP35kd14WRDnzyj5PrHAqqcadDgFwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356308; c=relaxed/simple;
	bh=SOqcKxAXNbSdEcywpH2tweVIQ706P7fQ36Acj80r9E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLcnXykwy/Z4gc457TGC/b9m7Bp6nz+UB2Z7GrxKVaAx8iWbw/OZ2GXNhGViE85SxKXTzmw0MOlABct9yUE97sdpLnB3ng4UYS3TXpgcLyB4AH/o8PL/EP2ZaUFac2UaAvBurzJrHQ4493HRrHWMDjZ/swSlGoH+LUXZt7H2HIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQQo3i0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C15FC2BCB1
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768356308;
	bh=SOqcKxAXNbSdEcywpH2tweVIQ706P7fQ36Acj80r9E8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GQQo3i0klccdMwJmToXV8lborVNCPyN55ZULpxrWDc4oFbgth4xn5o5Oqvf6izuo/
	 UBS0nZlK48Ut6gNlXLBYK0PnNC04qwCYXPBLk7o7iTNEotJ5Lbzbo9TTae16RrQN5S
	 Clu2JFlQc+Ja1QSvTEskO4drUGc5CqKd6nwta8Ka4O9b2JJVPWUqZfqd0Vi6/yqPKx
	 ThSZclTO2O/9qH38PTaCo57+hhEEwQZ1bwnU6hIFv7ZebfHKzdRLOuJA4V5kiv6NJ+
	 Zavkyevn56RFMnmPZcWYReYM34gFwSSN/0rblL4tydIxZTqMUADZc+q34SZoMuc1vD
	 nvCXZMghw0vMQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-652fec696c9so2639524a12.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:05:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsjwIYrN3P2nbZuI2okmcMXrnLTUyK1okJRHnGaxklMGLxCv0G3TyTKgWEyQWPTFihyQCRHMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3Itk9lYjVLot4KJKed9n8KTHejl29+gIt1itVMX2b/zEkVWu
	FiOsCBy+HN5Z/1WA2Kb7sqllnPuKR33vLVKbkYHrxc6tp+vXyr3xYKGuv+8/Cjd4mFicD6vaS5Y
	+cVSoC2X7VtYrujDc8knZeMx1f57c4Q==
X-Received: by 2002:a17:907:c24:b0:b87:1d30:7ec with SMTP id
 a640c23a62f3a-b87677a7f7fmr25999566b.37.1768356306546; Tue, 13 Jan 2026
 18:05:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107090019.2257867-1-alexander.sverdlin@siemens.com>
 <20260107090019.2257867-2-alexander.sverdlin@siemens.com> <20260113164128.GA3919887-robh@kernel.org>
 <aWZ57fz3EiwuXh6Y@makrotopia.org>
In-Reply-To: <aWZ57fz3EiwuXh6Y@makrotopia.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Jan 2026 20:04:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJyCPnSMeJ9y_qQcAgVqU6YtoXXKWB6h4REyJkrxoG73g@mail.gmail.com>
X-Gm-Features: AZwV_Qh9EWI4sjYgMniS7FHt70isAZelUpH3TgUlIv5Sfe7decupJwGGZPPwOvQ
Message-ID: <CAL_JsqJyCPnSMeJ9y_qQcAgVqU6YtoXXKWB6h4REyJkrxoG73g@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 MaxLinear R(G)MII slew rate
To: Daniel Golle <daniel@makrotopia.org>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>, netdev@vger.kernel.org, 
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:59=E2=80=AFAM Daniel Golle <daniel@makrotopia.or=
g> wrote:
>
> On Tue, Jan 13, 2026 at 10:41:28AM -0600, Rob Herring wrote:
> > On Wed, Jan 07, 2026 at 10:00:16AM +0100, A. Sverdlin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > >
> > > Add new maxlinear,slew-rate-txc and maxlinear,slew-rate-txd uint32
> > > properties. The properties are only applicable for ports in R(G)MII m=
ode
> > > and allow for slew rate reduction in comparison to "normal" default
> > > configuration with the purpose to reduce radiated emissions.
> > >
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > ---
> > > Changelog:
> > > v4:
> > > - separate properties for TXD and TXC pads ("maxlinear," prefix re-ap=
pears)
> > > v3:
> > > - use [pinctrl] standard "slew-rate" property as suggested by Rob
> > >   https://lore.kernel.org/all/20251219204324.GA3881969-robh@kernel.or=
g/
> > > v2:
> > > - unchanged
> > >
> > >  .../devicetree/bindings/net/dsa/lantiq,gswip.yaml  | 14 ++++++++++++=
++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.y=
aml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > index 205b683849a53..747106810cc17 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > @@ -106,6 +106,20 @@ patternProperties:
> > >          unevaluatedProperties: false
> > >
> > >          properties:
> > > +          maxlinear,slew-rate-txc:
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > +            enum: [0, 1]
> >
> > default: 0
>
> Not really. The default is not to touch the register value which may
> have already been setup by the bootloader.

Okay, please add that to the description.

Rob

