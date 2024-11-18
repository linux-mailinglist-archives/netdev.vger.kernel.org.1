Return-Path: <netdev+bounces-145845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05599D12A6
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C78B26679
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980341991C6;
	Mon, 18 Nov 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="z0HrbVKc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFCA53A7;
	Mon, 18 Nov 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937816; cv=none; b=Ju6WSL/Nfca/FpVQ1vchnF3fF+yqTm7ePCu02jy12EAPix0ZBMz5MyE9XcG2l+WJK3LyR0cI9oN6Yf4w9NHwMKgTu2MgZN1/L1OoUJPMrmUy0bqKWpLy53GvB56lrAaPdbQA59wROAE190oLZa7v01rQzBNG0y/KkceVZXukk8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937816; c=relaxed/simple;
	bh=qA/3glSjU1zbPWaKBtZERwuu0G9Ypp6ewx59EMjM2W4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKzTgXOFYzqkZm0GLc9W6T49NYoWSv6SNSY1ayDYieJ0GOdfg57oE5mSbj7gBWJjFCHYS+ZlBcH56mEMiqBYGvYx4jS+zMW/pHDm5pu2DwWXtJZl7tN9g2SRhLmK1me4BHLOWPsXGT8DVHEKsHkg7fVqel2W+SSBWmDiCQNEfkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=z0HrbVKc; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1731937809; x=1732542609; i=parker@finest.io;
	bh=b3Pjbz/GSF9pG8ylznqiAUCGfHFGePVPHSwvADAHbxk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=z0HrbVKccaTsRkJF0X3+qJDIt6zApfVzhT4iqMnCXac4K91c9JTnX9PW/TY3Kn8b
	 LXV05c68tQkIemKS8rMlhUu490we39FyxifFiPRSrRy5y1wq4Joq/XtM1J3Mjg/jA
	 shgW9zic/kCLmt/XR/Ree0fTe3Bhs91TK6iMpgZ+Ozo/TkPH2+IuzXIUHMtHjobTe
	 EEl+uRaOJXAu6UPcUqfxOXgQvwGOCUeveYoR0YMnaKG8U10JXpjxVfDzfMpbELCl1
	 g7p7mGLP0dP/AlNGycHIP3ILr/7gz5Pk40AEKYxg3FrvBZCtzICBk3zPq74FQ1zMw
	 9WEtHfdH3kTDJJIEhw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MScQ1-1tJKeL40Eb-00QdK2; Mon, 18 Nov 2024 14:44:05 +0100
Date: Mon, 18 Nov 2024 08:44:00 -0500
From: Parker Newman <parker@finest.io>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 1/1] net: stmmac: dwmac-tegra: Read iommu stream id
 from device tree
Message-ID: <20241118084400.35f4697a.parker@finest.io>
In-Reply-To: <bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
References: <cover.1731685185.git.pnewman@connecttech.com>
	<f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
	<ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
	<20241115135940.5f898781.parker@finest.io>
	<bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b2G6KXDe8gzQmPCDojvaXK5OwJiaOjeUL/OAy4fEaNFv4Q5aKIo
 mhL09ZNLedzJODU2GzkC/HWh8N2RTb2nLPUMCzmhJgss4K/Rn1ATnAGlRZIpQ6t3Dd3tWvt
 e4yt8/6oFRnYqO1E3AWr2Rd3FeQRRHYtCEjJgHx2X8fyIgPB1brbQSfZMZ5rzk1F7gYxdWQ
 paVLM7vpd5yCSvHVAay5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Sw0gA4BRG6w=;CvyJoIM1CSQYrW5eVmFWOmXtqMD
 K9k7Te2raPujkCRyH9vSBdb0YwnLikf7FlmTN25W+BTB3Km35A6xvmBpw7MZFejstqiWiDvbk
 /J06UE7rEyz8XceWUXdBGXreARPYvrY1qVzCQLwKY9oneulqSUCZsi1mYScvtLbeehpVm6mvr
 +GMDc7YdZpAJZmhkHwxr3cEW6Yk67Izlnmt7+H0j4CQ2yMriYRVL+qCxQPHVhH1TkL2WDiAaA
 TL1cBdJt6rpTjPNmmFqRZ/REpb8f1NdmxBCLH3Z3T1sKixD7JN8wkHt8Wte0VB/14m/6Th7EH
 VVSkzueh2L9jGB2K6+HH+js29g6mUzVvKJ+37x65zAHli0irqaa0Bdu5PdTfaJKknaIh3msMI
 MV+tW4I23Rz7aXGDg/vZBVTDP0ErHAbB6g7724yLEi99DS0CPstNS/KNbM2DjOMphyEBRd2jK
 yHayKnygG7ZihAyDCTXIpSXkeWEjfVJiZKRhlXjWb09zc9kwzCACdbc9ncNGNfq5JY9SpyM2t
 7zS6HP2xkGdYgAzf9083MQK+N5UApmO57ip++0YpWAsOyE2GYQqTkulQq2q/XmrgxkTUXwwoc
 aOk4JG4W1C0rUHJcdFYASVQurvu9UoiGgsgFKoh/x7u3kiHfpGfB+nNT1k6CwzayBIbQXozWL
 3ujNwnSxhzD84Qn8RjKa2Gs2FySqDTDjBXJzyKiPeC4iueyQyTOYO+kJ6joSDQRex7bnGjvFq
 WlrhVcL7aJRll5hFjE5+wYVGeSGjlPX0JWqlhEqBBbqEcXYu8IOMalDj50QnDxN/ZaWpIYSOu
 RqwXRKE8b96/DZfok0DCT762s4JgXQpNAyjbdJKhgWEd2yWKI9z61QkDpsRlF6Skno

