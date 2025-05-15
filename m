Return-Path: <netdev+bounces-190743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B863DAB894A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645863ACFB6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFDC1FF1C7;
	Thu, 15 May 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh/sq5tH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1B1FECD3
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318798; cv=none; b=sqGFAEoM8clWAgmXuEGscqlIMgMwjMxXrfW9u6OMobRWFk2gzm6dN7ruSNgv4hwxKwe2X9jC0kcJ7ET6NFA//Gp/g7nfjzD/o32B0OKREEYfC8UiJTNCPMo2a7s0hMmlBgJWW3AommZYdeHYcDly40k2p1OaZcPUCB14U9upxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318798; c=relaxed/simple;
	bh=atPGYRzR5Qcc+uad/fKdTPZvnOXd+HpS66PqeP5ZYJw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HXsXf7rsbQJHCwddfifJkAUE/vVkdZhF3zTXVViNZfGS/lNKVFadBrWQ28JdxW9uGes69XAosUNN+4I4+7fzhKLLV7zxnxCvI6zg1DWvY32dNFeqPGcSdiKrv8mkeNjTlt3iQst/+eVD8wOnQKzXXMB/fdEKIyuuebV6khyOy44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh/sq5tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50DCC4CEE7;
	Thu, 15 May 2025 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747318795;
	bh=atPGYRzR5Qcc+uad/fKdTPZvnOXd+HpS66PqeP5ZYJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uh/sq5tHuqoYXYnu52ZDVENPm4b3rMSDi40iB07kSgdPlJ7FzS3dQJAh7k7OyDGxq
	 uCIg6wqRwAGJjvzOctzI1XXryFVg9Wjld77e3zEJwPtq37ZvCKXkBNZhmwxmqGLPOX
	 /921ldEsO3cjXCdI8v9EfP6lzyHktHDGuqzoZV1jK6lNHxAOIWrivJglluTfuowFys
	 E6mblBTeS/EjUN4TRM7uE75vbarmmqlW1gRnKMuSKCl4FsEPufmKkbGIcUtGiedBqL
	 dTv893yrFmR1CBUxExlfzX4iCQ+OgYeUODZfrIhrqASKjv0HGnYroW55nn5FzFBJFT
	 uQu9ECzoirQbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2F23806659;
	Thu, 15 May 2025 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mlxsw: spectrum_router: Fix use-after-free when deleting
 GRE net devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174731883276.3125210.16609482340989544301.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 14:20:32 +0000
References: <c53c02c904fde32dad484657be3b1477884e9ad6.1747225701.git.petrm@nvidia.com>
In-Reply-To: <c53c02c904fde32dad484657be3b1477884e9ad6.1747225701.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 14:48:05 +0200 you wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver only offloads neighbors that are constructed on top of net
> devices registered by it or their uppers (which are all Ethernet). The
> device supports GRE encapsulation and decapsulation of forwarded
> traffic, but the driver will not offload dummy neighbors constructed on
> top of GRE net devices as they are not uppers of its net devices:
> 
> [...]

Here is the summary with links:
  - [net] mlxsw: spectrum_router: Fix use-after-free when deleting GRE net devices
    https://git.kernel.org/netdev/net/c/92ec4855034b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



