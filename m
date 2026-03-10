Return-Path: <netdev+bounces-265871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EWIJkmJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93289244899
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D6773017002
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995023B5842;
	Tue, 10 Mar 2026 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ/WDWGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761623AE1B5
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111617; cv=none; b=DGgiXax2M4vgO5HgPEl+G9QdLItwFOjbQd09RFIk1ueIgn39oQXcrCxrGp1oGNvqHznvnB/FhN0Npj4fYU7TEHuP+3GAQ3rw17HkAF1POu1o96yT/3folmHHVGVc+KQncPD2RiwZDojlgS5IbOTrSXACpqYr6ASHwvNXv/9dpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111617; c=relaxed/simple;
	bh=+e2yBgyYxwj8sqWAw2NywShhZMa+o5Jo4d8QnO1DC+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dpfkvS8b/jKk+lDD/VTZRRiYM5QlVE/utCPzg2h9kai1PNmKmCq+BEJaF5bLxT19VNsSTRSw0i02TwYZ5Uo7wSgam5UfOTIABRQpZ2VCjqGGGrvbsCAxw+CI6ZoKEp1Ex04FWF4iCDivCM+1oly225i48x3ZKtfq0g2nMcvgAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ/WDWGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ABDC4CEF7;
	Tue, 10 Mar 2026 03:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111617;
	bh=+e2yBgyYxwj8sqWAw2NywShhZMa+o5Jo4d8QnO1DC+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CZ/WDWGoHi/QwRAnHVRGhUVRyVQ54d/IfEtvG5z3ih7aezWGTo4372mdSpKcuCIsR
	 uWIR1iIhkHlp7trn1grQI+vLgiIzO7vTrBEGEnl9lEBRiaWv4DB4Y5BibCaunPbd/F
	 u3OvAWwjkQz/PKW7+nxzUYKJKM6y1DHv1dLx0bi1E4Ov44YlSdH62EEevpJy75sA2Q
	 pYd35pefggHVMzF8kWnmMQEKcdM6pmsQMZvRcnOCdipGxaUjxaSMR1JUoj+qAKjS2r
	 7FKCYHo3smGgJCTNfe/QcpEaH38bmVuO4pPYi7IvFUUORZJHZZ5ZOqrIVwsEZv6lA4
	 aDLEw3Tk1lOHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D08D3808200;
	Tue, 10 Mar 2026 03:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnxt_en: Fix RSS table size check when changing
 ethtool
 channels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311161404.2039470.4258340536798777418.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:14 +0000
References: <20260306225854.3575672-1-michael.chan@broadcom.com>
In-Reply-To: <20260306225854.3575672-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, bjorn@kernel.org
X-Rspamd-Queue-Id: 93289244899
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265871-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Mar 2026 14:58:54 -0800 you wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> When changing channels, the current check in bnxt_set_channels()
> is not checking for non-default RSS contexts when the RSS table size
> changes. The current check for IFF_RXFH_CONFIGURED is only sufficient
> for the default RSS context. Expand the check to include the presence
> of any non-default RSS contexts.
> 
> [...]

Here is the summary with links:
  - [net] bnxt_en: Fix RSS table size check when changing ethtool channels
    https://git.kernel.org/netdev/net/c/0d9a60a0618d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



