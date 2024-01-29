Return-Path: <netdev+bounces-66760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F38408ED
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3DA1F278EB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E490066B40;
	Mon, 29 Jan 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUgEkjHX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9437664DE
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539824; cv=none; b=Yzb6fXZ1NHtSim+eokSH534wFbsZF8v14o/W5lQ6l8uT6Or3kA/OHMkZn2p0gVUoQcg+qSQ3a9Y60gV9rvONsFkkPK0sWTE6rXvMuUiMo/amBD6zQiWfibUDGMiUn5vhrqEL8sq5RKuTRN42NMjEKM2SNOPA/b//PMctYM4/nPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539824; c=relaxed/simple;
	bh=uwouNDmv+9ERI7pqlTzaefP7/GtTIDFjIkw1h8/A4Ao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GbhRNUyvVucSFbOiUjuMIFbY/iwq3B3IBnCUJVv0HZTY4CcQS/SrZT87AKsyC07Fh/9sSuas5D1YGa6nADh/PAskbs4q69C8cRUDSzNWUXJDSIzvAWD7PA/e9hz0gUW8kVOF23iuDdAnrH1/lZ0NFMaPyInfHUkDGCqQmuhiTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUgEkjHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D141C433C7;
	Mon, 29 Jan 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539824;
	bh=uwouNDmv+9ERI7pqlTzaefP7/GtTIDFjIkw1h8/A4Ao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TUgEkjHXFPwVKGC5dTvDSNxz08E4ousfJ20nw9CXJpNQS42eL8Fjv9fzDjQ/sk+np
	 mCdMOWu+gftRbXFZWyDb7DIHQbDilBOoyKXy3ii7DNINvgpl+N6noLNLkgekm+bd+c
	 vTNuF+TnrpIgHps3VayZfZPpLlEf7YvwiTZsV7Ca8ZIBvE2WM06XXvuXhDUvWf9Vxq
	 v4zEboEjpvOp1gPxX0MTleWUUJsxeknB1xLRmhTWki+MzK6/qLlZ+QWdepUXtDybBc
	 nXAeixezT6T5QRc79bGwScctn9IvyndJnCbpIr+JHEVJNLO23xRv371+pdlYGDjann
	 1s4EU/E7nTKtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24F84C43153;
	Mon, 29 Jan 2024 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: free altname using an RCU callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170653982414.10827.9707272890466683041.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 14:50:24 +0000
References: <20240126201449.2904078-1-kuba@kernel.org>
In-Reply-To: <20240126201449.2904078-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, daniel@iogearbox.net, jiri@resnulli.us,
 lucien.xin@gmail.com, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Jan 2024 12:14:49 -0800 you wrote:
> We had to add another synchronize_rcu() in recent fix.
> Bite the bullet and add an rcu_head to netdev_name_node,
> free from RCU.
> 
> Note that name_node does not hold any reference on dev
> to which it points, but there must be a synchronize_rcu()
> on device removal path, so we should be fine.
> 
> [...]

Here is the summary with links:
  - [net-next] net: free altname using an RCU callback
    https://git.kernel.org/netdev/net-next/c/723de3ebef03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



