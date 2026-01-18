Return-Path: <netdev+bounces-250903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9588AD397D0
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EA0300943D
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63CD1E5B7B;
	Sun, 18 Jan 2026 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VOz+D9DB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46461FFE;
	Sun, 18 Jan 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768753175; cv=none; b=mwsOlUSnDXuY8RQGkzR8hlaNfwfL2RRyPR98G1WLaFAwz8XkjfULDERZjyC8aTuwhrzQUOvWoHwNcWjBerGje+lXnjHtB34uiBXx8Nbw9mu49u0BDxu/NPIyfx4Zw80bvxtWfrSiijMFy04QdBjmLN0Yy6mCYrU296KV0eDAjso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768753175; c=relaxed/simple;
	bh=mvm4GAWVC8IrveS7IkSffpXzYV+JQDFIgrifhA7iDtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzRH2BxNkhiTWm0CuQN/xOtvoexRYZzZW/CMShmoeoeJsmAYRmbOJ4ZoZsVeIYnQfXO1Hh5WSEXIqWrLVczdByp4rhXnjf9JwcmUIGOKDT2cZwSPPPOA9Kekq5pU5J+iUzEbx++BMjz3rG6JfmA4L/pl5T1FYig4A23/wob6YMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VOz+D9DB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H5HJXUwqIdvCMxkNpGmqIKMuEfnbyUKuPXOj3lNiwF8=; b=VOz+D9DB+Je0+GUUx1VGDZeu1i
	WEndDPhS7lPav4Z/2raVz1tWppaaFUqKn6tR6oQquy7sh4N+KDk830AmwZEvG2Vg/RKjP+QMFZcOh
	jcKfQEMkKSHuYmOyPnvLlDL8C8ePCOqexoCo/6qs8G2HAQD6ooJ+sdU+4Lvw7QBckEmA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhVUS-003Mo7-Ui; Sun, 18 Jan 2026 17:19:00 +0100
Date: Sun, 18 Jan 2026 17:19:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Yixun Lan <dlan@gentoo.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net: spacemit: Check netif_carrier_ok when reading
 stats
Message-ID: <3659a81b-4393-4a8d-bc8d-6ab89396353d@lunn.ch>
References: <20260118100000.224793-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118100000.224793-1-amadeus@jmu.edu.cn>

On Sun, Jan 18, 2026 at 06:00:00PM +0800, Chukun Pan wrote:
> Currently, when the interface is not linked up, reading the interface
> stats will print several timeout logs. Add a netif_carrier_ok check to
> the emac_stats_update function to avoid this situation:
> 
> root@OpenWrt:~# ubus call network.device status
> [  120.365060] k1_emac cac81000.ethernet eth1: Read stat timeout

What is the real issue here? That a clock is disabled? Can you test
the status of the clock, rather than adding yet more conditions to
this if ()?

     Andrew

