Return-Path: <netdev+bounces-267078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF6kMwzHsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:00:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA22273050
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEA70304953F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8F5351C17;
	Thu, 12 Mar 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dx/VhrYD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mot1zpvR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D831717E
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323701; cv=none; b=JWlZwJK7mzvExqEQNexLDkGGukDRC7O2BIgjNYNCp1D9bg4e3A4OtfnIOhlqHS3evG2afl0dECglx5sHDmBoTEChHbbT2VBcJP6dOYspN8s1o1Zb8kjC4MCzUapeTMt1guKIFWQSTkCWz35LZgLxFyq+J3Lj0R8LK0qgSoCF0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323701; c=relaxed/simple;
	bh=SpNehQ1QB2agnleumLY4gSLmRt7ah7+esaG/GMysUtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdYNAlNq03Xn/lNMWit7H9quoRTn29SddTXrXWff3smQva2zR+zQEXPFEkQPZWSPajeS9as7iZGywq2FTag7UbwdpthcgPAsN7dEFh9Wwe1jNgwc49UXSAAZnGSF6Jok2F9oWTc/MXNCr6egRRx4WQNHL4txG3ugbGatFDB9HOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dx/VhrYD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mot1zpvR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773323698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iz0EqyWTioqt5QKyYbfa8QuFQclbTzyA/mBVntajMyE=;
	b=Dx/VhrYDdaKFnj3ex906otzBg3BV/+QyTLpiM89lmZ+Pgat+j0eWmGlV124uAunhV/I3+Y
	vJCApbzMJGPz+Zo98IbRgOGKSbJnJSVx9rYHK0IvSzb0ITn9DAv+BC/CxqMj3ULpPC1rEB
	fLSMaaktQTVwjzwPMV7wGypWR9SmclM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-pK9lRdbZNXidy9anWA3MOA-1; Thu, 12 Mar 2026 09:54:55 -0400
X-MC-Unique: pK9lRdbZNXidy9anWA3MOA-1
X-Mimecast-MFC-AGG-ID: pK9lRdbZNXidy9anWA3MOA_1773323694
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-439bcec86dfso1098709f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773323694; x=1773928494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz0EqyWTioqt5QKyYbfa8QuFQclbTzyA/mBVntajMyE=;
        b=Mot1zpvRI5BvN0arffYqIahGxGrUbQJeKSmXTyKapgRCy74Z0x/3sf+L0g8Oa1XwC8
         vbHHkWBiOjh3IhTmXePAFjPnGrMvPMBtYMwBFQutyMaTOL8ll+UEycV4PL98Y1x0mZko
         uxv7YWfQVGcMqXipitd8nHYIQxCNQoM2c/yNCXh6VOFehaIChx6RDF1P1AmSCbwYsBK7
         40WjBCGQoCu/CRKg75prf5Q0Ysczpr5bAXr9Tv9WUSis881nw0OB3ithV/sQee2DoClC
         hIUTpkkx6gGMEUqRoyeOFVsMAflRQKEo/LxLj8YjE5uHKkxghnQh8RUomaTiADXGTf70
         BbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773323694; x=1773928494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iz0EqyWTioqt5QKyYbfa8QuFQclbTzyA/mBVntajMyE=;
        b=RtPUhQOQOnK8km3sF9RVje/fLQak3G0SYnOX0oDjt5eoTt1n76GA2o065fcna3IJFp
         /C+ysJSekPlhyjlahVWMJS7hsh1Rogp7Kyw5VVsO4MqmhNSy1aXijrV+tGKK4fhUyHjj
         K1CSZVnThyxUYF0OOyVd/km0QDdAtRBbQQPOV6CpPHyqDgWU3K4ktYVCmBB8i1R//uyd
         aMasJ6sIocosdenQGWA8UZCB3DVgDXjwNxPipjgHarw/OyFFN9dkeGya7TfTffXUWdpO
         8rWj4tv7lW9mcFubVfMLZ0RWUzFn5DFqDhXlmb1v7oTctOiSDXge9pHyrjxdZYTE/Aoj
         D/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnTQL864X1fwMkFgsDjU+srGdKrEm+GmoIwuAxFx4cNhZB1vQTfo+psZ3hkfq6ZJVVtwtm1YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPMCKkIybN+xmj3bteOAz3xh6ioB9JtY56hl1eJyCuFuAoSp5
	11OvP4SO/3WKZBzTpUI6v14UbUcnR1jaGo7C3oZ3kD0ROdDFPDvdb6Co7o6KHBdiG7G2jRMxShs
	JnhPDtJMILrCQVo6JLoKhouBbKG3mBe7VsSy1d8P1iwnNSfK5etv2PDJYMg==
