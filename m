Return-Path: <netdev+bounces-89339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B128AA0FF
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D793285F27
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C734A171092;
	Thu, 18 Apr 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsV1NwPj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5B15E20F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461058; cv=none; b=b2NOM35rG789dRvNMPRNJoXiizMu2C0w9krnxbpbmfflI+BwiKyi4XCYr8grCrtpEoJs9str1zFW1Xs74BxcwGFVDAw5l5g3EcpAk60HVCO0k/Y5OqA0FuEfp/W3Qc2NCHiq/CMTyePjqq1dqmyTeTYmsCBHz27PMTDtGn9PAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461058; c=relaxed/simple;
	bh=/kk0h3lTrOjagDoexWgteuHGe2q0MHcTJDTzIFoplUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8YItVproZ7hSs/uhDjyXT2SWktEE9kpjY/1LJPvSmIIT/ny4+jth5lEsGushTmoG74s+ldVwuhkcSa6t+9MWNr/+3KLj7mCIUfPty+fxIqnniEU4vCPsoOni2KpWHutvaJ+Vr27KX+cJ0AAtr0Vjfp0/aEEtFkVGUOzecKTXf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsV1NwPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2736C113CC;
	Thu, 18 Apr 2024 17:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713461058;
	bh=/kk0h3lTrOjagDoexWgteuHGe2q0MHcTJDTzIFoplUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsV1NwPj762+5XvG+JjPPlzsfex6PvPBLsXIFVNSltJilQG25MJBAzaI6g0I6f/vy
	 XDXiO/y1iM4fDOJgJKRGEAv4ITOOhL18eXqe8o5RsDE14m9tz2jV2Up5kNuKbbMa36
	 5qmsNLije0lKy/f5whIBj/KkK6ZOa/xX7RT33cbcuO0/cTOEUM2h6SauliXmSzZaR4
	 tcG0AIxgJqid6bmiTEwdSQErFLZiz8vVliLAW65xOILm636JXFtgJ6js6MPgomzhz4
	 z8a2kruZMTTS8u4MbrAMhi+xV9MnuSl77v3vS7x/vZ4a9Bi6yQfLmgO9kNEepT+Q1h
	 FVeOJfftgzBVQ==
Date: Thu, 18 Apr 2024 18:24:15 +0100
From: Simon Horman <horms@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch
Subject: Re: [PATCH net-next v1 3/5] net: tn40xx: add basic Tx handling
Message-ID: <20240418172415.GI3975545@kernel.org>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
 <20240415104352.4685-4-fujita.tomonori@gmail.com>
 <20240418172306.GH3975545@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418172306.GH3975545@kernel.org>

On Thu, Apr 18, 2024 at 06:23:06PM +0100, Simon Horman wrote:
> On Mon, Apr 15, 2024 at 07:43:50PM +0900, FUJITA Tomonori wrote:
> > This patch adds device specific structures to initialize the hardware
> > with basic Tx handling. The original driver loads the embedded
> > firmware in the header file. This driver is implemented to use the
> > firmware APIs.
> > 
> > The Tx logic uses three major data structures; two ring buffers with
> > NIC and one database. One ring buffer is used to send information
> > about packets to be sent for NIC. The other is used to get information
> > from NIC about packet that are sent. The database is used to keep the
> > information about DMA mapping. After a packet is sent, the db is used
> > to free the resource used for the packet.
> > 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> Hi Fujita-san,
> 
> Some review from my side.
> 
> > ---
> >  drivers/net/ethernet/tehuti/Kconfig |    1 +
> >  drivers/net/ethernet/tehuti/tn40.c  | 1251 +++++++++++++++++++++++++++
> >  drivers/net/ethernet/tehuti/tn40.h  |  192 +++-
> >  3 files changed, 1443 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
> > index 849e3b4a71c1..4198fd59e42e 100644
> > --- a/drivers/net/ethernet/tehuti/Kconfig
> > +++ b/drivers/net/ethernet/tehuti/Kconfig
> > @@ -26,6 +26,7 @@ config TEHUTI
> >  config TEHUTI_TN40
> >  	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
> >  	depends on PCI
> > +	select FW_LOADER
> >  	help
> >  	  This driver supports 10G Ethernet adapters using Tehuti Networks
> >  	  TN40xx chips. Currently, adapters with Applied Micro Circuits
> 
> Not strictly related to this patch, but did you consider
> adding an entry in the MAINTAINERS file for this driver?

Sorry, somehow I missed that you have done that elsewhere
in this patchset.

