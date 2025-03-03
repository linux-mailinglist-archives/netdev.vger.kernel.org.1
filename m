Return-Path: <netdev+bounces-171256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C1A4C2E2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A073A485F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE75212FBC;
	Mon,  3 Mar 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5qLtg71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D0211261
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011000; cv=none; b=JFIsitwHuQ0E8bOsGWp9mZzNVdk/X9GB8sV1U/V8KGcLtH+lvfmD/NZ1lhfe3E9sf7ogEgpSL0Emf5jktLdLj7Qp2r7buuKUp6tAyabsRGcAfgmUY09TtRBR8dDrCc18swnDNDcODdWQI4UKmKBdFS/ViZVFpWOXkwV+jTkyMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011000; c=relaxed/simple;
	bh=vNLLQelopAkPgmVxbSFDskaifMaJHcfTSsDi/7vyKvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q+k67FYOlMNwPL6xtayS0CI4S/S3OsaVOnDEOVyaZq+3zDe2M8ZKn53pOltEzBplVRlDlNocnsupGCvKYfUEDuhBxCaxDxZmofRlEXWpjbbXcnga1isBPVnL1kALZ0kVTUCUzERJ8Dl9uFt4gd6UIZzD1s15bwniu31bgqJ0c80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5qLtg71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40142C4CED6;
	Mon,  3 Mar 2025 14:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011000;
	bh=vNLLQelopAkPgmVxbSFDskaifMaJHcfTSsDi/7vyKvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A5qLtg71aWbFvcO+vpovrhdg87qewwqXgtQS4oT2YLP/ZCdajEAHE+kojr7CHpN+c
	 q8qziOXfA9+m55M947XYyDhB9pPFf+eWa7ehwZrYYx9iqO6Ngev9lbMC+C5Is8Iigh
	 ubBqqEqVCZKRT0R29YgynZzb2kM68qOI0011mMqpWU44/QQbF8+N5U1EjIsbvGgzLh
	 Y0phLXRNGxgh2b1if23Wu4gpwuvyi+Gv51lApM75eD4bA8QJYngUvxxfQbspJ27bMd
	 NDBRXPym6FKG7jWp6Gbp9i69P16mZNKReVQkZwbcOuigI9w1Ctj2LE0lTLWhhd65vJ
	 XE9+r+7JT6HnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F023809A8F;
	Mon,  3 Mar 2025 14:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] llc: do not use skb_get() before dev_queue_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174101103271.3591127.13091256569197048949.git-patchwork-notify@kernel.org>
Date: Mon, 03 Mar 2025 14:10:32 +0000
References: <20250227082642.2461118-1-edumazet@google.com>
In-Reply-To: <20250227082642.2461118-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+da65c993ae113742a25f@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Feb 2025 08:26:42 +0000 you wrote:
> syzbot is able to crash hosts [1], using llc and devices
> not supporting IFF_TX_SKB_SHARING.
> 
> In this case, e1000 driver calls eth_skb_pad(), while
> the skb is shared.
> 
> Simply replace skb_get() by skb_clone() in net/llc/llc_s_ac.c
> 
> [...]

Here is the summary with links:
  - [net] llc: do not use skb_get() before dev_queue_xmit()
    https://git.kernel.org/netdev/net/c/64e6a754d33d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



