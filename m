Return-Path: <netdev+bounces-30195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0FD786538
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 04:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484182813C5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258917F3;
	Thu, 24 Aug 2023 02:19:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9297F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 02:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC903C433C7;
	Thu, 24 Aug 2023 02:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692843570;
	bh=3EVcN2vYcbG04uVwv5dzwC83DowUUe2Rac9gz9OGIZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WDuuOCxU1XGq4hIodAG3sSkCb8yhHWr9RZ0peSgOO8Sh4zPyEJ3zbs5Ew/y+X7g4W
	 EWQH4yIDiNVUWTiVONeLeeUjFKMIxSy5cAqb1dsZ4SbvEbfLdU6ZigN6YmsU8lDC08
	 ksC3/JiJ2cpE38+Z7jmVoqg6Ov82Lr9AfA6lFRxru2/ibv6hVHrZLprpz96bKNWUG7
	 /LiaXybBwXWdBJdrbOwY+zMMJvJQ/qD01zUxk7aQpxgWlnTt9gp4qhkIN1CAwC/yuP
	 0jTWCLOqKbJhiXiiga4hNdSKXTv09AeypcxpqQJJd77GXcIKfLyXKGx5nWfjxpb9Zx
	 2433IZsEP6nhg==
Date: Wed, 23 Aug 2023 19:19:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Muhammad Husaini Zulkifli
 <muhammad.husaini.zulkifli@intel.com>, sasha.neftin@intel.com,
 horms@kernel.org, bcreeley@amd.com, Naama Meir
 <naamax.meir@linux.intel.com>
Subject: Re: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Message-ID: <20230823191928.1a32aed7@kernel.org>
In-Reply-To: <20230822221620.2988753-3-anthony.l.nguyen@intel.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 15:16:20 -0700 Tony Nguyen wrote:
> root@P12DYHUSAINI:~# ethtool -C enp170s0 tx-usecs 10
> netlink error: Invalid argument

Why was it returning an error previously? It's not clear from just 
this patch.

> -	/* convert to rate of irq's per second */
> -	if (ec->rx_coalesce_usecs && ec->rx_coalesce_usecs <= 3)
> -		adapter->rx_itr_setting = ec->rx_coalesce_usecs;
> -	else
> -		adapter->rx_itr_setting = ec->rx_coalesce_usecs << 2;
> +	if (adapter->flags & IGC_FLAG_QUEUE_PAIRS) {
> +		u32 old_tx_itr, old_rx_itr;
> +
> +		/* This is to get back the original value before byte shifting */
> +		old_tx_itr = (adapter->tx_itr_setting <= 3) ?
> +			      adapter->tx_itr_setting : adapter->tx_itr_setting >> 2;
> +
> +		old_rx_itr = (adapter->rx_itr_setting <= 3) ?
> +			      adapter->rx_itr_setting : adapter->rx_itr_setting >> 2;
> +
> +		/* convert to rate of irq's per second */
> +		if (old_tx_itr != ec->tx_coalesce_usecs) {
> +			adapter->tx_itr_setting =
> +				igc_ethtool_coalesce_to_itr_setting(ec->tx_coalesce_usecs);
> +			adapter->rx_itr_setting = adapter->tx_itr_setting;
> +		} else if (old_rx_itr != ec->rx_coalesce_usecs) {
> +			adapter->rx_itr_setting =
> +				igc_ethtool_coalesce_to_itr_setting(ec->rx_coalesce_usecs);
> +			adapter->tx_itr_setting = adapter->rx_itr_setting;
> +		}

I'm not sure about this fix. Systems which try to converge
configuration like chef will keep issuing: 

ethtool -C enp170s0 tx-usecs 20 rx-usecs 10

and AFAICT the values will flip back and froth between 10 and 20, 
and never stabilize. Returning an error for unsupported config
sounds right to me. This function takes extack, you can tell 
the user what the problem is.
-- 
pw-bot: cr

