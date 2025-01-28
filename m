Return-Path: <netdev+bounces-161258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71574A20440
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 07:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B828B1668F7
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 06:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE851917E7;
	Tue, 28 Jan 2025 06:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d46jtVwr"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EE18B476;
	Tue, 28 Jan 2025 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738044738; cv=none; b=p4r4cVxjiTz+8wBOS3hbfhTnut5LvueWhCvEIvw8m2Xou46KaanJY3hSkkw/GBv97zLVQ7SFK8LDMgkJuFoQAZeHZ+1j9ajnl/mAMn4N6bqzoZmPcubWzIrTST4p2SDVrWXHuNXVGCX++9dgVjTpdTUZzLMa1w0tFVowJ0PMdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738044738; c=relaxed/simple;
	bh=JLZRvtPx01zZ02Bp8wGAIaOL7w4LyZ+P9o5Ndkme27k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAAy6R5mCU1BEZ2Pc/o+5wwor7rVUkl+GPh15+CuIfAQ7LohbEnYZq1NSi/fvT4Lm+fe97DDJLOhnSCtslVxMGxRJijxteHVExjYd6VWENNxhYWo8hbatQaYvQapnvoBnO8a8mMLnYfNDlv9NqLOtxFeuH2zB4hjFTn7y8aWOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d46jtVwr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xpq0EzznBsykUuruz4uXaOlJN+LKQNMON88eEeJONJ4=; b=d46jtVwrm7L+V7m3wvZM2xQGAk
	Q0dEQl6ZBqvJMmVNqAx+clFFc7Xy4ECPalPCgl1U/8zlKjtTjpa76KWpmBr8ACOHvEJFewwxkvgbi
	CDEX75YTHfqOclu+9RQenq7sOQkAAKQoGb5ncTOC2LHKd3kaaelhet5ACjVrRrGYW18SAzU2hdu7y
	VOeKjRJkMVV6gq6lCSwsH5NKrWX4/dDBneQx0Q34rrgXB36SZNWSKJAhiIhu0laSCYgbCnfan4GQd
	phn5CjzqGSXl/dYGOE7lH2u/OmOPCWcJyjgrA/gm8klELE8eLoY3nmrdKFHeIMv6ymf9LO2Srz6a+
	4t7y5oKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcepU-00000004C7D-0hfc;
	Tue, 28 Jan 2025 06:12:08 +0000
Date: Mon, 27 Jan 2025 22:12:08 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC v8 3/5] page_pool: fix IOMMU crash when driver has already
 unbound
Message-ID: <Z5h1OMgcHuPSMaHM@infradead.org>
References: <20250127025734.3406167-1-linyunsheng@huawei.com>
 <20250127025734.3406167-4-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127025734.3406167-4-linyunsheng@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 27, 2025 at 10:57:32AM +0800, Yunsheng Lin wrote:
> Note, the devmem patchset seems to make the bug harder to fix,
> and may make backporting harder too. As there is no actual user
> for the devmem and the fixing for devmem is unclear for now,
> this patch does not consider fixing the case for devmem yet.

Is there another outstanding patchet?  Or do you mean the existing
devmem code already merged?  If that isn't actually used it should
be removed, but otherwise you need to fix it.


