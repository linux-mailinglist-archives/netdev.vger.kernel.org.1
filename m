Return-Path: <netdev+bounces-73233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EA285B86C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 474EDB23E0B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE88060BAD;
	Tue, 20 Feb 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGXGV6Pc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B357560867
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423226; cv=none; b=cHPUJdWXFVgQ5h7WxVhj985lxouP/JAIbxG+4njNRqG3bdbwYaas0+E4AG8YZel/kookVZOpM/iADWpe1lI/izWLkIhDYyUXlhAXwYDc/uusUGV+xyNEg8NeJ9mvnQ3wztEF00vWV4P1O3A+dhjYBCOvU5ADWFf/ZML0a5IkC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423226; c=relaxed/simple;
	bh=yCCqS3tVZYX9F+b8gLIeAeb9v/OP5g3l6869vCAW8UM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J3CtDDtX7tndLN/Pjc4f6p4p5q6xx+4kyZDJUuWk0ILR3SwHkVi7sBVlBOx/Tc3e2pl4ykbNSOiZDxs+68V4DO0PZ67KeCat0p1Sleejrz2HlesO+9pxEKdZ26ZBagEt/LSq3xiFtBs+f0Hk7rhWte640F/WRHVK6AChsxb/Y1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGXGV6Pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63F41C433F1;
	Tue, 20 Feb 2024 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708423226;
	bh=yCCqS3tVZYX9F+b8gLIeAeb9v/OP5g3l6869vCAW8UM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WGXGV6Pcu3ZrJAf3Zu8MtN8zlaMdYxStX1CAb+8MXMaVlqMa78R9ey97DjATX1uPW
	 LAzJoe5IiDZVvaBx0f//fySQ3BX6z49qLT6pzAKYVWiEd8CjBb3k0oFSVx4gTntblQ
	 FZuzPzBI0QchGoRxLc53dvT/ccWdMtIfG1ziQVH1J4gm/wH1fIP7cQTOjnGGU3qWiv
	 qr1DaqNomJhEjMdMCROmCA/eg1cjeMQ3YcdiJl/41uYSjd+qcJVLk+/tIYJ+/e7pqq
	 iGkm0NYaJ2uZ7pmAGl/VXVrUY779EI0Sip2wkZlmb1sYpu1oUHICTAL6NxYHrIXUwQ
	 wwhVEQEPLABsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BCB9C04E32;
	Tue, 20 Feb 2024 10:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] arp: Prevent overflow in arp_req_get().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170842322630.30293.18107902549214812009.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 10:00:26 +0000
References: <20240215230516.31330-1-kuniyu@amazon.com>
In-Reply-To: <20240215230516.31330-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzkaller@googlegroups.com, doebel@amazon.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 Feb 2024 15:05:16 -0800 you wrote:
> syzkaller reported an overflown write in arp_req_get(). [0]
> 
> When ioctl(SIOCGARP) is issued, arp_req_get() looks up an neighbour
> entry and copies neigh->ha to struct arpreq.arp_ha.sa_data.
> 
> The arp_ha here is struct sockaddr, not struct sockaddr_storage, so
> the sa_data buffer is just 14 bytes.
> 
> [...]

Here is the summary with links:
  - [v1,net] arp: Prevent overflow in arp_req_get().
    https://git.kernel.org/netdev/net/c/a7d6027790ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



