Return-Path: <netdev+bounces-179621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7297A7DDC9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD927171890
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7024888D;
	Mon,  7 Apr 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM1HEJsG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA51248879
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029437; cv=none; b=CIUC03pcyNuUgKlScMyf4vnBVLFC7BbIL4aiFDEUa/qyFqdvGE40UDdc/IMHrn4aNTdCIJu4vZV5X/pXP+WzcbVCtcewPkJ7JqRGmx+yWqj5hzn1spyV1or0Plo9g4YhZBmaGef5OHutUGkkmSPAag3Q+616mhrtVwCdviml2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029437; c=relaxed/simple;
	bh=oZyI1mpgLuMcg85lAyaMpnatD7EAnPF9QqXpdxcNdMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g66YIYfL5TrRXvaQrr5PgagLfSbHYFdK+mvcZQHAuiBM9clA2z0tdSDO7UsNwIGRkeKpWsODUJa9UduIifTLY3mf/6S6bF2PlA4LmvYBmAF0+jrm4cADE8FyQ3TQfvNjA4+axR7Ookzl0K2DiLnEElYBVaxIPSoYpfEk8Ecm3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM1HEJsG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07904C4CEDD;
	Mon,  7 Apr 2025 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744029437;
	bh=oZyI1mpgLuMcg85lAyaMpnatD7EAnPF9QqXpdxcNdMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SM1HEJsGT99defB7ng7EQ+pkfPfQka8Vm40nYknRIi3YG2B4bCVbrPE4Ny/IXdj1g
	 SmwUS9Y9Rd4gwUw66lFu78IAxUlol8h9rY0UMCPp+yq0SfPnXHUEXE+acm8A6j8xKO
	 lX6uzz6l3dOcfzPxoeMYGNJJYGMPUrhXd7ldXB+LhJ4zPT+5GEBflmnBX6jlsmw2q+
	 OAJ2h23AosRLcDIcT9tP4e+hk8ESPam/ji9/JmPmQ+D+FxZW60prY7lW9bNnFrvxlr
	 Xsgn8JreP8onFjKvs7Cv7qtEHPSsC2/A/8bmbfyhuuvRYQ3Ua/hCHm9M/ryUZnrmWC
	 XcxqS+CknObgg==
Date: Mon, 7 Apr 2025 13:37:12 +0100
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
Subject: Re: [PATCH iwl-next v4 2/2] igc: Change Tx mode for MQPRIO offloading
Message-ID: <20250407123712.GI395307@horms.kernel.org>
References: <20250321-igc_mqprio_tx_mode-v4-0-4571abb6714e@linutronix.de>
 <20250321-igc_mqprio_tx_mode-v4-2-4571abb6714e@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-igc_mqprio_tx_mode-v4-2-4571abb6714e@linutronix.de>

On Fri, Mar 21, 2025 at 02:52:39PM +0100, Kurt Kanzenbach wrote:
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
> Tested on i225 with real time application using high priority queue, iperf3
> using low priority queue and network TAP device.
> 
> Acked-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>


