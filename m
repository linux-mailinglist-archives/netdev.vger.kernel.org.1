Return-Path: <netdev+bounces-246346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F5CE97D4
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19C8B3019B80
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D3212554;
	Tue, 30 Dec 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zqxbjTvD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865328F5B;
	Tue, 30 Dec 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092552; cv=none; b=SHp5N+54v4DwaueJIpc3xZJmQBKgSTvBvHFcKbfWBqEGYd25dvzoRqfsJ52CsyfWsF2824jOi01hCGSwVYRUbD353s3XljQ0kfkyb6U5iGqpAagMqOlDA9yZEQ/AeRZbpZR7U52gSF2XX6bu0eNI5Giyh4qQfbzomfu5az4cGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092552; c=relaxed/simple;
	bh=hyGR4Yw9uLbxt3DVmlj3NCZmO3oBisZJI46slB/d74s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkebW7Ct1vRCsLjeeQ0bULrTtzsrUvw8fu7l/tRRYKLmoZzKYx1rcJTvOXT6EXoqV403wqktdVe7zPlcQFxa1jQsEGIt/Djz9wHu5FEOYGssnvOHok2MNRbRBgNtEBxyGPtKv7sS5mKcRDMGOrhfn19NH93xPc4xk/Wm3FX1JIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zqxbjTvD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oDSISqItq20dAUa3QhlG5JmCf5mHPcKdFZF8J+jWsFs=; b=zqxbjTvDQ2ISbFSt5tUUefFEkh
	bpT+heMRDW1OvceAMmFTdNOVw1OaLSO50khSh8b+M67wTvcN37GWLSRHZgOUgLyAQEsyR3jFPV8IU
	oMnPGhRGmTVYUvY0ZqaNzV9Qf6Ffe2WNVbT3UTWgSOmbKlEWR3C4oJ49TZR/+XVL98no=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vaXUc-000rgn-8M; Tue, 30 Dec 2025 12:02:22 +0100
Date: Tue, 30 Dec 2025 12:02:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yohei Kojima <yk@y-koj.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: netdevsim: fix inconsistent carrier state
 after link/unlink
Message-ID: <1c8edd12-0933-4aae-8af3-307b133dce27@lunn.ch>
References: <cover.1767032397.git.yk@y-koj.net>
 <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>
 <e8180dc5-fc23-4044-bd67-92fc3eebdaa0@lunn.ch>
 <aVLc4J8SQYLPWdZZ@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVLc4J8SQYLPWdZZ@y-koj.net>

> Thank you for the quick reply. I don't intend for this patch to be
> backported to the stable tree. My understanding was that bugfix patches
> to the net tree should have Fixes: tag for historical tracking.
> 
> > 
> > netdevsim is not a real device. Do its bugs actually bother people?
> 
> This patch fixes a real bug that is seen when a developer tries to test
> TFO or netdevsim tests on NetworkManager-enabled systems: it causes
> false positives in kselftests on such systems.

O.K, then keep the Fixes tag and submit it for net. However, the tests
should be considered development work, and submitted to net-next, if
they are not fixes. Please split this into two series.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

