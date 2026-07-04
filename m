Return-Path: <netdev+bounces-304709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NB3BDhMCSWrBxQAAu9opvQ
	(envelope-from <netdev+bounces-304709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 14:52:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E62707A8E
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 14:52:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CrwIEsdm;
	dkim=pass header.d=redhat.com header.s=google header.b=pjeWcB6C;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304709-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304709-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D848301468A
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31803B634C;
	Sat,  4 Jul 2026 12:52:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF83A1A21
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 12:52:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783169550; cv=none; b=Bcy0xZVThuL/aQngyRw59L1sfpjpSvN/NNFxtcpadM282G4JgJPDRATton4zfj9Bq4o9MrCU4w7QEmju9C+8+CDvGow9qnSASPoYuJmKfViaI9hjLZNLsHpuHsmka0WoqGmX4hfVV7+sKa2hzTassvnxnoE1Ow7je4MvogZb388=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783169550; c=relaxed/simple;
	bh=/WmRAos1Whor3b/aXjI813fSEyKrawxZCTuOqTr8FUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRpf5d2ZQyAartZZrLdSkfX/0f0qO1qfzLdMZgVIP6Fhn4KQPq8s7MUqcUbgz7tIeTt0sDswmdKucMtL8b/byxuMzgG8yB8gjqtS+gXX/JJyh2H4rh9J64rakX1E50VS5ahmTote7TB+GWTvDbYbfUwvaRPcT4sRySwhTae1ui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrwIEsdm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pjeWcB6C; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783169532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8sBlbuDZCtRHGl7YSIMCD5RtkvP80XA/MjKh+Fe5r9I=;
	b=CrwIEsdmqzEi7YNwTGhdiSPrIMuybgTNe/8wLYBBsEl+COc74fDcIR7cBK8lI483yTn8c3
	DDeSVw3z+/c9yMKielj17ZnzV624+Lo88s9z4xopHBNPu26aZlbU+oY3LqyoN9XnuK8OLs
	qw3HGkTgBdXlgYPWBwMaDWgqERqxHyo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-M4TH6qBoPja14ogsLz0MQg-1; Sat, 04 Jul 2026 08:52:11 -0400
X-MC-Unique: M4TH6qBoPja14ogsLz0MQg-1
X-Mimecast-MFC-AGG-ID: M4TH6qBoPja14ogsLz0MQg_1783169530
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so15086245e9.1
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783169530; x=1783774330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8sBlbuDZCtRHGl7YSIMCD5RtkvP80XA/MjKh+Fe5r9I=;
        b=pjeWcB6CdTJZaP5WJdgwb7J6jPk1AHT8RRCCqU4j36ZKed+o3Y5f8EPoHlSHk3YJLE
         GTh2/q9149d0V3Gcxcr9nvjzCdFQKHfat6CM9+ZprlkkBk+VUHjlTSA+I6mTjHF8C5X4
         2fylVWwRzUhQ1/+RN3T6L4cUENilShWeG6M39KFHV5S9pSUpjWFAoGfFmBoEUEl2Z2pQ
         d++41dBsHuLKGRJb1Q2Ps9vVwyfQzp5uGNv1U8nDYYaRoxn3ZQ20DLtd2Mxze6dUI+tn
         fbi4AoiuKxvQ6KlOv+ieew568hSWq5entJ3k04GgfU0pNTUxo2B7KHdSoUtYGpk9PIpf
         F67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783169530; x=1783774330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sBlbuDZCtRHGl7YSIMCD5RtkvP80XA/MjKh+Fe5r9I=;
        b=deg1Ye/obyvqnMWA/1wezuzfRlRvPbs6KCeJRra8VBMx4O75+49zLxMzAh/ObuJ6Kx
         vauqTzotSzLebnKu2vQxu2yvcS3x3DT05uejYc6OM8mI+S+P5QIXbMu2lZtYyvxc42xC
         I4N2P3lTUyoFdUO0IMkDufPlWR0w5PBtBh08ZWN7nT4kBF8k8pqavGRwYcGWQyAJIpud
         XxGoDI2m7CVTuzzcXKm8gu5tL08wDxL9w9FLyUM44nHgDbkSPA0fLU5JHUvWOY+cAGAj
         Pi9jvLIBHUeIWu7R3dvgK60uyYE4JwJNat9vL5kWwZ5cVYwC2jEWgcfzdSsxZEH5p8ll
         vnxA==
X-Forwarded-Encrypted: i=1; AFNElJ/Xw3U8RnDgHihPDWmy53plH1vKkdmsJNdnF/ju0xCQpf+SiEgLPSJcwuFmEjeDXle2xZ/TV5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTV/RMpKt3nDbij4MF3Wo4sUgisdKiEcdEAzZGHQWtX/XwtEjy
	Qmt7+CSnGpIR4xDerVR2WpxWY0yfQAgCR//jnuu3Eq4ZZRHM5ZyldaEtqfLfYvPHLoVEkZZJYxB
	u3wfLyWD6OGamXSaEKdB7MMx7BXtjxd6qe/JBOC6OANdEwcckMdhv2PM+9w==
X-Gm-Gg: AfdE7clpFreUwtsRcZSfEmLi3UPvodyLGM4QJhAUUdXbSXAbcnJ1WcAmyjvlYvKW9Ix
	OVB678zA1T6H578vXxoHJWG/e6SJng4dvkNwUUcP/JMaT+QUFysSu7v+p6SxdXWA8o++R/WGtbB
	NcgZfcyFccNoLlX1Rysl+Z/TWOueufSn9f0Unmm6+uVOaAONp6MaYPLnAza2+MT0bbSJQbxznpM
	frTifpZBTAEp0uUP0BfXX09dQ7uKk1ViqLIkiu8455aOPprmTc/2r98cqLkEBKSB3232e4okvih
	eW6iUA3d+qQohsTe262Z0YSrGC2afXS5IkcWCAZF+jIOqcikHUvRk6kO1ra4dK2cXz2H1scdihJ
	L4NC05S5RlKcuOYfurJHrNv3eDqcwAYvIGElN9TKQ6Q==
X-Received: by 2002:a05:600c:13d6:b0:493:b243:8ffc with SMTP id 5b1f17b1804b1-493d11fb7c1mr23066675e9.35.1783169529660;
        Sat, 04 Jul 2026 05:52:09 -0700 (PDT)
X-Received: by 2002:a05:600c:13d6:b0:493:b243:8ffc with SMTP id 5b1f17b1804b1-493d11fb7c1mr23066515e9.35.1783169529176;
        Sat, 04 Jul 2026 05:52:09 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f21543sm7276901f8f.35.2026.07.04.05.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 05:52:08 -0700 (PDT)
Date: Sat, 4 Jul 2026 08:52:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tun/tap & vhost-net: make qdisc backpressure opt-in
 via IFF_BACKPRESSURE
Message-ID: <20260704085121-mutt-send-email-mst@kernel.org>
References: <20260704112058.95421-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704112058.95421-1-simon.schippers@tu-dortmund.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304709-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:simon.schippers@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:brett@librecast.net,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lwn.net,linuxfoundation.org,lunn.ch,tu-dortmund.de,librecast.net];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tu-dortmund.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94E62707A8E

