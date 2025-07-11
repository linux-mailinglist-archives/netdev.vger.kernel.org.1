Return-Path: <netdev+bounces-205999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF2B01098
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1A648010
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F63A1B6;
	Fri, 11 Jul 2025 01:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAnZmcoY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0FE555;
	Fri, 11 Jul 2025 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196184; cv=none; b=g0BcqomvreaTechCpd52h79PikbUh2rpYZTD7QqQtWweRft26An6KC8m7VBuKDCSGAgRw4tcaVBnOAVtQeJnAMLqzBeqSMrmxQ0+s3mBmvtI7Kv6Y5MPrNJ2PxM2BjDDe/x8vRs7FKJv9jTNUOVQIJo6BCTliLMJfVZvIg3/kBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196184; c=relaxed/simple;
	bh=ZF8uf81UI5slVZjgXAWPwnW4K/a87yF2BLhoyZpKvrs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nic2EKVvdUkayGfQCzwfJ3H8eUvtCFhRjCiTUMcSy8XFKcIfGFgGxTeopRRnwVtA8UGlPuSc67eEFERsmFuNJU4zQwigXBdM8cX86rJwGb9aF5xrV+6MsVhGEbRnmj/JvJYRGxz8AjQVyTCpdi/E1NqjvtS0/+Zbowg53OtOzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAnZmcoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CD3C4CEE3;
	Fri, 11 Jul 2025 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196184;
	bh=ZF8uf81UI5slVZjgXAWPwnW4K/a87yF2BLhoyZpKvrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FAnZmcoY0PDkynxMTnl/2Qfv311taliqEK8cfS/RnThAuH/Psgdg3D4hBJztUwwOd
	 xeiNnW21xT2EbR9AaRNLX+xstXMU2AsXIpZ0Y5eQiZ6dBzR0b3IQqvaL1FVfyt22WH
	 gdNNXtXz6vsCYtoixxrbHWj2NWnw6lc929KSI/KoXIX7i4ApLvv1CqMBxAOgRmLavm
	 zyUaefcZ2MEHi4zkK6kCNUI7y5iZuTmZMQKfUDDW/EQENFPeauVXCHy4/y6wynxUqD
	 gC+cWVP0ascNlPgB0Gn9WpyQT77kSzmx0MZl44W12xSLFIfmzJ3imrQYAtGIUrpdhi
	 3knfLRug2bbIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E4689383B266;
	Fri, 11 Jul 2025 01:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: appletalk: Fix device refcount leak in
 atrtr_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219620677.1722907.259006484349670709.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:10:06 +0000
References: <tencent_E1A26771CDAB389A0396D1681A90A49E5D09@qq.com>
In-Reply-To: <tencent_E1A26771CDAB389A0396D1681A90A49E5D09@qq.com>
To: None <veritas501@foxmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tglx@linutronix.de, mingo@kernel.org,
 herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 03:52:51 +0000 you wrote:
> From: Kito Xu <veritas501@foxmail.com>
> 
> When updating an existing route entry in atrtr_create(), the old device
> reference was not being released before assigning the new device,
> leading to a device refcount leak. Fix this by calling dev_put() to
> release the old device reference before holding the new one.
> 
> [...]

Here is the summary with links:
  - [v2] net: appletalk: Fix device refcount leak in atrtr_create()
    https://git.kernel.org/netdev/net/c/711c80f7d8b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



