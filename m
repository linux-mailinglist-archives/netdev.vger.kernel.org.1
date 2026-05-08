Return-Path: <netdev+bounces-286033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MHDBNZo/mmIqQAAu9opvQ
	(envelope-from <netdev+bounces-286033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:51:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5D4FC7B9
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D253301629D
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA739B4AD;
	Fri,  8 May 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nkllh9it"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCD377EDD;
	Fri,  8 May 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280657; cv=none; b=eKycYiZUTtrmMpL2IgjSK2FSerdjGochTF80XyQ5IBav7aAK6sW7NPnx+25q4NonSPZNPAncpEpOJiypf6E/EHsbqReUjwpIe24+J+xm0K66YntcuRH1mAxfaO8SW7RViFAIWKXoIaVHi/eGfiBXcgZ1+APLNnFWu7u8EvzzPoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280657; c=relaxed/simple;
	bh=MPh1d6oFUV5JHfG0QF650MwQ9Wo9IgpRIALDr5Lp0hw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lvxZG8O6A3wPnTaM8F/Jl9Evu+sMJUJvyQYtNUlDFURMl7JaeSG87exPr+4TwBwp5gn3NwnU/SCV1v/kVkQl7iNfd2atPtMk/QnQTRxOfqMWMEF5ybim0Es1NZ+dkmkYhNNJoPS0DYbdUo/7A7Dt+S3CdLSUkUOdgk2bDhpu7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nkllh9it; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F821C2BCB0;
	Fri,  8 May 2026 22:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280657;
	bh=MPh1d6oFUV5JHfG0QF650MwQ9Wo9IgpRIALDr5Lp0hw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nkllh9itxSNEWAnclSbsJkT2H8ErGJNRCPuCMQl+anKw/uTWi6AG4Zr7bh8B46yyL
	 0wJpfdBcDxKXCZu/9E3HPq93Gvv4T8Aa9SpA+CQGztnT4ZjLlXA1IDis63+bQdyxPS
	 2gZ8NSyACJE6E7AbdRmscwiSaNZlN0D5PMFALmtgI2zqO/e7vVWsXYjQzvuntPYVt3
	 JYPtp7LYlXcdsjXeZaC0382S/q8a+F//rdRgoxzTQoqloIlkuCIFjlI7CMccLE30+T
	 jkM6saW7pF1sZpgDNY+85EvqHFqGSacXLzQtjMvnXTmlOLbU352QxeuVdt6Fku28EC
	 Kd55Vv5u3E0Dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F1D38119D3;
	Fri,  8 May 2026 22:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] genetlink: free the skb on 'group >=
 family->n_mcgrps'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828060530.880817.15926150905197144874.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:50:05 +0000
References: <20260506-genlmsg-return-v2-1-a63ee2a055d6@google.com>
In-Reply-To: <20260506-genlmsg-return-v2-1-a63ee2a055d6@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch, mmaurer@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 80A5D4FC7B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-286033-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 May 2026 20:07:13 +0000 you wrote:
> These methods generally consume ownership of the provided skb, so even
> if an error path is encountered, the skb is freed. This is because the
> very first thing they do after some initial setup is to unconditionally
> consume the skb via consume_skb(skb). Any subsequent errors lead to the
> core netlink layer freeing the skb.
> 
> However, there is one check that occurs before ownership is passed,
> which is the check for the group index. So if this error condition is
> encountered, then the skb is leaked. This error condition is generally
> considered a violation of the netlink API, so it's not expected to occur
> under normal circumstances. For the same reason, no callers check for
> this error condition, and no callers need to be adjusted. However, we
> should still follow the same ownership semantics of the rest of the
> function. Thus, free the skb in this codepath.
> 
> [...]

Here is the summary with links:
  - [net,v2] genetlink: free the skb on 'group >= family->n_mcgrps'
    https://git.kernel.org/netdev/net/c/efda25ee8432

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



