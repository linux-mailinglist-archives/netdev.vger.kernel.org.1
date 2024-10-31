Return-Path: <netdev+bounces-140585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A362B9B7182
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68EA4282618
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844DF43ABD;
	Thu, 31 Oct 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS771gIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6220241C62
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337028; cv=none; b=A0KBcxuYfCANojhEbtCgwr6qeTJOFeVoIa0OFSHTk2kMcidB3Nnxwe0Vh7TYJlp1bHT5oYuvOJBK0YUlg6CGJcxnhyuouWaFLi19qk49bWKtR8viac+qtXem3auyU2V4VtxD2ymCbFJbA/XCC5usPpajTVTllZ8p0oH0RJW8WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337028; c=relaxed/simple;
	bh=xIFemhMMsAnBkh+qIECbCkAFwd/1dR5mLwBy2//qqqo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kGQf/IdjAG0z0FpAn5ss3LH9MJ+XeaWeBksF3D0Xq7TXpeH7wqEtHu84xbV2zKF7QuuXaK2GXjesAEuZeHF1+V8MgowL9Y5OYAmYgwzed3W21lhSnYxfI7Xawr39ehW2A4w7ZzqpTYeCW4xGG++7JHF3jb5n/CYcCId7iFtMBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS771gIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53DFC4CECF;
	Thu, 31 Oct 2024 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730337026;
	bh=xIFemhMMsAnBkh+qIECbCkAFwd/1dR5mLwBy2//qqqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IS771gIBtnCdvQW0TD9oBUjMbzY0Y9PXkFyR4J66wkSVyolfhGRMNEg/EAtS3tutu
	 Q8ybBeHQHK94qW5kS3Lv8xTwsQFo59veVdkWpGI3JN/aDGUrpEUYCj5Zv7dNsOdRzk
	 fjjFu+a+bq6Ndkqmpk5YhdtFrvqNxzwm6pTuHqJSOLuyAsyKxp2msJb8oqpEfXySZf
	 qUwwHFmKVNjY3C5p2hobT8Ga0ElY6zo4Tqr9jmQltHnrrfbKpM2nd6YSpkoxOc0cy8
	 xEycJEt/fBsFW88XRCBbA2xmZg5oOy6OdHpADa2AqOn00HOysB3CB2hivVAowe96LN
	 kDYFNw+YBiSUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB014380AC22;
	Thu, 31 Oct 2024 01:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: change to use page_pool_put_full_page when
 recycling pages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033703450.1512423.3734049278634147857.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 01:10:34 +0000
References: <20241023221141.3008011-1-pkaligineedi@google.com>
In-Reply-To: <20241023221141.3008011-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 willemb@google.com, jeroendb@google.com, shailend@google.com,
 hramamurthy@google.com, ziweixiao@google.com, linyunsheng@huawei.com,
 jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 15:11:41 -0700 you wrote:
> From: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> The driver currently uses page_pool_put_page() to recycle
> page pool pages. Since gve uses split pages, if the fragment
> being recycled is not the last fragment in the page, there
> is no dma sync operation. When the last fragment is recycled,
> dma sync is performed by page pool infra according to the
> value passed as dma_sync_size which right now is set to the
> size of fragment.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: change to use page_pool_put_full_page when recycling pages
    https://git.kernel.org/netdev/net-next/c/4ddf7ccfdf70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



