Return-Path: <netdev+bounces-295025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fgfsGaXhIGpT8wAAu9opvQ
	(envelope-from <netdev+bounces-295025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C285B63C7A7
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:23:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mvNfsPIK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295025-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295025-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E82D305AD18
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C552DF3D1;
	Thu,  4 Jun 2026 02:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244133A032;
	Thu,  4 Jun 2026 02:20:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539628; cv=none; b=Jk1vuYu+IRcxu5NpQ/tHHNS7jd8f7bg7ys/+j4nJQs+OX9L30WlDEBF1NB5+TaLBpI7eRGaC3gNx+ZIqHSgMOQAk19dkOeKYC7jlSha5FqvL+0atQwiTpsmlHxT9CUzJAXseD4vpHffBXP4Jlan4HI3TS0UbTFxNESzMzyeTKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539628; c=relaxed/simple;
	bh=vumErFYlhVPPbcxQLTxYJ3J5X5puUs+zubcrx43Sr5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RGpKltAZ4B9rsv2MqcMOfUKexMFLuNi5VzrDAss71jdDPX+q+xQdL+tjHwmYJsQTQLo0EtUpw1DJOcgLtu2B1THXzMNxubYqvRRnTFw8KWJMvqeNduAJp0bc8D5/pggaNFKgo8LLmaibChjQc+ENxDAg41Uc6MpQLXFG+S4jEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvNfsPIK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F811F00898;
	Thu,  4 Jun 2026 02:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539620;
	bh=mCksd8Oo8+Q+S0kNqShN+SnXDAHBCybVQ1V46Ezk9Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mvNfsPIKpHUR5EIFekJHMXWnFit4X/SLVwsgR/iO+w5X8wWUZjO8L+yDLZdBK17Gb
	 c+usL9h6jIdKK/aPAxV0q1969USfUMLe07bG4tBLq6QQxbTRivqwc8LCxNISjKfxFW
	 HBFWfCDeibvLetUyPVAyjEI/PSD6AqCbRY1V7y4Tmq8x2YuzF+5GpYZfUPv7V8MKiy
	 39G4+toBScM+0KQT8DDISjebglLhx3v6EeDMuyCCrNFv7sYJ6EAY/yb1bVjRH4yUR9
	 6haHwiGHqJxIhs0qHf1TzO+iiMn6qmgo5Rq8sp40GhnXKZ8WImUiL2cOvyZop4Gznw
	 2kPgaojLlPzOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93D3339308E1;
	Thu,  4 Jun 2026 02:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-06-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053962113.2207566.5562894926058000252.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:20:21 +0000
References: <20260603162714.342496-1-luiz.dentz@gmail.com>
In-Reply-To: <20260603162714.342496-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295025-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luiz.dentz@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C285B63C7A7

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 12:27:14 -0400 you wrote:
> The following changes since commit cdf88b35e06f1b385f7f6228060ae541d44fbb72:
> 
>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-06-03
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-06-03
    https://git.kernel.org/netdev/net/c/d20da9130830

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



