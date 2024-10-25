Return-Path: <netdev+bounces-139106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D89B03DF
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 15:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1900281C21
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E35721216E;
	Fri, 25 Oct 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plagur32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8C70805;
	Fri, 25 Oct 2024 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862530; cv=none; b=NDNuzqbgRRULG89keWOrQYd1fVP7UQKoxHDkJEOYv5qVowqtzfXtLiCAfDBx/BbMMM+n/VJc9JpHaJqRyc69Vr8Q/8ctLIsMFQqnIpiEK0MbiNI0fNk5T/SSl2epfUz4mUFzjRHUmfvUJaQ2o/FhCwH/Z6SzzFXdqAJ2mtpPMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862530; c=relaxed/simple;
	bh=QPqqSjrdF74cbCCgzunNlradUj1JeN6blhSF2wB3w18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB9hfFOrsVNxGEOpQDGq0lFM/+eMzlMgfJmiXtSJEejkRzh7n2WPwU93eh5mVb06dq9h3tVYYPH+el0DhgSGWIwPpRNAXG7t3rEmtamkIjpcPe3M3tMr/esMOUn1lQ8NRlYWcUlz0+57ZMEyxF5ENJsi7JZ2+5iIQeHTqDLXA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plagur32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B37C4CEC3;
	Fri, 25 Oct 2024 13:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729862530;
	bh=QPqqSjrdF74cbCCgzunNlradUj1JeN6blhSF2wB3w18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Plagur326hve2OtUBnqZI0FuD6Rf24ndozohanzuGWG27qh5ChrknZI18FVYwsPrT
	 xqNIzkKD5VqPsgBp1GkbqnowL4tEj148HXRY6zraG5fyrwY4JDqtlSzQsr+R4i4jE2
	 97SHI98JvbjFjlM/KEbwCULPQ0EXafHT55//T+ddGeGVzjuG49iGUCTbratXzVLnpX
	 g3m4UTQp1o51OAyDL94Tn73kmW0hA/0Y5o8PLArmAIPU3zAEM6pX5JSQr2/RuyzhH+
	 4Y2vuFmQTpor2PM0icKBLyrhyeW42/JJhnOCJIDirUHLlZOBFyJVzfxCJkF0+NjaPb
	 pdS5Y/MbDJZxA==
Date: Fri, 25 Oct 2024 14:22:05 +0100
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev,
	Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
Message-ID: <20241025132205.GV1202098@kernel.org>
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
 <6aaee824-a5df-42a4-b35e-e89756471084@redhat.com>
 <1729823753.4548287-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729823753.4548287-2-xuanzhuo@linux.alibaba.com>

On Fri, Oct 25, 2024 at 10:35:53AM +0800, Xuan Zhuo wrote:
> On Thu, 17 Oct 2024 15:42:59 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> >
> >
> > On 10/14/24 05:12, Xuan Zhuo wrote:
> > > When the frag just got a page, then may lead to regression on VM.
> > > Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> > > then the frag always get a page when do refill.
> > >
> > > Which could see reliable crashes or scp failure (scp a file 100M in size
> > > to VM):
> > >
> > > The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> > > of a new frag. When the frag size is larger than PAGE_SIZE,
> > > everything is fine. However, if the frag is only one page and the
> > > total size of the buffer and virtnet_rq_dma is larger than one page, an
> > > overflow may occur.
> > >
> > > Here, when the frag size is not enough, we reduce the buffer len to fix
> > > this problem.
> > >
> > > Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api")
> > > Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > This looks like a fix that should target the net tree, but the following
> > patches looks like net-next material. Any special reason to bundle them
> > together?
> 
> Sorry, I forgot to add net-next as a target tree.
> 
> This may look like a fix. But the feature was disabled in the last Linux
> version. So the bug cannot be triggered, so we don't need to push to the net
> tree.

I think it would be useful to be clear in the commit message, use of tags,
and target tree regarding fixes and non-fixes.

Please describe in the commit message why this is not fixing a bug, as you
have described above. And please do not include Fixes tags in patches that
are not bug fixes, which seems to be the case here.

If you want to refer to the patch that introduced the problem, you can use
the following syntax, in the commit message, before the tags. Unlike Fixes
tags, this may be line wrapped.

  This problem is not a bug fix for net because... It was was introduced by
  commit f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma_api").

  Reported-by: ...
  ...

