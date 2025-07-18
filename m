Return-Path: <netdev+bounces-208072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC7B0998C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FC75A3431
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CD1F17E8;
	Fri, 18 Jul 2025 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbmFrJvm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05941F1302
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804013; cv=none; b=gkk7EHWo6sDYXHoBM10uDaYCtIi4PycXPs4jXVLLRhhxhcw2nMYWoWCshVQUPQFowQPELEfAhWXqKL9tKTxSUZuL4A2XV1QAlA26izSrGP/c72dykyiHDKGvyvHY7cJ6DFlXKFeFW5jyb+yuCE0qGPi1bjYg6rJ9RTuWRxZEOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804013; c=relaxed/simple;
	bh=f7SwhsxY+q/CplHgTdHlhpgnXLdgxR+P4k48YjqU2+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xz3mPOZ5ScU53LYYiDDpnNoYFarlHj7FyBB+UAZLgFad3SS4Y4Nmiz4eT6Y9v+L2TB5hPtSftdG7XUN+bfp0MKpuqKuZQvLbWotKx8OmZFNAg0quroEcw29OkarpYmyXrl4NAERc+/43BHWVbL093D7o1+k5rNI/1qtfdC2jPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbmFrJvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A49AC4CEF0;
	Fri, 18 Jul 2025 02:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804012;
	bh=f7SwhsxY+q/CplHgTdHlhpgnXLdgxR+P4k48YjqU2+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbmFrJvmmyASvnKjs89BzQUItAhMZgm1MiN2er2uGiqAG7zuLtYaT7h61ZFLPtKEH
	 uXaZhH1o7+mRkzPD4oS+dmhSt7mjfJWaGENgIVJApl3TbAvUoYyvSLlgiGlSGQOHVo
	 ttUu1Yk6pd4NJ9RQrGZo4Z9KqqFS2eRkf+KojfYP9JsBZKX2Ook6dHMeLF2vJSdwCX
	 EQoyzMjrSDMpV6qay7Eq7CqT/We0EQJ2lSTrpHeb+dnTBjWDJQniT4La+E7lFrvDn+
	 wnkopl1lHBpVfDk75MKtPhfCU4q3HAS2Wz091yYwYDwLwpkxaTWTK95xDJGaMm3YZF
	 yzuaE+FD4R7VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC53383BA3C;
	Fri, 18 Jul 2025 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] ibmvnic: Use ndo_get_stats64 to fix
 inaccurate
 SAR reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280403224.2141855.2028690524270156677.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:00:32 +0000
References: <20250716152115.61143-1-mmc@linux.ibm.com>
In-Reply-To: <20250716152115.61143-1-mmc@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org,
 bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@linux.ibm.com,
 davemarq@linux.ibm.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 11:21:15 -0400 you wrote:
> VNIC testing on multi-core Power systems showed SAR stats drift
> and packet rate inconsistencies under load.
> 
> Implements ndo_get_stats64 to provide safe aggregation of queue-level
> atomic64 counters into rtnl_link_stats64 for use by tools like 'ip -s',
> 'ifconfig', and 'sar'. Switch to ndo_get_stats64 to align SAR reporting
> with the standard kernel interface for retrieving netdev stats.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] ibmvnic: Use ndo_get_stats64 to fix inaccurate SAR reporting
    https://git.kernel.org/netdev/net-next/c/efe28034ea27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



