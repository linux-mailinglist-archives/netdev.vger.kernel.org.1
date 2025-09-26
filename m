Return-Path: <netdev+bounces-226802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F68BA5448
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FCD1885A27
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE6280339;
	Fri, 26 Sep 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smeZF8xc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46B1F542E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923518; cv=none; b=uGNgdpL+Vod/ut6LdR+dZadUtzy/7GSOcei0JQBnGUTQfnrie14L5pThT30i2VdxN+pG7MEY0b0ubUEt5FS/Y4KMXClgg0ccgb3qs7PylW/tmid6Q3JA+DKTLUIDnNs7qaCigS+I8oZvab2m+JUm5tlrzdsvw5NEGCM0/O2JYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923518; c=relaxed/simple;
	bh=xnzAxGs69h2xGITMcXH/seEam4jp5wyEMbqFU8mLaPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jTLlNcoA/o4mexI4belpBxhqIZ+aDH6bql7eLIO9ehEkcd88zapxMU/mlxdxqjjwddn9ISDr2dclXB0E7VJqlAIeCWQqvqMvJ4kY9uaS+PChKAvtso5AVT3smHjZTTuOucWQVtYVUlP9Utoi9TuKTOYXiB4ZHjyCAIgmqlFkZus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smeZF8xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2C6C4CEF4;
	Fri, 26 Sep 2025 21:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758923518;
	bh=xnzAxGs69h2xGITMcXH/seEam4jp5wyEMbqFU8mLaPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=smeZF8xc3URT8NhrhtUfAm5QWn6PjfADuYnxV4WdwLSzdG7/EJoSq8Pdz4EIUw4fl
	 qT6a7E/boXBR3SolxnazYs5Ovftscn3M7VcLDgwhPDEA5wuIB4gNbpHqXoxPakzB3L
	 dW9pDeccltZ8M8geyrkiZFIN/jMVMJZGXwXsE61CQCRJjxguy2YaZWwoxtwC5S6PAt
	 8MdtGYIE68INMYFh7REZZ8fvSJwp55TVCU2rHxeIXX+faHAtTmmvDyWAfFg08lpr4q
	 X1dFSBNCux3a1ESKG1D7C6MCuFuiUV6CnTB5dOKTP15VVvsmMfT22t/N4T8e/0Kt6o
	 fGWsfdgcNyJSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5839D0C3F;
	Fri, 26 Sep 2025 21:51:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] net: ipv6: fix field-spanning memcpy warning in AH
 output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892351350.70549.1277028925175371014.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 21:51:53 +0000
References: <20250926053025.2242061-2-steffen.klassert@secunet.com>
In-Reply-To: <20250926053025.2242061-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 26 Sep 2025 07:30:09 +0200 you wrote:
> From: Charalampos Mitrodimas <charmitro@posteo.net>
> 
> Fix field-spanning memcpy warnings in ah6_output() and
> ah6_output_done() where extension headers are copied to/from IPv6
> address fields, triggering fortify-string warnings about writes beyond
> the 16-byte address fields.
> 
> [...]

Here is the summary with links:
  - [1/2] net: ipv6: fix field-spanning memcpy warning in AH output
    https://git.kernel.org/netdev/net-next/c/2327a3d6f65c
  - [2/2] xfrm: xfrm_user: use strscpy() for alg_name
    https://git.kernel.org/netdev/net-next/c/9f4f591cd5a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



