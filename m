Return-Path: <netdev+bounces-135940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC0499FD63
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1A28691D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13D101E2;
	Wed, 16 Oct 2024 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaMI/+1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798394C83;
	Wed, 16 Oct 2024 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039824; cv=none; b=hMIyi5VwPD9OfxeyVsr2ZSp7/jY/0IbWT4Rug80UIUxmFbADdILFzY6ZwNoVO+/85vTeaqd6q/gp9TsYNEpO5rpqJq5axqEndea6qyEbFmFxU0bZwz+D/TXMnU/6JWk5dSQxfX4hNgwiEiG5ceVwYfDMhvIEerMhGbJSgQmJGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039824; c=relaxed/simple;
	bh=OjQsy01S4SAOFsRrQsVTMzz/QzolhEVuiqp+rLZQnpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t0RKYJONOVyZwb7Fn5+bRECSN5KFkGlEan9RVAwq4PEI0v8awOn7JqRzSCh6s/9WSUcc5XSh6FtZTGwI0yh1irgEkmoWRgqyChIWMmq1JanAtY56U97rZ8/W6SbhWmZTbKXC4t/9mjLbnLCLx7x7pbOx+Gmlq4XG5Epr3nBtkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaMI/+1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA1CC4CEC6;
	Wed, 16 Oct 2024 00:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729039824;
	bh=OjQsy01S4SAOFsRrQsVTMzz/QzolhEVuiqp+rLZQnpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QaMI/+1IZw46i6Um9bMYLLsbo2ktLw+067uQ42n2ojQzZJL7zKXlNH7OQT9FwjNAs
	 m5+fYFtxPRfyY9puRbB+/8r/h0tbufP7heic4JEg+y1IKLrJm2QUdpQaCbVMqdNjoA
	 KGtiIidoiqeI2Re/k2qrzNk1kJ7b38K4y/zhSzGZ5USL5fK25XB69naPis5vORBvNl
	 YDpZmwT2EC6I6aH1N8bRNzfUiW/JrZLV3MgNKq8IjWTBOrCFB8IiXo0BMzL+w0bYUK
	 sLo5dM8u2+2uObDp92EVhy336YNGFfHM59Qhqz2RuauQbnIFenliR48IQSy5cRiuuM
	 wDGV8UwP6wj8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 725993809A8A;
	Wed, 16 Oct 2024 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bcmasp: fix potential memory leak in bcmasp_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172903982926.1341434.16705230415476554959.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 00:50:29 +0000
References: <20241014145901.48940-1-wanghai38@huawei.com>
In-Reply-To: <20241014145901.48940-1-wanghai38@huawei.com>
To: Wang Hai <wanghai38@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, zhangxiaoxu5@huawei.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 22:59:01 +0800 you wrote:
> The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
> in case of mapping fails, add dev_kfree_skb() to fix it.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] net: bcmasp: fix potential memory leak in bcmasp_xmit()
    https://git.kernel.org/netdev/net/c/fed07d3eb8a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



