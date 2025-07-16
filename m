Return-Path: <netdev+bounces-207464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37CB076E1
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D9C584BFF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88911ADC97;
	Wed, 16 Jul 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZPTKGJX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF21A8F6D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672453; cv=none; b=Vr3OHM4I1M3kV2DBtyOevWW7TVNl1MwRqyJio9L42BTc/ekwYtAryRfMNi6+j1b1h28qrmAiR10qH6X3BYsNFUny+XksWtb0Cm5tQ203BGli3MIVtQ4C3B9pMK6vG4fbHp31WBKos1D5gyJmt/x1nWMB8f1pUEIs3DclWa22vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672453; c=relaxed/simple;
	bh=AhM7Gbo34MvyrwDuefykC3U1phCmTU+xRmitbDdZIb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrwVKQiBdtbkfd4VY1M8imXgikzm06wEpUzA/M6q8MVnA6X1XVC+8icwSBG3WP8NMhQfolzpdwOzSjruZxDjpL7kLqZBOEla0zjCrhE0CRkkCdXJ0S1LcN1qX+CRc0M6RRMuFtvQB2lUxtQCQPlQKzhKNuRFZYXY4qlCGqJ8shU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZPTKGJX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752672450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xIUzUI8LCPje/1PLfr5clYD7hM1EsM0qntpxYAf55oE=;
	b=FZPTKGJX37JrWvlsaJakUBWOYeSujkyINlT+VuaCdRem1cPKHzf9erF8hUDRw0KAZcwB+H
	dSdH4AyLBnPwTzIYb8IUOrOZ8nLrGs5653uV+4JOG+xR7ebe1H19U0kn8xZuWnGnXQ53Il
	/uKXG5KXJZRIA4+tG2JlonWqZ2g7qpc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-F35EFn1aP6Ocpy1J5h31Sw-1; Wed, 16 Jul 2025 09:27:29 -0400
X-MC-Unique: F35EFn1aP6Ocpy1J5h31Sw-1
X-Mimecast-MFC-AGG-ID: F35EFn1aP6Ocpy1J5h31Sw_1752672448
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso24925095e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 06:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672448; x=1753277248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIUzUI8LCPje/1PLfr5clYD7hM1EsM0qntpxYAf55oE=;
        b=Czun1xG/rxnxE0AZAjzl+dpTstlyYxmeyh4zbgJxz9khxDXBEAOkMlfbKX36otV7DX
         OrwjvESk1apnLZztKjRZ0hycnrIVS5YL8+hf8qMAqdTy2v4p6ttckgouaiUc6ASnRu+u
         KYa3i2hDYAONPx4gAjShp5tWh4xh56eOGZKTzr930/3y3lH5YCmjjAzTMXpjunQmL0Sm
         IA0SrLhmShQ5MXpXcQcg72I/opTTFAq2GxJUNsYsVxNoopmIwXQ7y11wgI7xJMfIwQFX
         Oz6qQRx5XaV9oLRICgOhT0xLlqJOYzKQqdnsWdcJseHbP2Eb4BCWOhZLb6zis7gVDiny
         wmyw==
X-Forwarded-Encrypted: i=1; AJvYcCV8jobM90iaBbRA2Lb5QPMOHJX92LLES0hhEVS1LcBjQpM3Tm14fKhAu4M/HPFAul4IlWXygnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRsw8678FKIM0veTPZcIM8Pk6V+r6Tvihk47AtqzehBO7H2OP
	9rkl9aQR6VD3CdiuWPnYza3Pja8rDknDSeCmeFjZHsocbGH+I7IbnDun2nHzt6kTfDrhICYoLN+
	bt1vmPNKUmaJ0OVZPjM5Nt+S0Bx1hDquVaqbBHaiKXOHgBRVVUvzDUMijgg==
X-Gm-Gg: ASbGnctuQD1w7oTldhCwNPrqHKgcdbEaA8RuSTarBF5HY+g2zsI+wUCBkzagmQgZ+r+
	4QSrWZgjwY3MQiNs06ozgHveJm5R1y9enGIajKhpgjaydhjfY3x5YX0ES/9HwhgRjcK0zzbEEDu
	TArlOutPvSzJShHV1ZvvjMxw0ZAqLbkKOH/MY2PHki8yQcVEo2CmadbEw345nVjm5max3FgsUuE
	y1dFZE1Yu6Yos+r8wQb3bqZI0tETlUZF74SJYB2KWZM1BcdYTVJdjvMFQ8xQ9iLrx+YXcGPk4zH
	F63wPJ6GRmvt6AyEeC0Zu0GZaMrjD37D
X-Received: by 2002:a05:600c:674a:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-4562e373e16mr24560575e9.20.1752672448174;
        Wed, 16 Jul 2025 06:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHbDh/0mz0p15FDovo+BRjkyUmjje/T03BW5/61Wm+8H+LQBbslJKqM78ICO4/OJJMN3SMhg==
X-Received: by 2002:a05:600c:674a:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-4562e373e16mr24560295e9.20.1752672447754;
        Wed, 16 Jul 2025 06:27:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm17724383f8f.24.2025.07.16.06.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:27:27 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during
 probe()
Message-ID: <20250716092717-mutt-send-email-mst@kernel.org>
References: <20250716115717.1472430-1-zuozhijie@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716115717.1472430-1-zuozhijie@bytedance.com>

On Wed, Jul 16, 2025 at 07:57:17PM +0800, Zigit Zo wrote:
> The deadlock appears in a stack trace like:
> 
>   virtnet_probe()
>     rtnl_lock()
>     virtio_config_changed_work()
>       netdev_notify_peers()
>         rtnl_lock()
> 
> It happens if the VMM sends a VIRTIO_NET_S_ANNOUNCE request while the
> virtio-net driver is still probing.
> 
> The config_work in probe() will get scheduled until virtnet_open() enables
> the config change notification via virtio_config_driver_enable().
> 
> Fixes: df28de7b0050 ("virtio-net: synchronize operstate with admin state on up/down")
> Signed-off-by: Zigit Zo <zuozhijie@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3 -> v2:
> * Simplify the changes.
> v1 -> v2:
> * Check vi->status in virtnet_open().
> * https://lore.kernel.org/netdev/20250702103722.576219-1-zuozhijie@bytedance.com/
> v1:
> * https://lore.kernel.org/netdev/20250630095109.214013-1-zuozhijie@bytedance.com/
> ---
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 5d674eb9a0f2..82b4a2a2b8c4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -7059,7 +7059,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		virtnet_config_changed_work(&vi->config_work);
> +		virtio_config_changed(vi->vdev);
>  	} else {
>  		vi->status = VIRTIO_NET_S_LINK_UP;
>  		virtnet_update_settings(vi);
> 
> base-commit: dae7f9cbd1909de2b0bccc30afef95c23f93e477
> -- 
> 2.49.0


