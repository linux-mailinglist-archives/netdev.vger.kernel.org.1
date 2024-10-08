Return-Path: <netdev+bounces-132917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70636993B93
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9191F1C23429
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E5EC4;
	Tue,  8 Oct 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo5LyUsH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F7F161;
	Tue,  8 Oct 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346222; cv=none; b=kWDXt70JmcmFaBtYy8j94h1pz90FEHstfUAuKOif50viysLjpHV9Rj+AAZgmrFrc41nL9QmlgW8APMj/f7EOLJIEMpO5l4RLXHv+k/tEuQC2gAS7rLv+TLK05jHMyxJ5Nhxmb6LfWf56wtUlHg0VO5/Ha2LP56E0852csuujxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346222; c=relaxed/simple;
	bh=b63IQ4s+fB8dm+DXtt4cfpDH5Bvp1G9Z8Iy6UTu075E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N1MZ4zuuGTV9Ip/KnO1jswLxTrC98Ooa3zpuEGKEnUuzd+0Ycr6qfSoZcFZwdJx/Tn/+hM94e6J4DU5yBW+ZFUOYMsmBli5LOhVpxD8Am3ExC3KQjYsCoEK2QPLA1r8q/0rnE84VC12uZS+RPUyaErCoZBengp26/fTvUIfWM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo5LyUsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7A2C4CEC6;
	Tue,  8 Oct 2024 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728346221;
	bh=b63IQ4s+fB8dm+DXtt4cfpDH5Bvp1G9Z8Iy6UTu075E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lo5LyUsHejX7iDckt6apclTXgRIRq3Cy8hkulbHMP6Fs4exTswv/zd9tUAZ+V7Pxf
	 75hVobVY9T5g5WkYfYtjc3VySssRw4nDkJ9wxSN64n89DIzxSztpBkTXzG/JpVGAdA
	 55Sl7NdbeCV2ih7XU1f7MofRHt5pCpMrMpCoqZtbEfdIBTbExDn1FrPlBc69XPxjin
	 MdsbGYAzVf8ZLGulgPB4YRJsGJJO9btIAkVYXq7L0I2CDdyDtcsaUvo4Hzz6/PnLel
	 xj+kKLSG6UjwihOiWhJYaNeHwUgr5xxb68/UMe194hlvm43k9zG7+X4SQOXCQjVnKi
	 C692NfQDpDG6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D153803262;
	Tue,  8 Oct 2024 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: adi: adin1110: Fix some error handling
 path in adin1110_read_fifo()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834622606.25280.14865735835274867551.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:10:26 +0000
References: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <8ff73b40f50d8fa994a454911b66adebce8da266.1727981562.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lennart@lfdomain.com, alexandru.tachici@analog.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 20:53:15 +0200 you wrote:
> If 'frame_size' is too small or if 'round_len' is an error code, it is
> likely that an error code should be returned to the caller.
> 
> Actually, 'ret' is likely to be 0, so if one of these sanity checks fails,
> 'success' is returned.
> 
> Return -EINVAL instead.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: adi: adin1110: Fix some error handling path in adin1110_read_fifo()
    https://git.kernel.org/netdev/net/c/83211ae16405

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



