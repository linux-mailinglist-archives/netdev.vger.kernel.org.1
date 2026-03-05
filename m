Return-Path: <netdev+bounces-264143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OkJOR7tqGnnygAAu9opvQ
	(envelope-from <netdev+bounces-264143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:40:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E71220A428
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01E12302E792
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802D23C39A;
	Thu,  5 Mar 2026 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNJzPXq0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252FC1AB6F1
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678428; cv=none; b=QvvU6PqO9XB3Q3cJ/VBXsxD1klK+WjWPKQU9PvBnpnYdQNJw6O6+EGVPg2Ay3hSmS9vY5b9Dng4uV553LNwglGhLbaTvSSF8OThBLDTJ657FqdbTr7J0qS0N2RWn9//UOQgx5OhIORV5ZZ4gbvHYDMR6bBKRG1dL9biLwm/gK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678428; c=relaxed/simple;
	bh=VSWa+YyGADdIQ93k/xkkDcoIZfPvySY9cmyn7w3eHec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KlkjMpG/E8A3qneHH42Ij6h6WZ9i7ENqDPLlnu2hQIDOaRZCwkKk2lPByMfcTBzY0YwWjxPe2ryfp6CScKJzaxlIXyhq1I2kMkTNqaq4Qnj+huOOwMhPN6KWdKqeQ/14S9eHK5WoUGJ6j1NX7+X99a1pjxBY2gcJShpzLUmbIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNJzPXq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3373C4CEF7;
	Thu,  5 Mar 2026 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772678427;
	bh=VSWa+YyGADdIQ93k/xkkDcoIZfPvySY9cmyn7w3eHec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rNJzPXq0kNMjWTdxb9/U3iqki31Dz3J39xMzgneBxN2rpx8ODs8ggxq5oioBRrk9G
	 MaghHrIf5hl+GWJ9o9rgXZo4P05CuNEjFcv+FMGe9remPteGrb+rPexdHUwOpdTt2v
	 InEUZBg9hH+AJyWPY/z7QiDVtKix3YWL2pEsF9Q8UCqEyVy1CrxzS7V+K0g5XANnNp
	 3NqXIWJNlVZgd0lceNb0CapquR7VVqmVdVJ8sC3IdDEQ0YbaIZjNOWiVQdxky/fDkY
	 ldF1GeTcJtKF7DGPPXs5bSK0UJFb7+0y0314mZxR854n6MBdY+RuMtHzxyaucv7W2W
	 E4Vfy9ds/I+vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF23808200;
	Thu,  5 Mar 2026 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] nfc: fix leaks and races surfaced by NIPA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267842805.2487871.16135390163428111966.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:40:28 +0000
References: <20260303162346.2071888-1-kuba@kernel.org>
In-Reply-To: <20260303162346.2071888-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
X-Rspamd-Queue-Id: 4E71220A428
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264143-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Mar 2026 08:23:40 -0800 you wrote:
> I recently added the nci test to NIPA. Somewhat surprisingly it runs
> without much settup but hits kmemleaks fairly often. Fix a handful of
> issues to make the test pass in a stable way.
> 
> Jakub Kicinski (5):
>   nfc: nci: free skb on nci_transceive early error paths
>   nfc: digital: free skb on digital_in_send error paths
>   nfc: nci: complete pending data exchange on device close
>   nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
>   nfc: rawsock: cancel tx_work before socket teardown
> 
> [...]

Here is the summary with links:
  - [net,1/5] nfc: nci: free skb on nci_transceive early error paths
    https://git.kernel.org/netdev/net/c/7bd4b0c4779f
  - [net,2/5] nfc: digital: free skb on digital_in_send error paths
    https://git.kernel.org/netdev/net/c/d42449d2c17c
  - [net,3/5] nfc: nci: complete pending data exchange on device close
    https://git.kernel.org/netdev/net/c/66083581945b
  - [net,4/5] nfc: nci: clear NCI_DATA_EXCHANGE before calling completion callback
    https://git.kernel.org/netdev/net/c/0efdc02f4f6d
  - [net,5/5] nfc: rawsock: cancel tx_work before socket teardown
    https://git.kernel.org/netdev/net/c/d793458c45df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



