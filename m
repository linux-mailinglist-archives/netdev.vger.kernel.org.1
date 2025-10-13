Return-Path: <netdev+bounces-228672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6762BD1CFA
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A05B348ACF
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 07:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BE12E8DFE;
	Mon, 13 Oct 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mL8N1wCk"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2332E8DE2
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340681; cv=none; b=sVpiiTgHZR1aMkyW6Ntr0y7p1EKxEa+leGrWBfcQkdl913aSR3RkzsB173A/XO7rbDHznxiHcoM6BsM5MIjmzbWjm0l2TX3bNbkrxK6GaPGPZyS+m5JULbeAsZ01RlekHG1tKbbRAr+mkUVlbkUlDUQSy6VR1gZnhN7bK4HGaIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340681; c=relaxed/simple;
	bh=nQd1wpSadkiLWOBWBzuaZBnKqek/NdGGpG/QSpGtpkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HLGlecIwC03SpsYxgLzOZ+IWlyEXbB5ByrZkBSqORxPFPyu6t4gg0nA0cJ146ssd/Vx3mbe9g4VhiRKUGxkR3SwT2giandk9kyuudeQ8SzqgFsBHyEoGL+EBCI0KBtqfAIgl9EphZ2ccSswx0MUJ1yNbV4aMtYKJ5sCr5hE8C3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mL8N1wCk; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251013073111euoutp02a4885dec09ea81f5cb81162faf734f2a~t-IOF56dk2092720927euoutp02g
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:31:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251013073111euoutp02a4885dec09ea81f5cb81162faf734f2a~t-IOF56dk2092720927euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760340671;
	bh=0C66lDNIsw7boeMvkI3nnrZCgoIXKGyjsWdc4rgF8EE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mL8N1wCkL8LSpTI9usNqZH6gXzCV2zL/i/7V9X7vcqQ3YL6mUwtsgNffuE3VYfDl3
	 ZsZLmKsDKqilpX6FLDf1J1UC4+wKk2NX0QC+lJWMOnBozx8a2Uraa6UJreTXWEy6r9
	 Ics67206t1pTNNAEfirpt9He7m+qGqFn39WED9Dw=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251013073110eucas1p2f1db1c771c1450842b0022966f21c4d0~t-INZxAM10776107761eucas1p2M;
	Mon, 13 Oct 2025 07:31:10 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251013073109eusmtip173e3c05d8ae051a2867cdde4986d79a8~t-IMEA6LU2984829848eusmtip1H;
	Mon, 13 Oct 2025 07:31:08 +0000 (GMT)
Message-ID: <0d5f2179-b89b-42b6-805d-6a50d2268eca@samsung.com>
Date: Mon, 13 Oct 2025 09:31:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: KMSAN: uninit-value in eth_type_trans
To: Alexander Potapenko <glider@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Leon
	Romanovsky <leonro@nvidia.com>, mhklinux@outlook.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Aleksandr
	Nogikh <nogikh@google.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251013073110eucas1p2f1db1c771c1450842b0022966f21c4d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251008084433eucas1p2d50387b4147f88edb8de400dcf0b0a82
X-EPHeader: CA
X-CMS-RootMailID: 20251008084433eucas1p2d50387b4147f88edb8de400dcf0b0a82
References: <20250925223656.1894710-1-nogikh@google.com>
	<CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
	<CGME20251008084433eucas1p2d50387b4147f88edb8de400dcf0b0a82@eucas1p2.samsung.com>
	<CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com>

On 08.10.2025 10:43, Alexander Potapenko wrote:
> On Tue, Oct 7, 2025 at 8:51 AM Alexander Potapenko <glider@google.com> wrote:
>> Folks, as far as I understand, dma_direct_sync_single_for_cpu() and
>> dma_direct_sync_single_for_device() are the places where we send data
>> to or from the device.
>> Should we add KMSAN annotations to those functions to catch infoleaks
>> and mark data from devices as initialized?
> Something along the lines of:
>
> ======================================
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 0d37da3d95b65..7f59de19c1c87 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -42,6 +42,7 @@
>   #include <linux/string.h>
>   #include <linux/swiotlb.h>
>   #include <linux/types.h>
> +#include <linux/kmsan-checks.h>
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
>   #include <linux/of.h>
>   #include <linux/of_fdt.h>
> @@ -903,10 +904,13 @@ static void swiotlb_bounce(struct device *dev,
> phys_addr_t tlb_addr, size_t size
>
>                          local_irq_save(flags);
>                          page = pfn_to_page(pfn);
> -                       if (dir == DMA_TO_DEVICE)
> +                       if (dir == DMA_TO_DEVICE) {
> +                               kmsan_check_highmem_page(page, offset, sz);
>                                  memcpy_from_page(vaddr, page, offset, sz);
> -                       else
> +                       } else {
> +                               kmsan_unpoison_memory(vaddr, sz);
>                                  memcpy_to_page(page, offset, vaddr, sz);
> +                       }
>                          local_irq_restore(flags);
>
>                          size -= sz;
> @@ -915,8 +919,10 @@ static void swiotlb_bounce(struct device *dev,
> phys_addr_t tlb_addr, size_t size
>                          offset = 0;
>                  }
>          } else if (dir == DMA_TO_DEVICE) {
> +               kmsan_check_memory(phys_to_virt(orig_addr), size);
>                  memcpy(vaddr, phys_to_virt(orig_addr), size);
>          } else {
> +               kmsan_unpoison_memory(vaddr, size);
>                  memcpy(phys_to_virt(orig_addr), vaddr, size);
>          }
>   }
> ======================================
>
> should be conceptually right, but according to the comment in
> swiotlb_tbl_map_single()
> (https://protect2.fireeye.com/v1/url?k=837a6d67-dce15478-837be628-000babdfecba-aa25926458f9fd30&q=1&e=a3963b1b-328b-4f69-8ca5-ffd6fc777dd7&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.17.1%2Fsource%2Fkernel%2Fdma%2Fswiotlb.c%23L1431),
> that function is deliberately copying the buffer to the device, even
> when it is uninitialized - and KMSAN actually started reporting that
> when I applied the above patch.
>
> How should we handle this case?
> Not adding the kmsan_check_memory() calls will solve the problem, but
> there might be real infoleaks that we won't detect.
> We could unpoison the buffer before passing it to
> swiotlb_tbl_map_single() to ignore just the first infoleak on the
> buffer.
> Alternatively, we could require callers to always initialize the
> buffer passed to swiotlb_tbl_map_single().

Well, I didn't consider swiotlb a special case so far. I did a simple 
test with my PoC patch mentioned earlier in this thread with 
'swiotlb=force' kernel parameter and I didn't observe any kmsan issues, 
but I admin that this wasn't exhaustive test.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


