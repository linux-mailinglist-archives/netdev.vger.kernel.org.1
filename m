Return-Path: <netdev+bounces-91666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B718B3610
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB131F21697
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97E148302;
	Fri, 26 Apr 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3hff/Rq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5B143C5F
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128628; cv=none; b=ENDV/9nRXCWEpWFw9nSgdJfsUeJ2Seqz4F0Xm8wspjQ950jF+qi9GdKYuAdEMZWZHysfOfks7uC8x1VgZ/9sNjr3glwGHPJHAEFUg0ETocxHTC9mpqsQVtuPW65+ACvdESJWGy66CWrLYUxAp12Nt/jZ4tl8MQlY2egY4D2o6jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128628; c=relaxed/simple;
	bh=CQdMSG7W+qCBHca4d0PjaozvCgJjnoMLIhvKqx8s7nQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b0PxVXpz+ghtoOfGxQ4DZrXUpxUdAJSc3bcTiRJtm5+2aQ+rbmdVsJwwMGmYnUIbtWvc4GpkzpAW7j6vbw2zkr/P/QAbO2fl/1Ky4RSJCS4Aq1xJ9mM/cEnr8jls7sz7g1V3yP5D3sIr+uJoYJAyizWpjhAqhe4lKZihc/VbTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3hff/Rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEFA4C2BD10;
	Fri, 26 Apr 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714128627;
	bh=CQdMSG7W+qCBHca4d0PjaozvCgJjnoMLIhvKqx8s7nQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S3hff/RqppiA74ZYc1r9PQmRud5IuGoePE4c6qsmEf50fdEgdtQv+6X/FEuu182cR
	 HacHO7aMR2ZXX3aHoNA4/PENQwztOl5Ag2X2K8rAtWcu7ci5MMm0sw8TeQxQ1BpEls
	 wWsWHR0G/BqU3QVU85I9YO/83FLspzG95j/G1XeApmnHYG5lRkbmAMpl3ptld32mhY
	 989GzMPZj+vVVDd4n/yecv2PHwLl+3NzBHxwfCA2ED0OeM/CCT7lRUXC8bWgCiyCKM
	 VR2J2GmWY0WR//4ZGpKWB5yEgzeGfvkf25q6DqqUafcX+E/WRRZJ0+TITwTCmBlO8N
	 n05AAFASTvjVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF5F8C54BAA;
	Fri, 26 Apr 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] nsh: Restore skb->{protocol,data,mac_header} for outer
 header in nsh_gso_segment().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171412862771.8995.14265893579264294580.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 10:50:27 +0000
References: <20240424023549.21862-1-kuniyu@amazon.com>
In-Reply-To: <20240424023549.21862-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jbenc@redhat.com, kuni1840@gmail.com,
 netdev@vger.kernel.org,
 syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com,
 syzbot+c298c9f0e46a3c86332b@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 23 Apr 2024 19:35:49 -0700 you wrote:
> syzbot triggered various splats (see [0] and links) by a crafted GSO
> packet of VIRTIO_NET_HDR_GSO_UDP layering the following protocols:
> 
>   ETH_P_8021AD + ETH_P_NSH + ETH_P_IPV6 + IPPROTO_UDP
> 
> NSH can encapsulate IPv4, IPv6, Ethernet, NSH, and MPLS.  As the inner
> protocol can be Ethernet, NSH GSO handler, nsh_gso_segment(), calls
> skb_mac_gso_segment() to invoke inner protocol GSO handlers.
> 
> [...]

Here is the summary with links:
  - [v2,net] nsh: Restore skb->{protocol,data,mac_header} for outer header in nsh_gso_segment().
    https://git.kernel.org/netdev/net/c/4b911a9690d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



