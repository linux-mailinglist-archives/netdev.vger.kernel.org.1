Return-Path: <netdev+bounces-84367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877F5896BC0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A8D1C20FB0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAE8135A65;
	Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rslEliH+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708F13AA56
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139028; cv=none; b=dr8LpmElInaTYnIHBpd881vEiJVMZMk7gCNFP7mAcnTTx1tQ3cf03tP43GYHrL0XQ67CC//ICgxEbMpnTpRE0E0aYAW1ROXEyrB/Zj4sjnuX465gFJbWAImAXk9eMHpHFO0goC5baAYdhcXmU5+MhrjYCo1obQs+FqcRsBxeraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139028; c=relaxed/simple;
	bh=plONL1F+9rO+p2TJA3nFACW5i6xAbOVmO50XiTMOkxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lPKuFCgOSIi8ixqR/01RHGBzSwn/sOBS6aA+GYjX6/CxOXSIAHBliFJF6r0iz3XSXK7mqm8o3vENC/WuD1lXqRXCCBD0KYealv3Ul3H6llIXo6B0ZqWD60pI8tbOcF1IFoVQf/p7iC4lBmZbSoTmEslt4rvfXA2av9s3xTiktp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rslEliH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36928C43390;
	Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712139028;
	bh=plONL1F+9rO+p2TJA3nFACW5i6xAbOVmO50XiTMOkxI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rslEliH+YVU3ydWtA2h2g6gLVZcKPdeBgm6EnP6rpTO6N6AaLXpAm0B9sDyv3BTLm
	 34n6JxWqi8VGgD3uuiUp/IxaJjkfU6VU1nGIdC7BShEzOv55KgZsrED/CuMMDqRePn
	 xkDQ4VGV9PLBLEsezYHmMJFjQH+qTgBJBFd9KMBkKvPuhMVeAoD0ox4pBSnlW4La9p
	 lgFaqKqpb8qFvZ9uH811F5Wu/+00FyNOAnktzuGU+q0vq2SqYCTFpe20sltQlAH6qz
	 +D6WBe/LSpan/N7Arr9oBy5o/fWdDMsR3k5+McI2gv6EJfVdazI9KmyVMmOZO5xdG3
	 ErXvaHzhk27/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28926C43168;
	Wed,  3 Apr 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: bcmgenet: Reset RBUF on first open
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171213902816.4996.4627354410898383893.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 10:10:28 +0000
References: <20240401111002.3111783-1-maarten@rmail.be>
In-Reply-To: <20240401111002.3111783-1-maarten@rmail.be>
To: Maarten Vanraes <maarten@rmail.be>
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com, netdev@vger.kernel.org,
 phil@raspberrypi.com, bcm-kernel-feedback-list@broadcom.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  1 Apr 2024 13:09:33 +0200 you wrote:
> From: Phil Elwell <phil@raspberrypi.com>
> 
> If the RBUF logic is not reset when the kernel starts then there
> may be some data left over from any network boot loader. If the
> 64-byte packet headers are enabled then this can be fatal.
> 
> Extend bcmgenet_dma_disable to do perform the reset, but not when
> called from bcmgenet_resume in order to preserve a wake packet.
> 
> [...]

Here is the summary with links:
  - [v2] net: bcmgenet: Reset RBUF on first open
    https://git.kernel.org/netdev/net/c/0a6380cb4c6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



