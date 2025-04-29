Return-Path: <netdev+bounces-186620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4FA9FE79
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F5E189A46F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BC1DE2C4;
	Tue, 29 Apr 2025 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ2olgpe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB21DE2C6
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745887040; cv=none; b=sKj6ccvNoXiuOt91pCWsCfr9G95sa8bo2C6gxVx4dthWTUQXG7Y4k/BhBvemArCPmtPhO9BGw0tBS+FlWqJAIzmFzPY9NCfcXdCpppZcjgzkOHWTAU2Kbiz4ty4Qx8jGokASIQNs7MzId4YsBFQBOIdNESrLMmhK58znQuqrbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745887040; c=relaxed/simple;
	bh=eK4Sy/lF7bnofYwxlDpl6KnrNK5eBiY3ESD8zUZiKcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7xrg7xcNgUM91eOzIavwivizEnt7Kx+kt5NflRe+JKJzfMeC90GY5LvyNTTygRs26SOrcwfb/gKIto2VjwD27KmAEfC1x0lB6OCj81FzkdbDAkbJIhSdgc2YvgGmEj1MpLn2nns+fES4Y9B26Z6tEVJvuu0oz/ngi3hQs7TDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ2olgpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104FDC4CEE4;
	Tue, 29 Apr 2025 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745887039;
	bh=eK4Sy/lF7bnofYwxlDpl6KnrNK5eBiY3ESD8zUZiKcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oJ2olgpeyRPIyAixkOJt7vnWfb86xeLDj0y63R1yDO/SqdSA+QhalQrj+GmiLIEGP
	 lK9AYlvXV3sPyKqcHLUlhXG65u6xJ/Z7ftaO60RKq9Ki6NHij/hgMCwW4tuY6K1OgB
	 QQz0tGGq5/z+ryCGOivOEz9bZCOUAW9bM6Y7+3IsTrqlNsRouu8reNtFdz5pC75G/J
	 FPEwlZs9pwDXHjV1Ez8jNh0j1dRfqa8sy0g+Rs1KbZoAi+GvDQ8UdPTSOl3W8PdVZe
	 kz4IMRKU9N+mYKXPFdlPXxdRIJRHBYk3QlAF4ml2QZqmVOv/iG+HOTGK+R71cE/YG3
	 qjHXwNBSnLasg==
Date: Mon, 28 Apr 2025 17:37:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Milena Olech
 <milena.olech@intel.com>, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, richardcochran@gmail.com, Josh Hay
 <joshua.a.hay@intel.com>, Samuel Salin <Samuel.salin@intel.com>
Subject: Re: [PATCH net-next v2 10/11] idpf: add Tx timestamp flows
Message-ID: <20250428173718.2f70e465@kernel.org>
In-Reply-To: <20250425215227.3170837-11-anthony.l.nguyen@intel.com>
References: <20250425215227.3170837-1-anthony.l.nguyen@intel.com>
	<20250425215227.3170837-11-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 14:52:24 -0700 Tony Nguyen wrote:
> @@ -479,6 +480,9 @@ static const struct idpf_stats idpf_gstrings_port_stats[] = {
>  	IDPF_PORT_STAT("tx-unicast_pkts", port_stats.vport_stats.tx_unicast),
>  	IDPF_PORT_STAT("tx-multicast_pkts", port_stats.vport_stats.tx_multicast),
>  	IDPF_PORT_STAT("tx-broadcast_pkts", port_stats.vport_stats.tx_broadcast),
> +	IDPF_PORT_STAT("tx-hwtstamp_skipped", port_stats.tx_hwtstamp_skipped),
> +	IDPF_PORT_STAT("tx-hwtstamp_flushed", tstamp_stats.tx_hwtstamp_flushed),
> +	IDPF_PORT_STAT("tx-hwtstamp_discarded", tstamp_stats.tx_hwtstamp_discarded),
>  };

I don't see the implementation of the standard stats via get_ts_stats
You must implement standard stats before exposing custom breakdown.

