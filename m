Return-Path: <netdev+bounces-167399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E79A3A264
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2141889FF9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760E526E63E;
	Tue, 18 Feb 2025 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Q+/BuoE+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345226E15A;
	Tue, 18 Feb 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895373; cv=none; b=jEcJAHRELtwaoPCxVWaRZyeQf1+CvkwKLUCHD8FPbI69Y0vrmX3Clp74Ti/EdySfpx7ltTJoyRGEBDzSsCFJC8SWjGvVzybLdNI8GvoC97OUvs8zF9NV8zSRNReKKqEUg3UME/M6EIGk65DG5ejxtdhUKb1gwTZAnn071o9qSxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895373; c=relaxed/simple;
	bh=0MOKGvsPRSG1U618hGedCatAETAqCMPW9NYg828vZb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqJGbsciHj/Nwp0v1ZD3yw/K51RPMHDbM6AbpAxykBKX2zUBlbUGP3GjZDSUfLkA/PoNY04xq0qfm0jhyy9DNSWlSgzZkKuwzbHqDD7pOPN7vDWgBlnOJMkP/doFe4Df4kiVcWwOpxSQ1acJyEq7Xx7I0S1BzGMv7v2YG64p6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Q+/BuoE+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7CW4v4AoHa6ABcgvmCbVdRqCmm5FyrKaem/pFda21aQ=; b=Q+/BuoE+1urhxGFcvtl35FVsxq
	S6wbn84edysVF5aBP5POmy5hFKja8DXTSGp0ryQrLMhEF+LaPD3lf3JAtrn89xZCWuP7i2vnQHmVz
	RbZO0rMdpIDeE8JpcQTYEWqOADi0Ecjwn77kqHQg9NsCpHNBsRd1PaimO6xJIRvm8pB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkQGV-00FLaL-3P; Tue, 18 Feb 2025 17:16:07 +0100
Date: Tue, 18 Feb 2025 17:16:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next] net: xilinx: axienet: Implement BQL
Message-ID: <da67b82c-1068-41c8-93d6-df0e7b009e4a@lunn.ch>
References: <20250214211252.2615573-1-sean.anderson@linux.dev>
 <BL3PR12MB6571A18DA9E284A301FF70FAC9F92@BL3PR12MB6571.namprd12.prod.outlook.com>
 <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>

> > Could you please check if BQL can be implemented for DMAengine flow?
> 
> I can have a look, but TBH I do not test the dma engine configuration since it is
> so much slower.

It might actually benefit more from BQL if it is slower?

	Andrew