X-Gm-Gg: ATEYQzzqs7H+brf1VBLdwhoGfTQCle6l36IwTcmnHDFibHfVx+QDc/xwwmCHo5Sdeip
	FpsUEAHfdr/gHGvwcq/rNp7mLMAttjCzuLKT4WACc+7iQCJ5+OQrD70o/CJWQtwtz9qDmEEYZcw
	MVX86Ju5v3TZxrTgZUKpsTDDlfgfZlJVNklrTRcfEx824HGCaCWbvYuX03so93aeMeN3XRPQH/Q
	j5ZjevtEVvJ/pwrqMzlUV6G7Mxqd6x88j4JBsaxssblE7IhbziU+Ch9XnJZZBWe9D2xuAxWEXiP
	Gkr3R35mw8l+V7UfNxd6Dxppzp6w8oiQavAajjzsVkJshOnMj9ZkRMd7+EHO5z7nU1ytuQ44z5B
	s3rtjdIj+Crj6HmwNKCOiFkt3E2NQRlXAq/Ce/wBJxn5KXQ==
X-Received: by 2002:a05:6000:2f86:b0:439:abfb:6d34 with SMTP id ffacd0b85a97d-439f84359d8mr11303260f8f.50.1773323694286;
        Thu, 12 Mar 2026 06:54:54 -0700 (PDT)
X-Received: by 2002:a05:6000:2f86:b0:439:abfb:6d34 with SMTP id ffacd0b85a97d-439f84359d8mr11303176f8f.50.1773323693676;
        Thu, 12 Mar 2026 06:54:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm7866593f8f.31.2026.03.12.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:54:53 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:54:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 2/4] vhost-net: wake queue of tun/tap after
 ptr_ring consume
Message-ID: <20260312095227-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267078-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 4CA22273050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 02:06:37PM +0100, Simon Schippers wrote:
> Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
> function validates that the file belongs to a tun/tap device,
> dereferences the tun_struct under RCU, and delegates to
> __tun_wake_queue().
> 
> vhost_net_buf_produce() now calls tun_wake_queue() after a successful
> batched consume of the ring to allow the netdev subqueue to be woken up.

A sentence missing here:
the point is to allow queue to be stopped when it gets full,
which is required for traffic shaping - implemented
by the following
"avoid ptr_ring tail-drop when a qdisc is present"




> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes a slight throughput regression for a
> tap+vhost-net setup sending to a qemu VM:
> 3.948 Mpps to 3.888 Mpps (-1.5%).
> 
> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
> threads, XDP drop program active in VM, pktgen sender; Avg over
> 20 runs @ 100,000,000 packets. SRSO and spectre v2 mitigations disabled.
>


 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c      | 21 +++++++++++++++++++++
>  drivers/vhost/net.c    | 15 +++++++++++----
>  include/linux/if_tun.h |  3 +++
>  3 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a82d665dab5f..b86582cc6cb6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3760,6 +3760,27 @@ struct ptr_ring *tun_get_tx_ring(struct file *file)
>  }
>  EXPORT_SYMBOL_GPL(tun_get_tx_ring);
>  
> +void tun_wake_queue(struct file *file)
> +{
> +	struct tun_file *tfile;
> +	struct tun_struct *tun;
> +
> +	if (file->f_op != &tun_fops)
> +		return;
> +	tfile = file->private_data;
> +	if (!tfile)
> +		return;
> +
> +	rcu_read_lock();
> +
> +	tun = rcu_dereference(tfile->tun);
> +	if (tun)
> +		__tun_wake_queue(tun, tfile);
> +
> +	rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tun_wake_queue);
> +
>  module_init(tun_init);
>  module_exit(tun_cleanup);
>  MODULE_DESCRIPTION(DRV_DESCRIPTION);
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c8ef804ef28c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -176,13 +176,19 @@ static void *vhost_net_buf_consume(struct vhost_net_buf *rxq)
>  	return ret;
>  }
>  
> -static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_produce(struct sock *sk,
> +				 struct vhost_net_virtqueue *nvq)
>  {
> +	struct file *file = sk->sk_socket->file;
>  	struct vhost_net_buf *rxq = &nvq->rxq;
>  
>  	rxq->head = 0;
>  	rxq->tail = ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
>  					      VHOST_NET_BATCH);
> +
> +	if (rxq->tail)
> +		tun_wake_queue(file);
> +
>  	return rxq->tail;
>  }
>  
> @@ -209,14 +215,15 @@ static int vhost_net_buf_peek_len(void *ptr)
>  	return __skb_array_len_with_tag(ptr);
>  }
>  
> -static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_peek(struct sock *sk,
> +			      struct vhost_net_virtqueue *nvq)
>  {
>  	struct vhost_net_buf *rxq = &nvq->rxq;
>  
>  	if (!vhost_net_buf_is_empty(rxq))
>  		goto out;
>  
> -	if (!vhost_net_buf_produce(nvq))
> +	if (!vhost_net_buf_produce(sk, nvq))
>  		return 0;
>  
>  out:
> @@ -995,7 +1002,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
>  	unsigned long flags;
>  
>  	if (rvq->rx_ring)
> -		return vhost_net_buf_peek(rvq);
> +		return vhost_net_buf_peek(sk, rvq);
>  
>  	spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
>  	head = skb_peek(&sk->sk_receive_queue);
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 80166eb62f41..ab3b4ebca059 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -22,6 +22,7 @@ struct tun_msg_ctl {
>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> +void tun_wake_queue(struct file *file);
>  
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> @@ -55,6 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct file *f)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +static inline void tun_wake_queue(struct file *f) {}
> +
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
>  	return false;
> -- 
> 2.43.0


