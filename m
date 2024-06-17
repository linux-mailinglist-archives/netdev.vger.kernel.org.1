Return-Path: <netdev+bounces-103981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E9190AB09
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9A21C2345C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F2194132;
	Mon, 17 Jun 2024 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DScFnxtt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D843517FAA2;
	Mon, 17 Jun 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620146; cv=none; b=ZwlutKFGMyx5SUBWjf3DoYnsvBtKECGF30dDWLJzT3BPSen6o6drYJNf3rANNOckhngL7iWzdMJnomO3Xe66hKgEkPHuWFrCLqs0AXCthXSCiiP0f6TnxtWBQO7Z4Wa/rt5z05qWE3WK95IhUVAsspkqlOXQ0bMqq5bmUDcGrMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620146; c=relaxed/simple;
	bh=h8m6K47SfYhgo2FbakEfctLP6IJiz9PoDGqcI9Lpx78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO1OGgQDRvpvzZPO8LWPpk+JxvjdWNH6lfiCuIa/ev+W3a4ASBBMNyoV+VpYrq0qCngAxXHeEGEpAdIq9KwRgiEmGnp6BMvvrxuARbgE5ozle2I5rlUehvCNNfsponOeRYH1WntTFyUKhNJ39DKc+GgMLWUPdUqGb0HI6NM6R0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DScFnxtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14F0C2BD10;
	Mon, 17 Jun 2024 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718620146;
	bh=h8m6K47SfYhgo2FbakEfctLP6IJiz9PoDGqcI9Lpx78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DScFnxttQ9z8aIToFh5M30yf9Y2aVWUOrwvezwqPtrmd5T7Je4ggNXYj5XH7gnjFd
	 6mUxzvzXAmVSUFtS1c5rCVSXH3B4EZXDs/wSo++DAPc4i3poRJxn4zJvOncv5qPvdn
	 PNU/kGlx/1DVsSDLSeSgnwG5ZugUvev8w3EY+K9/z3rqBSWvTqi8tl4evbyYT/gR5+
	 5GhMDJ/9YfmJ5LesDvu6jemo2bA4784rqu1oVYikSaLJju4R/lhvD52LVdWzdtjfTl
	 UuLItxoWpGXyNrQY36pgZkz7Eu3iX5ANCMWeNwIJb68r+I1TFmXin9CSGHrnRDGI+d
	 z0JQUr6XduYQA==
Date: Mon, 17 Jun 2024 11:29:01 +0100
From: Simon Horman <horms@kernel.org>
To: xiaolei wang <xiaolei.wang@windriver.com>
Cc: olteanv@gmail.com, linux@armlinux.org.uk, alexandre.torgue@foss.st.com,
	andrew@lunn.ch, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: No need to calculate speed divider when
 offload is disabled
Message-ID: <20240617102901.GO8447@kernel.org>
References: <20240614081916.764761-1-xiaolei.wang@windriver.com>
 <20240615144747.GE8447@kernel.org>
 <ec41f61f-d500-4dda-8a79-37a68ddafced@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec41f61f-d500-4dda-8a79-37a68ddafced@windriver.com>

On Sun, Jun 16, 2024 at 09:15:05AM +0800, xiaolei wang wrote:
> 
> On 6/15/24 22:47, Simon Horman wrote:
> > On Fri, Jun 14, 2024 at 04:19:16PM +0800, Xiaolei Wang wrote:

...

> >          /* Final adjustments for HW */
> >          value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
> >          priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
> > 
> >          value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
> >          priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
> > 
> > And the div_s64() lines above appear to use
> > ptr uninitialised in the !qopt->enable case.
> 
> Oh, when deleting the configuration, idleslope and sendslope are both 0, do
> you mean we also need to set ptr to 0?

Understood, if idleslope and sendslope are 0, then ptr could be set to any
value and the result would be the same.  And, based on my limited
understanding, 0 does not seem to be a bad choice.

My point is that ptr shouldn't be uninitialised at this point.

...

