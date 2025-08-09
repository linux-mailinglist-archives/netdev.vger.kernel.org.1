Return-Path: <netdev+bounces-212331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A863EB1F4E3
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5E03A6902
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF257274666;
	Sat,  9 Aug 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgXxpUPq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C679DA;
	Sat,  9 Aug 2025 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754748900; cv=none; b=qlcAjY+D61vik/ex4Bq5k33kkJP6ZNuuTa4QomPm2mEC7QipaJypYjcco5AT/eHj8TExvFGt6gQebtWBduy/KpQFePnmpkY734iTJAkJW5tc01hWPWncoGQ+D0RoLwF6efjvZA01iGMHlTToSoZFgIZo/v3QVv7RM3QbiOsNzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754748900; c=relaxed/simple;
	bh=Pk6pPPMvUqi5myCvoH2k9hVCTAmYLnGaZ3zsLuMDe8E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dhhvxlIwiD4sVG6H8ugPiWZuk0QqTl5KAGwuJFB0y49kZH8p8lMlniqfDTU2Wbtx4WuLPjx6oj/d0qPV4W6Y5JzrKGxgDzhAVvPzyNTs8XNHJG46iisAdS81gWjGnbdFR1ADkU6CzkojzqncH2Zjz5KS8FihTWcd3+q7ygPs0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgXxpUPq; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70744318bb3so26372546d6.3;
        Sat, 09 Aug 2025 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754748898; x=1755353698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5/kw8Cuk8L8DIVfN5icXBoPj/7ybSbwOKh3G7AKdjo=;
        b=mgXxpUPqFBdiAdCl/Aa4he8WWnrRfrYa7QnvDB2MRJaHRr1ZneSKSxGW6AEuCs4+oK
         rG9R7ygfQCq8UeWuI7aZ2LCq924DzVAxV6L1XGPetvPBZfwMC8nQxd+aaXQYIxpDqhC1
         l+YXGnPAxuOVIW9f2SIKqBL5PPTj4bj1IKa4mRDcy+Q92fWE6eumO898+JUCENAsJUhE
         cRCxamt1NxT4qE3LV4suyF5FlxMBdwJ7BcvlXyEIz9u2DV51NUNADrb8m1c6A7tCLTpS
         0fwduvtGFzWsIdiftir76WDQYKKzlB6sKUiB459T8aPp7snz0T0tmYcZuLf9Xtupi7HW
         ZW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754748898; x=1755353698;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5/kw8Cuk8L8DIVfN5icXBoPj/7ybSbwOKh3G7AKdjo=;
        b=v9owpGJ/mN4UYUM2Hj8JT1N4H8HkSMIGK8U8Gig4yql8N6pey+aX8eGUyZDoKpxQYk
         YLEsQlbQt1GZxKDBIoAq2ZVmQwT7N+XfZ3a742oD4l5YPn1bQpb2S5UDY9ixunAQ2S6e
         SuYLORjvhfdux0aFYLEauCGmMtXGOC8UCDQ8YaHXFbsaIYNPg0MibFjRZgf/Bm4Cf4/z
         aj62atAMVgscfUtidFSJMRjGM9AuiaVNoU+r9fdrcw5cDyHCS0frWoiBCEGZlQAECb23
         2BXkopjljpaO8mat24ZIf4v63XQJU47Do1AfEOtgI/KGHflc1PKixKItDcdikS0Vs3xB
         EHwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMQtX57SGeI7MBZW8ycKcurASg04kbUDiJcFlhhkGIsdDaqK+bPWlJu8eae2fhps+5N5YN6COD@vger.kernel.org, AJvYcCX2Rg7kMlb3MrC4y8nmnbvW062MBBv6PShEofq1M8/avI2PRcYn3C/afmo2qOaC2lIuo3tjlqMsj4vhFnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYi77oKr0sStCra3z+vyZhY4VulNyI4Yh2QGw+JeG2SEbgbp49
	BtP2b8PVdkO1mFTGRUIaEeEMDSBOuUaNrj7Y8oGZeZjdxaJ8VpK2Kok5GmX8Ytgr
