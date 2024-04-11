Return-Path: <netdev+bounces-86892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31E8A0A87
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 09:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7981F2401F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281D13E8BA;
	Thu, 11 Apr 2024 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL7hmSRd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA613E8B3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821832; cv=none; b=k0+mROumS6ywSlh6rXXVkjEQsBFKG2pzBFMImKRaatrpqhMogGKF+vh9gMUPNkupd68zQ0K9rBOSKSlBvRLdUY0zo56lFRRKFScGa0L47rroM/2lYqSeLvgKLOSMfl5bZHkpp0SevUa6TWMSra0BQf3qE5GgG9Me4c0UNPKTQt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821832; c=relaxed/simple;
	bh=jM/Ot6EuWtszlj5c4iHd2/h6hS5FUfVr/w+a2PvmQaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FiZVDz4Iry7kbRuJcJ3BnBj9QT0tBPLerMbVVSteT4Y7oHWfzLfRmi0fb0u8CAgu70YP9xvl6KJAeYokTDf7gcfvtE0NHrtf0yP/UVecF7hpRR2TEIvprSJieDP0A06KowWBz9hpivjkQBtcYRf3HEylqQ3U3mFZqMFsOeXw2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL7hmSRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E3C0C43394;
	Thu, 11 Apr 2024 07:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712821831;
	bh=jM/Ot6EuWtszlj5c4iHd2/h6hS5FUfVr/w+a2PvmQaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mL7hmSRdxWFSawJNZqUMGRB1etLO69i3N8cRA4CmtfHbAv5xgf0xYNGeAlJfmPBpR
	 55TASQ6cYh6WGf4XtLDzQJ/tJrejKVHNEXjwodh7ENufV8EV8NL/GMjfiIiMRY0ind
	 Y+yLvJiL4IoxDznpA87hOJpKe02i1iLqifGASJSTx6Za6+RUw+tCd/Bjig9BMUugnb
	 oA/jbOZyAogu+qjFnJUI4ix3bgFKm0mAKzrtLalpvO6dKduPyBUDt4HTVblN6Ypo05
	 YctjZFhID3hT8In1r+AaXywNe271oPR8V7EHnOKVzUVcwJDyMroUiOj/1tO6J9gdoo
	 MsRYrv6ZfYDkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 127EFC54BD0;
	Thu, 11 Apr 2024 07:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] af_unix: Fix garbage collector racing against
 connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171282183106.1471.16014082254968457229.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 07:50:31 +0000
References: <20240409201047.1032217-1-mhal@rbox.co>
In-Reply-To: <20240409201047.1032217-1-mhal@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Apr 2024 22:09:39 +0200 you wrote:
> Garbage collector does not take into account the risk of embryo getting
> enqueued during the garbage collection. If such embryo has a peer that
> carries SCM_RIGHTS, two consecutive passes of scan_children() may see a
> different set of children. Leading to an incorrectly elevated inflight
> count, and then a dangling pointer within the gc_inflight_list.
> 
> sockets are AF_UNIX/SOCK_STREAM
> S is an unconnected socket
> L is a listening in-flight socket bound to addr, not in fdtable
> V's fd will be passed via sendmsg(), gets inflight count bumped
> 
> [...]

Here is the summary with links:
  - [net,v2] af_unix: Fix garbage collector racing against connect()
    https://git.kernel.org/netdev/net/c/47d8ac011fe1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



