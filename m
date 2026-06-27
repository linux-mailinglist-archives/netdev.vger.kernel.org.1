Return-Path: <netdev+bounces-302294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QwqlELQsP2rvPgkAu9opvQ
	(envelope-from <netdev+bounces-302294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:51:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A406D0C07
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 03:51:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=osgeK+kU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302294-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302294-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF0C305A5C1
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 01:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13772274650;
	Sat, 27 Jun 2026 01:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE7259C82;
	Sat, 27 Jun 2026 01:50:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525031; cv=none; b=E1psj3DCGhpQIG1G1Ehi3KaYvrMXU3AHnDKIDwPNF2RgVrPiTdQ56GBSd8gutAxgbOJf8LdSpXvgd+5+1ZRuPHbWm3d3D6YXqaBTcUWu4+JEwiQ4BPok/2PI4QHJTRTCEsC9NLu6vnI5t1eMlnMNH03F8I4MIxmI/6W8O6j3taY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525031; c=relaxed/simple;
	bh=Sk4pWI5MXwJ3FyfGMprFGVWbLtqkznttaPGszFBnoYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sEP84Z7FwfvyyFI+DBpv4nr5iIilkYpy1iaQcOkV02CpFi/B3a1aHiwFhaW8vj56VkmPfcGVXZlnfxrQsF3cEEetkdfxjcTp3wgXupTX8WftVRhUwQidFBmK1/HeUil+t3zWbgz5NbitbsRNfWohlZMZECXhwu52Ov+LRrtlHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osgeK+kU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE071F00A3A;
	Sat, 27 Jun 2026 01:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525029;
	bh=mW/Md5slDKdXQwiHCdWi8GyJm1tqD46vKekkDfH4pGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=osgeK+kUIwIl2oX10Xs5LePUP88oqBB8XJWRpllyH6NVAafD4iziMu+LGmxdEy1Vb
	 G1NeR0AyFdP2BySEHMnPKc2iSWX6ninotquUWd/MtGRZNnD00QqsgFDrgvF9M28PnB
	 azhf0+fZx6XueDSr/0SkbIscJt9TIpycaLIcRHEo8aLDBoBHNrdXzZGup/CbJap5dT
	 rnmp+aXBZFjLEi/HUWmhyDQgkgNox0gsaVEYI9Gfj6qn06tQklA0v4SZ/trobBnbpQ
	 ypSwqvq9zEHT6wGV26xd08Jq4ZAhd0y+Xg39tYDOPhIWx9FJkSQ62nrStnOZL+ISdm
	 /GcssI5adJeHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198EB3938C76;
	Sat, 27 Jun 2026 01:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: pse-pd: scope pse_control regulator handle to
 kref lifetime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252501581.1164679.1241502299993931016.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 01:50:15 +0000
References: <20260624204017.2752934-1-github@szelinsky.de>
In-Reply-To: <20260624204017.2752934-1-github@szelinsky.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corey@leavitt.info, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,leavitt.info,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302294-lists,netdev=lfdr.de,netdevbpf];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corey@leavitt.info,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80A406D0C07

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 22:40:16 +0200 you wrote:
> From: Corey Leavitt <corey@leavitt.info>
> 
> __pse_control_release() drops psec->ps via devm_regulator_put(), which
> only succeeds if the devres entry added by the matching
> devm_regulator_get_exclusive() is still present on pcdev->dev at the
> time the pse_control's kref hits zero.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: pse-pd: scope pse_control regulator handle to kref lifetime
    https://git.kernel.org/netdev/net/c/16759757c4d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



