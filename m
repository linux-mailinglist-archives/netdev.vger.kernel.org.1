Return-Path: <netdev+bounces-304754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PNwuLhgISmrL9gAAu9opvQ
	(envelope-from <netdev+bounces-304754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 09:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0739709366
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 09:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kernel.org header.s=k20260515 header.b=mcy2mpHw;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304754-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304754-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A52573002924
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 07:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24A303A35;
	Sun,  5 Jul 2026 07:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133D213A3F7;
	Sun,  5 Jul 2026 07:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236626; cv=none; b=TgVWIHIbl4FXWgs6xfusjT/46Vnbz18yWs/Je0uX3zQ8BXLwjQ6nRw8viZ0V+NgCo7smRMFm5C/kuJKRQfXLYNzhg7fbku6SeKeQZ2k3IYZ8EQJlOfuMskTNdgsI8MPuHK7eoaI2eIcHZ3a5rn2ttHZD1MybhvCK5rxKCwqj3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236626; c=relaxed/simple;
	bh=KwzAvgvm+w6lnAxK8HeBT4TI/nRFEPyX0IemfKj9vH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fd0BW5c8oxjoId29rGvIayCPe2b6+UkdRUXELuOKlYFHYcApji/YXLYj3E614BChdA7895lK27mrgVXy5QxFIr4jzEIkDS9aanPrZakdi0x78xJlZSmaPptiELi+E8lwAnOTzHD2y50HO8M1G46A1140HV/VcIa5pKVC03Ly+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcy2mpHw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B061F000E9;
	Sun,  5 Jul 2026 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783236624;
	bh=g0zqh/4IWoGPglrnJGkQTqXcAtUbh6knkgcgOB1qXSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mcy2mpHwfSK2vn8lH1FXiRvw/QZLxBdrolI7dmAwoe+h0pclkxx0sFBMpZTdVgyCS
	 nzbftg9r/383Lxzt7zcVNWhnWd/T5z8DnK5chK9tRBpFbOO8H+SF1ahW9S5jXXLwBD
	 4ExTm49txx1aCcB3p+s6/hsod99LrrXoJetXrCEgiMg4rqLK53bHRLqTuOtCDa0u95
	 bPW/zcULgeW80k+W4b1N1SgfOQD2NEv+Nz/ocWp/1D7ot/kL7EE4QmjZuF/nGVkkHt
	 pJG7vsQEOl4xb8/C9NpWYzejIKik+1oxNriZIhlUj8q966um8FPADQaUQIJZaQBBRY
	 /kH0L0f0kX1eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5698C393A94F;
	Sun,  5 Jul 2026 07:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: microchip: vcap: fix races on the shared Super
 VCAP block
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178323660590.3752073.10824310525866470753.git-patchwork-notify@kernel.org>
Date: Sun, 05 Jul 2026 07:30:05 +0000
References: 
 <20260630-microchip_fix_vcap_locking-v1-1-f60a4596734d@microchip.com>
In-Reply-To: 
 <20260630-microchip_fix_vcap_locking-v1-1-f60a4596734d@microchip.com>
To: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard_=3Cjensemil=2Eschulzostergaard=40?=@codeaurora.org,
	=?utf-8?q?microchip=2Ecom=3E?=@codeaurora.org
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, steen.hegelund@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard_=3Cjensemil=2Eschulzostergaard=40?=@codeaurora.org,m:=?utf-8?q?microchip=2Ecom=3E?=@codeaurora.org,m:horatiu.vultur@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:steen.hegelund@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304754-lists,netdev=lfdr.de,netdevbpf];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0739709366

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 14:20:13 +0200 you wrote:
> The VCAP instances on a chip are not independent, yet they are locked
> independently. On sparx5 and lan969x the IS0 and IS2 instances are
> backed by the same Super VCAP hardware block and share its cache and
> command registers: every access drives the shared VCAP_SUPER_CTRL
> register and moves data through the shared cache registers.
> 
> Accessing one instance therefore races with accessing another. The
> per-instance admin->lock cannot prevent this, as each instance takes a
> different lock.
> 
> [...]

Here is the summary with links:
  - [net] net: microchip: vcap: fix races on the shared Super VCAP block
    https://git.kernel.org/netdev/net/c/d7a8d500d7e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



