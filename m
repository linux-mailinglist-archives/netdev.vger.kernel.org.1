Return-Path: <netdev+bounces-169210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3AA42FB2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08018189E9A0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE11C8634;
	Mon, 24 Feb 2025 22:00:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16B17BEBF
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434438; cv=none; b=pnSNWOpEIW1XcBybEE8CYw47PCC10Bpuz3Mhfa2UTL7iVe1QFoZjYwR8rED35glG9p+8QAjqfJUJXKJfVZlmjtEmuAKES0mB2BBVxVk78M8o/SSBfty/+dhgR0BmYApK8sOxPwq92I+kcvvb5VOaB3omjcfxX38y7t12ZrpH1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434438; c=relaxed/simple;
	bh=XYVxTiu5x+OVFzJaQlNPrK2a0xZsutEI7Ro0LqeYyF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrRTM6ysRJskjaoyzrW98Yxoz+ls03RdiKHYBJ5Vc//gotoyoCpkqLOJ6OGHoZOHA2WI+nhgYiIDGR/1iVKOzyHzD8WumsuifMu5IICLDWX9IyfJXlBn3ZAK0ufj5WybMHUudX/l8VkgrkKLuWXSu8aLV48oQIXxp1/ilsRk8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af521.dynamic.kabel-deutschland.de [95.90.245.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1DEF161E64788;
	Mon, 24 Feb 2025 22:59:32 +0100 (CET)
Message-ID: <1e8e6855-0c87-4007-aadd-bdcad51f97cf@molgen.mpg.de>
Date: Mon, 24 Feb 2025 22:59:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] igc: Change Tx mode for
 MQPRIO offloading
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250224-igc_mqprio_tx_mode-v2-1-9666da13c8d8@linutronix.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250224-igc_mqprio_tx_mode-v2-1-9666da13c8d8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kurt,


Thank you for the patch.


Am 24.02.25 um 11:05 schrieb Kurt Kanzenbach:
> The current MQPRIO offload implementation uses the legacy TSN Tx mode. In
> this mode the hardware uses four packet buffers and considers queue
> priorities.

If I didn’t miss anything, later on you do not specify how many buffers 
are used after changing the Tx mode.

> In order to harmonize the TAPRIO implementation with MQPRIO, switch to the
> regular TSN Tx mode. In addition to the legacy mode, transmission is always
> coupled to Qbv. The driver already has mechanisms to use a dummy schedule
> of 1 second with all gates open for ETF. Simply use this for MQPRIO too.
> 
> This reduces code and makes it easier to add support for frame preemption
> later.
> 
> While at it limit the netdev_tc calls to MQPRIO only.
> 
> Tested on i225 with real time application using high priority queue, iperf3
> using low priority queue and network TAP device.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
> Changes in v2:
> - Add comma to commit message (Faizal)
> - Simplify if condition (Faizal)
> - Link to v1: https://lore.kernel.org/r/20250217-igc_mqprio_tx_mode-v1-1-3a402fe1f326@linutronix.de
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  4 +---
>   drivers/net/ethernet/intel/igc/igc_main.c | 18 +++++++++++++-
>   drivers/net/ethernet/intel/igc/igc_tsn.c  | 40 ++-----------------------------
>   3 files changed, 20 insertions(+), 42 deletions(-)

[…]


Kind regards,

Paul

