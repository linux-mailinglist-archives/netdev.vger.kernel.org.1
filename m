Return-Path: <netdev+bounces-285086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMwXDlLd+2n9FwAAu9opvQ
	(envelope-from <netdev+bounces-285086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:31:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2126B4E1B31
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97F8830091CD
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 00:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B101AA1D2;
	Thu,  7 May 2026 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFDtnGao"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B9C40DFD6
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778113867; cv=none; b=YgEdWXumLOUXaj7dr0xiV3mJYN/Hl5rj+86vm+gw1Oy66Qr9kjz88wn6rZaZS0BkKevVFv5MADz8EvyIDMfzWjdCjpkNv1vJ/VTrJkkJNWU6CR8sJxw9/CBxRhFFY2dQL2U3Fm/rMSwtigr1Lt/ELOu3o3rhJqVTQy+AQ6dH2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778113867; c=relaxed/simple;
	bh=WbkAoqMaHzkFDsyZIIVsA7aV5R/kWRT4YV38Y10l48Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sh/BbRiteiQc2BupnUOhdc7F+OYEeT487noMEEIKGbOeTVa1HxNazA2qZ9RG0qvYU7l6x18Ld5lZrA0+8tEm31naC+wQ+NqhGLA6XGAMUjkGfT39CIcGT7HchbWUjLAEZl+dfhe1cW7spWQw3Ms/f+4e+ihmbjOcFrHOkmVsHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFDtnGao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D62C2BCB0;
	Thu,  7 May 2026 00:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778113866;
	bh=WbkAoqMaHzkFDsyZIIVsA7aV5R/kWRT4YV38Y10l48Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nFDtnGao+AlmpLPJSeq3fyyoqORz5p6NSzwoyqjaB9TxiLybuBh5FnsXhUhaifsuV
	 nX8kB1DvhPcHwp9IY2mqFCbuleDIi2f9wXSTEOuQOArXf77y4jhkuBcT4PwwvWC/sr
	 ha4I8nPNvc6Imec1eSse5U6AmdhJS25V1GvC6ArfIbCNe1SrUF+z/44i6C4JSPyYYJ
	 lmIb/v4f42oQEFYjBGRIX2RIILwpi1C/tIJaejjXCufCKgTOMlShncUshL6zDFzC18
	 z/zAHdPveXpcrSWs3ak9w0eASF3MHjc3OQZOvjlp75dR0sTMPuXYkVR2rGhNKq/fv0
	 AbuM4RM6caqzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF21393089F;
	Thu,  7 May 2026 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/8] ipv6: xfrm6: release dst on error in
 xfrm6_rcv_encap()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811381580.3276081.8751944163436887998.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 00:30:15 +0000
References: <20260505132326.1362733-2-steffen.klassert@secunet.com>
In-Reply-To: <20260505132326.1362733-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 2126B4E1B31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285086-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:email]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 5 May 2026 15:22:57 +0200 you wrote:
> From: Yilin Zhu <zylzyl2333@gmail.com>
> 
> xfrm6_rcv_encap() performs an IPv6 route lookup when the skb does not
> already have a dst attached. ip6_route_input_lookup() returns a
> referenced dst entry even when the lookup resolves to an error route.
> 
> If dst->error is set, xfrm6_rcv_encap() drops the skb without attaching
> the dst to the skb and without releasing the reference returned by the
> lookup. Repeated packets hitting this path therefore leak dst entries.
> 
> [...]

Here is the summary with links:
  - [1/8] ipv6: xfrm6: release dst on error in xfrm6_rcv_encap()
    https://git.kernel.org/netdev/net/c/bc0fcb9823cd
  - [2/8] xfrm: ah: account for ESN high bits in async callbacks
    https://git.kernel.org/netdev/net/c/ec54093e6a8f
  - [3/8] tools/selftests: Use a sensible timeout value for iperf3 client
    https://git.kernel.org/netdev/net/c/ada95e5e603b
  - [4/8] tools/selftests: Add a VXLAN+IPsec traffic test
    https://git.kernel.org/netdev/net/c/e64e03b478e2
  - [5/8] xfrm: Don't clobber inner headers when already set
    https://git.kernel.org/netdev/net/c/fa90a3145c03
  - [6/8] xfrm: provide message size for XFRM_MSG_MAPPING
    https://git.kernel.org/netdev/net/c/28465227c80f
  - [7/8] xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
    https://git.kernel.org/netdev/net/c/14acf9652e56
  - [8/8] xfrm: esp: avoid in-place decrypt on shared skb frags
    https://git.kernel.org/netdev/net/c/f4c50a4034e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



