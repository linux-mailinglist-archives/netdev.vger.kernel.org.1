Return-Path: <netdev+bounces-79996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5487C562
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 23:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA9E1C202DC
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9275C13D;
	Thu, 14 Mar 2024 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzyGw/dg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36BBE62;
	Thu, 14 Mar 2024 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456978; cv=none; b=LZiCOMF28Dtg3cw2KnKSLTuMRYoToPFkaeaUcNakd9IHp4cVM9JdFtfV7w46tov0L1Tf7UrT/xS0zugY2AZztJIHPyIPxFoo1jLKV7whbdU6FCML5JLPD8yEu9QOFnIUJ6iREuMJ93neyJcyXNe3IKwYk+NC1rTXN5ZVJGHVFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456978; c=relaxed/simple;
	bh=iMEA64HbMPPlwVyRScuWhR08kJHdqUe2im7H/gW3wCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPwHk31raOopEowZzBUp9a1HmMSgkv8jXQxoHcMoKdLa8P0ZpV9iEVKlJkejF5VFdDKHR2AhVle9dMNLeAOR06jE6w+81ERPskgTyrT3QFIhAfbFv+dc/O3AOilIvE3FXF7g1FPn6U94eMrygwuvY5hsYoI+k+1nMQtXjQIbIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzyGw/dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684A3C433C7;
	Thu, 14 Mar 2024 22:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710456978;
	bh=iMEA64HbMPPlwVyRScuWhR08kJHdqUe2im7H/gW3wCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzyGw/dgwa/OaDl39BJx8aYs7FVwxgheL4KM3iCLagCFwHi5Yc84EBfOOQy1hyinr
	 KcoNHj1lJ+/lJXfvJ2f9TkWYeWQ96opLtOkGMwMI3De4/DWTx4eb9aEpUX+dv6z9WR
	 eoUlZa5NOb0P10oq0PPsDlS+ljDFkybIiJk4FaF1hgAWhhcrga7dXQswMrjgmwMQSr
	 SeMUVGLsZi4NjKK9/+KjnDWi/Rw79SrN7LcRZFqCESp9Tj09378Qna0XEE58vnGUVC
	 +F7GCiFxEN9Ai2i//ClzlKexOTwZARfbOBo1vmryKY7PS0Uc6xvpX0CaIoxbmToNbn
	 Y07Fj/H0BujTg==
Date: Thu, 14 Mar 2024 15:56:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@google.com>, Amritha
 Nambiar <amritha.nambiar@intel.com>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Sridhar Samudrala
 <sridhar.samudrala@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 8/8] virtio-net: support queue stat
Message-ID: <20240314155616.107de7c3@kernel.org>
In-Reply-To: <20240314085459.115933-9-xuanzhuo@linux.alibaba.com>
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
	<20240314085459.115933-9-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 16:54:59 +0800 Xuan Zhuo wrote:
> +static void virtnet_get_base_stats(struct net_device *dev,
> +				   struct netdev_queue_stats_rx *rx,
> +				   struct netdev_queue_stats_tx *tx)
> +{
> +	/* The queue stats of the virtio-net will not be reset. So here we
> +	 * return 0.
> +	 */
> +	memset(rx, 0, sizeof(*rx));
> +	memset(tx, 0, sizeof(*tx));
> +}

/**
 * struct netdev_stat_ops - netdev ops for fine grained stats
 * @get_queue_stats_rx:	get stats for a given Rx queue
 * @get_queue_stats_tx:	get stats for a given Tx queue
 * @get_base_stats:	get base stats (not belonging to any live instance)
 *
 * Query stats for a given object. The values of the statistics are undefined
 * on entry (specifically they are *not* zero-initialized). Drivers should
 * assign values only to the statistics they collect. Statistics which are not
 * collected must be left undefined.                  ^^^^^^^^^^^^^^^^^^^^^^^^
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

