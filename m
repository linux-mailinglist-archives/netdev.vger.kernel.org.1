Return-Path: <netdev+bounces-158663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08325A12E37
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 23:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214AD165C52
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309A1DB158;
	Wed, 15 Jan 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHFXRl+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA83132C38;
	Wed, 15 Jan 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979789; cv=none; b=q1bju+bFNTJoLJvrfRl3ujWhc2j0tlaUxefu+MuRRBg84PSiRVjrCF8bos5P5T+H9FdJ/ma3VTcN4+VG/tEUaz/FNG7g4V/E24n5C+rZy+wuqt37M/IPMJcT4HD3M2ToEcrLGGuFbAJrvg/KbDNAXyfXuHCdUDCq4Qbafl35Lns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979789; c=relaxed/simple;
	bh=xZDaAgAgfLwPND9U7+0w/smVD+0b6CjU5iWZeF5xBKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0PM7EmOmKnZB9h7QYgQGjkdXUQXSxwTGDtjR+no7Id1p5yW6Sbr2rUEjnsGjyU6DXYcuWRl1WhHqSZTK69K2q6O2BkCh+f77RKIFu0aeQnM7j84zynrtuoeu/MjE6GzEV0zk/aJoke+5ZTZXInSLQk1gBzdb0IxG6w9bQCkEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHFXRl+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4466AC4CED1;
	Wed, 15 Jan 2025 22:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736979788;
	bh=xZDaAgAgfLwPND9U7+0w/smVD+0b6CjU5iWZeF5xBKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AHFXRl+VGflPkO0+oOn+SR74AZXi8TSdrUZXZI3b6Jm1A+NybpHzXcn9YFt1J+s4H
	 Xtjq8ONUDkfZ/0VBIqy9kJhqnxZa4+lGnoNmk/LT8G6RvakqTBLB+inFeGGe51fye7
	 JEhxa+JEkYhq/KQ4+OGb/ZwfD0qv1xT6FFOjfaXCEaIMnXla6VMRjxa+YUBht++r+R
	 DjF53XWKOI31+DcveUO4N2T5Q3QwpNo2/i22V4qGc1FIw/e2AmvBkaT2TXP/FqOIKK
	 ORKKCM3jXdb1sGBs2oLmq37KPdY1rftF1Ce6SKKNwDqgJqth9oSzwklyBFcmoTQNh+
	 PypPdzYSzr8+w==
Date: Wed, 15 Jan 2025 14:23:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>
Subject: Re: [PATCH net v7 1/4] octeon_ep: update tx/rx stats locally for
 persistence
Message-ID: <20250115142307.35840bae@kernel.org>
In-Reply-To: <20250114125124.2570660-2-srasheed@marvell.com>
References: <20250114125124.2570660-1-srasheed@marvell.com>
	<20250114125124.2570660-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 04:51:21 -0800 Shinas Rasheed wrote:
> +	tx_packets = 0;
> +	tx_bytes = 0;
> +	rx_packets = 0;
> +	rx_bytes = 0;
> +	for (q = 0; q < oct->num_ioq_stats; q++) {
> +		tx_packets += oct->stats_iq[q].instr_completed;
> +		tx_bytes += oct->stats_iq[q].bytes_sent;
> +		rx_packets += oct->stats_oq[q].packets;
> +		rx_bytes += oct->stats_oq[q].bytes;
> +	}
> +
>  	if (netif_running(netdev))
>  		octep_ctrl_net_get_if_stats(oct,
>  					    OCTEP_CTRL_NET_INVALID_VFID,
>  					    &oct->iface_rx_stats,
>  					    &oct->iface_tx_stats);
>  
> -	tx_packets = 0;
> -	tx_bytes = 0;
> -	rx_packets = 0;
> -	rx_bytes = 0;
> -	for (q = 0; q < oct->num_oqs; q++) {
> -		struct octep_iq *iq = oct->iq[q];
> -		struct octep_oq *oq = oct->oq[q];
> -
> -		tx_packets += iq->stats.instr_completed;
> -		tx_bytes += iq->stats.bytes_sent;
> -		rx_packets += oq->stats.packets;
> -		rx_bytes += oq->stats.bytes;
> -	}

This code move is unnecessary. Next patch removes the
octep_ctrl_net_get_if_stats() call, so you can just 
reorder the patches to remove the FW calls first, 
and the diff will be smaller here.
-- 
pw-bot: cr

