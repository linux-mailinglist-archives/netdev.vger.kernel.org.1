Return-Path: <netdev+bounces-220998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A86B49D16
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BF84E7377
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A112E92B0;
	Mon,  8 Sep 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzV25RQW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEE1EB5CE;
	Mon,  8 Sep 2025 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371782; cv=none; b=fsDn4p+Sk0vl/ar14XhZ+Kq2GWU/OtzvtQvRrqPSSDGq6lQNwz+QVbcoLvHHd4C4sH5KsO6QpAafU9DdSuorieIvwCS3Bjv2LiDemGwHcEt+rnDIbU7Tbt96d1n+F5zykfvrKqSt9Wacu7ZRKCGE8UhCIfe9OhBl6wyDQ4v7Vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371782; c=relaxed/simple;
	bh=lnwnrrjuGfO0mxaFVDsCYUrjF7eAtqYJcIxxxfw8O5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgX9NZA2O7yuCNy9nrHXXqkkg3Iox1K9VBc+eNUzNe3ADiZnNRlscgyzuvt0wPjnhsGyw5BGCIL5oKn53MpCvTKimBIxdC0Rdn0hTNgQksUhZPkBryOSh0kKOw9uUj26Fh3+r8dUxVtamqhaegYPUDhUpfDVIPtpyvs9ne+3jYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzV25RQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26F8C4CEF8;
	Mon,  8 Sep 2025 22:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757371782;
	bh=lnwnrrjuGfO0mxaFVDsCYUrjF7eAtqYJcIxxxfw8O5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qzV25RQW+MgDi/hpupASciblnRwvwak6iSKey3VOtSYLukUwHI7fR+zUx1QST/x2Q
	 6Em65Qfmn9/B4CzRdBo4+nd087sFEkJ5vfUGT4P2m+dbzUkPa8YxqP7boAFnn7uXt3
	 gTVEUZiV8K3eTb/9xPfhX4fJK+mAbHPXs5CvfpNnFKONpFSW6Pd59zpCNXJoxekD2F
	 hHDw5zXZe8hbKbKOu4Tu6MF4LvuhP7Xdr57eX8HWZOJNUeOSx/f5AjqufnoLeTt0UY
	 Caev8zFMYNQo3OPQSgsaNYEib6Q/FIu7A+t68dAgynSZVLzRLAoaiXJ5mbl91LGTw9
	 s61gtcduRHBBA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so7256013a12.0;
        Mon, 08 Sep 2025 15:49:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaSooCDTOU1zVGzpWGZLPmWlbDTyDInf/52pHzr4TOutLBVsYrIWvv08omtK8M1777NGJSBKO6IY92VPcO@vger.kernel.org, AJvYcCWymyU//5CocjfYWdwKiLuPlnOxqU3z4SMIb8eUmQl9DKnvuJfDLPu5OSxTEDwp+N2Mwz/cblm5Y8o5@vger.kernel.org
X-Gm-Message-State: AOJu0YzsCfkuE2MDNRTpMGVVLwBimx7E9CZqvY2r3vPSbXbZDf+0rl/z
	pDV6zr7H0PrgcuDlfvWvGgoxBd3+l/iDpqEp2uH/9tgwVZ4IwbqKKY1gQBRielxAobXjy8Hc1Lx
	gK8kYWR2bsxRzispl3hfo+1oDWDNWSQ==
X-Google-Smtp-Source: AGHT+IGHw+8G7L+ArmhFoRRdE1FV4g1i7ErMbY/OfAAY/uLB+PGTF8jRNyhPKgW/7xBDt1d7qcOsXVSoBcTc1Gd368Q=
X-Received: by 2002:a05:6402:3484:b0:61e:8f70:ee26 with SMTP id
 4fb4d7f45d1cf-62379b825a1mr8384508a12.38.1757371780463; Mon, 08 Sep 2025
 15:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815144736.1438060-1-ivecera@redhat.com> <20250820211350.GA1072343-robh@kernel.org>
 <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com> <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
 <bc39cdc9-c354-416d-896f-c2b3c3b64858@redhat.com>
