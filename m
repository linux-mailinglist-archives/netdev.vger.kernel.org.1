Return-Path: <netdev+bounces-209225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E79B0EBE6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E181F54423C
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367792737EC;
	Wed, 23 Jul 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ9VprkW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE58273D6A;
	Wed, 23 Jul 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255746; cv=none; b=tLWmaxdZtZFCH+PF38dlPvJPn3ZKEZgzEbIhE0eWL94Eti4twLkd/eVMaoXNYS76iyyw6UOj+C55yl+LKq6HuZ5Lz+Z2N5dnx+PV006UwfPR7IYJQxQevXTl7zAX51O26Y91vc1hcBuS/hk6HZnBT8WdhOwAoHRFXZ/fZUhGahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255746; c=relaxed/simple;
	bh=xF8Pni8rJCxkZ8VtQYcsNsFSmJ4XavgHmbqmuA+rrJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHaJZDqcwCNa1lVvbDd7PYvfAZVpk1TywHjKa4lPynwTSQqHPNsD9yJ2uEUyUxmeG15NJEd+O03cjRyd3mJDPF7+oa92IsH521ZAn1QZ89zXco/de9YjEMQ4LwWMhyzFWyEKe/56xJBxPGSV9dAYXZmX7lUJ1LGznevc0Ti40Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ9VprkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165FCC4CEE7;
	Wed, 23 Jul 2025 07:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753255745;
	bh=xF8Pni8rJCxkZ8VtQYcsNsFSmJ4XavgHmbqmuA+rrJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQ9VprkW2tbVKWFFhQJjT7fPdPdVoBrrTvhyfcQ+Zq7WTfLRUIt9cTYyCj0lzPzVE
	 kDYhrwwvWgtemaoenDfnp7qhz5nwgBuNwyOW2jKqiiQ2LNdlt3A9z5n/RIsgWxjfyy
	 xm7ZUIozwbWt630bb7cTuxZiQg+XqueTywboVhdFBqnaE1AgbTkA1lc/0YxNgv1PaR
	 CIMaW5gXUDkJcQ59N3j7nPTkhfB84OvILgGtOr4Sf0VPtMcxEjuNYbvx/mGlzulj0s
	 B+fIq5TnA9tvwa5TCs2n4Y7i5yTSk5Flb3IX50omU5FdUEBOY53s4+HsdcKEj00Wzj
	 qWLJNuT6WE21Q==
Date: Wed, 23 Jul 2025 08:29:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 4/4] net: hns3: default enable tx bounce buffer
 when smmu enabled
Message-ID: <20250723072900.GV2459@horms.kernel.org>
References: <20250722125423.1270673-1-shaojijie@huawei.com>
 <20250722125423.1270673-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722125423.1270673-5-shaojijie@huawei.com>

On Tue, Jul 22, 2025 at 08:54:23PM +0800, Jijie Shao wrote:
> The SMMU engine on HIP09 chip has a hardware issue.
> SMMU pagetable prefetch features may prefetch and use a invalid PTE
> even the PTE is valid at that time. This will cause the device trigger
> fake pagefaults. The solution is to avoid prefetching by adding a
> SYNC command when smmu mapping a iova. But the performance of nic has a
> sharp drop. Then we do this workaround, always enable tx bounce buffer,
> avoid mapping/unmapping on TX path.
> 
> This issue only affects HNS3, so we always enable
> tx bounce buffer when smmu enabled to improve performance.
> 
> Fixes: 295ba232a8c3 ("net: hns3: add device version to replace pci revision")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - Split this patch, omits the ethtool changes,
>     ethtool changes will be sent to net-next, suggested by Simon Horman
>   v1: https://lore.kernel.org/all/20250702130901.2879031-1-shaojijie@huawei.com/

Thanks for breaking this out.

Reviewed-by: Simon Horman <horms@kernel.org>

