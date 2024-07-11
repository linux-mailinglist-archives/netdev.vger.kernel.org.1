Return-Path: <netdev+bounces-110940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6992F070
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C7D1F2261E
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD89B16F0E7;
	Thu, 11 Jul 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTHAyPFJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EF38DD9;
	Thu, 11 Jul 2024 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730582; cv=none; b=OemG2XFiwSURY6n7j3DH6GOmaYNREJy3GX90cOEldIwYOl3K4JGpUrpzS6HeccMKDqoij/ZeTkvyMDPMBzuAP3Pt9tnKK0rToY3A6XoAHb9cnQjQpxbKj4CLjVBsEtFHdM5lZ0qfoq+RGRRX3sBRfMLzeXZNt08WjjysEto3s9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730582; c=relaxed/simple;
	bh=khOfbfPVVqPE4ywntfX+gbv4nMJuiXVC/C7VYAP4hVI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hY9PHCWwQjZJyeb7jR371TefLfJEBse5GUW+rbJugJ+yLw7bhUHUoqkW5/LXp1c4FHDafu4nhjtNFwO/M1LrOmJAzffm22r7kZagoj/eyMIlfCdC+6NIrOZm8Q4ltfQnRqOKrYASqOEsSnBUBUbs7lsy5uplNjCOOFR5ZSqHANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTHAyPFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F7C1C116B1;
	Thu, 11 Jul 2024 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720730582;
	bh=khOfbfPVVqPE4ywntfX+gbv4nMJuiXVC/C7VYAP4hVI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DTHAyPFJwuS49r+kexOhoopnvA8HoscwV4rNhGO3Ro51mOyN48vm/NOxSnhps/dHN
	 a3S1mXtICQR7dp6Xwzgkfrhh4EMeNH6tFrRarRIawbSkSMi+HrSMeN6uqx7i29VaRB
	 0DBUQ2QEHtGkF/2c/Cj5LLrTMLgifSZeorMFgzzq9q4Xc6Fs0pbnRlBqchswhcSqOd
	 nasQ8Mm4dWWSTy/6wA6z8wjBhoy5DzOMWcNiJYXSbNjEIurHMn1jEXBP29acGUy/ZM
	 9ORcVYtqBvd0ZdAILE9O+TPz7CS870DHkWS0+MM1ubayZqgb8/mppVCyMEppml+SED
	 R+/OmaxIsaRVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3BB7C433E9;
	Thu, 11 Jul 2024 20:43:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: fix rc7's __skb_datagram_iter()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172073058198.5052.14456309995810548001.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 20:43:01 +0000
References: <66e53f14-bfca-6b1a-d9db-9b1c0786d07a@google.com>
In-Reply-To: <66e53f14-bfca-6b1a-d9db-9b1c0786d07a@google.com>
To: Hugh Dickins <hughd@google.com>
Cc: torvalds@linux-foundation.org, sagi@grimberg.me, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, regressions@leemhuis.info,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 08:36:54 -0700 (PDT) you wrote:
> X would not start in my old 32-bit partition (and the "n"-handling looks
> just as wrong on 64-bit, but for whatever reason did not show up there):
> "n" must be accumulated over all pages before it's added to "offset" and
> compared with "copy", immediately after the skb_frag_foreach_page() loop.
> 
> Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> [...]

Here is the summary with links:
  - [v3] net: fix rc7's __skb_datagram_iter()
    https://git.kernel.org/netdev/net-next/c/f153831097b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



