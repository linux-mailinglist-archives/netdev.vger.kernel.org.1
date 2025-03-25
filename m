Return-Path: <netdev+bounces-177541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25901A70838
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF60F1894452
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9428D25DD07;
	Tue, 25 Mar 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEKafJ2r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8984FAD
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923799; cv=none; b=ePGhqFSAWDM55M2jgwXgk3BimRpjT0bdCQw8YM3NIfAh9Pewio2+mCLeJeU/JQD5mHEYZK3vwFgpZkmw0kfR5K5lB02mFF6qDB3bM/BiaLoxp6GQuI+FQmh2cE5CXdCJTQqpvwkzKtb6pgrWHrmQn4sLUrwYUh6xxkWj8i3Y788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923799; c=relaxed/simple;
	bh=4ZBZEas9JX4RPOUELxrNq4XvA2dxPQQQA7l9LOPb+xA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hGTmrh2oM6UG0mgxXkSjzAgKMgWDNDKEadAEgnjit6muZqYgi2ZX/WtWCOxZRtxPG16QVxYc8jPGjjFcS2p7989RPHq7Ilpxv8qE09H8iq1ss+qdtz5ZNKgGgkq2CeMIwWhdaMA1lCnt16MrdmI46sreE0pYNBB8tc0CA85K/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEKafJ2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37CFC4CEE4;
	Tue, 25 Mar 2025 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742923797;
	bh=4ZBZEas9JX4RPOUELxrNq4XvA2dxPQQQA7l9LOPb+xA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HEKafJ2rzw5ZPa8REfEU1axJnIDBLCUg73AnfqDwO6ZP4tTuMsYngDNbwP4feennK
	 Vq9rZzPB3OftQMVqvna9ZVcdxPwjVW/c4CgBgbGuHn65m6de75VIcWmy+enxzh16/B
	 t0hb3QJKNirsOk/nWSrHs74JpRrGViXrunO4TbWLAkDnURwKcyARIDy0nmgx7kAkvc
	 WUzG6oLwHn3mPsBcknW86siP41pvUt8C1e+W21/8FgeBMkysbaYhRR/cyR1kP3h38f
	 8q9Fgqo+2MfKLNMnWpyFmlF/yRqBzhuSYKRK53fTYnYx+cwcgBD93BDMU3Rk0tiom0
	 SYdat4wcULT2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9A380CFE7;
	Tue, 25 Mar 2025 17:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] net: skip taking rtnl_lock for queue GET
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174292383401.660431.1912162765020068057.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 17:30:34 +0000
References: <20250324224537.248800-1-kuba@kernel.org>
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Mar 2025 15:45:26 -0700 you wrote:
> Skip taking rtnl_lock for queue GET ops on devices which opt
> into running all ops under the instance lock.
> 
> This fixes and completes Stan's ops-locking work, so I think
> for sanity / ease of backporting fixes we should merge it for
> v6.15.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()
    https://git.kernel.org/netdev/net-next/c/ba6f418fbf64
  - [net-next,v2,02/11] net: remove netif_set_real_num_rx_queues() helper for when SYSFS=n
    https://git.kernel.org/netdev/net-next/c/bae2da826196
  - [net-next,v2,03/11] net: constify dev pointer in misc instance lock helpers
    https://git.kernel.org/netdev/net-next/c/e2f81e8f4d0c
  - [net-next,v2,04/11] net: explain "protection types" for the instance lock
    (no matching commit)
  - [net-next,v2,05/11] net: designate queue counts as "double ops protected" by instance lock
    https://git.kernel.org/netdev/net-next/c/0a65dcf6249b
  - [net-next,v2,06/11] net: designate queue -> napi linking as "ops protected"
    https://git.kernel.org/netdev/net-next/c/310ae9eb2617
  - [net-next,v2,07/11] net: protect rxq->mp_params with the instance lock
    https://git.kernel.org/netdev/net-next/c/b52458652eca
  - [net-next,v2,08/11] net: make NETDEV_UNREGISTER and instance lock more consistent
    (no matching commit)
  - [net-next,v2,09/11] net: designate XSK pool pointers in queues as "ops protected"
    (no matching commit)
  - [net-next,v2,10/11] netdev: add "ops compat locking" helpers
    (no matching commit)
  - [net-next,v2,11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



