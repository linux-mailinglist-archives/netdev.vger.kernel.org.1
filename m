Return-Path: <netdev+bounces-133689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF79996B15
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2293A1F2A71E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47DF1E22F9;
	Wed,  9 Oct 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhAhEGHx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC81A2642;
	Wed,  9 Oct 2024 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478339; cv=none; b=QIFyOxnHIKhYoBI3ZxpTlLrsGLExItuTnrYYt2p9TH9mq2XcwsYMyNDZIptW9K3G0H0lGJMV7lkumOagpcxYAh5Opggb2rmXnr3KDikh24/7ysEoa4bLntVGYn10aAaiObHy3+YQwZFobw991BpSW/nG5Q66ZxW6dWzLJYB/jtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478339; c=relaxed/simple;
	bh=HHEBQb1qdAFHMv/pfrcD18RfgjkUCU/NTuuNhY+0ulA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqsnqabLQJjBgllw+sbpzRpAwpBX9vPv0WUHCvd0Efnim9AuUCQweSlmYMMGpuPWRMW4emhot8lyNUdnIOifdp3AHc7M8HfHqDmAnHchoAKm+OcucgTsy6smmrAGMiDSBOV+Fn5vQlndnQXrr5l8Y12nzIU9a2uPH9gGbSLl1fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhAhEGHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF805C4CECE;
	Wed,  9 Oct 2024 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478339;
	bh=HHEBQb1qdAFHMv/pfrcD18RfgjkUCU/NTuuNhY+0ulA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhAhEGHxXSG/ILrU3aplWh44VHb8vgn6R9oCcbIG70q8GhjGJV1XzMItsG+A0LyfD
	 BQXfJO89WkTaIaElQZ3trMOzkeuA2qHDaMnIeQEtckRw7p6rm+raJ4rRsPyw04F+pE
	 gghZP5p+5og7zHM8Apf83fybuDeJcK+yiaaa07BVxjQxqBBqXVgcXeF3cro8vY0FoW
	 oKw/VxTFkBg189pXOSERSMtCvxAwNHIj+l+DIgDdfum6LnaZdguoTtqnzvCRgU3i5B
	 tbLRge+Tm6a+hd7FiIUXxiIT/9IaymOzoDF/0ryMKxNaUdIUeQ8mhUSVn9nVK0sBrp
	 VKCF36z0LP8Mg==
Date: Wed, 9 Oct 2024 13:52:14 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"csokas.bence@prolan.hu" <csokas.bence@prolan.hu>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
Message-ID: <20241009125214.GV99782@kernel.org>
References: <20241008061153.1977930-1-wei.fang@nxp.com>
 <20241009115448.GJ99782@kernel.org>
 <PAXPR04MB8510790CAA16524DA0AC1A0D887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB8510790CAA16524DA0AC1A0D887F2@PAXPR04MB8510.eurprd04.prod.outlook.com>

On Wed, Oct 09, 2024 at 12:43:50PM +0000, Wei Fang wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: 2024年10月9日 19:55
> > To: Wei Fang <wei.fang@nxp.com>
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; richardcochran@gmail.com; csokas.bence@prolan.hu;
> > Shenwei Wang <shenwei.wang@nxp.com>; Clark Wang
> > <xiaoning.wang@nxp.com>; linux@roeck-us.net; imx@lists.linux.dev;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net] net: fec: don't save PTP state if PTP is unsupported
> >
> > On Tue, Oct 08, 2024 at 02:11:53PM +0800, Wei Fang wrote:
> > > Some platforms (such as i.MX25 and i.MX27) do not support PTP, so on
> > > these platforms fec_ptp_init() is not called and the related members
> > > in fep are not initialized. However, fec_ptp_save_state() is called
> > > unconditionally, which causes the kernel to panic. Therefore, add a
> > > condition so that fec_ptp_save_state() is not called if PTP is not
> > > supported.
> > >
> > > Fixes: a1477dc87dc4 ("net: fec: Restart PPS after link state change")
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Closes:
> > https://lore.ker/
> > nel.org%2Flkml%2F353e41fe-6bb4-4ee9-9980-2da2a9c1c508%40roeck-us.net
> > %2F&data=05%7C02%7Cwei.fang%40nxp.com%7Cb10cac9ed8cd43284aae08
> > dce85930cd%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63864
> > 0716999752935%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> > JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=1
> > gxwnxNjk91xX7I%2Foco%2F4OhBbxNCryhDMo72O9Jkr2w%3D&reserved=0
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > >  drivers/net/ethernet/freescale/fec_main.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > b/drivers/net/ethernet/freescale/fec_main.c
> > > index 60fb54231ead..1b55047c0237 100644
> > > --- a/drivers/net/ethernet/freescale/fec_main.c
> > > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > > @@ -1077,7 +1077,8 @@ fec_restart(struct net_device *ndev)
> > >     u32 rcntl = OPT_FRAME_SIZE | 0x04;
> > >     u32 ecntl = FEC_ECR_ETHEREN;
> > >
> > > -   fec_ptp_save_state(fep);
> > > +   if (fep->bufdesc_ex)
> > > +           fec_ptp_save_state(fep);
> >
> > Hi,
> >
> > I am wondering if you considered adding this check to (the top of)
> > fec_ptp_save_state. It seems like it would both lead to a smaller
> > change and be less error-prone to use.
> >
> 
> Yes, I considered this solution, but when I thought about it,
> fec_ptp_save_state() and fec_ptp_restore_state() are a pair. If
> the check is added to fec_ptp_save_state(), it is better to add
> it to fec_ptp_restore_state(). However, considering that this is
> not related to the current problem, and there are relatively few
> calls to fec_ptp_restore_state(), I did not do this. If there are more
> calls to fec_ptp_restore_state()/fec_ptp_restore_state() in the
> future, I will consider it.

Sure, I agree on your point regarding symmetry, which I had not considered
when I wrote my previous email.  And I agree that the patch is suitable for
net in it's current form.

Reviewed-by: Simon Horman <horms@kernel.org>

...

