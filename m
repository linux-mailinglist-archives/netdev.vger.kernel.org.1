Return-Path: <netdev+bounces-270621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIt9CzV5wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:32:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BF2F9FFF
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E30318D487
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82943C456F;
	Mon, 23 Mar 2026 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5V47eeG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="meE7k/jb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2FD3C4575
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285117; cv=none; b=clDwVMzpDCfp0TBMDLgFBYjKU9ZCaGrPGJ4blIYDBZyIfUbqP3ZGCCsD3YixUm8aYY97S9IFy1kLIgKmfCJlpWQPKzRe5pvOmAMnqptigqPCGR5zT+dpdnWcJe9BA3zUTwe99JIb2h4zkFa/0PFjLSAkko4SIqVXoDQIQIMC/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285117; c=relaxed/simple;
	bh=zKfpEDx/bMNnliTMcyZ3QPurRtzaRjVy8bY/EVr1Gq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAsJrvyAVDKu9gl/a1WUkO4q3W65o/q4lHwfdT2eCaroUsolIlfIgiKihTkkStkPhFE2q50Urwo6L3ghLePxrt2jkXQ/6xZWXM8kKGGjL8gq55pQJE+pMXiwY2q8jypAMkuLc9GCK3T/u6GFcb5WyRV5xvuQjJPvx9ppaws6I+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5V47eeG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=meE7k/jb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774285114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+LDGMV4LQONK/JaWRKk1AqF2/olqUh4X35pgtSYkU4=;
	b=J5V47eeGLIYkQ2QsSx3IC2rcNg8s+8G5uZQ5DHvH3JdGd2Q+b1cPJr0jKzu3iHIYoExl75
	JMY574wqDQ9oraqElpsQcWZLMJGPtqzMQ7sI1dHjgDiMWGy9VA+9k5aPsA5XjbpkRdeS1F
	tGXS5C/b5wi1KBm+aNk8KrVauChY83s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-feNzzdPuOpGH5uyZfwibKQ-1; Mon, 23 Mar 2026 12:58:31 -0400
X-MC-Unique: feNzzdPuOpGH5uyZfwibKQ-1
X-Mimecast-MFC-AGG-ID: feNzzdPuOpGH5uyZfwibKQ_1774285110
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439ae2cba40so346392f8f.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774285110; x=1774889910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F+LDGMV4LQONK/JaWRKk1AqF2/olqUh4X35pgtSYkU4=;
        b=meE7k/jbApamyPWdfy2gGhsum8KEdbVxNJ8KdFJ8ulr/oDTo6fxbSn3turKhvenbGJ
         XwXW/DriPGF67RHhouqCQouC2Eaf53aOJ7gJxWOXIwyizwK9kkudd/K7+YEBTa8bdLfK
         HHGT9s9oilN8wGoHihT5q0kVThCvTpGjERpzq9iQ/R0dAwr4KeXBQr9fbciziLqBXS5t
         ANNjKd0YvDYtiQCAlMnls9CPNdDxlYVg9jCxeph18sG8yEKPGDtpEGMUdTjM30o2sNWR
         ++srhP7hRC8gUZuAjdkXV5CFumhO95yTWEIcZBIt1gIPmEP9HA3n8d9u/KTe0ilk9R4j
         HalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285110; x=1774889910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+LDGMV4LQONK/JaWRKk1AqF2/olqUh4X35pgtSYkU4=;
        b=HCvZvaxFKoCRshviO3xLJ8Og1xOEacRI4x2gHE10pNVVZCusqT88PrKqY8+GrJ6+1G
         lBuv8ScSnijoUgzSuawAXinSY5Bw9WtcwWMPxrEuYaafLJSDQ5XVahFMIvgpnT9RabRE
         eSGjvkiLvJcykMe1+jaVyCPUZZG2ZrFJ/9HZ3W8vZhajSg4Cg6dSVk0X7WmuKYhqQbrt
         /d+goSJ7iFgeRv/BgnKRs8h9+U5yP36MRUvnnfWYa5ZAFW5v2U0igs/SemnfMh4pqZyO
         /i4brVNRGDpTsZ8nygYAZeb1FKBIwNF9CKf83ohS/7cpF+5sSqi1G9L4nK31YLLhlGuz
         iKtA==
X-Forwarded-Encrypted: i=1; AJvYcCU/AcL/FdVMSJriF3r3x4C7UCP+hOpVJy7GJ0yhV1/eZl9oV0I1DuLOvCc6jlDyt9yF5c9eOWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywub0EWAadZh06vQ2jQVtXQfso4AL5sBjDH89d3wtMw0S/D0M5/
	KlFjQzpRNVHp+9ln6pv7S9hsEMceIY5giNwu58ThPvckLssiJkeZU7DPH4AloahhBU6tgBUDtNS
	Aiz/QMyahgWogS9sPD8a1tF2WlG4QTA9LBcMdt7vWgB3p7mGoKtQPNzgWOg==
X-Gm-Gg: ATEYQzw6haeOONE0Ll2N7eAg9bq+pqyZjwIJtjHwgk+M0QAkvNKteoodr0Jz4qULuon
	RbxlA0wQMGkV5Ct4m5kC9MdahSPKwEz2RF6kygicjY8HEhX1YiMbKy64vbYEmN/XK2IERmqkUIV
	JyAPn975nWzwQyFu10VquaFRBX5qgTnJDN77CqVKsR3VU6D50p4LFbqRu2kqsZ94jTaNSw5kz9j
	Fcy7ivZxHqJ4cMV6CDaR+H2nYXW90vlbCK8g0YOiGLJQWP75vcUm8ka5HfW7VXf+oR8gUw6ywXj
	8xARa/4WhO4i5ZIqzim8gRBtSXlmVz7M6Zj4pEce5/UyGX+OcRLp15V8WaueWCYrgtudZDUU7oq
	kCbVbQzx/6Eplto05
