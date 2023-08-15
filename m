Return-Path: <netdev+bounces-27715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51DC77CFA7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8DE1C20D88
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D31548F;
	Tue, 15 Aug 2023 15:54:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA414A91
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 15:54:02 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F91BD0
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YqM3sFIAr0dPlzpnG5UjR2YT4bCJ1GeRfuoA0iMwHhw=; b=p9jXINvwL96c8P5rdLOwOWWDEQ
	TRGHeh5zMeOeGxnAZcmNcQbJD4mvNJMXlzBwO8/1JYZs+vMhetvD9K+8L1ks6gYF4QTUfsh4ntyC+
	BPSeES8+/beN1mbbtqMSOK4Brfq6z+0mmtwb0jRMYShEa1X8k+RRpijbMvaUzbw3s7ifW1ZFy9fsS
	/YwemLInbb5fOxQZcpgzdDAoyYjeWOHRayAwOXfasu52a1j4XfoiNHiFHY3cKFYsNgsVKCB1Byr6k
	/adjwv66R4kqZJMCiseto46usSLKk+plP3OSFxZvf722Iw7I5lY9v6RT9o0/iPt92oALkH+nYUTS0
	4cz1BkOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qVwMk-00957r-QY; Tue, 15 Aug 2023 15:53:54 +0000
Date: Tue, 15 Aug 2023 16:53:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, vbabka@suse.cz,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Christoph Lameter <cl@linux.com>, roman.gushchin@linux.dev,
	dsterba@suse.com
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache
 skbuff_head_cache
Message-ID: <ZNufkkauiS20IIJw@casper.infradead.org>
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169211265663.1491038.8580163757548985946.stgit@firesoul>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 05:17:36PM +0200, Jesper Dangaard Brouer wrote:
> For the bulk API to perform efficiently the slub fragmentation need to
> be low. Especially for the SLUB allocator, the efficiency of bulk free
> API depend on objects belonging to the same slab (page).

Hey Jesper,

You probably haven't seen this patch series from Vlastimil:

https://lore.kernel.org/linux-mm/20230810163627.6206-9-vbabka@suse.cz/

I wonder if you'd like to give it a try?  It should provide some immunity
to this problem, and might even be faster than the current approach.
If it isn't, it'd be good to understand why, and if it could be improved.

No objection to this patch going in for now, of course.

