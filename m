Return-Path: <netdev+bounces-64986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1C8838B46
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0546128E850
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB85A0FB;
	Tue, 23 Jan 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdV26JYx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084F5A0F2
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004028; cv=none; b=dUfIBiIP0XLawXRs+uoeQFmBoO++3HXK+gzRKukQZ0/Edn/YGqqr9JrqEH65Ob3JliW/aNlWrSkwVQPCVMoc8ALbWsDwJeR5hfDhUKFsNi4bJaknVJifILHEC3kSzE/FW497hHKfQUa28KqyX+zHldYB1Z8FkYWHyleIsNDGL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004028; c=relaxed/simple;
	bh=P86cTJZc6jZpyCaRRQKLv89rcvhOKMjU+QM5EKvjmJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jjk2TeTaMYsrW0k+cmt6vYm/pMfj9sZdbelvQrDgjGBZJ6uq1US6b0lrIyJjr1K8n2QBukM9Cxt8RPVCzzPhcjJQlAKL20Q6RENXUSluDhdfuUNQOu0iDZSTe+fFPJ8AgPL3bZKHZtZlIECDEOW1TWPCTdpXAKKTe+5Rz3k/xcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdV26JYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57172C43394;
	Tue, 23 Jan 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706004027;
	bh=P86cTJZc6jZpyCaRRQKLv89rcvhOKMjU+QM5EKvjmJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KdV26JYxcVtncP/h6UjtO4Kll5E9dvA3TRoSi6foseyklmk9IYStzHzU8lGlwbbQz
	 lFpiK8/em/JcupIbchbC9S+xeMo1nbG/HWcGR7AujdM1Fn5yHGX7s9eqKg/hrSEE4p
	 GpaBfFpv+X0JOwU3JXanPfpF4krzyp7RRAzE8SzID0bJnG98LrIUWA7d1F8l9PGnk+
	 y1usX0hJ8j89msG94tjT6Mjla0UimDYQzZytLLmY+m+Sf79btA2X+llcQpI/JWDW3X
	 zwc6Ng5Y3MVUZ8zXq7nQabtni7QUxS4WS9x9a/1nZHUWSsbeVjazwVJY7Gn3HwrcH3
	 nwKo6bv2BXRHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40B8CDC99E1;
	Tue, 23 Jan 2024 10:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] selftest: Don't reuse port for SO_INCOMING_CPU test.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170600402726.32452.17185055624218058884.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 10:00:27 +0000
References: <20240120031642.67014-1-kuniyu@amazon.com>
In-Reply-To: <20240120031642.67014-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Jan 2024 19:16:42 -0800 you wrote:
> Jakub reported that ASSERT_EQ(cpu, i) in so_incoming_cpu.c seems to
> fire somewhat randomly.
> 
>   # #  RUN           so_incoming_cpu.before_reuseport.test3 ...
>   # # so_incoming_cpu.c:191:test3:Expected cpu (32) == i (0)
>   # # test3: Test terminated by assertion
>   # #          FAIL  so_incoming_cpu.before_reuseport.test3
>   # not ok 3 so_incoming_cpu.before_reuseport.test3
> 
> [...]

Here is the summary with links:
  - [v1,net] selftest: Don't reuse port for SO_INCOMING_CPU test.
    https://git.kernel.org/netdev/net/c/97de5a15edf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



