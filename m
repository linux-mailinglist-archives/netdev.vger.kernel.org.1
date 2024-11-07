Return-Path: <netdev+bounces-142686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F759C0035
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB6F1C21AF5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0A1DC1BD;
	Thu,  7 Nov 2024 08:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0A1D7E50;
	Thu,  7 Nov 2024 08:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968887; cv=none; b=ocS6g6yRXzKJyBlx+sQYA/PUHnvtBR0+NxROt5g4a0/FvMzh7TCOW8lltf0UqLPSq5j4dbkUG8HwYPt4Fv4YdrAK5drEjjCiyQdw7+ikg1+76EjTE4xNrA4V9zAJnO6mzaSLiEj95hhrKKR2atAIFmju6qShlbUG+iW0K48TRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968887; c=relaxed/simple;
	bh=d7pUjDYxzTkdWgCuCUmFQOQ2ESEPFeLlSVzcCFaQeq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIKV89ASWOXmmJ946MxFacPwSn9HV0BdLu8CqDKE65JkE7KQrDQ4Cy8CNhUibqXgdh3sN+7YE4d8AvHQpdPLnmNMTBZv30jzjQzRKj6hVHQTyMk2HXDXbHQ/wH2dkXmhrmSpixCLHGLe6Dvlt31smv+qBdNSBRd87W5jlLQ0iUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 898A968AA6; Thu,  7 Nov 2024 09:41:18 +0100 (CET)
Date: Thu, 7 Nov 2024 09:41:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, fanghaiqing@huawei.com,
	liuyonglong@huawei.com, Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	IOMMU <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel-team <kernel-team@cloudflare.com>,
	Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
Message-ID: <20241107084117.GA9712@lst.de>
References: <87r084e8lc.fsf@toke.dk> <cf1911c5-622f-484c-9ee5-11e1ac83da24@huawei.com> <878qu7c8om.fsf@toke.dk> <1eac33ae-e8e1-4437-9403-57291ba4ced6@huawei.com> <87o731by64.fsf@toke.dk> <023fdee7-dbd4-4e78-b911-a7136ff81343@huawei.com> <874j4sb60w.fsf@toke.dk> <a50250bf-fe76-4324-96d7-b3acf087a18c@huawei.com> <a6cfba96-9164-4497-b075-9359c18a5eef@kernel.org> <2f256bce-0c37-4940-9218-9545daa46169@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f256bce-0c37-4940-9218-9545daa46169@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 06, 2024 at 06:56:34PM +0800, Yunsheng Lin wrote:
> > It is a very radical change that page_pool needs to keep track of *ALL* in-flight pages.
> 
> I am agreed that it is a radical change, that is why it is targetting net-next
> tree instead of net tree even when there is a Fixes tag for it.
> 
> If there is a proper and non-radical way to fix that, I would prefer the
> non-radical way too.

As Robin already correctly pointed out DMA mappings fundamentally can't
outlive the devices they were performed on.  So I don't think there will
be much hope for a non-radical fix for this design fault.


