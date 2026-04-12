Return-Path: <netdev+bounces-277917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNagFOUT3Gm0MAkAu9opvQ
	(envelope-from <netdev+bounces-277917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:51:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF5C3E639D
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC4EE300BD92
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC69310762;
	Sun, 12 Apr 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L91UO+LU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5830F7FB
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776030655; cv=none; b=odHmRtI+T7gG2G1Pg5+yn5mX2OpNJkGqSfTQyviHOhk6mShUGiZT0A8w0r8hMc5iTmS6Hs1uISfYkm+cNRJWiz/7UzQtbSZG4CDF374J0MlghCykjlIjoLDgBA1z0y6KILi9XsZJWJN0w3BduyRvTKzYMTAc+Ok2NhQcg6xO/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776030655; c=relaxed/simple;
	bh=/t4l+0PSDew4xSp+1nWnF+ozTJBLyCV/73ecjT9pj6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gPIvAuEr8/3eBK7+rnCyCF3yuduXeAhdUJf7KUPFYNViXa3bV+8eRWTWiWeD/4lw7oRLR4uArbCYnX3aJOi/5Vjd70YL2UDCgLbpaS69LUdKEUBWI1pzLGG0JN18/s/FLnWGRdobLLzIJXacSmlpt1jTeM0BULRHghGt0yw1rQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L91UO+LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE235C19424;
	Sun, 12 Apr 2026 21:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776030655;
	bh=/t4l+0PSDew4xSp+1nWnF+ozTJBLyCV/73ecjT9pj6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L91UO+LU2i0DbAIc3UzaL2Udk+VMasy6a84kHuaQe/FTv0/NMfZzz5rtDsNNL54Wx
	 FxuqzeOApwESKjQ/En7hxODFjMmvmtJd+OzaQRI/MyAqXdfy1oLvAKPdWa1qRBJAcw
	 1MT3H9z9KntrgUSzdIKSkMO9jT709eRfpTG2NQ+UvZnsjEYZXgvDKtl6ZkRVuU7yjp
	 VlBL8zKTw/f9QpsXrQ904dw71UlOo5Utt7toZBzXLZuKn3QseloFew58EkwWtdGQol
	 zm/t+bXOPKQ5EAqkTTajRq2r83GwTp3dPd3C78yOONwovPZFg8zQ23P6gdmfYxVExF
	 7H6swc5x6gevA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC743809A8C;
	Sun, 12 Apr 2026 21:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: reduce sk_filter() (and friends) bloat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603062803.3833036.5244809516542083212.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:50:28 +0000
References: <20260409145625.2306224-1-edumazet@google.com>
In-Reply-To: <20260409145625.2306224-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277917-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ABF5C3E639D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 14:56:19 +0000 you wrote:
> Some functions return an error by value, and a drop_reason
> by an output parameter. This extra parameter can force stack canaries.
> 
> A drop_reason is enough and more efficient.
> 
> This series reduces bloat by 678 bytes on x86_64:
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: change sock_queue_rcv_skb_reason() to return a drop_reason
    https://git.kernel.org/netdev/net-next/c/900f27fb797c
  - [net-next,2/5] net: always set reason in sk_filter_trim_cap()
    https://git.kernel.org/netdev/net-next/c/734ea7e324ad
  - [net-next,3/5] net: change sk_filter_reason() to return the reason by value
    https://git.kernel.org/netdev/net-next/c/c78bcbd51976
  - [net-next,4/5] tcp: change tcp_filter() to return the reason by value
    https://git.kernel.org/netdev/net-next/c/97449a5f1a58
  - [net-next,5/5] net: change sk_filter_trim_cap() to return a drop_reason by value
    https://git.kernel.org/netdev/net-next/c/fb37aea2a00e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



