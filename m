Return-Path: <netdev+bounces-253694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMJpKVg4eGmmowEAu9opvQ
	(envelope-from <netdev+bounces-253694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:00:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E318FC5D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CF47300D754
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE43161AA;
	Tue, 27 Jan 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anx//39J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9C31619E
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769486416; cv=none; b=p511yVVVaPL4NUM01U+PR9sZA9bPE2m/uz3UuMYpCBD7EXFhIEH/z7UwN5G585/NIeLK9czDIFhPOUubfK2k1JdAxWg7UIhDKEDZ/nLHtJEfXsZT5wzte461T2+nUpGYj1+UdA2MaowK2fCkCfy46qEyWlPLAT+L4mwYsG1EfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769486416; c=relaxed/simple;
	bh=mD7oCMpFnY7XJti6/d851rboCBV8d7hroDMicpAjhYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IqpKCE5e0y9zMO4kZXdi5ZNpsbs8Febo0o3BO2+X5ryrIZuGnNz07VWWlmAVzAboXm0liGDVKpfUtrYHLYiVu5CUxie8kiudm857b2JcuFQpsX44Q1N/xFNcNtaa9+haUE94Yx51Bwtw1ixULkL9ycECR+oQRMAVKZ8VljrgEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anx//39J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E46AC116C6;
	Tue, 27 Jan 2026 04:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769486416;
	bh=mD7oCMpFnY7XJti6/d851rboCBV8d7hroDMicpAjhYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=anx//39JfCRof4vu1RX9bw5TtroqexJJyrW7outusRsHGUaEjrPmcqIhdvohODLyX
	 6EZraRUClSJncptbBMXOElRLsumT97MHmlmKpmAr1vH0a9mrdnGujnw+6/+RpiR2xf
	 odDkPWd9yFwmxycMbhajiJYJT5AkZECywWiiKePOZ1WSb1oWX/GoTMYgcLJw3TJhhh
	 x251bhl1BqfCeMSPrNyC4LOc0Px+NV1z7EOXQMvQpkq4Vpo6so1zspyb7MZ0r/OSQN
	 BL/A2DhZ0LRJqK6/TCLhZQnO1/UTZP6y5Md1BVFoB+PJjadaFSDLICKBUMz6Y6ps4h
	 gtmGIWlNTeoiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11BCB380A961;
	Tue, 27 Jan 2026 04:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] nfc: llcp: Fix memleak in
 nfc_llcp_send_ui_frame().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948641060.677485.17878577493024735025.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 04:00:10 +0000
References: <20260125010214.1572439-1-kuniyu@google.com>
In-Reply-To: <20260125010214.1572439-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sameo@linux.intel.com,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+f2d245f1d76bbfa50e4c@syzkaller.appspotmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253694-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,f2d245f1d76bbfa50e4c];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47E318FC5D
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 Jan 2026 00:59:28 +0000 you wrote:
> syzbot reported various memory leaks related to NFC, struct
> nfc_llcp_sock, sk_buff, nfc_dev, etc. [0]
> 
> The leading log hinted that nfc_llcp_send_ui_frame() failed
> to allocate skb due to sock_error(sk) being -ENXIO.
> 
> ENXIO is set by nfc_llcp_socket_release() when struct
> nfc_llcp_local is destroyed by local_cleanup().
> 
> [...]

Here is the summary with links:
  - [v1,net] nfc: llcp: Fix memleak in nfc_llcp_send_ui_frame().
    https://git.kernel.org/netdev/net/c/165c34fb6068

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



