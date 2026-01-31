Return-Path: <netdev+bounces-255333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI00IEh3fWkYSQIAu9opvQ
	(envelope-from <netdev+bounces-255333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:30:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21947C084F
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 04:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C3023003998
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279234E76A;
	Sat, 31 Jan 2026 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZURTRQC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0D241CB7;
	Sat, 31 Jan 2026 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830213; cv=none; b=P+X1ovDUYDJlxsSpX8D+o5wsSp/GGIhXbY2yX2x+LKghqWTfSCUBW8JU0KFqKqByWd+wW18fxFbfrEEjBvrhTdesLWvMSws7MbF21mg5tzYQNk1dVMqNdGMf/8f1f2EiwzFnzze//P4B5fXWdAUOhqOPvJgGU8gu6ayNcxpb7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830213; c=relaxed/simple;
	bh=KLNSvVh0Fwu5J9yX+RYnhAI0A+uTAxuBE3hQtekuz7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oFj3sgVYnw35L6js/Udyt9uTVe9XXpkQJHKm07VDxhvRsPlEh9NGe03gQ/tUDLY/slWxroWuvy47RipSp5V9aqmCFhHQFAhT4gm9x1hvKCnrq7rwyQInOVZdfY9ksbOxQEZ1E9/k4a6LPLmcW72RhvTac+W/WwbsSnC4Pyj1sJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZURTRQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C980C4CEF7;
	Sat, 31 Jan 2026 03:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769830213;
	bh=KLNSvVh0Fwu5J9yX+RYnhAI0A+uTAxuBE3hQtekuz7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GZURTRQCfUgMkCeFVO5RPhbgTcsdt9HXj867vz09x8kjNBhcovXpuZYebl0ydQ8ao
	 sTvoNwCSUmjVW0HYzdzajASkBzPoyYBthztvO4rQwt6dX/vx0nC48Q4zDPVtFfwKlK
	 QWvZfrISVOyBCWn5WO9nQS/2XYhG09xiFMecIx2/xjrlQII80oNxdKR3qyeEmQ5S+/
	 bY65u3wcGLfXxoar5TgBTNoG4/fORJUNxhaMjnqrtnyPRxXx6aNd8IV6pdAvc2s+3S
	 F//fk1wxnC+PfGv/CGrDEXROysiHH6rD47nmERj75Q93VOm/z6+1TShfIDVyLxpqqB
	 ayaJT0V2s0JBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CE6380CFFF;
	Sat, 31 Jan 2026 03:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] net: usb: r8152: fix resume reset deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176983020561.3983574.16514295663164511885.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 03:30:05 +0000
References: <20260129031106.3805887-1-senozhatsky@chromium.org>
In-Reply-To: <20260129031106.3805887-1-senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, dianders@chromium.org,
 tfiga@chromium.org, danielgeorgem@chromium.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255333-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21947C084F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 12:10:30 +0900 you wrote:
> rtl8152 can trigger device reset during reset which
> potentially can result in a deadlock:
> 
>  **** DPM device timeout after 10 seconds; 15 seconds until panic ****
>  Call Trace:
>  <TASK>
>  schedule+0x483/0x1370
>  schedule_preempt_disabled+0x15/0x30
>  __mutex_lock_common+0x1fd/0x470
>  __rtl8152_set_mac_address+0x80/0x1f0
>  dev_set_mac_address+0x7f/0x150
>  rtl8152_post_reset+0x72/0x150
>  usb_reset_device+0x1d0/0x220
>  rtl8152_resume+0x99/0xc0
>  usb_resume_interface+0x3e/0xc0
>  usb_resume_both+0x104/0x150
>  usb_resume+0x22/0x110
> 
> [...]

Here is the summary with links:
  - [PATCHv2] net: usb: r8152: fix resume reset deadlock
    https://git.kernel.org/netdev/net/c/6d06bc83a5ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



