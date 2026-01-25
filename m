Return-Path: <netdev+bounces-253211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PavJRaJdmncRgEAu9opvQ
	(envelope-from <netdev+bounces-253211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:20:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E9827B1
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AD353001FEB
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464130CDAE;
	Sun, 25 Jan 2026 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pksWXvPx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279430C631
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376016; cv=none; b=m5xEY4bu1WU3o6y6mFMYt5QSvZ4KdBQRjmuTstm+qe9AMQ6V0GZO5jUM/ddpVIPnhFWXXfAhkWw/iJsoB2p3l1ni2OE6CfoZ3C870XWXD7Lnnr6RLpmUabDKZyqAc1APVM6gcYaYSbwiFZ0SkVM1bcIfDpgBodo/BQ93t15LfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376016; c=relaxed/simple;
	bh=L8A6Skz/GAxRAdq/plxkvsRYsS73oOpS83cfpXxlDTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n7ZYxbywY6JPiqE/2sFlmCIsiLzjqhPqhwxXVFLL58QkIJl4a4rHSkEhxiGvw19W6ITlD0JTwBseE+dTf4G8dl2vbVPTDRCfYsqA7VZ5ns9sYmz4MskDqlwks1qsUh0+V3lFUIqraZDSd8F5jW4BDjX+krvsRoP27pBoxgK95TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pksWXvPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FA9C4CEF1;
	Sun, 25 Jan 2026 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769376016;
	bh=L8A6Skz/GAxRAdq/plxkvsRYsS73oOpS83cfpXxlDTA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pksWXvPxxckMPpSYEn+KidwyVBgIMGHsVSwpUImBvFeL3wFkYP2ybnqopgc0NeJIR
	 4iLIuzLLBuRq62yFuz2pG0NvwSh6wxdFs7xNARHrVwKajQvcoCvUnFZ5vrwUAzpU25
	 CaLYOCuhlyyt7Djec45+ekegfptlcnEA+uuL+22sduxJUBkIvzfZ5/kgJrJIJbFdTD
	 DvnAC5xHKN7ReLttBpZBb4A2VRSavgwtomICnASLNepMs+YZ2vMF/IceJSQN54Bzma
	 1clJZMLTTEhQKST51yZlz4Bn0I/NivFkgTqvgSOxSNXIJeF8ZX7vS4S3BOFsx41pnh
	 5PbIB7yEJyKPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC353809A15;
	Sun, 25 Jan 2026 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sfc: fix deadlock in RSS config read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176937601110.3588307.13456617616509726491.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 21:20:11 +0000
References: <20260123161634.1215006-1-edward.cree@amd.com>
In-Reply-To: <20260123161634.1215006-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ecree.xilinx@gmail.com, netdev@vger.kernel.org, damir.mansurov@oktetlabs.ru,
 ben@decadent.org.uk
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253211-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[amd.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,oktetlabs.ru,decadent.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: E90E9827B1
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jan 2026 16:16:34 +0000 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Since cited commit, core locks the net_device's rss_lock when handling
>  ethtool -x command, so driver's implementation should not lock it
>  again.  Remove the latter.
> 
> Fixes: 040cef30b5e6 ("net: ethtool: move get_rxfh callback under the rss_lock")
> Reported-by: Damir Mansurov <damir.mansurov@oktetlabs.ru>
> Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1126015
> Suggested-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] sfc: fix deadlock in RSS config read
    https://git.kernel.org/netdev/net/c/944c614b0a7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



