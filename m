Return-Path: <netdev+bounces-180561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D611A81AC4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2105C19E1C75
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D032940F;
	Wed,  9 Apr 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAaqDJSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353251DA3D
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163977; cv=none; b=kqACNdITmM4GuiZrsGMV73pVPHsLl0o7PA5ptyOsD+FQvIvQjqMX1rfzJp3yH5EMKKEFRnJS3jzUqoo3TcO8ns4yBdqQBwGn2yU5bDAGRB0a4KcH4UeCmfS6MOtoOzSibzl/agEjgFQzceCfkXJqV97vjcNUbr7kCI/y8xGNy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163977; c=relaxed/simple;
	bh=dUbgiwi8QYH5Ef1xOpnCU+fga3tgSmmfMn7B6CQc0VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlIc09TtdoQPTsh5WcdrBJ3UMru/iQr7ElrszhwTaH+nSgf1op2qhPnbw6Ha+5H4xFTstQnzkxjZH93UJctgoHJi5FumlK9KCV0WBXwO/L30i2fNfLcsr3TmtKot31zE3Ituzy4PTpxG9N1feT1uhuNjrtivXAvduVwJxgDwh/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAaqDJSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F006FC4CEE5;
	Wed,  9 Apr 2025 01:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744163976;
	bh=dUbgiwi8QYH5Ef1xOpnCU+fga3tgSmmfMn7B6CQc0VQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vAaqDJSZ9AeAEJ388ZO2uOrpKBi2ZR27pqcyjbT3ITe2GXiPmYG71+spYBikTJLJj
	 +04kys8VQwwvZnHoO2g/wpVIyczWIl1HTE5XT8P1Ym0dUphdCN2WFFbJgaiPeRT2Gw
	 BiMJuEraq2V2pLR+AWL++ZL3vvER6UL5x9v86LeYklXTJnpwYzAzPjIhZD730mrPi4
	 mNEZoHSAOCRMWhrYrNT7NGKKHQltWprYZsLcQxKxJHd5OfAYdY0bFRN2xC0KpZoIex
	 4/bokdor35vAHkOPsf9Pe1+1LapVQgfhQqs+a4LUgRU/p+ja6snguFv/CeSFcDNtC2
	 oId3jBoSKB74g==
Date: Tue, 8 Apr 2025 18:59:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 netdev@vger.kernel.org, dw@davidwei.uk, kuniyu@amazon.com, sdf@fomichev.me,
 ahmed.zaki@intel.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH net-next] eth: bnxt: add support rx side device memory
 TCP
Message-ID: <20250408185935.2984648d@kernel.org>
In-Reply-To: <20250408043545.2179381-1-ap420073@gmail.com>
References: <20250408043545.2179381-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 04:35:45 +0000 Taehee Yoo wrote:
> Currently, bnxt_en driver satisfies the requirements of the Device
> memory TCP, which is HDS.
> So, it implements rx-side Device memory TCP for bnxt_en driver.
> It requires only converting the page API to netmem API.
> `struct page` of agg rings are changed to `netmem_ref netmem` and
> corresponding functions are changed to a variant of netmem API.
> 
> It also passes PP_FLAG_ALLOW_UNREADABLE_NETMEM flag to a parameter of
> page_pool.
> The netmem will be activated only when a user requests devmem TCP.
> 
> When netmem is activated, received data is unreadable and netmem is
> disabled, received data is readable.
> But drivers don't need to handle both cases because netmem core API will
> handle it properly.
> So, using proper netmem API is enough for drivers.
> 
> Device memory TCP can be tested with
> tools/testing/selftests/drivers/net/hw/ncdevmem.
> This is tested with BCM57504-N425G and firmware version 232.0.155.8/pkg
> 232.1.132.8.

drivers/net/ethernet/broadcom/bnxt/bnxt.c:1262:14: warning: variable 'mapping' set but not used [-Wunused-but-set-variable]
 1262 |                 dma_addr_t mapping;
      |                            ^
-- 
pw-bot: cr

