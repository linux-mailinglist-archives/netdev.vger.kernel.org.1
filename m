Return-Path: <netdev+bounces-102780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8790493C
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6DC1C23003
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ABFFBED;
	Wed, 12 Jun 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egd7vYH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A3DF62;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161234; cv=none; b=CJyStezkqIzkWmHb7SaSm/TVDtu9V/HnM2HMLfkxcPZH0oYUEjBORrW1Dl+E+B9Bn3rbKIobCNFxZ3zBDAP213NYlnmoaKVqNp/Dr+9d6hvSWmQOTZnJJ0JPmsYlMJjrheDDEFAUNv1iq2QD8u0zQLik+LeswZK/kh4Lchb7T30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161234; c=relaxed/simple;
	bh=RUXhIiQ650W0ISBjZa4FmMnAKv75xiQwfEYjljSa7Ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xu15NcoygvclC+6cxTODXLIzzZtvu47iChHiRBe4WJwDGrUKFRDfMi7MvCpINs8Dgp5DbUrW7AgZGPlY5RG8/xYmqgec+wSS2dmNaoJ5Z+wd7q0wATQTml79n7e0hhKLioVbOt/CR4DlKy0Xla61DHttyojprwPdd19PUY5B0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egd7vYH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76F78C4AF1C;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161233;
	bh=RUXhIiQ650W0ISBjZa4FmMnAKv75xiQwfEYjljSa7Ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=egd7vYH1h06yWv8wIa6eIzpxyiFUxxsgc0Xa6iL2sUlaK5z+aOlL3Tf6Y8oMYUD5S
	 FyT3vKJPg/pWFid861HMka3h4RIMx/eAjWQu6dp1lg85sGWvGoazpCugjZ6cb4LzWk
	 SwUXIVazp6Z5EpI48fh4mjpncZbgu9atizAMR5dTqZnlLBCN0ldzTAHkQii6jnye8J
	 tu0fy2/sIjNfiJqw9ZvtzFeS/ldiqSK8WJbYHdHeB77VC3BLcO3vrw6ha/0uXWLzi0
	 uQvCt4Zh4/NIK2JtzeZAzqYvT1pNPU84Hfv0f2aU1DrNyaAG8Qv0B9CCtGlm8uB6yH
	 Hk/Ec/XJtCs0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55327C43614;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v5 PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171816123334.11889.9944196119101092125.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 03:00:33 +0000
References: <20240608143524.2065736-1-xiaolei.wang@windriver.com>
In-Reply-To: <20240608143524.2065736-1-xiaolei.wang@windriver.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: olteanv@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, wojciech.drewek@intel.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  8 Jun 2024 22:35:24 +0800 you wrote:
> The current cbs parameter depends on speed after uplinking,
> which is not needed and will report a configuration error
> if the port is not initially connected. The UAPI exposed by
> tc-cbs requires userspace to recalculate the send slope anyway,
> because the formula depends on port_transmit_rate (see man tc-cbs),
> which is not an invariant from tc's perspective. Therefore, we
> use offload->sendslope and offload->idleslope to derive the
> original port_transmit_rate from the CBS formula.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: stmmac: replace priv->speed with the portTransmitRate from the tc-cbs parameters
    https://git.kernel.org/netdev/net/c/be27b8965297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



