Return-Path: <netdev+bounces-207907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A610EB08FD6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851913AC247
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86E2F7CEA;
	Thu, 17 Jul 2025 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCL9IUKb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1332F6F90
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763804; cv=none; b=YCrPjI91gk3JedvzmnwH1i0MZTD7x6Gu1kp77Tbj8vPZDa1ATKzHSu/E/70uddmYQZzGDWcF6rx9EEAQ6t3AqSq0kodJA8y93/RGosWyNBJ8mbQSCjnv2I0GqwRxHb/qpdPNQqEaREPrtZdt8F4/EMStH/XiV/+HLebLSO8dfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763804; c=relaxed/simple;
	bh=KkJVpH15ijmmMzD9tfDzXBUBLovgWH8FujVdHHlzDGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l71NeCbgqYqoYOGGEYl7Ycul+w2UVUA51d6Mw1IcnyDxPnHr01uVuCdfUih13VByEuWJnGYFfbeJIYQ+LxEfFFG8z6F/fUMSR/qedlTgfgzsX0qdIrUPA6lMMKnDdxuWMbzsu4aNUEY1d6eEAKBkoZ8tI63/CESc/5exGslsaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCL9IUKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3DDC4CEE3;
	Thu, 17 Jul 2025 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763803;
	bh=KkJVpH15ijmmMzD9tfDzXBUBLovgWH8FujVdHHlzDGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eCL9IUKbBy2EcbJXXighqOQhK1RKjLS0CCZEnQkClrzNX1yv+zOIysAwaOMZHFGOY
	 thfgRSyINGPPQ2b1bU8mQ+Du+sHKQVa/RRuv7NJIuLpEqjGvPCoqzu46VCcs0IVvmD
	 vgbPmlC56dMDyZZv05x9Zh5kObYfstIyDsytePWj1hsI9rzmIoF2n7oGnS5vobbcx1
	 ThlVlJ2AaI/w+bFZwLdqHUIxxdsE1jrzDw+5JNkYJJZ/Hbs8dgE9okwmhxs/u0+OSk
	 BfmJw4ZWaWkTH8LVOo9ObEZi5JchFjw/RBzkhu8XymnNl5Wdcwc6YZLlq6vyESmFVo
	 VLDVKekkvuJJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD42383BF47;
	Thu, 17 Jul 2025 14:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/3] ovpn: propagate socket mark to skb in UDP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276382376.1959085.6196858187925791348.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:50:23 +0000
References: <20250716115443.16763-2-antonio@openvpn.net>
In-Reply-To: <20250716115443.16763-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Wed, 16 Jul 2025 13:54:41 +0200 you wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> OpenVPN allows users to configure a FW mark on sockets used to
> communicate with other peers. The mark is set by means of the
> `SO_MARK` Linux socket option.
> 
> However, in the ovpn UDP code path, the socket's `sk_mark` value is
> currently ignored and it is not propagated to outgoing `skbs`.
> 
> [...]

Here is the summary with links:
  - [net,1/3] ovpn: propagate socket mark to skb in UDP
    https://git.kernel.org/netdev/net/c/4c88cfcc6738
  - [net,2/3] ovpn: reject unexpected netlink attributes
    https://git.kernel.org/netdev/net/c/af52020fc599
  - [net,3/3] ovpn: reset GSO metadata after decapsulation
    https://git.kernel.org/netdev/net/c/2022d704014d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



