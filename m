Return-Path: <netdev+bounces-220166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AF2B44946
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE3EAA5249
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4822E3397;
	Thu,  4 Sep 2025 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDGRrFQy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7E2E2F1A;
	Thu,  4 Sep 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023622; cv=none; b=ZrkdSp11eVIQnQxfuai5tGakwGftTAYzTuosZLfUlOTGkZa+cn3h7U91sSbf4WjQr1jELsjToXg+UplwVdVXdF0IdsywbJSX9m0hY/z1ocy6w5B7CUAZq5eWem9FVErMnqdz3JFP+q+OPCRW7i9VD+vyH8TJav7WOEN6/HIdCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023622; c=relaxed/simple;
	bh=jJhRUuO/5DksvNEh02TanYPo+USrmlI2eOgLzi4mPFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqvNQ9maIvxak/zNAfIUTy4iWyu5oLoBW8a5B8K8+naW1khtfBPedvU7o5ootgzCe+LrtT0vVjefIMPfBSkH2H29Zl5G83SX/LE2QpU8vUFTskYwJeOApHoUwJvHu5+XX9WPSVjUanoely58YDkehanE9jQIflhtu3tLyLWx7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDGRrFQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9796C4CEF0;
	Thu,  4 Sep 2025 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757023621;
	bh=jJhRUuO/5DksvNEh02TanYPo+USrmlI2eOgLzi4mPFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kDGRrFQytiXE5Ip6YxTa0R0mkMN5RaF9UTszBwoFZtJnkO1V/EoecRbaGxKF/ET4F
	 FPcLYBtr9F+CHIflB8qfiKS/bHBOKFG8Ikm+bOYiwanbskT52gvpIVoAQioRhIRESj
	 oPIy+k5tg40MdhJBOsWZ/jpvPxEm/3QxQc50aJQucHQjnhNmjdlJltultYDHFIFs98
	 szz5/d44JMXWUpAO2kc8//+WYcJ3rwHLlv6lxAysPBfQh0jQa009nuGzoKKLs0pusG
	 LdiHrafda5JQh6sgdFUQc7Zi16Mj9HI1nNyweF22ireYdqnU407EXEOo/Pl1/xBO7d
	 yzaiwabt7rwxQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b045d56e181so222170166b.2;
        Thu, 04 Sep 2025 15:07:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZZ9UHTu071T5Ex0r/ig/BtpfC3jB1J8aZctP5qy0r/y9NeD1E0yArFLJDCVJXwZgrxCnASF+oryQJkC9f@vger.kernel.org, AJvYcCXucovPLwetTlKrpJElWGg4NGw10IKMate5WrE+yR/4eivtt9X9zJSZl9KUcheMVS+1EWleWGCEseYp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hdb5HUSKaNmcrGGj6/2F/TxOLJiqCA7agprRS/oCvsMBE+u7
	KHKMjoKyQ29q0xUGPaOTpxx7LM+I7RwFVgNHik6iKFhlkQWIJhve9lfSRJt0VicDuu2QU2ydewo
	/2txmABrZM4zY86BuZC9CGuUa7FjEwA==
X-Google-Smtp-Source: AGHT+IFPU86J5q2os3DqVwm6OQaIRkb2uYTcTl4ECKidm6RB8z6xN09U8ImNFZgAVv9Nyn09Omd/IqLY/RP2kNmAtGk=
X-Received: by 2002:a17:906:7308:b0:b04:616c:d762 with SMTP id
 a640c23a62f3a-b04616cdf1fmr904842166b.0.1757023620219; Thu, 04 Sep 2025
 15:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815144736.1438060-1-ivecera@redhat.com> <20250820211350.GA1072343-robh@kernel.org>
 <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
In-Reply-To: <5e38e1b7-9589-49a9-8f26-3b186f54c7d5@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Sep 2025 17:06:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
X-Gm-Features: Ac12FXzrq6H3317mJJXy9VKhjd67b1NEF52ll39fJK2DNVneuUd7QWVkJXMJpLI
Message-ID: <CAL_JsqKui29O_8xGBVx9T2e85Dy0onyAp4mGqChSuuwABOhDqA@mail.gmail.com>
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

