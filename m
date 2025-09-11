Return-Path: <netdev+bounces-221908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947FCB5252E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD3D467510
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524E1A9F9E;
	Thu, 11 Sep 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb62S9Ri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7719309E;
	Thu, 11 Sep 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551962; cv=none; b=k7nGNK/vsZ+pEpl4FfSvzMxpcwbP09efmyn+Kurr0x8DZ5K2FQNqLVcYUi6uiq+rHZdLVNZgq9UawtkZFR3ZWyYE5e7y5ycUojqbyiSywi4UqAiKfZ1uQTZQ8BppWMcfboyDWaq5iGJGTvsITYhsm0GYtO6wVSi3SfZxgz6iBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551962; c=relaxed/simple;
	bh=V8xpZ+8EhZp3so4fvB8IMMv2kOizosAzyULq4a4Whcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtMK4paxvEHxMxxbLRw6sWdKG0Xhe5YlSnkrUNQgEeuuMukWxKeWKN3LhcPVKtTS8Dn0G/2/XPsw30BlWdYfrGSOhOB1oJG3CLlrI777u7Ug+x/CmNeTAZ+I5dHUdaU5bI8T7Yt/6iI7Pl3muxqOYF9P4tSJ1o07Jw6ZiFj9SD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb62S9Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB21C4CEEB;
	Thu, 11 Sep 2025 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757551961;
	bh=V8xpZ+8EhZp3so4fvB8IMMv2kOizosAzyULq4a4Whcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nb62S9RikRNNrxSmYWlXFL1v3AvgVoV4t1QDscjX9c9vNFgqnQ7VBi+/+nZd4fApc
	 aA3gEVEh43XTCU6/iBvtv3RcAgFQQNx6jkTTd+aLrnFl2UONNbfpZxgWcpQEMb+tyH
	 +RzbRdRo8W+YiJ1pfQiJDD3aep5t/lM7h9NlZBtDt29aJhfp9903diIAq2YDy9I2XP
	 eDLzAJfWXEql86JELFzv4QtzPqaMr0AwnEcK0wXDte+DVOezCdTN6p9xJimxTmCb5J
	 PoXWomCPzqHtMGagmxPAFf+NNHL5gE56cWy6nE4TIgmHStvPO9ohbfTtl50FRGdxNO
	 Ccy5hxFvJKduw==
Date: Wed, 10 Sep 2025 17:52:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net, hawk@kernel.org
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ilias.apalodimas@linaro.org,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, llvm@lists.linux.dev
Subject: Re: [PATCH net-next] page_pool: always add GFP_NOWARN for ATOMIC
 allocations
Message-ID: <20250910175240.72c56e86@kernel.org>
In-Reply-To: <20250908152123.97829-1-kuba@kernel.org>
References: <20250908152123.97829-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 08:21:23 -0700 Jakub Kicinski wrote:
> Driver authors often forget to add GFP_NOWARN for page allocation
> from the datapath. This is annoying to operators as OOMs are a fact
> of life, and we pretty much expect network Rx to hit page allocation
> failures during OOM. Make page pool add GFP_NOWARN for ATOMIC allocations
> by default.

Hi Jesper! Are you okay with this? It's not a lot of instructions and
it's in the _slow() function, anyway. TBH I wrote the patch to fix the
driver (again) first but when writing the commit message I realized my
explanation why we can't fix this in the core was sounding like BS :$

