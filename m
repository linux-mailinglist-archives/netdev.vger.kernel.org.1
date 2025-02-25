Return-Path: <netdev+bounces-169404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C74A43B87
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF7A3BDDAB
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9AF267F42;
	Tue, 25 Feb 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrNSTlVL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D2267B9C
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478934; cv=none; b=aebACTB4gJw7pLubECseFOIQ2Wz32aTbRbvoacQ2KEVJuua2kHcXl4MauDfSvppld7bo/2NhO3aaAfEUlng44MRF2uBKK8gyEGTj4362drbnJ2XySo2ps+MdqLcJvi9OXBVzUfzfkwO+rrCz0ym5aRPc6D3pTGpFxMEtjMcYOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478934; c=relaxed/simple;
	bh=v9twrmLMUDvtPrU79VyArvUo+LlqBK8BJXTwvQSKJQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ony5Xhe9Khl6Vl946j6koApjwqhP2SpwJ9Ez6e+npJ6NoGdHKCb18iwS++eUk5YiLoFQmi8zL3ldwdYvFO/EV0zEvReb7cZQ0pULip9xqD8JT+YSXP4R9s+YGIsAKgNwNsNAqRKdtGAo4b3ZmajSTYnwURKtAnZs8FW+j4WxxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrNSTlVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0CDC4CEE8;
	Tue, 25 Feb 2025 10:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478933;
	bh=v9twrmLMUDvtPrU79VyArvUo+LlqBK8BJXTwvQSKJQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrNSTlVLchFo7ick0DndFzAAKh75PBrP95jjkzQQpZxxtvRfFOLq93T16vkxpxwy7
	 9k3IQxUs1jEHUjUsmLQqRYBrqW+SBv650zTmFRjStkVUyq2V0M55+y3trGDPWCnVMB
	 RdeBTAxv+kfqE2FYtsk9PNz2kLhx4nckcrnVL8u6+2WEE0twtpNt4G/hqQAw/VHeOA
	 RemgyC/Fp3xVZQ+MAsY9Uq0Uz08O99RckHT6XYFwpwegIYBRIrYfS3DdAlZ46CHCfw
	 KN2i0DViHp+garDsxpKE8N5r/GRm19I6NyemV/dmLJv0sSKJ84iWJNM9Zd+5an701B
	 o4p356k4TLtpg==
Date: Tue, 25 Feb 2025 10:22:08 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, parthiban.veerasooran@microchip.com,
	masahiroy@kernel.org
Subject: Re: [PATCH v4 05/14] net-next/yunsilicon: Add eq and alloc
Message-ID: <20250225102208.GS1615191@kernel.org>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>
 <20250213091412.2067626-6-tianx@yunsilicon.com>
 <20250218171036.GB1615191@kernel.org>
 <b0adf539-8104-452d-ba34-14a120602bd5@yunsilicon.com>
 <20250224185817.GH1615191@kernel.org>
 <9b96cab4-e433-4752-a668-1d8ff262be2a@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b96cab4-e433-4752-a668-1d8ff262be2a@yunsilicon.com>

