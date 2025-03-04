Return-Path: <netdev+bounces-171616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A082A4DD45
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02D917720D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109D320013D;
	Tue,  4 Mar 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbV2yebA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D6200B9F;
	Tue,  4 Mar 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089600; cv=none; b=b4ZKUDCevOptJ7Cqk+7fTZNnaCFMHdItjGZXMnJknqWtM2BP6O2eAbb5NEf0hh6fw/3lr0F9p2vosjLUzZCd3GN9j6n3c6Xtu5zv4otwZiDNddFpijP1x084E2AlYFywtadzuBB8TVfe4kFGCpJ+XrEsGXdKYYee/y1BIhjwcE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089600; c=relaxed/simple;
	bh=E08SB6Z1syo3up7Ty9PycPv45+p3/R0MzAJU2jZucfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sFrB1gJiq0JD2dcwPuABqUMWNKqD8KH1zigxVangHXeLpvmlerx96iwXl/aLROsEhHy6e1zbxXl3dRInjsA/IKAIbsj0ATNdBqEt4C2h825OAmfGCIbWiFy22z0YGKJv0Ghspos2YIQxOrpW5ZMZxLblv7u9y5Z+z+D1G+xC/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbV2yebA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AA9C4CEE5;
	Tue,  4 Mar 2025 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741089599;
	bh=E08SB6Z1syo3up7Ty9PycPv45+p3/R0MzAJU2jZucfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gbV2yebAA3pFFb9zE6BpbIMHN2CfXiVrp7DiVEOWUK0SyX2/3ur5Up++4ycn73XdL
	 OfwQLTUmMw8Kxy/AuU6l72TFo2I37wEJZ4edFL2wELJcWknWeb9Q50HdLkNlhqNxWf
	 8EbACsuCBAtXDAJlDBv1JRkvgx5nA1Ji5BotEnRhnT5gQiorfGLP5CuWx8APSBKDui
	 +dF0LuXq4sLgpfxrgYbPa2XzlmmBPk/v0PsMnW8uUtgwhZ5vylV/XA0Leo5Bh9UvOx
	 FQ2n/OJZEI+7L6uNPQEvjGnfDqbvqEJLpPNy7J4DG2qsKcLxMgrG3ecqWrENwIA9d0
	 Zi84gcNjbLxyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713E4380AA7F;
	Tue,  4 Mar 2025 12:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hns3: make sure ptp clock is unregister and freed if
 hclge_ptp_get_cycle returns an error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174108963218.113455.4268912693343662541.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 12:00:32 +0000
References: <20250228105258.1243461-1-shaojijie@huawei.com>
In-Reply-To: <20250228105258.1243461-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 28 Feb 2025 18:52:58 +0800 you wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> During the initialization of ptp, hclge_ptp_get_cycle might return an error
> and returned directly without unregister clock and free it. To avoid that,
> call hclge_ptp_destroy_clock to unregist and free clock if
> hclge_ptp_get_cycle failed.
> 
> [...]

Here is the summary with links:
  - [net] net: hns3: make sure ptp clock is unregister and freed if hclge_ptp_get_cycle returns an error
    https://git.kernel.org/netdev/net/c/b7365eab3983

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



