Return-Path: <netdev+bounces-42993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEE77D0F4D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94862824C2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BDC199D0;
	Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoDopc0f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9C7199C8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DAADC433C9;
	Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697803224;
	bh=D15z/0oXu2m7VQo8gW5F0wjdgIyPA8e7yZ0xj2+0Uyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hoDopc0f1NLUT57g6ES2s/mq+umUbqZ/Y9WmVSY/HnUxiNIedEEBPS+Kvlijd9Vg3
	 XiLydu3tu1WNn/ta40S81xTHKSI6owh1luCzUJtm913hjm+6J6KvgfaPeD/efjc/yX
	 P8AvqAueblWnO8vXmrxN0VwDvgDcjSrw+LxvOsZeqj9YVPx38eEyk8n2+M+Oqz/sfq
	 aYgSy+1DaN7fC3YaD1OICgWmkURBvgtvKmc6d4Y1r96eCbOIuB1lRY85p9z/IKtxFX
	 uSWwMSFp/Ji+f6aNRi1ghvOUGRpkV5i5l2AS3cyx9qYzhaOj9It1ZuRCMAPvJ2yrgx
	 wnSpSYkeCI9Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FDFCC595D7;
	Fri, 20 Oct 2023 12:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169780322412.10600.10310001607168170468.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 12:00:24 +0000
References: <20231019163721.1333370-1-ivecera@redhat.com>
In-Reply-To: <20231019163721.1333370-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, mateusz.palczewski@intel.com, horms@kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 przemyslawx.patynowski@intel.com, sylwesterx.dziedziuch@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Oct 2023 18:37:20 +0200 you wrote:
> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
> 
> Move the affected flag at the end of the flags and fix its value.
> 
> Reproducer:
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close on
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning on
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off
> [ 6323.142585] i40e 0000:02:00.0: Setting link-down-on-close not supported on this port (because total-port-shutdown is enabled)
> netlink error: Operation not supported
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 vf-vlan-pruning off
> [root@cnb-03 ~]# ethtool --set-priv-flags enp2s0f0np0 link-down-on-close off
> 
> [...]

Here is the summary with links:
  - [net,v2] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
    https://git.kernel.org/netdev/net/c/665e7d83c538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



