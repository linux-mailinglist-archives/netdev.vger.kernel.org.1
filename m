Return-Path: <netdev+bounces-187467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8BAA7430
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 15:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5AE9C381D
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2942550AE;
	Fri,  2 May 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6kKVWc9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF72522AB
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193917; cv=none; b=fpc5qAeWwaMS0WCw3y5eEx/FibqhTxfiI6R7OYjr4L/QVANiRxB0QDsdK/ZxrsMl+mEf/+WK1uPh+/TGnIfpt1A6lyevvk03CAOfKROAjza2RgyQ0aDI1u9Y8kC90H3FwLYz55byiqTlB9b4VJHaWzbIwKjX/n7PXzjPRld6QBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193917; c=relaxed/simple;
	bh=u0c006iRpQ1vZcMndFKLZKSftLoGjDeSS+yQpZG+y3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy0UZeLqnnpnMz7yZuVG3Y3XqIrCDHfnI0dD3uPeCErLkF3f9LqG9aE1BmPJWO6J1LIg7MMv6G9Sh9x1yx0r12XlHKe4Eardk+7dUFU3bzb0HAekcWokLMih+JlLFlPZNtipbMH/nUy4vKQzOxqulUYBU+NYVvQa1SbaePSMf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6kKVWc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB040C4CEE4;
	Fri,  2 May 2025 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746193917;
	bh=u0c006iRpQ1vZcMndFKLZKSftLoGjDeSS+yQpZG+y3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6kKVWc9B2ECXhiOr4HIXIetYiXCFozRHwTGDPFiN7jgBZzq+2xnLDOgpy215v54B
	 aqtLKJ89k7HjwUZJOlTJIpbeb/1zuDg0BSWsQNnvX67EM/f8RJxXs2Q1mBFW8y8C+k
	 YNSJaPwbRAKxwbmYr3wBddVTz4n1DgygPDl7PlxbbvI7H5Pg92T0cr0SbUwbYwlVRI
	 LhsuoK/W+e/RodpltXzqIRzrEOzKUmBoyUTB0aFGG2nlhglMZApvc5tv7jssFELXCS
	 rAd+1mlBKEEG/zkD7emeU99ujwy6+QioHzJv4IktBJrntF46Ne/1dzPGD7rR3aathR
	 RJeR0S/1ETZqA==
Date: Fri, 2 May 2025 14:51:53 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 3/6] fbnic: Add additional handling of IRQs
Message-ID: <20250502135153.GL3339421@horms.kernel.org>
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614221004.126317.3819743775871203479.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174614221004.126317.3819743775871203479.stgit@ahduyck-xeon-server.home.arpa>

On Thu, May 01, 2025 at 04:30:10PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> We have two issues that need to be addressed in our IRQ handling.
> 
> One is the fact that we can end up double-freeing IRQs in the event of an
> exception handling error such as a PCIe reset/recovery that fails. To
> prevent that from becoming an issue we can use the msix_vector values to
> indicate that we have successfully requested/freed the IRQ by only setting
> or clearing them when we have completed the tiven action.

nit: given

> 
> The other issue is that we have several potential races in our IRQ path due
> to us manipulating the mask before the vector has been truly disabled. In
> order to handle that in the case of the FW mailbox we need to not
> auto-enable the IRQ and instead will be enabling/disabling it separately.
> In the case of the PCS vector we can mitigate this by unmapping it and
> synchronizing the IRQ before we clear the mask.
> 
> The general order of operations after this change is now to request the
> interrupt, poll the FW mailbox to ready, and then enable the interrupt. For
> the shutdown we do the reverse where we disable the interrupt, flush any
> pending Tx, and then free the IRQ. I am renaming the enable/disable to
> request/free to be equivilent with the IRQ calls being used. We may see
> additions in the future to enable/disable the IRQs versus request/free them
> for certain use cases.

Thanks for the nice explanation. And likewise throughout this series.
It's much appreciated.

> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Fixes: 69684376eed5 ("eth: fbnic: Add link detection")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>


