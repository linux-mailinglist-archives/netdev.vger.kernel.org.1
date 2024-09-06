Return-Path: <netdev+bounces-125857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A796EFFE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB831F26486
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BF71C9EAF;
	Fri,  6 Sep 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgNimn7P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1F1C8FA1
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615881; cv=none; b=ldRB/YV+IxaLmrtuoVxhgLGSw8U3ptYyuooMuB8eSklTwG6nvny0feLWu+NcPBQbWpy9JkfBub+8S/jKonNthDMT6fFenz2zgGKmThLXzlgk2CRV9AqD+/ar9sfmpp9LYUu6jAI29JFypDWHxSKM62kvjnskOj3HTevVdm0L0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615881; c=relaxed/simple;
	bh=nLhuq/4NxoaYG7DZOyXppSOtFssAQu52mHLlRX69mdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC4Ditvqta8QNtmsVpELqHSPfX85FParZEnv58qfCdzDESSnfmrS5rjpvMgOG3w9i4SxE8gxYzW6QIVxMAS+k03f3pRSzIDbPZNB6D4S2kdnQLKpyvWyHFQ0PhLIu7XHNw5i1tFjseCCh8jtHVO+S7B31UpJR4otxGOcbyz77do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgNimn7P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725615878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wD1vYVely4q8JgbIO/gNQgBWtSw0G56naq9lr5lM8JY=;
	b=LgNimn7P/g6SheN02KfzgEFhwNal0I7Jw+NFQZ8HH1jMzZwbo7kWQypFLFU8KhPwd5OWKf
	yLneF1U388DdAXah3du1fKCvHZhdG88AttO12Ijts5uXMxhdC8/UBdYYgvATk4CCmL3xKA
	hznMhOTIsAqA6edSmIVBL2pLwPVpdnQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-PJjCPas8OR6WmLdcQPC7-Q-1; Fri, 06 Sep 2024 05:44:37 -0400
X-MC-Unique: PJjCPas8OR6WmLdcQPC7-Q-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c7aa6c13cso14130145e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 02:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725615876; x=1726220676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD1vYVely4q8JgbIO/gNQgBWtSw0G56naq9lr5lM8JY=;
        b=Wfnkb8jyOa/LAa3QiwzwZsYPASg0A24lrv1eXde/iLUMdRxeabt24w1eFU8/znS4NT
         uSNcMMQBCcvIltl/J4z+fR8gfcQdrSZ/ioT4UhIbm7iC25rzzATxw9gSUJsyViZChGui
         g5wcFMRFA99DE4iweKIM1sDdm1oVgzpzvrjA+BzVP3cDcIQ5Uh1vdewhAFLiq9dH7B1R
         KfQxsTgMQNzh2K7tMQptFPrhs+2M9/SVqH/O9ba6oUXw2pXtNr+r5fMF2qgGDwmOU2Fi
         KK4ePCwRx2WZptP2+YaAg4LR8RFqVNDDHbsjnBeOJDORjWOkO3OSDSRcoxd2BO1R5CdG
         Af1Q==
X-Gm-Message-State: AOJu0Yw0k2vUocQuPHaW+wkphXD2B8QIOiEoyGrRU8glfyTzZ6U6D0F5
	NPlVFWKLTCZ0n4d1REadWg5F1RjG5PKy8Mn2mOFZmryjH0HDXE7L/SRSsyLVpJl/ouHFB7XDDtK
	y6caHcqUMwaBNR5TPWs9SBlwiK641vYCka/buXnZmjvyOB40NlF77lg==
X-Received: by 2002:a05:600c:c18:b0:426:65bf:5cc2 with SMTP id 5b1f17b1804b1-42c9f974354mr13692665e9.1.1725615875898;
        Fri, 06 Sep 2024 02:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFurAD8vfCPbDx8mPwjLMlgz8hKPuXp0zxCQu7viYPaLZ5O0ap8jTH8MPGq5GoeJAHcOnV3og==
