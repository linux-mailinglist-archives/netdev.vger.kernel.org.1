Return-Path: <netdev+bounces-167424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C6A3A3CD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A6B166E8E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F4272912;
	Tue, 18 Feb 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lelzDAP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9927290D
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898642; cv=none; b=fXtLL9xgGrPZmPzzp6p4Ehh7/jGuFJ0YjTJDxuTasLb4J/97h6e3vLHvcJiw0wWd9awJX74F8taUPKzG91lglOA5k5BLqaq+Ypzma7DtxsZdtLh9qb39ymp3jnzFLYVaFN3AyCwCd4C8ikooXlW8T0sfOnGMlxBHCslzAAdWnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898642; c=relaxed/simple;
	bh=FaOkrmQL/Jr8gx0EIfzVSrV+9cb4Lx7AsLuN13P/+14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4JxiVOerji2rWVGyQDoB4J3uCzyRJ2Lp8VjG7rgOxEM4t6rjrkT/rEBOiREhwlTpD0DM0mr4NQYIfCkb/DNT7vqnRjt/T6Hgg8BRjbYP48cghWCekEAdYGHrMQSSyUvgJd4/2sPTkrnBTej/71YeLaxGSVZWNQXcaOIHsWUBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lelzDAP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EBAC4CEE2;
	Tue, 18 Feb 2025 17:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898641;
	bh=FaOkrmQL/Jr8gx0EIfzVSrV+9cb4Lx7AsLuN13P/+14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lelzDAP64XBYn4EutgpYRgeAHzU/V0wM/QvlC4b05TYMpB1Bo4gbFB0UfBTuXi+eU
	 f/pxuslb/II6Pz7/VKt2nNZxEUCsIbmcj/tT/KpkNZwsV4WqlrumK33h7OI39tInXO
	 OL/V9spkain51hptBLAat416dhBib8Swe5s6nPQ3DpuBtIE+aucYyOyZgYXCvJUvJA
	 veSyrW+169+IHiSLkIRpXXXmO5TDjVZcqfwg/RCHj3JoVYLvzs2YUjcC0lFyp72/bT
	 Y6cwATQSXIcfrUkN6QHO+UxQNdZAZVqOxmQkimMP+DMx6WdPBAtoHePL1HslM42NFF
	 9U5hwxgCUGQzw==
Date: Tue, 18 Feb 2025 17:10:36 +0000
From: Simon Horman <horms@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, leon@kernel.org, andrew+netdev@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
	przemyslaw.kitszel@intel.com, weihg@yunsilicon.com,
	wanry@yunsilicon.com, parthiban.veerasooran@microchip.com,
	masahiroy@kernel.org
Subject: Re: [PATCH v4 05/14] net-next/yunsilicon: Add eq and alloc
Message-ID: <20250218171036.GB1615191@kernel.org>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>
 <20250213091412.2067626-6-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213091412.2067626-6-tianx@yunsilicon.com>

On Thu, Feb 13, 2025 at 05:14:14PM +0800, Xin Tian wrote:
> Add eq management and buffer alloc apis
> 
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h

...

> +struct xsc_eq_table {
> +	void __iomem	       *update_ci;
> +	void __iomem	       *update_arm_ci;
> +	struct list_head       comp_eqs_list;

nit: The indentation of the member names above seems inconsistent
     with what is below.

> +	struct xsc_eq		pages_eq;
> +	struct xsc_eq		async_eq;
> +	struct xsc_eq		cmd_eq;
> +	int			num_comp_vectors;
> +	int			eq_vec_comp_base;
> +	/* protect EQs list
> +	 */
> +	spinlock_t		lock;
> +};

...

> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c

...

> +/* Handling for queue buffers -- we allocate a bunch of memory and
> + * register it in a memory region at HCA virtual address 0.  If the
> + * requested size is > max_direct, we split the allocation into
> + * multiple pages, so we don't require too much contiguous memory.
> + */

I can't help but think there is an existing API to handle this.

