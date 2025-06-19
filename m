Return-Path: <netdev+bounces-199407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F124DAE02AC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44103AEB09
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA750223311;
	Thu, 19 Jun 2025 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT8SanKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518A221DA5
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328979; cv=none; b=cK7hMACHf7Z/wvb/8ii54lb9vdDMz6xHyZFTvFKySvubjy9ViQ6eY5Nm64gzC15iPGV0UV10jo5gZyopQeBDCEooIDahGB4ROU8+JvY8ZtMyBOkZrj3bL1lSYT/yaP3FTvV58bL+NMowEuo1la53GuJUGZz+LCvvDS1J1X3MYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328979; c=relaxed/simple;
	bh=sOwwOqy8YeaW5YgxiJKGbO7bQyaG16hCKTSWCcCeGrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I0WqxoltoQWNaI1elEo95BSfR6rIe37oppWhheZWDrl3ZsJS1OQdRBYWDSfZk4LKdlLRnKy6HRu+BTeKQhtIiG2zKeGefdMuQK6LqWglxQ6xkoRwd3DVhqkwN+SOoji0fjfNMsXuERjfa+kU7RCRB31DDihaYsu+Mmrlhy1P1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT8SanKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2281BC4CEEA;
	Thu, 19 Jun 2025 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750328978;
	bh=sOwwOqy8YeaW5YgxiJKGbO7bQyaG16hCKTSWCcCeGrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AT8SanKfEIVlTubORVtS4BkF/QEHtPAlvDRql3ma/z8Yzk07O2bTjkSAahAsLafpl
	 YqTGuSiWqt/UsCUGyQhI77bKjIm6dNeMhdl50YFEh1FlNqj/gvwAbrIO9FPSpzHSSw
	 YwB607G11EjpDUNm/1K0DIIXiLboHVo7flvVprT/Kj37XwElI55fJWqTYT3q2t5Azd
	 5IrMxajpe83dOKvERZ6fUV33XhZZSAx5Uu58pWA413l8ldljTe2sNTxcLETAwGtlJj
	 3JNUhZdYrzKBWrM96GOQilYII4Ze4tog5gKGx93bdi/pt/NmBfXBPIx1/VLZgW0ZCJ
	 Ww99GrbizquSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B443806649;
	Thu, 19 Jun 2025 10:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: avoid double free when failing to DMA-map
 FW
 msg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175032900625.449869.12314876309159391776.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 10:30:06 +0000
References: <20250616195510.225819-1-kuba@kernel.org>
In-Reply-To: <20250616195510.225819-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, lee@trager.us,
 jacob.e.keller@intel.com, alexanderduyck@fb.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Jun 2025 12:55:10 -0700 you wrote:
> The semantics are that caller of fbnic_mbx_map_msg() retains
> the ownership of the message on error. All existing callers
> dutifully free the page.
> 
> Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: avoid double free when failing to DMA-map FW msg
    https://git.kernel.org/netdev/net/c/5bd1bafd4474

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