X-Received: by 2002:a05:600c:c18:b0:426:65bf:5cc2 with SMTP id 5b1f17b1804b1-42c9f974354mr13692375e9.1.1725615875032;
        Fri, 06 Sep 2024 02:44:35 -0700 (PDT)
Received: from redhat.com ([155.133.17.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ca70fsm14649695e9.16.2024.09.06.02.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:44:34 -0700 (PDT)
Date: Fri, 6 Sep 2024 05:44:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Si-Wei Liu <si-wei.liu@oracle.com>,
	Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20240906053922-mutt-send-email-mst@kernel.org>
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
 <20240906044143-mutt-send-email-mst@kernel.org>
 <1725612818.815039-1-xuanzhuo@linux.alibaba.com>
 <20240906045904-mutt-send-email-mst@kernel.org>
 <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1725614736.9464588-1-xuanzhuo@linux.alibaba.com>

On Fri, Sep 06, 2024 at 05:25:36PM +0800, Xuan Zhuo wrote:
> On Fri, 6 Sep 2024 05:08:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Sep 06, 2024 at 04:53:38PM +0800, Xuan Zhuo wrote:
> > > On Fri, 6 Sep 2024 04:43:29 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Tue, Aug 20, 2024 at 03:19:13PM +0800, Xuan Zhuo wrote:
> > > > > leads to regression on VM with the sysctl value of:
> > > > >
> > > > > - net.core.high_order_alloc_disable=1
> > > > >
> > > > > which could see reliable crashes or scp failure (scp a file 100M in size
> > > > > to VM):
> > > > >
> > > > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > > > everything is fine. However, if the frag is only one page and the
> > > > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > > > overflow may occur. In this case, if an overflow is possible, I adjust
> > > > > the buffer size. If net.core.high_order_alloc_disable=1, the maximum
> > > > > buffer size is 4096 - 16. If net.core.high_order_alloc_disable=0, only
> > > > > the first buffer of the frag is affected.
> > > > >
> > > > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > > > Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > >
> > > > Guys where are we going with this? We have a crasher right now,
> > > > if this is not fixed ASAP I'd have to revert a ton of
> > > > work Xuan Zhuo just did.
> > >
> > > I think this patch can fix it and I tested it.
> > > But Darren said this patch did not work.
> > > I need more info about the crash that Darren encountered.
> > >
> > > Thanks.
> >
> > So what are we doing? Revert the whole pile for now?
> > Seems to be a bit of a pity, but maybe that's the best we can do
> > for this release.
> 
> @Jason Could you review this?
> 
> I think this problem is clear, though I do not know why it did not work
> for Darren.
> 
> Thanks.
> 

No regressions is a hard rule. If we can't figure out the regression
now, we should revert and you can try again for the next release.


> >
> >
> > > >
> > > >
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 12 +++++++++---
> > > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index c6af18948092..e5286a6da863 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
> > > > >  	void *buf, *head;
> > > > >  	dma_addr_t addr;
> > > > >
> > > > > -	if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> > > > > -		return NULL;
> > > > > -
> > > > >  	head = page_address(alloc_frag->page);
> > > > >
> > > > >  	dma = head;
> > > > > @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
> > > > >  	len = SKB_DATA_ALIGN(len) +
> > > > >  	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > >
> > > > > +	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> > > > > +		return -ENOMEM;
> > > > > +
> > > > >  	buf = virtnet_rq_alloc(rq, len, gfp);
> > > > >  	if (unlikely(!buf))
> > > > >  		return -ENOMEM;
> > > > > @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> > > > >  	 */
> > > > >  	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
> > > > >
> > > > > +	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
> > > > > +		len -= sizeof(struct virtnet_rq_dma);
> > > > > +
> > > > >  	buf = virtnet_rq_alloc(rq, len + room, gfp);
> > > > >  	if (unlikely(!buf))
> > > > >  		return -ENOMEM;
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> >


