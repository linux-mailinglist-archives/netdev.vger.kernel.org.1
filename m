Return-Path: <netdev+bounces-307472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SWfyMHA3Vmp01gAAu9opvQ
	(envelope-from <netdev+bounces-307472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:19:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF25754FFA
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:19:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NwKx25gA;
	dkim=pass header.d=redhat.com header.s=google header.b="P81mEPO/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307472-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307472-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D9B630342EA
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927527B35F;
	Tue, 14 Jul 2026 13:17:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7625EF87
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:17:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035069; cv=none; b=gw4ZRgeR/YrvWoij0Zm30GRdBsFI8mKB07TQXKVUeZNwddt59yWwom4r9Xw0IxchIjRmL/6szlNHf7kdkwcm3PBvaENzk4wPExJCk34l1rBuoJbI37n90lfvEJJmgfKfoN+MI8DOkjUcU1xO6dREgESaCakvzquK1Ht0/4qzFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035069; c=relaxed/simple;
	bh=nlvh7CSMqUiIujUhp9BH2IdZPZMU6ylLQI28sV+2+ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua8xrZIxV+nuj1nsfNvWkv94AeZMs/3rhCGH0snQCebtHRqYm+rHnf9gW/GZ1WIuXcFCoD6SElqHfBgQFbJypFw878eYhchQSb4md7U+p3h+FkSTEzTrQaW6bnAPtP1TFWr75FfIIKuzmEWAZBgBuvfFtxj6d8WU2jrP/mlbh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwKx25gA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P81mEPO/; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784035067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+SO+5kDYlyBkSJf2vk/RjtSZDkaoll53kor2Z2ySV6U=;
	b=NwKx25gAFszJlKU6Ikii6dm+ddAttXedju+ASm2vrSyiwlXFv+MmirtC4smQcwF4qj+JNh
	3WpgJcBNCg2PLnHYuulEerry6BB4xOxF0431w5IIm9Nijy9ek5iuJ4guvm4KM0u6ZrNO6R
	5R1nieNaJpxm1UBeQttUV6QmAjy+JJw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-7-xQUqaKOhubAnk2m08_og-1; Tue, 14 Jul 2026 09:17:46 -0400
X-MC-Unique: 7-xQUqaKOhubAnk2m08_og-1
X-Mimecast-MFC-AGG-ID: 7-xQUqaKOhubAnk2m08_og_1784035065
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-472bdd6f529so2647412f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784035065; x=1784639865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+SO+5kDYlyBkSJf2vk/RjtSZDkaoll53kor2Z2ySV6U=;
        b=P81mEPO/PdCj3Sd0rO+XhVJf5s5mkbpbLdbpt62dcXQ7B86rdKWt5H8+lhvwGOEsJn
         iIToiYDjKroemV9xOaKGMq/QV+K6iUA4swSH0FJCY5aP6ItD3MjhMLsYP7Tz2usc4rbJ
         fA6gxkiKFW2+U2/553W9HEihCobFIgGjMItWKtEE+7FdmksQB7I9mw9PmdOnj7su9sQd
         15FMTb5d4BFQSj8NJQIXQxlLFj1u5Rptw2e7vZiSaUa/eKF6RwAaLwxdnyanP2x+8GNR
         j1StGqrMHOK5KFsqXMmWgDAcqFrqFNKHyVSvq1ycw2MgFHOM4t5QpouW0FS2oYSXf8Bu
         TEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035065; x=1784639865;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+SO+5kDYlyBkSJf2vk/RjtSZDkaoll53kor2Z2ySV6U=;
        b=iFWpNfsmXuOdHI9eiCYdH2M2WgbLH5/yZR98OY87QWPKKEAuqyeA2tDqI9NQ5s4z+y
         J432cMpXvp7e8aAf2wDiOra+JZFwz+QS5MQs+ojzig8o6bQp1t8tMJXr5dyvfWKG7kgz
         XnI1xukgGV0rhztpcJEAcdzwDeVV8vzD6/DEWrzQoNLa3ZTNdcKkOkdEvcZnYnVO0ldT
         M465z254kcSV6T6f6wWKG6Q/t99MjpI1bBTqtVUXlOiVXI4E5MeF6F0btc1nhXRGPgd1
         sCPwfxKzlfschoYhVEs7eXiGgR9B55aX/Pk61iA0VS/vitfwjLuY9IjYyPhzv0MTrMGq
         Ethw==
X-Forwarded-Encrypted: i=1; AHgh+RrFW19LIsNXdq/+eTN7adEEcIY82p/JRvQnKwtRFe+2ogwYeNeAE6t/u7qntH/FxhlQuYXXDk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzllUf6NlXeUBECq031sBMFxaDImqaCkEy3yBjZO8+B0kEZQ3Wr
	ObYK++aM6jByI+Ybq+q9+eAP+hFeULogbBN1lkiiisceOcjOqZXlzoDY6qN04vzEpCq7FtpFOfs
	llg1pvS5tc0tSZiHFucOwO4076vFED/euzgZrQwIUdfRuMchIzzpD9NU32A==
X-Gm-Gg: AfdE7clKXZM5Km67WvUvAaCLseKkE5wy/V9nWCNdaX/OOmwfM67rtIrWq6aaVb+TUNn
	RSADD4xNVI4tMSuALDJMd5qyNoGNsjQwqaZ3jJflDcvvQejfks4Mg51AuHLR+INucvQJfExTuen
	Ymn6HMJTb7RS0++tV6F8Z8Fipws6OoO7p+/uJp5HeqY6d+BNn+as/hFsrlZEdI9IXZZ/+y6t4yC
	jVyXT6RcjWkysFrcJhJp/bMN6DtNEQMvodHZt4TXRRemIEiEENItaKBZWW1BQ5mmWJyAluJqrlE
	iICsxgITfqyCYo/mVbwtPcf40cF78U2+hTdX4rMlUWBhp/Nk/frybXegAXvo5MkO+cxXEDsACOw
	MjaWcU9A2lSEX1eulVwrSGqF3/SG+q/rq8iQ=
X-Received: by 2002:a5d:5e07:0:b0:47e:81b1:74aa with SMTP id ffacd0b85a97d-47f488bdae4mr2796416f8f.42.1784035064503;
        Tue, 14 Jul 2026 06:17:44 -0700 (PDT)
X-Received: by 2002:a5d:5e07:0:b0:47e:81b1:74aa with SMTP id ffacd0b85a97d-47f488bdae4mr2796364f8f.42.1784035063914;
        Tue, 14 Jul 2026 06:17:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm8851487f8f.3.2026.07.14.06.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:17:43 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:17:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinqian Yang <yangjinqian1@huawei.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	liuyonglong@huawei.com, wangzhou1@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [PATCH] virtio_net: fix infinite loop in virtnet_poll_cleantx
 when device is broken
Message-ID: <20260714091622-mutt-send-email-mst@kernel.org>
References: <20260713132025.703147-1-yangjinqian1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713132025.703147-1-yangjinqian1@huawei.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:yangjinqian1@huawei.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:liuyonglong@huawei.com,m:wangzhou1@hisilicon.com,m:linuxarm@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BF25754FFA

On Mon, Jul 13, 2026 at 09:20:25PM +0800, Jinqian Yang wrote:
> virtnet_poll_cleantx() contains a do-while loop that cleans up
> transmitted TX buffers and calls virtqueue_enable_cb_delayed() to check
> whether more buffers need processing. When the virtio backend stops
> responding during guest reboot, used->idx is never updated, so
> virtqueue_enable_cb_delayed() always returns false and the loop never
> terminates. Then it will block reboot process, and the guest will hang.
> 
> The problem occurs during guest reboot under network traffic:
> 
>   1. kernel_restart() -> device_shutdown() traverses the device list
>   2. virtio_dev_shutdown() calls virtio_break_device() which sets
>      vq->broken = true
>   3. virtio_dev_shutdown() then calls virtio_synchronize_cbs() to wait
>      for in-flight callbacks to complete
>   4. A virtio interrupt fires, softirq is deferred to ksoftirqd which
>      calls net_rx_action() -> virtnet_poll() -> virtnet_poll_cleantx()
>   5. virtnet_poll_cleantx() enters the do-while loop and never exits
>      because the QEMU backend has stopped updating used->idx, despite
>      vq->broken having been set to true in step 2.
> 
> Since the loop runs inside ksoftirqd (a SCHED_OTHER kthread), it is
> visible to the scheduler and does not trigger a hard lockup. However,
> the kthread never leaves the loop, so RCU detects it as a CPU stall
> and reports it periodically. Meanwhile, the reboot process remains
> blocked in device_shutdown() because virtio_dev_shutdown() cannot
> complete its synchronization step, and the guest hangs permanently.
> 
> This can be reproduced on a guest with a virtio-net device: run iperf3
> traffic in the guest, then trigger reboot. The reboot occasionally hangs
> permanently with RCU stall on ksoftirqd.
> 
> Observed on ARM64 KVM guest:
> 
>   CPU#1 RCU stall (ksoftirqd/1), repeated periodically:
>     virtqueue_enable_cb_delayed_split <- virtnet_poll <- __napi_poll <-
>     net_rx_action <- handle_softirqs <- run_ksoftirqd <-
>     smpboot_thread_fn <- kthread
> 
> Fix by adding a virtqueue_is_broken() check to the loop condition, so
> that the loop exits immediately when the device is broken, allowing
> the device shutdown to proceed.
> 
> Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>

I'd expect lots of drivers have this issue?  Wouldn't it make more sense
to check virtqueue_is_broken in
virtqueue_enable_cb_delayed/virtqueue_enable_cb? This way it works for
all drivers.



> ---
>  drivers/net/virtio_net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7d2eeb9b1226..c8d2d420c31d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2970,7 +2970,8 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
>  		do {
>  			virtqueue_disable_cb(sq->vq);
>  			free_old_xmit(sq, txq, !!budget);
> -		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> +		} while (!virtqueue_is_broken(sq->vq) &&
> +			 unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
>  			virtnet_tx_wake_queue(vi, sq);
> -- 
> 2.33.0


