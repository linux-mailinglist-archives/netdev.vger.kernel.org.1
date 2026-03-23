Return-Path: <netdev+bounces-270812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULwgKODOwWnhWwQAu9opvQ
	(envelope-from <netdev+bounces-270812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:38:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 469102FF073
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 150AB301ABAD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F3E377EDE;
	Mon, 23 Mar 2026 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOitvyAl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rfcr9ouF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE99372B53
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309086; cv=none; b=Q8m20p5d9F336AsCQlStmT7ztBtT0cdqyjHeL5MvfMeCs9ly80uyMSY7W61B1j1le3q3v7v6dOutzOxSjEhEdICtbVY5bqQ7tWJtrunZiSwB3MVPjPAbRiyEDsMqQ2kDsUtPDjgIDUgPVM/breDjpnix5DCfZF9dRbpbeGrPbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309086; c=relaxed/simple;
	bh=owEdr220dkK3ppsi6JXpVg05w8GpReJWUif3G0RS6T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbxxOb0eDTswQnwYSEK2ZpvB+citwZaSlh6ibQ9B6gkqhcPLbVfVmm/UHtC8YoBrOIiJVus4KosTcF9km86gU+C6cMUKRq93mcxj3n9xB4SPO9Aye9rlJ5WdEbcS6cs7qSGEuUfkfkD1V3ItOznLs6vU+nZfJ0XJy/uXOtXD73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOitvyAl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rfcr9ouF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774309083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fo0gWB5wj1kID668MfwKwidT0apXwX5ZGElz9QaiNPw=;
	b=ZOitvyAlvtdbJn5xxKcPsqvPZ3FD6OUisyvnthdTSlBueNN6AiSsCQX2/2nzYboh0e2LU5
	dkhzCKy29A71U7X8uWxeezgnlDjTjKn3uiSxOeX+LxTm25J2zAKp/cp/EWnI+7sG2001KY
	XAdRiypvLyoquvtTmQnsrikUpdwBiDw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-CBeenrsqMfawWR5m5xxYRA-1; Mon, 23 Mar 2026 19:38:01 -0400
X-MC-Unique: CBeenrsqMfawWR5m5xxYRA-1
X-Mimecast-MFC-AGG-ID: CBeenrsqMfawWR5m5xxYRA_1774309081
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48534941525so40645875e9.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774309080; x=1774913880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fo0gWB5wj1kID668MfwKwidT0apXwX5ZGElz9QaiNPw=;
        b=rfcr9ouFraEZ7kMfsGvFV70sALa5dfXlWNquYqPuDTV8sCz4molapKISmjUZttVUDZ
         MktKkeN7bGpv1BevKMlQwS3I9iR2tWfoEhrqxqWTXidzAlSb+yLP/epZ322Or72j0CsI
         bIbhZl/eAFyOkmj/C18E1C9QAp00XsYT7k0AEYB1mT6a0SWv8jaG8SdyF+M5rhfBKzzM
         /A0cxgQa34Rt818QScMCspOo2X6TTJtTOLirVf+d7nL1h6ab0Y2GkDixdO7KrGl6w5LF
         C4MVpolY5H9K/NUSBPLAaDQ8qTOS056fAlWoE3lldfJYI+znJERdIJgjx6W6xex2LdA4
         3v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309080; x=1774913880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo0gWB5wj1kID668MfwKwidT0apXwX5ZGElz9QaiNPw=;
        b=iL5MBPjO/vi3LxbtqzKRNZAlCqR3N/s/DRyRLmWiGq5PjPQVX0wEJV3TBRxHAzBzLM
         AWuBKHWWfdu/USeMuhrql1YFPiR5vjZcJ2iDDdayyz5F6ohVQ+YOU2FqsZYjJgdnAFBg
         X/xxYjKYo0jC9UcNEz0A92kibt89+kn+pXogmHu6Bvu+rtDdx5QRcb4qtSXIuWDqW4Pu
         PwkK+qCRiGz3BsFz1UEpwtFCnycTyB5T/CWyTh6tomB3XbhFH3tcNh4nEo9sHbCPFk7S
         ZHUARUjEuGFjskmH9tUoRRRfkejsegzWGOYwFwEwHQ4AguwoPipaXEujiXppZ0q8HR+O
         QZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGr6M/Zr3m4AaQzdFA4vXIlnEEt7kolOyKrGVLPtKKDDwEfzp2ICnDJVBT2aArt2dPYwp6ocY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6dMKbBsX5y128FhlmywwrEF00jVtA0wYHAryrZ7iY8QDE6do
	cal+mtTorMCSbL7K+oVdzJ1BrEBtFsa0DOW/dMwCsOTdvWcY3mNoantsM+QAt9Xc+h+PrDyN9rH
	NGTtZkpMIvhot/pVEoaBAZhlrwUgYuI+9uEO/kYZbScSpBcRdc+JM2qXNFA==
X-Gm-Gg: ATEYQzzSt+4YHEqW0X27LXaz3b8QZRBre5ycruuquOjqCZnxLHg9LzWW6R91bDhCI30
	5ynwEgXj+x9qvuxHZzd1feBimjn1jNDvmC3nhCMLNwMmaWlUfAhpqlaq6EGYEk4K6feqS4efkty
	ROp6FPytrsGTH/XqorliAlwwUv0n5ekN3dNx0OObn0Rg+LYnhz7B7m4tm0MX+SB7jO8lv5ggkSy
	w6QQzLRdUfAob8/UllbCVvBHsxU+Ak5tnuy4qO3NYQZo9ses4PvwBA7qS6GyHgNfDMspdkXxpng
	F21VMup63KyAy9xPddEZEr5x6kfOS/tTyZJ8QQUpGITwn2YX7FV4Prg8drOJHatOg6chFbODPVp
	AM/nBcL2ayDco0ctX
X-Received: by 2002:a05:600c:3483:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-486ff02923emr204364805e9.21.1774309080435;
        Mon, 23 Mar 2026 16:38:00 -0700 (PDT)
X-Received: by 2002:a05:600c:3483:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-486ff02923emr204364575e9.21.1774309079916;
        Mon, 23 Mar 2026 16:37:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f822b83sm8160385e9.4.2026.03.23.16.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 16:37:59 -0700 (PDT)
Date: Mon, 23 Mar 2026 19:37:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Omar Elghoul <oelghoul@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, dw@davidwei.uk, edumazet@google.com,
	eperezma@redhat.com, ilias.apalodimas@linaro.org,
	jasowang@redhat.com, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, technoboy85@gmail.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for
 buffer allocation
Message-ID: <20260323193722-mutt-send-email-mst@kernel.org>
References: <20260310183107.2822016-1-vishs@meta.com>
 <20260323150136.14452-1-oelghoul@linux.ibm.com>
 <20260323114313-mutt-send-email-mst@kernel.org>
 <20260323122728-mutt-send-email-mst@kernel.org>
 <6b6bea74-4bff-4301-8dbf-a9c162456185@linux.ibm.com>
 <f91a42f7-1e90-4db0-923a-371dac8245e0@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f91a42f7-1e90-4db0-923a-371dac8245e0@meta.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270812-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,meta.com,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 469102FF073
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 01:50:29PM -0400, Vishwanath Seshagiri wrote:
> 
> 
> On 3/23/26 10:39 PM, Omar Elghoul wrote:
> > On 3/23/26 12:58 PM, Michael S. Tsirkin wrote:
> > 
> > > On Mon, Mar 23, 2026 at 11:52:34AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Mar 23, 2026 at 11:01:31AM -0400, Omar Elghoul wrote:
> > > > > [...]
> > > > Well... I am not sure how I missed it. Obvious in hindsight:
> > > > 
> > > > static void receive_buf(struct virtnet_info *vi, struct
> > > > receive_queue *rq,
> > > >                          void *buf, unsigned int len, void **ctx,
> > > >                          unsigned int *xdp_xmit,
> > > >                          struct virtnet_rq_stats *stats)
> > > > {
> > > >          struct net_device *dev = vi->dev;
> > > >          struct sk_buff *skb;
> > > >          u8 flags;
> > > >          if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > >                  pr_debug("%s: short packet %i\n", dev->name, len);
> > > >                  DEV_STATS_INC(dev, rx_length_errors);
> > > >                  virtnet_rq_free_buf(vi, rq, buf);
> > > >                  return;
> > > >          }
> > > >          /* About the flags below:
> > > >           * 1. Save the flags early, as the XDP program might
> > > > overwrite them.
> > > >           * These flags ensure packets marked as
> > > > VIRTIO_NET_HDR_F_DATA_VALID
> > > >           * stay valid after XDP processing.
> > > >           * 2. XDP doesn't work with partially checksummed
> > > > packets (refer to
> > > >           * virtnet_xdp_set()), so packets marked as
> > > >           * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP
> > > > processing.
> > > >           */
> > > >          if (vi->mergeable_rx_bufs) {
> > > >                  flags = ((struct virtio_net_common_hdr *)buf)-
> > > > >hdr.flags;
> > > >                  skb = receive_mergeable(dev, vi, rq, buf, ctx,
> > > > len, xdp_xmit,
> > > >                                          stats);
> > > >          } else if (vi->big_packets) {
> > > >                  void *p = page_address((struct page *)buf);
> > > >                  flags = ((struct virtio_net_common_hdr *)p)->hdr.flags;
> > > >                  skb = receive_big(dev, vi, rq, buf, len, stats);
> > > >          } else {
> > > >                  flags = ((struct virtio_net_common_hdr *)buf)-
> > > > >hdr.flags;
> > > >                  skb = receive_small(dev, vi, rq, buf, ctx, len,
> > > > xdp_xmit, stats);
> > > >          }
> > > > 
> > > > 
> > > > So we are reading the header, before dma sync, which is within
> > > > receive_mergeable and friends:
> > > > 
> > > > static struct sk_buff *receive_mergeable(struct net_device *dev,
> > > >                                           struct virtnet_info *vi,
> > > >                                           struct receive_queue *rq,
> > > >                                           void *buf,
> > > >                                           void *ctx,
> > > >                                           unsigned int len,
> > > >                                           unsigned int *xdp_xmit,
> > > >                                           struct
> > > > virtnet_rq_stats *stats)
> > > > {
> > > >          struct virtio_net_hdr_mrg_rxbuf *hdr = buf;
> > > >          int num_buf = virtio16_to_cpu(vi->vdev, hdr->num_buffers);
> > > >          struct page *page = virt_to_head_page(buf);
> > > >          int offset = buf - page_address(page);
> > > >          struct sk_buff *head_skb, *curr_skb;
> > > >          unsigned int truesize = mergeable_ctx_to_truesize(ctx);
> > > >          unsigned int headroom = mergeable_ctx_to_headroom(ctx);
> > > >          head_skb = NULL;
> > > >          if (rq->use_page_pool_dma)
> > > >                  page_pool_dma_sync_for_cpu(rq->page_pool, page,
> > > > offset, len);
> > > > 
> > > > 
> > > > Just as a test, the below should fix it (compiled only), but the real
> > > > fix is more complex since we need to be careful to avoid
> > > > expensive syncing
> > > > twice.
> > > > 
> > > > 
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index 97035b49bae7..57b4f5954bed 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -931,9 +931,19 @@ static struct sk_buff *page_to_skb(struct
> > > > virtnet_info *vi,
> > > >   static void *virtnet_rq_get_buf(struct receive_queue *rq, u32
> > > > *len, void **ctx)
> > > >   {
> > > > +    void *buf;
> > > > +
> > > >       BUG_ON(!rq->page_pool);
> > > > -    return virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > +    buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> > > > +    if (buf && rq->use_page_pool_dma && *len) {
> > > > +        struct page *page = virt_to_head_page(buf);
> > > > +        int offset = buf - page_address(page);
> > > > +
> > > > +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, *len);
> > > > +    }
> > > > +
> > > > +    return buf;
> > > >   }
> > > >   static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> > > > 
> > > > 
> > > > 
> > > > 
> > > > -- 
> > > > MST
> > > or maybe like this:
> > Both of these patches resolve the issue on my end.
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 97035b49bae7..835f52651006 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1956,13 +1956,6 @@ static struct sk_buff *receive_small(struct
> > > net_device *dev,
> > >        */
> > >       buf -= VIRTNET_RX_PAD + xdp_headroom;
> > > -    if (rq->use_page_pool_dma) {
> > > -        int offset = buf - page_address(page) +
> > > -                 VIRTNET_RX_PAD + xdp_headroom;
> > > -
> > > -        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > -    }
> > > -
> > >       len -= vi->hdr_len;
> > >       u64_stats_add(&stats->bytes, len);
> > > @@ -2398,9 +2391,6 @@ static struct sk_buff
> > > *receive_mergeable(struct net_device *dev,
> > >       head_skb = NULL;
> > > -    if (rq->use_page_pool_dma)
> > > -        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > -
> > >       u64_stats_add(&stats->bytes, len - vi->hdr_len);
> > >       if (check_mergeable_len(dev, ctx, len))
> > > @@ -2563,6 +2553,13 @@ static void receive_buf(struct virtnet_info
> > > *vi, struct receive_queue *rq,
> > >           return;
> > >       }
> > > +    if (rq->use_page_pool_dma) {
> > > +        struct page *page = virt_to_head_page(buf);
> > > +        int offset = buf - page_address(page);
> > > +
> > > +        page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
> > > +    }
> > > +
> > >       /* About the flags below:
> > >        * 1. Save the flags early, as the XDP program might overwrite
> > > them.
> > >        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
> > > 
> 
> Hello Omar. Thank you for the bisect, apologies for breaking the
> functionality. Thank you Michael for the patch, I will be careful next
> time about DMA sync issues. Looks like the bug is fixed, is there
> anything else needed from my end?
> 


Would be great to have you test the patch on your end and report
the performace. Thanks!

-- 
MST


