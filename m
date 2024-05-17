Return-Path: <netdev+bounces-96838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27C98C7FFF
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8986C1F21779
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72807BA2D;
	Fri, 17 May 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBMxejEn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F758F6A
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715913631; cv=none; b=XE3RLfkJsoy2Pxw5YkaogGWtNjPIOQeF+vUTUae32L13yEVZbuMW37NhF6C22sGlgAkHA7g3hf8VVogJap0i/NaGhT34P634WaE/uV3F9GfH+9OagMSgYwhvdGB0GGb+lupPTNC75fmP4nNghiI26TLczF5cEoyW2Im+kNjU7XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715913631; c=relaxed/simple;
	bh=iTWceDwsUlr31w4xO/7wMMOS+8Gu37qNE7EyVhDq5l8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bhJO81VzY8IEzSGRjbrCb3MJkVIjLTJjr9fE47rvHiWXc01E+6d3HjK5xnMB/1eiY82jUv51PxprrU6FHZAO+f2xQDYoG/pK3M/i9Kmhk0EFe2z+2d3RSn01NtxoYO2lco8kGIlVDTzmaRBfrdRKDT/8tzlVPDntaO5uMrEMAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBMxejEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0FE9C4AF15;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715913630;
	bh=iTWceDwsUlr31w4xO/7wMMOS+8Gu37qNE7EyVhDq5l8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KBMxejEny46IzwlYpjBVlFvomf3ZIRjYWrf9PpelO2sJTsU6N6fKjasGCTAUiiuyF
	 zLlohruemMLVy7gbuj6EMLHDFjblHNIB/gbnNMKbL7p53splTuTj4Q7RFWpbbsvSE1
	 B/q2vMqAvvCSJaOUNMHGqcNz4GNPiJbIzyiY58P6VH9sCbIhvSJgS3jiz1ou2i89PE
	 skUo3HRAyxccb7RAvZgAxROWZCNfH8kztr4b6WlJwP1gs+W92XrHLgZRXDtu+TRfSH
	 bfyTqTirbuWLXZjiUggpvWXpSSvGbKJnuobpsD53kAbzGVWrOKs9VGaIYhFSKSju6T
	 tpagEW0hMiiHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D66A6C54BDA;
	Fri, 17 May 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netrom: fix possible dead-lock in nr_rt_ioctl()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171591363087.2697.1088676962296781019.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 02:40:30 +0000
References: <20240515142934.3708038-1-edumazet@google.com>
In-Reply-To: <20240515142934.3708038-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 May 2024 14:29:34 +0000 you wrote:
> syzbot loves netrom, and found a possible deadlock in nr_rt_ioctl [1]
> 
> Make sure we always acquire nr_node_list_lock before nr_node_lock(nr_node)
> 
> [1]
> WARNING: possible circular locking dependency detected
> 6.9.0-rc7-syzkaller-02147-g654de42f3fc6 #0 Not tainted
> 
> [...]

Here is the summary with links:
  - [net] netrom: fix possible dead-lock in nr_rt_ioctl()
    https://git.kernel.org/netdev/net/c/e03e7f20ebf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



