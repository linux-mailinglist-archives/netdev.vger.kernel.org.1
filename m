Return-Path: <netdev+bounces-290528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BHmITAsD2r+HQYAu9opvQ
	(envelope-from <netdev+bounces-290528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1475A8D2D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FD343097B03
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C35349CF2;
	Thu, 21 May 2026 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgYr5JNX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF31346FDA;
	Thu, 21 May 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376804; cv=none; b=TNozwLpVD8YZSlwkAgPvl0cVW5SHmK0YbY4iowG4zmBl47QmUnXT1/bv8DVJNelTnY4Kh6RqdhxDSBGTXU3ukxLBWK8ndbd7/hJ2aLuFleoWZyxQxg/23QJIgH6bdnHkVYGnLHn2J3hCV1YkVn7u8j3FHNUvxKPM2i38hF9iy1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376804; c=relaxed/simple;
	bh=c2pb3CTFTN6e3ANuLnPdWLo4qrL6AegPnUq7G0f/C4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=boLWNclBXpERzmbVuAk9442oW8KBZ/rUsKOur7HvVBynhyftifJ7uyuAntNxzaRms8jfPlIMInwZuMQi6/XfNGHAU46qSXlY19sEa6RypPP8NIwqHAduOKFCX93964jk5pwfpVa/O9TxF/JswFC5PeCIfX7iVJSBaQa3R4BNrj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgYr5JNX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406591F000E9;
	Thu, 21 May 2026 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376803;
	bh=uDaaoq6QV8BI/Q9PBLoh/DVI/Cnzm0iK+gOhzH6ejlc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mgYr5JNX/Rj/hGadhqBxzU/Fhdxo9btiYcVUJoVUbpU2AQFkk6obt6wSKJbQ2WNlx
	 GfSfZN9o+AXaV5T6+iauMEjkOQDcZAOmY7TA6by7GDDvsNnFvL5QLIr/V+EF+BVFw3
	 zBSYG7D16MT8hEJiV4SHXzEVI8xtQt4YZj7RMH+0TBIT00NQzSbSSw7taPa1TfrMx4
	 CdyJv6+FWdADDz0c0yBrrokS+f5RbrGOgrFlUau5qlAi3S73I0+NBbb+sYtW/fz20e
	 sKMa/D7d4amdEp7dYDRma5Id6bmFQDu1nlNOC2h+nbzJsAB/gDuR5r7q9LNQM0xO81
	 jq/FrNDXyXLKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569913930E00;
	Thu, 21 May 2026 15:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: npc: Fix allmulticast skip logic for
 LBK
 and SDP VFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681289.379332.18385656444728574089.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:12 +0000
References: <20260520043036.1523798-1-rkannoth@marvell.com>
In-Reply-To: <20260520043036.1523798-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: davem@davemloft.net, gakula@marvell.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290528-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C1475A8D2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 10:00:36 +0530 you wrote:
> When installing the allmulticast NPC rule, rvu_npc_install_allmulti_entry()
> should skip LBK and SDP VFs (only CGX PF/VF may add the entry).  The
> code combined is_lbk_vf() and is_sdp_vf() with logical AND, which is
> never true for a single pcifunc, so the intended early return never ran.
> 
> Use logical OR instead.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: npc: Fix allmulticast skip logic for LBK and SDP VFs
    https://git.kernel.org/netdev/net/c/9eddc819f00b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



