Return-Path: <netdev+bounces-12808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C4D738FDC
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013371C20FC5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9C01ACDA;
	Wed, 21 Jun 2023 19:14:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD6B1ACC5
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2798C433BB;
	Wed, 21 Jun 2023 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687374881;
	bh=bXO3wc+3sUR2EsnLgZj2gLeL3jd1/ho0rVN8u88ldT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YpoUEvMOrBGMFDjrPqPWSZCR7mJwiRcT4A6Fe//PCS8tGsN+EWgUGtLtHkSfNCPnq
	 D+n999RikC5LvkbQ6McHADa9Ea0f25g8ItgjOnC2izATjIxYsFEIFhkH4AtBi9YKRo
	 3oWlCVi/4K5dioybCxBB5UEpaBnP0X134v3eDbbgk+fbwe1S4XqLf54078CTC3kKu5
	 3ricwRCK3ABSVvySIytegLwEK5E+pSCe0Bi7Kd2/CxOImI7ZtvP5+OXUnhMVhjGY+j
	 V48QM81gxPRcmHk/8P8sprvICMjApqwOfIlCMh6l9+6KFSiV517nyP4nUyQIIOI6g9
	 BPwmce4MrOS8w==
Date: Wed, 21 Jun 2023 12:14:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 Joshua Hay <joshua.a.hay@intel.com>, <emil.s.tantilov@intel.com>,
 <jesse.brandeburg@intel.com>, <sridhar.samudrala@intel.com>,
 <shiraz.saleem@intel.com>, <sindhu.devale@intel.com>, <willemb@google.com>,
 <decot@google.com>, <andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
 <simon.horman@corigine.com>, <shannon.nelson@amd.com>,
 <stephen@networkplumber.org>, Alan Brady <alan.brady@intel.com>, "Madhu
 Chittim" <madhu.chittim@intel.com>, Phani Burra <phani.r.burra@intel.com>,
 Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>
Subject: Re: [PATCH net-next v2 03/15] idpf: add controlq init and reset
 checks
Message-ID: <20230621121439.382c687f@kernel.org>
In-Reply-To: <0b6fa05f-d357-2942-d17b-d24d8a5a3321@intel.com>
References: <20230614171428.1504179-1-anthony.l.nguyen@intel.com>
	<20230614171428.1504179-4-anthony.l.nguyen@intel.com>
	<20230616234218.58760587@kernel.org>
	<0b6fa05f-d357-2942-d17b-d24d8a5a3321@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 12:05:54 -0700 Linga, Pavan Kumar wrote:
> >> +void *idpf_alloc_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem, u64 size)
> >> +{
> >> +	struct idpf_adapter *adapter = hw->back;
> >> +	size_t sz = ALIGN(size, 4096);
> >> +
> >> +	mem->va = dma_alloc_coherent(&adapter->pdev->dev, sz,
> >> +				     &mem->pa, GFP_KERNEL | __GFP_ZERO);  
> > 
> > DMA API always zeros memory, I thought cocci warns about this
> > Did you run cocci checks?
> 
> I ran cocci check using the command "make -j8 
> M=drivers/net/ethernet/intel/idpf/ C=1 CHECK="scripts/coccicheck" 
> CONFIG_IDPF=m &>>err.log" but didn't see any hits and not sure if this 
> is the right command to see the warning. Will fix it anyways.

Ugh, disappointing, looks like people how were chasing these flags
throughout the tree couldn't be bothered to upstream the cocci check.
Or even document it, it seems? :| See 750afb08ca7131 as the initial
commit, FWIW, sorry to misdirect towards coccicheck.

