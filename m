Return-Path: <netdev+bounces-226221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8FDB9E351
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F404838323E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EDE279795;
	Thu, 25 Sep 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRf4aU4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638625A631;
	Thu, 25 Sep 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791412; cv=none; b=Yl594kKpSF03UNIicIyNK7/ptMwRVjy2jEPGW69FSg9krxGJoVchPVUGhqIz8nOrYS3AuAWjohCKwdJZGW+MypvCT2epTAJ2QGaX6pPeg+VcKfQXJcI2uCwEtYkUbNzk7X6Fy5rXUpEf8g3BD5+HFL6LCbMDMAd/IgnAkV4nK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791412; c=relaxed/simple;
	bh=zlKvZF7T0/CqKIo0w31jcZP1EJcI0GZOAlcXbevR/yY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nsav8+BtNL7wcWOWMNmiSoHf8kLt6wLE8S/ah73trI/uQfPYZ81fltpgVFWgB779U8KtkWqu6TKEFDnvvPCPh+EcI6tfJMw5vAF8Uvv3qoqVzGot5AlrGrkVY3KrEvChUyJeUKCqyFU1LKMJ7Us1QsRRfNb6KGDhG2hdieI4t18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRf4aU4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CB2C4CEF0;
	Thu, 25 Sep 2025 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758791410;
	bh=zlKvZF7T0/CqKIo0w31jcZP1EJcI0GZOAlcXbevR/yY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VRf4aU4SOdhM6cJK5l09eJfHsE35j00Sgehz2jOfIfKvmLvq1Z3zO9eMthlHCQvyF
	 VYhTpWwNmFxjd3ca4U193GEO00GjMWsAq9j34uQmHTj17AWvS/bSYLBx1JRkxVPeY4
	 HQffUzRuHrgpHtaqdIFCaV0npUPgbEeujryt/tZ2ip03GZ5950bct4PeEWaI6T8/gA
	 R9CXttUSggxHwVlsi2V1/NLJTRXgt9zFuAzTeAD6RZ2NS7ytK+d//utNh0JXAQ3NXa
	 j9x70ht+/io43J/yQMa3v5T6NB20CXszF8IMr3txvw9bi5hEu/gzWz3N5CJLhqnf9k
	 l0FWoceXSTJRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F6139D0C21;
	Thu, 25 Sep 2025 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Fix potential use after free in
 otx2_tc_add_flow()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175879140625.2887572.13262332274692355098.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 09:10:06 +0000
References: <aNKCL1jKwK8GRJHh@stanley.mountain>
In-Reply-To: <aNKCL1jKwK8GRJHh@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sbhatta@marvell.com, sgoutham@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Sep 2025 14:19:11 +0300 you wrote:
> This code calls kfree_rcu(new_node, rcu) and then dereferences "new_node"
> and then dereferences it on the next line.  Two lines later, we take
> a mutex so I don't think this is an RCU safe region.  Re-order it to do
> the dereferences before queuing up the free.
> 
> Fixes: 68fbff68dbea ("octeontx2-pf: Add police action for TC flower")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix potential use after free in otx2_tc_add_flow()
    https://git.kernel.org/netdev/net/c/d9c70e93ec59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



