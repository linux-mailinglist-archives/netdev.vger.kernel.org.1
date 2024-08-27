Return-Path: <netdev+bounces-122522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36B396193A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1224E1C22ED6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D991D414E;
	Tue, 27 Aug 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebgEp3tX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30B1D4147
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794232; cv=none; b=jwLJrtEN3YwAkUiZFiO4yONE82AL4tySknLdry8ogQvVWzabf6zYlkKSszWgJriG4z51Qc2VlGvmTWvrRj+dgQpWFs1sa8iyBorYEYqEEmnWRxC/DEgfTA/K4zn7ggMTm6skLwop4wdR32h4o1WYzi015QfPvE9f5KMlERi2/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794232; c=relaxed/simple;
	bh=4Z7FABauvVX9rjZePg1phFgn3e7awIJw6xtGURJrYmE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DmKIti+in+IqTkToXWZ5ymNP/xy8Bq98O3/TJ6970hPrQ60JlhH1ig4wMBpMIM6WeIEKe3KWQa+vnmrgk58ShyllMMdnJDjKh5O/ul58UR7X5Bb0FYv4yQwtP519AI8UzMuMga51rI9MSRjRGttr/sNhU/zJTMuCRLe/OcvxQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebgEp3tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632EBC4AF1B;
	Tue, 27 Aug 2024 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724794232;
	bh=4Z7FABauvVX9rjZePg1phFgn3e7awIJw6xtGURJrYmE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebgEp3tXOix8yDiicoGG+AplkxSY26sKDawYnH0IsPxxusAG8lyAK7a4vj92BROCu
	 wnSFZSNhW6EyeuMwNu14aHM1ERo5Mh5YS516fIazcnUuaDwc+KQWePJP3Y1j3YYjn+
	 vpkczeiaTQrDPgQLvTGMX8TbGe831VQpHjr7fIL69dn53R355A39k8/8Ziwti0Ke6f
	 k7ZMQz86hCONYrhBzi2FWP8o1mYCFyYZgfC6Yl37dkYAd7ZQiWbMHY1H1tt/q0yqZi
	 GwkAKwExUdL6ymlqsuvf2kvqNoU/3MnT3HRW4d0wXlPXHKOzrHFFKZMpTkW5Dg8OIu
	 gPyNO9ADpHZYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE303822D6D;
	Tue, 27 Aug 2024 21:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net] gtp: fix a potential NULL pointer dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479423249.767553.15007142293154315706.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:30:32 +0000
References: <20240825191638.146748-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20240825191638.146748-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, cong.wang@bytedance.com, aschultz@tpip.net,
 pablo@netfilter.org, laforge@gnumonks.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Aug 2024 12:16:38 -0700 you wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> When sockfd_lookup() fails, gtp_encap_enable_socket() returns a
> NULL pointer, but its callers only check for error pointers thus miss
> the NULL pointer case.
> 
> Fix it by returning an error pointer with the error code carried from
> sockfd_lookup().
> 
> [...]

Here is the summary with links:
  - [net] gtp: fix a potential NULL pointer dereference
    https://git.kernel.org/netdev/net/c/defd8b3c37b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



