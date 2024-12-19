Return-Path: <netdev+bounces-153218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CBC9F7356
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 04:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E62188A42E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0624016FF3B;
	Thu, 19 Dec 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+ZDaMJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B67081C;
	Thu, 19 Dec 2024 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734579015; cv=none; b=pccxs+xFE4uk4tVq0L2WrVlCgDzPP5iG/fq6NE4tHnanE/cdEjyya7uPTyga3dh1AkaBZG6zYpZgyH8TUarpDX0dJ+0/LueFB0SMCEdibZNuD8ErDMz66P7aif+X31eSwpfG1lVGj/I8dlQkMSPi8IMPYj8+FloIHP4odrcbDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734579015; c=relaxed/simple;
	bh=IybUAG2SzJ9naf0k2AUBrWFTel9UL9KuH+SEC8esGY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LjILdFsSPTodJv8WDfNCEuaziN2MqqiFF2rePf9KcKsLDnJYgEkzmndPO1LU4UsXtP1ZM35FW7ZQL6Xa6DL8i8jg5AP/VGag0Zw5sWV6ZQi42DDx+MlEztBR5A9NF897+Z0s3qBalOX4uprJxesoSLYmGSKmp4bw+ZF/aRofE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+ZDaMJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395E3C4CED4;
	Thu, 19 Dec 2024 03:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734579015;
	bh=IybUAG2SzJ9naf0k2AUBrWFTel9UL9KuH+SEC8esGY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R+ZDaMJdLCtVb/cu7WDGoHD11HP+K7pGTppw3Y5dtHsMcuSnWZOMhzqt7Du65UtP5
	 UmEIicC/gyPkvyQxxaXaM8MPdN0++MyZfbCRYg8Mw2w3+qi1s3B1UqzFvmDx5AXL8F
	 l9zp8MTU0j7l6R7Gq43uK6QMF8MFrTnvsfto1Hk/m5/LgYZbOWlGNVxmN7WlhVGjKY
	 UdcbqC2dXS0ArwDbnWn1leBp2ivU7EnILxKRDh3SnrBwYyga4g5LJTyT+TzIeYd9Fi
	 Ak7dfJOpUtQ9x2TvdjSqkRRMr2XuSv4rzXhdF3Klzrk+EzSfN1CSqQfS9zX29E4qmX
	 75IymLBDdIzsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0733805DB1;
	Thu, 19 Dec 2024 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] octeontx2-pf: fix netdev memory leak in
 rvu_rep_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457903274.1807897.17464555527251593786.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 03:30:32 +0000
References: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241217052326.1086191-1-harshit.m.mogalapalli@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, error27@gmail.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 21:23:24 -0800 you wrote:
> When rvu_rep_devlink_port_register() fails, free_netdev(ndev) for this
> incomplete iteration before going to "exit:" label.
> 
> Fixes: 9ed0343f561e ("octeontx2-pf: Add devlink port support")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] octeontx2-pf: fix netdev memory leak in rvu_rep_create()
    https://git.kernel.org/netdev/net/c/51df94767836
  - [net,v2,2/2] octeontx2-pf: fix error handling of devlink port in rvu_rep_create()
    https://git.kernel.org/netdev/net/c/b95c8c33ae68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



