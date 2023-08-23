Return-Path: <netdev+bounces-29834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD67784DE6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 02:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B0C2811C8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301727E2;
	Wed, 23 Aug 2023 00:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A528EBE
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525DBC433CB;
	Wed, 23 Aug 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692751223;
	bh=+78T4vWdit4IBjxIp0H8k/XvIeNF8KEiuKYsoYa3w4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a17iPD55G2I/sh3Gh+17YHJ2Gmn+N59m2dUAwkHxHCuzqbkYwtGAg2y5bdcMSeVnO
	 UoXRz++9eoG655/mzqIV5YiMSP9bxoWl85v6c+bzpRBv6ZaQ5ExlcZQvs3rFc1p5CN
	 fQ24pr2DsS0Dv3OyPzoIC1uEDbvMkSUlFd0Qb7rW2cO0Rm/ZksDiZ4lwC78cGZwBbm
	 p7Zp4kvRMZBO57wQqwlBobo8k74wURi3beZta+02fOLwEAyjVI/37JLPX6T+uTQP7T
	 YLPcnqs4umlrp8MY4R6ZZLMSlawzzyT9VPfGJoEOEC9nrC237Zgeu90KYCrmVZNghN
	 mI+QCSOUKcPhA==
Date: Tue, 22 Aug 2023 17:40:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v2 4/9] net: Move kernel helpers for queue
 index outside sysfs
Message-ID: <20230822174022.6fa412ac@kernel.org>
In-Reply-To: <169266033119.10199.3382453499474113876.stgit@anambiarhost.jf.intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
	<169266033119.10199.3382453499474113876.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Aug 2023 16:25:31 -0700 Amritha Nambiar wrote:
> +static inline
> +unsigned int get_netdev_queue_index(struct netdev_queue *queue)
> +{
> +	struct net_device *dev = queue->dev;
> +	unsigned int i;
> +
> +	i = queue - dev->_tx;
> +	DEBUG_NET_WARN_ON_ONCE(i >= dev->num_tx_queues);
> +
> +	return i;
> +}

If this is needed let's move it to a new header -
include/net/netdev_tx_queue.h ?

>  static inline struct netdev_queue *skb_get_tx_queue(const struct net_device *dev,
>  						    const struct sk_buff *skb)
>  {
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index 66bda0dfe71c..ac58fa7c2532 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h

