Return-Path: <netdev+bounces-184925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E44A97B75
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B45A1B6098F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217D2147F5;
	Tue, 22 Apr 2025 23:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhjACKLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6ED1D61A3
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366391; cv=none; b=KT5Sgj/a9sPY1bXUbZhlzp2bIwNWHt53ozMpwNwx1HLWhjGCaHECl0hh5abMx6f9uhth+WAAx1OlpPaLJzGvW8gbvd5/cgqfM+dYuMJupWNkqYB9qv8DMkDXah/auLhiD/IHIjv+XUkDbDh3hgtjkyqQDLOm6VW78LbEuvgxjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366391; c=relaxed/simple;
	bh=gHASo0LA3+NHcIbbHdHyN3xgWxNUwRFJ2ZyMxMuqnKU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kkC7jJaonOntL1q4XrbkXBI3w/bolP204yGCPnAQqVkoPF95v7pl0orIEOigbHLuhzq8NKU4rwlYhfgYay1xXlT9wWAwsCRdNma1QHX0utGbi1cNwHPjxOAVbMOK5X8Cz9yLQiz7j6jqtn/VwCMALxxka5s+8gEHHXLwJePZhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhjACKLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BCAC4CEE9;
	Tue, 22 Apr 2025 23:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745366390;
	bh=gHASo0LA3+NHcIbbHdHyN3xgWxNUwRFJ2ZyMxMuqnKU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhjACKLhrKbawYyaj+bOf6zp3e9fwOjQ+O5NlgRatqaE1rjtB6avRniCxlc8UAMBS
	 GwTlHXFkB4CDItJFKuP2mWJ6Znm08FzjqCeb+SxJ3sU5HDOiElHB8sgsp+6dqjDSq+
	 bMIAQNZPo9d3axkI7v3K11Q55iPVWvWU1LQL8XGGrGSik5GgCKP8SM0l1wfj34CjyY
	 zonrlMdpvGMtdDFzahYDTas855W60v1cZWwYBRO2DAD0MVa/lE26S/1FHeivzNrZaD
	 WJpql79u76VuHGoppsJsHSnaWbecYP1KoV9AWxOZ8PcJokSm98Nxa26NCIwBMOWtjT
	 ksurPzVtxPQkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C78380CEF4;
	Wed, 23 Apr 2025 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: fix suspend/resume with WoL enabled and
 link down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174536642901.2092468.9000223067110745952.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 00:00:29 +0000
References: <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1u55Qf-0016RN-PA@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexander.duyck@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 qiangqing.zhang@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 17:16:01 +0100 you wrote:
> When WoL is enabled, we update the software state in phylink to
> indicate that the link is down, and disable the resolver from
> bringing the link back up.
> 
> On resume, we attempt to bring the overall state into consistency
> by calling the .mac_link_down() method, but this is wrong if the
> link was already down, as phylink strictly orders the .mac_link_up()
> and .mac_link_down() methods - and this would break that ordering.
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: fix suspend/resume with WoL enabled and link down
    https://git.kernel.org/netdev/net/c/4c8925cb9db1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



