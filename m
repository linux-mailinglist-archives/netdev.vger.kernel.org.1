Return-Path: <netdev+bounces-141587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141559BB9D4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403821C22C0A
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7211C07EC;
	Mon,  4 Nov 2024 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okZXBXo+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600601BE23F;
	Mon,  4 Nov 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736441; cv=none; b=C8W8cZMNt36kv6dlwia7WZsW9nBLxC+eDVfAM+xX3nk90X3KOHChipCkBhCjoc97B+1K/qSdYNVGqwCF5PK1MbZHwPZMW+d2Cp16R7VbewK3C0R+8Hyy4BHrrdgw9mOwpZmZV46HSJnjdgtpp9gU4CuZwA5VLbTQNnjjyw90qQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736441; c=relaxed/simple;
	bh=4wMk8tpFq/A6HJt9/TcWCPAJzZ7H3SFj1GkpDsHnzjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKtCoPlVrAHDC5+q7+q0qyZ3a8LDY3/hShH8qLfNkLlnmHIRkq/NgHI0vQrggtCJfvdhm3BBhFmtgzarxi4LaHrNymGcOkStra1Fri0EXifMfjDOlOZTi7n8ax1eYEOo5ChQdUgUW6Q0TKCmd97p+sz9BpWeJXa0dProESJ+dMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okZXBXo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912DEC4CECE;
	Mon,  4 Nov 2024 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730736438;
	bh=4wMk8tpFq/A6HJt9/TcWCPAJzZ7H3SFj1GkpDsHnzjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=okZXBXo+8i9TCnYpxP1ne6zY8pxjYj3mHj01oR1aAB0M399boMDdUvLpBY/aPk9cp
	 C/ucp9fPQ1nES2lKV6eQoT8+zhe5oNHlV7DCrWO6KyVVbfFqvKswU4y19I1x5bT+MG
	 JyW+8L0FcIqSxsenUPkzS8OcEgxyzLpt7aL39Ly6t3hPmTwlWzYhh0gcD8LSL1WUQO
	 1ADCRyMQ0hm53y1QGZ1PBCkozvETRyvTsr6dUzeIQRHGU1R6M5yYkIFygU1l+xOmpG
	 P/6IJn9XVQC2wsfhbti82d5ioru0uRpzt4+X7l2zUDemeLmDN+HNxvb8vwj2KM0Z20
	 uo/SaO8nGTIcw==
Date: Mon, 4 Nov 2024 16:07:13 +0000
From: Simon Horman <horms@kernel.org>
To: Tuo Li <islituo@gmail.com>
Cc: ayush.sawal@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	almasrymina@google.com, dtatulea@nvidia.com,
	jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] chcr_ktls: fix a possible null-pointer dereference in
 chcr_ktls_dev_add()
Message-ID: <20241104160713.GE2118587@kernel.org>
References: <20241030132352.154488-1-islituo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030132352.154488-1-islituo@gmail.com>

On Thu, Oct 31, 2024 at 12:23:52AM +1100, Tuo Li wrote:
> There is a possible null-pointer dereference related to the wait-completion
> synchronization mechanism in the function chcr_ktls_dev_add().
> 
> Consider the following execution scenario:
> 
>   chcr_ktls_cpl_act_open_rpl()   //641
>     u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;   //686
>     if (u_ctx) {  //687
>     complete(&tx_info->completion);  //704
> 
> The variable u_ctx is checked by an if statement at Line 687, which means
> it can be NULL. Then, complete() is called at Line 704, which will wake
> up wait_for_completion_xxx().
> 
> Consider the wait_for_completion_timeout() in chcr_ktls_dev_add():
> 
>   chcr_ktls_dev_add()  //412
>     u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;  //432
>     wait_for_completion_timeout(&tx_info->completion, 30 * HZ); //551
>     xa_erase(&u_ctx->tid_list, tx_info->tid);  //580
> 
> The variable u_ctx is dereferenced without being rechecked at Line 580
> after the wait_for_completion_timeout(), which can introduce a null-pointer
> dereference. Besides, the variable u_ctx is also checked at Line 442 in
> chcr_ktls_dev_add(), which indicates that u_ctx is likely to be NULL in
> some execution contexts.
> 
> To fix this possible null-pointer dereference, a NULL check is put ahead of
> the call to xa_erase().
> 
> This potential bug was discovered using an experimental static analysis
> tool developed by our team. The tool deduces complete() and
> wait_for_completion() pairs using alias analysis. It then applies data
> flow analysis to detect null-pointer dereferences across synchronization
> points.
> 
> Fixes: 65e302a9bd57 ("cxgb4/ch_ktls: Clear resources when pf4 device is removed") 
> Signed-off-by: Tuo Li <islituo@gmail.com>

Hi Tuo Li,

I do see that the checking of u_ctx is inconsistent,
but it is not clear to me that is because one part is too defensive
or, OTOH, there is a bug as you suggest. And I think that we need
more analysis to determine which case it is.

Also, if it is the case that there is a bug as you suggest, after a quick
search, I think it also exists in at least one other place in this file.

...

