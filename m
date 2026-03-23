Return-Path: <netdev+bounces-270623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFw4FNB6wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76342FA20D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 589673103279
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF9265606;
	Mon, 23 Mar 2026 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL21juQz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oht7LGD/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2CA24E4D4
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285846; cv=none; b=DBnLyQMjviqnXeZZKsL+HxHcv16mNZzCgcLH9JcCFFMo/RyDmrZoLUibYiFg0J/jS6PIjaxAlwBsNn7QjlI+e3mDzRYity22IEkAQXhg+9567v6xio7wwT71khjf48j4/xrT3XJitsdtjQv8mXlH92Xuq0pvxB8JUmMiA64ENzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285846; c=relaxed/simple;
	bh=AXu4moyYLT6oyjJm/jW8zlTRLJclBIHpMOpF1YV/RDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQZQKGrnW9kL1vh+ns127UXWZtYj8B7i557IeSw7uhNbbXQvUIlxEjWqDAPXYHTF3qtPRgmp32TVcHIM8L9BsAsb8oT4Zc48WhuHXteOPn//BEjbME2r4EachLWqJM79AroqB7YRIl9u1kBOpurcW/Tzsivp9uhRykvxlmfMwjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VL21juQz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oht7LGD/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774285844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgSRRWjYpcT9SP6nnEifjHM4Oz7EppnrFyKqEruLcwQ=;
	b=VL21juQzJchFvWLpZ2xlBVL7+smde+yYCSLOCg3/WBKfGPazSlFJ19tqIpxLsQ4PsyKnbm
	HDNr6zx5vPXYMqKPYkCKP/c5BK2TETjySy+shPSSYpVt8wqIIElB6ei0OX5dvcID+Y2OR7
	rsuCN6QbO67cCYGx6vxhBszKNAmB2p4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-LcUzDqijPI-rOz4BmFELEA-1; Mon, 23 Mar 2026 13:10:43 -0400
X-MC-Unique: LcUzDqijPI-rOz4BmFELEA-1
X-Mimecast-MFC-AGG-ID: LcUzDqijPI-rOz4BmFELEA_1774285842
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439a85832c0so498474f8f.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774285842; x=1774890642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgSRRWjYpcT9SP6nnEifjHM4Oz7EppnrFyKqEruLcwQ=;
        b=oht7LGD/9YfNVixMDlynwqGnkVetXVZRSvAczJ91jYNValrLJPWrnDFH2WTa4NvWfr
         525svrM5cIhqlkTpOiurFVDDMh9OBopKRQ6Hu2j+Mg+z7CtBuIAGzClmEEPNibfZGsb1
         lG24MAuOxU3jLiM5CvFdaUp4XqEFfNNKlo6u/e4knBI2I+cAQamOOdaVNdYBbmnuPe12
         x4rMpo6t0jkZeBDE0g6evtvI8jRMXc1OzNuc8rlWz2OtPVu8CDNdjxdG7ctfW5jtmyb9
         qmBhEUPNCPojosy0W7oUJr+CU5ok+OMPo1JlXR2l82xpvZ12jrH7dLcskg6cy1kopLQT
         witg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285842; x=1774890642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgSRRWjYpcT9SP6nnEifjHM4Oz7EppnrFyKqEruLcwQ=;
        b=MWisiBEpH0rrvx26L/mAAW2q672pinQqN4ST2yCcqREtLncBhJPVU0n5l1J94YvfBj
         N5lDCSEWrGfx2kizyadidCYRj1tvAQzvqbuYKH7vQViTmpsrPgFZpNp0nGDFKTwp+Rtm
         YgATVORrtPf9QhYU3zhzkOXORdCdf7IUFtknzZDbRMtIUnAYjjvqcGiUIPaQnM1QS3Oa
         XosAFzf4MrUmFqHaXacfFf/HdrFycYVD9ACTzbWc+Zu7SgAqI0BdSUKCP9czO+5hgThM
         behWkJmvzyl41h6bmyTNYB1lU37yzBUn5UjliSZcxFInHp02kJk4E6pQZSVRjJu8rW/p
         J6SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDl8WRJL7Y8NC/TaSWFg4wJbbiN2Kd4vvLkWKXE0B/1IOXMwYm2PiKsCVXKEcaGR8sR3YBhg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ij4spOqP35ediBWiuo9dtURhpnQoLKEIYKQRYHoAbsEIoP8w
	mIUqWpLUzrOWvoLz5xh44EVIuaZG7vzjeU1z7795/gENdb0DxDK4RUr+2iU2DmIRuqXyj5GEvwR
	ZfGgcpiMK/Akt9MwPoHsI9gbmfxXvVgNixa5LAyq3Z1lKZweHpj5623+ZgQ==