On Sat, 16 Nov 2024 20:22:53 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Nov 15, 2024 at 01:59:40PM -0500, Parker Newman wrote:
> > On Fri, 15 Nov 2024 18:17:07 +0100
> > Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > > On 11/15/24 17:31, Parker Newman wrote:
> > > > From: Parker Newman <pnewman@connecttech.com>
> > > >
> > > > Read the iommu stream id from device tree rather than hard coding =
to mgbe0.
> > > > Fixes kernel panics when using mgbe controllers other than mgbe0.
> > >
> > > It's better to include the full Oops backtrace, possibly decoded.
> > >
> >
> > Will do, there are many different ones but I can add the most common.
> >
> > > > Tested with Orin AGX 64GB module on Connect Tech Forge carrier boa=
rd.
> > >
> > > Since this looks like a fix, you should include a suitable 'Fixes' t=
ag
> > > here, and specify the 'net' target tree in the subj prefix.
> > >
> >
> > Sorry I missed the "net" tag.
> >
> > The bug has existed since dwmac-tegra.c was added. I can add a Fixes t=
ag but
> > in the past I was told they aren't needed in that situation?
> >
> > > > @@ -241,6 +243,12 @@ static int tegra_mgbe_probe(struct platform_d=
evice *pdev)
> > > >  	if (IS_ERR(mgbe->xpcs))
> > > >  		return PTR_ERR(mgbe->xpcs);
> > > >
> > > > +	/* get controller's stream id from iommu property in device tree=
 */
> > > > +	if (!tegra_dev_iommu_get_stream_id(mgbe->dev, &mgbe->iommu_sid))=
 {
> > > > +		dev_err(mgbe->dev, "failed to get iommu stream id\n");
> > > > +		return -EINVAL;
> > > > +	}
> > >
> > > I *think* it would be better to fallback (possibly with a warning or
> > > notice) to the previous default value when the device tree property =
is
> > > not available, to avoid regressions.
> > >
> >
> > I debated this as well... In theory the iommu must be setup for the
> > mgbe controller to work anyways. Doing it this way means the worst cas=
e is
> > probe() fails and you lose an ethernet port.
>
> New DT properties are always optional. Take the example of a board
> only using a single controller. It should happily work. It probably
> does not have this property because it is not needed. Your change is
> likely to cause a regression on such a board.
>
> Also, is a binding patch needed?
>
> 	Andrew

This is not a new dt property, the "iommus" property is an existing proper=
ty
that is parsed by the Nvidia implementation of the arm-smmu driver.

Here is a snippet from the device tree:

smmu_niso0: iommu@12000000 {
        compatible =3D "nvidia,tegra234-smmu", "nvidia,smmu-500";
...
}

/* MGBE0 */
ethernet@6800000 {
	compatible =3D "nvidia,tegra234-mgbe";
...
	iommus =3D <&smmu_niso0 TEGRA234_SID_MGBE>;
...
}

/* MGBE1 */
ethernet@6900000 {
	compatible =3D "nvidia,tegra234-mgbe";
...
	iommus =3D <&smmu_niso0 TEGRA234_SID_MGBE_VF1>;
...
}

The 2nd field of the iommus propert is the "Stream ID" which arm-smmu stor=
es
in the device's struct iommu_fwspec *fwspec. This is what the existing
tegra_dev_iommu_get_stream_id() function uses to get the SID.

If the iommus property is missing completely from the MGBE's device tree n=
ode it
causes secure read/write errors which spam the kernel log and can cause cr=
ashes.

I can add the fallback in V2 with a warning if that is preferred.

Thanks,
Parker





