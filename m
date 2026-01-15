Return-Path: <netdev+bounces-250003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB1D22462
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 04:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FE67301C5F7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 03:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDF1A840A;
	Thu, 15 Jan 2026 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faH+waC8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700914AEE2;
	Thu, 15 Jan 2026 03:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768447007; cv=none; b=cTmIXEnnwM3rd4G28hUfFhUcVnXcC4jIFBkLm6i+1jugm94cmhAGbLZ3vzRpybCE6LovHbbFdfHA3dIvzAxEmmPkBeyrF9XMsw9EQ1ywk3xpcT1x8v+Vi/2yn1uXhcaVgANVJ5+K0GFzIpBZ8NVtqPQrDyahm2JQfCPs7p0viq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768447007; c=relaxed/simple;
	bh=4/nR6Vnd7dznW8UsJsw3uatFCnB8OjCUeTlTI09MXSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL4jK+mikKUPbq8fILxA/+cGZ/lCVQ2CByH0MBqoaeGAOg5MSxOmZ/LGmQm6w+7mt5t6ItQif2zsM9kdRqLojzyvAS/N2lU26mn3vf+bfdFenX5p9RJu8hwvfbtAaBKH3+h7Q1ZNzOGBeJau/Cn8oYy+hseIT8oIIC/EuvWlO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faH+waC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0565C4CEF7;
	Thu, 15 Jan 2026 03:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768447007;
	bh=4/nR6Vnd7dznW8UsJsw3uatFCnB8OjCUeTlTI09MXSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=faH+waC8+mMGzOvCE4ztaZCVewVluM9e0Nv3eMr1RLq5uG1GgrsMSbmwn7iQos2Dt
	 ZjkvnwMOgcgUhIxv0L7DbOdrEOhMMDvO3T+nxQgRfUOwdidZZDFGEGc8vRlREPPQCJ
	 B9yQxu1c+YzmAFiqymBoZxaIjdVNdXvSjfxzQER7n4aWaaiIrPbfxCradz4TCUppie
	 9tYUZs1vJElDOv+BEV6mFbWHyM3Ou4mBrAkmr8C7088oR4HsIcseRl9DlunM5aUDjX
	 930GIiad65NM2qJmUSfQMT0AvbL2QbL54YXjsiWHwGtYrv2d0zxHPnucncPBiqqyhS
	 LjB94mn+PQmKw==
Date: Wed, 14 Jan 2026 19:16:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tao Wang <tao03.wang@horizon.auto>
Cc: <alexandre.torgue@foss.st.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <maxime.chevallier@bootlin.com>, <mcoquelin.stm32@gmail.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
Message-ID: <20260114191645.03ed8d67@kernel.org>
In-Reply-To: <20260114110031.113367-1-tao03.wang@horizon.auto>
References: <20260112200550.2cd3c212@kernel.org>
	<20260114110031.113367-1-tao03.wang@horizon.auto>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 19:00:31 +0800 Tao Wang wrote:
> To solve the issue, set last_segment to false in stmmac_free_tx_buffer:
> tx_q->tx_skbuff_dma[i].last_segment = false.  Do not use the last_segment
>  default value and set last_segment to false in stmmac_tso_xmit. This
> will prevent similar issues from occurring in the future.
> 
> Fixes: c2837423cb54 ("net: stmmac: Rework TX Coalesce logic")
> 
> changelog:
> v1 -> v2:
> 	- Modify commit message, del empty line, add fixed commit
> 	 information.
> 
> Signed-off-by: Tao Wang <tao03.wang@horizon.auto>

When you repost to address Russell's feedback in the commit
message please:
 - follow the recommended format (changelog placement and no empty
   lines between Fixes and SoB):
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested
 - do not send new version in reply to the old one, start a new thread
-- 
pw-bot: cr

