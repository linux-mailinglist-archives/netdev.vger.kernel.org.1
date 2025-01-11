Return-Path: <netdev+bounces-157352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF9A0A060
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A795188E40C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83FE40C03;
	Sat, 11 Jan 2025 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXPEHrfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C88B10E9;
	Sat, 11 Jan 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563211; cv=none; b=DM2DBAQ26dwj+tzza+6xKAC95Zzd4TYU5romjJE+y8634U06KTKMBCOt55t2YiPX37ZIjjKrfBDpSvV1ar50jTpdCBdgJubYDqPreJYlJSmxrP9JR/jrdO02wE3X1jCAtbWPBcID4xCpjgkxDyxUrh6zUhYnF26on1ytSYUf1nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563211; c=relaxed/simple;
	bh=FgA3uodaBynKkRaTEsX1skUMLCtUgS6WcLfRma2use4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AAZF6zUTPyYOuBHzvycGjfCCW1QptnTzozvvvHga7+lD9frsKMRdTBJbnj8abnSyU5cznixZJFe+OuH3Kz7YccbSxGB9VpsqLLF7b9o1FD5Rlyg6JmrAgwT+NQNR2xStSO3Kpfu8pxLbgnRlpqbd41JmI22TDDt9DBizyhI8YtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXPEHrfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F355CC4CED6;
	Sat, 11 Jan 2025 02:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563210;
	bh=FgA3uodaBynKkRaTEsX1skUMLCtUgS6WcLfRma2use4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bXPEHrfAwlfsHUJh37K/V4PS8KH98heYBX3sU8FMugOcHz7oi6giLLc2QP6S50lLK
	 pbqfZiWqklZNjZq7WOo0sp5zfuW7RW4ho34L/i00c7W6Zn+KeKC2tFv+z/XDwzA8W7
	 sWOgFrPzrvGWSrJSu0qY0KzNYOiWNTflw61/NesRCubVShJUu801rr4M1fkPrGYsVs
	 eIV/Ml0wGHGhvhAyWs8m3ZviheJu+wc+wDQo9EEfMb7/1Rh0QRuWHAemE7v3dp/dwT
	 3+jX+ACzUkYXMhOYlaXxbtIisNPj00Ie3+Orku27mF3tvgwTEOpCotQh3IXiGRRyHu
	 0UWmnO9yQ8LSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34669380AA57;
	Sat, 11 Jan 2025 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: fix lockup on tx to unregistering netdev
 with carrier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656323206.2272951.314255670629847295.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:40:32 +0000
References: <20250109122225.4034688-1-i.maximets@ovn.org>
In-Reply-To: <20250109122225.4034688-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 luca.czesla@mail.schwarz, felix.huettner@mail.schwarz, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, pshelar@ovn.org, f.weber@proxmox.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 13:21:24 +0100 you wrote:
> Commit in a fixes tag attempted to fix the issue in the following
> sequence of calls:
> 
>     do_output
>     -> ovs_vport_send
>        -> dev_queue_xmit
>           -> __dev_queue_xmit
>              -> netdev_core_pick_tx
>                 -> skb_tx_hash
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: fix lockup on tx to unregistering netdev with carrier
    https://git.kernel.org/netdev/net/c/47e55e4b410f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



