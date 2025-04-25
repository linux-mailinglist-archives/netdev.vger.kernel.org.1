Return-Path: <netdev+bounces-185790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08007A9BBB5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E603B6E1C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7629A32;
	Fri, 25 Apr 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4T5+cbQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041981E;
	Fri, 25 Apr 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540391; cv=none; b=AcvuFu5qV8SuYzLrOevvXq2lqN11nDjkd5TY1njvMVN/XLbYHS/yf9YlrJ3cX1fTnB2rHV00MhQJMMfPRy7pYqEaW3tntIox7Tj853LIdSz7mn4aqn8PyB5b2hbfs3xsZvVWcBY0PvjqhaFyB04bnqvd2SurzaZgX0qIhufVv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540391; c=relaxed/simple;
	bh=aKhiMsG/T/rd79GeOlANyesH2TRaoF5Ms+z9wo9rTA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=it+qyFXoQt5EaXOEWOvAyyh7KDvbfzN/HutnorsVkGYPNYj8eSmYFL11SJnqemEOORjyKgh9VQ8ll5vj6xDx66tUe4gMObfyhfE0fKOJlAPD3HhD4jph3n2ECRh+xNY1dqwkCpflm37fCsWCQ9QS8uzsKJMP2d20dWqTZxqiwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4T5+cbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16900C4CEE3;
	Fri, 25 Apr 2025 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745540391;
	bh=aKhiMsG/T/rd79GeOlANyesH2TRaoF5Ms+z9wo9rTA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N4T5+cbQHAfwiBwuLYnzAYnys+qIOrKSb30ica+PoEnC0jLjc2/SXZ2T8WxSL3Lry
	 vo49BIxDTNQWx9vRge8s/3/3FA6pqiG7mQik5TCie9JfZBXXywG+WxVNP3NUIaX0VS
	 QlzKpjKJpzfoa7C6zFIsQVMSys7naSp7wEW44TyRID4ghVXymprjELaxb0Y3c1IGWS
	 k1UlMLlWsyvrXfgtMC5TTOXpDNEgqfjO+Mfp3uDZsgbvbCV0W3PZJSaIhRdgWx2roO
	 zGGSORIfTJWkWZDnq/g1LH0+5vdmvl7WBvmkVhnveKZ/UwRVxEkuw0Okuf7K2jxSt9
	 K68QncOZ+Qofg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFA3380CFD9;
	Fri, 25 Apr 2025 00:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] xsk: Fix race condition in AF_XDP generic RX path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174554042976.3528880.6984313799746363403.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 00:20:29 +0000
References: <20250416101908.10919-1-e.kubanski@partner.samsung.com>
In-Reply-To: <20250416101908.10919-1-e.kubanski@partner.samsung.com>
To: e.kubanski <e.kubanski@partner.samsung.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 12:19:08 +0200 you wrote:
> Move rx_lock from xsk_socket to xsk_buff_pool.
> Fix synchronization for shared umem mode in
> generic RX path where multiple sockets share
> single xsk_buff_pool.
> 
> RX queue is exclusive to xsk_socket, while FILL
> queue can be shared between multiple sockets.
> This could result in race condition where two
> CPU cores access RX path of two different sockets
> sharing the same umem.
> 
> [...]

Here is the summary with links:
  - [v2,bpf] xsk: Fix race condition in AF_XDP generic RX path
    https://git.kernel.org/netdev/net/c/a1356ac7749c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



