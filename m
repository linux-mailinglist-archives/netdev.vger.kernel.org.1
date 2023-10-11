Return-Path: <netdev+bounces-39823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B57C4972
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 07:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA40281FE8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB73E552;
	Wed, 11 Oct 2023 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD0DDA2
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 05:52:19 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134A19E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:52:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 024336732A; Wed, 11 Oct 2023 07:52:14 +0200 (CEST)
Date: Wed, 11 Oct 2023 07:52:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Message-ID: <20231011055213.GA1131@lst.de>
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-6-hch@lst.de> <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com> <0299895c-24a5-4bd4-b7a4-dc50cc21e3d8@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0299895c-24a5-4bd4-b7a4-dc50cc21e3d8@linux-m68k.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 12:20:57AM +1000, Greg Ungerer wrote:
> That should be M532x.
>
> I am pretty sure the code as-is today is broken for the case of using
> the split cache arrangement (so both instruction and data cache) for any
> of the version 2 cores too (denoted by the HAVE_CACHE_SPLIT option).
> But that has probably not been picked up because the default on those
> has always been instruction cache only.
>
> The reason for the special case for the M532x series is that it is a version 3
> core and they have a unified instruction and data cache. The 523x series is the
> only version 3 core that Linux supports that has the FEC hardware module.

So what config option should we check for supporting coherent allocations
and which not having the hack in fec?

Here is my guesses based on the above:

in m68k support coherent allocations with no work if

CONFIG_COLDIFRE is set and neither CONFIG_CACHE_D or CONFIG_CACHE_BOTH
is set.

in the fec driver do the alloc_noncoherent and global cache flush
hack if:

COMFIG_COLDFIRE && (CONFIG_CACHE_D || CONFIG_CACHE_BOTH)

?

