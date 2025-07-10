Return-Path: <netdev+bounces-205642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8FAFF734
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8281C43CF0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0F628315A;
	Thu, 10 Jul 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQq73ks6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED2283138;
	Thu, 10 Jul 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116406; cv=none; b=kxgsU9D+kP3HPatOxwQoLsIKHceX7hBoA7Q6J1MAEYD1SEhT6KyYVUuJVwFQC5TPpz0OuU0KvSrztxXj9pDmdegkSMOLfjY6fI2cPg/DcMFhGwo/Gq12w5Gjd1yevHugpfhPrYCmGin5owq0R0YJhmZk2eGRcvGF6oNlZrgzrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116406; c=relaxed/simple;
	bh=RxpYBJJ435isBTg3hu4FPIq4wwase/mh5cxZ2TvpAkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RgjwHGiCx45Et1Q+2DoEFfLcGHeMw7OAFmttGxjvqi/jRg9FJsPMJJ4LNvQ1mtebe9yzfMaJWfaE64pMQmAIrDisZqe2nmWWrHqLf/kc2dYNi80ScT3U7C2L4M1j8F8puuUpDL/ZqHVEZyJsml4S+JtOHyV0De4vyPyMghsragM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQq73ks6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB3BC4CEF0;
	Thu, 10 Jul 2025 03:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752116405;
	bh=RxpYBJJ435isBTg3hu4FPIq4wwase/mh5cxZ2TvpAkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tQq73ks6qKi1yWqD4ReU3Xo2CtJ0aJGXMQ8nhlCh4AeaOQhN2LPWEPBjz5JaktJS6
	 mNlnTXEOMJnzw5P44nsfH98Z9LAiAQWxAt+gM2E3zb8gWrJjfdbN9xg1YHSv8SvSYa
	 dM22B6VEJT1BnJ9rhg1IcLmeyEMEM8P4d1qFXOGSzV70kkx22Lh82qXf2pPE6n5BTC
	 7gsvBD72dOjzEjIfzyRYoDd7SW+uBim5sIVqidHTrFYB63fVulvyi/nEEypCFZuoNz
	 4CWQemytHzuukSkuQ0G2jFgrC7s1o1E+OPeNHzaNX/Q3IUIhyREhVbOj+wll/Mmwb1
	 JfuSv0ZofXh4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E00383B261;
	Thu, 10 Jul 2025 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] vsock/test: fix test for null ptr deref when
 transport changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211642825.969691.15727844419964289216.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 03:00:28 +0000
References: <20250708111701.129585-1-sgarzare@redhat.com>
In-Reply-To: <20250708111701.129585-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, kuba@kernel.org,
 linux-kernel@vger.kernel.org, leonardi@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Jul 2025 13:17:01 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> In test_stream_transport_change_client(), the client sends CONTROL_CONTINUE
> on each iteration, even when connect() is unsuccessful. This causes a flood
> of control messages in the server that hangs around for more than 10
> seconds after the test finishes, triggering several timeouts and causing
> subsequent tests to fail. This was discovered in testing a newly proposed
> test that failed in this way on the client side:
>     ...
>     33 - SOCK_STREAM transport change null-ptr-deref...ok
>     34 - SOCK_STREAM ioctl(SIOCINQ) functionality...recv timed out
> 
> [...]

Here is the summary with links:
  - [net-next] vsock/test: fix test for null ptr deref when transport changes
    https://git.kernel.org/netdev/net-next/c/5d6fc6b4d0b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



