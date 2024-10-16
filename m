Return-Path: <netdev+bounces-135974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2099FE1E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056CF1C23B70
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274A45009;
	Wed, 16 Oct 2024 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j36UDIJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89261433C0;
	Wed, 16 Oct 2024 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041575; cv=none; b=sJEUdailCPlmf6sxl14E/q+FJuFoFAw0bEPD2zEc89l+YgoY5nfi3RxeJvaDpjwV3evrHiEANNfedbnAeJFz1aSecvDjT4QmKKJvRzi/0e+g9zWQUr5IBla1iaio6Rj7s+X/A+WM11u0qfI/A6EzmYuHzJIZ8K3Y2qDwCGjOCoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041575; c=relaxed/simple;
	bh=jbVyCk1AWOwYwLa7bYVHToOePtRemy/kRTRE1MIxC9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9b5GlUmJwIRncJw3n0/7/K6DM5sZE8ovcn0IYglgHY2YIX3iJzzxxc+/CIrhbRxYgIEagNDOQvglbZhaUREtOfIZpNyhiKajbmMF+ghX0aYdG54BrW0DEtCiEnVs0X/u5pPnLukEIobdyfkoG5lHrlbvs0TfSCL4170vZkoTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j36UDIJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7B3C4CEC6;
	Wed, 16 Oct 2024 01:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729041575;
	bh=jbVyCk1AWOwYwLa7bYVHToOePtRemy/kRTRE1MIxC9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j36UDIJfyd6loYlqfrsUM7JuJm1t7+D9dbN6VpfMKaU9SUjfFph+Xg4akphX49Ldy
	 D2dd1ByP9HEjEzK4MiGe9R/KbjuE9qYnUzspahH4NfERXtgacEXQU8jBZNBT/eMhbB
	 tNRmJjBclMwWBzmLdGDHRNrNjs7VeveNu+8YWNn1dnC5Cc27YZMmLyAdqeUt4vZHTw
	 i7DhzWkFPUW1lyBx4CIHF8vKFaDJX1lHc2krLl+Z92TLeUdLCw6iRw7RqBMpCbTeIV
	 Sh5IDrQWjGJxEt+amRZY1RQWW5rcO57NZpfx3sef6tzHCqbf+2UaeMXyqX7C+WXqfE
	 M4oLijby36ekQ==
Date: Tue, 15 Oct 2024 18:19:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
 <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <lanhao@huawei.com>,
 <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/9] net: hns3: add sync command to sync io-pgtable
Message-ID: <20241015181933.3e7afbe3@kernel.org>
In-Reply-To: <20241011094521.3008298-3-shaojijie@huawei.com>
References: <20241011094521.3008298-1-shaojijie@huawei.com>
	<20241011094521.3008298-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 17:45:14 +0800 Jijie Shao wrote:
> To avoid errors in pgtable prefectch, add a sync command to sync
> io-pagtable.

I've never seen net drivers call iommu_iotlb functions.
Could you provide more context on what this is doing and 
why such unusual handling is necessary?

