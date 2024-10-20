Return-Path: <netdev+bounces-137277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C28B9A5496
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0BA282979
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA65E193416;
	Sun, 20 Oct 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO/jpAxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FB19309B;
	Sun, 20 Oct 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435829; cv=none; b=iwSHEJhCcnDTym+OeVF7DVOTPlqGrKVb5MsFatSoN6zI1kHDWCSFI3HMeVjpjTlb9heWzhtjOqPVln3BLP27+S4HlUm8YhUFqsswa6Yld3v2UmZTap3CqTq2XfH1WEW+7QGIRgL6w5xCY+vueXOzSFdmgLri+T/RGBefIH+4GNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435829; c=relaxed/simple;
	bh=RwdXc0L0kGeC5u/UtjJYKNmn2j8aWVtx4yvTRebOT8o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kw1ZldM0B0+Zx68iAVdN0N+zMYMygP6zshttUELQnfqfQ07uG7um7iRGSG8hDbXOPyrwoejPyDGCkLOAmPEHwJiSjKoucKcoBEPb4HB5YOSUGLKhZdpW0s9gNyijwzD4G+5wc2z9oPO46KTRoWyVnW1DiqxrYRDtc0fkIeEg2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO/jpAxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18481C4CEC6;
	Sun, 20 Oct 2024 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435829;
	bh=RwdXc0L0kGeC5u/UtjJYKNmn2j8aWVtx4yvTRebOT8o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hO/jpAxOOuc/2+QZLgMREHGRPAmZ4QWoHqNUyC0chHyHJpXBpUlIWxapZaKud5/lr
	 z/MGl0GuuPbjrCa0j6bGvsZWkQ7paSpwrFIqIAa9eN/JBulUEuqiun/y/cLttZzhJ7
	 Imobj8IhDuTGZOs9vxKumwMjOoJYcjDba9xj0IJRxNVXaYS5IwLL7SqL/0sOsKOPrg
	 pMorzRKy6xMt3GDHQKAM7j/t5LfON5N2nbHDCPv0Tetr+DVPa/xwVt7m1eSv/bA2XU
	 SravgVIj1HREGVhpwijk/C3l31iYGgfzwIHXgRFW4V2YkaMhOWfD2DbaCnqhdHcKIz
	 NDS7XCaiMz+gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC73805CC0;
	Sun, 20 Oct 2024 14:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sun3_82586: fix potential memory leak in
 sun3_82586_send_packet()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943583500.3593495.1043464338026707882.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:35 +0000
References: <20241015144148.7918-1-wanghai38@huawei.com>
In-Reply-To: <20241015144148.7918-1-wanghai38@huawei.com>
To: Wang Hai <wanghai38@huawei.com>
Cc: sammy@sammy.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, zhangxiaoxu5@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Tue, 15 Oct 2024 22:41:48 +0800 you wrote:
> The sun3_82586_send_packet() returns NETDEV_TX_OK without freeing skb
> in case of skb->len being too long, add dev_kfree_skb() to fix it.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/net/ethernet/i825xx/sun3_82586.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
    https://git.kernel.org/netdev/net/c/2cb3f56e827a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



