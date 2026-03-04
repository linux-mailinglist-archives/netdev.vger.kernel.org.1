Return-Path: <netdev+bounces-263538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KlmKfSPp2lKiQAAu9opvQ
	(envelope-from <netdev+bounces-263538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:50:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E51F9AE6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA538307B238
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94E327BEC;
	Wed,  4 Mar 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZR4K7Gm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB953254BB;
	Wed,  4 Mar 2026 01:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589007; cv=none; b=cyC6Aj9U3CyUfXkvHiN094LGPrKTNp+ECyNBa7xwPZaoSK9+bTJnJMXDkU5FdkW34yNzhahh30VGoLKokkT7WzE4yr0aCqPCVh76SN8cnFkimJklXADpWACA+jj97CAs+aHa1MsT3K21WtOtVYSO4BMFuto7locpDDYbmjbp11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589007; c=relaxed/simple;
	bh=QLjMQ/UhrxwgKgLAFqRbQ0R6O6SIrJ0zVQp+v0Uxi5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u1E9dsQTIgWkXEPd01dS7AHFxCo+hDoBSte4GKRdeUP1VsQIIFCN2t2o052i/8clK6MV69sKqSqs+XbWPXxfOKDXr0NHaMRATBOfOq3cKgHviRmc/zoOt8NEZwCl9iHLKPaHAp17eSDv5crj01qqiNb+OgRXmYVvS/eX9SWEqXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZR4K7Gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D9BC19422;
	Wed,  4 Mar 2026 01:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772589007;
	bh=QLjMQ/UhrxwgKgLAFqRbQ0R6O6SIrJ0zVQp+v0Uxi5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UZR4K7GmpiwBz2oe+WKaxoNVIHsqst2PtkiXfoh4fCn9+CaXiArLvbqArjIWorSyN
	 T6oopneJ8DUS6+4Ud2wlXtyazmVMayMGJBjKm9WzhOOM3P1d9Lsyj7Yfd8IVSCJPEu
	 JBwygeaDWK6R8qM7OMqUj4P1ahovNGZUO2Ex78VlcafpI4a5ELGplwDErzu5WzbQfm
	 e4dTJnqRCMyrKQVAS4nhnPkFUmTUPOhf0x1hEFj0BU2+IWoFxKggyzxpCT+5XtlBb0
	 pSauJYolO6fXgQ3N32wTA8eXMSShxkUlMA19+G2sWIcdZnwkfUly+Trot9dXLO/YjD
	 xdY/o9WEg2EsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EBC3808200;
	Wed,  4 Mar 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] amd-xgbe: fix sleep while atomic on suspend/resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258900829.1554347.5287441049219471036.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:50:08 +0000
References: <20260302042124.1386445-1-Raju.Rangoju@amd.com>
In-Reply-To: <20260302042124.1386445-1-Raju.Rangoju@amd.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, Thomas.Lendacky@amd.com
X-Rspamd-Queue-Id: 0B4E51F9AE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263538-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Mar 2026 09:51:24 +0530 you wrote:
> The xgbe_powerdown() and xgbe_powerup() functions use spinlocks
> (spin_lock_irqsave) while calling functions that may sleep:
> - napi_disable() can sleep waiting for NAPI polling to complete
> - flush_workqueue() can sleep waiting for pending work items
> 
> This causes a "BUG: scheduling while atomic" error during suspend/resume
> cycles on systems using the AMD XGBE Ethernet controller.
> 
> [...]

Here is the summary with links:
  - [net,v3] amd-xgbe: fix sleep while atomic on suspend/resume
    https://git.kernel.org/netdev/net/c/e2f27363aa6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



