Return-Path: <netdev+bounces-124128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C673496831E
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02DB71C2253A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7821C2DB0;
	Mon,  2 Sep 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lzrkKoqB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C679C187355;
	Mon,  2 Sep 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269015; cv=none; b=iZ3dwL4l/+zac2cISsPzfQV9u4mA727UB4RedRL3v+Wn5VHqzZZ6jo9RXkE61Xept5FSWQh++W9O9FaSH2jH4saPMbGCuWDlPVZ5NEwQRbo+dDn6jsHAqGXI3hcxnOVIFYUyjhRUZaTvjxASxGMZK3/WcufBbFPy6DinDPQ2Za0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269015; c=relaxed/simple;
	bh=cCFseqcH4z5OSqatyQ8Njvobnvsuzyx5wOOXtcdAbc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAX7UY/u1SngF7yzQ7XUPAhtP/Zsyq28Jx0JlqXuNYyq2BvAmz6FH9L5gHdMYLpMwQ+OKFUy2pxZ/vRExEY4SEIlUKH3UiOdg3OUyfz9KPtXDShAjZqjexk4VjBllZtSyh2jp+KTdNxRp07jIssn+DXVt9/CTI218gkuvEAP2E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lzrkKoqB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k8fNp4lPEgrhIlaN+v3O0Q3/cbsRJ7Y/SUZlytKJl78=; b=lzrkKoqBk9ddfuYiQtaezmQCY9
	qQH6VLJGsuaTvibz6mCM2E9uabi/UmI2NBr3jqZIfsGHTOqS82k4aeyDGpEZCs2sF2voB0R9FjoQk
	/Nc8uO6wF5RW1GjfkGRByItVtxpE6Q6Ptn84BGh0lTJX4B7vd77ZPie49HMycq4bCFQoImQZ4aoOo
	+Vthr5UiNlFXpf1FevZxIXuH9a6Fy6ul9uhETJk2nIKCN3wL84YCyxUEWzY7iFDs3yRlC/Qgb5yq4
	Ih4JhokutM3IeqTvOiithyBNEcT/ZGP4yM2HUxCdimtYfiiHTVkwnpqv/7SGtJCAJmbS00llXWDzz
	XYyX7uog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46394)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sl3HF-0005tr-2y;
	Mon, 02 Sep 2024 10:23:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sl3H9-0001gG-1n;
	Mon, 02 Sep 2024 10:23:07 +0100
Date: Mon, 2 Sep 2024 10:23:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wentai Deng <wtdeng24@m.fudan.edu.cn>
Cc: davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	=?utf-8?B?5p2c6Zuq55uI?= <21210240012@m.fudan.edu.cn>
Subject: Re: [BUG] Possible Use-After-Free Vulnerability in ether3 Driver Due
 to Race Condition
Message-ID: <ZtWD+/veJzhA9WH2@shell.armlinux.org.uk>
References: <tencent_4212C4F240B0666B49355184@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4212C4F240B0666B49355184@qq.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 02, 2024 at 01:19:43PM +0800, Wentai Deng wrote:
> In the ether3_probe function, a timer is initialized with a callback function ether3_ledoff, bound to &amp;prev(dev)-&gt;timer. Once the timer is started, there is a risk of a race condition if the module or device is removed, triggering the ether3_remove function to perform cleanup. The sequence of operations that may lead to a UAF bug is as follows:
> 
> 
> CPU0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CPU1
> 
> 
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; &nbsp;ether3_ledoff
> ether3_remove&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
> &nbsp; &nbsp; free_netdev(dev);&nbsp; &nbsp; &nbsp; &nbsp;|
> &nbsp; &nbsp; put_device&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
> &nbsp; &nbsp; kfree(dev);&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; &nbsp; &nbsp; &nbsp;ether3_outw(priv(dev)-&gt;regs.config2 |= CFG2_CTRLO, REG_CONFIG2);
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; &nbsp; &nbsp; &nbsp;// use dev

This is unreadable.

> Request for Review:
> 
> 
> We would appreciate your expert insight to confirm whether this vulnerability indeed poses a risk to the system, and if the proposed fix is appropriate.

Please resend without the HTML junk in the plain text part.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

