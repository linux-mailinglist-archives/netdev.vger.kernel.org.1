Return-Path: <netdev+bounces-95732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB238C32F6
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 19:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3011A1C20C35
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BBF1BDCF;
	Sat, 11 May 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEeFkol3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDF7F;
	Sat, 11 May 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715449281; cv=none; b=K7ie/K7WS+IXvpAOEzUSwZlRqNC66GohNYAZbafs/CRsp7cnHusX1KMUqQUT9C6bFE8STteCQDMIUn9twty8ovSZPuLEVR7uBNWbTUbnk/oOWM+tlGp4TM+wXSuXjK2REj/r3N5EAIXbY8o447ODpksM80L25h7J0GQqzMqWEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715449281; c=relaxed/simple;
	bh=Dlo88TYjJ2dqpMbh1XVRqvHEvnVqfca8m0hFFGpWvgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRaE+A/9uG+K+nYz0f9AnB91oHkdXQFBKi4CvvLgkgVYr2/wkSUv1nfrXyZgIyoWxB0ByKI/OK/ugR0wvE2EC7udBaB8x9ftoM5GgSYmLhRBmDvXsrjc3ftyHrlZR0FMfWrqKKdG3Zrl8GTV+FlSejEfSiYBSMfYZReK3UWKkSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEeFkol3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80238C2BBFC;
	Sat, 11 May 2024 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715449280;
	bh=Dlo88TYjJ2dqpMbh1XVRqvHEvnVqfca8m0hFFGpWvgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NEeFkol3mXfZbArM4ITEYgwWMmg7Z6pFFK8e0IQqzNP0sCFg9u3/pIwrZBWBAYdXS
	 5YMDxVVF7OWz40LLpfVEv6D9TXoJzxf1qWJysoWgJjgrasdtG9ULu50TxYjc8uL3Hx
	 7uHepVIOL4zkj9bfM1s9MisdLQrGjJpGOVa69fqz4wUq4UISYVIwjFwM4EPO8a2X91
	 XVLq1kJX8yC0GeWWrODGAdBWZ22gIuWM5v84v4WiMTLXr90GKcLZ736o5ksBC4E1AN
	 uj0hP3khmqYOLNwKDlz4odl0JrptzAqcWHsANlZnrgzvOqMrmKHmkfGyWqLjT2hMkT
	 WsnL8dZE68vIA==
Date: Sat, 11 May 2024 18:41:12 +0100
From: Simon Horman <horms@kernel.org>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
	bartosz.golaszewski@linaro.org, rohan.g.thomas@intel.com,
	rmk+kernel@armlinux.org.uk, fancer.lancer@gmail.com,
	ahalaney@redhat.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v5 2/2] net: stmmac: move the EST structure to struct
 stmmac_priv
Message-ID: <20240511174112.GS2347895@kernel.org>
References: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
 <20240510122155.3394723-3-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510122155.3394723-3-xiaolei.wang@windriver.com>

On Fri, May 10, 2024 at 08:21:55PM +0800, Xiaolei Wang wrote:
> Move the EST structure to struct stmmac_priv, because the
> EST configs don't look like platform config, but EST is
> enabled in runtime with the settings retrieved for the TC
> TAPRIO feature also in runtime. So it's better to have the
> EST-data preserved in the driver private data instead of
> the platform data storage.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Patch 1/2 of this series is a fix for net, with a Fixes tag.
IMHO, it looks good.

This patch, however, is a clean-up/enhancement.
It doesn't have a Fixes tag, which is good.
But I think it should be targeted at net-next
(once patch 1/2 has been accepted into net, and
net has been merged into net-next; also, given the timing,
once net-next reopens as It's likely to close rather soon
for the merge window).

Perhaps it is possible for the maintainers to pick up
patch 1/2, leaving this patch as follow-up.

The above notwithstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: under-review




