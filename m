Return-Path: <netdev+bounces-216178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A397B325CE
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 02:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4AA1C281F7
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E820B22;
	Sat, 23 Aug 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCQmpO1N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B21BC2A
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908997; cv=none; b=lcx9ydXWb9ysYJ8zgxNfMHsr7ThUvMak1hTOHPivBvsLjishDR9MqLFcxJOayguASMGfXJ8xhFjabKMVtFddwdDTqHsayz22Z2r3Kwb5tsSJHg3BPTAVfliA4C31cVvAei8w31WdQfkaW9jwJ1ToKn0E4RiJpVsrG7g94NgTUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908997; c=relaxed/simple;
	bh=fr9WqDO1kXpknKVJ9BLrEc7r1NzTIi3aSXwDL/pp+HU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EUu97q2/wJdFhk/98yAw4rzKZ6PVph8A3PUPTIb0LD2L0mdbmGsWItohgOxuZ08RBYbBxo7P7kFeIGPnAKbj1BHLUCPJtT857Wr4d+d1gUwr7rzR845cuOvn/IqMEv2NrJ/h4gxACHoiaOAdThKIpO8ycbFc515hn2wGKZtpPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCQmpO1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D07C4CEED;
	Sat, 23 Aug 2025 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755908997;
	bh=fr9WqDO1kXpknKVJ9BLrEc7r1NzTIi3aSXwDL/pp+HU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WCQmpO1NvH8vhoCWkydcWFERJWdKsW5A4WBg4iaKtPMiUS2DoBRq5nS+w6UMpto2m
	 nA1LC+eJ/8tVJc34NFxseYC+WhrenijULr1kevViF1iAzLeBa6AdMyqfboTX+eMqb4
	 VlyCezAS0/u8x9cXcbv6oeiTdlSravoMz5DxVaOZJTGMgFTIK/OFQHj2xjvC2JsxUr
	 gKFJkauvY6HKOD3wYndMLFTTscvCvASjn4U4fgjt2nLZ1WVRUafBj77pPBN71sFcBW
	 Qlujftecs5qSO2+4et74m7qWchmbjBuWgTkjhdT38sEAXX8MLDHSpCekhX4JUZWpsW
	 UiHdAwQFYHniw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BFA383BF69;
	Sat, 23 Aug 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] atm: atmtcp: Prevent arbitrary write in
 atmtcp_recv_control().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590900606.2040371.2846813817993723539.git-patchwork-notify@kernel.org>
Date: Sat, 23 Aug 2025 00:30:06 +0000
References: <20250821021901.2814721-1-kuniyu@google.com>
In-Reply-To: <20250821021901.2814721-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 syzbot+1741b56d54536f4ec349@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 02:18:24 +0000 you wrote:
> syzbot reported the splat below. [0]
> 
> When atmtcp_v_open() or atmtcp_v_close() is called via connect()
> or close(), atmtcp_send_control() is called to send an in-kernel
> special message.
> 
> The message has ATMTCP_HDR_MAGIC in atmtcp_control.hdr.length.
> Also, a pointer of struct atm_vcc is set to atmtcp_control.vcc.
> 
> [...]

Here is the summary with links:
  - [v1,net] atm: atmtcp: Prevent arbitrary write in atmtcp_recv_control().
    https://git.kernel.org/netdev/net/c/ec79003c5f9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



