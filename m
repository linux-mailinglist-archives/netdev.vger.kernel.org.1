Return-Path: <netdev+bounces-101369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6EB8FE4E7
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481BF1C22EC4
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FB0194C9F;
	Thu,  6 Jun 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUGMZrCI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54337194C88
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672233; cv=none; b=YgrnJd6Uqg652sYOrOiOl9ikCespTjh7Q0IzQoNjIq8lB4iFGbRQd/kXKqeLyDp9qFqo2tuywauKlTle/ef7mIihWrMOxW79XbYzBSBqYgdjeYNFzO/qc0BOMueZxbBaC9UdaT9WA2a1cbTSCH8ZziGp6An9wjfoldu1Fe7ZrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672233; c=relaxed/simple;
	bh=B0nnUGYwMyX+DdqlOlRQ4Wm9nPTF9hikc1v/wsAg4PY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PB2FwS/dpi1h7/MBSLxjlaQoaotklc2tHYltgY2yDX3jqimG/0hKJy12ctcjhq4BhXmCEwW4osdJynS866p6D26f0NJy6HUdihf09ZcD5+7+1l3hV4u+EIxv7Yeboc/ojrFEsQFwvKLdWz9qnFuDYuCPAo3rjEuUnHFj5jvuILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUGMZrCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD1C0C4AF09;
	Thu,  6 Jun 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717672232;
	bh=B0nnUGYwMyX+DdqlOlRQ4Wm9nPTF9hikc1v/wsAg4PY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PUGMZrCI+Hh0T4XXEtHbHC02tfSAXfMSUyjp8UEHJ+0dD2+V/gM7vbJj8fPI9ZgqK
	 o6KJ5x4IjjXR1dSfPvIrXx3xljkTWcmBJr/296Q3EqhT03GqL5Gm1ihoPCs3x4XW4s
	 b14g3eiEh5ixmG36vk0Xivyejti4owQ/1yaX101+toJ0T3kXjaZZYuDPnqWr9QGg9o
	 Sz1SconQ5GNCrPtk2xU+FgoZvnsV1tcLRfTblWjEePLwlRYjnOL41OdzGBzr/2SjCi
	 Bw4A3QSHDbzPoiORga2WgO6DaZOEGGVJpJqw4UzgHBsIIULsxesHQlbMAzMaWX4uoR
	 xlClj+Coqif+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB320D2039E;
	Thu,  6 Jun 2024 11:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 00/15] af_unix: Fix lockless access of sk->sk_state and
 others fields.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171767223276.26965.9686336510263273632.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 11:10:32 +0000
References: <20240604165241.44758-1-kuniyu@amazon.com>
In-Reply-To: <20240604165241.44758-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 4 Jun 2024 09:52:26 -0700 you wrote:
> The patch 1 fixes a bug where SOCK_DGRAM's sk->sk_state is changed
> to TCP_CLOSE even if the socket is connect()ed to another socket.
> 
> The rest of this series annotates lockless accesses to the following
> fields.
> 
>   * sk->sk_state
>   * sk->sk_sndbuf
>   * net->unx.sysctl_max_dgram_qlen
>   * sk->sk_receive_queue.qlen
>   * sk->sk_shutdown
> 
> [...]

Here is the summary with links:
  - [v2,net,01/15] af_unix: Set sk->sk_state under unix_state_lock() for truly disconencted peer.
    https://git.kernel.org/netdev/net/c/26bfb8b57063
  - [v2,net,02/15] af_unix: Annodate data-races around sk->sk_state for writers.
    https://git.kernel.org/netdev/net/c/942238f9735a
  - [v2,net,03/15] af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
    https://git.kernel.org/netdev/net/c/3a0f38eb285c
  - [v2,net,04/15] af_unix: Annotate data-races around sk->sk_state in unix_write_space() and poll().
    https://git.kernel.org/netdev/net/c/eb0718fb3e97
  - [v2,net,05/15] af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
    https://git.kernel.org/netdev/net/c/a9bf9c7dc6a5
  - [v2,net,06/15] af_unix: Annotate data-race of sk->sk_state in unix_accept().
    https://git.kernel.org/netdev/net/c/1b536948e805
  - [v2,net,07/15] af_unix: Annotate data-races around sk->sk_state in sendmsg() and recvmsg().
    https://git.kernel.org/netdev/net/c/8a34d4e8d974
  - [v2,net,08/15] af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb().
    https://git.kernel.org/netdev/net/c/af4c733b6b1a
  - [v2,net,09/15] af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
    https://git.kernel.org/netdev/net/c/0aa3be7b3e1f
  - [v2,net,10/15] af_unix: Annotate data-races around sk->sk_sndbuf.
    https://git.kernel.org/netdev/net/c/b0632e53e0da
  - [v2,net,11/15] af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
    https://git.kernel.org/netdev/net/c/bd9f2d05731f
  - [v2,net,12/15] af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
    https://git.kernel.org/netdev/net/c/45d872f0e655
  - [v2,net,13/15] af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
    https://git.kernel.org/netdev/net/c/83690b82d228
  - [v2,net,14/15] af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
    https://git.kernel.org/netdev/net/c/5d915e584d84
  - [v2,net,15/15] af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().
    https://git.kernel.org/netdev/net/c/efaf24e30ec3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