X-Gm-Gg: ATEYQzxqJzzhlB8xSKVYsS7kbw9YnyI/mYePykNc/4IQtHZkjcupRHiHVXfx308WOzK
	XnmkWzEl+Et+du4yMTDg68k8d7eU94baQYlwjytJdprtGei7k2gxV+kFnoNybzn+ynG/Zadobr+
	1evKjKPesPQGTRh5oJAUvVcLoxcbHc5myq0Bq7W0UEN0rdFQi+okQJaL2tHY9KySsxdzM4DMjMU
	NJuAmgRHBemNlCLMFvmN0u+3CoaRMFyOiUHQScQEOAlDGuJK0TcYrw6XarIXnIZfqH+xiGhDmFy
	3azcQ11ytg5PSubHgLiwb8jO95tzL81gKOP4PZBevUfqJtpZ+BTDp6NeMerQQ2i0l9mVel0xrgs
	hkyVUR0NAv8QUpojl
X-Received: by 2002:a05:6000:4203:b0:43b:60f7:2284 with SMTP id ffacd0b85a97d-43b6424e660mr20920979f8f.14.1774285841805;
        Mon, 23 Mar 2026 10:10:41 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:43b:60f7:2284 with SMTP id ffacd0b85a97d-43b6424e660mr20920915f8f.14.1774285841294;
        Mon, 23 Mar 2026 10:10:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm29266639f8f.16.2026.03.23.10.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:10:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:10:37 -0400
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
Message-ID: <20260323131033-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
 <8e0a5562-4511-41df-9993-a77e51025e95@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e0a5562-4511-41df-9993-a77e51025e95@linux.ibm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270623-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B76342FA20D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:54:03PM -0400, Omar Elghoul wrote:
> On 3/23/26 11:52 AM, Michael S. Tsirkin wrote:
> > On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > > [...]
> > Well... I am not sure how I missed it. Obvious in hindsight:
> > 
> > static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >                          void *buf, unsigned int len, void **ctx,
> >                          unsigned int *xdp_xmit,
> >                          struct virtnet_rq_stats *stats)
> > {
> >          struct net_device *dev = vi->dev;
> >          struct sk_buff *skb;
> >          u8 flags;
> >          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >                  pr_debug("%s: short packet %i\n", dev->name, len);
> >                  DEV_STATS_INC(dev, rx_length_errors);
> >                  virtnet_rq_free_buf(vi, rq, buf);
> >                  return;
> >          }
> >          /* About the flags below:
> >           * 1. Save the flags early, as the XDP program might overwrite them.
> >           * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
> >           * stay valid after XDP processing.
> >           * 2. XDP doesn't work with partially checksummed packets (refer to
> >           * virtnet_xdp_set()), so packets marked as
> >           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
> >           */
> >          if (vi->mergeable_rx_bufs) {
> >                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >                  skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> >                                          stats);
> >          } else if (vi->big_packets) {
> >                  void *p = page_address((struct page *)buf);
> >                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> >                  skb = receive_big(dev, vi, rq, buf, len, stats);
> >          } else {
> >                  flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> >                  skb = receive_small(dev, vi, rq, buf, ctx, len, xdp_xmit, stats);
> >          }
> > 
> > 
> > So we are reading the header, before dma sync, which is within
> > receive_mergeable and friends:
> Thank you for your analysis and explanation.
> > 
> > static struct sk_buff *receive_mergeable(struct net_device *dev,
> >                                           struct virtnet_info *vi,
> >                                           struct receive_queue *rq,
> >                                           void *buf,
> >                                           void *ctx,
> >                                           unsigned int len,
> >                                           unsigned int *xdp_xmit,
> >                                           struct virtnet_rq_stats *stats)
> > {
> >          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> >          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> >          struct page *page = virt_to_head_page(buf);
> >          int offset = buf - page_address(page);
> >          struct sk_buff *head_skb, *curr_skb;
> >          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
> >          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> >          head_skb = NULL;
> >          if (rq->use_page_pool_dma)
> >                  page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > 
> > 
> > Just as a test, the below should fix it (compiled only), but the real
> > fix is more complex since we need to be careful to avoid expensive syncing
> > twice.
> 
> I applied your patch and tested it on my system. With this change, I could
> not reproduce the same error anymore. I would be happy to test a proper fix
> once you have one.
> 
> > 
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 97035b49bae7..57b4f5954bed 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> >   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
> >   {
> > +	void *buf;
> > +
> >   	BUG_ON(!rq->page_pool);
> > -	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > +	if (buf && rq->use_page_pool_dma && *len) {
> > +		struct page *page = virt_to_head_page(buf);
> > +		int offset = buf - page_address(page);
> > +
> > +		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
> > +	}
> > +
> > +	return buf;
> >   }
> >   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > 
> > 
> > 
> > 

just sent


