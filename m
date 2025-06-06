Return-Path: <netdev+bounces-195343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935B0ACFAB9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 03:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FD23AFFC2
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 01:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55602487BF;
	Fri,  6 Jun 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhRGZS6l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270643D561;
	Fri,  6 Jun 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173399; cv=none; b=Fe2u9Q/cKF1X8AlTO075WfD4rjysZxjKGlvvSbCewsJEkZcTqA09549EGXnpkguEzpRcgxCrht3Zp0pdHrL7R7Mty7T6dm9yuKojIKJT/KtjYv8/kqH1zI3AkFTX58PYaR2hJdtEkxY8fHVbZKXM2oho+/nQiQlinr/7BG+8iXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173399; c=relaxed/simple;
	bh=POIw/L4oIu6+bMliJb1g4x2nEniJ2yDHQiFLfUQXVZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UmEEXmmilCQBMr3ApSRqcoSvrgtEzDDNcdZuLsPloRO9rOsdSjdJZmzAlPdtlhiYrPmVbmQwpJ+ngK/LiYUaIaz8CKUSM2FeXJl8Hp39Lp/iOBHuuE8SSyOBbRbHntV5g8zQD3kGrLhFAfRV7hQG2Vz125v9ieOLktFh72glzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhRGZS6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99C6C4CEEE;
	Fri,  6 Jun 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749173399;
	bh=POIw/L4oIu6+bMliJb1g4x2nEniJ2yDHQiFLfUQXVZY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YhRGZS6lAcaVbi1eheAGZ1f/yceMsRtOvtyJ9FTSciYW6uMlp/aLkNeqHzDz2K3oR
	 QOIIt49Qw14RWeGbOCIJSDAyLFAsTZ/d7fgPiOO1duFF6R8mGIgP4qLEfbB8moZbK9
	 p+TSOHFIw7cri5r8VNpeXEu0SyWmeS9vqjSUlhShgqpRnomxvVHND46xpLa3O63Dlr
	 XLR9ALop/kHOsAHtMsd37+ZjxYjisk8ffKbFJ93izQdiNmdUJ/pYGN/i6PW0VtliHs
	 EU6QDPcMmhx7YOuTd/7S1jTi9nmkrSTJmnayielI58AU19cMuz1nkkfvynDB4fP++0
	 AqyEuQTiqnAxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE639D60B4;
	Fri,  6 Jun 2025 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: b53: fix untagged traffic sent via cpu
 tagged
 with VID 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174917343049.3314262.7602954077671451203.git-patchwork-notify@kernel.org>
Date: Fri, 06 Jun 2025 01:30:30 +0000
References: <20250602194914.1011890-1-jonas.gorski@gmail.com>
In-Reply-To: <20250602194914.1011890-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Jun 2025 21:49:14 +0200 you wrote:
> When Linux sends out untagged traffic from a port, it will enter the CPU
> port without any VLAN tag, even if the port is a member of a vlan
> filtering bridge with a PVID egress untagged VLAN.
> 
> This makes the CPU port's PVID take effect, and the PVID's VLAN
> table entry controls if the packet will be tagged on egress.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: b53: fix untagged traffic sent via cpu tagged with VID 0
    https://git.kernel.org/netdev/net/c/692eb9f8a5b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



