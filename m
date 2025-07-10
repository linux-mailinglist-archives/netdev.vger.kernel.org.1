Return-Path: <netdev+bounces-205634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12436AFF715
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CAA560FF4
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF8F28000B;
	Thu, 10 Jul 2025 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jntNMcb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD8027FD6B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115789; cv=none; b=u765nEP0PoltnnYgNk8j4RwuyhXvR3p4I/XESu3+6drIwSf7rI7HKpxhN41215InhLy8snaS7n/Ud5VzuCp9yuDik7Nilcuey5G2nn6xPl1vkxJAsX3MBpCya932wAiigJMr9AOe09ZPtIgz3mM/jSbYhbhYWWdbNyYBQpfvAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115789; c=relaxed/simple;
	bh=hh3MFw3UI/nbdOMYCh5dSmBs4J0ZRNZHcIb9qjP9nwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kCYGPGtTv8VxyyeojlW1BQHDgGpfc1796v5EZj4jvLQmxRrzHDpiiTRO+AxTlPdpdVYBqbomFvZhUXcxzYU+SpsJaseuFV5HPRpDDecKBforzgCpXaqCtYDeYURue7B2g0ODurxhXOIBWcUWd9OA9KCoTX6dAE3sbS1/DyyJ98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jntNMcb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1339BC4CEEF;
	Thu, 10 Jul 2025 02:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115789;
	bh=hh3MFw3UI/nbdOMYCh5dSmBs4J0ZRNZHcIb9qjP9nwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jntNMcb2+SrlU/LK9a8wpc+JkzTzN/vGfqRrKK7XznguZJoWH1WB47ZersNyt8vZ+
	 zpRlh4vovpl1OUC6BAeOQtmzXs17OdPhRYQtuPkCOL5RD2MEtNRaZG5wMRK7jVlMYU
	 RlsRhdzO+AbyJ+HQ9x0vQ9foLPJgwxQJWzBWTfwewl3Wo5wfjyf3OUbmIrJwIHOhoF
	 ICuPV8Ma4yvhYpZ6xVc5UTfSRDKrnjhs3kl2lwTaXMXqYUBsyz00k4cqdbeUMWyhh1
	 7Yx7Br9Nw2M8NxMjipP8pXcRiFQx3xuwyzKWS/Yl4ejGWjDfuF9gaszo6EJvoXwZCS
	 gAGytyzyG0vQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF06383B261;
	Thu, 10 Jul 2025 02:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: Abort __tc_modify_qdisc if parent class
 does not exist
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211581125.967127.9029455164848283277.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:50:11 +0000
References: <20250707210801.372995-1-victor@mojatatu.com>
In-Reply-To: <20250707210801.372995-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, netdev@vger.kernel.org, pctammela@mojatatu.com,
 syzbot+d8b58d7b0ad89a678a16@syzkaller.appspotmail.com,
 syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com,
 syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com,
 syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com,
 syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Jul 2025 18:08:01 -0300 you wrote:
> Lion's patch [1] revealed an ancient bug in the qdisc API.
> Whenever a user creates/modifies a qdisc specifying as a parent another
> qdisc, the qdisc API will, during grafting, detect that the user is
> not trying to attach to a class and reject. However grafting is
> performed after qdisc_create (and thus the qdiscs' init callback) is
> executed. In qdiscs that eventually call qdisc_tree_reduce_backlog
> during init or change (such as fq, hhf, choke, etc), an issue
> arises. For example, executing the following commands:
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: Abort __tc_modify_qdisc if parent class does not exist
    https://git.kernel.org/netdev/net/c/ffdde7bf5a43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



