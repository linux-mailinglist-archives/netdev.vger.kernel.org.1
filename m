Return-Path: <netdev+bounces-199061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B2DADEC94
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2521C7A787B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0EF2EA15C;
	Wed, 18 Jun 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpTgTRhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D898F2DE204;
	Wed, 18 Jun 2025 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250049; cv=none; b=bJEme0JjVrWLsdly2puFyopO7OyaFdxWDFGrQFPvw0lXYJb2+AYM6Ko5P/PUel8zhYhSd0rHcrOgkXK8jvV89ucIL3tBFFZaAgeA9F1mV4R4IYek7zlXXKBMiRZXiwhwzwZvIX11GWsKaTgZqo0GIE4o6HIqygOiAczSTVvO4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250049; c=relaxed/simple;
	bh=CqtW2tNbfWVC0/PJLiDcBr6CPf9A3LFNx9bnw1lWXdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ5nzTDQl5UOd+kIe4QvgwjyTTbIOPQXuIkIir9qaTQCbO2q2lbkC2lhIpQ3Jf24q5jjp+TteaNKm9WdcLBz2aKOqyT8L4iJPn5iqxYp2sNKi+uw4lJQ0oOrX5TpX6gCYpNOVcooiX+2M5xq6PjHEKyc6SiU6t2oDtFiMaiU8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpTgTRhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69762C4CEE7;
	Wed, 18 Jun 2025 12:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750250049;
	bh=CqtW2tNbfWVC0/PJLiDcBr6CPf9A3LFNx9bnw1lWXdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpTgTRhZ5Xe4fvAIXro9/JvXN2JfjblpwUOUnRcBqCGPZSup2mjMvddb37oMtKb6H
	 DemTvUQikcwmPWnxqQQ8eTiq3qxBWqIMj4pwD3dJJeMSViSU66QQlrv7v66jmxDuE/
	 AAc7JVuyghm0VxJI885Hf5PPxHBNlXMwdHHx826DYGCFjttUm4HB//xmwiA2ALgOck
	 4RLazNONmA/0K5CcKnjBXaU7laoY2Mh9BGzEt1FFfIGkloZOZ/6QtoBsrYP/17Miwx
	 OuHmoVISw5s6HLY0Qc98cu3ADHkK+qv7clBzrdSYInRuW32zj23QK5Ad05D5OmNx/v
	 TgxRwiJWtqyzA==
Date: Wed, 18 Jun 2025 13:34:05 +0100
From: Simon Horman <horms@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Asmaa Mnebhi <asmaa@nvidia.com>
Subject: Re: [PATCH net v1] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not
 available
Message-ID: <20250618123405.GN1699@horms.kernel.org>
References: <20250613185129.1998882-1-davthompson@nvidia.com>
 <20250616124502.GA4750@horms.kernel.org>
 <MN0PR12MB5907DC095A95A1BA1F2472FDC773A@MN0PR12MB5907.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB5907DC095A95A1BA1F2472FDC773A@MN0PR12MB5907.namprd12.prod.outlook.com>

On Tue, Jun 17, 2025 at 08:07:37PM +0000, David Thompson wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, June 16, 2025 8:45 AM
> > To: David Thompson <davthompson@nvidia.com>
> > Cc: andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; u.kleine-koenig@baylibre.com;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Asmaa Mnebhi
> > <asmaa@nvidia.com>
> > Subject: Re: [PATCH net v1] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not
> > available
> > 
> > On Fri, Jun 13, 2025 at 06:51:29PM +0000, David Thompson wrote:
> > > The message "Error getting PHY irq. Use polling instead"
> > > is emitted when the mlxbf_gige driver is loaded by the kernel before
> > > the associated gpio-mlxbf driver, and thus the call to get the PHY IRQ
> > > fails since it is not yet available. The driver probe() must return
> > > -EPROBE_DEFER if acpi_dev_gpio_irq_get_by() returns the same.
> > >
> > > Signed-off-by: David Thompson <davthompson@nvidia.com>
> > > Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
> > 
> > Thanks David,
> > 
> > I as a bug fix this needs a Fixes tag, which you can add by simply replying to this
> > email.
> > 
> > Else we can treat it as an enhancement for net-next.
> 
> Yes, good point Simon.
> 
> This patch is a fix, so should have the following Fixes tag:
> 	Fixes: 6c2a6ddca763 ("net: mellanox: mlxbf_gige: Replace non-standard interrupt handling")

Thanks David,

I notice that in the meantime that this has been marked as Changes Requested
in patchwork. Presumably due to my earlier comment about a Fixes tag.

Could you post a v2 with the Fixes tag?

Feel free to also include
Reviewed-by: Simon Horman <horms@kernel.org>