In-Reply-To: <bc39cdc9-c354-416d-896f-c2b3c3b64858@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Sep 2025 17:49:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL5wQ+0Xcdo5T3FTyoa2csQ9aW8ZxxMxVOhRJpzc7fGhA@mail.gmail.com>
X-Gm-Features: AS18NWAxhYNwJ56vsQfUczkl_R9TNuNktlxc2midcWQWDd56JDmUw5T0m2c6T2w
Message-ID: <CAL_JsqL5wQ+0Xcdo5T3FTyoa2csQ9aW8ZxxMxVOhRJpzc7fGhA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, mschmidt@redhat.com, poros@redhat.com, 
	Andrew Lunn <andrew@lunn.ch>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:50=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> wro=
te:
>
>
>
> On 05. 09. 25 12:06 dop., Rob Herring wrote:
> > On Fri, Aug 29, 2025 at 8:29=E2=80=AFAM Ivan Vecera <ivecera@redhat.com=
> wrote:
> >> ...
> >>
> >> Do you mean to add a property (e.g. dpll-channel or dpll-device) into
> >> net/network-class.yaml ? If so, yes, it would be possible, and the way
> >> I look at it now, it would probably be better. The DPLL driver can
> >> enumerate all devices across the system that has this specific propert=
y
> >> and check its value.
> >
> > Yes. Or into ethernet-controller.yaml. Is a DPLL used with wifi,
> > bluetooth, etc.?
>
> AFAIK no... ethernet-controller makes sense.
>
> >>
> >> See the proposal below...
> >>
> >> Thanks,
> >> Ivan
> >>
> >> ---
> >>    Documentation/devicetree/bindings/dpll/dpll-device.yaml  | 6 ++++++
> >>    Documentation/devicetree/bindings/net/network-class.yaml | 7 ++++++=
+
> >>    2 files changed, 13 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >> b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >> index fb8d7a9a3693f..560351df1bec3 100644
> >> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >> @@ -27,6 +27,12 @@ properties:
> >>      "#size-cells":
> >>        const: 0
> >>
> >> +  "#dpll-cells":
> >> +    description: |
> >> +      Number of cells in a dpll specifier. The cell specifies the ind=
ex
> >> +      of the channel within the DPLL device.
> >> +    const: 1
> >
> > If it is 1 for everyone, then you don't need a property for it. The
> > question is whether it would need to vary. Perhaps some configuration
> > flags/info might be needed? Connection type or frequency looking at
> > the existing configuration setting?
>
> Connection type maybe... What I am trying to do is define a relationship
> between the network controller and the DPLL device, which together form
> a single entity from a use-case perspective (e.g., Ethernet uses an
> external DPLL device either to synchronize the recovered clock or to
> provide a SyncE signal synchronized with an external 1PPS source).
>
> Yesterday I was considering the implementation from the DPLL driver's
> perspective and encountered a problem when the relation is defined from
> the Ethernet controller's perspective. In that case, it would be
> necessary to enumerate all devices that contain a =E2=80=9Cdpll=E2=80=9D =
property whose
> value references this DPLL device.

Why is that?

>
> This approach seems quite complicated, as it would require searching
> through all buses, all connected devices, and checking each fwnode for a
> =E2=80=9Cdpll=E2=80=9D property containing the given reference. I don=E2=
=80=99t think this would
> be the right solution.

for_each_node_with_property() provides that. No, it's not efficient,
but I doubt it needs to be. As you'd only need to do it once.

> I then came across graph bindings and ACPI graph extensions, which are
> widely used in the media and DRM subsystems to define relations between
> devices. Would this be an appropriate way to define a binding between an
> Ethernet controller and a DPLL device?

Usually the graph is used to handle complex chains of devices and how
the data flows. I'm not sure that applies here.

> If so, what would such a binding roughly look like? I=E2=80=99m not very
> experienced in this area, so I would appreciate any guidance.
>
> If not, wouldn=E2=80=99t it be better to define the relation from the DPL=
L
> device to the network controller, as originally proposed?

I have no idea really. I would think the DPLL is the provider and an
ethernet device is the consumer. And if the ethernet device is unused
(or disabled), then the DPLL connection associated with it is unused.
If that's the case, then I think the property belongs in the ethernet
node.

Rob

