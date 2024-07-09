Return-Path: <netdev+bounces-110302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D9692BC85
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 16:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BAB4B25D50
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4CA18EFD7;
	Tue,  9 Jul 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0WxFHkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123538DD8;
	Tue,  9 Jul 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534256; cv=none; b=XgHe8WqgugBz6LU10A03p/muF0AX76vYyFJl3cpVYQwnIa8M02Pkm+zoz8krTjau6fbXSgRbPVLq1BDbA9b2mxqBZlCM6i4gop95gt/zPzkHtX2KyOKm6YcFQ6w5oIESVbS9yVfL2R7tYpWvO/msJWGu2U4yS/OBZEwSIL6HRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534256; c=relaxed/simple;
	bh=jrwgOSqLnDVXE3Ir5Kqt1EGFwtQZ92EcQiFwkAGb7Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoDh6c74U+XonkBpc8AqN86JU0O3cvisB2FPNMN0q7RT9nGwEOshNX7kJ7bBbCgMbV0iha6of7c8HS9ln+HBBQiCU1SGixvkkFfkvNWFv3ljl5+faHknWqpAKanSkrswdkI91Dp+LBbjSPnuq0S5GxeTwPdpHHOlm3+5k3HRAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0WxFHkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD25C3277B;
	Tue,  9 Jul 2024 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720534255;
	bh=jrwgOSqLnDVXE3Ir5Kqt1EGFwtQZ92EcQiFwkAGb7Ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E0WxFHkwNCoOYL12JtMm5dm1ewNJPL1fF4A6uE073OEbk+NfiXWC9XhhxKgcwdw4K
	 WOhoUXzBtRGPgsoNKi9plDP7xi/6htrNPgqRx9EJdtLTVGsPnA73le/4NWbMjvVhM3
	 fSIIXSZYBy9eHAuQrwBoe4VNhMNUTLMEr9cBMCjous/B7eNMauXn7gDPu6hreRG9sU
	 KHXtp0u9MQ5mzhRBTQO95FMpfPKto/EAIE/5rQsIrHFhtbHViDPg5CdaqqEFtZpBT6
	 Ffq4PLu+qyxQGau/9sQ1XSQrsbxokDQW0LPo2418bWKcVnFnMG5cPpggRxmWYdzPAi
	 i54Bl+11v4AEw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so7155926e87.3;
        Tue, 09 Jul 2024 07:10:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcZ0RjwyJToU5Qsl5FjyArmmFgmuVL7K3Vnu9wvkijLcrwYEMHfBhRlDjKAhv2UQTKNCaej5H/9zizjkMAmV+f8e9f7T9QU2ZonoXUJDU0PLWZu89wDbnMJhMI3dcM3PAoUlgzFUYJTXJaKM5Utf/+32tknZ87Uya6zTr/N9SQEw==
X-Gm-Message-State: AOJu0YyrA9ZX2X9zCsifUTk+4zoeizE4d9laddbBr6KP+IBSznvD7A/1
	1sLKCQQYbxikcvBxWd2xiJDrcZt1iwvgAUNHQh7Kfm5Gjc47X6qfd4ea9y25+TIo931pUXIsYUq
	CmWGcz4kwa3J79EbIliJ7Z1p6rw==
X-Google-Smtp-Source: AGHT+IEQmv0+WiicMvKYnKq41lc5Tr8jd8opmyylh2uppeRiuhPL2X8bz0Bic+Ci/n4FuePRj8iO7NcnOVzDh6HBDow=
X-Received: by 2002:a05:6512:3b9d:b0:52b:be6b:d16a with SMTP id
 2adb3069b0e04-52eb99a3526mr2633731e87.31.1720534254056; Tue, 09 Jul 2024
 07:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626162307.1748759-1-Frank.Li@nxp.com> <PAXPR04MB85101FF8C01B57F87DF1B04A88DA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB85101FF8C01B57F87DF1B04A88DA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Jul 2024 08:10:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJt+6_YrUaapxd+u7GjQffFi=okirkq+cotTUE43Knwqw@mail.gmail.com>
Message-ID: <CAL_JsqJt+6_YrUaapxd+u7GjQffFi=okirkq+cotTUE43Knwqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
To: Wei Fang <wei.fang@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, "krzk@kernel.org" <krzk@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 4:07=E2=80=AFAM Wei Fang <wei.fang@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Frank Li <Frank.Li@nxp.com>
> > Sent: 2024=E5=B9=B46=E6=9C=8827=E6=97=A5 0:23
> > To: krzk@kernel.org
> > Cc: Frank Li <frank.li@nxp.com>; conor+dt@kernel.org;
> > davem@davemloft.net; devicetree@vger.kernel.org; edumazet@google.com;
> > imx@lists.linux.dev; krzk+dt@kernel.org; kuba@kernel.org;
> > linux-kernel@vger.kernel.org; netdev@vger.kernel.org; pabeni@redhat.com=
;
> > robh@kernel.org
> > Subject: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
> >
> > Convert enetc device binding file to yaml. Split to 3 yaml files, 'fsl,=
enetc.yaml',
> > 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.
> >
>
> Sorry I didn't see this patch until now, I was planning to make this conv=
ersion
> but didn't realize you had started it first. It's very nice, thanks!
>
> > Additional Changes:
> > - Add pci<vendor id>,<production id> in compatible string.
> > - Ref to common ethernet-controller.yaml and mdio.yaml.
> > - Remove fixed-link part.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - renamee file as fsl,enetc-mdio.yaml, fsl,enetc-ierb.yaml, fsl,enetc.y=
aml
> > - example include pcie node
> > ---
> >  .../bindings/net/fsl,enetc-ierb.yaml          |  35 ++++++
> >  .../bindings/net/fsl,enetc-mdio.yaml          |  53 ++++++++
> >  .../devicetree/bindings/net/fsl,enetc.yaml    |  50 ++++++++
> >  .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
> >  4 files changed, 138 insertions(+), 119 deletions(-)  create mode 1006=
44
> > Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
> >  create mode 100644
> > Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.yam=
l
> >  delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> > b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
> > new file mode 100644
> > index 0000000000000..60740ea56cb08
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
>
> I suggest changing the file name to nxp,netc-emdio.yaml. "fsl" is a very =
outdated
> prefix. For new files, I think "nxp" is a better prefix.

Convention is filenames use the compatible string. So no.

> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +
> > +title: ENETC the central MDIO PCIe endpoint device
> external is better, that is why we call it EMDIO.
>
> > +
> > +description:
> > +  In this case, the mdio node should be defined as another PCIe
> > +  endpoint node, at the same level with the ENETC port nodes
> > +
> This my local description, excerpted from NETC's block guide, FYI.
> description: |
>   NETC provides an external master MDIO interface (EMDIO) for managing ex=
ternal
>   devices (PHYs). EMDIO supports both Clause 22 and 45 protocols. And the=
 EMDIO
>   provides a means for different software modules to share a single set o=
f MDIO
>   signals to access their PHYs.
>
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>.
> Vladimir and Claudiu as the driver maintainer, it is best to add them
> to this list
>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - pci1957,ee01
> > +      - const: fsl,enetc-mdio
>
> " fsl,enetc-mdio" is meaningless, we did not use it ever.

arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:
 compatible =3D "pci1957,ee01", "fsl,enetc-mdio";

In fact, until I recently added the standard PCI compatibles, these
were the only compatible strings used.


Rob

