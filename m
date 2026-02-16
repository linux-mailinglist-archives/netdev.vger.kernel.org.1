Return-Path: <netdev+bounces-258871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOkfH1YZk2nD1QEAu9opvQ
	(envelope-from <netdev+bounces-258871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:19:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF46143C36
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7538A3007F4B
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2860F2F83AE;
	Mon, 16 Feb 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTiHqB0r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E582E9757
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771247955; cv=none; b=J23EMjon/AhB5Yb7ChSgm5oJV7Xt79oEPcGIGcAWXXS1kt0Aiv1vIi3wIwXy3TsB+zIkzctaKcygt2HkYH70VqpEBezGOZBYwrga8hbvelK3SyAiDPwEXqeQfP09Ub+xkQEKfHu821AsR+5dxsah6uW99tkIKOqF0jgb3IydVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771247955; c=relaxed/simple;
	bh=L+SuQDcvBCHqR3x9W5Om/Gh8l0QgbINjVgOff6HAL+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzlQ0j8CSl/PPk42zCY0D07X0vNHpEbG7coTHvLCVlQzEBxkBT09A72zgG4vEvPcdYlE3jv9Em/A4/7YTpqQf82hOEtyS7GeAe/qL8oAqpbhfKpl6fApq/6fmfKxX0+DJOEzqIv75Wqn/xYD+YlqhcdTqV7/IKebCjhS/ugp98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTiHqB0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0704EC116C6;
	Mon, 16 Feb 2026 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771247954;
	bh=L+SuQDcvBCHqR3x9W5Om/Gh8l0QgbINjVgOff6HAL+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTiHqB0rP48PVxvQLTUYs9bSqEf1NSYD2bs+/j6lInOtin3m/NKf+Sruuc55l0vWW
	 7JwMX+oAkhgNTyXgXgz70WTTK7gczZc08TIlDSKHNSxAOfTfBqhOkOHZ9WzEcZovrK
	 M4vLVtTZqK3EDibwvl9UUIh/cp2HNe4NwapXFe84t0eY1wDCO+k3do/WpjC/dQHBM0
	 dt+nNNqC5Gj4HA+DDIfxZiEKuPdhxLUF6wK+2qXP4j4SYaLImHvJyar8ZUjYQ5B/X2
	 MLXzY2MmGvpjNJ5jZvASwVRFeF6vm41TP4bfbXsO3M2pDPu9yHfMSzVl/xXafbezTX
	 F/uUjVs6IHjPA==
Date: Mon, 16 Feb 2026 13:19:09 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Witold Fijalkowski <witoldx.fijalkowski@intel.com>,
	Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
	kohei.enju@gmail.com
Subject: Re: [PATCH v1 iwl-net] iavf: fix out-of-bounds writes in
 iavf_get_ethtool_stats()
Message-ID: <aZMZTTXWtIO1ERpm@horms.kernel.org>
References: <20260214191502.267670-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214191502.267670-1-kohei@enjuk.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258871-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: CFF46143C36
X-Rspamd-Action: no action

On Sat, Feb 14, 2026 at 07:14:25PM +0000, Kohei Enju wrote:
> iavf incorrectly uses real_num_tx_queues for ETH_SS_STATS. Since the
> value could change in runtime, we should use num_tx_queues instead.
> 
> Moreover iavf_get_ethtool_stats() uses num_active_queues while
> iavf_get_sset_count() and iavf_get_stat_strings() use
> real_num_tx_queues, which triggers out-of-bounds writes when we do
> "ethtool -L" and "ethtool -S" simultaneously [1].
> 
> For example when we change channels from 1 to 8, Thread 3 could be
> scheduled before Thread 2, and out-of-bounds writes could be triggered
> in Thread 3:
> 
> Thread 1 (ethtool -L)       Thread 2 (work)        Thread 3 (ethtool -S)
> iavf_set_channels()
> ...
> iavf_alloc_queues()
> -> num_active_queues = 8
> iavf_schedule_finish_config()
>                                                    iavf_get_sset_count()
>                                                    real_num_tx_queues: 1
>                                                    -> buffer for 1 queue
>                                                    iavf_get_ethtool_stats()
>                                                    num_active_queues: 8
>                                                    -> out-of-bounds!
>                             iavf_finish_config()
>                             -> real_num_tx_queues = 8

...

> Fixes: 64430f70ba6f ("iavf: Fix displaying queue statistics shown by ethtool")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

...

> @@ -345,19 +344,19 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
>  	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
>  
>  	rcu_read_lock();
> -	/* As num_active_queues describe both tx and rx queues, we can use
> -	 * it to iterate over rings' stats.
> +	/* Use num_tx_queues to report stats for the maximum number of queues.
> +	 * Queues beyond num_active_queues will report zero.
>  	 */
> -	for (i = 0; i < adapter->num_active_queues; i++) {
> -		struct iavf_ring *ring;
> +	for (i = 0; i < netdev->num_tx_queues; i++) {
> +		struct iavf_ring *tx_ring = NULL, *rx_ring = NULL;
>  
> -		/* Tx rings stats */
> -		ring = &adapter->tx_rings[i];
> -		iavf_add_queue_stats(&data, ring);
> +		if (i < adapter->num_active_queues) {

Hi Enju-san,

If I understand things correctly, in the scenario described in the patch
description, num_active_queues will be 8 here.

Won't that result in an overflow?

> +			tx_ring = &adapter->tx_rings[i];
> +			rx_ring = &adapter->rx_rings[i];
> +		}
>  
> -		/* Rx rings stats */
> -		ring = &adapter->rx_rings[i];
> -		iavf_add_queue_stats(&data, ring);
> +		iavf_add_queue_stats(&data, tx_ring);
> +		iavf_add_queue_stats(&data, rx_ring);
>  	}
>  	rcu_read_unlock();
>  }

...

