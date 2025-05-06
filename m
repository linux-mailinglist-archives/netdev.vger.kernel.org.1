Return-Path: <netdev+bounces-188399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13630AACA70
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A51C41969
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBDE283CB0;
	Tue,  6 May 2025 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5p/kv0rM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3E280A29;
	Tue,  6 May 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547664; cv=none; b=OYNaOQKt1Ia7aEfcQxAmWis1CJDoIDapRbE8T9dcHqYpV7zToNzw7oMv7orh27qMGKBpCr2XLRYom4Sou+u6U2iFlSbjHGe50i0cZ/0FPzHEAh5m9rrOhTxfSX1jk9/jvl2KQu4FiqDHuqPsF0/e26Ok/taqIvSkXG+nsPsPGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547664; c=relaxed/simple;
	bh=R57uE80QHeIxF/beQ/FwZmTbYeEK5J1gOynGnagEdr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUCwlrwVFFiQpgnkIzwVELucM83YUez3lSZDZIMlrvGfqMj1iTtHrui6OjZGiO1VxzmzuFFTvpqFZ+hEacqwV4Ad2eXl8ZQ0AjcTF4N6VsomaRt6U/3RyReSOwaWXXfmWsfJpNTNX7/gGbxOM98/axJebCKuM66nlmccxd2wIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5p/kv0rM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o7khUtuXqkV12JSbjwJ8x1EVYWn6Fhstp775RFxlELY=; b=5p/kv0rMi9GpXe3Pn03TSlFekd
	HhGxmjvOC9EnUnrbDizJhCGgBQePk+h0yjY6mSSqJEjOrYygCNsN/dAT1+mP1Rk44kDdhzFttRXTy
	JO52Dn85kBMF/xtIfRY+mErY/izASMwAfHKg52XDgdNcnQFpfLCe7KL4CGXN5/6yB3gw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCKpP-00BmaD-GB; Tue, 06 May 2025 18:07:31 +0200
Date: Tue, 6 May 2025 18:07:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Shalimov <alex-shalimov@yandex-team.ru>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] net/tun: expose queue utilization stats via ethtool
Message-ID: <c02e519b-8b7d-414c-b602-5575c9382101@lunn.ch>
References: <20250506154117.10651-1-alex-shalimov@yandex-team.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506154117.10651-1-alex-shalimov@yandex-team.ru>

On Tue, May 06, 2025 at 06:41:17PM +0300, Alexander Shalimov wrote:
> TUN/TAP devices are heavily used in network virtualization scenarios
> such as QEMU/KVM with "-netdev tap" and are commonly paired with virtio-net
> or vhost-net backends. Under high network load, queues of the tuntap device
> may become saturated, resulting in TX drops.
> 
> Existing aggregated drop counters alone are often insufficient during
> complex debugging and performance tuning, especially in high-throughput
> environments. Visibility of real-time queue utilization is critical for
> understanding why guest VMs might be unable to dequeue packets in time.
> 
> This patch exposes per-queue utilization statistics via ethtool -S,
> allowing on-demand inspection of queue fill levels. Utilization metrics are
> captured at the time of the ethtool invocation, providing a snapshot useful
> for correlation with guest and host behavior.

This does not fit the usual statistics pattern, which are simple
incremental counters. Are there any other drivers doing anything like
this?

Maybe devlink resources would be a better API? That would also allow
you to report the size of the ring.

> +static void tun_get_ethtool_stats(struct net_device *dev,
> +				  struct ethtool_stats *stats, u64 *data)
> +{
> +	struct tun_struct *tun = netdev_priv(dev);
> +	struct tun_file *tfile;
> +	int i;
> +	int producer, consumer, size, usage;
> +
> +	rcu_read_lock();
> +	for (i = 0; i < dev->real_num_tx_queues; i++) {
> +		tfile = rcu_dereference(tun->tfiles[i]);
> +
> +		producer = READ_ONCE(tfile->tx_ring.producer);
> +		consumer = READ_ONCE(tfile->tx_ring.consumer_head);
> +		size = READ_ONCE(tfile->tx_ring.size);
> +
> +		if (producer >= consumer)
> +			usage = producer - consumer;
> +		else
> +			usage = size - (consumer - producer);

It seems like this belongs in ptr_ring.h along with all the other
methods which deal with insides of the ring.

	Andrew

