Return-Path: <netdev+bounces-149954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0429E8321
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EBC281B58
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E6182D0;
	Sun,  8 Dec 2024 02:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbVo+cSs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD44C9D;
	Sun,  8 Dec 2024 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625015; cv=none; b=cueGKP8Dh8xrcIly5AHKNaeYhWpdqzkOHAZYsjXToPIMb1WxsE4ajqwEwGIGdQcecQ2GLNqzRt5BAE3cFaEGM4FudlnjOC5/MZi475AG5Hp+xL89SsSaGdPIrspsATUBomiati9AbY9lILO5Efl++/D2Kc21TR8IIsOdT54+Clc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625015; c=relaxed/simple;
	bh=vHQj57/Wy7hQSU5mcdZp993GWoU3DY6UmrIfuZL9SH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bz1LtaR5HcBmpmdq9iJaVt5k4UNcHnHJvovnH7l9vLrwoFX0Avlp3+Kj5Q1qqPrkJe2ISOYmtkjTYiY8nij+/DnMGi16T3b6sK8xLHoTU2o5ZKoKTNJd7Ax7Lk5hjaAwpUnZ/ceCw2kOXEIRSJfx3IOc+Es6yT82ctB5A/YIrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbVo+cSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56A2C4CECD;
	Sun,  8 Dec 2024 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733625014;
	bh=vHQj57/Wy7hQSU5mcdZp993GWoU3DY6UmrIfuZL9SH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbVo+cSspdLs17xwhOe0eTSL+NodFUig141nms+yPKbWD8sLZo6gZ633b3YeBihCo
	 8in306ACXz0Ui+GyAkqymrjfIiY+VwU0rsB/VqsjGvb4lCizgm42bcUFQnU7rbnXNO
	 29Byn2w2Ck7ghdONu9Ww2yxy73SgzsdfJBsVQuuHo86g6trfhTavixLIdbFis0a0gB
	 ssdoGSTY1STgqTb5gw9YjeEJX2goqkiRLEfwXWuNBa1fHvnacFdWoA4q2Dh3wrRC98
	 uVW0b86dy5ThiPhJrZ5nPulmbq/iPguGcl3P4StJ/v6wLYc7iyh7zVxS2oTNKAcs6U
	 DtvPmzNZJERGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34863380A95D;
	Sun,  8 Dec 2024 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] rtnetlink: fix error code in rtnl_newlink()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362503002.3137016.194680734913660375.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 02:30:30 +0000
References: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
In-Reply-To: <a2d20cd4-387a-4475-887c-bb7d0e88e25a@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com,
 idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 6 Dec 2024 15:32:52 +0300 you wrote:
> If rtnl_get_peer_net() fails, then propagate the error code.  Don't
> return success.
> 
> Fixes: 48327566769a ("rtnetlink: fix double call of rtnl_link_get_net_ifla()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/core/rtnetlink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] rtnetlink: fix error code in rtnl_newlink()
    https://git.kernel.org/netdev/net/c/09310cfd4ea5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



