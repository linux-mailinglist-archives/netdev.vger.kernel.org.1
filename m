Return-Path: <netdev+bounces-281564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKYLNYEE8GlmNQEAu9opvQ
	(envelope-from <netdev+bounces-281564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:51:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AC47C3CE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB82930315E4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1B623507B;
	Tue, 28 Apr 2026 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN5CLtgK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3F23504B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337458; cv=none; b=eIJBw4hnGsqLc6rWIUtp3CDHaJZwGo1VzBNUDU6VSjZHZqSgCmUDixGvDTTG3C+28pTy2aP77G5JqrHhB5wnJMNtdEjPGcMRsyklB1gw9PG9sZXstmqdbnM3LQPvdUwQXskghYVZ0hoDBDlytACAZZpT4fqzf+srh9GvYdrvoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337458; c=relaxed/simple;
	bh=4u3fOBLkg7bwwRHn/jMjMp3yIXtsrAn3Pp1vO36pLtg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uxS5k4CDqgzpzctfDGDWgCezaezRELkwamP6vLSnnq0luCmt3AWgxQa7UZL8cJly6p0WRkKt3NJNlB93t0RUnfwFAAG7oc8JN1N7jrOh/tTy4fBgTaTu6ii/GEof0Dr5TPA7Jpp7asHJ29D600ztABnGLzGlDmsIYtfDtmJdDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN5CLtgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B81C19425;
	Tue, 28 Apr 2026 00:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337458;
	bh=4u3fOBLkg7bwwRHn/jMjMp3yIXtsrAn3Pp1vO36pLtg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YN5CLtgK8FNnYdReLhkkdpjhySnXvwSBYBGBI/n45z8BnDJwe18rd6OEsCQAsT5Ce
	 ZnoqHNzwuYkZzNEs/208yFmj138ZMFA3194VEmfhqkuwBG4sL6xCnjFzg0Of2iWrWP
	 DPZQ+/s8lobpFMJ/onVu7p1AvdiSTegiAFdPrraDZFOrK+Q6jlxwReuPIFcFwpVQgr
	 8rILaZuRs0bCrW+Op1NNqM8bx879M/EM5So53N1obvTnrlMmoCJqKsAHTfNx+bdLy/
	 JcKWHIO4NQ0SW/sJm9Lv8kQwdjStdvrJl1gQLtiWXgsh4bkPZBl4ZKPeigrNxqnfr+
	 6I61tvo9dFS0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E5338119DB;
	Tue, 28 Apr 2026 00:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Do not read uninitialized fragment
 address in airoha_dev_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733741530.177472.9248284506411567966.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:15 +0000
References: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
In-Reply-To: <20260424-airoha-xmit-fix-read-frag-v1-1-fdc0a83c79e8@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: 547AC47C3CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281564-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Apr 2026 11:00:28 +0200 you wrote:
> The transmit loop in airoha_dev_xmit() reads fragment address and length
> during its final iteration, when the loop index equals
> skb_shinfo(skb)->nr_frags, at which point the fragment data is
> uninitialized. While these values are never consumed, the read itself is
> unsafe and may trigger a page fault. Fix this by avoiding the fragment
> read on the last iteration.
> Additionally, move the skb pointer from the first to the last used packet
> descriptor, so that airoha_qdma_tx_napi_poll() defers freeing the skb
> until the final descriptor is processed.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Do not read uninitialized fragment address in airoha_dev_xmit()
    https://git.kernel.org/netdev/net/c/bde34e84edc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



