Return-Path: <netdev+bounces-93911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0118BD911
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BC41F22F21
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E633FE4;
	Tue,  7 May 2024 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LSCcqLyL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715F1366;
	Tue,  7 May 2024 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045984; cv=none; b=ZE41oG8ejF+cRjhGplEq5CNgxfcWvu8CcW3bLOGELVVQpQ3Bt9197CCdSjGKiDTxKKlFGKnBBjgFBSWFDjW2yKAUP52BrgxmOWn8ohQ/+Ai0QLAvFsqct11ilr9fmWOOpiGMb0KUbAxvv0DxQob9ss7ONaKgKDYVHO5L2F5ENOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045984; c=relaxed/simple;
	bh=E7ARgkhEsohvSTW2NzXTQRNpgaQd8EYbT7I4/e0wuUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2cvFpUEtkmgD+lFf1+3mUflam6OZI44Gc6TjQkncSUsye6menj3nOxCHw2mkthvlUm7V8/0ntVMViptjAWwPwK7Q57kePMLy8/0rQr4KBez7xaO+2ikcKyL83WB+1Jy59A+qVHgWU91m6mrMosqg/0h6Iak2qQH4/rzNiQ44IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LSCcqLyL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FXNp/q3EFc3VE1kfKaNpKliwa/x0VAgfl7uuP2pqXyQ=; b=LSCcqLyL687THwltEsK2assb/C
	3b7ONr5S/NsGuqh95g8ETyeP8w5OHcpqHaLc0f2gSm96GX23H4LOiSdNTsy6ncwZBxO9IgDWduXRi
	lTK3xu1MszAdGGQ3vtJ9d79ef6EE0jwM9E5+NQvD9ImJeGApkoQnF+02/XeRajB/S1RA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s49nd-00EoM8-2p; Tue, 07 May 2024 03:39:21 +0200
Date: Tue, 7 May 2024 03:39:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ricky Wu <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.co, anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com
Subject: Re: [PATCH] e1000e: fix link fluctuations problem
Message-ID: <f47e0bb6-fb3f-4d0e-923a-cdb5469b6cbe@lunn.ch>
References: <20240502091215.13068-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502091215.13068-1-en-wei.wu@canonical.com>

On Thu, May 02, 2024 at 05:12:15PM +0800, Ricky Wu wrote:
> As described in https://bugzilla.kernel.org/show_bug.cgi?id=218642,
> some e1000e NIC reports link up -> link down -> link up when hog-plugging
> the Ethernet cable.
> 
> The problem is because the unstable behavior of Link Status bit in
> PHY Status Register of some e1000e NIC.

Why PHY is this? It might be the PHY manufacture has an errata, since
this is probably not the MAC causing the problem, but the PHY itself.

	Andrew

