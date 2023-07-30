Return-Path: <netdev+bounces-22614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84022768502
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 13:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459E91C209C2
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC515BD;
	Sun, 30 Jul 2023 11:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F89369
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 11:19:06 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAEC1993;
	Sun, 30 Jul 2023 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kbiG19oZd/dSLtXDQyp/3XUeAYx519PsJLOOLc1diN8=; b=FcIwHFr1i0uI+4Q3Gz2kHXpaz/
	8PgE6DxOAjio4iAk93OSpSPJDPmQ0IkXSn8fqF1f5WbwAVPa9LDEJFVuyz93BBNbNJ65bRGqFglAI
	5/B/BCsWZy4FfbSdVZoezNwjJ9QqWhFJNLHEU522nAQacE/f2K85CYniJur3g2JizBbWG86YFHSME
	O8t04Ax7RTohEVH8BqB8FGr5t9+EY4S86SrbDJvhwFROsNr711hyHv/pV++/gPU4N5jDOV/t71d7z
	CnHWLlTKUH7FpOjPlBM3Q2oni+ETqrKBSDEwRzwqLE6FJSJtKhN3sHPpstpV/klY75i+msbXMkz3f
	3QZ2fzAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qQ4Rr-00Dsdl-5I; Sun, 30 Jul 2023 11:18:55 +0000
Date: Sun, 30 Jul 2023 12:18:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/13] scatterlist: Add sg_set_folio()
Message-ID: <ZMZHH5Xc507OZA1O@casper.infradead.org>
References: <20230621164557.3510324-1-willy@infradead.org>
 <20230621164557.3510324-4-willy@infradead.org>
 <a2a2180c-62ac-452f-0737-26f01f228c79@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a2180c-62ac-452f-0737-26f01f228c79@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 30, 2023 at 07:01:26PM +0800, Zhu Yanjun wrote:
> Does the following function have folio version?
> 
> "
> int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
> 		struct page **pages, unsigned int n_pages, unsigned int offset,
> 		unsigned long size, unsigned int max_segment,
> 		unsigned int left_pages, gfp_t gfp_mask)
> "

No -- I haven't needed to convert anything that uses
sg_alloc_append_table_from_pages() yet.  It doesn't look like it should
be _too_ hard to add a folio version.

