Return-Path: <netdev+bounces-30008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B67785966
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2561281308
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD380BE7E;
	Wed, 23 Aug 2023 13:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BEEBE4D
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:33:26 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38857E77
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 06:32:56 -0700 (PDT)
Date: Wed, 23 Aug 2023 15:31:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692797502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alKSNGeqIyVxfgJ6B9m6vM/XzLSKQ8YkxsBFV3DQslk=;
	b=weu79/finMzw9sW0vFx1g2zKcCq/KX1nVOUrMvdT3B5V/Hrx8DHuX/be/QOE2m7cM6NJ1b
	m+Qla0FRpmUrqneJNIUZuyQKhdzfAjjQMopj5vIUPDzXQlYJ7xBT5UuwWRnCR5x7qHzl59
	7LeNLldsXGYFKANJPFlSR3cWV691zVhYH6boKELG6drKKWMDqgtMGxaOWsz25+u5GEMWzh
	FoFcX4k8BuUs0K3rTz4BZhFP7KtRLXyouJKMdsozq5Z87Qu7xWc2sQYZkwNOtOzUWzaQ0H
	Df5rirzYN4DcJWWi7/9VXfENkpnghTgmPNeA06bqZ97b3ejHlr2eGfeYCn43Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692797502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alKSNGeqIyVxfgJ6B9m6vM/XzLSKQ8YkxsBFV3DQslk=;
	b=VoGgvvlM4enMbD5nhaT8AxTyOs28kAeH12opTymycL7Hy1qnyPHYAWlIvVujD2X5IJkYPF
	HTBfZPCgWxb38GDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: netdev@vger.kernel.org, Ratheesh Kannoth <rkannoth@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hariprasad <hkelam@marvell.com>
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Message-ID: <20230823133140.qbrxOLu-@linutronix.de>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <CAC_iWjJmoqsC6w=9cjr5v9o+43=2t4LKeZCrEP83PBb7nRS6zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC_iWjJmoqsC6w=9cjr5v9o+43=2t4LKeZCrEP83PBb7nRS6zw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-08-23 14:36:06 [+0300], Ilias Apalodimas wrote:
> Hi Sebastian,
Hi Ilias,

> >                                                       dma_sync_size);
> >
> > -               if (allow_direct && in_softirq() &&
> > +               if (allow_direct && in_serving_softirq() &&
> >                     page_pool_recycle_in_cache(page, pool))
> >                         return NULL;
> >
> 
> FWIW we used to have that check.
> commit 542bcea4be866b ("net: page_pool: use in_softirq() instead")
> changed that, so maybe we should revert that overall?

The other changes look okay, this in particular I am not sure about. It
would end up in the pool->ring instead of the lock-less cache. It still
depends how it got here. If it comes from page_pool_return_skb_page()
then the list_owner check will fail because it is not set for the
threaded-NAPI case. If it was a real concern, the entry point must have
been page_pool_put_full_page() or later. This basically assumes the same
context.

> > because the intention (as I understand it) is to be invoked from within
> > the NAPI callback (while softirq is served) and not if BH is just
> > disabled due to a lock or so.
> >
> > It would also make sense to a add WARN_ON_ONCE(!in_serving_softirq()) to
> > page_pool_alloc_pages() to spot usage outside of softirq. But this will
> > trigger in every driver since the same function is used in the open
> > callback to initially setup the HW.
> 
> What about adding a check in the cached allocation path in order to
> skip the initial page allocation?

Maybe. I'm a bit worried that this lock-less has no lockdep or similar
checks if everyone plays by the rules.

> Thanks
> /Ilias

Sebastian

