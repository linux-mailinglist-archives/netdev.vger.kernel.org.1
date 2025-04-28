Return-Path: <netdev+bounces-186555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779F2A9FA24
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F9D7A5333
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369C2973D2;
	Mon, 28 Apr 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLDdoZvV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AE52951DF;
	Mon, 28 Apr 2025 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745870704; cv=none; b=HdK16UQSiR6RWVOymLj27qYJyGbIwdWhRRkSpB8h4mH2DBczJTauqA4GjK/cZi1IwVWdJlT+0zvwXvxVmeJTvgoOKuUQFHONUHj+x6B2rM4TOtcPzRgV0bzyHVevaGluHLfiV/L2PmOPACPgenbEHEmyWAUOb04uJXDSljtO+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745870704; c=relaxed/simple;
	bh=JUAjh8uOOoE92HNSZYb4XPtIiW2gP/0nvsrvkA3azJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im17sjgIH1916pwGcRc/MC25kzDGIHiX9tscLQNmcRAs2bj+a2e8D4DFy6oWYRn9B/OGnMgEFzmCEJg5J7vnuLL6tQ/NAb9sGJnXb3xzjHligFVFNY14v5R5bda/RVuCaFHFHE6Le773X7/0NhSTBjhoonHNK0Fmobr+vkgOLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLDdoZvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12790C4CEE4;
	Mon, 28 Apr 2025 20:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745870703;
	bh=JUAjh8uOOoE92HNSZYb4XPtIiW2gP/0nvsrvkA3azJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLDdoZvViSQNZPCmbGifNhqt9CXGbVsj9eUXgNyeb5QuiGBxuE9QF+Qb5o4fbDtY5
	 vcsOdQL8wHDEb+3phfeG892at01UvRYBh+xm+dnNIEupXien9CUOoSL84zK4dlLTID
	 zfaKaaUWGIG+dPCJCcokl/hah7XZSTwUjTbCI1yQFk3JRK/onh5i7O5wwewgAYwevR
	 jat2bT5V6wUzAMsWdt1Kxg2U5kruLKKsOWEoHT7a3GEEPyuCzD3EnO7WpTVomQnGds
	 qWLYSJFkdrFvtOiYNStk4E6l8tPa+fUPhEp//eqduWVAJeIorGG1iQjzX9cFqpBz0e
	 HZt9mqSnA5suQ==
Date: Mon, 28 Apr 2025 21:04:57 +0100
From: Simon Horman <horms@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Yinjun Zhang <yinjun.zhang@corigine.com>,
	Diana Wang <na.wang@corigine.com>, oss-drivers@corigine.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Mohammad Heib <mheib@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nfp: xsk: Adjust allocation type for nn->dp.xsk_pools
Message-ID: <20250428200457.GN3339421@horms.kernel.org>
References: <20250426060841.work.016-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426060841.work.016-kees@kernel.org>

On Fri, Apr 25, 2025 at 11:08:42PM -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type "struct xsk_buff_pool **", but the returned type will be
> "struct xsk_buff_pool ***". These are the same allocation size (pointer
> size), but the types don't match. Adjust the allocation type to match
> the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

