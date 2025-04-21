Return-Path: <netdev+bounces-184472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D137A95971
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E7C176BCA
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02907224AFB;
	Mon, 21 Apr 2025 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXJUjcVD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218921B9D9;
	Mon, 21 Apr 2025 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274560; cv=none; b=E+ik+mE9/i+N/HS+1v+cBfRtCVt1BgCT3jlpdgOWVyk7f9xoG2dBRJz+6RLlzcSK46g/LYbJOOh6Y8f+EadAGVgIZe8TnycHuF7vCp7SMNT98SmqgXx72WkNBtTj1r+6EvQs8NBxZdmrFltYbscRP3X8sYLxRYiV/zH7cwCAjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274560; c=relaxed/simple;
	bh=b8KH1FAUb9EGzQMvKP4UFOGpbgRKt1En9MMbqwCtNWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U525QGIqN3Enf34abtSd+yFmkkrtVeQ9YkX9V0iLadxzyRUdau8JnaQ8GxrjAFSdnFxnThBtGXrqND1qEneWaXtDBDmdKa8gJHZy0AuGxvJdV7+d7K0vj55hK1ZPumSqenSLfgjvbghFr3M4xasBU/MfT0MFOF2K7d0kkxN3QIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXJUjcVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ADFC4CEEC;
	Mon, 21 Apr 2025 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274560;
	bh=b8KH1FAUb9EGzQMvKP4UFOGpbgRKt1En9MMbqwCtNWw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dXJUjcVDD9BZBmW9oa16k0xpfI4GEdupIjzeuiUnm+nUXn7AtsiMe861oHWsWqHp8
	 nj7pn4yNZXWe8ky3qV87Bkp9LofehU350/ium1uWiyJaOnFciF622/W0nOFxPjh/CS
	 ToYjC1nqU+nqOctbF0ULcT2YWqjBYhF9/U7O9Re9S6vl8TBjcVlRes+gYjoZgx4S9u
	 4fQ7tq406b4aQJUbc+yDd1uONY2Rx21Mj0UzVcX93W0LI7GNyGa/+eqfmgsNupZs1J
	 z+O01vQfuqZCFlJNaSHtb4lw8kl+zXnMneZaq45k1rYyDYCQOuRDXvgHuF50hKiukA
	 tyUkIYsVm5pEg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso6854967a12.0;
        Mon, 21 Apr 2025 15:29:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhwE2jW1S3YrCIE2t/8y1QkG+LR4wT9+YPRRZf0RSM0Vi/Mv1m1vpyoT3i6Is2FkMNbZ8e799AEN+BRn9NasFI@vger.kernel.org, AJvYcCVU4AAKkQCoYsXe4R7zHkpv2p+gcxMqglObZouBJg88fYwjGB/oaZbQRdizkwCv5HLEgfhV7FKysR5I@vger.kernel.org, AJvYcCXSvufwh3KlicTp7Y+Sysl2wfdefD4EfXC0HQJvt2dE0EwKfPLEaOO2yCIIkwOBpr/EQ2cg5Igu1IbHL2nk@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJKKFSSho1E5T2ZOSlDMLunbYfyklsY+QMyyL19lAHHNc5Qxm
	72Q8WtEHzRY9FdSKQeztK525OuRqwzW17J0ouFhqMoqx/Pc+oIevIm0RT/E89zhktm64lCpdNOj
	TC2v6e8ZN+mWQBqNdfhCoju2hqg==
X-Google-Smtp-Source: AGHT+IFP3YpF5XTgHYYVhg6D5kBY3MEsEFzrvX/jgOwvWAKhilsAGtPagJ2qxpTp18NV9oKeZoB+9CV1BXnKR0Zm6AU=
X-Received: by 2002:a17:907:1ca0:b0:ac7:150b:57b2 with SMTP id
 a640c23a62f3a-acb74db61d8mr1231535566b.41.1745274559272; Mon, 21 Apr 2025
 15:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416162144.670760-1-ivecera@redhat.com> <20250416162144.670760-2-ivecera@redhat.com>
 <20250421222025.GA3015001-robh@kernel.org>
In-Reply-To: <20250421222025.GA3015001-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 21 Apr 2025 17:29:07 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+WqMNBcQgN0wL6wt-+=YXRTE=bYd+Awfe4L6RE0y-vVw@mail.gmail.com>
X-Gm-Features: ATxdqUGPzjCNN4U_Hdsbb32xQq-ridxzv-u-UbVYEh-kmoiPPUb3BIUXDP3GQ1s
Message-ID: <CAL_Jsq+WqMNBcQgN0wL6wt-+=YXRTE=bYd+Awfe4L6RE0y-vVw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/8] dt-bindings: dpll: Add device tree
 bindings for DPLL device and pin
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Schmidt <mschmidt@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 5:20=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Apr 16, 2025 at 06:21:37PM +0200, Ivan Vecera wrote:
> > Add a common DT schema for DPLL device and associated pin.
> > The DPLL (device phase-locked loop) is a device used for precise clock
> > synchronization in networking and telecom hardware.
>
> In the subject, drop 'device tree binding for'. You already said that
> with 'dt-bindings'.
>
> >
> > The device itself is equipped with one or more DPLLs (channels) and
> > one or more physical input and output pins.
> >
> > Each DPLL channel is used either to provide pulse-per-clock signal or
> > to drive ethernet equipment clock.
> >
> > The input and output pins have a label (specifies board label),
> > type (specifies its usage depending on wiring), list of supported
> > or allowed frequencies (depending on how the pin is connected and
> > where) and can support embedded sync capability.
>
> Convince me this is something generic... Some example parts or
> datasheets would help. For example, wouldn't these devices have 1 or
> more power supplies or a reset line?

Never mind, I read the next patch...

>
> >
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > ---
> > v1->v3:
> > * rewritten description for both device and pin
> > * dropped num-dplls property
> > * supported-frequencies property renamed to supported-frequencies-hz
> > ---
> >  .../devicetree/bindings/dpll/dpll-device.yaml | 76 +++++++++++++++++++
> >  .../devicetree/bindings/dpll/dpll-pin.yaml    | 44 +++++++++++
> >  MAINTAINERS                                   |  2 +
> >  3 files changed, 122 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.=
yaml
> >  create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yam=
l
> >
> > diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b/=
Documentation/devicetree/bindings/dpll/dpll-device.yaml
> > new file mode 100644
> > index 0000000000000..11a02b74e28b7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dpll/dpll-device.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Digital Phase-Locked Loop (DPLL) Device
> > +
> > +maintainers:
> > +  - Ivan Vecera <ivecera@redhat.com>
> > +
> > +description:
> > +  Digital Phase-Locked Loop (DPLL) device is used for precise clock
> > +  synchronization in networking and telecom hardware. The device can
> > +  have one or more channels (DPLLs) and one or more physical input and
> > +  output pins. Each DPLL channel can either produce pulse-per-clock si=
gnal
> > +  or drive ethernet equipment clock. The type of each channel can be
> > +  indicated by dpll-types property.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^dpll(@.*)?$"
>
> There's no 'reg' property, so you can't ever have a unit-address. I
> suppose you can have more than 1, so you need a '-[0-9]+' suffix.

And forget this too.

Rob

