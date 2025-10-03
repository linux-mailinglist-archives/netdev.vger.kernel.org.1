Return-Path: <netdev+bounces-227782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB969BB707F
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 15:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A09948329D
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 13:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A818C1DC994;
	Fri,  3 Oct 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZNpsvWG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7E145A05
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498683; cv=none; b=M/CzVXOBj1AihfYtABM/+IHLike7+4YsOFxvV+ge7d1Jniwd4hyUppPsyC/EaQrzMkNeA1aZpy8AEV5e7chJufOLTxDRCPC3NsIaUkCTHteOwp6L7VQfAPGMoV5UnEqjjnoxd3eqOnaGgHvD07bXS92qDt70xeUkJma6iYfYbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498683; c=relaxed/simple;
	bh=2pmyEop6Zijxc9PO1JLBitmHPv8GpcEmMMIj4ht1oUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAluZDoQcZuDTnF9qD5OkifrHS/odD1w3P4WckNu5JVUVVsvKKRzUx1SAjP+7CiQsxQRvY6SPVjS+/nnXqrslP5FMUWzTS7kSV4psZqAlI+NtQHkFBSvrhYuhRU2oOhaehfrWaQsA4sVSZL68MehrDzkfq/zB3Aos3021voPKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZNpsvWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB2BC4AF09
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759498683;
	bh=2pmyEop6Zijxc9PO1JLBitmHPv8GpcEmMMIj4ht1oUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GZNpsvWG+NWIn7O/yvfTHV1s6evBcvlhFsmkOt5jeFeV+co/Rfk4bYvu2k129Auyq
	 LgKcKI/wn259mKalCxbKqx3JtgNwJ3qJxwoQfE77Fdsfo+9kHO/78sMvm7OW8uTUOH
	 e7QgLRk64J+ydxC5awDZlBLHHSuReP8bARSUNh+QXbVraa8Y6f5Wv5d8W9MwnIUJ1P
	 jL2awPmKc3HNLJGS4qkDrOqR6fWMGnuFZoYogKL1i8oAwtGmzv18USvJdsJZ/oY6Wt
	 hETD29Lz+c9w4bSG1E+zcWHKa6ZyW7wv+4dkw61k+NlOG2nNWWtZWQ9nxHW4LpID5b
	 0kt+/gZl7iB9w==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b07e3a77b72so569749166b.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 06:38:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUI/uvE8szVogv6J4/Aju1VnAKzIRIGeBsOnwafzH9mV2xFCprBTm+30U3lmvD9XZbRN5yK9Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMphiZb0CXvJvcGY9wp5OAWyjp02i9VQVHCug4/m+Z84xTsuA
	jHtfxKnR35+3QCjwicV2ltTgkEyXrZWv6n7Ea9nx/27zrI11SFDKLcXQsZp2jpuz5d3z7GiodJ8
	OSz8mRCI5OfdGMEzpu4idP+E+7a6MfQ==
X-Google-Smtp-Source: AGHT+IFfN6sSJIriH9Ll5BV1c1HgV9f2BYxa3Ss/f40JFYNyE+Fo873QiRh98/8opdRwv/J+A2EYfUUUK5pmVOC4e1g=
X-Received: by 2002:a17:907:7206:b0:b40:7305:b93d with SMTP id
 a640c23a62f3a-b49c128064emr438127966b.2.1759498681661; Fri, 03 Oct 2025
 06:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
 <175943240204.235529.17735630695826458855.robh@kernel.org> <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com>
In-Reply-To: <CABBYNZKSFCes1ag0oiEptKpifb=gqLt1LQ+mdvF8tYRj8uDDuQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 3 Oct 2025 08:37:50 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
X-Gm-Features: AS18NWA85pWm_cEAdPpLk9qTIKFIIE56dO54pRBpeMMRWMqKc4pJeIF8bKT_Mng
Message-ID: <CAL_Jsq+Y6uuyiRo+UV-nz+TyjQzxx4H12auHHy6RdsLtThefhA@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings
 to DT schema
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>, andrew+netdev@lunn.ch, 
	conor+dt@kernel.org, kernel@collabora.com, krzk+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, kuba@kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 2:18=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Thu, Oct 2, 2025 at 3:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
> >
> >
> > On Wed, 01 Oct 2025 15:33:20 -0300, Ariel D'Alessandro wrote:
> > > Convert the existing text-based DT bindings for Marvell 8897/8997
> > > (sd8897/sd8997) bluetooth devices controller to a DT schema.
> > >
> > > While here, bindings for "usb1286,204e" (USB interface) are dropped f=
rom
> > > the DT   schema definition as these are currently documented in file =
[0].
> > >
> > > [0] Documentation/devicetree/bindings/net/btusb.txt
> > >
> > > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> > > ---
> > >  .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 +++++++++++++++++=
+
> > >  .../devicetree/bindings/net/btusb.txt         |  2 +-
> > >  .../bindings/net/marvell-bt-8xxx.txt          | 83 -----------------=
--
> > >  3 files changed, 80 insertions(+), 84 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/m=
arvell,sd8897-bt.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/net/marvell-bt-=
8xxx.txt
> > >
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >
> > You'll probably have to resend this after rc1.
>
> In that case I'd like to have a Fixes tag so I can remember to send it
> as rc1 is tagged.

A Fixes tag is not appropriate for a conversion to DT schema.

Rob

