Return-Path: <netdev+bounces-53275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0CC801E21
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68632B20B85
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 18:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0537DF9D5;
	Sat,  2 Dec 2023 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5yZi5op"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E428828
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 18:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE6EC433C7;
	Sat,  2 Dec 2023 18:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701543527;
	bh=pGZmxg4gMuH9Y/xp6YNdSj3V/YUamxIEYzNm/xMRWhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5yZi5optou1fyuiBv5bgcirRha8rYqhwkAX11o+bLsdJBri1Fmv7k+S5o9F9lJfA
	 isTpc5oXp+nyuu7xLVXXETZby8sI2NMCWrokZ0+gnZbq30UjgodzuG6bCvrrIZftM6
	 4lGBJ7iHwt94DT1YeWwhZ9hQ8pYaabSpMxuRHsX6s2PVwRI37XHV4fyYjBSUvYdLP2
	 tI6GWln+sXwdCT+o4lvbpWZVshBW1fXT2ncZFBFXq969gGcxDO3xerB/Xrwty+dTam
	 9abRCz+Rxabl05bmByuODvkNSB3GAUNWTxdMvrWn9DGk+xLapAQelv8vlNKtlyvwfU
	 dDSaOLegQx/3A==
Date: Sat, 2 Dec 2023 10:58:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Justin Lai <justinlai0215@realtek.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Message-ID: <20231202105845.12e27e31@kernel.org>
In-Reply-To: <27b2b87a-929d-4b97-9265-303391982d27@lunn.ch>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
	<20231130114327.1530225-2-justinlai0215@realtek.com>
	<20231201203602.7e380716@kernel.org>
	<27b2b87a-929d-4b97-9265-303391982d27@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Dec 2023 17:27:57 +0100 Andrew Lunn wrote:
> > > + *  The block of the Realtek RTL90xx series is our entire chip architecture,
> > > + *  the GMAC is connected to the switch core, and there is no PHY in between.
> > > + *  In addition, this driver is mainly used to control GMAC, but does not
> > > + *  control the switch core, so it is not the same as DSA.  
> > 
> > Okay, but you seem to only register one netdev.
> > 
> > Which MAC is it for?  
> 
> The GMAC one. This is going to be a DSA system, and this driver is for
> the conduit MAC the CPU uses. At some point, i hope there is a DSA
> driver added, or the existing realtek driver is extended to support
> this switch.

Oh, thanks, it even says so in the comment. I blame it on late night
reviewing. I was confused by the "driver [...] does not control the
switch core, so it is not the same as DSA." Looking at the discussion
in v3 it sounds like the switch is controlled by a different PCI
function? In which case it very much sounds like DSA. Or maybe there
was a minor misunderstanding there, and the driver will need MFD /
auxbus, which is still close to DSA.

I'm mainly asking to make sure we avoid "implicitly programming" the
switch, like, IIUC, one of the TI drivers did. And we ended up with
multiple versions / modes of operation :( Sounds like this driver
doesn't touch switch registers yet, tho, so all good.

