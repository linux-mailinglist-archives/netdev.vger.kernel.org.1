Return-Path: <netdev+bounces-139025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0179AFDB2
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84725281C18
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4AA1D1F7B;
	Fri, 25 Oct 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDfUjk62"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8391CF295
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847358; cv=none; b=kwxcnCgSjlVBIRjpmH76eSw1bteXT6FDEg+70fb2E2dLBTNLnu2iW50dO6bZC4FJEewxCFx4I01cQ3ThBYN+RhRf/8jwBWlZdgtsZ/mG6mWl1X60+VhQ2huUxxBXCwbYkqsbxExm23ucJoNT7AhtUUmcmJYD1BlscnhlGpwuozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847358; c=relaxed/simple;
	bh=g0JppvObfk3iNTqV3mU7dfQbTKcrxAZKtQOZlZ8VC2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iETA9qoCxE4Tq8xoBME1eUH3WWN203EVk+55yEaINn/IVVfrUqB2v6OC9i41qfUjW3RJkR7gDvK7iMHSS/O/iKP3MgBC4Opmn8AqSB0aW7ckFv8R57fmEYKmP9trOtep7o+DTPt8aEhwQjFyKqHJ5pTxiUpGixTO9wdo3/Jt3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDfUjk62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8F3C4CEC3;
	Fri, 25 Oct 2024 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729847358;
	bh=g0JppvObfk3iNTqV3mU7dfQbTKcrxAZKtQOZlZ8VC2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDfUjk62n/kFzSLM7FkN1lLNdZtI7cPzziu0QMR6mCJJsTPhuSs4Zr8JpK+4QIxiq
	 1uiCxcC+YtXU+D16VBDy4aoxb+N4scGDshg/filAVNPC/gFdBgITUzG/fA7YOt4tyf
	 n9bBMw2XfGrPqcJf49Tml+FgiqZl1yoXj+6YFhN2P2j1sNThGPwalwMwYfX1P2eBfU
	 urW/mI+sRNqmXnA28C7waYhOjVNOmkTDGCZ6nM7FGL7Vm3kuO9SJ2xDK5Rhg9KS5sI
	 ccrUO9ZonSQbEsFN/tCRwbCsOMxCVfkyUBPCZhalaQpfw6C8Ooxrve0W39VkFyeCRz
	 Y4nQKpHqTpCDQ==
Date: Fri, 25 Oct 2024 10:09:13 +0100
From: Simon Horman <horms@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	willemb@google.com, jeroendb@google.com, shailend@google.com,
	ziweixiao@google.com, jacob.e.keller@intel.com
Subject: Re: [PATCH net-next] gve: change to use page_pool_put_full_page when
 recycling pages
Message-ID: <20241025090913.GI1202098@kernel.org>
References: <20241023221141.3008011-1-pkaligineedi@google.com>
 <cf13ffde-2a5f-4845-a27d-d4789a384891@huawei.com>
 <20241024154503.GB1202098@kernel.org>
 <CAEAWyHewCMmWmA16jdPiT6pQvwFX88JOtAyzKJHXzRBFogdyPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEAWyHewCMmWmA16jdPiT6pQvwFX88JOtAyzKJHXzRBFogdyPg@mail.gmail.com>

On Thu, Oct 24, 2024 at 10:58:47AM -0700, Harshitha Ramamurthy wrote:
> On Thu, Oct 24, 2024 at 8:45 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Oct 24, 2024 at 10:36:02AM +0800, Yunsheng Lin wrote:
> > > On 2024/10/24 6:11, Praveen Kaligineedi wrote:
> > > > From: Harshitha Ramamurthy <hramamurthy@google.com>
> > > >
> > > > The driver currently uses page_pool_put_page() to recycle
> > > > page pool pages. Since gve uses split pages, if the fragment
> > > > being recycled is not the last fragment in the page, there
> > > > is no dma sync operation. When the last fragment is recycled,
> > > > dma sync is performed by page pool infra according to the
> > > > value passed as dma_sync_size which right now is set to the
> > > > size of fragment.
> > > >
> > > > But the correct thing to do is to dma sync the entire page when
> > > > the last fragment is recycled. Hence change to using
> > > > page_pool_put_full_page().
> > >
> > > I am not sure if Fixes tag is needed if the blamed commit is only
> > > in the net-next tree. Otherwise, LGTM.
> >
> > I think it would be best to provide a fixes tag in this case.
> > It can be done by supplying it in a response to this email thread.
> > (I think it needs to start at the beginning of a line.)
> 
> Thanks Yunsheng and Simon. I wasn't sure since this patch was targeted
> for net-next. I have provided a Fixes tag below.

Thanks. FWIIW, the tag looks correct to me.

> >
> > > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> > >
> > > >
> > > > Link: https://lore.kernel.org/netdev/89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com/
> > > >
> Fixes: ebdfae0d377b ("gve: adopt page pool for DQ RDA mode")
> > > > Suggested-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> >
> > ...
> 

