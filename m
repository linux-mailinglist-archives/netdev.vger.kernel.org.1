Return-Path: <netdev+bounces-172293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253A2A54139
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3933AD835
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64F199238;
	Thu,  6 Mar 2025 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJklbOsp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40C1991DD
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231802; cv=none; b=FOw01QewtDSIxkdpSh8vccCOWT01vuIQWlg/B47Ca7MFleU6dQ1FiPp5wdYzQMrglT1cw0FyPbndl9ylElLsNQKG8yc5LpvjsvHrM2ayImEicJbryTq+QQ/gzuskrI9B9mog/oZy1YbtUHjYvunEPQsDjSQCz4RymwOBVdPpRA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231802; c=relaxed/simple;
	bh=QBzAMIQU65GVKy3VqgNNyRzIbrrn7hbPwKJ+A11cEFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NOoRV/vsdzYm5kDH191Mum44Sm7jyTfZY0qEd9HuadnwO4T5FN4pBDiOptKVGBy/jQbd2V0F8Z86Ci0gDmd5zeruDbtb+jinlcIp6jQVvCZFdIlh74yc/bNT6Y4njHb9yPFxi2gvVD7EGlFbdyMJUoUT1soBZDlJi5qlv7QZfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJklbOsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F514C4CED1;
	Thu,  6 Mar 2025 03:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741231801;
	bh=QBzAMIQU65GVKy3VqgNNyRzIbrrn7hbPwKJ+A11cEFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sJklbOsp3OybJ4iTK2IgP2Bjj9aTY0viL73+YmSiKkDFELRADb2pbvp8MZRkfxcEX
	 YOkLs6jeCZa+HmpQuWc74kOWr0H/5kSvKtxliBH2J47o8uLdrLAWE/Dy48s+RuJBNX
	 0wvZ4A1SnBAdpD8k6/q6ymP3OrZPHXSzviSj4BnQ28F9tClKE5DlsQc3UMh3QOFN1U
	 23kSh1f2offDk88KLKRRbn6/bCe+A/++yVvse57cI1v8RJKvIq3Ak+y68DLq0VUsW/
	 ZaQC048uMa46oRv2YkbWOijx8eIyrfp1gpXK3YA6dHvn7QrOnwRUR5SR21AT5vWX0l
	 OBOC4Zq7uWc/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D8380CFF3;
	Thu,  6 Mar 2025 03:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] inet: fix lwtunnel_valid_encap_type() lock imbalance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174123183424.1114452.760275294340733893.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 03:30:34 +0000
References: <20250304125918.2763514-1-edumazet@google.com>
In-Reply-To: <20250304125918.2763514-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@amazon.com, dsahern@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+3f18ef0f7df107a3f6a0@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Mar 2025 12:59:18 +0000 you wrote:
> After blamed commit rtm_to_fib_config() now calls
> lwtunnel_valid_encap_type{_attr}() without RTNL held,
> triggering an unlock balance in __rtnl_unlock,
> as reported by syzbot [1]
> 
> IPv6 and rtm_to_nh_config() are not yet converted.
> 
> [...]

Here is the summary with links:
  - [net-next] inet: fix lwtunnel_valid_encap_type() lock imbalance
    https://git.kernel.org/netdev/net-next/c/f130a0cc1b4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



