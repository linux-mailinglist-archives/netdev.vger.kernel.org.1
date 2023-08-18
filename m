Return-Path: <netdev+bounces-28832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADB780EEC
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FA3280DF3
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965F18C28;
	Fri, 18 Aug 2023 15:18:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D400182BC
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 15:18:36 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE13C1F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 08:18:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D9D121890;
	Fri, 18 Aug 2023 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1692371913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqiekH2F0E2/DDRwg3KGVqWkE2aBPtHmUQq2Q3oCfR8=;
	b=EpRBuI8IZ7N4y+Fb1IC81VfFtAE0lnIg8bO2Pdtle8MMmVibh8YZauSSqc9T8l79wnWMUQ
	nIQdLIZDCThqJUJpNdN3tS9dqIFqHEy8Oz5fuudmds1y82cr58EixAkWsJA3LTtBXlBR1w
	ARoGyE0CJDbM85BTQorWFikMxwKwKvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1692371913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqiekH2F0E2/DDRwg3KGVqWkE2aBPtHmUQq2Q3oCfR8=;
	b=JbQjzaDCyT9y0UIMBO2L1auErX+f71DPH1ntDCw8bZA9FATVWk+/cadv+eT25ryTxi0yFC
	/9L85ZCZTGyRAbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 837A8138F0;
	Fri, 18 Aug 2023 15:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MXhvHciL32QQWwAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 18 Aug 2023 15:18:32 +0000
Message-ID: <7fa57517-cf32-79b9-405d-251997d25414@suse.cz>
Date: Fri, 18 Aug 2023 17:20:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net] net: use SLAB_NO_MERGE for kmem_cache
 skbuff_head_cache
Content-Language: en-US
To: Jesper Dangaard Brouer <jbrouer@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>
Cc: brouer@redhat.com, netdev@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Christoph Lameter <cl@linux.com>,
 roman.gushchin@linux.dev, dsterba@suse.com
References: <169211265663.1491038.8580163757548985946.stgit@firesoul>
 <ZNufkkauiS20IIJw@casper.infradead.org>
 <0f77001b-8bd3-f72e-7837-cc0d3485aaf8@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <0f77001b-8bd3-f72e-7837-cc0d3485aaf8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/23 14:32, Jesper Dangaard Brouer wrote:
> 
> 
> On 15/08/2023 17.53, Matthew Wilcox wrote:
>> On Tue, Aug 15, 2023 at 05:17:36PM +0200, Jesper Dangaard Brouer wrote:
>>> For the bulk API to perform efficiently the slub fragmentation need to
>>> be low. Especially for the SLUB allocator, the efficiency of bulk free
>>> API depend on objects belonging to the same slab (page).
>>
>> Hey Jesper,
>>
>> You probably haven't seen this patch series from Vlastimil:
>>
>> https://lore.kernel.org/linux-mm/20230810163627.6206-9-vbabka@suse.cz/
>>
>> I wonder if you'd like to give it a try?  It should provide some immunity
>> to this problem, and might even be faster than the current approach.
>> If it isn't, it'd be good to understand why, and if it could be improved.

I didn't Cc Jesper on that yet, as the initial attempt was focused on
the maple tree nodes use case. But you'll notice using the percpu array
requires the cache to be created with SLAB_NO_MERGE anyway, so this
patch would be still necessary :)

> I took a quick look at:
>  -
> https://lore.kernel.org/linux-mm/20230810163627.6206-11-vbabka@suse.cz/#Z31mm:slub.c
> 
> To Vlastimil, sorry but I don't think this approach with spin_lock will
> be faster than SLUB's normal fast-path using this_cpu_cmpxchg.
> 
> My experience is that SLUB this_cpu_cmpxchg trick is faster than spin_lock.
> 
> On my testlab CPU E5-1650 v4 @ 3.60GHz:
>  - spin_lock+unlock : 34 cycles(tsc) 9.485 ns
>  - this_cpu_cmpxchg :  5 cycles(tsc) 1.585 ns
>  - locked cmpxchg   : 18 cycles(tsc) 5.006 ns

Hm that's unexpected difference between spin_lock+unlock where AFAIK
spin_lock is basically a locked cmpxchg and unlock a simple write, and I
assume these measurements are on uncontended lock?

> SLUB does use a cmpxchg_double which I don't have a microbench for.

Yeah it's possible the _double will be slower. Yeah the locking will
have to be considered more thoroughly for the percpu array.

>> No objection to this patch going in for now, of course.
>>
> 

