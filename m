Return-Path: <netdev+bounces-262181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HhoK2Q5o2mU+gQAu9opvQ
	(envelope-from <netdev+bounces-262181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:52:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DBD1C6576
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 19:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747B932619F2
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED233CCA01;
	Sat, 28 Feb 2026 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2mGLDAx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB4E3CC9F9;
	Sat, 28 Feb 2026 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300402; cv=none; b=KOApNRzy5W1wql0rHiw5vMWa1csn42ehQ/ybptI0jpe9UOOFTNrhpu9iN9P3AKaRljmeuFx9VgBsvD0rHGdDpd2lEsz+bx9VOIGl80Lb3KQLEPR5EQ5lH1nG+JXAxaWS0MSsdifIaOYA8IKJszHtoX7T1gQ5nn8cgX2CP9Ae7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300402; c=relaxed/simple;
	bh=bSqXYpiN9FCneMlFl6TQ6PT7n7G+AvspnY3z3BZGn18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nfbydruf3SMFK3u3og+qNpUihURY0X8MMmGSGITtw1+faE5+PDScGQktkdXQfAGRShA4jrELac2nFC+iHw+XaSydKiH6W2GSLNPELef7lzp+m2kYmmD7u/xow6UJ/IZ2qzUZB4IspJVXC5GDGMKdcIQmJsAeyAv4vluxv2XHY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2mGLDAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACDDC19423;
	Sat, 28 Feb 2026 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300402;
	bh=bSqXYpiN9FCneMlFl6TQ6PT7n7G+AvspnY3z3BZGn18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2mGLDAxI7uQVmJO8bJV3iIPJUIRSXaak9F6FMqtqt8ax6++dcjtUumu1SwU6eIF2
	 PBWfdjrWag5zKf5+XeF0kcG4HSPydOT+zjQJEgNYBKQSuNx2GoetdEunF2W0h+QLey
	 fO1DqMjNNZThVDFCPrueD965ayhIOtQniH4ZqVo+E2d/rKerDNQeDdBoiLpRZAQjvt
	 QJhjjRr/FXW0iO4ymPW006X3GjktxUptpEFb2XT++3BOF7E8iJZtUYf0itzNE/hthT
	 f/NoYlg75KKF6r0JORJLbVIbzbuyW5UJuXf2BMqBVLCtZJMaNFMKwlmXJiM7xjJ2Rg
	 ZuiJ6PRqozyvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF0D39F2022;
	Sat, 28 Feb 2026 17:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177230040530.3024856.1166895485917045079.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 17:40:05 +0000
References: <20260225123250.189289-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260225123250.189289-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
 dan.carpenter@linaro.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, tglx@kernel.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-262181-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 34DBD1C6576
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 20:32:40 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
> This issue can be easily reproduced using the syzkaller reproducer.
> 
> In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
> multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
> When the underlying VCC is closed, lec_vcc_close() iterates over all
> ARP entries and calls lec_arp_clear_vccs() for each matched entry.
> 
> [...]

Here is the summary with links:
  - [net,v2] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
    https://git.kernel.org/netdev/net/c/101bacb303e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



