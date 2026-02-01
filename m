Return-Path: <netdev+bounces-255552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TD4DA6OYfmltbQIAu9opvQ
	(envelope-from <netdev+bounces-255552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:04:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A9C46DC
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE215300231D
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807943EBF16;
	Sun,  1 Feb 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjXiADGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EFA59;
	Sun,  1 Feb 2026 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904288; cv=none; b=VuccmH2P8XKcBhKwjEmqWUw02pfDbSjoSarvV7INvnZFW+F2ImUQZqBSGsdA8MFUhX0iqeGwyMLEzVoDuASY3WARSNM9XoyaWErXISNR4q0P1lc4XaRZVPPF0XFInodrfD18IRE+O7UidZp/jzb5k/XVvvST2H2MYzM+ppGlGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904288; c=relaxed/simple;
	bh=WbdPH/TpKDE53rm07TVweRKLlRnvF1alpfiqpwXOvHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKSejZp79k9x9KZDwJFcnX8loElPa/p1hLT8LcHA641ZiYlpfG3LnQWiuzYh2wWVagI96PXGf+KHrpTcFGpSdzbi2PaeHn0dhFoQVlYk2jCJ9eHVkWNF9Vil6yTnjvCaEyOxUZc791Aj9/s7i0v+qOz9s+fDnP4TKZulEQ0+Px8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjXiADGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94B8C4CEF1;
	Sun,  1 Feb 2026 00:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769904287;
	bh=WbdPH/TpKDE53rm07TVweRKLlRnvF1alpfiqpwXOvHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XjXiADGT2MNxAfiilPa8ZVWR4ZlhKPboV2OyCtF0f01q8Nzrmjh24vhlkMzOz9eRq
	 J2QByC9pgLHjTMl0tRhMl9Oxf6sLCbz5mwu6LnzXSa/AOl4sE3NIixvwXuY8A7BRl9
	 zmsDyQ5jxYz24wDQGuR9qYg3PCeahHn27l0KlUwLO0GVAg6aQ+fqoCUzHf9PcSDabx
	 5KHzEnsHk9etcj9t7aG3Q4rlA4loP/uHiSrtOV3Rk02zSaB2a6W45enfW48vvcQxtH
	 M9Rr5kbQHlkZbtyt+WoAKXC10eu6XWAS2KDXpj/dVAYZjp/VJdRPKewXqUa2B0JDmM
	 JjxWvL1AJSi4A==
Date: Sat, 31 Jan 2026 16:04:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 07/16] net: Proxy netdev_queue_get_dma_dev
 for leased queues
Message-ID: <20260131160445.2e49e9d3@kernel.org>
In-Reply-To: <20260129222830.439687-8-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-8-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255552-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 969A9C46DC
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:21 +0100 Daniel Borkmann wrote:
> - * Get dma device for zero-copy operations to be used for this queue.
> + * Get dma device for zero-copy operations to be used for this queue. If the
> + * queue is leased to a physical queue, we retrieve the latter's dma device.
>   * When such device is not available or valid, the function will return NULL.
>   *
>   * Return: Device or NULL on error
>   */
>  struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
>  {
> -	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
> +	const struct netdev_queue_mgmt_ops *queue_ops;
>  	struct device *dma_dev;
>  
> +	if (idx < dev->real_num_rx_queues) {
> +		struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, idx);
> +
> +		if (rxq->lease) {
> +			rxq = rxq->lease;
> +			dev = rxq->dev;
> +			idx = get_netdev_rx_queue_index(rxq);
> +		}
> +	}
> +
> +	queue_ops = dev->queue_mgmt_ops;

We're gonna call physical device's op without locking it no?

