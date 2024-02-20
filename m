Return-Path: <netdev+bounces-73230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19285B7E6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8281C214B3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6DD60DF8;
	Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu8I+9Ne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853AA679E1
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422028; cv=none; b=iVfLyjop+VIdvvVxl507a3uKRzQZ0lK3ex91jxs22rAnUghCfxhDJjD7b5A2d9usVLq1fOuqbO/QoIH14TMdrAlFB4ca6NGJoz4HUnYThACqvpjiOURJQRcPNOsOVd0EJ/jaBLocYhSpwJTKPahDpuCXj4++0Z/85RNAfCE97xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422028; c=relaxed/simple;
	bh=y1Kk4cbnXSzWjtqFO9pXcacE8/TOAElqXqD0aWcDxjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qp/avM0PyGbrKJ7wLjyvvphxXI073TaVLkn8y7QMMnLtJei+GEuhCnG1kFCzff7IorNr+K9BjPuMM+bu2V9FTdXxkjFC/NymMFrxS4kfTbIONoXQO8CX/s8EAItJmpE3VsV6GCIHGvNuR/h9QexIbpWCe3elGqsgALsgyU7HOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu8I+9Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DB60C433B2;
	Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708422028;
	bh=y1Kk4cbnXSzWjtqFO9pXcacE8/TOAElqXqD0aWcDxjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lu8I+9Ne93jD99ObxRkQ8a1jtcr4DwSbPJvL6nkUBtn89l/hQ02AXTMp2jNkgBHQ6
	 a+zMhNq3tvFeAoCWgCrBeYmlZFaye0OuFCRl0FxGTC5H/cNufZAyXYjIXHrlVC/reN
	 laEwE4pBJ/frNl4EspD/7f3lTPnThlAqiJH4McFQrzCUuz4juIakILOobZfiq9/1yC
	 IMeXwUpJsDDYWilby+JhrcCTR9Tr46aUZ/C1ZTV9MciG9SLXyquiTgEGe03sMb75m5
	 3VwK6Oz0ziljq9RzbfWutcPRkeY4bpbgKatd6EXZSiKx3kdVTcpW2nmuYgdQLLqSPc
	 KW1qNQ6LHnxiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 169C4D84BBB;
	Tue, 20 Feb 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ipv6: sr: fix possible use-after-free and null-ptr-deref
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170842202807.17965.17736912621512483731.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 09:40:28 +0000
References: <20240215202717.29815-1-kovalev@altlinux.org>
In-Reply-To: <20240215202717.29815-1-kovalev@altlinux.org>
To: None <kovalev@altlinux.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.lebrun@uclouvain.be

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 Feb 2024 23:27:17 +0300 you wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> The pernet operations structure for the subsystem must be registered
> before registering the generic netlink family.
> 
> Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
> Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> [...]

Here is the summary with links:
  - ipv6: sr: fix possible use-after-free and null-ptr-deref
    https://git.kernel.org/netdev/net/c/5559cea2d5aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