> +int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,

I think unsigned long would be slightly better types for size and max_direct.

> +		  struct xsc_buf *buf)
> +{
> +	dma_addr_t t;
> +
> +	buf->size = size;
> +	if (size <= max_direct) {
> +		buf->nbufs        = 1;
> +		buf->npages       = 1;
> +		buf->page_shift   = get_order(size) + PAGE_SHIFT;
> +		buf->direct.buf   = dma_alloc_coherent(&xdev->pdev->dev,
> +						       size,
> +						       &t,
> +						       GFP_KERNEL | __GFP_ZERO);
> +		if (!buf->direct.buf)
> +			return -ENOMEM;
> +
> +		buf->direct.map = t;
> +
> +		while (t & ((1 << buf->page_shift) - 1)) {

I think GENMASK() can be used here.

> +			--buf->page_shift;
> +			buf->npages *= 2;
> +		}
> +	} else {
> +		int i;
> +
> +		buf->direct.buf  = NULL;
> +		buf->nbufs       = (size + PAGE_SIZE - 1) / PAGE_SIZE;

I think this is open-coding DIV_ROUND_UP

> +		buf->npages      = buf->nbufs;
> +		buf->page_shift  = PAGE_SHIFT;
> +		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
> +					   GFP_KERNEL);
> +		if (!buf->page_list)
> +			return -ENOMEM;
> +
> +		for (i = 0; i < buf->nbufs; i++) {
> +			buf->page_list[i].buf =
> +				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
> +						   &t, GFP_KERNEL | __GFP_ZERO);
> +			if (!buf->page_list[i].buf)
> +				goto err_free;
> +
> +			buf->page_list[i].map = t;
> +		}
> +
> +		if (BITS_PER_LONG == 64) {
> +			struct page **pages;
> +
> +			pages = kmalloc_array(buf->nbufs, sizeof(*pages),
> +					      GFP_KERNEL);
> +			if (!pages)
> +				goto err_free;
> +			for (i = 0; i < buf->nbufs; i++) {
> +				void *addr = buf->page_list[i].buf;
> +
> +				if (is_vmalloc_addr(addr))
> +					pages[i] = vmalloc_to_page(addr);
> +				else
> +					pages[i] = virt_to_page(addr);
> +			}
> +			buf->direct.buf = vmap(pages, buf->nbufs,
> +					       VM_MAP, PAGE_KERNEL);
> +			kfree(pages);
> +			if (!buf->direct.buf)
> +				goto err_free;
> +		}

I think some explanation is warranted of why the above is relevant
only when BITS_PER_LONG == 64.

> +	}
> +
> +	return 0;
> +
> +err_free:
> +	xsc_buf_free(xdev, buf);
> +
> +	return -ENOMEM;
> +}

...

> +void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages)

As per my comment on unsigned long in my response to another patch,
I think npages can be unsigned long.

> +{
> +	int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
> +	int mask = (1 << shift) - 1;

Likewise, I think that mask should be an unsigned long.
Or, both shift and mask could be #defines, as they are compile-time
constants.

Also, mask can be generated using GENMASK, e.g.

#define XSC_PAGE_ARRAY_MASK GENMASK(PAGE_SHIFT, PAGE_SHIFT_4K)
#define XSC_PAGE_ARRAY_SHIFT (PAGE_SHIFT - PAGE_SHIFT_4K)

And I note, in the (common) case of 4k pages, that both shift and mask are 0.

> +	u64 addr;
> +	int i;
> +
> +	for (i = 0; i < npages; i++) {
> +		if (buf->nbufs == 1)
> +			addr = buf->direct.map + (i << PAGE_SHIFT_4K);
> +		else
> +			addr = buf->page_list[i >> shift].map
> +			       + ((i & mask) << PAGE_SHIFT_4K);

The like above is open-coding FIELD_PREP().
However, I don't think it can be used here as
the compiler complains very loudly because the mask is 0.

> +
> +		pas[i] = cpu_to_be64(addr);
> +	}
> +}
> diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h

