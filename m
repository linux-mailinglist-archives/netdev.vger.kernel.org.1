Return-Path: <netdev+bounces-93430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49438BBB2A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11A228116B
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561A20DC4;
	Sat,  4 May 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neL539ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A441EF15
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825214; cv=none; b=nQPXUV8NNaU6WTEBdx4/x8XdHB5GBtXpyjDvpz1hYZFrAs+3Upd9NUEujRWtcII0BwCmp9XbvINy5xDTKPOwlZ3VSEBSf5c4+YDmAqArGxlSDJjXIQwDwoCmYP0iPa3wT1Gw3QDGwb7jeWLnECFIaDk+MKoD4OVHHSb2X9amXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825214; c=relaxed/simple;
	bh=+VLjoeSEQPG89xCMocvv7YCtZoQa9mj0UTo5zfl6Bbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcYcz7+YXdV5kybrXlSGXCd17yKyly1yase2ZCwDfQRm7HV3+a2HoH0PzD5zJHKLMc4f4GxN88JqxxKtvJfeiGxFVmhEh2voYB0dj/1NMCx+48Cv1spluBimWWrQl1Cu70eFsx8ASKKU0Ht9yUMQUz4XmJkDwnVj2qbVaCYyy1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neL539ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB981C32789;
	Sat,  4 May 2024 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714825213;
	bh=+VLjoeSEQPG89xCMocvv7YCtZoQa9mj0UTo5zfl6Bbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neL539nsalU1qIiPFEOWXwl9NS9dXiXtnG+h7y/xhuJQ9tRnvz9epj70Z69Z3k4Bk
	 mbLwpH+JXYXYrOdw2HA0fWO3Uoc6e9Xv14gfvEWOOBZd4pW+sbcUvqyROZEMmI/euM
	 GzmPAAKlrZoctxvQRsLQy31tY/Tks40L/h/FfolSojg0IxJq5H5Z1RP9nHssHyHnXc
	 2eepP+Rbo1mNyEua0UUEgVUj+WyiT9m7STOw/3LnKveH3gbLx/Ii9Cbqbjl312nB/r
	 YmHZWizQzgzp9susGZeEV5skoUL252DxUoydi7onMzdkL7/ah/ECfaL56OEna9x2BQ
	 9gR91zNcFtLHA==
Date: Sat, 4 May 2024 13:20:07 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Adrian Alvarado <adrian.alvarado@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Shailend Chand <shailend@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH net-next v2 3/9] netdev: add netdev_rx_queue_restart()
Message-ID: <20240504122007.GG3167983@kernel.org>
References: <20240502045410.3524155-1-dw@davidwei.uk>
 <20240502045410.3524155-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502045410.3524155-4-dw@davidwei.uk>

On Wed, May 01, 2024 at 09:54:04PM -0700, David Wei wrote:
> From: Mina Almasry <almasrymina@google.com>
> 
> Add netdev_rx_queue_restart() function to netdev_rx_queue.h. This is
> taken from Mina's work in [1] with a slight modification of taking
> rtnl_lock() during the queue stop and start ops.
> 
> For bnxt specifically, if the firmware doesn't support
> BNXT_RST_RING_SP_EVENT, then ndo_queue_stop() returns -EOPNOTSUPP and
> the whole restart fails. Unlike bnxt_rx_ring_reset(), there is no
> attempt to reset the whole device.
> 
> [1]: https://lore.kernel.org/linux-kernel/20240403002053.2376017-6-almasrymina@google.com/#t
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

nit: Mina's From line is above, but there is no corresponding Signed-off-by
     line here.

> ---
>  include/net/netdev_rx_queue.h |  3 ++
>  net/core/Makefile             |  1 +
>  net/core/netdev_rx_queue.c    | 58 +++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 net/core/netdev_rx_queue.c
> 
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index aa1716fb0e53..e78ca52d67fb 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -54,4 +54,7 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>  	return index;
>  }
>  #endif
> +
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> +
>  #endif
> diff --git a/net/core/Makefile b/net/core/Makefile
> index 21d6fbc7e884..f2aa63c167a3 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
>  
>  obj-y += net-sysfs.o
>  obj-y += hotdata.o
> +obj-y += netdev_rx_queue.o
>  obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
>  obj-$(CONFIG_PROC_FS) += net-procfs.o
>  obj-$(CONFIG_NET_PKTGEN) += pktgen.o
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> new file mode 100644
> index 000000000000..9633fb36f6d1
> --- /dev/null
> +++ b/net/core/netdev_rx_queue.c
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

nit: my understanding is that, as a .c file, the correct SPDX format is:

// SPDX-License-Identifier: GPL-2.0

...

