Return-Path: <netdev+bounces-137286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3359A54A6
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F37F282A46
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7ED198842;
	Sun, 20 Oct 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeHwm30A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D641957E2;
	Sun, 20 Oct 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435840; cv=none; b=BwFOEuVn5X0KnHV7nr94GgJyLh2zJ0ywMo0lCj6r0bh+0eqCfU7dS/d5iFcZhGP+QbtFJaMUrYWeattdTTmfEUbcX9Zx7Ncs9M+7C7/SVP6SSsCQ+6ozhMWtCVvYo6E1rlWWGUbxFV8DIUlWZzHLZrRXtAIe1U8EiesCu/nTSDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435840; c=relaxed/simple;
	bh=49z6RRHJ2SgnNdYpPQkbs1jeUeIKseQxmUYcKA7cbNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cxuKt3pfIhbe8ncCTEHUi0r6DcOZQOOLIENHKWcwAlNxG4XBmmOeIAlrixwSol6An5G4JrdzBR8qOtsCbg22dXlk/zt1rO46IswIiEe2QC16Q3PAfipRPQuWLBWknPlKAUJwsU2HwS1PF9yln4vojiFoYJHW1VYtOrincBA208g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeHwm30A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599B7C4CEC7;
	Sun, 20 Oct 2024 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435840;
	bh=49z6RRHJ2SgnNdYpPQkbs1jeUeIKseQxmUYcKA7cbNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GeHwm30Ax7nr1MSlN2/sQZx0z1xkno84RgaldXGZnncCIHWgShCFs4PC9hyGXmnbq
	 BtrbI9s6qKLcL/VGLh4rqWY9llaahljIUsZNnqIMQaepZyxxWcmQXu8tIwOksrmGCC
	 DYFZeMJEoieWvXeGeqtP043FvXam1N+gNIbFpjUE3CR0KMq1Gvt7WSy7zopb5Oyp+L
	 hS7mBHrZ3ng411O0avnOp+KHk5ddjAx+SiMI4PwzvJPYj0eyPJU7NfEcPD1E2SzMG1
	 gCMuqz+lT7eqh1Cjqe7d7cz5wrHlj0LD8x3uFE+E4jn0HNIljuygMG3izZ839P2tzP
	 ZS7zKba3VtDQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE83805CC0;
	Sun, 20 Oct 2024 14:50:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] be2net: fix potential memory leak in be_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943584599.3593495.6067062516799587489.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:45 +0000
References: <20241015144802.12150-1-wanghai38@huawei.com>
In-Reply-To: <20241015144802.12150-1-wanghai38@huawei.com>
To: Wang Hai <wanghai38@huawei.com>
Cc: ajit.khaparde@broadcom.com, horms@kernel.org,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 VenkatKumar.Duvvuru@Emulex.Com, zhangxiaoxu5@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Tue, 15 Oct 2024 22:48:02 +0800 you wrote:
> The be_xmit() returns NETDEV_TX_OK without freeing skb
> in case of be_xmit_enqueue() fails, add dev_kfree_skb_any() to fix it.
> 
> Fixes: 760c295e0e8d ("be2net: Support for OS2BMC.")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: Add label drop_skb for dev_kfree_skb_any()
>  drivers/net/ethernet/emulex/benet/be_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [v2,net] be2net: fix potential memory leak in be_xmit()
    https://git.kernel.org/netdev/net/c/e4dd8bfe0f6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



