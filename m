Return-Path: <netdev+bounces-211850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F83B1BE35
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54F617E2C7
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 01:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C1313C9C4;
	Wed,  6 Aug 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9I0GcE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518FEA935;
	Wed,  6 Aug 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442888; cv=none; b=Yh5y7fsTxEr+4lUWNiTtTICBBdzFB1Z58LXz1lop2imvZwOLC2eo5j4hpYcQ1/icXqFjrmDwJ/moVyCl+Aro04US1mSvNPRuiOnXFlg12nTLRuKD6K8Zsc9m0IN+DB1btyy61P64n/MkcBACdnrMcipWY3Y3eYGhO4SwlVHrvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442888; c=relaxed/simple;
	bh=DeKwr281iVQbp6yRLeDouxi56CW0MsFXgIhnGMHe75I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3MJxU9OLbw1PWkKGHD6VxEzAR1hDx+PuFD3w8cX1kZzw75uKkjNBRZnhHBcEMCx8x+EXCNAI7pr/txC2bgvooBD79yiqyae3a/15gtS8gqEw4roJv6SeHJtsEIpqL+6IId5I5DtG8mo726Yojmt24o1qy6gpqcfjQA2fmpB+h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9I0GcE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E31C4CEF0;
	Wed,  6 Aug 2025 01:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754442887;
	bh=DeKwr281iVQbp6yRLeDouxi56CW0MsFXgIhnGMHe75I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y9I0GcE5V2PNs8RMKo4irgV32OCh1HqPhjDP5nZTpQg54U245ZXkvvygIjtlRaaxl
	 IdlNYsGP2JKvV5//FhOLXJOovcYWfWwYWrfDGCJc6kM+QfIEY5+Vy2fghxmKL5rK52
	 fma1yQS6DhDBIKwWlEZ4BM6vVDr2KFIyYKlwLg5phpbLuDeYWfegIFEJJZgmMCxOr9
	 sNjEAUK2a7YB/gngZecx78O+i8r96yC+0fyh7fVCDZeMcECU2BisxuiWsKwhQ3kVFO
	 2UCj7qNXBcMpw0VkfVGhPUn6QzQ67tdUA8hafKvX8n9lKZjsgQSS4ioAZIk76njsCB
	 MC/2yNo15ipFw==
Date: Tue, 5 Aug 2025 18:14:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 2/3] net: hibmcge: fix the division by zero issue
Message-ID: <20250805181446.3deaceb9@kernel.org>
In-Reply-To: <20250802123226.3386231-3-shaojijie@huawei.com>
References: <20250802123226.3386231-1-shaojijie@huawei.com>
	<20250802123226.3386231-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Aug 2025 20:32:25 +0800 Jijie Shao wrote:
>  static inline u32 hbg_get_queue_used_num(struct hbg_ring *ring)
>  {
> +	if (!ring->len)
> +		return 0;
> +
>  	return (ring->ntu + ring->len - ring->ntc) % ring->len;

This should probably be a READ_ONCE() to a temporary variable.
There is no locking in debugfs, AFAICT, the value may change
between the test and the division / modulo.
-- 
pw-bot: cr

