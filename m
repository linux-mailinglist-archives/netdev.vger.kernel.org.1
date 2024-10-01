Return-Path: <netdev+bounces-130822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5D98BAAA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F69282803
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BE71BF339;
	Tue,  1 Oct 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB2jz5rd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E11BF333;
	Tue,  1 Oct 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781032; cv=none; b=lA5hUu8SrdoduDPKkY06mAYcQGEPQMX1MMNshe8b8cJiMqjvxdJCwN/Jh18E/FqG6JbOxgDnyHfnrBtu0diB1YZ+9P3CsBPrb1JedVEIMqvVmxRra5PLR4KkX5I+JRfUSV4i8Ol982dyo88MOp6hN7ZUhWFcqDyINmZQY2eYVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781032; c=relaxed/simple;
	bh=+5/UtwCABVqIXqFPpwfo4yTpYXbi9/kqIYYgKn0CpSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g3Em18v/Qum9I4+LZCanlnY96LdFobaa2xRS5yS3YHQfd9ArC68FpAkmPTqL4CFaFgpvucV5ZTeqE2iZkPm3hpaBz4CpdfnV0M9di57TKHM+8rv5fXwXQZcEAu05zS1gQ/M4JgvumRqhvK67PSeo7ouOvDzFOUQcauFS5bmXdwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB2jz5rd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28395C4CEC6;
	Tue,  1 Oct 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781032;
	bh=+5/UtwCABVqIXqFPpwfo4yTpYXbi9/kqIYYgKn0CpSc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oB2jz5rdFm5P/ZyyVdCg664P+qe128AWhH7AIyiLevU1CHnrJW4YX/EH7bIsYil69
	 3LEbeCLGck9/jRxLPt3Gkqp1zxwVivRo5/8OxaqhR4jlPy5cF33GbnQpvOzq8qhuRh
	 clVTHlu98ZliLeZCmzt1ENB/Wcucj4AuOmEWFsmIHhmjH0XKm4AsmX0ULatMWS+jOG
	 OsIvKSr7Yyv3sJH/RwPrhAawsE6wYCCW504Yu+EUjhZ7z0d+kPTCEDrXakvoq8XXwG
	 xwYocQFnetHIvzHPTKwA48lfeWlI5a1K6SwQULtaOQI+JXND760dTGgFa71otslhrW
	 vpmVe4jDpi5RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 719E1380DBF7;
	Tue,  1 Oct 2024 11:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172778103527.314421.10268831803194238355.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 11:10:35 +0000
References: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, syoshida@redhat.com,
 sumang@marvell.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Sep 2024 02:51:59 +0300 you wrote:
> Regression Description:
> 
> Depending on the options specified for the GRE tunnel device, small
> packets may be dropped. This occurs because the pskb_network_may_pull
> function fails due to the packet's insufficient length.
> 
> For example, if only the okey option is specified for the tunnel device,
> original (before encapsulation) packets smaller than 28 bytes (including
> the IPv4 header) will be dropped. This happens because the required
> length is calculated relative to the network header, not the skb->head.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4: ip_gre: Fix drops of small packets in ipgre_xmit
    https://git.kernel.org/netdev/net/c/c4a14f6d9d17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



