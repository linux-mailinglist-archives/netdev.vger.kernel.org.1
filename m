Return-Path: <netdev+bounces-165807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CDDA336AF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269E73A98F7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EFB206F34;
	Thu, 13 Feb 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ1ptCpr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2042063C5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419806; cv=none; b=jgu5FyVefTZkQHpSgA0Bu+MyRnl5e0APqKv0jifoiu3kkDo5W/wY04hm2xNvqO02cenJGgkQOdRgzfH1gZDs0Llxvri6Nm+6yOp9FpSnOwpcGaKv7uGjbfUbFyxefiaOb8p3WVP3jJ6xL0pDL/lLyL8DdGvRBd6Z6qGGdPbavW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419806; c=relaxed/simple;
	bh=Canau+8HT8WPrhl8UBgh9MBOJN0SAm1j1Xlz/VIEmd4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gG3XXiQ3qhdI/QUZ6sTPvDV1dM0FyTpvLYQGWor2OayuuE0ASRbCss51sruu3ro7Q64NddFHW+Hn1+YYABoBTgHKqHrhge5B1M5ms+lGRiivXtdH55sVqPG0IRTj4G06xRBAQh1/zSkIEBsu522x9+tfw3QtZmzRjaGRElxvSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ1ptCpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B128C4CED1;
	Thu, 13 Feb 2025 04:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739419806;
	bh=Canau+8HT8WPrhl8UBgh9MBOJN0SAm1j1Xlz/VIEmd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IJ1ptCprpPakF3m7XjNqKz9Q1fZHQfH//15oSXUYxpOxXvvkYUfKeheeKut2ODsz7
	 ic1iy8rt7k3ZJZlP/r/1Gb4YNu8an7H/vuCSko2XL7zA7Cvo16N9+b4ZySztvhB5BL
	 ZvL2Qt1FD7Xsqev5Arq/OA+z+loTR0P59TDnxgyJAjjaHSIvQvNx88+3jdKUWt8bvZ
	 TL0ZuZ6qvu/JgV3AmXWnHin1QWm48iwzzUnfDzwtHOQLuwKd1gJerlvD3mzXFbfY45
	 BKfUeTOWuDJ/5atdmymsOCA+euggAda3D5vqAk/B6WoqarzZgCVXz4c+ujaWTZdU1F
	 kLTp7elcBq4/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714C4380CEDC;
	Thu, 13 Feb 2025 04:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] vsock: null-ptr-deref when SO_LINGER enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173941983526.756055.14317513883684281023.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 04:10:35 +0000
References: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
In-Reply-To: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com, leonardi@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 13:14:59 +0100 you wrote:
> syzbot pointed out that a recent patching of a use-after-free introduced a
> null-ptr-deref. This series fixes the problem and adds a test.
> 
> Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] vsock: Orphan socket after transport release
    https://git.kernel.org/netdev/net/c/78dafe1cf3af
  - [net,v3,2/2] vsock/test: Add test for SO_LINGER null ptr deref
    https://git.kernel.org/netdev/net/c/440c9d488705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



