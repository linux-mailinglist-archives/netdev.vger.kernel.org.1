Return-Path: <netdev+bounces-228003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F0BBEF73
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0713A2099
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C1122A7E2;
	Mon,  6 Oct 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkRG9E6x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B5186284;
	Mon,  6 Oct 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775421; cv=none; b=WC4/fnb0dYocfQvDq/1NoeZQixiAAje0s71qqsWwveuPGBVFSQjoVhiyMLfqvUMbtAhB3yUkTnVkiyjDGo2C5Z+PczeGcj4sXlF5ANuGH56a0XZVIG+UaLWJGenFpR/ya8sZaBd8QWuV6ONEcNKEVPcXGBIWFe+OHp8BdE3Fc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775421; c=relaxed/simple;
	bh=1/3yS3/3heLRUNhz94bbjCBzVJbQ8bv7upwAIwiOxME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HKmDce5ygsdMvUR10k95XDbA77cyFdtUR6bxHbb/BpC2lgjY/MIrTAKBU45/Wm1mx/d8Ik9RHfa/xgyCinI5GaW0B+j4SKBKXZPlT5yRX2MO8+GtHPRSl7JljZ6GA0BbuoLCN9zdZJ7fPwIGoQsXyrvDa3gxcAJYfDIFBKfF6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkRG9E6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05B8C4CEF5;
	Mon,  6 Oct 2025 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775420;
	bh=1/3yS3/3heLRUNhz94bbjCBzVJbQ8bv7upwAIwiOxME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VkRG9E6xLvC1LBBJve55X0FAoV4o0rcgNn+IfAmeZtQZhoFJNqvfmPQQYnk0TF52t
	 VwXb316kbOOzB7gdwf+LRfd9GEREJOuq6/hWZAEwVkz0X0yjiooQTKtkqoLBaMJ6G9
	 XwXkih5bkFyzTR2kb18Vqy4Ub6FM5h1ZUAc2ZkEmWjYNl/Mvzn4WTOiUN73CtHSojv
	 UIoVSEGUZWscWY/7NV1tgB8Qc5WJRlbNnGlWSgjAiVtVyWGKQNo16mKDGfiBZFMRE1
	 VIj5xDlhiWVqIEc027McA3DzS9IRN+eAD8xZz6V0fpTG1budjRUWmkus1YfjZulI+t
	 SPDoKILw6ceOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03039D0C1A;
	Mon,  6 Oct 2025 18:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fsl_pq_mdio: Fix device node reference leak in
 fsl_pq_mdio_probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175977541050.1511446.8119337213640574445.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:30:10 +0000
References: <20251002174617.960521-1-karanja99erick@gmail.com>
In-Reply-To: <20251002174617.960521-1-karanja99erick@gmail.com>
To: Erick Karanja <karanja99erick@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org, david.hunter.linux@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Oct 2025 20:46:17 +0300 you wrote:
> Add missing of_node_put call to release device node tbi obtained
> via for_each_child_of_node.
> 
> Fixes: afae5ad78b342 ("net/fsl_pq_mdio: streamline probing of MDIO nodes")
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: fsl_pq_mdio: Fix device node reference leak in fsl_pq_mdio_probe
    https://git.kernel.org/netdev/net/c/521405cb54cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



