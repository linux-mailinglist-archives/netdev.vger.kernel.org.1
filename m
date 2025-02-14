Return-Path: <netdev+bounces-166427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59349A35F7A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05AE7188B88F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E22263F57;
	Fri, 14 Feb 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P2KUW794"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED82263C82;
	Fri, 14 Feb 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541237; cv=none; b=qulU88pceWhDYjHdAMITlQNd78rSdq5+E7t9YX37Z4jvOzAjlgfC4adVCAd102G1FsFrIj91v2SSJWiB8S4vn0QvFx/81MKvTE0YjR4xvVDoTq4eC8Mgp6YE+b1G2/VlxBuFNGeQ2/dV4dbh07cPVGl9zgbacFqKJ3weNC0hM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541237; c=relaxed/simple;
	bh=8ZFVNPkYOb2CptUJ8u3SwY9+0rQ0qA9DGmFWCHEH8lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErI9V2+f5Qk6EA/euOBnRYySio4GPrKMt/fT7bO0zPDU845HCX2LygvMDSwVP5vCMbLwkWcuKrHTvysPweYpjXu2W7vR4LI8C8cIX6Kt4kv9hxnoPyTYydtqr46g4iAO1Lxl/0ghlscAU/hZ8XRc7X1CBRLdladI2m98Yinr4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P2KUW794; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IP3d98N+f1HgUNJBWXpBJxp0KHTpgUbSL6byXT5O8Uc=; b=P2KUW7940YVrhuVj5OvJay7NSj
	6odEsSIDa6+HyX+7J/+nOdQYQfaznZQdG1K3BwUZxUmB/gUtz5hreqOH3ko/Wt19IDBVM8TYrlyGq
	gBLfjzgtqfWU/xdtW9ZLEHo4PW2llcYBA16G9V63mgH33Pc2UXaMLKD2NAXDA/VNUyso=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tiw8Y-00E5BK-Pm; Fri, 14 Feb 2025 14:53:46 +0100
Date: Fri, 14 Feb 2025 14:53:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add self test supported in
 this module
Message-ID: <9bc6a8b9-2d78-4aef-801d-21425426d3a1@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-3-shaojijie@huawei.com>
 <6501012c-fecf-42b3-a70a-2c8a968b6fbd@lunn.ch>
 <842c3542-95a6-4112-9c50-70226b0caadc@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <842c3542-95a6-4112-9c50-70226b0caadc@huawei.com>

On Fri, Feb 14, 2025 at 10:46:31AM +0800, Jijie Shao wrote:
> 
> on 2025/2/14 3:59, Andrew Lunn wrote:
> > On Thu, Feb 13, 2025 at 11:55:24AM +0800, Jijie Shao wrote:
> > > This patch supports many self test: Mac, SerDes and Phy.
> > > 
> > > To implement self test, this patch implements a simple packet sending and
> > > receiving function in the driver. By sending a packet in a specific format,
> > > driver considers that the test is successful if the packet is received.
> > > Otherwise, the test fails.
> > > 
> > > The SerDes hardware is on the BMC side, Therefore, when the SerDes loopback
> > > need enabled, driver notifies the BMC through an event message.
> > > 
> > > Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> > Please take a look at the work Gerhard Engleder is doing, and try not
> > to reinvent net/core/selftest.c
> > 
> >      Andrew
> 
> I actually knew about this, but after browsing the source code, I gave up using it.
> 
> I have an additional requirement: serdes loopback and mac loopback.
> However, they are not supported in net/core/selftest.c.

Which is why i pointed you toward Gerhard. He found similar
limitations in the code, wanting to add in extra tests, same as you.
Two developers wanting to do that same things, suggests the core
should be extended to support that, not two different copies hidden
away in drivers.

Maybe my initial advice about not exporting the helpers was bad? I
don't know. Please chat with Gerhard and come up with a design that
makes the core usable for both your uses cases, and anybody else
wanting to embed similar self tests in their driver.

	Andrew

