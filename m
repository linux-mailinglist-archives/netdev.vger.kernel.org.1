Return-Path: <netdev+bounces-22629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADCD7685E8
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 16:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C191A2817D6
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AAE2102;
	Sun, 30 Jul 2023 14:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A984A2101
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 14:05:50 +0000 (UTC)
X-Greylist: delayed 507 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 07:05:46 PDT
Received: from out-107.mta1.migadu.com (out-107.mta1.migadu.com [IPv6:2001:41d0:203:375::6b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC82189
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 07:05:46 -0700 (PDT)
Message-ID: <40a3ab47-da3e-0d08-b3fa-b4663f3e727d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690725435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGVwrSKPSqOKImBWbZoAx1qzxZDIg0U6/MyAhWrgbuQ=;
	b=iwoYw6Haq+kOYGPuPZKv5wW+uOf7UmUbzIK+dEi5BcvQ8JE87XsTTo3/OaLFjVQBD/o/ir
	fRSrCMrpEvqE0XtHAMIKkjF5ulAwlVSYlFZPhPk/oZ9ZcnH4KqxFkMf4MzqaUwsOND4ZDJ
	4e/ew8GqIOajhMOJNNAbOKquCrq4by4=
Date: Sun, 30 Jul 2023 21:57:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] scatterlist: Add sg_set_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20230621164557.3510324-1-willy@infradead.org>
 <20230621164557.3510324-4-willy@infradead.org>
 <a2a2180c-62ac-452f-0737-26f01f228c79@linux.dev>
 <ZMZHH5Xc507OZA1O@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZMZHH5Xc507OZA1O@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


在 2023/7/30 19:18, Matthew Wilcox 写道:
> On Sun, Jul 30, 2023 at 07:01:26PM +0800, Zhu Yanjun wrote:
>> Does the following function have folio version?
>>
>> "
>> int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
>> 		struct page **pages, unsigned int n_pages, unsigned int offset,
>> 		unsigned long size, unsigned int max_segment,
>> 		unsigned int left_pages, gfp_t gfp_mask)
>> "
> No -- I haven't needed to convert anything that uses
> sg_alloc_append_table_from_pages() yet.  It doesn't look like it should
> be _too_ hard to add a folio version.

In many places, this function is used. So this function needs the folio 
version.

Another problem, after folio is used, I want to know the performance 
after folio is implemented.

How to make tests to get the performance?

Thanks a lot.

Zhu Yanjun


