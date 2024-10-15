Return-Path: <netdev+bounces-135825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F34DA99F4C0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A7A1C21A1F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD01741E8;
	Tue, 15 Oct 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvnJq8zD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6634128691;
	Tue, 15 Oct 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015397; cv=none; b=YUTKth3s+TvZuhgz014OHoR6nzFxjTWnkZE27Q45/UCIe0NiJ+tYQMkILRKbh0WixmK/mVLe5MD/MNd9S8Px5qqQkuUZVFrZZFdRGbvviXGNDtz98VSyqMuGupl5xDdF1DfTxrw7FontgvGo15SCvwwrPgL2eQAL6gO2vopV7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015397; c=relaxed/simple;
	bh=o/aJS0/LYG9c2sdC9oTn2XOXUyj9Lkx1jfFKhJxZk5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2gPO0zd+tQLZMDxelmmoY4WCPxInCENjEtoPrWoUcWSXlEpgoNTI/v7s8L/QqoDaLD9mj7+aGMD5Qkjin6bPjMyOYR1avvGkk+KSTm11SI4GQjkhi3KUwqBh9Gv0w30RQbDU7qu9Jl/zwz5acbstnHEfo39k+zbYx3t8xlS580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvnJq8zD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1356C4CEC6;
	Tue, 15 Oct 2024 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015397;
	bh=o/aJS0/LYG9c2sdC9oTn2XOXUyj9Lkx1jfFKhJxZk5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LvnJq8zDZyc6KGEkDCK7XhpD7Iu6m5D//1huhbDljHM+/t/tFOQbkmh/D5GMkMvB+
	 st07TtmPxsb1kFx5W1Onu9/fwrf9uNG+dtxQQfTF5vRKCpkiRItD6+NhRSe2C8cYOh
	 Iz4XXp5pVPQW9vsTfNQBVIdKVeyVGmVb/RqFY6hTA9DpPQKX00pFrKzDBeKzDDCu1H
	 0T6sGbK8cTIntGZt4aGREjb42V2O7+558ZgSA2WgqgPFEqyLYfvO+ocE1NFDY2q4uA
	 C21D/aAUy7MDYSGUrWlGI+18lUoCGx8VdDeqncGNRAF1RE9xlqVaR8oe77kdsCj344
	 CdYSMKO6zOLug==
Date: Tue, 15 Oct 2024 11:03:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Hai <wanghai38@huawei.com>
Cc: <florian.fainelli@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <zhangxiaoxu5@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net] net: systemport: fix potential memory leak in
 bcm_sysport_xmit()
Message-ID: <20241015110315.656f5f03@kernel.org>
In-Reply-To: <20241015143558.939-1-wanghai38@huawei.com>
References: <20241015143558.939-1-wanghai38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 22:35:58 +0800 Wang Hai wrote:
> The bcm_sysport_xmit() returns NETDEV_TX_OK without freeing skb
> in case of dma_map_single() fails, add dev_consume_skb_any() to fix it.

Technically you posted it 16min too early (23h 44min) and I'm not sure
this is better than v1, see the discussion there. So I'm discarding
this version.

