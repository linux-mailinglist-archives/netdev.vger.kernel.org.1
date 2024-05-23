Return-Path: <netdev+bounces-97738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86078CCF76
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E904B1C20F53
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E613D285;
	Thu, 23 May 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzYuenIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0E4685;
	Thu, 23 May 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457238; cv=none; b=QV6zQ26Djyz6x39ms3k7vv0u/LJ5viorafrwnBTcw6zvMPVi8MIisHzlsjMfrvHJ6rcINVRIDnrN5PDbLg0dMHEipKaI+9dahkG1E5K4EnH0BZKz5PS/qbEeM6VzJeTbQ/EmCV5LgEJW30D1C2P4H0pVj0CUtv7pFKHdQOqkeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457238; c=relaxed/simple;
	bh=0a8Cvw4MRnzhALmRdstt3jzS71JOV55Hiq8Rf4MC7GY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QzWi+iRWk+/JS22iAOtIK5yRfG7tWR3ECtYzQ0VUThUXrSqO24g1NvN7ohWHI7gqp+zkDKt8g9rVqXCwrmxrY9B6zHPJC3gjFggILDO9ad3tzePMd/Uoe9IOHI1WbZI4fHFuNM/nS5w2Iw8TUH+9DfaMwmh67gur1tnMY4i5q4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzYuenIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE9F1C32782;
	Thu, 23 May 2024 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716457237;
	bh=0a8Cvw4MRnzhALmRdstt3jzS71JOV55Hiq8Rf4MC7GY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VzYuenIM80nW7ntnPLMKGkabfZFxJEqKpu1MT/FiN+h5oFOZBVMiEsfRjHy+DhGrV
	 ajbVyu5aWI+qS78OM9nSfFtJFWM5oyYpZiZ3v//0MVpbCXSBnGUGvA1m+1Ux87pn3K
	 IjQGMWw+XPCWkcC12U7w0naAxTXNyhWIffhiKOUQl4Gcsk0biafl0gKidkq/03f9iK
	 hdsKVIfZrCuBv1E1ZfFANtZZ3zG+01sprUaiNeMjhthCv1qE4uKwHCmbNDRliElsdJ
	 fYD6aQLgtkCRIseVUSWikuXFaIJpg4KPTSy+JN/q73HvLdKQxas3a0TUdA+ORHrihU
	 qMDKs7lv+agqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE823C43617;
	Thu, 23 May 2024 09:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: fec: avoid lock evasion when reading pps_enable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171645723783.24100.7721910085063661458.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 09:40:37 +0000
References: <20240521023800.17102-1-wei.fang@nxp.com>
In-Reply-To: <20240521023800.17102-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 richardcochran@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 May 2024 10:38:00 +0800 you wrote:
> The assignment of pps_enable is protected by tmreg_lock, but the read
> operation of pps_enable is not. So the Coverity tool reports a lock
> evasion warning which may cause data race to occur when running in a
> multithread environment. Although this issue is almost impossible to
> occur, we'd better fix it, at least it seems more logically reasonable,
> and it also prevents Coverity from continuing to issue warnings.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: fec: avoid lock evasion when reading pps_enable
    https://git.kernel.org/netdev/net/c/3b1c92f8e537

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



