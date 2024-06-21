Return-Path: <netdev+bounces-105618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3AF912056
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0531C217D6
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094E16E883;
	Fri, 21 Jun 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwPxV1gL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F916E86F;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961632; cv=none; b=aIeOZXtHqBe5fuoYFP3AOJZGfK1c7rvETKNgfFl5RxUCi2vSYHYj9KOI+1ahILAzCWk772Fj/VyzFY0HJRFu9oyh1paPENjBDtJqHR/9WFY6ypAI7b7pA+z32jP6tDot/ptkoEuLudpw96qcvbhhEKpcIQRBUB6Rop2yDrLkyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961632; c=relaxed/simple;
	bh=DdfBUSruCOMmVc04SJP9LQBray58f2G8GWiu7++ObGY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gPwji1nrMuH5aOTSmj/ENrY9FK3cOuOiU6dZqhB3qcCqHLFi3Y6/fNCCQVFrhti0u+3viEjlSUExlzA3Mu0SSPfefO8W/VfSaTI9+gwoANg558KpzpX1QssQY3TWUOMXZi2+z42KR4VAAmDcnp7PY/LIoMlltP3P5uFDFPR9+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwPxV1gL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88ED2C4AF11;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961631;
	bh=DdfBUSruCOMmVc04SJP9LQBray58f2G8GWiu7++ObGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hwPxV1gLc8S89t1n0Hk+M6QQuEbWSuBecMPD5HTs4oSSCRvBg6voSgWT7Mw3AJuuF
	 xOVuyKdMB0d+pqVm1ZG/z1U+NN9bOAA48tJivS1eQup/Hi3zEESK95m5jHC9HFumRJ
	 SmUWrTIf2P5RPVI5Slec0SJcB5dcXveJRrOXfTA/bXpDSG/BEd0j3JdFpG8ZkdgrFu
	 w7tmotBE1cVMQmtIJJjQpOwvuuMlzdjbN0kX/mrkGt7qGK1q/8l26amztkK53BZDHj
	 4k6+2H1W/cP0gUcWqFlJzCDYj85ApcTmY4ViS8WfDvrpkzKLUg19XWO2Vq7bc0aN6j
	 vYLipJPpSFN8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78D4FCF3B9C;
	Fri, 21 Jun 2024 09:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH resubmit 3] net: fec: Fix FEC_ECR_EN1588 being cleared on
 link-down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896163149.20195.11694633975704847703.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 09:20:31 +0000
References: <20240619123111.2798142-1-csokas.bence@prolan.hu>
In-Reply-To: <20240619123111.2798142-1-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMgQmVuY2UgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: Frank.Li@freescale.com, davem@davemloft.net, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, andrew@lunn.ch, wei.fang@nxp.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jun 2024 14:31:11 +0200 you wrote:
> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
> makes all 1588 functionality shut down, and all the extended registers
> disappear, on link-down, making the adapter fall back to compatibility
> "dumb mode". However, some functionality needs to be retained (e.g. PPS)
> even without link.
> 
> Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
> Cc: Richard Cochran <richardcochran@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Link: https://lore.kernel.org/netdev/5fa9fadc-a89d-467a-aae9-c65469ff5fe1@lunn.ch/
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> 
> [...]

Here is the summary with links:
  - [resubmit,3] net: fec: Fix FEC_ECR_EN1588 being cleared on link-down
    https://git.kernel.org/netdev/net-next/c/c32fe1986f27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



