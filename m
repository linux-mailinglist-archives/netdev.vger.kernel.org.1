Return-Path: <netdev+bounces-207641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A525B080DA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 01:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB314A8350
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 23:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A311129292F;
	Wed, 16 Jul 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOxyIzgg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37019DF8D
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752707987; cv=none; b=c1slt49aJ4rvqkdw11jjw/cS7vjU53txKEAMsbqzrdcJ+2WI/1v6XlibCsF+de0OFHKr2Jn53t2LwL9foYtrrkAlCu/Cw4PZTXqgOmbMmY6exzKVDzv12UjH77Il75/dU0jbZXx6jAC0brKHcozwS/+/Qr5SpElwZqDl0BpnrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752707987; c=relaxed/simple;
	bh=kx+4ZYsQpDAmMk5ChkJlInSDwEN1VVHvPfCH1VnGMsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eMxkKp42NZXEXKEr/04xdnGI3fQD7az/B9tur5nYZ6aJiKsk/r/4FYwz8hvuhMryIIcGjT4aMpnlWZL91hGIG4wSG5g+sXoWGvJAj73HYaBYqy1OYCHlVpuC2tf+syxxT3i1NBZyl87wyjVWM+jflw8W1MCrADwlJkb+2wLrLEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOxyIzgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058BDC4CEE7;
	Wed, 16 Jul 2025 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752707986;
	bh=kx+4ZYsQpDAmMk5ChkJlInSDwEN1VVHvPfCH1VnGMsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YOxyIzggkLlEmH823frHhPnCuJX+XHd+xkJmlZN7KVcLFmeMS3qkBcvV8DohuVlNM
	 KXNbmyivPFWN/axz4zSbwAs86xg37rEWOCBq696h1fBfpPT+BCI+8f6ec7PRfOhVQv
	 e9jKzQblFVWoiRQF1WHKRaSzNpcZvv6rJNs21NJzk0A1Xk7JGsRBQuv0xaHzsBpc1u
	 NA95JQ6FmHl73FX7+y/+QrtWQH/U1FUyMgHlBjfJzbp+rrOlXoNbUdOkUSlJYzWrjz
	 mJtoXjFHwzEVMjfZfpE+oJE2DksOAcHOj2nBqPzZqReWp17bYvy7553HzQiS5arGJi
	 u24aszmuHZkTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710CE383BA38;
	Wed, 16 Jul 2025 23:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: fix potential use-after-free in
 airoha_npu_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270800628.1359575.17421649701122534916.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 23:20:06 +0000
References: <20250715143102.3458286-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250715143102.3458286-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sayantan.nandy@airoha.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 07:30:58 -0700 you wrote:
> np->name was being used after calling of_node_put(np), which
> releases the node and can lead to a use-after-free bug.
> Previously, of_node_put(np) was called unconditionally after
> of_find_device_by_node(np), which could result in a use-after-free if
> pdev is NULL.
> 
> This patch moves of_node_put(np) after the error check to ensure
> the node is only released after both the error and success cases
> are handled appropriately, preventing potential resource issues.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: fix potential use-after-free in airoha_npu_get()
    https://git.kernel.org/netdev/net/c/3cd582e7d078

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



