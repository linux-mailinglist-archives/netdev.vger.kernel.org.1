Return-Path: <netdev+bounces-172678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA11A55AF5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D243B13E9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7827CCE8;
	Thu,  6 Mar 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzmu15qp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63C203709
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304400; cv=none; b=NBMMUWfpJU0teEusTAojTCJFGI6VlCEZC5DXRBghBA+3XDyOJeTmQEB7CuJQ/dPxoIq5+L3uCAnCJLeZm+62agRUjPPkuVBvTNzOgIvdrSgiYA3a+7LiiJmFDKr4WfZFbcs39aBdu1QV8keXXzDHPgscgbqjCtX1HEuBNVNmnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304400; c=relaxed/simple;
	bh=emxzmeQoV90jOMUN+sghwG9Iapc81kvHylrex2K2SQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aXDCprJN50MCQFjUGwIqdMopQ5dGtH6pdGJZUYKGNDN2ybZKvVg877y3jlN4QQNAZcirUroC/fV4D2UlgAOVAlyhljP2mpQDm2eZ4Bdzui0jRwM1nLu39KB/gd0tDF3fnLHP4fBw3BaHy2bhoydCICan/fbELViaMxLSh9DBCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzmu15qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EC1C4CEE0;
	Thu,  6 Mar 2025 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741304399;
	bh=emxzmeQoV90jOMUN+sghwG9Iapc81kvHylrex2K2SQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qzmu15qpNBeUNAGOvVtYjyrFW8GD+KK8PPOdD/YPth7RhmDqWWjFz71/4pwTiF7CW
	 vP1eo8OF1neqxogtQF2mMDvF23SS9hS4ow1IdTbX67aRvc1fIBryQ+nzLwdYIQUeNf
	 ro7T3y/Z7kqCMxr3jl4sj78QeZAlj2gHe8wMUQ4mTqiXBXtDc+b5gDRAq4Ofw4yFlW
	 Ko03dZIq5GDKmi3wE8rZCkuTB0P7PdPOtf2RVgT3cT7wzBGs4vfSWQaTY0IoczF79I
	 1pr9d/UjqUOb7hd8kTIrM5eK0XJn2Cai8Ubs3y0iFq7nL3z3DqN/xE+wWzmlRwZwlo
	 a34JEZiCwtVcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712C2380CFF6;
	Thu,  6 Mar 2025 23:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: mostly remove "buf_sz"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130443328.1819102.15961350109548099161.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 23:40:33 +0000
References: <E1tpswn-005U6I-TU@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tpswn-005U6I-TU@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 05 Mar 2025 17:54:21 +0000 you wrote:
> The "buf_sz" parameter is not used in the stmmac driver - there is one
> place where the value of buf_sz is validated, and two places where it
> is written. It is otherwise unused.
> 
> Remove these accesses. However, leave the module parameter in place as
> removing it could cause module load to fail, breaking user setups.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: mostly remove "buf_sz"
    https://git.kernel.org/netdev/net-next/c/072dd84b4c5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