...

> +static void eq_update_ci(struct xsc_eq *eq, int arm)
> +{
> +	struct xsc_eq_doorbell db = {0};
> +
> +	db.data0 = XSC_SET_FIELD(cpu_to_le32(eq->cons_index),
> +				 XSC_EQ_DB_NEXT_CID) |
> +		   XSC_SET_FIELD(cpu_to_le32(eq->eqn), XSC_EQ_DB_EQ_ID);

Each of the two uses of XSC_SET_FIELD() are passed a little-endian value
and a host-byte order mask. This does not seem correct as it seems
they byte order should be consistent.

> +	if (arm)
> +		db.data0 |= XSC_EQ_DB_ARM;

Likewise, here data0 is little-endian while XSC_EQ_DB_ARM is host
byte-order.

> +	writel(db.data0, XSC_REG_ADDR(eq->dev, eq->doorbell));

And here, db.data0 is little-endian, but writel expects a host-byte order
value (which it converts to little-endian).

I didn't dig deeper but it seems to me that it would be easier to change
the type of data0 to host byte-order and drop the use of cpu_to_le32()
above.

Issues flagged by Sparse.

> +	/* We still want ordering, just not swabbing, so add a barrier */
> +	mb();
> +}

...

> +static int xsc_eq_int(struct xsc_core_device *xdev, struct xsc_eq *eq)
> +{
> +	u32 cqn, qpn, queue_id;
> +	struct xsc_eqe *eqe;
> +	int eqes_found = 0;
> +	int set_ci = 0;
> +
> +	while ((eqe = next_eqe_sw(eq))) {
> +		/* Make sure we read EQ entry contents after we've
> +		 * checked the ownership bit.
> +		 */
> +		rmb();
> +		switch (eqe->type) {
> +		case XSC_EVENT_TYPE_COMP:
> +		case XSC_EVENT_TYPE_INTERNAL_ERROR:
> +			/* eqe is changing */
> +			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
> +							     XSC_EQE_QUEUE_ID));

Similarly, here XSC_GET_FIELD() is passed a little-endian value and a host
byte-order mask, which is inconsistent.

Perhaps this should be (completely untested!):

			queue_id = XSC_GET_FIELD(le16_to_cpu(eqe->queue_id_data),
						 XSC_EQE_QUEUE_ID);

Likewise for the two uses of XSC_GET_FIELD below.

And perhaps queue_id could be renamed, say to q_id, to make things a bit
more succinct.


> +			cqn = queue_id;

I'm unsure why both cqn and queue_id are needed.

> +			xsc_cq_completion(xdev, cqn);
> +			break;
> +
> +		case XSC_EVENT_TYPE_CQ_ERROR:
> +			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
> +							     XSC_EQE_QUEUE_ID));
> +			cqn = queue_id;
> +			xsc_eq_cq_event(xdev, cqn, eqe->type);
> +			break;
> +		case XSC_EVENT_TYPE_WQ_CATAS_ERROR:
> +		case XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR:
> +		case XSC_EVENT_TYPE_WQ_ACCESS_ERROR:
> +			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
> +							     XSC_EQE_QUEUE_ID));
> +			qpn = queue_id;
> +			xsc_qp_event(xdev, qpn, eqe->type);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		++eq->cons_index;
> +		eqes_found = 1;
> +		++set_ci;
> +
> +		/* The HCA will think the queue has overflowed if we
> +		 * don't tell it we've been processing events.  We
> +		 * create our EQs with XSC_NUM_SPARE_EQE extra
> +		 * entries, so we must update our consumer index at
> +		 * least that often.
> +		 */
> +		if (unlikely(set_ci >= XSC_NUM_SPARE_EQE)) {
> +			eq_update_ci(eq, 0);
> +			set_ci = 0;
> +		}
> +	}
> +
> +	eq_update_ci(eq, 1);
> +
> +	return eqes_found;
> +}

...

