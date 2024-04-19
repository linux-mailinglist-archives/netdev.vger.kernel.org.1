Return-Path: <netdev+bounces-89498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1E8AA6B3
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 03:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A001F22F5D
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 01:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D920138C;
	Fri, 19 Apr 2024 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg9dTvna"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591415C3;
	Fri, 19 Apr 2024 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491508; cv=none; b=jKxcC0G44b+nLSS/7szG5xHK73wGTFY4+I70lgkECafO/OPqfdKxNvwHy5e+Spt1fBo/pc9VP+9WF/Qkr6pGSXLbR9mUGQyMUQ22JpViKuj7DtpWrHcF2NgOXb1jLOlHd4WjHmcim1nKfU+oj9wulZXjIMNl7BCYMTtwb2DBrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491508; c=relaxed/simple;
	bh=syaMnvA3knmCzWYr1sDlnYWM6SRCKauaf9CI3Iqzd5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjcqQ+Fdm4X45o8Rp3HVRvzlLkkjolgUyQ2rw4BcdTraeOXPXydqqNQ0qXd3ahX2IOl4uDgonmt1zl+ksOX+u8o/tRTlnS1kSfmRXyRhJVn9mQ6YN1J/UNB20JDlmI75rW1uLuF2qnE/Z3qNAMXc1MpLpzZ2GlNh8TNTLxh0mzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg9dTvna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6756FC113CC;
	Fri, 19 Apr 2024 01:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713491508;
	bh=syaMnvA3knmCzWYr1sDlnYWM6SRCKauaf9CI3Iqzd5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fg9dTvna43SWKpM0Kx8Ye4HwkYWnsQQfzPKpPCJ/AyCLheTMwmUeoaSxJsWtjp59G
	 SSOxsEJuK2KTMAdZ2n2oHpb/f1bgg3Lyn6RKanqMUlF9Cff5MDXGijUQzpU+ijkA1M
	 cbzgi46M9mdu0S8cMIT1qLT3zOPQ9O2eiLeU89vwJpwz5ridUehAakFWVbmCMGm7LE
	 wL/VYJqT9IK3ulg8JiU2qyGSd3EQjT7bsKv3RTTl1kNQ4YUufkBoLu8SlEYJ5aE0tW
	 knjFqCEo5yWd+Ll5KEypB04a/NHU/5H1BoKjB6csPXMFp4wFT9HvyJMs+i+Aukv0Zp
	 ePeSuLp//Do9g==
Date: Thu, 18 Apr 2024 18:51:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Dan
 Carpenter <dan.carpenter@linaro.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew
 Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v7 2/2] net: ethernet: ti: am65-cpsw/ethtool:
 Enable RX HW timestamp only for PTP packets
Message-ID: <20240418185146.497cb075@kernel.org>
In-Reply-To: <20240417120913.3811519-3-c-vankar@ti.com>
References: <20240417120913.3811519-1-c-vankar@ti.com>
	<20240417120913.3811519-3-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 17:39:13 +0530 Chintan Vankar wrote:
> Fixes: b1f66a5bee07 ("net: ethernet: ti: am65-cpsw-nuss: enable packet timestamping support")
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

No empty lines between trailers, please
-- 
pw-bot: cr

