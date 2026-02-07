Return-Path: <netdev+bounces-257717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zQirNI29hmkzQgQAu9opvQ
	(envelope-from <netdev+bounces-257717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:20:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2E104DF7
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 602F63008310
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC02BDC0B;
	Sat,  7 Feb 2026 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udXyDYAv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E5F17A2F0;
	Sat,  7 Feb 2026 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438024; cv=none; b=OQ8NncwbfpjaoSV1m+BL+oRSBlm94/JZd8btK/fzA3HGtcy9/Q/cxnPh+THMdE5NRzmhdQ7SAyknIgNCKxVdBN++jmTyOMyoz5qOlnT8iAaKq2x1ZhvUwFJ+WtfEiBEEYANv3TmAqMoNnTat096XTSjZBzHSEt0eFn15eS6GxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438024; c=relaxed/simple;
	bh=s2fnzSSbfVz3F9An5frwxiKGXeWg4nVdDhrnju2Xia4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZqBJby0O5uIl8kOb/AKvjIehqdmz249aj0vxjRW6bql37YiEaRsO7Luum4M/Ae4tsMA/W6Wyyoy+Fk0onD4Xiqs4dMtvMiff5FN+8PH4IzUrTpEEJiHXUofUjiGDTLxxK3EuVwPnL8i91Qw762vG85B8KrKnwbqxrSnQZgDiEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udXyDYAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACBFC116D0;
	Sat,  7 Feb 2026 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438024;
	bh=s2fnzSSbfVz3F9An5frwxiKGXeWg4nVdDhrnju2Xia4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=udXyDYAv11zL+/qzFCIbPXOYGjFHA8UCVVRvrWFOF5KWvy/hEHPe5ncPUrqq666uz
	 CSc1+u/M9GyDyA7HJ2PX4zgjv7QleEQHA24fqBXbcXUAIOFvMj5iXX5L0muBplf0SC
	 IGS8ccnl7nsynf2gQTIyeLI7ATKJZ4EOckv2+/hzYZ/RO2fiace1oMBr9ifN72n5KQ
	 XqDxqd/smT5+ZiiFzEy5BSkewAqoMBKHdWQpnCgQTlcprO0IezEmuoAUHGkRNCSUYk
	 G85hGLK0WdKx8fKo4c0uQh47pElUBF0xHd4tion5kAO0UwOCVUU7NHxiQQ4B43zAy0
	 RMqaRgQ+hfW0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23743809A1A;
	Sat,  7 Feb 2026 04:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v4] myri10ge: avoid uninitialized variable use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043802159.1183264.4531591321232273015.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:20:21 +0000
References: <20260205162935.2126442-1-arnd@kernel.org>
In-Reply-To: <20260205162935.2126442-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-257717-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 65B2E104DF7
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 17:28:09 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While compile testing on less common architectures, I noticed that gcc-10 on
> s390 finds a bug that all other configurations seem to miss:
> 
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_set_multicast_list':
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:391:25: error: 'cmd.data0' is used uninitialized in this function [-Werror=uninitialized]
>   391 |  buf->data0 = htonl(data->data0);
>       |                         ^~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:25: error: '*((void *)&cmd+4)' is used uninitialized in this function [-Werror=uninitialized]
>   392 |  buf->data1 = htonl(data->data1);
>       |                         ^~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_allocate_rings':
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:13: error: 'cmd.data1' is used uninitialized in this function [-Werror=uninitialized]
>   392 |  buf->data1 = htonl(data->data1);
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data1' was declared here
>  1939 |  struct myri10ge_cmd cmd;
>       |                      ^~~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:393:13: error: 'cmd.data2' is used uninitialized in this function [-Werror=uninitialized]
>   393 |  buf->data2 = htonl(data->data2);
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data2' was declared here
>  1939 |  struct myri10ge_cmd cmd;
> 
> [...]

Here is the summary with links:
  - [v4] myri10ge: avoid uninitialized variable use
    https://git.kernel.org/netdev/net-next/c/fd24173439c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



