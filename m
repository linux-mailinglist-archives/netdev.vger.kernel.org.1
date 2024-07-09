Return-Path: <netdev+bounces-110308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E13692BCF8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0A71F2381E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF41891CF;
	Tue,  9 Jul 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K33RZZwr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A815749F;
	Tue,  9 Jul 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535601; cv=none; b=HRWU2Q89A2GJ7CuDtTCnUkkxLIL7QOzTD0gPcOw/8Kp/jTXXYG41ApRa/HhG3QwJNQAdtXWv3uke2fHudJfyjqlqmm7tNhErDAePxmiS0agGy7PpJZOPQXpFr4xkaQ3Lge5X50Abi+yFvgxP3BS63cyVy/13yqBFgGRVPmmiM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535601; c=relaxed/simple;
	bh=c7Ar22kn+at+eqcwFycf/zfSHhunW56S94dCSCyjaJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y92NsCdZo5Vp5l2JnsfJi4fLr3ccC6KI+qcLz62X+JeC4CWbaVNposdyK7wM8ZL3vA5ioK3WiI/jGdyEO8qsopRIhRwKao9lPzY7T4NtFSl1owEcTXCEvgU7TzVWHMFtS9hW7FTR0UHBdRrfPnESddb4XjdcTIa+Jy3YaMw4ySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K33RZZwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CE2C32782;
	Tue,  9 Jul 2024 14:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720535600;
	bh=c7Ar22kn+at+eqcwFycf/zfSHhunW56S94dCSCyjaJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K33RZZwrIpUbBdqo7Z0bZ0UNxpvIMKQZt4pdbi/gCOCPEcoNLX6rNFUsZ1DFd4M7O
	 yggCG+ox4iNEJSKX0prT/mbxk2dY3huNv8o73dZWecdt+PrcTUjFx3vATkU4KjAsUx
	 iChkLE+smovoP3mmihg7rAtau4WFMLoeQg0r47CxYsTP4Y1eu9NlZOz1PWqO3iBLug
	 jRx0pA8IBcEVrTer5bzAxJ2MD6hTjYE1DrRC82IKAmh65U6aVFOkViZivCEY+7wVov
	 wXbvvISIQFdEcao/f1j38gg67ju2R9+fRRgNIki/wiwORyq73R6ramXhMXAWcTKOWw
	 ezfP2G43gpeQg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea16b429dso4055439e87.1;
        Tue, 09 Jul 2024 07:33:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgI/oNYuJxiPYKwbzqmJe4eNZS0vOv/wwjm33Ij0pEcMptXFQ94yT5q2Of/GEpe6T0PvfXqrdp2FUK8dAuZaWkxkPcxAYQbIa7Kcm6nu17WSv1OuD5IBwjs/zezgHFMYAYh4vmO/7t8paM3XxcokJrc2kBvR+BnUYEQfw6awW8Fw==
X-Gm-Message-State: AOJu0Yy+moW0F33NYdsp5ZHUfrXVtyDlNhEH0ooEUuwXncRJhlXcfQep
	psNylR5wsImfgTRE5chs62DgIxQ7MBwITrEVYV+WH6xNqLreLHw3YlFx6ySaGqAb9td2vHka2RH
	rDvw9aRlNlJ/sBt7HMkyFXLDe0w==
X-Google-Smtp-Source: AGHT+IHTmviUiixvQG/Xt8fJzFE5DpLTA8M/XoeZDNsC+xg+0GZ0cSOKZpaaZL0C4DtVVM7mEY2q8hFIA8LCOKLUw3A=
X-Received: by 2002:a05:6512:3088:b0:52c:81ba:aeba with SMTP id
 2adb3069b0e04-52eb9d44f6dmr819413e87.14.1720535599235; Tue, 09 Jul 2024
 07:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626162307.1748759-1-Frank.Li@nxp.com> <20240627155547.GB3480309-robh@kernel.org>
 <ZoMn0Pc/agPGKeTS@lizhi-Precision-Tower-5810>
