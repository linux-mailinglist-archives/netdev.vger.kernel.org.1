Return-Path: <netdev+bounces-99935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6308D7271
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 00:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46231C20B69
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 22:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005020B34;
	Sat,  1 Jun 2024 22:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfdi9//k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD18473;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717280434; cv=none; b=TWWrkHn+r1FIWyxeiA8COqIsb+v1WtDcxFbLulZmycYDZ6961acGGC5VipoVBaaDoqdl6FlzHcwB4PzcAIHw3eqgFb0NslnfDxxnjj+emx2omqhDSIYDUNTd6kOluwiHclURl9ZW4bEvdqRevyLxAtRo0vMeiH2H01E7bFisMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717280434; c=relaxed/simple;
	bh=hNgHVZe+petJJgZdQ4AargHAL3EsmxecFShi/5vzJw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZaVgg72pn0sRfGuQYi8ofeTy/J0txnNDx6k2AjNhjnBRRYDkz3R3farPkAYIfom6BlzurtmldZr6b3eRkex43rPdxP5xg5gEIel9uCh/cVh2pS8LiR1V/AqrvLIgjgrgiNQUpboa7N6FhytgG5zw1zWgIJKKjgViAVRvRBScMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfdi9//k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3C13C4AF07;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717280433;
	bh=hNgHVZe+petJJgZdQ4AargHAL3EsmxecFShi/5vzJw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bfdi9//kNYSYHJPP6QNw0z5PAEkLIkvY6rihFQJS0vSE3sEAJX6oUS8UNdeGQo3C6
	 lF0w8mRRLbIpkUBPHUJ7YDbr05GrxhAjC3ZOqDKoOUp1D3jtctEdfg80FlOXhRZ1oG
	 pNJajoDdOzY6O3AqPnWXnB0YGBUEJw4d1ZoksfuNM96CEfAZsi9fxOmve3CeD9W/Rh
	 wXV3yzECzUhLEkCiIajv07iBEx97fLD2qMecmkKEQmv/lfO+KfRc5PGGvEJb5bCHZb
	 lavOIvkbaYGZhXnkusY2fBj6eQBz9vSJe1j9zHUQ4QmhSEmH62DdhciiHkX1XXVSVz
	 lVcVLVbR480Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94316C4936D;
	Sat,  1 Jun 2024 22:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] virtio_net: fix lock warning and unrecoverable
 state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728043360.17681.16238810205462664237.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 22:20:33 +0000
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240528134116.117426-1-hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jiri@resnulli.us, danielj@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 21:41:14 +0800 you wrote:
> Patch 1 describes and fixes an issue where dim cannot return to
> normal state in certain scenarios.
> 
> Patch 2 attempts to resolve lockdep's complaints that holding many
> nested locks.
> 
> Changelog
> =======
> v2->v3:
>   Patch(2/2): Refactor code instead of revert the patch.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] virtio_net: fix possible dim status unrecoverable
    https://git.kernel.org/netdev/net/c/9e0945b1901c
  - [net,v3,2/2] virtio_net: fix a spurious deadlock issue
    https://git.kernel.org/netdev/net/c/d1f0bd01bc58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



