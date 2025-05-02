Return-Path: <netdev+bounces-187409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D600AA700B
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46AF3B35BD
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0357C231821;
	Fri,  2 May 2025 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjaHiiPH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223279D2
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182953; cv=none; b=FhTSG1gV1s29jCIK7aff8eNzvX+mSLcyVhU3yW2C2pPalkfgvZmXcAm5WgkT/wleDO1S9LKcDtGGTzRE3udNZXzfC/gjsORt1m8vrS6Il2dzRzmJYbNO5hcimH/49dxWYPFvnMfiLjr3o11QFk15lQ8qOcraxIZjUUDwtDMQEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182953; c=relaxed/simple;
	bh=ghIBx2KDomgMKduOP3stdxxsNuip9x330I57qzH+3xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4ijLw0F1JvTzLjZtxQlYtn/toSM2+JaQekyZ3Z7pTJJUPCeiGKX+rtbhjeu9SjGSNm8L/6C7/GgpE6VzEO1n3tEbdzUoRy4Cy6MpplEeIv6EMqG8bGmFD06sR2K+rOhu9AWnmuoXUPyAVccoX3bGcGD3aBzyal0/GkqH9YBzi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjaHiiPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF61FC4CEE4;
	Fri,  2 May 2025 10:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746182953;
	bh=ghIBx2KDomgMKduOP3stdxxsNuip9x330I57qzH+3xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjaHiiPHPy369p4AeFFb62y73FkL2w1zY3K6e8WMmBmMdT2DYVu+fMz3E8r14Gk+Q
	 pd8Bful1EmfqRL8R5IXAcGsDcnevyZynD+bLW7UmTqw6im+PKqCQE7kmsFmTDXasDG
	 R1whZEH3j5XrthTrXAGk652mN3XdhOpaNYrpc2SHPjKh3/ALvwFrOcEn2M3sM9ZfRD
	 sqsvYRdLkWUz6/dG/WDkMq/b1HSmhi3yCJrNQQUX/9DX3MayanFQgbSEU7J4FpebBv
	 pjMBIDjuWR0d5Eb5q6MmHq2AwE32AmXmEcYYkRUzNa5oHV39aTHA5QSpTZut33k6+q
	 jVNtwuFnh5EcA==
Date: Fri, 2 May 2025 11:49:09 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net PATCH 1/6] fbnic: Fix initialization of mailbox descriptor
 rings
Message-ID: <20250502104909.GI3339421@horms.kernel.org>
References: <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
 <174614219719.126317.5964851599064974666.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174614219719.126317.5964851599064974666.stgit@ahduyck-xeon-server.home.arpa>

On Thu, May 01, 2025 at 04:29:57PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Address to issues with the FW mailbox descriptor initialization.
> 
> We need to reverse the order of accesses when we invalidate an entry versus
> writing an entry. When writing an entry we write upper and then lower as
> the lower 32b contain the valid bit that makes the entire address valid.
> However for invalidation we should write it in the reverse order so that
> the upper is marked invalid before we update it.
> 
> Without this change we may see FW attempt to access pages with the upper
> 32b of the address set to 0 which will likely result in DMAR faults due to
> write access failures on mailbox shutdown.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")

nit: No blank line here please.
     Likewise in other patches in this series.

> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

The nit above aside, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

