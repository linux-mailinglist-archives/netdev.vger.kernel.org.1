Return-Path: <netdev+bounces-95462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA28D8C24EE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838AF281BF0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7AC3FB87;
	Fri, 10 May 2024 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l8giWwHL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606597710E;
	Fri, 10 May 2024 12:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344353; cv=none; b=Zug3rkqPatbnA7AFpz6bKMZFeBtB63ltnzpZzDiaKH4CFFUgYCQZGaP8DGV1Z8d+PcGcLCO3ozRuPiL3v2EqQt+wh9OfTKQanGpadE4JIRAwBTHLg4XVFWyeBEPRCpe53RsRaeTyXJ3DKgffYS96hESkNGPR8na1tsxJsqIELXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344353; c=relaxed/simple;
	bh=ccfbAEPf5Tst3ce/2QUnbg7oKbMUyZkRFSjGp/BIMQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+hjDYl8h38KpW49EB0/WI2G/NGJKBnNp0uubQVL6HyZ66ddi2IHE9JIZZH0ddb42oWonzuIVjJ1f8KEKSLU6jFHNFSjnJ7kSngKcKp/rjlYiNCTvH9g3RURVCsnoyh8vHmmMiCD9vSMfo+yHYukMN/ar5yGaJKH4GEx3V7A2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=l8giWwHL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kYvLhiz8ZLdgpAJEUaG2GVgbiir4S057iWOlDZef/0A=; b=l8giWwHL5386gqDRGg9X+/i37t
	y1gLXjhj29wp1iMLa1uTcOfyWlUaZmX1DYOACtP7FTH8v0FJHWOadnRlrEnJIk28bhkz39vC3DjXC
	QVmx0mej7C9WEUlEiGWuptRsVAaB0CHhLA0CNl4un2IEJI54qYFriO0XRqQZQu0ObbM4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5PQE-00F8RW-PQ; Fri, 10 May 2024 14:32:22 +0200
Date: Fri, 10 May 2024 14:32:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
	Ricky Wu <en-wei.wu@canonical.com>, netdev@vger.kernel.org,
	rickywu0421@gmail.com, linux-kernel@vger.kernel.org,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org, anthony.l.nguyen@intel.com, pabeni@redhat.com,
	davem@davemloft.net, "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"naamax.meir" <naamax.meir@linux.intel.com>,
	"Avivi, Amir" <amir.avivi@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 2/2] e1000e: fix link fluctuations
 problem
Message-ID: <5669c185-db96-4ac2-81d5-2198060ae77d@lunn.ch>
References: <20240503101836.32755-1-en-wei.wu@canonical.com>
 <83a2c15e-12ef-4a33-a1f1-8801acb78724@lunn.ch>
 <514e990b-50c6-419b-96f2-09c3d04a2fda@intel.com>
 <334396b5-0acc-43f7-b046-30bcdab1b6fb@intel.com>
 <cc58ecfc-53f1-4154-bc38-e73964a59e16@lunn.ch>
 <b288926e-f9d6-48d5-9851-078a6c9912bf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b288926e-f9d6-48d5-9851-078a6c9912bf@intel.com>

> > It would be interesting to see what the link partner sees. What does
> > it think the I219-LM is advertising? Is it advertising 1000BaseT_Half?
> 
> i219 parts come with LSI PHY. 1000BASE-T half-duplex is not supported.
> 1000BASET half-duplex not advertised in IEEE 1000BASE-T Control Register 9.

That is the theory. But in practice? What does the link partner really
see? I've come across systems which get advertisement wrong. However,
in that case, i suspect it is the software above the PHY, not the PHY
itself which was wrong.

	Andrew

