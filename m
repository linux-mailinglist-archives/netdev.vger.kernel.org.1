Return-Path: <netdev+bounces-238340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E41C576C1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C15D434B0F8
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A173BB40;
	Thu, 13 Nov 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZBJLbfQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460C35CBC1;
	Thu, 13 Nov 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037038; cv=none; b=JnFOPUaxkuVKz6PBn84rUGYhwPURAr4zAphdBdT4ObVbBdryQVGX+/lv9zcYXYy0nMk7NBfOLoei4CQYPp3OyM37RFQl+DfFivLg/LdaQvr2PnP7MNGx0WCSHwF0+ybxLcIzlBPdzD8qBxYWUILncUE2wM3BmnU+orWUrti+3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037038; c=relaxed/simple;
	bh=Em3tOA+yZ4I5B7ql6OGRl1zGOOyRHnagwTfSnDMCk90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lXfGfKX8lxAM+wnCCR+TkGQONdX6L3bGaOAJpsHY6fr+pn1wAM+KbrDvFwnnyZtQnRli/VXcsYGZlVM7IDDZ7r+Rn5egmLYNpxY9VpZODkhLEDLrb0tfZ8Njkgn+IlN77XfzLeEADlpNYtKhayLfEMPbs9FUP6up5TF8/mnzsVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZBJLbfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A65EC4CEF1;
	Thu, 13 Nov 2025 12:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763037037;
	bh=Em3tOA+yZ4I5B7ql6OGRl1zGOOyRHnagwTfSnDMCk90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qZBJLbfQDtQmyT4HAVrLbT3ZbLqtOiI64+3Yj+VB2yFW3YtiTa6P1rsGgxHARCMzd
	 gLbgGfBHqhL68L+cGceLHfPdU9rvm2ZHY9dlqvABW1X/KH/vBD7bNEAAPIOkdgBDp/
	 Jfd+d3isp16SiHSMFf6FcTATRHlanhatIBq0gawRs8Wx5vucfUMuQHUxfJd1qleRtY
	 V0kRN9wO+Zie77CK8gmso8fTiU4zmoQ9VXknQxrFFNwx8Q6tr+PoloMmdxCsslaO7G
	 HRhZjZOYt/aLD+5dtgj0W83dv1RJVTwje6/1Zvf59X/r6omZYNkywR/qDFnWnO6Xqe
	 Q4kQ53SOYKGHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3F3A41033;
	Thu, 13 Nov 2025 12:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] virtio-net: fix incorrect flags recording in big mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176303700677.831415.11786935401202249706.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 12:30:06 +0000
References: <20251111090828.23186-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20251111090828.23186-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 hengqi@linux.alibaba.com, virtualization@lists.linux.dev, hi@alyssa.is

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Nov 2025 17:08:28 +0800 you wrote:
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
> 
> [...]

Here is the summary with links:
  - virtio-net: fix incorrect flags recording in big mode
    https://git.kernel.org/netdev/net/c/0eff2eaa5322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



