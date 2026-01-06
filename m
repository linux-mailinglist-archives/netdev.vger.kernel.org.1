Return-Path: <netdev+bounces-247247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46ECF63C3
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0786E307E943
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18888279355;
	Tue,  6 Jan 2026 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4fjxNL6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E667226E6F4
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662013; cv=none; b=FoRR/mIl2Ig8DfywSd3VcR218TqX0rxGljSQ9Ct4YX4gmHU4YBmQ+RGuOwgaWIm3XxlDSvV9XzkPonv4+jZ/IVR+CtIAspOCAxKdc3NhrEjTbYdtBOKTM3O/Z3SP2ZfVcr2Ykp5nRMuxasyO0vnkdN32zddh8hkbc7gZGrBa/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662013; c=relaxed/simple;
	bh=DNsWzqQ/UyT6ZsALotmud/m90fux7yziUGNA9tdpPII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e5zFyAKMwEI9HEQ5fInALA94kNBpu+CopKNUwcgH41SV0Y2FD/bpVPTh22gBp1OUuBhpqsu+TNU1at8YRe2Img1V34DInkIOItMXmFlcj24jT4Nhm8J9Li+C/UVzJHYx8iWJy/NpwwVgYNDQ07AE1GlLe4YbdB9zKjgrlXN+a5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4fjxNL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C27C116D0;
	Tue,  6 Jan 2026 01:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767662012;
	bh=DNsWzqQ/UyT6ZsALotmud/m90fux7yziUGNA9tdpPII=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U4fjxNL6U9eA0rslrko2v27HMo4I2Wqkl4COUlbdh/kKqkXu/uwGzWJssZL7GNes2
	 ucZBq/4w+9bGjedBTyeGRf40ymSDegozBvaVf/B26MkvlnJP/Lcf5J/o1iI8iFoVi2
	 MCYlqY1hFy7I0k4EsiuqjmdC+twWEjYMAs5zk12mHrB1JQHaaxTIWBgHkri/ZFnUyB
	 W2U2+dPQnt2c/BUQHD47t/A9j3TB023rrccHDuP53gpqSVHdwOGz7j7nWboYYR0pgE
	 MASTbEO4I+6/7rvOmAgAX4rNqinz4MxYbQLeMgP09ZwUPLHgYNeUpJx22m+DFmBS2D
	 D9M2Un+ToxzYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BFB380AA7F;
	Tue,  6 Jan 2026 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: fix memory leak in skb_segment_list for GRO
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176766181056.1354046.9145452313439535583.git-patchwork-notify@kernel.org>
Date: Tue, 06 Jan 2026 01:10:10 +0000
References: <20260104213101.352887-1-mheib@redhat.com>
In-Reply-To: <20260104213101.352887-1-mheib@redhat.com>
To: mohammad heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kernelxing@tencent.com, kuniyu@google.com,
 atenart@kernel.org, aleksander.lobakin@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  4 Jan 2026 23:31:01 +0200 you wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> When skb_segment_list() is called during packet forwarding, it handles
> packets that were aggregated by the GRO engine.
> 
> Historically, the segmentation logic in skb_segment_list assumes that
> individual segments are split from a parent SKB and may need to carry
> their own socket memory accounting. Accordingly, the code transfers
> truesize from the parent to the newly created segments.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: fix memory leak in skb_segment_list for GRO packets
    https://git.kernel.org/netdev/net/c/238e03d04662

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