X-Gm-Gg: ASbGncudeXxkQ9w88uiMVvLAcris/olBkwpnt5dwfSMH2QlISNT0iTXAPP4dQLzex8E
	ygs5tY5S3Du+MpM3uJqqaU4CTjZZ1lPsPrjxWgWkbt193qlEWwdW2ziP1d+svrGZOHpe+BIc4Ib
	3bY3DhfW15E8uvTlMutmE9MShfPNUfHBoID80PEZTwiCPvNBSB0ZTaDXKhetsNEGnLNzOk9myWk
	9dIZzyqr2Z2VpgQhCls5EEqvX1efnbKOk+060YE+TDKx4hklb4RiPzOfme268vjHV+qQstanjzo
	K673X6OJ+o3b9Gl2LWwuaKHU+eFlpW6RLHVJwtjRinGaGffT7jAhiFKHcetQaZsZC6QZAeYlxQc
	nVIE8sv+oz8UPZoIRA9HKyW2RsD6ikmSE5Go21U1YOCQlr66SVHDRaf7lZQYftzmdnAm0fw==
X-Google-Smtp-Source: AGHT+IG34/q/ALagKj7YliOl5pPCQGwMSDy5c/GyO8Th2886kPksrTRCIPTr4DFddCC92o62UTj7Mw==
X-Received: by 2002:a05:6214:c29:b0:707:228e:40b9 with SMTP id 6a1803df08f44-7099a332e82mr120381026d6.23.1754748897591;
        Sat, 09 Aug 2025 07:14:57 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077ca3621asm127118316d6.33.2025.08.09.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 07:14:57 -0700 (PDT)
Date: Sat, 09 Aug 2025 10:14:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 Tim Gebauer <tim.gebauer@tu-dortmund.de>
Message-ID: <689757e093982_2ad3722945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250808153721.261334-1-simon.schippers@tu-dortmund.de>
References: <20250808153721.261334-1-simon.schippers@tu-dortmund.de>
Subject: Re: [PATCH net] TUN/TAP: Improving throughput and latency by avoiding
 SKB drops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Schippers wrote:
> This patch is the result of our paper with the title "The NODROP Patch:
> Hardening Secure Networking for Real-time Teleoperation by Preventing
> Packet Drops in the Linux TUN Driver" [1].
> It deals with the tun_net_xmit function which drops SKB's with the reason
> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
> resulting in reduced TCP performance and packet loss for bursty video
> streams when used over VPN's.
> 
> The abstract reads as follows:
> "Throughput-critical teleoperation requires robust and low-latency
> communication to ensure safety and performance. Often, these kinds of
> applications are implemented in Linux-based operating systems and transmit
> over virtual private networks, which ensure encryption and ease of use by
> providing a dedicated tunneling interface (TUN) to user space
> applications. In this work, we identified a specific behavior in the Linux
> TUN driver, which results in significant performance degradation due to
> the sender stack silently dropping packets. This design issue drastically
> impacts real-time video streaming, inducing up to 29 % packet loss with
> noticeable video artifacts when the internal queue of the TUN driver is
> reduced to 25 packets to minimize latency. Furthermore, a small queue

This clearly increases dropcount. Does it meaningfully reduce latency?

The cause of latency here is scheduling of the process reading from
the tun FD.

Task pinning and/or adjusting scheduler priority/algorithm/etc. may
be a more effective and robust approach to reducing latency.

