Return-Path: <netdev+bounces-224477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1896FB85692
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA2D7B6CF5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA5130EF67;
	Thu, 18 Sep 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHBazFsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DF530CB56;
	Thu, 18 Sep 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207616; cv=none; b=aYD3oiWw1yK70VBeqvJSeZr5KFXJ/0zNSKzJ4T6TLFFOEyZy93bECoIjs0fZ4U8pKVwyaLzElBBlb14Gb3QJFYtnfG6Lot+6Mcir1qgW0Bszn5zHFGkN6m2aN+vBzoBgQFfkxAMZVWLrEE5F712jsFLZ4CPxVC28hqMtmdGCyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207616; c=relaxed/simple;
	bh=hXL4OXAsNtVliEMtBbEqOcEl26tQDemUiWDFhEXcJ9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T2CeZx0yCWZdosRaj/cInzcqZdZcdwHqV8HyC7Nn8v8O5NBPAuF1EnHvW3j5DtDYxWJZ04PlUmPACe6eGeCle3XDfv9yqq/C94apcEoZPQTF6z+XDxZcsZ1etmX55zDK2s8bw5ELqTc15tVVdKSGvkLyueFW6N7zQBqkEOWvS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHBazFsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9EBC4CEFD;
	Thu, 18 Sep 2025 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207616;
	bh=hXL4OXAsNtVliEMtBbEqOcEl26tQDemUiWDFhEXcJ9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dHBazFsn11qK866O/FmenJpHqngiBuCwrAPxGDgFOdThI7MUvbvlvbxVljRH9eyJq
	 FTB9m7ptSu8nUDzsaHUfDSSqPLEah2GDcvWHt8dcqV9tuQ6Y0rIG9/j97wpfT9rdqq
	 a7Q1khst3I9WEXm9QZao932o0Hbyt+++2XE0LSpi33kxw3eBX2N52ySPAKHG0M6R41
	 yJlIQq+vmYODEdmqH12nf1z2yj3AbyuYjeAfnJhCln8HQCz2kxaS19tmCupOMjTPCw
	 F1Xb3Sa4vdw1yLRXtepsOgw9NuS+N8Tyra61AIaPqQh1tCPXk43R82xvDdeLlXOElB
	 l0hl8eIXFCZ6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B7139D0C28;
	Thu, 18 Sep 2025 15:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] octeontx2-pf: Fix use-after-free bugs in
 otx2_sync_tstamp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820761599.2450229.12360019578497967882.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:00:15 +0000
References: <20250917063853.24295-1-duoming@zju.edu.cn>
In-Reply-To: <20250917063853.24295-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 richardcochran@gmail.com, naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 14:38:53 +0800 you wrote:
> The original code relies on cancel_delayed_work() in otx2_ptp_destroy(),
> which does not ensure that the delayed work item synctstamp_work has fully
> completed if it was already running. This leads to use-after-free scenarios
> where otx2_ptp is deallocated by otx2_ptp_destroy(), while synctstamp_work
> remains active and attempts to dereference otx2_ptp in otx2_sync_tstamp().
> Furthermore, the synctstamp_work is cyclic, the likelihood of triggering
> the bug is nonnegligible.
> 
> [...]

Here is the summary with links:
  - [v2,net] octeontx2-pf: Fix use-after-free bugs in otx2_sync_tstamp()
    https://git.kernel.org/netdev/net/c/f8b468715102

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



