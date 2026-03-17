Return-Path: <netdev+bounces-268582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECMpHOxDuWmK+QEAu9opvQ
	(envelope-from <netdev+bounces-268582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:07:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C13812A982A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0EC7301AF49
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB9D3BAD9D;
	Tue, 17 Mar 2026 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3x96tee";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lg5XTv8Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F73BA25E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749071; cv=none; b=JJBdPx/0usILcRFMox+Dn8LLHe45fo/LL/D9Enmp4Yo5Al6kiQzMlV1+A/PoYmdcf8MGPQ0D80sNIJNwdaX19Kv6NhNgUtMlOj5fVsCp5NmVhFnV9jzIWgjbIYvRTdupRlPbJ7WkTK8zZsCq0xIS7RlQJwuTIEIas0pZ8jCkskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749071; c=relaxed/simple;
	bh=gXf7h6m3QFucjAyYb0Chs97a79d9hUiTRP/yW6fiHjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUaTsEH4oRcZISDUdjZnLvcSJ8t9Z+gxJSp24EhNf9CLEw/Lu5WYMz/PJ0UkE6Rx8cFVvabMTQPFotVe1vFDBRBM+0RE0pxi78+63Ec4fQvzjVKF15bniRCTw/vMDXMjj0AnoZ/bNld/AF7cLfnyvvxzfiLq52oQWAKyEPq1Wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3x96tee; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lg5XTv8Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773749067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OUPcuOst/Vgj50RX9iunVkzL2by2SSGoTL5fXS6O4A=;
	b=c3x96tee3Cls7nn1ernOcqND0b5B0eHy+TFC3w43rHIfUiwpt6IMOhzmhSMfqdW3Cvblb5
	2oUS5ZeYaCja2f2QAv9j6NPL9lZHQtvoYDsBNH7B6pe4M3P8H4VETCB/LCv2YwWoUxxmw5
	fFMRcYNwZxRylQUhXBpWFrqOnNG5KVA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-KPwWUr2BOJa7GQoW136hlw-1; Tue, 17 Mar 2026 08:04:25 -0400
X-MC-Unique: KPwWUr2BOJa7GQoW136hlw-1
X-Mimecast-MFC-AGG-ID: KPwWUr2BOJa7GQoW136hlw_1773749064
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853466655dso53077655e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773749064; x=1774353864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OUPcuOst/Vgj50RX9iunVkzL2by2SSGoTL5fXS6O4A=;
        b=Lg5XTv8ZBF2gjJurzAyNukRbceWh5m/PkiAy0M+0hw9azRk9f12cAx6w91uz0wAB3F
         ma2VeYlTLOWC/RNQcM9sugwkOrd0fcZERER2/AjB4vW+KGNOyz1QrU5hh/jj8xm6G6on
         zjtTbaKqLjVWJnr5BwewKyn/KPOGpEQjlN74zYS0Xy2i5VsENaJMMGXCQ/VfSDA4ucgb
         upMcOJG2qLOQwtNBGtIXWZkEqg/oMzUb2glbg/4cI8bYDsb5gdu3+oIPisOQvcFCg7Ce
         w1MVIVcN3Q+3HoOxUMpuelWXm8QFE0CUHC5QsuSr5ZjiTBX+5nRWF/7hjHZKqIEkIK86
         +Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773749064; x=1774353864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OUPcuOst/Vgj50RX9iunVkzL2by2SSGoTL5fXS6O4A=;
        b=XEPrQ0QZswLVITt/LIXVkUoFvsTp1RQ7eyRDLyoC8yVi7yUyYMhGBVhOH6BTfMVawJ
         p5QpEo/Oi8zpSbfq4j8b69gGZsMcLjkdoFSyARUIFFWiQHtufASCfBn/+qkFbNvOKfeu
         esQSMBzNtBrgfoRsZ18JaXofRGdD1a2GYRdnA3GZ8vgX3kJlGB5dRKd3n1++jFS32kUT
         h0NgRMuBD0w5YObEvuaku5PA/zoOJJtFUSQo/Mj3Yxd/5/dwHf3ZnEMm42fyl/Rbvvfq
         +so1EnV5sUTbQQmz5DrJXFyJQLt/KOMQNAN1DMXglAecQG/Fd5C4qq+3Dfl++Df1GZV+
         c5aw==
X-Forwarded-Encrypted: i=1; AJvYcCUeveeKbgbgdFuzxZ8HYI8LxgevE+WZKgNxATPla3L/s9CP2oxNWCXLHzMLWHoJRCt2xNtZDkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjaJjH2VHNcwT3vVJNnQDKvj1v1smlsP24h1JjaXAVoZL1dcJ
	y8EIb5eLtglhwdkcssQl1ociKbbC7CI9ztq1MCv7OpQMol8F89IKKkVNt46opdDfVb6pSJzVxZ2
	za2+BfyPqBKSINzPPTYH2DdKyHnuM1dsw8n21UM0Q/2fgm7BoJwMgTwln9Q==
X-Gm-Gg: ATEYQzyBP/+O4FJgrx9NuEztv9sD03OUAN5i/qf9cqG3eE9ynmz5252tX2JvoK19U5/
	azfGnFWH4yzqVEsZQ5joyvqYdZINp67ScLj+T4zESzaPBGFXg5sDfVNi2ihWdZZbb8RQDAReepi
	L6fPUo0cgKnZxT65by+KoUSoHEPMRdp1OIaZzfas/jbzY4CP/QXJ5N7CHk1M/FFcZH/Ec9OahgB
	k9OB2ygGnQZZiw3CXmtEZTXjS0/e7PJ68t3Pfn0Rm6cxNgYqOifS9ssN9aFn48QFQHxXkLoPwK9
	skPJxjA56qwdt80n6FTNIX8tKoXqxRggu14Y9MK2+pg7eEFvIwnkPtrda/Rn87CafnCLhssJr29
	zelcrm7MX3z7tsq9bhmSTCA/SIAkL40GQjnFUwePHrCQtFQ==
X-Received: by 2002:a05:600c:1d0e:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4855671fac1mr306212655e9.25.1773749063418;
        Tue, 17 Mar 2026 05:04:23 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0e:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4855671fac1mr306211665e9.25.1773749062823;
        Tue, 17 Mar 2026 05:04:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm118112975e9.20.2026.03.17.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 05:04:22 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:04:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Di Zhu <zhud@hygon.cn>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	lijing@hygon.cn, yingzhiwei@hygon.cn,
	Philo Lu <lulie@linux.alibaba.com>, Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260317074739-mutt-send-email-mst@kernel.org>
References: <20260317113433.927022-1-zhud@hygon.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317113433.927022-1-zhud@hygon.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268582-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hygon.cn:email]
X-Rspamd-Queue-Id: C13812A982A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 07:34:33PM +0800, Di Zhu wrote:
> Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> allows control over offload support, but the offloads that can be
> controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> nor GUEST_TSO6 is supported).
> 
> In such a setup, reporting NETIF_F_GRO_HW as available for the device
> is too optimistic and misleading to the user.
> 
> Improve the situation by masking off NETIF_F_GRO_HW unless the device
> possesses actual GRO-related offload capabilities. Out of an abundance
> of caution, this does not change the current behaviour for hardware with
> just v6 or just v4 GRO: current interfaces do not allow distinguishing
> between v6/v4 GRO, so we can't expose them to userspace precisely.
> 
> Fixes: dbcf24d15388 ("virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LRO")
> Signed-off-by: Di Zhu <zhud@hygon.cn>
> ---
> /* v3 */
>   -Update Fixes tag to dbcf24d15388
>   -Refine commit message using Maintainer's "too optimistic" 
>     phrasing to clarify the risk of misleading configurations.
> 
> /* v2 */
>   -make the modified logic clearer
> ---
>  drivers/net/virtio_net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..b233c99925e9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
>  		dev->features |= NETIF_F_GRO_HW;
> -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> -		dev->hw_features |= NETIF_F_GRO_HW;
>  
>  	dev->vlan_features = dev->features;
>  	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> +		dev->hw_features |= NETIF_F_GRO_HW;
> +

Hmm wait a second. Isn't this late? netdev registered, even link is
up already.

Documentation/networking/netdev-features.rst says:

 1. netdev->hw_features set contains features whose state may possibly
    be changed (enabled or disabled) for a particular device by user's
    request.  This set should be initialized in ndo_init callback and not
    changed later.



I'd say let's move it up?





Having said that, we already have a bug:

  dev->hw_features &= ~NETIF_F_RXHASH;                                                                                                   
is after register, too.

This is because we take pains to recover from these commands failing.
Except, we completely ignore that in virtnet_set_rxfh ...


Cc relevant contributors to maybe take a look at fixing all that.



>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> -- 
> 2.34.1
> 


