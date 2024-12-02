Return-Path: <netdev+bounces-148227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C929E0E02
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88737164D3F
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE81DDA0C;
	Mon,  2 Dec 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVkruGnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E62EAF7;
	Mon,  2 Dec 2024 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733175617; cv=none; b=uEENcmF5BQDVzm3D8hoGx4MomsbR4GPG1flPk0B0aG2dpqYfUTSKhPAUPs0luW+38jLg98HE4DJxS1GTI8X/EMS0751Qz4Dg0OpTCA3xeD9Aqgj7SAdEBIgQ550ZMnr0lN/dTYmas/fkTHAWeO6PjgS/PjC/hHO/DzSHgNSdKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733175617; c=relaxed/simple;
	bh=ZYW5HxsaW2pCM3n/gu/fF/LyniB4EIceqjfCgltqXx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IqAHTCsG8FATz6csPMGeIebORTE2JQqBFX5WPNpq8J//rUIAX+6lrUDT4SzQVAB6fP6hrgi33HKq+eoKnrCJxGqKU+/jaImSSXGRZopTieQk/FiKiLqzChKxcaxqOsHpen8kEAuT6XFau+S3zyaVT5gU/RVmRo3TXTFlGIKV/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVkruGnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D59C4CED1;
	Mon,  2 Dec 2024 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733175616;
	bh=ZYW5HxsaW2pCM3n/gu/fF/LyniB4EIceqjfCgltqXx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WVkruGncFJQpjjg2WDSmnqYy1ulD4EuQ0YuvkjNkrl5d8B3YA5UGBv1uqqUw82h3S
	 LhR71Mh1/V7YlZ8Y/cI1i8N+22JgKU1pUCk4ovHWQRzsSu4ZgchaMkSTU7JQ/W/R0O
	 gNjFlfKTxMEMty4rSgTIbt/ix0wGGTCTt5cDxaDWdwXPbQbzIwmUMhbnNlMRtl9wIH
	 BcWMhSSRNEmZuoQZ6vMXwooVDbMvnzx6/QQ9A0fs4NQnBFe8ymdhrnGtwDK85UC+zP
	 ReqA60D3xruLxFB26Ddo7+AE73S16WbbFGI5GYukGk34a8fXsGo0oWLQo0G8gUCPTa
	 +iHhViNyaChhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB36C3806656;
	Mon,  2 Dec 2024 21:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] net: Fix some callers of copy_from_sockptr()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173317563075.3902418.2961842712438149169.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 21:40:30 +0000
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, dhowells@redhat.com, marc.dionne@auristor.com,
 luiz.von.dentz@intel.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-afs@lists.infradead.org, kuba@kernel.org,
 dw@davidwei.uk

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 19 Nov 2024 14:31:39 +0100 you wrote:
> Some callers misinterpret copy_from_sockptr()'s return value. The function
> follows copy_from_user(), i.e. returns 0 for success, or the number of
> bytes not copied on error. Simply returning the result in a non-zero case
> isn't usually what was intended.
> 
> Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] Bluetooth: Improve setsockopt() handling of malformed user input
    https://git.kernel.org/bluetooth/bluetooth-next/c/389eeaf59809
  - [net,v3,2/4] llc: Improve setsockopt() handling of malformed user input
    (no matching commit)
  - [net,v3,3/4] rxrpc: Improve setsockopt() handling of malformed user input
    (no matching commit)
  - [net,v3,4/4] net: Comment copy_from_sockptr() explaining its behaviour
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



