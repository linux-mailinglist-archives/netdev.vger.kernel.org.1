Return-Path: <netdev+bounces-108459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC69923E70
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2958E28669A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B199819D085;
	Tue,  2 Jul 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9wSPt8X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F716C440
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925827; cv=none; b=g4KzTw2mR7/pv8G5TdQ20VNO6tcidWNkCPIsNFSmgR/jIfWG88QRTJ6rMQzsUFBVhxQnlqDUzqdp580cxUT/HLWQyJtS9bxrAwK15Ec8q0J6Se4eHlG9hDMUtmnMfd302IJgKpBRzSuA4lXXXvkku+cE1zpOHWvSnTSIzvluB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925827; c=relaxed/simple;
	bh=KvmMqBl2LR9E7TK2irMnk6b222EBoH/fXyHGj7GOem4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mv6cPVBg4v0YcGNmMKIUiK65VhEC+OZ+avJlrXp9k1H1dWTFcRXnzwWFLq7L7rX4epB00bHSvWtZl5h95g3JXv85My2mGQ5i80i4QEaT0SuM8q7b57TPeQOsI7NgqQY6EgvkiO/weiMkRwVP8uhE/wT7WGdjj82LmEQgRjSxPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9wSPt8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64617C4AF0C;
	Tue,  2 Jul 2024 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719925827;
	bh=KvmMqBl2LR9E7TK2irMnk6b222EBoH/fXyHGj7GOem4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9wSPt8XbzyRLTb47hAbGjXv/RWl5m1Rv3S3DCYXCDn+Y/TLR/EbOCsCFR5lJgZNu
	 lCMzY4M77YRESYEYhcHr51ObxmU9e17WKWAnIcNh6MBlW/bANh6uUe6dv83R8E1KjD
	 n9MqC50GcpLIz6Y+Iovl1M5eVH6teBYSRSNkLY/l81ap2nDdMks7+qUoNUonXqTBGO
	 4ewr02NFuaVvCNTH3ngmVOwhgPxC21R5Y1nvH9KrzXAtJBScXkpTebZJ2ouMFNlR5o
	 plAyRPVHE0Tu0N6kuRk3HBtZd7GkUb/ruu788uTRQx9nkel+k7OVFFbg9qLc7g8VOS
	 ypc8fW0JJ4xrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53E49D2D0E2;
	Tue,  2 Jul 2024 13:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: allow skb_datagram_iter to be called from any
 context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171992582734.9361.8796883322359433395.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 13:10:27 +0000
References: <20240626100008.831849-1-sagi@grimberg.me>
In-Reply-To: <20240626100008.831849-1-sagi@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 26 Jun 2024 13:00:08 +0300 you wrote:
> We only use the mapping in a single context, so kmap_local is sufficient
> and cheaper. Make sure to use skb_frag_foreach_page as skb frags may
> contain highmem compound pages and we need to map page by page.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com
> Fixes: 950fcaecd5cc ("datagram: consolidate datagram copy to iter helpers")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: allow skb_datagram_iter to be called from any context
    https://git.kernel.org/netdev/net/c/d2d30a376d9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



