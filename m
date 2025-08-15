Return-Path: <netdev+bounces-213915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FAAB274B7
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 03:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0C8AA0B07
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232C19D8A8;
	Fri, 15 Aug 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE7eXqo4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA31990A7;
	Fri, 15 Aug 2025 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221398; cv=none; b=uJKeCcvoK3XLlptnaCqfcsxj8FyT8MNzNmb8KeHme6hv4sDTbN2UDQgVogPXOY8hZ6eNUS6QOBY8K5KTdF2I3wkNXiuO3xLW3nZbQjMU4ic34QCDTif1tMxkXGnd0jmce2LGSGx9nsMovUzcgrHLzrTzTZ2+du9BFSp/pqr3YNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221398; c=relaxed/simple;
	bh=lZQ9QRRVgo42yFVW5XyEOLzKK8kOJQGa4ftxluS2M2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ro8bMQpSe+P50hF4xjdaPI1vfpmz1/hqT8l/AM3F8mICuglAtSn09sBOsYUtZ7uMXbXyyE0mJQcTPwv96n8VjPfCDnyH4UY3s6B40E7vzFBjtmkppdADMnoCiDkPlcNGnDj+N/FCEXwYkgKjjeWKnkMbbq/RQw+xd6UPVTwOf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE7eXqo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711C6C4CEED;
	Fri, 15 Aug 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755221398;
	bh=lZQ9QRRVgo42yFVW5XyEOLzKK8kOJQGa4ftxluS2M2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JE7eXqo4l2LuDKz72HqAjSk3I5Z6uQbuKZMb3EXkrZDLfE2JYt+fdRhQyi/rZXlnv
	 4W1uUYy6RwsOTjoHxI4/UbmT4OXAvo3uONem28U6cHsrf40DNE57M4QjcFERry9Evq
	 2fQ1QHpbcrtdZE01bOqUeLSYcoED40ZokZNzVXOzQnofuJYvzO/QQw+LdCDi0ZuQ9s
	 S03V+s0p1ODKfOAIXPCPRovbsX5wBvRvan2Op7/+SOE1UfA4Dyc64CiUDzBrzmQRA/
	 vHUOk77xqcDUHene9Vkfu3Kpzw2ogo+wQKJPCv5zlxjsCro+d6W3bk6QsSUPmPunzY
	 8zaOtlIMDJWEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA039D0C3E;
	Fri, 15 Aug 2025 01:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtase: Fix Rx descriptor CRC error bit definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175522140949.510661.17207824271959160883.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 01:30:09 +0000
References: <20250813071631.7566-1-justinlai0215@realtek.com>
In-Reply-To: <20250813071631.7566-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
 larry.chiu@realtek.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 15:16:31 +0800 you wrote:
> The CRC error bit is located at bit 17 in the Rx descriptor, but the
> driver was incorrectly using bit 16. Fix it.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] rtase: Fix Rx descriptor CRC error bit definition
    https://git.kernel.org/netdev/net/c/065c31f2c691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