In-Reply-To: <ZoMn0Pc/agPGKeTS@lizhi-Precision-Tower-5810>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Jul 2024 08:33:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJE69akg0WnmaNHYBupSNrktDkOxWHPdQ7h2ZWB8fWGZQ@mail.gmail.com>
Message-ID: <CAL_JsqJE69akg0WnmaNHYBupSNrktDkOxWHPdQ7h2ZWB8fWGZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
To: Frank Li <Frank.li@nxp.com>
Cc: krzk@kernel.org, conor+dt@kernel.org, davem@davemloft.net, 
	devicetree@vger.kernel.org, edumazet@google.com, imx@lists.linux.dev, 
	krzk+dt@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 4:04=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, Jun 27, 2024 at 09:55:47AM -0600, Rob Herring wrote:
> > On Wed, Jun 26, 2024 at 12:23:07PM -0400, Frank Li wrote:
> > > Convert enetc device binding file to yaml. Split to 3 yaml files,
> > > 'fsl,enetc.yaml', 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.
> > >
> > > Additional Changes:
> > > - Add pci<vendor id>,<production id> in compatible string.
> > > - Ref to common ethernet-controller.yaml and mdio.yaml.
> > > - Remove fixed-link part.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v1 to v2
> > > - renamee file as fsl,enetc-mdio.yaml, fsl,enetc-ierb.yaml, fsl,enetc=
.yaml
> > > - example include pcie node
> > > ---
> > >  .../bindings/net/fsl,enetc-ierb.yaml          |  35 ++++++
> > >  .../bindings/net/fsl,enetc-mdio.yaml          |  53 ++++++++
> > >  .../devicetree/bindings/net/fsl,enetc.yaml    |  50 ++++++++
> > >  .../devicetree/bindings/net/fsl-enetc.txt     | 119 ----------------=
--
> > >  4 files changed, 138 insertions(+), 119 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-i=
erb.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-m=
dio.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.y=
aml
> > >  delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.t=
xt
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yam=
l b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> > > new file mode 100644
> > > index 0000000000000..ce88d7ce07a5e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> > > @@ -0,0 +1,35 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/fsl,enetc-ierb.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Integrated Endpoint Register Block
> > > +
> > > +description:
> > > +  The fsl_enetc driver can probe on the Integrated Endpoint Register
> > > +  Block, which preconfigures the FIFO limits for the ENETC ports.
> >
> > Wrap at 80 chars
> >
> > > +
> > > +maintainers:
> > > +  - Frank Li <Frank.Li@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,ls1028a-enetc-ierb
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    ierb@1f0800000 {
> >
> > unit-address doesn't match
> >
> > > +        compatible =3D "fsl,ls1028a-enetc-ierb";
> > > +        reg =3D <0xf0800000 0x10000>;
> > > +    };
> > > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yam=
l b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> > > new file mode 100644
> > > index 0000000000000..60740ea56cb08
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/fsl,enetc-mdio.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: ENETC the central MDIO PCIe endpoint device
> > > +
> > > +description:
> > > +  In this case, the mdio node should be defined as another PCIe
> > > +  endpoint node, at the same level with the ENETC port nodes
> > > +
> > > +maintainers:
> > > +  - Frank Li <Frank.Li@nxp.com>.
> >
> > stray '.'                         ^
> >
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - pci1957,ee01
> > > +      - const: fsl,enetc-mdio
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +allOf:
> > > +  - $ref: mdio.yaml
> >
> > As a PCI device, also needs pci-device.yaml.
>
> After I add pci-devices.yaml, I get
> Documentation/devicetree/bindings/net/fsl,enetc.example.dtb: ethernet@0,0=
: False schema does not allow {'compatible': ['pci1957,e100', 'fsl,enetc'],=
 'reg': [[0, 0, 0, 0, 0]], 'phy-handle': [[4294967295]], 'phy-connection-ty=
pe': ['sgmii'], '$nodename': ['ethernet@0,0']}

Perhaps use pci-device.yaml, not pci-devices.yaml which doesn't exist.
The latter gives me this error, the former works fine for me.

Rob

