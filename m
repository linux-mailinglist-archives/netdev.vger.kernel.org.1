Return-Path: <netdev+bounces-193882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D13AAC627B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C829E3136
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E7244665;
	Wed, 28 May 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us+8qX4Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B163229B0B
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415596; cv=none; b=e67mBf1lnZVM1/PE01eJ4yp91bwYXu7ToSh5VKGvKKgOm1L/rSohoV4PPNxOKWl5HpnQtoTcsfIyyL6W9SmI/p3glKmd/uCA6fRZTd2NqVEFBG3YwgZI5hOdhU20i2e6AhiMe1zZz48qvtro54EHZ+qAxzqfwaj81orzxBx+qcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415596; c=relaxed/simple;
	bh=Ap6NAH3Ohnk4e4xUmbXtYo5Qmts1GML6ejcgRnLYDa8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LDQe+hwbYEy+6znNJ7BWrrQpRJ/lGLRA8MBakKHHzevEIQZwzLXWGKfYoV7DJh5riJHPlD//xU0CNvhIp+60/Ev2tZlOcAVq9jUrhq6FrkSwK6iLhflfxy7IZ2PylHr42dWLD1DUY3n8OVSIAFmr57QdZ37Krdvcf5v6pz4z7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us+8qX4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E06C4CEE7;
	Wed, 28 May 2025 06:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748415595;
	bh=Ap6NAH3Ohnk4e4xUmbXtYo5Qmts1GML6ejcgRnLYDa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=us+8qX4ZK1WihWKUiRVFSSPovyzTCcXKclto/jV1g6tTIf73fnOqX8z1AYi7dpfww
	 ghhQOxl1MH/E4knHAOmup7Y3sNBkbBN9KizCbXR+aYzN0+BKOovkUEpgbcbz72e4ZR
	 y9ECHN1UXWeSfVd2nuZS2MORQMZyuyohm3lFPVug7vePDGsjmwGq/K2EKzamF8Wf6F
	 /qWIz7Gvcb7B82kTu7H7EcxMxmDPm4tckhLMj0XKV5b5qOlS22vBE2dL4ne4gOMMF6
	 HKMTh1D1SrXR9N/XceseURazf9QDaR9g637Hm8B1kQR2CadxFeztfRaohNEtTQyvtw
	 VKzBpmp+YQgnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1BF39F1DE4;
	Wed, 28 May 2025 07:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net_sched: hfsc: Address reentrant enqueue adding
 class to eltree twice
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174841562975.1932259.11802728611294523301.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 07:00:29 +0000
References: <20250522181448.1439717-1-pctammela@mojatatu.com>
In-Reply-To: <20250522181448.1439717-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 May 2025 15:14:46 -0300 you wrote:
> Savino says:
>     "We are writing to report that this recent patch
>     (141d34391abbb315d68556b7c67ad97885407547)
>     can be bypassed, and a UAF can still occur when HFSC is utilized with
>     NETEM.
> 
>     The patch only checks the cl->cl_nactive field to determine whether
>     it is the first insertion or not, but this field is only
>     incremented by init_vf.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net_sched: hfsc: Address reentrant enqueue adding class to eltree twice
    https://git.kernel.org/netdev/net/c/ac9fe7dd8e73
  - [net,v2,2/2] selftests/tc-testing: Add a test for HFSC eltree double add with reentrant enqueue behaviour on netem
    https://git.kernel.org/netdev/net/c/2945ff733dee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



