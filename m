Return-Path: <netdev+bounces-79267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8836B8788FD
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B361C20D4F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44255792;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+U9qrID"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457F854F9D
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185962; cv=none; b=ONLei3u7XnrEFG7mvboTKhXX9ZllwvrIaofnP3ZvHGwDz/Yccull+rFOzWKMlMJK93Jb+k2Y4tleyk+WStw0WEBeVrxYm/ms3SPc0NlS9q2xKSjKMHQIIioX2Di4Ymj6n54ri9ajSK9UAAWrudcnYNHPxTsiDfoJ5X+uodu61PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185962; c=relaxed/simple;
	bh=rPDbE7RB39eJOewL0W8sEM8zqzJzgVQAs9ycXM7lOM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PBcw/qILImE0uuC2xQW5t+0hf8vlLDeUVFJp7CztrgDHvV5P6duElwRFmtS3LUBesZSKq46j7JLuuNZgqsWicZtylvVljgPnUZvQBDgOzYui6nXzO0ABcMYYhcscm6gWPo35scqe2sTH09f1XBkcKIvUVFXD0Y1VlmXeQ3JBf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+U9qrID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 130C1C43399;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185962;
	bh=rPDbE7RB39eJOewL0W8sEM8zqzJzgVQAs9ycXM7lOM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I+U9qrIDUqkSpwn/0D5qnO6mzvHRMdRBG62BsEN1AoJMWvi1mekD7kd4lQ6GXQ81H
	 1TlIaZCoByyS30/7Nl6c34VkoroCTx4/LMyM2UbmUZVwbwAjZ8+bplRU2j/qo6riL1
	 W8WyYYP+pzj2OQR6VM5JNPgCJbtaJg3i1yIJjjqyaK9PxEgHN8W186CaIkUBhb9YD2
	 /R7yNR4rIIxO7JjNuZFt6n1GJOF04aqw3iDXV8i177pQGvdAo5AnIvYXrA9kxuUT6k
	 kiDhwFeZnabEufywAr69Q1YPaBFXWSlxqFzdvv7m8uDTNOOs3pcisFc9mOc7H2sH+T
	 9REIzE5FnwztQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E92F0D95058;
	Mon, 11 Mar 2024 19:39:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: no longer touch sk->sk_refcnt in early demux
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018596195.1144.670475648217886446.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:21 +0000
References: <20240307220016.3147666-1-edumazet@google.com>
In-Reply-To: <20240307220016.3147666-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kafai@fb.com,
 joe@wand.net.nz, ast@kernel.org, willemdebruijn.kernel@gmail.com,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  7 Mar 2024 22:00:16 +0000 you wrote:
> After commits ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")
> and 7ae215d23c12 ("bpf: Don't refcount LISTEN sockets in sk_assign()")
> UDP early demux no longer need to grab a refcount on the UDP socket.
> 
> This save two atomic operations per incoming packet for connected
> sockets.
> 
> [...]

Here is the summary with links:
  - [net-next] udp: no longer touch sk->sk_refcnt in early demux
    https://git.kernel.org/netdev/net-next/c/08842c43d016

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