On Sat, Jul 04, 2026 at 01:20:58PM +0200, Simon Schippers wrote:
> Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
> when a qdisc is present") did not show a relevant performance regression
> in my testing but on Brett Sheffield's librecast testbed it shows a
> significant performance drop. The regression can be pinpointed when
> multiple iperf3 TCP threads are sending. For 8 threads the performance
> dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is the reason why this
> patch makes the qdisc backpressure behavior opt-in.
> 
> One option to accomplish the opt-in would be to set the default qdisc to
> noqueue at init. However this may also break userspace as users might
> have chosen a custom qdisc even though most of the qdiscs did nothing
> for tun/tap in the past due to missing backpressure...
> 
> This is the reason why in this patch, the flag IFF_BACKPRESSURE is
> introduced instead which is required to enable the backpressure logic.
> This means the stopping logic in tun_net_xmit() and the waking logic in
> __tun_wake_queue() are skipped if the flag is disabled.
> 
> In tun_set_iff(), netif_tx_wake_all_queues() is replaced with looping
> over all tfiles in which the netdev queues are woken and cons_cnt is
> reset while the consumer_lock and producer_lock are held. This is to
> ensure that tun_net_xmit() can not stop the queue concurrently, avoiding
> a possible stall.
> 
> The documentation in tuntap.rst is updated accordingly.
> 
> Fixes: 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present")
> Reported-by: Brett Sheffield <brett@librecast.net>
> Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/T/#u
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>

the patch itself makes sense

Acked-by: Michael S. Tsirkin <mst@redhat.com>

The issue is it would ideally be in next, but we need it now
to fix the regression introduced by 1d6e569b7d0c.

