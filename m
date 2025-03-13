Return-Path: <netdev+bounces-174614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159CBA5F8BF
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552678816EB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01109267F45;
	Thu, 13 Mar 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4bYuuliP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB823BD13
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876846; cv=none; b=Le6mC0V7Qa3VDgSbj68rHZ1tAFz0yUMYvMlEru59cWkQGJMbpOtfLLtFxU1kpIgkX2zKsXJCkhKvRYZeBgq0Of+qNdukaeG0lOsRGoFZBvsEIhado42+VQagrPR/f4h6ZPSyPL7CwBCIqOtP6qW+TjWALDwJr574RFaZOeNk7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876846; c=relaxed/simple;
	bh=nI9AbJnxfbTMS5UjVGjV5UoqXhG3DsJYZCC1fGpKZ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kROpwG6KduD+IlZK8VM1mnzCK3FBEGcc2ZybIrekbRSyWPrT6myKXWA7gAC88fol1PuHexzk7SCHamgrpfpPPE3qibUKJqdRu/R6rM9urc3Xo4eexX1nHHDuLOwMDlHjZk5jT/XHkUldkjQ9I0RgG7BoN6OMN1Tv+fE4lh+3rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4bYuuliP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=XZW/g3ThEAnyNENzFYz6ga3h6ego0Ozi4SXbqk3r0cI=; b=4b
	YuuliP57NFCdjfOnZ3IHpFOSXDTpW363ckhPPTANwA7fNNrwsy+3Wz8s9Swk5NBPsfRM8uJvFMph4
	fhFeCiCc/dsFltVYKy49ecsROgLN/GYuDueqK8nfwlUHnpC1EEig5BcsNQ2eeBeVNlO8hl2Lxd1jw
	Ex2FBL8SD0aHX3c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsjjj-00518U-2p; Thu, 13 Mar 2025 15:40:39 +0100
Date: Thu, 13 Mar 2025 15:40:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net 08/13] net: dsa: mv88e6xxx: enable .rmu_disable() for
 6320 family
Message-ID: <9624f27a-8dd2-4e99-9f31-eff9b581d3fa@lunn.ch>
References: <20250313134146.27087-1-kabel@kernel.org>
 <20250313134146.27087-9-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313134146.27087-9-kabel@kernel.org>

On Thu, Mar 13, 2025 at 02:41:41PM +0100, Marek Behún wrote:
> Commit 9e5baf9b3636 ("net: dsa: mv88e6xxx: add RMU disable op") forgot
> to add the .rmu_disable() method for the 6320 family. Fix it.

Please add a justification for stable. The rules say:

  It must either fix a real bug that bothers people or just add a
  device ID.

How does this bother people?

Please look through all the patches in this set and split them between
net and net-next. They do not all meet this requirement.

Andrew

---
pw-bot: cr

