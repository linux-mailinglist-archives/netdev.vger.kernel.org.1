Return-Path: <netdev+bounces-258545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOxfLMeTjmmVDAEAu9opvQ
	(envelope-from <netdev+bounces-258545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:00:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A89132825
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA3AA307ECAE
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40898C8CE;
	Fri, 13 Feb 2026 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umR/7VS2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80ED239E76;
	Fri, 13 Feb 2026 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951613; cv=none; b=EnwFXxZZpEh3fF1XJ0qioPAkm1BHAp+VMwSJeF6Tp7w89SHjD8a32oNCjeQlL9TqDxR4q0zKGPjGTggvqQg6ONYQ5Eyw7IasGJC1xiH9KBkyniq4wRY5Et1nbcGskZFcpPG4jAvfgLbB4xGZ9U/833HJk1hl+NkiyjScPuwbJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951613; c=relaxed/simple;
	bh=Nb7rt3xyeK4wTFYyHC+JmyHyqtSSuMEKW1YsUTBCnYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C3vsAmoDt3gMBlvvTTKaUV0uMMwo1dT1IPiRfplNnMAwEA+ICQ178TY8gtsiSr+vRNJudlk5AmNafYvQlFwPGnKIquO1HXz70C8PkQyp0f1PGmTpZlBx9KSYyEvMPv622Ww+b+yaN9w4758xalDrBRtdlPgzWB5Kso5hYaKgSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umR/7VS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72419C4CEF7;
	Fri, 13 Feb 2026 03:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951613;
	bh=Nb7rt3xyeK4wTFYyHC+JmyHyqtSSuMEKW1YsUTBCnYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=umR/7VS2cbiOw3B9sq6HM6Zaqpu/CKbFOr1PJUlEL9BSEcv5Xu+zR8SvawnNrKJSE
	 d03paO+CpUn502cgKxU+pzDE1KfBaiz5f5XJ9bX0GbM8MNwvUoTx9SSq79s4WgM0Mu
	 Usu2WyJ0uvGxsXzDxWvBPp+StnhxhoVVs/HdYAqrHj13AxzSKJs52ASXlpPblVCQBF
	 YUAUuqAuxtERBITIL3F/PxolT9x37GvygiAgErx9hKulAHLsZKnx/w8TX+IZIPtxfJ
	 F6eHocqhfjbvfoTBefI++h/gEK7DwaakLMBb3izYG9X0wGhYbTrtleE80Yd3atYcq2
	 t2o0eO2TT8dbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22B03931093;
	Fri, 13 Feb 2026 03:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] atm: fore200e: fix use-after-free in tasklets
 during
 device removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095160732.1822665.6502324897144779246.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 03:00:07 +0000
References: <20260210094537.9767-1-duoming@zju.edu.cn>
In-Reply-To: <20260210094537.9767-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, 3chas3@gmail.com,
 shaojijie@huawei.com, stable@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com,huawei.com,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258545-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31A89132825
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Feb 2026 17:45:37 +0800 you wrote:
> When the PCA-200E or SBA-200E adapter is being detached, the fore200e
> is deallocated. However, the tx_tasklet or rx_tasklet may still be running
> or pending, leading to use-after-free bug when the already freed fore200e
> is accessed again in fore200e_tx_tasklet() or fore200e_rx_tasklet().
> 
> One of the race conditions can occur as follows:
> 
> [...]

Here is the summary with links:
  - [net,v4] atm: fore200e: fix use-after-free in tasklets during device removal
    https://git.kernel.org/netdev/net/c/8930878101cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