> ---
>  Documentation/networking/tuntap.rst | 17 +++++++++++++++++
>  drivers/net/tun.c                   | 29 +++++++++++++++++++++++------
>  include/uapi/linux/if_tun.h         |  1 +
>  tools/include/uapi/linux/if_tun.h   |  1 +
>  4 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
> index 4d7087f727be..599264825dd2 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -206,6 +206,23 @@ enable is true we enable it, otherwise we disable it::
>        return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>    }
>  
> +3.4 qdisc backpressure
> +----------------------
> +
> +Starting with Linux 7.2, IFF_BACKPRESSURE can be set to enable qdisc
> +backpressure. Without it, TX drops occur when the internal ring buffer is
> +full. With it, the kernel stops the TX queue instead, letting the qdisc
> +hold packets. Drops only occur as a rare race. This can benefit protocols
> +like TCP that react to drops. Backpressure requires a qdisc to be
> +attached and has no effect with noqueue.
> +
> +The TUN/TAP ring buffer size can be reduced alongside this flag to
> +further shift buffering into the qdisc and reduce bufferbloat, but comes
> +at possible performance cost.
> +
> +When running multiple network streams in parallel, the flag may reduce
> +performance due to the extra overhead of the backpressure mechanism.
> +
>  Universal TUN/TAP device driver Frequently Asked Question
>  =========================================================
>  
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ffbe6f13fb1f..3bf8a73a0816 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -98,7 +98,8 @@ static void tun_default_link_ksettings(struct net_device *dev,
>  #define TUN_FASYNC	IFF_ATTACH_QUEUE
>  
>  #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
> -		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
> +		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS | \
> +		      IFF_BACKPRESSURE)
>  
>  #define GOODCOPY_LEN 128
>  
> @@ -1077,7 +1078,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	spin_lock(&tfile->tx_ring.producer_lock);
>  	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> -	if (!qdisc_txq_has_no_queue(queue) &&
> +	if ((tun->flags & IFF_BACKPRESSURE) &&
> +	    !qdisc_txq_has_no_queue(queue) &&
>  	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
>  		netif_tx_stop_queue(queue);
>  		/* Paired with smp_mb() in __tun_wake_queue() */
> @@ -2151,8 +2153,12 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  static void __tun_wake_queue(struct tun_struct *tun,
>  			     struct tun_file *tfile, int consumed)
>  {
> -	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
> -						tfile->queue_index);
> +	struct netdev_queue *txq;
> +
> +	if (!(tun->flags & IFF_BACKPRESSURE))
> +		return;
> +
> +	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
>  
>  	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
>  	smp_mb();
> @@ -2893,8 +2899,19 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  	/* Make sure persistent devices do not get stuck in
>  	 * xoff state.
>  	 */
> -	if (netif_running(tun->dev))
> -		netif_tx_wake_all_queues(tun->dev);
> +	if (netif_running(tun->dev)) {
> +		for (int i = 0; i < tun->numqueues; i++) {
> +			struct tun_file *i_tfile;
> +
> +			i_tfile = rtnl_dereference(tun->tfiles[i]);
> +			spin_lock_bh(&i_tfile->tx_ring.consumer_lock);
> +			spin_lock(&i_tfile->tx_ring.producer_lock);
> +			netif_wake_subqueue(tun->dev, i_tfile->queue_index);
> +			i_tfile->cons_cnt = 0;
> +			spin_unlock(&i_tfile->tx_ring.producer_lock);
> +			spin_unlock_bh(&i_tfile->tx_ring.consumer_lock);
> +		}
> +	}
>  
>  	strscpy(ifr->ifr_name, tun->dev->name);
>  	return 0;
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 79d53c7a1ebd..73a77141315c 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -69,6 +69,7 @@
>  #define IFF_NAPI_FRAGS	0x0020
>  /* Used in TUNSETIFF to bring up tun/tap without carrier */
>  #define IFF_NO_CARRIER	0x0040
> +#define IFF_BACKPRESSURE	0x0080
>  #define IFF_NO_PI	0x1000
>  /* This flag has no real effect */
>  #define IFF_ONE_QUEUE	0x2000
> diff --git a/tools/include/uapi/linux/if_tun.h b/tools/include/uapi/linux/if_tun.h
> index 2ec07de1d73b..97b670f5bc0a 100644
> --- a/tools/include/uapi/linux/if_tun.h
> +++ b/tools/include/uapi/linux/if_tun.h
> @@ -67,6 +67,7 @@
>  #define IFF_TAP		0x0002
>  #define IFF_NAPI	0x0010
>  #define IFF_NAPI_FRAGS	0x0020
> +#define IFF_BACKPRESSURE	0x0080
>  #define IFF_NO_PI	0x1000
>  /* This flag has no real effect */
>  #define IFF_ONE_QUEUE	0x2000
> -- 
> 2.43.0