X-Received: by 2002:a5d:5f94:0:b0:43b:5744:13fb with SMTP id ffacd0b85a97d-43b6423489dmr20503949f8f.4.1774285109991;
        Mon, 23 Mar 2026 09:58:29 -0700 (PDT)
X-Received: by 2002:a5d:5f94:0:b0:43b:5744:13fb with SMTP id ffacd0b85a97d-43b6423489dmr20503890f8f.4.1774285109379;
        Mon, 23 Mar 2026 09:58:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bf1c5sm33789641f8f.14.2026.03.23.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:28 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:58:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: vishs@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	dw@davidwei.uk, edumazet@google.com, eperezma@redhat.com,
	ilias.apalodimas@linaro.org, jasowang@redhat.com,
	kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, technoboy85@gmail.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260323122728-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323114313-mutt-send-email-mst@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270621-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[meta.com,lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 971BF2F9FFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
> On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > Hi,
> > 
> > I've been testing linux-next (tags later than 03/17) and hit new issues in
> > virtio-net on s390x. I bisected the issue, and I found this patch to be the
> > first buggy commit.
> > 
> > The issue seems to only be reproducible when running in Secure Execution.
> > Tested in a KVM guest, the virtio-net performance appears greatly reduced,
> > and the dmesg output shows many instances of the following error messages.
> > 
> > Partial relevant logs
> > =====================
> > [   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 tnl csum 0
> > [   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunnel 0 tnl csum 0
> > [  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum 0
> > [  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> > [  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum 0
> > [  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum 0
> > [  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
> > 
> > Steps to reproduce
> > ==================
> > 1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with SE
> >    enabled and a virtio-net-ccw device attached.
> > 2. Run dmesg. The error message is usually already present at boot time,
> >    but if not, it can be reproduced by creating any network traffic.
> > 
> > (*) This patch was not tested in a non-KVM hypervisor environment.
> > 
> > I've further confirmed that reverting this patch onto its parent commit
> > resolves the issue. Please let me know if you'd like me to test a fix or if
> > you would need more information.
> > 
> > Thanks in advance.
> > 
> > Best,
> > Omar
> 
> Well... I am not sure how I missed it. Obvious in hindsight:
> 
> static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>                         void *buf, unsigned int len, void **ctx,
>                         unsigned int *xdp_xmit,
>                         struct virtnet_rq_stats *stats)
> {
>         struct net_device *dev = vi->dev;
>         struct sk_buff *skb;
>         u8 flags;
>                 
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
>                 DEV_STATS_INC(dev, rx_length_errors);
>                 virtnet_rq_free_buf(vi, rq, buf);
>                 return;
>         }
>         
>         /* About the flags below:
>          * 1. Save the flags early, as the XDP program might overwrite them.
>          * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
>          * stay valid after XDP processing.
>          * 2. XDP doesn't work with partially checksummed packets (refer to
>          * virtnet_xdp_set()), so packets marked as
>          * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
>          */
>                 
>         if (vi->mergeable_rx_bufs) {
>                 flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>                 skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
>                                         stats);
>         } else if (vi->big_packets) {
>                 void *p = page_address((struct page *)buf);
>                 
>                 flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
>                 skb = receive_big(dev, vi, rq, buf, len, stats);
>         } else {
>                 flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
>                 skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
>         }       
> 
> 
> So we are reading the header, before dma sync, which is within
> receive_mergeable and friends:
> 
> static struct sk_buff *receive_mergeable(struct net_device *dev,
>                                          struct virtnet_info *vi,
>                                          struct receive_queue *rq,
>                                          void *buf,
>                                          void *ctx,
>                                          unsigned int len,
>                                          unsigned int *xdp_xmit,
>                                          struct virtnet_rq_stats *stats)
> {               
>         struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
>         int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
>         struct page *page = virt_to_head_page(buf);
>         int offset = buf - page_address(page);
>         struct sk_buff *head_skb, *curr_skb;     
>         unsigned int truesize = mergeable_ctx_to_truesize(ctx);
>         unsigned int headroom = mergeable_ctx_to_headroom(ctx);
>                 
>         head_skb = NULL;
>                 
>         if (rq->use_page_pool_dma)
>                 page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
>                 
> 
> 
> Just as a test, the below should fix it (compiled only), but the real
> fix is more complex since we need to be careful to avoid expensive syncing
> twice.
> 
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 97035b49bae7..57b4f5954bed 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>  
>  static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  {
> +	void *buf;
> +
>  	BUG_ON(!rq->page_pool);
>  
> -	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> +	if (buf && rq->use_page_pool_dma && *len) {
> +		struct page *page = virt_to_head_page(buf);
> +		int offset = buf - page_address(page);
> +
> +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
> +	}
> +
> +	return buf;
>  }
>  
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> 
> 
> 
> 
> -- 
> MST

or maybe like this:

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 97035b49bae7..835f52651006 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	 */
 	buf -= VIRTNET_RX_PAD + xdp_headroom;
 
-	if (rq->use_page_pool_dma) {
-		int offset = buf - page_address(page) +
-			     VIRTNET_RX_PAD + xdp_headroom;
-
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-	}
-
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2398,9 +2391,6 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	head_skb = NULL;
 
-	if (rq->use_page_pool_dma)
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
-
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
 	if (check_mergeable_len(dev, ctx, len))
@@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 		return;
 	}
 
+	if (rq->use_page_pool_dma) {
+		struct page *page = virt_to_head_page(buf);
+		int offset = buf - page_address(page);
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+	}
+
 	/* About the flags below:
 	 * 1. Save the flags early, as the XDP program might overwrite them.
 	 * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID


