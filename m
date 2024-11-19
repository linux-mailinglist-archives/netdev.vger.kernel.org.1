Return-Path: <netdev+bounces-146252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086F9D2724
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37A81F245CE
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4E1CEE94;
	Tue, 19 Nov 2024 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jyBeVuQ8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7171CFEA1;
	Tue, 19 Nov 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023515; cv=none; b=GhFU0+fZkRCFG8KqaUdTO+D8WT9ld67bymiVbyxXCF1aUQ6XFGN34cgyh6/+RC4RyK9lX2cbhjpt2oMst7ymjrjFsVj0yf1qy2mjTtx+t1vQpbGPYK3GdEJaeZo+W2jHHTQQee+yB8NQ4GvejsWjLm9MKOegLdT1FStTpCaXtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023515; c=relaxed/simple;
	bh=B1gLukyJOHHf8VPzOe6Ywb+soBypYIi+x5d3PReHJlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqVnlMl95f9TgX6ncN0MjFTUzIxRcpJHOpwdFKsgmeN5gKG7U5zgEz4OK0y4HWaO3zAFXZ9ZNmTrOfbDhtudFyFuyN0sEIX6BerxSxnY+FAyAanLaTHJybAbZ8wJ4ndi1MpYfRzaaziuf3SsWLkeiB/K/itwYO+x32jRvAfOsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jyBeVuQ8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n/8L6jiP0MMCe6YnhTtuyP2MV88r7Yd1I8/6RUdDlQk=; b=jyBeVuQ8YgM7rp6UTaSBQbCsgi
	mUDUUxwYRmnKMSB5N+E5ZWXUQtgvZnVfVaMnKw9RSolP/Xuy6ITn6EpVwkHvrwO0uhs9acKbe1Zl+
	irmKSRLWDJuTQJCPamsfM/q/N7vUSwxctESCXcYB0NwMaTmDJIbAF78zYiq4Ckk2mP4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDOQx-00Dnxs-62; Tue, 19 Nov 2024 14:38:23 +0100
Date: Tue, 19 Nov 2024 14:38:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add
 bindings for AXI 2.5G MAC
Message-ID: <d25ad78f-a009-4a0e-9052-ed247e6a2afc@lunn.ch>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-2-suraj.gupta2@amd.com>
 <20241118165451.6a8b53ed@fedora.home>
 <410bf89c-7218-463d-9edf-f43fc1047c89@linux.dev>
 <ce534b32-7363-4433-8b1d-4e01c3d92084@lunn.ch>
 <BL3PR12MB657106F2B29FE44123C672EEC9202@BL3PR12MB6571.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB657106F2B29FE44123C672EEC9202@BL3PR12MB6571.namprd12.prod.outlook.com>

> > Do you mean 2.5G is a synthesis option? Or are you saying it has always been able
> > to do 2.5G, but nobody has added the needed code?
> > 
> > This is a pretty unusual use of max-speed, so i would like to fully understand why it
> > is being used before allowing it.
> > 
> >         Andrew
> 

> 2.5G support was already there in hardware, driver is getting
> upstream now. 1G or 2.5G configuration needs to be selected before
> synthesis. In 2.5G configuration it supports only 2.5G speed.

So when the PCS is fixed to 2.5G, are you planning on using rate
adaptation to support lower speeds? There are a few systems doing
this, mostly by using pause frames between the PHY and the MAC.

> I'm exploring registers to get 1G / 2.5G selections information
> instead of using max-speed. Will send next series soon.

That would be best. The PCS might itself report its
capabilities. Sometimes there is the equivalent of the BMSR.

> Just for my understanding, could you please share the use of
> max-speed DT property if possible?

It is generally used to remove higher speed operation because they are
broken for a particular board. It should be considered a board
property, not a SoC property.

	Andrew

