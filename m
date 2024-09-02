Return-Path: <netdev+bounces-124261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B099968B8D
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAB31F21219
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C751A3024;
	Mon,  2 Sep 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MPDN5YLZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077742AB7
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293094; cv=none; b=RXmVCUDrHAcEB8x/T4F57EvTjVLf/8e7WCh0Y2sL4OVNCXz8eSiaIhOrkRc7lc7DUlF11ymz3gMlJab75SAeLS+qwUoIMb1wibPpmk/XfCi2k4pM9x9mkhKDFyImBuvpmDa3cIK4+fhNeZsTRO4Jkg8x6NE9UHrNx1OHZTPePA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293094; c=relaxed/simple;
	bh=NchOCM/dMTLDu67uRYyctxWnlTV9l9IiRxqH4WVGPEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rl/TCFMIhEEmdrluNMOfE5GjOTVEwtcsb/66nfwL5Ghd6iyjXlfdEy10qQtNWZKnnK4Kk9mmTT8wRCf3FdGvuYCKQuVsqGngu+5ojM3er7z1tAX3RIxQskQQpffhUEQQ83FWxowJKw8x4TQHD8q2QwrbP+P812Gym87B7Yorua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MPDN5YLZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gsswcvCXYw25bPATotJK9XQVHQsp1B4V6qyjfC70Ww8=; b=MPDN5YLZ2CI2K0LgEEi1umS6+G
	wbaX90XA37Dj9XqdYu/a5b6lrzDcf+10R8cn6WPd2NYlVP+LMLOALkvKJBnBe0jFFRS/jRpFVyVGo
	8ngTzqJWfscgmK8BEHxvlTsGKy8ytzMTk0StFnwNtHBzEpD/A8QjRKOjDPxOUZ0u/jz8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sl9Xg-006K53-M2; Mon, 02 Sep 2024 18:04:36 +0200
Date: Mon, 2 Sep 2024 18:04:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH v1 net-next] e1000e: Remove duplicated writel() in
 e1000_configure_tx/rx()
Message-ID: <87af1b9e-21c3-4c22-861a-b917b5cd82c2@lunn.ch>
References: <20240902061454.85744-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902061454.85744-1-takamitz@amazon.co.jp>

On Mon, Sep 02, 2024 at 03:14:54PM +0900, Takamitsu Iwai wrote:
> Duplicated register initialization codes exist in e1000_configure_tx()
> and e1000_configure_rx().

What does the datasheet say about these registers? Since we are
talking about hardware here, before you remove anything you need to be
sure these writes are not actually required by the hardware.

> commit 0845d45e900c ("e1000e: Modify Tx/Rx configurations to avoid
> null pointer dereferences in e1000_open") has introduced these
> writel(). This commit moved register writing to
> e1000_configure_tx/rx(), and as result, it caused duplication in
> e1000_configure_tx/rx().

Did the same sequence of read/writes happen before 0845d45e900c? Or
did 0845d45e900c add additional writes, not just move them around?

	Andrew

