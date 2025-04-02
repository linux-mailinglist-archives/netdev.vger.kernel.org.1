Return-Path: <netdev+bounces-178923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A41AA79913
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BF716930E
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFFA1FAC29;
	Wed,  2 Apr 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjIneLXb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B06A1FA177
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637203; cv=none; b=upIH7x+MZ+aa+z64jwMeiY86gmZxCQ7/VYyWlafwxvoWcHqvQoRYe5Tc4V+8fjzPzO7OJlJOZJ50w8saVnQ8NJeZRMiM/LqJkZ+1nbf606+oNU8Hnn7tvjHdB0WoLf5wUCyapwD4kRvtDqjWcr8QxNVz8cMww3yZMpsK1cNh0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637203; c=relaxed/simple;
	bh=t/LAek9BHPq+4Uwq3WuerBeiaAigDokCVq7F0NObbJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQTY1UYTF1So/0/vLIqq6DWCCKIeCdU4hqilPSZ0RVXLfEj+qG9fc6SQ0Yj4OoZZMX/8eBiNJOrKDA3VRYTpiv6L/Zn/VtXnuR71HbOvJ4JXKPBnmZo1ZHOZESR6eg4xF1lfStDtu9hqWreMde4mBQcabYVZV1lC7MMYUA+4WUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjIneLXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11397C4CEE7;
	Wed,  2 Apr 2025 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743637203;
	bh=t/LAek9BHPq+4Uwq3WuerBeiaAigDokCVq7F0NObbJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NjIneLXbir3nUbEGraD09YRgUBuJzlSu4Q3GdTjt3cbP/Fj0ftEQkKsJOo70K4nyk
	 GbTkQKc1CXlEMMApcnfQw5CJ70Qt2sSivxPH3OlQW5sASajNmuUPWqBwFwsgPYn3eq
	 +xgqbl6RGENzQ7D2k5Nmn2uE4zxDAXDnTEUzQFoOxIMetezLau6j3U/cwe8PHcbGKa
	 mZRVKAjZEYu5iO7G4Mc3SB7GSUSDpQFlm7wfZMWcTfd2r/y280gY608APF2axNVosn
	 VPJtvmtpjc5rz+2gwX3TynMaTlpJ/VNsbMssjaCFZ38lBIGbZUgZgI5uXD//bN2gJP
	 3aJOUp2F5E1KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAC380CEE3;
	Wed,  2 Apr 2025 23:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] net: mvpp2: Prevent parser TCAM memory corruption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174363724001.1716091.16388905575771046869.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 23:40:40 +0000
References: <20250401065855.3113635-1-tobias@waldekranz.com>
In-Reply-To: <20250401065855.3113635-1-tobias@waldekranz.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, maxime.chevallier@bootlin.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Apr 2025 08:58:04 +0200 you wrote:
> Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
> information, from concurrent modifications.
> 
> Both the TCAM and SRAM tables are indirectly accessed by configuring
> an index register that selects the row to read or write to. This means
> that operations must be atomic in order to, e.g., avoid spreading
> writes across multiple rows. Since the shadow SRAM array is used to
> find free rows in the hardware table, it must also be protected in
> order to avoid TOCTOU errors where multiple cores allocate the same
> row.
> 
> [...]

Here is the summary with links:
  - [v5] net: mvpp2: Prevent parser TCAM memory corruption
    https://git.kernel.org/netdev/net/c/96844075226b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



