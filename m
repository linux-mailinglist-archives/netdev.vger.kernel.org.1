Return-Path: <netdev+bounces-146327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58299D2DAC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 19:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C202829B0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8BC1D1F44;
	Tue, 19 Nov 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="uONjaW2F"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC11CF7B7;
	Tue, 19 Nov 2024 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040066; cv=none; b=Km7o10S4JeyZ1RfJWr9Y6LaX6+9vuVjqUDKsZ5I6dqCTy1wlQ5i867qZnNLSxf1vP8RjmWThz5Cm5HfqaWwomys3XNq6vzQyD99Df98ftEfm4ZWicDmuNkzIZHWprfXiMy7SKevmwqkwuFIzbSOf1baUeOjf7SdD2yxvRDZwhkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040066; c=relaxed/simple;
	bh=21a71e7orvgi5MPsMxou9/OOteSQW78/MKUCiMlrvqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChyfU5RMBP63jRyXrBBxdFHkgXwHUWjDj/OThUBg7Hs5VQq/H3dnqyrSd010xpUP/caasOFdSyt8AmfXgWbIfSp3QEYb7uWZ0dw/bz3+bfc9VsI7l7dHenyX6lJEaBi7rmwl2SFugrjxz+CKDEqp7FTFQoRsfoIBf1a3PWf7ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=uONjaW2F; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1732040021; x=1732644821; i=parker@finest.io;
	bh=VGT8AsS8Us1spIq9IkDtJaus5/uzjZbOrMzyLjeFCNQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uONjaW2FblG/6peh9CrwJ8XfF2tDFqYzBm0/FVmh1cbgSJvIV2STyvLj609t1bSm
	 j7E/90mYpc6DFcdH5K9kuPE3fUdGViS6Cyl6s1yfiCoGy9nC4AC4TkMrLJAUGfjjL
	 3ot+Uio1KuKJL+Z/ZvUa3rTw6BIU3zYv+vqnDj2PdMsw5bMvTVF0s9ljozJwLRCYK
	 9kps61qMxknCaPTMQhBQQIpKxV0Kxu+q5zMTHlPhgS6ApViyesHEvdDvip9csBZZ5
	 RNhiHzIZMnFFRvQSWLWX6iiniXgWEvZNSZ/zqVjzvO6+UxgVk5O4HlvAX1sQ+0Z6z
	 pqMzG4BBklMvP2R+zg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N95Jb-1tqap93LVv-017uyx; Tue, 19 Nov 2024 19:13:40 +0100