> length also drastically reduces the throughput of TCP traffic due to many
> retransmissions. Instead, with our open-source NODROP Patch, we propose
> generating backpressure in case of burst traffic or network congestion.
> The patch effectively addresses the packet-dropping behavior, hardening
> real-time video streaming and improving TCP throughput by 36 % in high
> latency scenarios."
> 
> In addition to the mentioned performance and latency improvements for VPN
> applications, this patch also allows the proper usage of qdisc's. For
> example a fq_codel can not control the queuing delay when packets are
> already dropped in the TUN driver. This issue is also described in [2].
> 
> The performance evaluation of the paper (see Fig. 4) showed a 4%
> performance hit for a single queue TUN with the default TUN queue size of
> 500 packets. However it is important to notice that with the proposed
> patch no packet drop ever occurred even with a TUN queue size of 1 packet.
> The utilized validation pipeline is available under [3].
> 
> As the reduction of the TUN queue to a size of down to 5 packets showed no
> further performance hit in the paper, a reduction of the default TUN queue
> size might be desirable accompanying this patch. A reduction would
> obviously reduce buffer bloat and memory requirements.
> 
> Implementation details:
> - The netdev queue start/stop flow control is utilized.
> - Compatible with multi-queue by only stopping/waking the specific
> netdevice subqueue.
> - No additional locking is used.
> 
> In the tun_net_xmit function:
> - Stopping the subqueue is done when the tx_ring gets full after inserting
> the SKB into the tx_ring.
> - In the unlikely case when the insertion with ptr_ring_produce fails, the
> old dropping behavior is used for this SKB.
> - In the unlikely case when tun_net_xmit is called even though the tx_ring
> is full, the subqueue is stopped once again and NETDEV_TX_BUSY is returned.
> 
> In the tun_ring_recv function:
> - Waking the subqueue is done after consuming a SKB from the tx_ring when
> the tx_ring is empty. Waking the subqueue when the tx_ring has any
> available space, so when it is not full, showed crashes in our testing. We
> are open to suggestions.
> - Especially when the tx_ring is configured to be small, queuing might be
> stopped in the tun_net_xmit function while at the same time,
> ptr_ring_consume is not able to grab a packet. This prevents tun_net_xmit
> from being called again and causes tun_ring_recv to wait indefinitely for
> a packet. Therefore, the queue is woken after grabbing a packet if the
> queuing is stopped. The same behavior is applied in the accompanying wait
> queue.
> - Because the tun_struct is required to get the tx_queue into the new txq
> pointer, the tun_struct is passed in tun_do_read aswell. This is likely
> faster then trying to get it via the tun_file tfile because it utilizes a
> rcu lock.
> 
> We are open to suggestions regarding the implementation :)
> Thank you for your work!
> 
> [1] Link:
> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2
> 025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> [2] Link:
> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective
> -on-tun-device
> [3] Link: https://github.com/tudo-cni/nodrop
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index cc6c50180663..e88a312d3c72 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1023,6 +1023,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	netif_info(tun, tx_queued, tun->dev, "%s %d\n", __func__, skb->len);
>  
> +	if (unlikely(ptr_ring_full(&tfile->tx_ring))) {
> +		queue = netdev_get_tx_queue(dev, txq);
> +		netif_tx_stop_queue(queue);
> +		rcu_read_unlock();
> +		return NETDEV_TX_BUSY;

returning NETDEV_TX_BUSY is discouraged.

In principle pausing the "device" queue for TUN, similar to other
devices, sounds reasonable, iff the simpler above suggestion is not
sufficient.

But then preferable to pause before the queue is full, to avoid having
to return failure. See for instance virtio_net.

> +	}
> +
>  	/* Drop if the filter does not like it.
>  	 * This is a noop if the filter is disabled.
>  	 * Filter can be enabled only for the TAP devices. */
> @@ -1060,13 +1067,16 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +	if (unlikely(ptr_ring_produce(&tfile->tx_ring, skb))) {
> +		netif_tx_stop_queue(queue);
>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}
> +	if (ptr_ring_full(&tfile->tx_ring))
> +		netif_tx_stop_queue(queue);
>  
>  	/* dev->lltx requires to do our own update of trans_start */
> -	queue = netdev_get_tx_queue(dev, txq);
>  	txq_trans_cond_update(queue);
>  
>  	/* Notify and wake up reader process */
> @@ -2110,15 +2120,21 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	return total;
>  }
>  
> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> +static void *tun_ring_recv(struct tun_struct *tun, struct tun_file *tfile, int noblock, int *err)
>  {
>  	DECLARE_WAITQUEUE(wait, current);
> +	struct netdev_queue *txq;
>  	void *ptr = NULL;
>  	int error = 0;
>  
>  	ptr = ptr_ring_consume(&tfile->tx_ring);
>  	if (ptr)
>  		goto out;
> +
> +	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
> +	if (unlikely(netif_tx_queue_stopped(txq)))
> +		netif_tx_wake_queue(txq);
> +
>  	if (noblock) {
>  		error = -EAGAIN;
>  		goto out;
> @@ -2131,6 +2147,10 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  		ptr = ptr_ring_consume(&tfile->tx_ring);
>  		if (ptr)
>  			break;
> +
> +		if (unlikely(netif_tx_queue_stopped(txq)))
> +			netif_tx_wake_queue(txq);
> +
>  		if (signal_pending(current)) {
>  			error = -ERESTARTSYS;
>  			break;
> @@ -2147,6 +2167,10 @@ static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
>  	remove_wait_queue(&tfile->socket.wq.wait, &wait);
>  
>  out:
> +	if (ptr_ring_empty(&tfile->tx_ring)) {
> +		txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
> +		netif_tx_wake_queue(txq);
> +	}
>  	*err = error;
>  	return ptr;
>  }
> @@ -2165,7 +2189,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>  
>  	if (!ptr) {
>  		/* Read frames from ring */
> -		ptr = tun_ring_recv(tfile, noblock, &err);
> +		ptr = tun_ring_recv(tun, tfile, noblock, &err);
>  		if (!ptr)
>  			return err;
>  	}
> -- 
> 2.43.0
> 



