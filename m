Return-Path: <netdev+bounces-202894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B233AEF935
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C616F440
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A62273D7D;
	Tue,  1 Jul 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCf6r4Vs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1D82727E5;
	Tue,  1 Jul 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374315; cv=none; b=V/co8kpRlfNRW8FhPGw2IbvLO9osuxTgH93HHmXxebG++3IQNCrPF0LvQq2DCEHF9I66I6gAxeclPBZRYY6wdc8PeDHEKJRg5DS0O6VeEr6pbVgrxadUReu5jR7z0PX0Cb+GywcWrAsG1xVGZPKzCeyCup52hyaFQxLMFcRbYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374315; c=relaxed/simple;
	bh=+MKN7YXAva8+pY6XRhpucJBWGbDIuQoTwCcLllZQFm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I93Yci6VMVXol7d2aCkF9vRC3oVNdWhiALxoDPnGIod+DWwJ6DFRDSaZ1Vyn07ND9CWaSsMnkn1sLo34KdgJLYW2cRTnC+kF364aNoSsdtHTY4lrK65QY8cVrklH6cEgxXKqYNvOWe60IsldE1L9oiK+oGXHDIJ6/21/VLaUxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCf6r4Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A8EC4CEEB;
	Tue,  1 Jul 2025 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374314;
	bh=+MKN7YXAva8+pY6XRhpucJBWGbDIuQoTwCcLllZQFm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCf6r4VseIB/TZuVhSx8kaDmlL6YGp/18kJm1ahC3ffFPiTkBvOv+ys8Ycsg7qwF1
	 WG/fZZQt/cBimoRbWoKmKyB3gFikFxDVTlJinUbXVvMmMk2mtZYNwTxHDk7qoAeD8D
	 ygFyj9PG1iTbz1ZOgJA5abbSO5mJk+iDh+sW4+IsGRh/H82IglHFlRcM5JDMzSUHqs
	 7WDh/ro/bnw0W5bVISXlQxiKMjO8KnBtTOR4wVStnhWbSUWwmvAwmJnmR+fNEJS8YL
	 rg8Qd+EMIsFYn33ROR3kzcWoBPMK3GeIbHOq1FJVcEpLD99ZKTwmk2+Mh3+W28Zzps
	 gw1+zkGbpuvzw==
Date: Tue, 1 Jul 2025 13:51:50 +0100
From: Simon Horman <horms@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Asmaa Mnebhi <asmaa@nvidia.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v1] mlxbf_gige: emit messages during open and
 probe failures
Message-ID: <20250701125150.GR41770@horms.kernel.org>
References: <20250613174228.1542237-1-davthompson@nvidia.com>
 <20250616135710.GA6918@horms.kernel.org>
 <ecadea91-7406-49ff-a931-00c425a9790a@intel.com>
 <20250616191750.GB5000@horms.kernel.org>
 <PH7PR12MB5902AE4A0311CA4B47F02F8FC741A@PH7PR12MB5902.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR12MB5902AE4A0311CA4B47F02F8FC741A@PH7PR12MB5902.namprd12.prod.outlook.com>

On Tue, Jul 01, 2025 at 12:44:14AM +0000, David Thompson wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, June 16, 2025 3:18 PM
> > To: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Cc: David Thompson <davthompson@nvidia.com>; andrew+netdev@lunn.ch;
> > davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; Asmaa Mnebhi <asmaa@nvidia.com>; u.kleine-
> > koenig@baylibre.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH net-next v1] mlxbf_gige: emit messages during open and
> > probe failures
> > 
> > On Mon, Jun 16, 2025 at 04:06:49PM +0200, Alexander Lobakin wrote:
> > > From: Simon Horman <horms@kernel.org>
> > > Date: Mon, 16 Jun 2025 14:57:10 +0100
> > >
> > > > On Fri, Jun 13, 2025 at 05:42:28PM +0000, David Thompson wrote:
> > > >> The open() and probe() functions of the mlxbf_gige driver check for
> > > >> errors during initialization, but do not provide details regarding
> > > >> the errors. The mlxbf_gige driver should provide error details in
> > > >> the kernel log, noting what step of initialization failed.
> > > >>
> > > >> Signed-off-by: David Thompson <davthompson@nvidia.com>
> > > >
> > > > Hi David,
> > > >
> > > > I do have some reservations about the value of printing out raw err
> > > > values. But I also see that the logging added by this patch is
> > > > consistent with existing code in this driver.
> > > > So in that context I agree this is appropriate.
> > > >
> > > > Reviewed-by: Simon Horman <horms@kernel.org>
> > >
> > > I still think it's better to encourage people to use %pe for printing
> > > error codes. The already existing messages could be improved later,
> > > but then at least no new places would sneak in.
> > 
> > Thanks, I agree that is reasonable.
> > And as a bonus the patch-set could update existing messages.
> > 
> > David, could you consider making this so?
> 
> Sorry for late response.
> 
> Yes, will look into updating this patch to use %pe
> 
> Thanks for the feedback.

Thanks, much appreciated.

