Return-Path: <netdev+bounces-202851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42DAEF5EF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10713B0EC7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E27B271476;
	Tue,  1 Jul 2025 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6lQr+pj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86AF226CFF;
	Tue,  1 Jul 2025 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367596; cv=none; b=PZpFHr2GVHcmKzfmShHzkltFHV1et2E4ngKtOP+RPO7rOzGWm92scxowvFcMocRc4KlLvhoorIGWzDOm4TH4CfXWcNuYVs4pLcYcXvMXB3pYqvz+EvFbOF6DCvPAPFfI7wYB91Q99AnLFfYdXySyIsy/U5r5CLm+SnrUyFhK44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367596; c=relaxed/simple;
	bh=SsdnV5rtnPpZH7ma4opAubXa+uEG9ndLZmZMTOMsyLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sL74ZfIkRHU8Q4X00Wc+lUg4xgBJUMPq9fuoXFbVYzBzWUNZixnif2QkRfqNYM73COSdVoVQaHaMa3oyYslpxX1sYfMnZTx62zo2Nk7r/VRPMRbLMPTNJT7H1IFAFVZCTioiJGrnqfQqIbjLTYO2g5Pc6g0goMnR9hPt1jbcIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6lQr+pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87357C4CEEB;
	Tue,  1 Jul 2025 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751367595;
	bh=SsdnV5rtnPpZH7ma4opAubXa+uEG9ndLZmZMTOMsyLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u6lQr+pjB00FdKUTR0Ot/Z0T0rE7f2FKLlKHse/kuKK2N2CgXzfnXYATh0cHN+mri
	 0tWrN48WJjbINJZcu6M67Fh+Q0AZrIWE7ZwMwY0wy+/lpF1ofGiLF89mjpbkNNedFT
	 KYpkEgD0a0DihLEg0E+foYtX6/Xu9Z8IkRuWMHup4CTRgND7FEFBmCfNs14f44CoS1
	 ZFa3j3XHXPzMyvW+IIAGIMB46veask+jfJ3wOlJfqQRmrDfPn7WBz/pmK3IaECjk+3
	 mmha6oNaV66odD8TIZDTkSKPRVoVVAHv5TLYsW4YVwzMCG2/CE3/f1c2TOFtr8GLmU
	 DQSyZL+JEH7sQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF538111CE;
	Tue,  1 Jul 2025 11:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ieee8021q: fix insufficient table-size assertion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175136762051.4118367.17037780870326601416.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 11:00:20 +0000
References: <20250626205907.1566384-1-rubenkelevra@gmail.com>
In-Reply-To: <20250626205907.1566384-1-rubenkelevra@gmail.com>
To: RubenKelevra <rubenkelevra@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Jun 2025 22:59:07 +0200 you wrote:
> _Static_assert(ARRAY_SIZE(map) != IEEE8021Q_TT_MAX - 1) rejects only a
> length of 7 and allows any other mismatch. Replace it with a strict
> equality test via a helper macro so that every mapping table must have
> exactly IEEE8021Q_TT_MAX (8) entries.
> 
> Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: ieee8021q: fix insufficient table-size assertion
    https://git.kernel.org/netdev/net-next/c/21deb2d96692

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



