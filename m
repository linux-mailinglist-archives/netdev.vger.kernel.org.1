Return-Path: <netdev+bounces-146075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2919D1E84
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F09283075
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876864594A;
	Tue, 19 Nov 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj6KOGrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391A2629F
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985221; cv=none; b=iNhiRmY/reW8esjHsBntup6N5gWPkvZ9JEB1BAEQYDQ/6BNDkxUiTfYEXzfPU6C0w/KzFAkYIwWFDgMFTMV5huG8l0UgIr9clgipBnGdkDale5S6EbOfNVFiJV6iIZSSRv7YvmBhwHpZcKkuQS4DK2kWd1Rswppi/iqrhoov6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985221; c=relaxed/simple;
	bh=ABi4ICJvQKTsxHbog1xUgnuHrIei50ueRYSDTvFf1LE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YiwIphu0G9Sddc57UKblyGQWtVklQY2iINt77ZUSMv1Qpz04fKNkKkXqXXLcy3FjHGryjhVsI5nW/shnYfuJPDzZywCeQ16UXIvWD3f9UDCDkv+bP4Ndu6AxwHorlh92qNFyIMsvy9MMV42IZupOoOHRNqqcAFsUF/9wAI4R3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj6KOGrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EBCC4CECF;
	Tue, 19 Nov 2024 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985221;
	bh=ABi4ICJvQKTsxHbog1xUgnuHrIei50ueRYSDTvFf1LE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dj6KOGrY1HgK54c+8cymWxq5B8Vdly/gLQhzKduq+An2eFNwrd2awz9YYwJse4iTm
	 d5YK8E0Mmc1gmUoaaIQs11YqYsRf+HfxNWUrn2jqHBAbKLilb4hWRO9VPWk4aFNMGQ
	 Rv+YFkscMcM53txTS38YGMqzTS1FM3t5vgSeWYvog724x7dyv2WQRw8wsTl01mx5fc
	 CtX0VvSjaghoGgQvkt9xhfFXpqg1uNrnicLIfvVvoPoDpGx1RsohkVX7R4HqBArVx0
	 nt49a6Pqyn+h+grctWntqQXb9TghYZNd0qVeYbwbh6Gray0yd608Ld/qJaTRiw294w
	 94RXHvnp4Y/Jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B03513809A80;
	Tue, 19 Nov 2024 03:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: fbnic: don't disable the PCI device twice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198523249.84991.11498187711746511884.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:00:32 +0000
References: <20241115014809.754860-1-kuba@kernel.org>
In-Reply-To: <20241115014809.754860-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, alexanderduyck@fb.com, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 17:48:09 -0800 you wrote:
> We use pcim_enable_device(), there is no need to call pci_disable_device().
> 
> Fixes: 546dd90be979 ("eth: fbnic: Add scaffolding for Meta's NIC driver")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: alexanderduyck@fb.com
> CC: kernel-team@meta.com
> 
> [...]

Here is the summary with links:
  - [net] eth: fbnic: don't disable the PCI device twice
    https://git.kernel.org/netdev/net/c/62e9c00ea868

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



