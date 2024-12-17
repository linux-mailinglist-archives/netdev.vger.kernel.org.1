Return-Path: <netdev+bounces-152611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D269F4D78
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62181188B726
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3D1F542F;
	Tue, 17 Dec 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCo+RmRu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B727470;
	Tue, 17 Dec 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445214; cv=none; b=tUxSSyzkQY1sSrzHDPZHHmWoZsAkzAYKSI4wcuzKc/VNiEGEN9Em5EC1q88H5TY2CAqGFHETN+z6ieggQYwT43TAhbuPw5V2wrA6ADL6kOyK99eAMbbS0dTFvjs2jlzmiXARAiYIQjkF0t6WxqHZA+6xI/auoDvsncrKR58ZIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445214; c=relaxed/simple;
	bh=vJPLatlrDqC95p8LVjdMOA9HfexduBosVlyBGxjao2E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a4t5NKSC54k4ciYxFtv9fYUA+O8eVn63Cei6QN4/x+GMyG1XPbyh4GgmyGkRgoWAzKJf9mk0lM+rTzb+3U0OWwoztkKxX5HoIIK+2JIxHlfRCJvLX+/hg1piooT0RMnf/WWzeIqXSLbAqffBL82KDnGU848hukUqp9kxONRpbow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCo+RmRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63E4C4CED3;
	Tue, 17 Dec 2024 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445213;
	bh=vJPLatlrDqC95p8LVjdMOA9HfexduBosVlyBGxjao2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lCo+RmRu1sk3YKfmGVBecKbEMyZpLvs2nG7GkfZPwqy3Z5cRWdJoEk1kxxrsF8mOW
	 vnCsF0+ae7jPXYN9SHf1w5gt9qrh71tk7vlOVx8xl5J3vMT6t875lZY28CQZrnXiR1
	 kEQkkINcNgfzyOZwUfc8TwEjWPDCyMLzf0UJHaPCrG+DaGQ3VhZEWMilGaig5wWZx4
	 VNHz2vJkdiocjOWCf8mGPcARFTdMsfC2onW02CdB1u8jsQ3UotOV8UWlDFQUVIdGZb
	 R27fNaEt2OF2OP/LTmVyTEhDCR1BWw01TAILGoEgmei19LYxuMAUas/dmCpsvyQKsW
	 ZXEAuBbuZBKbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340913806656;
	Tue, 17 Dec 2024 14:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] qed: fix possible uninit pointer read in
 qed_mcp_nvm_info_populate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173444523101.912585.15358390243675010078.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 14:20:31 +0000
References: <20241215011733.351325-2-gianf.trad@gmail.com>
In-Reply-To: <20241215011733.351325-2-gianf.trad@gmail.com>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: horms@kernel.org, manishc@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 15 Dec 2024 02:17:34 +0100 you wrote:
> Coverity reports an uninit pointer read in qed_mcp_nvm_info_populate().
> If EOPNOTSUPP is returned from qed_mcp_bist_nvm_get_num_images() ensure
> nvm_info.num_images is set to 0 to avoid possible uninit assignment
> to p_hwfn->nvm_info.image_att later on in out label.
> 
> Closes: https://scan5.scan.coverity.com/#/project-view/63204/10063?selectedIssue=1636666
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] qed: fix possible uninit pointer read in qed_mcp_nvm_info_populate()
    https://git.kernel.org/netdev/net/c/7ed2d9158877

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



