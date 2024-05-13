Return-Path: <netdev+bounces-96144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA78C47DA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7883828324E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917227711C;
	Mon, 13 May 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVWZOSVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69211757FB;
	Mon, 13 May 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629815; cv=none; b=cpqx/sYZjFsjQoBerF1xpV6ti0Rpe7IJlJkVzzZAw0yYAku7++PHfg3Tt7s04nPfJGMLDWecUyGYfY2yLxM0wBkWjvuYwVWWNnZjExxt9Vc1a0X0kv3U03XzKHykPQzfcrEzteLk0LKXvcZFhuWxl/Bys9RMT1bNKnT9og3HWTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629815; c=relaxed/simple;
	bh=NrfU76rQkDacMih4EfCdtj4kvNf3aCwAPMB9IErV4bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWTMgDDKf3SKejUmKrsE+rLCNvR6aVjoidqDmdRRUWL0POM40ZuxCPktTHX7fDqsaqcVBZCQr+y/NTvXhj26VwKtfo41VTConypzZR7823rXbS6TckBP54O0WEuqdJAdYtabjVMueBpSaYnVzt78eBtP8LFHzC4aWcZcOmCGcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVWZOSVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3805C113CC;
	Mon, 13 May 2024 19:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715629815;
	bh=NrfU76rQkDacMih4EfCdtj4kvNf3aCwAPMB9IErV4bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVWZOSVgRq1OlnbzQAK3cpcg3rOJXKkQbYEzNv/XVkLOaUh0/l/KJBW2MMYqE7QZd
	 F7dS4rem5C9x9ZKieAw45EXIVSycjjukzdJK0b7haPPxCMm+wpSvv49jxCsQClRQPy
	 i/shI+9XyCapgk7/x80lIWYa25n5OZRWjQGSUJCQtDyLKes7/Krxjj73tv0fV5a2tW
	 BahY0FO+fhPIune5Dg/kS92iqhh3a9g8Zi487w8WGGuBNPBDnyrdZtF2HJ+k6P/iRR
	 mIqsThiDmUTMcRK9XXpTrOpDNO1SYBRIPwRGCuv9rIQ6eUBhQYUhaC/f1G2LzsOlai
	 KCdve26RrMeaA==
Date: Mon, 13 May 2024 20:50:10 +0100
From: Simon Horman <horms@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: micrel: Fix receiving the timestamp in the
 frame for lan8841
Message-ID: <20240513195010.GW2787@kernel.org>
References: <20240513192157.3917664-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513192157.3917664-1-horatiu.vultur@microchip.com>

On Mon, May 13, 2024 at 09:21:57PM +0200, Horatiu Vultur wrote:
> The blamed commit started to use the ptp workqueue to get the second
> part of the timestamp. And when the port was set down, then this
> workqueue is stopped. But if the config option NETWORK_PHY_TIMESTAMPING
> is not enabled, then the ptp_clock is not initialized so then it would
> crash when it would try to access the delayed work.
> So then basically by setting up and then down the port, it would crash.
> The fix consists in checking if the ptp_clock is initialized and only
> then cancel the delayed work.
> 
> Fixes: cc7554954848 ("net: micrel: Change to receive timestamp in the frame for lan8841")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>


