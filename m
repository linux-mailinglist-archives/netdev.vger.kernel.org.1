Return-Path: <netdev+bounces-26183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A737771E8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9E11C21197
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E51613F;
	Thu, 10 Aug 2023 07:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76929A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3EFC433C7;
	Thu, 10 Aug 2023 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691653754;
	bh=e7MEa/R7xR4Wky+nEP3+CKBKXMOoeInQccy4b2OpW7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2RYiO6BHui3lLTY2qbfObRvRrIsw2Tqu8L7uhIvPFScH/TtiWLmNlE9H9FdLpS5L2
	 LfL5fZzXbCZ50T2GQMx0wOrrCRUlHUxXkRZDB1bwEjsh8WFbVeaIisz0+a0J8zn9tc
	 GuJzL8ncjUNG4Fo4zuvrkVctpy3qGP81LR1+b5e0=
Date: Thu, 10 Aug 2023 09:49:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net 0/5] Netfilter fixes for net
Message-ID: <2023081006-nurture-landside-fb56@gregkh>
References: <20230810070830.24064-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810070830.24064-1-pablo@netfilter.org>

On Thu, Aug 10, 2023 at 09:08:25AM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> The following patchset contains Netfilter fixes for net.
> 
> The existing attempt to resolve races between control plane and GC work
> is error prone, as reported by Bien Pham <phamnnb@sea.com>, some places
> forgot to call nft_set_elem_mark_busy(), leading to double-deactivation
> of elements.
> 
> This series contains the following patches:
> 
> 1) Do not skip expired elements during walk otherwise elements might
>    never decrement the reference counter on data, leading to memleak.
> 
> 2) Add a GC transaction API to replace the former attempt to deal with
>    races between control plane and GC. GC worker sets on NFT_SET_ELEM_DEAD_BIT
>    on elements and it creates a GC transaction to remove the expired
>    elements, GC transaction could abort in case of interference with
>    control plane and retried later (GC async). Set backends such as
>    rbtree and pipapo also perform GC from control plane (GC sync), in
>    such case, element deactivation and removal is safe because mutex
>    is held then collected elements are released via call_rcu().
> 
> 3) Adapt existing set backends to use the GC transaction API.
> 
> 4) Update rhash set backend to set on _DEAD bit to report deleted
>    elements from datapath for GC.
> 
> 5) Remove old GC batch API and the NFT_SET_ELEM_BUSY_BIT.
> 
> Florian Westphal (1):
>   netfilter: nf_tables: don't skip expired elements during walk
> 
> Pablo Neira Ayuso (4):
>   netfilter: nf_tables: GC transaction API to avoid race with control plane
>   netfilter: nf_tables: adapt set backend to use GC transaction API
>   netfilter: nft_set_hash: mark set element as dead when deleting from packet path
>   netfilter: nf_tables: remove busy mark and gc batch API
> 
> Please, pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-23-08-10
> 
> Thanks.
> 
> ----------------------------------------------------------------
> 
> The following changes since commit c5ccff70501d92db445a135fa49cf9bc6b98c444:
> 
>   Merge branch 'net-sched-bind-logic-fixes-for-cls_fw-cls_u32-and-cls_route' (2023-07-31 20:10:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git tags/nf-23-08-10
> 
> for you to fetch changes up to a2dd0233cbc4d8a0abb5f64487487ffc9265beb5:
> 
>   netfilter: nf_tables: remove busy mark and gc batch API (2023-08-10 08:25:27 +0200)
> 
> ----------------------------------------------------------------
> netfilter pull request 23-08-10
> 
> ----------------------------------------------------------------
> Florian Westphal (1):
>       netfilter: nf_tables: don't skip expired elements during walk
> 
> Pablo Neira Ayuso (4):
>       netfilter: nf_tables: GC transaction API to avoid race with control plane
>       netfilter: nf_tables: adapt set backend to use GC transaction API
>       netfilter: nft_set_hash: mark set element as dead when deleting from packet path
>       netfilter: nf_tables: remove busy mark and gc batch API
> 
>  include/net/netfilter/nf_tables.h | 120 ++++++---------
>  net/netfilter/nf_tables_api.c     | 307 ++++++++++++++++++++++++++++++--------
>  net/netfilter/nft_set_hash.c      |  85 +++++++----
>  net/netfilter/nft_set_pipapo.c    |  66 +++++---
>  net/netfilter/nft_set_rbtree.c    | 146 ++++++++++--------
>  5 files changed, 476 insertions(+), 248 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

