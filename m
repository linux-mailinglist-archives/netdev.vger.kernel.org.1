Return-Path: <netdev+bounces-30002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B59D78582D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE581C20C79
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C1BE7C;
	Wed, 23 Aug 2023 12:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39BDBE7B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 12:54:55 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B205EE5C
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:54:52 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:54:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692795290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBRWiMnYP/bWCOqgyAMEagaSdQUvqpL4iQXSl2tEboU=;
	b=hB3VH8XOSfalQPLY1p7a054BXteOwPt9NKSgkTs/9EyyRWz+1DkiJ8LrXyLsKDQTdzjiDA
	s/OK7MwNkDlfoy6jB+k4purMTAPqHugBstTx35EbYv4GU/Kqw7PuvlT2jmD6JRbfZYYQLS
	+1D21FfbBIDWxrrjEBrmj4kiWX/qWthwagtgv62M2AbAWk4voN+ZAvbS7XyPGi9NGhuNXu
	2vgE4lECbk2z7oSgpu/Qylgxkr9x5+LnqFLcovvga944wZEFsJl2kudypN/UwqKgHVlBJ0
	KRNF4WAuUfQMAU2qBEq+iD1m7071t9ithltxbt95WLGU4E0rZNURROq1jme28Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692795290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBRWiMnYP/bWCOqgyAMEagaSdQUvqpL4iQXSl2tEboU=;
	b=oAstP5cYpLZDT3Wf4/65/Nd5PYvoWXINs9govrFBlWhIXtpAtJJcNFciAqEXjFXB2ietmr
	gdSZms4NXIIe4BAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: RE: [EXT] [BUG] Possible unsafe page_pool usage in octeontx2
Message-ID: <20230823125448.Q89O9wFB@linutronix.de>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <MWHPR1801MB1918F1D7686BDBC8817E473FD31CA@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB1918F1D7686BDBC8817E473FD31CA@MWHPR1801MB1918.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-23 12:28:58 [+0000], Ratheesh Kannoth wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Sent: Wednesday, August 23, 2023 3:18 PM
> > Subject: [EXT] [BUG] Possible unsafe page_pool usage in octeontx2
> > 
> > This breaks in octeontx2 where a worker is used to fill the buffer:
> >   otx2_pool_refill_task() -> otx2_alloc_rbuf() -> __otx2_alloc_rbuf() ->
> >   otx2_alloc_pool_buf() -> page_pool_alloc_frag().
> >
> As I understand, the problem is due to workqueue may get scheduled on
> other CPU. If we use BOUND workqueue, do you think this problem can be
> solved ?

It would but is still open to less obvious races for instance if the
IRQ/ NAPI is assigned to another CPU while the workqueue is scheduled.
You would have to additional synchronisation to ensure that bad can
happen. This does not make it any simpler nor prettier or serves as a
good example.

I would suggest to stay away from the lock-less buffer if not in NAPI
and feed the pool->ring instead.

> > BH is disabled but the add of a page can still happen while NAPI callback runs
> > on a remote CPU and so corrupting the index/ array.
> > 
> > API wise I would suggest to
> > 
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c index
> > 7ff80b80a6f9f..b50e219470a36 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -612,7 +612,7 @@ __page_pool_put_page(struct page_pool *pool,
> > struct page *page,
> >  			page_pool_dma_sync_for_device(pool, page,
> >  						      dma_sync_size);
> > 
> > -		if (allow_direct && in_softirq() &&
> > +		if (allow_direct && in_serving_softirq() &&
> >  		    page_pool_recycle_in_cache(page, pool))
> >  			return NULL;
> > 
> > because the intention (as I understand it) is to be invoked from within the
> > NAPI callback (while softirq is served) and not if BH is just disabled due to a
> > lock or so.
> Could you help me understand where in_softirq() check will break ?  If
> we TX a packet (dev_queue_xmit()) in 
> Process context on same core,  in_serving_softirq() check will prevent
> it from recycling ?

If a check is added to page_pool_alloc_pages() then it will trigger if
you fill the buffer from your ->ndo_open() callback.
Also, if you invoke dev_queue_xmit() from process context. But It will
be added to &pool->ring instead.

Sebastian

