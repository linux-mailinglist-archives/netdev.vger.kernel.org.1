Return-Path: <netdev+bounces-171783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074BA4EA18
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7FB1888E5D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2CA2862B9;
	Tue,  4 Mar 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hA5A/kjp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C028629C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109426; cv=none; b=MHYIF2zRUgS0lvjOIOjHoY1QQI1Brx5CInQh118aKo5VGME5TNVhHAYs7BR65KIzYrHIeKq5OsBc6JcNXi5wUNxBQJQbT92bK8E/F3CziTetRJf8sBLoPRD8yNODLWcPVO9zZ4xXDX8bqw4IttjUcK7pt9qcBy96WCgfh/5EiYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109426; c=relaxed/simple;
	bh=xuCB2v1oTiS5aN88F+t/9IxGezhQ8OSGjVyYYhNHj48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3JiVdyLEFovSpGEp3jscS7OLBEz89xCT9v/RsBuHyP2fZciyUCO3xGcAuZcG1dm0hN1HSMAzmhwYWEN8ivPkMu8hCgtAxS7Iy9HOT3mca+0OIZLblUZMwNiVoUYgp8B5dxNGZVB0DgK0aQ3qGcCfEWvbIFB2hSwwt9FWyacQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hA5A/kjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BA8C4CEE5;
	Tue,  4 Mar 2025 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741109425;
	bh=xuCB2v1oTiS5aN88F+t/9IxGezhQ8OSGjVyYYhNHj48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hA5A/kjpuNwBuwkBfBPzGm3c4k3T/6X2O42kzkDgPM2PQPURnd4VrfbdjGinzSe4R
	 7Earfx7KtvrVS18Y89YQ1cKi63QqWQfJFiDazGcTh2Z2e/0O1M5pbTkoXGjheQeZbT
	 E3n0D8ZgEJgjrRzLIPa/rpi9ac3UJsaiINh8HCMepERMI6BuUr0L0F2UV8rWlj6e79
	 f5+rQ+1Jx1qLnMGQ+66e63rlXkF2KcrZuIXeppiz8sWlrE6iIO4ql1Yb/O+3j3wiqj
	 pik0zlBL1U/vRlK8BBkZT9MNphx5hh3nJpOcfZrakObklpaP2RJxc0W9BtlSKByAIh
	 W3Z/3ygTR/GJQ==
Date: Tue, 4 Mar 2025 17:30:21 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3] igc: Change Tx mode for MQPRIO offloading
Message-ID: <20250304173021.GH3666230@kernel.org>
References: <20250303-igc_mqprio_tx_mode-v3-1-0efce85e6ae0@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-igc_mqprio_tx_mode-v3-1-0efce85e6ae0@linutronix.de>

On Mon, Mar 03, 2025 at 10:16:33AM +0100, Kurt Kanzenbach wrote:
> The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
> this mode the hardware uses four packet buffers and considers queue
> priorities.
> 
> In order to harmonize the TAPRIO implementation with MQPRIO, switch to the
> regular TSN Tx mode. This mode also uses four packet buffers and considers
> queue priorities. In addition to the legacy mode, transmission is always
> coupled to Qbv. The driver already has mechanisms to use a dummy schedule
> of 1 second with all gates open for ETF. Simply use this for MQPRIO too.
> 
> This reduces code and makes it easier to add support for frame preemption
> later.
> 
> While at it limit the netdev_tc calls to MQPRIO only.

Hi Kurt,

Can this part be broken out into a separate patch?
It seems so to me, but perhaps I'm missing something.

The reason that I ask is that this appears to be a good portion of the
change, and doing so would make the code changes for main part of the
patch, as per the description prior to the line above, clearer IMHO.

> 
> Tested on i225 with real time application using high priority queue, iperf3
> using low priority queue and network TAP device.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

...

