Return-Path: <netdev+bounces-41329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FD07CA934
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A10B20C39
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87027738;
	Mon, 16 Oct 2023 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC3E541
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:17:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63515F7;
	Mon, 16 Oct 2023 06:17:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD1D16732D; Mon, 16 Oct 2023 15:17:16 +0200 (CEST)
Date: Mon, 16 Oct 2023 15:17:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 01/12] riscv: RISCV_NONSTANDARD_CACHE_OPS shouldn't
 depend on RISCV_DMA_NONCOHERENT
Message-ID: <20231016131716.GA26484@lst.de>
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-2-hch@lst.de> <20231016-walmart-egomaniac-dc4c63ea70a6@wendy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-walmart-egomaniac-dc4c63ea70a6@wendy>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 01:49:41PM +0100, Conor Dooley wrote:
> Hey,
> 
> On Mon, Oct 16, 2023 at 07:47:43AM +0200, Christoph Hellwig wrote:
> > RISCV_NONSTANDARD_CACHE_OPS is also used for the pmem cache maintenance
> > helpers, which are built into the kernel unconditionally.
> 
> You surely have better insight than I do here, but is this actually
> required?
> This patch seems to allow creation of a kernel where the cache
> maintenance operations could be used for pmem, but would be otherwise
> unavailable, which seems counter intuitive to me.
>
> Why would someone want to provide the pmem helpers with cache
> maintenance operations, but not provide them generally?
> 

Even if all your periphals are cache coherent (very common on server
class hardware) you still need cache maintenance for pmem.  No need
to force the extra text size and runtime overhead for non-coherent DMA.

> I also don't really understand what the unconditional nature of the pmem
> helpers has to do with anything, as this patch does not unconditionally
> provide any cache management operations, only relax the conditions under
> which the non-standard cache management operations can be provided.

They simply were broken if a platform had non-standard cache mem but
only coherent DMA before.  That's probably more a theoretical than
practial case, but still worth fixing.

