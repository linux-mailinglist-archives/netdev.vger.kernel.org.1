Return-Path: <netdev+bounces-135973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474499FE1B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19911F24139
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D12AEE1;
	Wed, 16 Oct 2024 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAtj5zYX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602D411711;
	Wed, 16 Oct 2024 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041419; cv=none; b=G1MXhOKOYp54h1NdMWJqWNFnA/jSWO4B0BjV1RZRaiJClkuiVqbCx/A/u6e7NoRw9/cVfXtEmVNJ3o+/P0tSwVvL9oJFo1hN8MIl2X8493tNrxuWRaEPFFVYCLHtOuwRL5kzcJKBWovL0yqD7j0lV2UUMtjdYRKR0KvkHW50+nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041419; c=relaxed/simple;
	bh=ZZ0pEuBlmRW8FNRXada/4lSdbqHqnYDwqQfJu7KD4M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUjaBu9ym0YYsHKpiVJWKy3ChyogrKcZWFRJrvvtAH7hCJ/W6E89A+PdlSouvi5wfCxxtlAnUCwyrQ/RskzI1M/4Bgirs2+opaLERCxQB4vzqRI+yi1/+3CQ03rpWNYb1/TRtjd0SK/Ng7aihlO2FQmdoj1e4VYQ90uTDU6MLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAtj5zYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC0CC4CEC6;
	Wed, 16 Oct 2024 01:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729041418;
	bh=ZZ0pEuBlmRW8FNRXada/4lSdbqHqnYDwqQfJu7KD4M0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAtj5zYXdcOBVSGyA3Isu5LshmdG2Vd+Aj3ZZ1C6SxGE0UMj09wU7tmkYktpaISFq
	 owRP5TYMRmNujqMxr/3kaXVyJDfHK9hLEsG7w5/XiDLwrYheP13Ww2aEZ+q5vLGRuA
	 LFczZ+sA8P6cINvuVpeq5s3DV7oDr2e/svnF1nW5Lw/cU6hb+hPZLhYbLiIDYps5lb
	 wyIlj13cqg9Wd7Pno/VcvZfKe8OwAuIUjcZ+IvZfAMbXSg46fTaOaKKrNwtZPRYB8w
	 OXWh7iIFgbmzLGJwp0HrP6CRC8Lv/94E576NP20d9Bo5Kjdd3LkvhcoU1vGbdHn+7K
	 oyEaj8j4Y4FYQ==
Date: Tue, 15 Oct 2024 18:16:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
 <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <lanhao@huawei.com>,
 <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/9] net: hns3: default enable tx bounce buffer when
 smmu enabled
Message-ID: <20241015181657.14fe9227@kernel.org>
In-Reply-To: <20241011094521.3008298-2-shaojijie@huawei.com>
References: <20241011094521.3008298-1-shaojijie@huawei.com>
	<20241011094521.3008298-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 17:45:13 +0800 Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> When TX bounce buffer is enabled, dma map is used only when the buffer
> initialized. When spending packages, the driver only do dma sync. To

packages -> packets

> avoid SMMU prefetch, default enable tx bounce buffer if smmu enabled.

you seem to force it to be enabled, rather than just changing 
the default. That is strange. Why not let the user lower the value?

Also I don't see why this is a fix. Seems like a performance
improvement.
-- 
pw-bot: cr