Date: Tue, 19 Nov 2024 13:13:36 -0500
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
Message-ID: <20241119131336.371af397.parker@finest.io>
In-Reply-To: <984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
References: <cover.1731685185.git.pnewman@connecttech.com>
	<f2a14edb5761d372ec939ccbea4fb8dfd1fdab91.1731685185.git.pnewman@connecttech.com>
	<ed2ec1c2-65c7-4768-99f1-987e5fa39a54@redhat.com>
	<20241115135940.5f898781.parker@finest.io>
	<bb52bdc1-df2e-493d-a58f-df3143715150@lunn.ch>
	<20241118084400.35f4697a.parker@finest.io>
	<984a8471-7e49-4549-9d8a-48e1a29950f6@lunn.ch>
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
X-Provags-ID: V03:K1:AtKqw0Z1I7mrrYJHxTfQz5F8hUNeBM14Cog+yV7Z7kBlruzLoEq
 52aV4ZlzIPc1OCm+IfwqymFQaKhYt2ZbqHTJJjIQtpu18McO2js+UUUqNozSyFiYvq1vMor
 j9qgYJ9/bNlYyTzSt2XcktTKgokGqx4GQXdAyJty1dbl52/eaXikcxB5rMLKxb3u1DoDau0
 uxB9RThgXBNB/H6oziE3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GuLdzSAGVIo=;t3EYDXONAZMT2F7a5+doMXWtZjV
 cuPGr3pdRSaNEJ3lO0C0RnOVAEH+I4kv7Lt9MhqlfkkCa3ctc+Eru00Tvng2hrD7aEvbKEGR2
 Wxyg76vJ6IzKEaeRWP3H3PilJZHve7T0xqTYrl4X+RFBxF0FUOCgF0uVCOpxr05CLxuqxNEas
 VajBnbVq1GKwPOo2s/J0ZPsxei8RaO2/NhtbJXrgLf/V/EbYVkcs35rr5pRNmoKc1jsUL30rH
 IaLCS6xT3Dca9e8ZYpX37p1rpT2e8/SW3jqZLCRwHXVmYAbOZST1WD/1qEaDr32EPl8do+Pf5
 bhkB01vomsqhSSD2kGW+APTP3QA4z+Aqp0dYn3FbAr+ASMgt+PmghUV/CIcjnIrHPBj8Df/vz
 dCWIDSC8goGPB2aLNJDsjWNC1cLOk/Xyy0d3RDAJjiMA/uPMJWuw6yoLc7YTCZJS8JYlbgt3x
 m61c4e5SHkb3lafflPNLQEPo1FTEWpWu95VWbn4csRoo7XQT1IiOvdslMd58YVN1BSef89qeZ
 lq1sbzE9+tlg25Rwx9S+Gflbq/R9ZmIQw/c2Rmxqaed4CTVyFf5e68kln99SAMq6chzOpaDRe
 quTSx0TaDCaw0bgcavSAWYkcmgkAqk3o9WZh5huC+o70gGK/RQ1jgIw/7cHXdJCJDIory/dYH
 PCc+TioN+rhYatstwunHIshLdhPvLA06Pv5/+UoaoaRAe07nfdcvITa8EQvzi/y6d9WEjCHx/
 07d1BJrVCRQjXE+kBDRQ4+SaZ4M9Zc9yqrnc1Ofo5ii8rBGvcZ0o0ABKOh8S65HiZdboh2e4b
 IpA4NlLSNMrMLav9j14WctihV02FYT81m/4Y+QtzPNYTAqfOHznU1Z4E0I1KmubFto

On Tue, 19 Nov 2024 01:50:18 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > This is not a new dt property, the "iommus" property is an existing pr=
operty
> > that is parsed by the Nvidia implementation of the arm-smmu driver.
> >
> > Here is a snippet from the device tree:
> >
> > smmu_niso0: iommu@12000000 {
> >         compatible =3D "nvidia,tegra234-smmu", "nvidia,smmu-500";
> > ...
> > }
> >
> > /* MGBE0 */
> > ethernet@6800000 {
> > 	compatible =3D "nvidia,tegra234-mgbe";
> > ...
> > 	iommus =3D <&smmu_niso0 TEGRA234_SID_MGBE>;
> > ...
> > }
> >
> > /* MGBE1 */
> > ethernet@6900000 {
> > 	compatible =3D "nvidia,tegra234-mgbe";
> > ...
> > 	iommus =3D <&smmu_niso0 TEGRA234_SID_MGBE_VF1>;
> > ...
> > }
>
> What i was meaning does the nvidia,tegra234-mgbe binding allow iommus?
> I just checked, yes it does.
>
> > If the iommus property is missing completely from the MGBE's device tr=
ee node it
> > causes secure read/write errors which spam the kernel log and can caus=
e crashes.
> >
> > I can add the fallback in V2 with a warning if that is preferred.
>
> The fact it crashed makes me think it is optional. Any existing users
> must work, otherwise it would crash, and then be debugged. I guess you
> are pushing the usage further, and so have come across this condition.
>
> Is the iommus a SoC property, or a board property? If it is a SoC
> property, could you review all the SoC .dtsi files and fix up any
> which are missing the property?
>
> Adding a warning is O.K, but ideally the missing property should be
> added first.

I think there is some confusion here. I will try to summarize:
- Ihe iommu is supported by the Tegra SOC.
- The way the mgbe driver is written the iommu DT property is REQUIRED.
- "iommus" is a SOC DT property and is defined in tegra234.dtsi.
- The mgbe device tree nodes in tegra234.dtsi DO have the iommus property.
- There are no device tree changes required to to make this patch work.
- This patch works fine with existing device trees.

I will add the fallback however in case there is changes made to the iommu
subsystem in the future.

> The merge window is open now, so patches will need to wait two weeks.
>

Ok thanks, I will wait a couple weeks to resend.
Parker








