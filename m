Return-Path: <netdev+bounces-170190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB30AA47AC7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9663A73CF
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D61922A1EC;
	Thu, 27 Feb 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm2O31xo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009B82288EA;
	Thu, 27 Feb 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653398; cv=none; b=C0ZmFJX6yJsKh+BJavH+y5Lo7Tekw+jVMEwvQz+TeQp02oJmrOCW+8xGN/Av2+2kGCMHunFAMiv4LHOewAxeea/rz5rcbfL8L08lz5OFM1puuFN3O4JdHbf5G034bNbNGaWGk8CWBiUhkvB9Pk1Za2ov3l0TkxKjIM5O5KdZbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653398; c=relaxed/simple;
	bh=YYJ7gEsR0U/YGiOODkNqsZ8vEFtQRhso7UfJ5DEdLUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V+4Zhj383gR9XRbjrcLi2FLaJRnvTHlyWVZD+0Fjy+TcN+B1gmWsEXv88jEl0dwIuLjtlmkfEXQDGv3AMj82D9ZzumgMAmhPgKtwc35CSTXu0cX2EfGPViHjENB0nqLoJeKLiXUx/84upFiZUWhIWd2Oi/E8drc7M6c9ofggn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm2O31xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F582C4CEDD;
	Thu, 27 Feb 2025 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740653397;
	bh=YYJ7gEsR0U/YGiOODkNqsZ8vEFtQRhso7UfJ5DEdLUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rm2O31xoE60HsohBYtZYWmEY9ZjWpZVed0MrgkMC8cYzFZr9821hoaQp6J5S51l+b
	 +lNILK3oVdq9j8+v1Q6eEE9FpdBxAflApa0lp0OoywGucSPrS9PKglx4igMkXbyUe5
	 lYi/lCZurDjxynI1g2zYURjitGpTri4nbILEg67U7aRJwXT5NL5qxj0nqBDvgBPt9I
	 q4h7za9wlcYce+FVMzp41SOK+hFEqxjVrLAJxfeZjMxMhGsq1X3qSAn2iQv24aq7H4
	 uoj0Z0OIzPh2R/QIX+slEKhnb1TdqmJCxTqn0D8rqvxtY3/qPGjXz28Wpg3VkYw82q
	 oO09ulWQylvUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0BD380AA7F;
	Thu, 27 Feb 2025 10:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] usbnet: gl620a: fix endpoint checking in genelink_bind()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174065342951.1379797.16119885160230991674.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 10:50:29 +0000
References: <20250224172919.1220522-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20250224172919.1220522-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+d693c07c6f647e0388d3@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 24 Feb 2025 20:29:17 +0300 you wrote:
> Syzbot reports [1] a warning in usb_submit_urb() triggered by
> inconsistencies between expected and actually present endpoints
> in gl620a driver. Since genelink_bind() does not properly
> verify whether specified eps are in fact provided by the device,
> in this case, an artificially manufactured one, one may get a
> mismatch.
> 
> [...]

Here is the summary with links:
  - [net] usbnet: gl620a: fix endpoint checking in genelink_bind()
    https://git.kernel.org/netdev/net/c/1cf9631d836b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



