Return-Path: <netdev+bounces-118060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E248A9506E2
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F75F283328
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FAE19B5BC;
	Tue, 13 Aug 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH9WPsem"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989481EA8D;
	Tue, 13 Aug 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557028; cv=none; b=IbRhVj7ESF4JUQCh9Y6D9LHAaASfzxPA+3Y7lgqbsdY1wy1yIsUbPUpi781O/djWEbH0c/dLeDU9TVi+WElG0KlEcqkhapc4vLeeanGuhUJinjgxaNATo029VqLT5lYH5ff19x5wY8glTMt+QrKocqxYz36jJ7Hgsb6pa1+Aq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557028; c=relaxed/simple;
	bh=Y+N81luiDhpmwTIpzxfPqMn67Yivx08cv0joM+WD/oE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=leAm8SCu4kuQXhmUWD3L8JcKo2pGiezHDTtFUasZ00Kyxh3+OvqNizy5oFv23jRla1HFWkIbAWRmGU5jHE3VsfEhHQDlxjMlfG/GKP1VDDQ5exV1P3s/xv1sbdVoXcOJf/2FtdLytdHIN93w4/YyXtO47PUF9AJqzsy7GKs2Pwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH9WPsem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDD1C4AF0B;
	Tue, 13 Aug 2024 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723557028;
	bh=Y+N81luiDhpmwTIpzxfPqMn67Yivx08cv0joM+WD/oE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tH9WPsemb1A+VaddFPBN6MrRffdBGHwoQAiyZVD8Nwy99JYM2T0h/BC9/19N3bbng
	 ASakimI7XblF4wdXhFdxMJ62Pekln7YxYXD22r2p/wriVqcpXuIYeRmSy5ZLjJGyVA
	 FwgwsDyLe3Hu6EsjSCSDQH8yJ29SI8vTuZKH6p07QBBtiHT8thPAbyNRIJsvOcnEHJ
	 39lmrbBRC+vYlXuSO9RsFj9F0fg5uegjEaztBNPaISSJ8bcHAWfC/+AYJq57DIAzCP
	 Mb+B+AYCM+RMLuIs3vV33ndbAVX5VrBR4pkTg0pJmEwz8AuSePEy3pHL7mqIQfb+KA
	 gfDKv2va0DUGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7105D3823327;
	Tue, 13 Aug 2024 13:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] mlxbf_gige: disable RX filters until RX path
 initialized
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172355702725.1643029.11168261839990556381.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 13:50:27 +0000
References: <20240809163612.12852-1-davthompson@nvidia.com>
In-Reply-To: <20240809163612.12852-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leon@kernel.org, yuehaibing@huawei.com,
 andriy.shevchenko@linux.intel.com, u.kleine-koenig@pengutronix.de,
 asmaa@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 9 Aug 2024 12:36:12 -0400 you wrote:
> A recent change to the driver exposed a bug where the MAC RX
> filters (unicast MAC, broadcast MAC, and multicast MAC) are
> configured and enabled before the RX path is fully initialized.
> The result of this bug is that after the PHY is started packets
> that match these MAC RX filters start to flow into the RX FIFO.
> And then, after rx_init() is completed, these packets will go
> into the driver RX ring as well. If enough packets are received
> to fill the RX ring (default size is 128 packets) before the call
> to request_irq() completes, the driver RX function becomes stuck.
> 
> [...]

Here is the summary with links:
  - [net,v1] mlxbf_gige: disable RX filters until RX path initialized
    https://git.kernel.org/netdev/net/c/df934abb185c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



