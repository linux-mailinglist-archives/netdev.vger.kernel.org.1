Return-Path: <netdev+bounces-250585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F41D37A37
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 458BB302E078
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A833F8B7;
	Fri, 16 Jan 2026 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0mrgd8Ss"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4A337B91;
	Fri, 16 Jan 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584775; cv=none; b=IQYZ9Ly2h5ttoEHSm5lzd9SE/00mFqS8XlkdjRX9z4ujR+8ZNot9h3M/qiRK0IX3DTgBdT5JTCUGMQXTqB4DJ82xbI/HqaGgIK9pCQmJUcGDfnjDLViNyf4InKWFp2OZgqnNdBXwYQ7+3F4ijVj8MVCqPG8kJAlXTUmsD8ystdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584775; c=relaxed/simple;
	bh=YyvyrsGhMbFFDQKb6NiNeT+k/FsQborlUQWPjAXpp3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1dI2i6fKPjdDR7l4zXTt5gzKcKY8y0N68wNDwVa3v3creJWpKkZM4eke8HwK4MyhDRkFgtSaSwZhzGujn1zPquarmTg+WcalHPcycBICxFC/2WT3kYQlNqk0k38yD57QtEysVe7/2QMrvLT4hy1aXZtdEnkVEcRTm5fHaVx6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0mrgd8Ss; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NLErl4gvK4Y6j6GKoVV2CPKisx29kEhGwGnW45BCQVA=; b=0mrgd8SsKEWO0/U6VH1OOSWZPr
	Our3oHj2A6KaqaaddV8Gn55ACMyMk6XJ9YE3radbRgYjQ5uGNzRLC7DscGRkw3fNfxLocZbKqSJcw
	eCI7CGmBfxbxnSP+cuiO1BRKZGT9uY1VT48wusMkv4IqjvPWWavYt8NSupCyc/4DESVU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgngn-0036Fb-Uc; Fri, 16 Jan 2026 18:32:49 +0100
Date: Fri, 16 Jan 2026 18:32:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: insyelu <insyelu@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, nic_swsd@realtek.com,
	tiwai@suse.de, hayeswang@realtek.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Message-ID: <974e39e1-490c-4d61-87fc-6d8249cf8c25@lunn.ch>
References: <20260114025622.24348-1-insyelu@gmail.com>
 <20260116023725.8095-1-insyelu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116023725.8095-1-insyelu@gmail.com>

On Fri, Jan 16, 2026 at 10:37:25AM +0800, insyelu wrote:
> When the TX queue length reaches the threshold, the netdev watchdog
> immediately detects a TX queue timeout.
> 
> This patch updates the trans_start timestamp of the transmit queue
> on every asynchronous USB URB submission along the transmit path,
> ensuring that the network watchdog accurately reflects ongoing
> transmission activity.
> 
> Signed-off-by: insyelu <insyelu@gmail.com>
> ---
> v2: Update the transmit timestamp when submitting the USB URB.

Always create a new thread for a new version of a patch. The CI/CD
system just thinks this is a discussion comment, so has ignored it.

    Andrew

---
pw-bot: cr

