Return-Path: <netdev+bounces-211634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5EEB1ABB7
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 02:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BF63BE696
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2615ECCC;
	Tue,  5 Aug 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frd1RzSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850C155326
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 00:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353804; cv=none; b=NgPQoRGVvathHyVSGzZ39fMzan1ZCEqTGFWYnHKAuezhD6BEJxlDB4LE3d9IH/1Gz70K948Ka47O6d3BYolZWenHnjZz2ZLzFbU1KLHkXNbqoHcBspGZ4qK1kAKyjijQYO/RbS2aJevWoPUokFPcddyQuxfejubAvC2P1/HFug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353804; c=relaxed/simple;
	bh=KOez3NXL+uNqf1znoJqoOIy++cZkegqkXXuvT86mFgw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u+qilEuTSHzesB4wmIF2t/E8bgMYa3ldB/RIJ9YVGC/6KT+egU4lBqtKm4so5QtXMpqoz1nzT4sOPxxUoRfNmHXag8b9W9IwLlJjscNJatEOzwqdqis8u4M1F5+NMFug3qfhKhZS+F9e04eFBkXCSU2ykN2IpLFQXX4LGuIL6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frd1RzSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AEBC4CEE7;
	Tue,  5 Aug 2025 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353803;
	bh=KOez3NXL+uNqf1znoJqoOIy++cZkegqkXXuvT86mFgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Frd1RzSYJgpD54VrK3h9w+rgnmyxLTJqfcpG0ywzFNozthUp91zLriJe3CEfjRDcO
	 0ps5x9xy840beRt6ZmPXHF2GkumPA99fGXfuteGQqO5CnPx1vzeZbwMHYWR127OmTg
	 B+SMbFmRkxi+JirC2lzhvy3HCmAtm4VnT73U3D3WmZ0sqMLCaYiFfOd3Fa3Qbr1cf5
	 zv6IoqUOl3EFRRhOsAG2azI8XBg1xIiY5Q1CrDZSCS2yCBg2AUUS45xoZ3QVZMz0rD
	 l3YYUcGAyBmtoA4eX3rfNFa5vZINPygbB/MzrwDTidv+LuSmvIzQTlF75o+R63CfvP
	 dEjgo86S/jpKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BD6383BF62;
	Tue,  5 Aug 2025 00:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: devmem: fix DMA direction on unmapping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435381700.1400451.11085719618072517804.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:17 +0000
References: <20250801011335.2267515-1-kuba@kernel.org>
In-Reply-To: <20250801011335.2267515-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 almasrymina@google.com, asml.silence@gmail.com, sdf@fomichev.me,
 dw@davidwei.uk, kaiyuanz@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 31 Jul 2025 18:13:35 -0700 you wrote:
> Looks like we always unmap the DMA_BUF with DMA_FROM_DEVICE direction.
> While at it unexport __net_devmem_dmabuf_binding_free(), it's internal.
> 
> Found by code inspection.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: devmem: fix DMA direction on unmapping
    https://git.kernel.org/netdev/net/c/fa516c0d8bf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



