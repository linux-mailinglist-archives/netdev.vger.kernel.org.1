Return-Path: <netdev+bounces-22613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E97684DD
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 13:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC84B28172C
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA761361;
	Sun, 30 Jul 2023 11:01:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D30369
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 11:01:41 +0000 (UTC)
Received: from out-68.mta0.migadu.com (out-68.mta0.migadu.com [IPv6:2001:41d0:1004:224b::44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4E10EB
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 04:01:39 -0700 (PDT)
Message-ID: <a2a2180c-62ac-452f-0737-26f01f228c79@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690714895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDqItS6TsBITc0ogQeiO9zs2cfijso9HiN6zsa9jo50=;
	b=XpXFu6WxU3V13MvRIEnz/7Ji7DORifqqz168/epr0ILzyigpBFV+A4z4oGIVSkBtUeOFgh
	diNqH0zw0JE5/uCXG3B6N+tvcHXMpKZsZ6s0eKFzsZ+X7f+mOxmtYIXl0uv700u7SMTX1R
	uLBVb66nh3KObdbTdSfDQ/9rS/J3C2k=
Date: Sun, 30 Jul 2023 19:01:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 03/13] scatterlist: Add sg_set_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20230621164557.3510324-1-willy@infradead.org>
 <20230621164557.3510324-4-willy@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230621164557.3510324-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/6/22 0:45, Matthew Wilcox (Oracle) 写道:
> This wrapper for sg_set_page() lets drivers add folios to a scatterlist
> more easily.  We could, perhaps, do better by using a different page
> in the folio if offset is larger than UINT_MAX, but let's hope we get
> a better data structure than this before we need to care about such
> large folios.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/scatterlist.h | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index ec46d8e8e49d..77df3d7b18a6 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -141,6 +141,30 @@ static inline void sg_set_page(struct scatterlist *sg, struct page *page,
>   	sg->length = len;
>   }
>   
> +/**
> + * sg_set_folio - Set sg entry to point at given folio
> + * @sg:		 SG entry
> + * @folio:	 The folio
> + * @len:	 Length of data
> + * @offset:	 Offset into folio
> + *
> + * Description:
> + *   Use this function to set an sg entry pointing at a folio, never assign
> + *   the folio directly. We encode sg table information in the lower bits
> + *   of the folio pointer. See sg_page() for looking up the page belonging
> + *   to an sg entry.
> + *
> + **/
> +static inline void sg_set_folio(struct scatterlist *sg, struct folio *folio,
> +			       size_t len, size_t offset)
> +{
> +	WARN_ON_ONCE(len > UINT_MAX);
> +	WARN_ON_ONCE(offset > UINT_MAX);
> +	sg_assign_page(sg, &folio->page);
> +	sg->offset = offset;
> +	sg->length = len;
> +}
> +

https://elixir.bootlin.com/linux/latest/source/lib/scatterlist.c#L451

Does the following function have folio version?

"
int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
		struct page **pages, unsigned int n_pages, unsigned int offset,
		unsigned long size, unsigned int max_segment,
		unsigned int left_pages, gfp_t gfp_mask)
"

Thanks a lot.
Zhu Yanjun

>   static inline struct page *sg_page(struct scatterlist *sg)
>   {
>   #ifdef CONFIG_DEBUG_SG


