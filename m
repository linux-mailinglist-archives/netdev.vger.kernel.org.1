Return-Path: <netdev+bounces-239320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97040C66E23
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 346EF355EDB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E9D283FD4;
	Tue, 18 Nov 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djA8dS7i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8C2676DE;
	Tue, 18 Nov 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763430603; cv=none; b=b7StLPmCPJLym2YJ4hY7FfbBl6xgDKQABoDdk+xCDHIQRAbl4DazYeFq2Cfk0nyRsbysLdVcUwVlgsTC4kKIMLG0CTqjT79o1tUWOz5bhWDzBxAFUvniyCiNoy5Mbh6J8IhuBu0tnOAMAKGtlqc5Y7eNyJxWEeFBArp3/7jd564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763430603; c=relaxed/simple;
	bh=6jYb00Rg+QqlouDdqRwaPBR8YEy8vHrsSdTzuB0wZ3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsPMQsvmMRXkQ31UdxAVOpQIl1V5lCan1cM5X6cZ0Mx+xRlLMCVyYWFVLfES7uvLRX/hKxdNQKjvuY0ftDEtJd6BijteLdqyAGw7b8mTV/57Z6zUH8rUhIguWIMUbqxCg2lGtT+SNABg2Ip0zjH7uKEYoevQxIAOhCfG4+J1IFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djA8dS7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D54C2BCB5;
	Tue, 18 Nov 2025 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763430600;
	bh=6jYb00Rg+QqlouDdqRwaPBR8YEy8vHrsSdTzuB0wZ3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djA8dS7i4h2Gc9473G22HIV5xJ6Moddt2eUSEEBOs3Dmwl7fn4QWioUaU0YC/FlXW
	 ZeZ3ul6sTwdv6YeouaIZkclDZNbClS6+3x9RtQ2x5VKNO/BxkEKAV2VQx+yGG+2k97
	 dKlMniT2quezBLEiNEtBnUevW0xW8Wy0Mw0BXS85eaW1y6OZZDn6vCIfCqsIwJEtdU
	 fbkKsIqhxbJQzBy7txLaAvTaAkOBJfKIZV/dLjHOp5RfsMFXfFrtxg99CZrJQ4yG3T
	 yCVKo2w7kKCfYAQRCqACzZHZ4sbXTYr4nh15Y7eHWuo3Mlss9zpOym92pxaZtPnbrk
	 PXSB+336A1exA==
Date: Mon, 17 Nov 2025 17:49:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>, <lantao5@huawei.com>,
 <huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
 <jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: hibmcge: support pagepool for rx
Message-ID: <20251117174957.631e7b40@kernel.org>
In-Reply-To: <20251114092222.2071583-4-shaojijie@huawei.com>
References: <20251114092222.2071583-1-shaojijie@huawei.com>
	<20251114092222.2071583-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 17:22:22 +0800 Jijie Shao wrote:
> Support pagepool for rx, retaining the original
> packet receiving process.

Why retain the legacy path? Page pool is 7 years old, all major NIC
vendors had dropped the support for non-page pool Rx path at this point.
If there are bugs or performance regressions we will fix them and send
the fixes to stable.
-- 
pw-bot: cr

