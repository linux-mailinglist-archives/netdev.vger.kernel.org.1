Return-Path: <netdev+bounces-203520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D6AF6460
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778B27A8F46
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC36323B616;
	Wed,  2 Jul 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqDfQzDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCF23AE96
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492987; cv=none; b=bwES3O52nnDcWkPqordES1ELbjQ60UOhU3Qz/Lh0vmPflEAd95QkCxKy+UBK3+GofieW3j5hDLJ10V5jkQ9FnZBYEKd5nM86ijFyFMP32t0hfoo6AI9aLxTrxd0q4OvKnPWmnaugDRGHYk1gmPla6uzFulaDJE9bMmSYvoQONvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492987; c=relaxed/simple;
	bh=6DmYX/L6B4GZtmcaN9+RBsihZo9tzuazIn3gNdnVvcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=msb/CXtlDMSHDFRci2HiVGZ3XQ4GB0SQ1ZtTzEqCUFyAoA3fQwgngekji98UAYfgatjySh7z2nxznbUz1fFLdczj/SLUDHFIHygCsAOFrkq8vWW5XipIfz0IFVtZrN3b3KUmdSbIxrY2oCq60LTGRPqU1GzCHBCS8ZWQvSuqJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqDfQzDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41738C4CEE7;
	Wed,  2 Jul 2025 21:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751492987;
	bh=6DmYX/L6B4GZtmcaN9+RBsihZo9tzuazIn3gNdnVvcE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqDfQzDUtYLt8b0H1WKIMdV0g3ae3mo6tKnhJgaNMPfZw30+Q1YsgRt9tkF0GyZyK
	 9uzKRzTlh79bZWu70QM50Qx1wv9LGOBBJFHELVwDNymuYUIYu7yMSAzYK56vlXJTwh
	 cTqSADMZUqTQw966Y97aRXTQDRYCRQF0cAd1GlAtownJNLfc2crJIrrCrXtBr6zzer
	 DWbTnblpGH/emauX6LvbhMRq1o+roUwNmble71iMEYHJ4BPkqKQSMD0FxtkfGWDaAN
	 WOhh5Tyu/6rdTCykWtx0Kpt4WKruiuGFvvb3utv3Fyzp8OpY0ohNqVZnpk+IAm0VRK
	 ELfALFiLG9hHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB072383B273;
	Wed,  2 Jul 2025 21:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] amd-xgbe: do not double read link status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149301151.875317.18312607616810684191.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 21:50:11 +0000
References: <20250701065016.4140707-1-Raju.Rangoju@amd.com>
In-Reply-To: <20250701065016.4140707-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 Shyam-sundar.S-k@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Jul 2025 12:20:16 +0530 you wrote:
> The link status is latched low so that momentary link drops
> can be detected. Always double-reading the status defeats this
> design feature. Only double read if link was already down
> 
> This prevents unnecessary duplicate readings of the link status.
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] amd-xgbe: do not double read link status
    https://git.kernel.org/netdev/net/c/16ceda2ef683

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



