Return-Path: <netdev+bounces-230246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD785BE5BF7
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56EC819C0226
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349F1FDE14;
	Thu, 16 Oct 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evx6unnT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144941917F1;
	Thu, 16 Oct 2025 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655622; cv=none; b=cmEx0Oa9SP/GRK3d1H7fisPQM5qW3ASoJ39EGZUwjsyj5vTuiRQGzjiu1w00WaDCNZvh1NCj/Xk6qqy9mhC92qhVht5EFTJuVX6RkhK1X/cXI3AS8se7Hst3NGEpUIBAaB0LxAXKvuIMfqs7qqXSdrFg5Y0g5ubUBROs08DDzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655622; c=relaxed/simple;
	bh=y1cLi1qiNeoQW0GjMowxZf8p9EuPzw2O8V99suRom+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nYP+7QoPcj/LutbAVYFwgNlanxEtvT4cDfVF+/7Qf7a5oVLAcfqna7MtubqXqIGqJU0sXQzlnM1uNN+BI3u+OEiBQVPy9oT4P96VGTXElp1qmb9OazSlNv4EIwF8XuRytFuW30qCFltyIBnVFCbe0Hlg44qLVmw218UlmHfd3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evx6unnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ED6C4CEF1;
	Thu, 16 Oct 2025 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655621;
	bh=y1cLi1qiNeoQW0GjMowxZf8p9EuPzw2O8V99suRom+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=evx6unnT9oSNZN3XJgzUIuD+g9AWt9P2COUA+/Vdw+WpoI8fvYtyjmvk2yIRMpmWj
	 GSQN1ouWvTQlu7qHrYjD0aGb2kJO05lgiPSaqi4C0x9T1lc5PwNqg8VLJ6fMb1q3zz
	 pB+70YvP5l4EqDw4jakf6BlBvhaQPAhI+ossPtYRlMBLwG9keEwbh3E7Mf7TDw975h
	 U0fqR4z/w2pAlzkVs6rUoqvBCTfwQKP2PDcWptFwxVYa6TtZ/ubkxKdYQ/amOX6Pf4
	 zBH3A8ehiiWZMvHpb+2oBRQksfY0c+Df9w39qW4+Eif6cJsD2Z9onrLkfryFT0vY9P
	 I3FD3mRIBNRXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11D3810902;
	Thu, 16 Oct 2025 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: rmnet: Fix checksum offload header v5 and
 aggregation packet formatting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065560576.1937406.6281512047477502044.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 23:00:05 +0000
References: <20251015092540.32282-2-bagasdotme@gmail.com>
In-Reply-To: <20251015092540.32282-2-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 quic_sharathv@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Oct 2025 16:25:41 +0700 you wrote:
> Packet format for checksum offload header v5 and aggregation, and header
> type table for the former, are shown in normal paragraphs instead.
> 
> Use appropriate markup.
> 
> Fixes: 710b797cf61b ("docs: networking: Add documentation for MAPv5")
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: rmnet: Fix checksum offload header v5 and aggregation packet formatting
    https://git.kernel.org/netdev/net/c/1b0124ad5039

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



