Return-Path: <netdev+bounces-94491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D916C8BFAB9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B001F253AC
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A17A15C;
	Wed,  8 May 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVomiSR/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739647D405;
	Wed,  8 May 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163292; cv=none; b=mf+UvfhN9u1c40xjVgHBDQc4b3CmzmhNHj+o6Gl2gyS+ys72VsVQXx4P36e5n1hMcfr3vRxS3UnRtg/K3uHteQXJjiqfAjyZncfmGmZzfgvnVVWCVMj5jesOE4pdhk/+ODNrZ4P1R4ncOE4oMUOQPHiN1ntwAPtJO53D6w0ZPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163292; c=relaxed/simple;
	bh=QJq+nxCPYLW+HuN4uFAjTQF8DmqNROLLUZUNwKPWQsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdsCJRsK2ocxmvYV1I2LTJiumhx7RbB4QWfGoeT2sswjws8fXqKNEBL+idiiHqVCtKpOUFoKBFj5Wc2Qi7mwVkKCNjUHnDIXDGojBUJzqB3G8w+wvbNLrb19GQ23FwQBcwWlWCU9UPKFvU9gSJulSXdqKmqdqZnRpf5p28XaXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVomiSR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63557C113CC;
	Wed,  8 May 2024 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163291;
	bh=QJq+nxCPYLW+HuN4uFAjTQF8DmqNROLLUZUNwKPWQsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVomiSR/Z9uGISAitvK/ZZVFf7Nrlpk5P7u9mbB5AkPKsPxa0JHqIWVI9IrmONbjK
	 dvziDVHgVhi8DTnLrg8alzGUHyixJX1B7MjB8vVjOGx9LlVVYdbVLnqsROQAlYsTyk
	 EsrtK8539Z+SVdYfu5A9b5HJBGr8q4axRhcjGGk+y2FhFS43h66R96K3481hYoRE0v
	 D46ZsZ4bNySvwBpQyfIwcQsyxEb0/VFfYwQCN5BB/WBeve1Yi21iUc9A7rAWFK5Tlg
	 AyzoQ0YSlHz+XjuGcMfcikc5qTbrBXOVIEVNAPG/moMBkaRXbgbzJw4kimTRBXqYk5
	 gYdGaLSaA/8vg==
Date: Wed, 8 May 2024 11:14:46 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v2] hsr: Simplify code for announcing HSR nodes timer
 setup
Message-ID: <20240508101446.GC1736038@kernel.org>
References: <20240507111214.3519800-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507111214.3519800-1-lukma@denx.de>

On Tue, May 07, 2024 at 01:12:14PM +0200, Lukasz Majewski wrote:
> Up till now the code to start HSR announce timer, which triggers sending
> supervisory frames, was assuming that hsr_netdev_notify() would be called
> at least twice for hsrX interface. This was required to have different
> values for old and current values of network device's operstate.
> 
> This is problematic for a case where hsrX interface is already in the
> operational state when hsr_netdev_notify() is called, so timer is not
> configured to trigger and as a result the hsrX is not sending supervisory
> frames to HSR ring.
> 
> This error has been discovered when hsr_ping.sh script was run. To be
> more specific - for the hsr1 and hsr2 the hsr_netdev_notify() was
> called at least twice with different IF_OPER_{LOWERDOWN|DOWN|UP} states
> assigned in hsr_check_carrier_and_operstate(hsr). As a result there was
> no issue with sending supervisory frames.
> However, with hsr3, the notify function was called only once with
> operstate set to IF_OPER_UP and timer responsible for triggering
> supervisory frames was not fired.
> 
> The solution is to use netif_oper_up() and netif_running() helper
> functions to assess if network hsrX device is up.
> Only then, when the timer is not already pending, it is started.
> Otherwise it is deactivated.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> ---
> Changes for v2:
> 
> - Add extra condition to check if the hsr network device is running
>   (not only up).
> 
> - Only start announce timer when it is not pending (to avoid period
>   shortening/violation)

Reviewed-by: Simon Horman <horms@kernel.org>


