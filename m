Return-Path: <netdev+bounces-100964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AB8FCA9E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4921C22957
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7711C19148B;
	Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFc+fkvO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511E614D6F8
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587629; cv=none; b=TSegPILWa87pUM6f+FvdW8Cho8wXAteUwHANRXJnnStIlEjRynRAXdKxM/FLMqU77oxl37f7f4KHUmqBiW5ttG25OBtjKrK68NLmEfci1o3ouQAWDG2vAu8/F71PA2dyei4V+YKDR4JIWSEXpJ7aS7bwEwMn3oaUAET/X4jT1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587629; c=relaxed/simple;
	bh=nVaj4sMPX2sqyWSrZFSZ+ZrHVAjgL17eJcdv1xla6Rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t+4iCuGBJBnWO19PW8DC6Scd/ABmJOgNUtpllq5MuRHXPOmB4LeeUqpTmFkxXMz+ogkVfMbytYtug68h7x/utWsOMBJ9mdxBjMmsXNpNsvVuJSmA/2EW5aFjsXUDXXBO6TG1ljvXjHoSrig2k+23y59gREn6aAZm3JUobbIfZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFc+fkvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27239C4AF13;
	Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587629;
	bh=nVaj4sMPX2sqyWSrZFSZ+ZrHVAjgL17eJcdv1xla6Rw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iFc+fkvOiwm2qpqx6bT+CAhMPvImQ9bd58bc+0o3+ujbzAvgHpOrR6nsD4RYgIjaV
	 WCcH8/ODUrpxj7u0HJ+/iR4u+1opZGyqCUfFh3Dyqtc0HtirartA2rZgpIPU38iDek
	 RT/1Z8s62HgTuDdNko495l3uxk7BXqKYI022CvDCMeU+AkUD8GttODf1e2QY9l9W66
	 q9hx7LiZmh20op6lrSDE5sTeyGJAHvayD2iQkdZQ6fcVb8CVDu7g1A5amHUfPifRNr
	 aEOwbkVpN+H/jW5A9+emrBXXLpnVOB39VH2mzKUrWfpB388dR47TpDBowb0vf47rbt
	 41gCAy8Eel2Pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AAA3D3E997;
	Wed,  5 Jun 2024 11:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: annotate data-races around tw->tw_ts_recent and
 tw->tw_ts_recent_stamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171758762910.21278.16623475247999381001.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 11:40:29 +0000
References: <20240603155106.409119-1-edumazet@google.com>
In-Reply-To: <20240603155106.409119-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jun 2024 15:51:06 +0000 you wrote:
> These fields can be read and written locklessly, add annotations
> around these minor races.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_ipv4.c      | 12 +++++++-----
>  net/ipv4/tcp_minisocks.c | 22 ++++++++++++++--------
>  net/ipv6/tcp_ipv6.c      |  6 +++---
>  3 files changed, 24 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [net-next] tcp: annotate data-races around tw->tw_ts_recent and tw->tw_ts_recent_stamp
    https://git.kernel.org/netdev/net-next/c/69e0b33a7fce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



