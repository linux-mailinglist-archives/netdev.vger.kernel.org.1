Return-Path: <netdev+bounces-183113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C2A8AE5B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 05:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0C217E997
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7EE227E90;
	Wed, 16 Apr 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXnvyzUF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AB227E82;
	Wed, 16 Apr 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744772996; cv=none; b=M9gC+U892Ar8eQffACtWy2jD2KAROFYTxyvtMhPsN6no44L8W4fVAKo79FGBPu6Jt4oUR66b0cz0S66TrVTBf5uvVZb3t5pIAD9o403wcReSQUGZ3RzlSIhw+cMQOyxjaOCehWlRc7hIQJSBIdDZ7OBJMLuwqlREhlxibUpGnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744772996; c=relaxed/simple;
	bh=pjwuOhl+6YnLRO0UJWY97LUYEwC0+mgIl+EW6AZdz3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qN2AxiOqTxsrqtpRKLgRyS3EIhadEq4oAlVfzryAwSbfeEEdQuuzPEt4jDskWm2t6+ktU1G6Yb8TzL0iZW+ssZesDSenwjO/ZOPJPkaA21ovx4GeHqSXN4gRSZFttwq0gc1U6NtSTTjWo3+QdWXitRXBP9KTPEr2b9A3F6rpt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXnvyzUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF5FC4CEEB;
	Wed, 16 Apr 2025 03:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744772996;
	bh=pjwuOhl+6YnLRO0UJWY97LUYEwC0+mgIl+EW6AZdz3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SXnvyzUF3PkfQxd3KY6C5nx9Z7fGtfz7q/PDdxxbjw0UC1s008kRVlDl93zijVNtA
	 KVz7FG+RMh9Z+FXd6u2o4FJ7i1Vx9qOr8Q9FrUzagsh4mC3z/XoCahfxEzQyZgQkaA
	 F5tmhBw0dvPPjwahH/qfPfHad7iBDEUFFELtlk4BhKk4XREv4aX33gHU2iHLY3ekOV
	 L/V/ES9a7ozknm23AqcXMNmOGHjb+7R2AaLbwQF5nd08BfSGHLQnhYvp97rLZxaOni
	 8hKQRVf3Fd3R39/lOf1iyezpfhCLKvE930/6mioecx1jyrhKv9LDbktKlG+L6FoTwP
	 bnXBisWu2dbWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F593822D55;
	Wed, 16 Apr 2025 03:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] batman-adv: Fix double-hold of meshif when getting
 enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174477303400.2860234.7904751019740013737.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 03:10:34 +0000
References: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
In-Reply-To: <20250414-double_hold_fix-v5-1-10e056324cde@narfation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com,
 syzbot+4036165fc595a74b09b2@syzkaller.appspotmail.com,
 syzbot+c35d73ce910d86c0026e@syzkaller.appspotmail.com,
 syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com,
 syzbot+f37372d86207b3bb2941@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 20:05:37 +0200 you wrote:
> It was originally meant to replace the dev_hold with netdev_hold. But this
> was missed in batadv_hardif_enable_interface(). As result, there was an
> imbalance and a hang when trying to remove the mesh-interface with
> (previously) active hard-interfaces:
> 
>   unregister_netdevice: waiting for batadv0 to become free. Usage count = 3
> 
> [...]

Here is the summary with links:
  - [net,v5] batman-adv: Fix double-hold of meshif when getting enabled
    https://git.kernel.org/netdev/net/c/10a77965760c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



