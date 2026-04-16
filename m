Return-Path: <netdev+bounces-279007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMAhOCnH4GmjlwAAu9opvQ
	(envelope-from <netdev+bounces-279007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:25:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 454E440D582
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBAF63194567
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C9C3A3E9D;
	Thu, 16 Apr 2026 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDX0M/S9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B039A05F
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338436; cv=none; b=LVoNzLS4De80Ui//z7kqV6Nx4n2TSQE9zDt7EJQ1ee+5l469M7+6/pvKDTK/uc36WfiJLQ0Qtlv/SSAiaVVMvhkizbpNY4mTB3Xf+X+E1eTClywsXxCTly+lx8IhHyzij57UMCm2WnqCPtwsTzPTkBo/jxnN7T93Alnx5AdVr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338436; c=relaxed/simple;
	bh=3AKNHMl6I39j7TRrjgV9Q+gpM6C4qXxQML7L8SfsT8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TYKFrpePG5S45HgbgfIy9zJGJmR03TQ5Zpe2WU/fyG+D6txrUYNJWdLUH6EIvOb9odgSlBzIR8PPAncI3jgxZOYJmJNWiA5ux51CvFuuwdGF31oW+vuiGRHE7PQf6edAJFzIDqim+DP5MEEnQJeTE6a4Jif0nhQAIXwGKYT7BXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDX0M/S9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9137CC2BCB7;
	Thu, 16 Apr 2026 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776338436;
	bh=3AKNHMl6I39j7TRrjgV9Q+gpM6C4qXxQML7L8SfsT8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RDX0M/S9ZajMqkTF/QxPHiANCtgWZhIHAGnf2k0CCQXoUmvK1vn26om7xFVqHfaWC
	 cQcd5gc5lpevm0KuADLIAFnoaBW3FOeauF6e24qnL/Z/aFVsR/Atf9GQl3wfdlwywn
	 Mrxss2E+EyF0ZB0xA9RDnzNbfkKDhqkzJ4cwOalNLgdtpbquqy9s7MKkE2rLpclJbN
	 v75KUvEwl+AuyjCnkXZNYxNKwRu71T8CeEWd6KZsbXTeedLzaXnyRluZMTN3o3tuRZ
	 77ku2hrh7dizxABB5Uf0QyiQ6W/hELQExbuhbALVzO+73ow/Fgss4hGDx3/AmK3KuP
	 pvGfpEl017ZEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF16380AA48;
	Thu, 16 Apr 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/sched: sch_cake: fix NAT destination port not
 being
 updated in cake_update_flowkeys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177633840530.2745448.12214078618979057434.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 11:20:05 +0000
References: <20260413110041.44704-1-phx0fer@gmail.com>
In-Reply-To: <20260413110041.44704-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, toke@toke.dk, jhs@mojatatu.com, jiri@resnulli.us
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279007-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 454E440D582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Apr 2026 19:00:41 +0800 you wrote:
> cake_update_flowkeys() is supposed to update the flow dissector keys
> with the NAT-translated addresses and ports from conntrack, so that
> CAKE's per-flow fairness correctly identifies post-NAT flows as
> belonging to the same connection.
> 
> For the source port, this works correctly:
>     keys->ports.src = port;
> 
> [...]

Here is the summary with links:
  - [v2] net/sched: sch_cake: fix NAT destination port not being updated in cake_update_flowkeys
    https://git.kernel.org/netdev/net/c/f9e406647069

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