On Tue, Feb 25, 2025 at 10:34:24AM +0800, Xin Tian wrote:
> On 2025/2/25 2:58, Simon Horman wrote:
> > On Thu, Feb 20, 2025 at 11:35:26PM +0800, tianx wrote:
> >> On 2025/2/19 1:10, Simon Horman wrote:
> >>> On Thu, Feb 13, 2025 at 05:14:14PM +0800, Xin Tian wrote:
> > ...
> >
> >>>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
> >>> ...
> >>>
> >>>> +/* Handling for queue buffers -- we allocate a bunch of memory and
> >>>> + * register it in a memory region at HCA virtual address 0.  If the
> >>>> + * requested size is > max_direct, we split the allocation into
> >>>> + * multiple pages, so we don't require too much contiguous memory.
> >>>> + */
> >>> I can't help but think there is an existing API to handle this.
> >> failed to find one
> > Yes, me neither.
> >
> >>>> +int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
> >>> I think unsigned long would be slightly better types for size and max_direct.
> >> yes, will modify
> >>>> +		  struct xsc_buf *buf)
> >>>> +{
> >>>> +	dma_addr_t t;
> >>>> +
> >>>> +	buf->size = size;
> >>>> +	if (size <= max_direct) {
> >>>> +		buf->nbufs        = 1;
> >>>> +		buf->npages       = 1;
> >>>> +		buf->page_shift   = get_order(size) + PAGE_SHIFT;
> >>>> +		buf->direct.buf   = dma_alloc_coherent(&xdev->pdev->dev,
> >>>> +						       size,
> >>>> +						       &t,
> >>>> +						       GFP_KERNEL | __GFP_ZERO);
> >>>> +		if (!buf->direct.buf)
> >>>> +			return -ENOMEM;
> >>>> +
> >>>> +		buf->direct.map = t;
> >>>> +
> >>>> +		while (t & ((1 << buf->page_shift) - 1)) {
> >>> I think GENMASK() can be used here.
> >> ok
> >>>> +			--buf->page_shift;
> >>>> +			buf->npages *= 2;
> >>>> +		}
> >>>> +	} else {
> >>>> +		int i;
> >>>> +
> >>>> +		buf->direct.buf  = NULL;
> >>>> +		buf->nbufs       = (size + PAGE_SIZE - 1) / PAGE_SIZE;
> >>> I think this is open-coding DIV_ROUND_UP
> >> right, I'll change
> >>>> +		buf->npages      = buf->nbufs;
> >>>> +		buf->page_shift  = PAGE_SHIFT;
> >>>> +		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
> >>>> +					   GFP_KERNEL);
> >>>> +		if (!buf->page_list)
> >>>> +			return -ENOMEM;
> >>>> +
> >>>> +		for (i = 0; i < buf->nbufs; i++) {
> >>>> +			buf->page_list[i].buf =
> >>>> +				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
> >>>> +						   &t, GFP_KERNEL | __GFP_ZERO);
> >>>> +			if (!buf->page_list[i].buf)
> >>>> +				goto err_free;
> >>>> +
> >>>> +			buf->page_list[i].map = t;
> >>>> +		}
> >>>> +
> >>>> +		if (BITS_PER_LONG == 64) {
> >>>> +			struct page **pages;
> >>>> +
> >>>> +			pages = kmalloc_array(buf->nbufs, sizeof(*pages),
> >>>> +					      GFP_KERNEL);
> >>>> +			if (!pages)
> >>>> +				goto err_free;
> >>>> +			for (i = 0; i < buf->nbufs; i++) {
> >>>> +				void *addr = buf->page_list[i].buf;
> >>>> +
> >>>> +				if (is_vmalloc_addr(addr))
> >>>> +					pages[i] = vmalloc_to_page(addr);
> >>>> +				else
> >>>> +					pages[i] = virt_to_page(addr);
> >>>> +			}
> >>>> +			buf->direct.buf = vmap(pages, buf->nbufs,
> >>>> +					       VM_MAP, PAGE_KERNEL);
> >>>> +			kfree(pages);
> >>>> +			if (!buf->direct.buf)
> >>>> +				goto err_free;
> >>>> +		}
> >>> I think some explanation is warranted of why the above is relevant
> >>> only when BITS_PER_LONG == 64.
> >> Some strange historical reasons, and no need for the check now. I'll
> >> clean this up
> > Thanks.
> >
> > If you do need 64bit only logic, then perhaps it can be moved to a
> > separate function. It could guard code using something like this.
> >
> > int some_func(struct xsc_buf *buf)
> > {
> > 	if (!IS_ENABLED(CONFIG_64BIT))
> > 		return 0;
> >
> > 	...
> > }
> >
> > Or if that is not possible, something like this:
> >
> > #ifdef CONFIG_64BIT
> > int some_func(struct xsc_buf *buf)
> > {
> > 	...
> > }
> > #else /* CONFIG_64BIT */
> > int some_func(struct xsc_buf *buf) { return 0; }
> > #fi /* CONFIG_64BIT */
> >
> >>>> +	}
> >>>> +
> >>>> +	return 0;
> >>>> +
> >>>> +err_free:
> >>>> +	xsc_buf_free(xdev, buf);
> >>>> +
> >>>> +	return -ENOMEM;
> >>>> +}
> >>> ...
> >>>
> >>>> +void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages)
> >>> As per my comment on unsigned long in my response to another patch,
> >>> I think npages can be unsigned long.
> >> ok
> >>>> +{
> >>>> +	int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
> >>>> +	int mask = (1 << shift) - 1;
> >>> Likewise, I think that mask should be an unsigned long.
> >>> Or, both shift and mask could be #defines, as they are compile-time
> >>> constants.
> >>>
> >>> Also, mask can be generated using GENMASK, e.g.
> >>>
> >>> #define XSC_PAGE_ARRAY_MASK GENMASK(PAGE_SHIFT, PAGE_SHIFT_4K)
> >>> #define XSC_PAGE_ARRAY_SHIFT (PAGE_SHIFT - PAGE_SHIFT_4K)
> >>>
> >>> And I note, in the (common) case of 4k pages, that both shift and mask are 0.
> >> Thank you for the suggestion, but that's not quite the case here. The
> >> |shift| and |mask| are not used to extract fields from data. Instead,
> >> they are part of a calculation. In |xsc_buf_alloc|, we allocate the
> >> buffer based on the system's page size. However, in this function, we
> >> need to break each page in the |buflist| into 4KB chunks, populate the
> >> |pas| array with the corresponding DMA addresses, and then map them to
> >> hardware.
> >>
> >> The |shift| is calculated as |PAGE_SHIFT - PAGE_SHIFT_4K|, allowing us
> >> to convert the 4KB chunk index (|i|) to the corresponding page index in
> >> |buflist| with |i >> shift|. The |i & mask| gives us the offset of the
> >> current 4KB chunk within the page, and by applying |((i & mask) <<
> >> PAGE_SHIFT_4K)|, we can compute the offset of that chunk within the page.
> >>
> >> I hope this makes things clearer!
> > Thanks, that is clear.
> >
> > I do still think that the shift and mask could
> > be compile-time constants rather than local variables.
> > And it does seem to me that GENMASK can be used to generate the mask.
> 
> Hi, Simon,
> 
> Assuming we use GENMASK, the mask should be defined as GENMASK(shift - 
> 1, 0).
> 
> When the system page size is 4K, shift will be 0, which will cause an error.

Understood, so much for that idea.

