Return-Path: <netdev+bounces-17553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A81751FA8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B2D1C21368
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357D91096F;
	Thu, 13 Jul 2023 11:15:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19E1094E;
	Thu, 13 Jul 2023 11:14:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304D26A2;
	Thu, 13 Jul 2023 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MDuT703ngKhFlRZyWWMSEsAM8ty4gmUzqQMXJQcuvVk=; b=wYDk+bN1++5rhyjrI8cgWC7POg
	DA2dP0rGbqmN9RskyM2L70JP8xgSx8GQ1Le2mFgzrQmGX1tVs//odE1KLPY/OvxYDCVdtFQC+eJBt
	SVuxX0ZGL0Ypzj9q/geyGyF2D1rByT9ZVyQgMvmzjlq6CkHiJOH7WyhMmSg2kMvKw9aC3Sgmp7pia
	N9jIQLDN8sbzZ1Br3d0dptlPpJtXRshxzqPaZQ1Q/e0dVraBupePz2s02k69AgQGBlZA/SLJZHzDa
	NI45kxHVkjzxplnEacIbr1fVJFcwpUuqx7eShf8M6QOjPdPnDWgDCIk+RoyoN0W3BjtNfTd205eFD
	ykdxn+AQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qJuHV-00339M-2s;
	Thu, 13 Jul 2023 11:14:45 +0000
Date: Thu, 13 Jul 2023 04:14:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vhost v11 03/10] virtio_ring: introduce
 virtqueue_set_premapped()
Message-ID: <ZK/cpSceLMovhmfR@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710034237.12391-4-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 11:42:30AM +0800, Xuan Zhuo wrote:
> This helper allows the driver change the dma mode to premapped mode.
> Under the premapped mode, the virtio core do not do dma mapping
> internally.
> 
> This just work when the use_dma_api is true. If the use_dma_api is false,
> the dma options is not through the DMA APIs, that is not the standard
> way of the linux kernel.

I have a hard time parsing this.

More importantly having two modes seems very error prone going down
the route.  If the premapping is so important, why don't we do it
always?

