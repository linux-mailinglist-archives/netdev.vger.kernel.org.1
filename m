Return-Path: <netdev+bounces-64980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD04E838AF1
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B62B24BBA
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A285D720;
	Tue, 23 Jan 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkPS26s9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE45C913
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003426; cv=none; b=eFM0fELvlf66uzveZsB+9XohuKQz97zQxqQ3yf7h7ALhpCjXYYsAGAyZNw7J0388CRJ5Pjz6f4ev/BuMfCL/zjlIkW+qysXzdQLapCRffRZgPoZH0kILKwONi4/9dqv5rpsterHW2Vsxo+REHl4QDZxYd8/Hf4WX2SUccs+Jgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003426; c=relaxed/simple;
	bh=fpO+NT57K5aRbDl/RPxKNEvROGGXazyOC5xrJOeLm1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lTu0fS8x+JjcLfQCCxmmpdy3IZ/Y/BstKfkKBId1XUz8n/2kVt+olbiFNG6XRap1UWAN/lheTn2+zxlJt6zM/EuFOdXegDWJ4diuOeaV75hLBU9eRd2u0hR6ZVfCFTd7Q7bG6avf0WN776049UdNqXSk9EKBaNTUE+VYRWCh2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkPS26s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E31A8C433B1;
	Tue, 23 Jan 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706003426;
	bh=fpO+NT57K5aRbDl/RPxKNEvROGGXazyOC5xrJOeLm1c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BkPS26s9JDB3/UP0v+7eknyIZWQVG9Whr1S59uZJYsYj5+H4hOfnascvaIO+ycOps
	 3H8OAWUoWLOHjsriVcfcjToF6cQmbq7y3rpGly2Rvmp25k6dX/TKL35kTPEhHSS951
	 B4KrO9UELNLSspuvmoiIVIvRSLAhaw7m2OSeAOtOcdTrBhYGsgMFt4x1fUTn9DvZFA
	 FPoHOR38TKJUT0pbviQIQ0MDiCj5Kl1piiSfGbxAmM9hST7Mgx5POUBzAx5ephZ3jU
	 jkvXFW5wr2MVX5jte1dnfR199SG7jQARURsJeWMbU0QsJREgfK4RuTCx6nOyjpXBVO
	 IbiVCCrJDGSqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C38F1DC99E1;
	Tue, 23 Jan 2024 09:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] tcp: Add memory barrier to tcp_push()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170600342579.26307.3816738058418886684.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jan 2024 09:50:25 +0000
References: <20240119190133.43698-1-dipiets@amazon.com>
In-Reply-To: <20240119190133.43698-1-dipiets@amazon.com>
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 blakgeof@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 dipietro.salvatore@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Jan 2024 11:01:33 -0800 you wrote:
> On CPUs with weak memory models, reads and updates performed by tcp_push
> to the sk variables can get reordered leaving the socket throttled when
> it should not. The tasklet running tcp_wfree() may also not observe the
> memory updates in time and will skip flushing any packets throttled by
> tcp_push(), delaying the sending. This can pathologically cause 40ms
> extra latency due to bad interactions with delayed acks.
> 
> [...]

Here is the summary with links:
  - [v4] tcp: Add memory barrier to tcp_push()
    https://git.kernel.org/netdev/net/c/7267e8dcad6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



