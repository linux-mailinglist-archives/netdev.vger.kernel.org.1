Return-Path: <netdev+bounces-80579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A7687FDCF
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 13:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1341C21D3E
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC803C062;
	Tue, 19 Mar 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLzpKwkG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B5F3BBC5;
	Tue, 19 Mar 2024 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852628; cv=none; b=iS3MRcg1REpFWwJXzqgCc4Shuz0eOdR2NUmXwve2jNQg0j1+FzColuKvwsqkEJmNao7/MQzFdGZuosxD74ehfj11NA1gmF+OFxcIzH8a9aYjK7/GVT0ZmWiWFViteQiWaH7AVyIFkwfU4a8gy0REF7gkCspj7fpVe3TrSJNsPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852628; c=relaxed/simple;
	bh=B56wff5eeIZ9ad2gtLHNgCGSkLvK/KDNlsG1NWzjqG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BAi0FzbrlrGvqCPzRBmZBfd8PUr9f3zDhVGJoFK9pRTp1pHQDnsHGwOeY1MGnaAXvxCnZr8M2+bJ82vEn0AVlYOs/fRILrLrxpQCcYlE4Zrwg2p19LEA8RqXuQnpydMaE4OAYToomnvSJqJogVFmVG5yNLxXAwZHub/XHj16aXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLzpKwkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DAD2C433F1;
	Tue, 19 Mar 2024 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710852628;
	bh=B56wff5eeIZ9ad2gtLHNgCGSkLvK/KDNlsG1NWzjqG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kLzpKwkGU6V0r4mqoBZjFo3DZeyph4uql2UX+m10jwZE/pu9q2JCMbNdpEDEbBR8i
	 yLlE9JEVx5pP6Q0efogpE2vqpqB8zZ3Tlb5daaMPnnIU7P8UeBtG6/P8hObh7iFeLk
	 MPXyiWyCHVDk2xlB47+xxB1m6yMT7Rw0DSf6xXzMT1sPe7SGu6gocOzO1P5vTdmyQU
	 qFZXthHmIh6PA2e6ZLIqqX0xrULvO4RjQnpbpFx3Lnlx48ahvdjJOjUEItBrinQKEw
	 2jf26iZccCU7aLSIU0Ddh28J6Uys7/23ve02PEaRyjKYD+r+IVa6cJCNKEwGHJoSTT
	 daUztTiDUMHkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B260D982E0;
	Tue, 19 Mar 2024 12:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] xsk: Don't assume metadata is always requested in TX
 completion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171085262830.28386.2900898887950974537.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 12:50:28 +0000
References: <20240318165427.1403313-1-sdf@google.com>
In-Reply-To: <20240318165427.1403313-1-sdf@google.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, d.albano@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 18 Mar 2024 09:54:27 -0700 you wrote:
> `compl->tx_timestam != NULL` means that the user has explicitly
> requested the metadata via XDP_TX_METADATA+XDP_TX_METADATA_TIMESTAMP.
> 
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> Reported-by: Daniele Salvatore Albano <d.albano@gmail.com>
> Tested-by: Daniele Salvatore Albano <d.albano@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] xsk: Don't assume metadata is always requested in TX completion
    https://git.kernel.org/bpf/bpf/c/f6e922365faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



