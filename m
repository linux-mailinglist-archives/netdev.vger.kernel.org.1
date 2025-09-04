Return-Path: <netdev+bounces-219751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65969B42DC3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71E85680D5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20322C235B;
	Thu,  4 Sep 2025 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt/5iSHr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10F2475C3;
	Thu,  4 Sep 2025 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944005; cv=none; b=gJ9HDjzWBECdCJhQaTg/g6EFxolKLsdYorcOuqSjsbF8CdgESVuLvGMm7b+F60yZkFDQ7fT8JDPTUH5xSTgQ8L0UFx6HHTSPNg6vF5TAZodQCfK+izPTX2Jck1w8B4NgvxRJ329Jd3w+ISyQLkEmG6KxEiwaz6XhSuvAnbR91qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944005; c=relaxed/simple;
	bh=DRn/T96ZauTISpOvyVlFnzPXqF4MbW+TUHmU2JkpBcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DgSI/Dj7qxvspWDp2pniyOnQGTPxNLB271aOscyYSK/3ujB34S7+F79NfYjhbqtdrHhTSPMLHNMVg7PCe/lZEpXw8G1HxUJ5Z2gDXrKYAgN1c92PTQWDYE5r35zaNnOxvah5V70SKnZIwrWuc/GMtQLRMVTK+9pFBw6QwUMtLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt/5iSHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A781C4CEF4;
	Thu,  4 Sep 2025 00:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756944005;
	bh=DRn/T96ZauTISpOvyVlFnzPXqF4MbW+TUHmU2JkpBcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nt/5iSHrYmYHaW3ojNZqy+nuI5h6/D5g3EXem8YQjIIINlV069GkTutXemDiV3vtH
	 xgp2ZgRbdHwDJoDsMIiaAVYRZgaGv4H1vEhZBgh7ZzpBwAsc1A7W2nPv+P9o+Zl5AX
	 eyKQJEtppzYVaTChwb7mv4WOU7TXpOFteSCX7536F/5DlBvDC303foePUctwJi6RtE
	 yFOGwNHDf9R8Kqsgmj/Eqzcf00HpziKtn8sr2Ffftbpahzi7t9Z4we17G9l3Z5sBH5
	 6gkn3nw3sm+GaKiCGOZgAr0tklpJ3ml3erIy7j9PQVmhT7v26c3Q+YXBLRRhx9d7ju
	 iKkT7qcRio2sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB6F383C259;
	Thu,  4 Sep 2025 00:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: thunder_bgx: decrement cleanup index before use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694401025.1242165.3852519134905149120.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:00:10 +0000
References: <20250901213314.48599-1-rosenp@gmail.com>
In-Reply-To: <20250901213314.48599-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, sgoutham@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.daney@cavium.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 14:33:14 -0700 you wrote:
> All paths in probe that call goto defer do so before assigning phydev
> and thus it makes sense to cleanup the prior index. It also fixes a bug
> where index 0 does not get cleaned up.
> 
> Fixes: b7d3e3d3d21a ("net: thunderx: Don't leak phy device references on -EPROBE_DEFER condition.")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: thunder_bgx: decrement cleanup index before use
    https://git.kernel.org/netdev/net/c/9e3d71a92e56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



