Return-Path: <netdev+bounces-110474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CB292C85D
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40A7B21F10
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0283F8F66;
	Wed, 10 Jul 2024 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFAOr8Y3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5563B9;
	Wed, 10 Jul 2024 02:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577973; cv=none; b=kzjEy+GisHxZPWzMs7QFVZYeOwr9dfjGFJJ0nYD2usaVHehhFQvg7Co5vg2FOJJ3OvibJyTUupdbUN4ku0Gi8XWMI5L3QQ/MyFbZWSzXvhoxdETMXnBUCyZObq8++qFwWjZU6MJv8agLLRLnqsvV6KhfPza0p1QjZIHnkCJa87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577973; c=relaxed/simple;
	bh=omrW3CcblNZaKNxxWLAegGSDxSKVDuM/ZXcSFvkUZ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ0VWuappew/9c/rxFUy0fe0pnG8bm6ovyFn522K0Ufip7TZMqAij9cPDa3Z7JKZ6k3EaJHyGUnLaZ/ixNu0LzycVBNflRNSfyBYGnuDfccC7D3VTUZetIcjnNhyoLMyP9WW6wWQcBHG/h8f6iTYSTA2XLSvppAjYmO9FqyCDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFAOr8Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F34C32782;
	Wed, 10 Jul 2024 02:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720577973;
	bh=omrW3CcblNZaKNxxWLAegGSDxSKVDuM/ZXcSFvkUZ8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HFAOr8Y3+eUXUxsMTIQYbR3ENCbjaI2vkeu6AKtQL8f7FcDMsJcycGsY19pdREGrL
	 cdQGVPeVjSNI09suPZ1uDtNJXID5w9KkPdbe1r/Gk7SaC09ZQJaymQXva77tZtFXW8
	 wbrRZooFz1AokmHpahjBox6eFqDs7QBuTb8GBPfZ6NgDnNCvWnyk2bFwwLhtJxx3eY
	 DZytVeAE7ZcZO8S/QLR96X2WvQSulQZq8R38zeuAckJkc38cC3Cptz8uwltDqYh9Jj
	 85Pqke927GX3tLuT7psdlgjuT3Ai9pM+84CojxI+kLsOtIQYHBOxNkRSgopWEE1z3W
	 940cPMU0f/BzQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea8320d48so263043e87.1;
        Tue, 09 Jul 2024 19:19:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWv82H7jhBf0LJS3o1ePcxRPNavG0V3JWqDmhnObfhnvq0PlLb33ip/TjPGuo/IbhxJTN4KgAhVYyv1yjMeHnGQwYsHk0ujp4dUPibveD0bYCHM0K6PFbYIfA5EN1S1i844PE5S+J9YadUacq5SgsPS7omfS3xDMXFC5Z6XIzKixQ==
X-Gm-Message-State: AOJu0YyudECT1EGPLCRRbwPx6nA99aJVZbejoPwt//pG3qOSh/PApne6
	q99nSqnXlBkMLotQEk4mxn9dXXy4DhRmZoX3jpRoZZDUjyg1eEkBdssdKe9JYqas4IiWfZlgMGe
	LwXu67038UNLHUuI3RAP1aLz3TQ==
X-Google-Smtp-Source: AGHT+IGxjr9hREIQBvmHUvhoFmwglXRsuInIzhYFWi82637ZDGNlRG90DOkyuUfJ/AmSofDhseE2G6Iv5+zn9Db8jPg=
X-Received: by 2002:a05:6512:124f:b0:52c:d7d9:9ba4 with SMTP id
 2adb3069b0e04-52eb9d789f0mr1353567e87.31.1720577971650; Tue, 09 Jul 2024
 19:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709214841.570154-1-Frank.Li@nxp.com>
In-Reply-To: <20240709214841.570154-1-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Jul 2024 20:19:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ83V8YmiH8dKv42ZV9eCSchD_znRDr3=NuAJTCB7kS1w@mail.gmail.com>
Message-ID: <CAL_JsqJ83V8YmiH8dKv42ZV9eCSchD_znRDr3=NuAJTCB7kS1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: net: convert enetc to yaml
To: Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, davem@davemloft.net, devicetree@vger.kernel.org, 
	edumazet@google.com, imx@lists.linux.dev, krzk+dt@kernel.org, krzk@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 3:49=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Convert enetc device binding file to yaml. Split to 3 yaml files,
> 'fsl,enetc.yaml', 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.
>
> Additional Changes:
> - Add pci<vendor id>,<production id> in compatible string.
> - Ref to common ethernet-controller.yaml and mdio.yaml.
> - Add Wei fang, Vladimir and Claudiu as maintainer.
> - Update ENETC description.
> - Remove fixed-link part.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - use endpoint-config as node name for fsl,enetc-ierb.yaml,
> - wrap to 80 in fsl,enetc-ierb.yaml.
> - fix unit address don't match
> - Remove reg/compatible string for pci
> - Add pci-device.yaml, which need absolute path.
> - Use example which have mdio sub node.
>
> Change from v1 to v2
> - renamee file as fsl,enetc-mdio.yaml, fsl,enetc-ierb.yaml, fsl,enetc.yam=
l
> - example include pcie node
> ---
>  .../bindings/net/fsl,enetc-ierb.yaml          |  38 ++++++
>  .../bindings/net/fsl,enetc-mdio.yaml          |  57 +++++++++
>  .../devicetree/bindings/net/fsl,enetc.yaml    |  66 ++++++++++
>  .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
>  4 files changed, 161 insertions(+), 119 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-ierb.=
yaml
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-mdio.=
yaml
>  create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

