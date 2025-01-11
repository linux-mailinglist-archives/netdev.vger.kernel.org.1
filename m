Return-Path: <netdev+bounces-157354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6765CA0A064
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 03:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7A516B901
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660E2152166;
	Sat, 11 Jan 2025 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3WCraHi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209415098A
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736563215; cv=none; b=Pponf847GBPEW8+uOvzawQ8HrXSor+XaB99qKF0fi3JV0vVlI2YuA5uWNWhUtKqdZ1OH9gODCMrbqHKruvo7BUTxYIWLTRNoboxqfZIDhmDYKxeQV64gSS2v2IgULcfVeg2rW6ZjhvF4CIATLOT5pdttST1fKafo9DS7teYWcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736563215; c=relaxed/simple;
	bh=VIPh7a/khK0mijwbVFGI1sEEWx6GGtyYDW567eFuLSw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ikOT/ukzHrJioa+337OdAuoAQl3+50X7swHWfEGE1t+8lWaAJ664c31QnPAE4NNnZYIiauf33dso9yxo6JPWbRg9U3sBXjFWjHi05kMG8UD2V6zulzJ0nca7mi5sq81eugCSyjhKg5P/mq9SC/yOi9Sj8+yxSjA6gfiXqeY74tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3WCraHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1EEC4CEE1;
	Sat, 11 Jan 2025 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736563214;
	bh=VIPh7a/khK0mijwbVFGI1sEEWx6GGtyYDW567eFuLSw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E3WCraHi2DGoGo1TUj1KeMqzlpZpbOnAyxYSQfQ3osq0ALrYkoLZc95BKfClL4BJt
	 NWx9A9TLgx+DoL3OxOTJE+usuwOFY/4bEMna1yvNLUw7fY9AmEe0mR9msx5sBHdC0V
	 OodmLlU7wzrVQ7ywgh3GvB95A9TOIdK+/DC0k9FVPGqEBkTLlejNwMBsLVoNp9TG2s
	 fvLptazV1hDHGtraUWmcsith2mcxT5QuAOA4rtP1ASncpWYB4GyiNjDY0hLOOztdIi
	 T9BhFD5/k9kbBIa696pa0hK7XsQLLNCYgK8rC8g66HGjYlYRo8Lho/Goc3XkNBXCu5
	 AQJIpTqrwGvng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1D5380AA57;
	Sat, 11 Jan 2025 02:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tls: skip setting sk_write_space on rekey
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656323650.2272951.6013172385562660465.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:40:36 +0000
References: <ffdbe4de691d1c1eead556bbf42e33ae215304a7.1736436785.git.sd@queasysnail.net>
In-Reply-To: <ffdbe4de691d1c1eead556bbf42e33ae215304a7.1736436785.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, syzbot+6ac73b3abf1b598863fa@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jan 2025 23:30:54 +0100 you wrote:
> syzbot reported a problem when calling setsockopt(SO_SNDBUF) after a
> rekey. SO_SNDBUF calls sk_write_space, ie tls_write_space, which then
> calls the original socket's sk_write_space, saved in
> ctx->sk_write_space. Rekeys should skip re-assigning
> ctx->sk_write_space, so we don't end up with tls_write_space calling
> itself.
> 
> [...]

Here is the summary with links:
  - [net-next] tls: skip setting sk_write_space on rekey
    https://git.kernel.org/netdev/net-next/c/06cc8786516f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