On Fri, Aug 29, 2025 at 8:29=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> Hi Rob,
>
> On 20. 08. 25 11:13 odp., Rob Herring wrote:
> > On Fri, Aug 15, 2025 at 04:47:35PM +0200, Ivan Vecera wrote:
> >> In case of SyncE scenario a DPLL channels generates a clean frequency
> >> synchronous Ethernet clock (SyncE) and feeds it into the NIC transmit
> >> path. The DPLL channel can be locked either to the recovered clock
> >> from the NIC's PHY (Loop timing scenario) or to some external signal
> >> source (e.g. GNSS) (Externally timed scenario).
> >>
> >> The example shows both situations. NIC1 recovers the input SyncE signa=
l
> >> that is used as an input reference for DPLL channel 1. The channel loc=
ks
> >> to this signal, filters jitter/wander and provides holdover. On output
> >> the channel feeds a stable, phase-aligned clock back into the NIC1.
> >> In the 2nd case the DPLL channel 2 locks to a master clock from GNSS a=
nd
> >> feeds a clean SyncE signal into the NIC2.
> >>
> >>                 +-----------+
> >>              +--|   NIC 1   |<-+
> >>              |  +-----------+  |
> >>              |                 |
> >>              | RxCLK     TxCLK |
> >>              |                 |
> >>              |  +-----------+  |
> >>              +->| channel 1 |--+
> >> +------+        |-- DPLL ---|
> >> | GNSS |---------->| channel 2 |--+
> >> +------+  RefCLK   +-----------+  |
> >>                                |
> >>                          TxCLK |
> >>                                |
> >>                 +-----------+  |
> >>                 |   NIC 2   |<-+
> >>                 +-----------+
> >>
> >> In the situations above the DPLL channels should be registered into
> >> the DPLL sub-system with the same Clock Identity as PHCs present
> >> in the NICs (for the example above DPLL channel 1 uses the same
> >> Clock ID as NIC1's PHC and the channel 2 as NIC2's PHC).
> >>
> >> Because a NIC PHC's Clock ID is derived from the NIC's MAC address,
> >> add a per-channel property 'ethernet-handle' that specifies a referenc=
e
> >> to a node representing an Ethernet device that uses this channel
> >> to synchronize its hardware clock. Additionally convert existing
> >> 'dpll-types' list property to 'dpll-type' per-channel property.
> >>
> >> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> >> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> >> ---
> >>   .../devicetree/bindings/dpll/dpll-device.yaml | 40 ++++++++++++++++-=
--
> >>   .../bindings/dpll/microchip,zl30731.yaml      | 29 +++++++++++++-
> >>   2 files changed, 62 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml b=
/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >> index fb8d7a9a3693f..798c5484657cf 100644
> >> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >> @@ -27,11 +27,41 @@ properties:
> >>     "#size-cells":
> >>       const: 0
> >>
> >> -  dpll-types:
> >> -    description: List of DPLL channel types, one per DPLL instance.
> >> -    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> >> -    items:
> >> -      enum: [pps, eec]
> >
> > Dropping this is an ABI change. You can't do that unless you are
> > confident there are no users both in existing DTs and OSs.
>
> Get it, will keep.
>
> >> +  channels:
> >> +    type: object
> >> +    description: DPLL channels
> >> +    unevaluatedProperties: false
> >> +
> >> +    properties:
> >> +      "#address-cells":
> >> +        const: 1
> >> +      "#size-cells":
> >> +        const: 0
> >> +
> >> +    patternProperties:
> >> +      "^channel@[0-9a-f]+$":
> >> +        type: object
> >> +        description: DPLL channel
> >> +        unevaluatedProperties: false
> >> +
> >> +        properties:
> >> +          reg:
> >> +            description: Hardware index of the DPLL channel
> >> +            maxItems: 1
> >> +
> >> +          dpll-type:
> >> +            description: DPLL channel type
> >> +            $ref: /schemas/types.yaml#/definitions/string
> >> +            enum: [pps, eec]
> >> +
> >> +          ethernet-handle:
> >> +            description:
> >> +              Specifies a reference to a node representing an Etherne=
t device
> >> +              that uses this channel to synchronize its hardware cloc=
k.
> >> +            $ref: /schemas/types.yaml#/definitions/phandle
> >
> > Seems a bit odd to me that the ethernet controller doesn't have a link
> > to this node instead.
>
> Do you mean to add a property (e.g. dpll-channel or dpll-device) into
> net/network-class.yaml ? If so, yes, it would be possible, and the way
> I look at it now, it would probably be better. The DPLL driver can
> enumerate all devices across the system that has this specific property
> and check its value.

Yes. Or into ethernet-controller.yaml. Is a DPLL used with wifi,
bluetooth, etc.?

>
> See the proposal below...
>
> Thanks,
> Ivan
>
> ---
>   Documentation/devicetree/bindings/dpll/dpll-device.yaml  | 6 ++++++
>   Documentation/devicetree/bindings/net/network-class.yaml | 7 +++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> index fb8d7a9a3693f..560351df1bec3 100644
> --- a/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> +++ b/Documentation/devicetree/bindings/dpll/dpll-device.yaml
> @@ -27,6 +27,12 @@ properties:
>     "#size-cells":
>       const: 0
>
> +  "#dpll-cells":
> +    description: |
> +      Number of cells in a dpll specifier. The cell specifies the index
> +      of the channel within the DPLL device.
> +    const: 1

If it is 1 for everyone, then you don't need a property for it. The
question is whether it would need to vary. Perhaps some configuration
flags/info might be needed? Connection type or frequency looking at
the existing configuration setting?

> +
>     dpll-types:
>       description: List of DPLL channel types, one per DPLL instance.
>       $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> diff --git a/Documentation/devicetree/bindings/net/network-class.yaml
> b/Documentation/devicetree/bindings/net/network-class.yaml
> index 06461fb92eb84..144badb3b7ff1 100644
> --- a/Documentation/devicetree/bindings/net/network-class.yaml
> +++ b/Documentation/devicetree/bindings/net/network-class.yaml
> @@ -17,6 +17,13 @@ properties:
>       default: 48
>       const: 48
>
> +  dpll:
> +    description:
> +      Specifies DPLL device phandle and index of the DPLL channel within
> +      this device used by this network device to synchronize its hardwar=
e
> +      clock.
> +    $ref: /schemas/types.yaml#/definitions/phandle

If you have cells, then this should be phandle-array.

> +
>     local-mac-address:
>       description:
>         Specifies MAC address that was assigned to the network device
> described by
>

