Return-Path: <netdev+bounces-161674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C1A23285
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA1118838E5
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79961EF0A6;
	Thu, 30 Jan 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy5lhc5r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38811EF0A0
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257013; cv=none; b=lzNRrmBV+SfIh74oGKl0ydaFW2cpM65oYkyN3HqnGsaPAlZV5H0QjZq8VACckz4AUZzNhsUeNiTYavZ8c9E9+SJHuG94/Wq44YrgbQLPqHX2XIzENFspTsj2/3cSyDIx1QO/OmmhuFUk8Qt8V8llQIZqMa8cNxo0gVDvzcrr/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257013; c=relaxed/simple;
	bh=jcBlgrXcvv+KHflMclQaRO9D/3MXZ8SxlxLEh0VM4aE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EilXtyQkD2tLesFm8BDfSdHafFXIb57bIIOedmIZG9Z8py3Ozej/PpRiccXlsdYk+jBhww8Uh9ILCQNLKcgjCRJQvnigwhzkxfnuiJ1mUoCingrDvYz2gunzv2r1z1/YEj3l5DFS9nFjqbfwuolApkujKMVGmgsblYsiBzAkhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy5lhc5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777C8C4CEE7;
	Thu, 30 Jan 2025 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738257013;
	bh=jcBlgrXcvv+KHflMclQaRO9D/3MXZ8SxlxLEh0VM4aE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uy5lhc5rRO8kE+P4ui1sMvCbmqhNOTkkwnKV1M4vCk21WcJJog6pDMK2IBv3IvB9L
	 1MV8RF70t0W+551S+lByryELRaXlwXcZ4nqE0F/J9mTqldrhcNcxNro/ncw1+vWWsx
	 61kF7uYSxaf5Vp6qF1Uhkh2u8fNUGB9MTymUIWG713CKpv+/MXBqI37OToi1JUFH7X
	 F39SqlsYVq6hyuq1qtDj8KiQ3gtvAtOQJDbW0YBgtrgX6vspQDlKSY+jLrjMU80BfK
	 cpcev3vN727MjHWzud1lQ/xzeey2u2KUuPMAWPy7LTaewmneg3eFI1bB5nQAz2j3AU
	 Rxqx9GW/3qRrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECC82380AA66;
	Thu, 30 Jan 2025 17:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hsr: fix fill_frame_info() regression vs VLAN
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173825703950.1021356.10166996136540749458.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 17:10:39 +0000
References: <20250129130007.644084-1-edumazet@google.com>
In-Reply-To: <20250129130007.644084-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 stephan.wurm@a-eberle.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Jan 2025 13:00:07 +0000 you wrote:
> Stephan Wurm reported that my recent patch broke VLAN support.
> 
> Apparently skb->mac_len is not correct for VLAN traffic as
> shown by debug traces [1].
> 
> Use instead pskb_may_pull() to make sure the expected header
> is present in skb->head.
> 
> [...]

Here is the summary with links:
  - [net] net: hsr: fix fill_frame_info() regression vs VLAN packets
    https://git.kernel.org/netdev/net/c/0f5697f1a3f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



