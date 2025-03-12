Return-Path: <netdev+bounces-174197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB952A5DD65
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA597ACC65
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE382459C1;
	Wed, 12 Mar 2025 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sPrSTwdv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387D24634F
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784771; cv=none; b=OxTozYB1MUAUidI23JTqkvWCEs57cxqi5ZfsQVJs0i+5GCywtRxV6EmVecjxD0YVEC9dsYY1rYNRPOGkfQFQ8yI+Oae0TXHuGYqBak/urAq+6Cf9hR3CfZZCCuoqyKnuanNN8Qz0u9onUv7mWgUiYBnKoOvhh0hBdHJmuAZTPmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784771; c=relaxed/simple;
	bh=m6Fbrxm4R2/LCjXv3kXKUmWdKhjaxGM3CoDE+tpZZwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=li9aAH46ufJqdlHtQURfod5wfMYESeODv+g6gHq12SJluYqyOA7t4rplP2HtjWpClCJk6kFfFnxmJ998E314OR0L4eAwR1wluO5nKwcqiJlXfT/eL3S9Cy3umuGptGoEbXxNbsn3w4qGkLlFpXEax0KvvGMgEWdDczJFtQnM22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sPrSTwdv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KO4VVVT/RtKl517J0cn8cyrIOvSu1StRHJFRtRyxnEE=; b=sPrSTwdvJh0NGBdXclgJRY+ZEz
	LfRKtu4lMUIMPS3uY+4wLpZ6ldyFO7mFjaIKpFQS4XiQCQFENe+s8UkeGV73FTQ6LYHRWUW3kcoqi
	qM/UStunnWoenvQv4eknDiXEk8QriN0HWo4T1aa8h4o8APKSfuIwOHqZoOwI7K8/BBp8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsLmW-004fSw-IR; Wed, 12 Mar 2025 14:05:56 +0100
Date: Wed, 12 Mar 2025 14:05:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] igb: Prevent IPCFGN write resetting autoneg
 advertisement register
Message-ID: <eae8e09c-f571-4016-b11d-88611a2b368f@lunn.ch>
References: <20250312032251.2259794-1-hamish.martin@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312032251.2259794-1-hamish.martin@alliedtelesis.co.nz>

On Wed, Mar 12, 2025 at 04:22:50PM +1300, Hamish Martin wrote:
> An issue is observed on the i210 when autonegotiation advertisement is set
> to a specific subset of the supported speeds but the requested settings
> are not correctly set in the Copper Auto-Negotiation Advertisement Register
> (Page 0, Register 4).
> Initially, the advertisement register is correctly set by the driver code
> (in igb_phy_setup_autoneg()) but this register's contents are modified as a
> result of a later write to the IPCNFG register in igb_set_eee_i350(). It is
> unclear what the mechanism is for the write of the IPCNFG register to lead
> to the change in the autoneg advertisement register.
> The issue can be observed by, for example, restricting the advertised speed
> to just 10MFull. The expected result would be that the link would come up
> at 10MFull, but actually the phy ends up advertising a full suite of speeds
> and the link will come up at 100MFull.
> 
> The problem is avoided by ensuring that the write to the IPCNFG register
> occurs before the write to the autoneg advertisement register.

When you set the advertisement for only 10BaseT Full, what EEE
settings are applied? It could be that calling igb_set_eee_i350() to
advertise EEE for 100BaseT Full and 1000BaseT Full, while only
advertising link mode 10BaseT causes the change to the autoneg
register.

Please try only advertising EEE modes which fit with the basic link
mode advertising.

     Andrew

