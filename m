Return-Path: <netdev+bounces-258095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN0gExxBi2mfRwAAu9opvQ
	(envelope-from <netdev+bounces-258095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:30:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A393211BECA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C964E3020A4B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8BF37473D;
	Tue, 10 Feb 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxioQdCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBCD374724;
	Tue, 10 Feb 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733811; cv=none; b=VqudtVtFq/iLzx6f3Sre40vgbYftKrKECtmyYld9wkTNNLw6rrB3xD49BPuOxHQ+TVEPAPq+pOEIEz2T8hLpbaTK5O8hOBTyBT3iMGmtVEQDdIKBjrVA5ylrUcyRbp0OxHHWa7txcFXbO4YsoIjZcR+EPFUVd1QKAOeX2xRoeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733811; c=relaxed/simple;
	bh=9WoUbIRtDZIqtFEW+NuWVJ3eqEgj1aP/zxNt0OAeNVg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lacKF7ksTcr/CEdcfZ8hTb3JzFsHLbhL4teO7JIIeYzHeHzkhxfK4u0TGJqPDIGJ9fqxVYLXCzTOwuhLU5wpmoDY6VbNT5Rk5szKSBE1IUJGsoR2c2TcYmMs1aC1XimB/J+M3/7g3A2IRk8csDh/E2y2ughgj7NxJtU8j1kLObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxioQdCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6974EC116C6;
	Tue, 10 Feb 2026 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770733810;
	bh=9WoUbIRtDZIqtFEW+NuWVJ3eqEgj1aP/zxNt0OAeNVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sxioQdCx9M2LD3SnZf8VJ2JjDz5wGfv+eKgiHD/d4TvFI3Su51MA7FQ8GIqzre7ht
	 bFSrNM1CcCPt7yqo+vyn1gwvC2SLLtoAI88d07523SZn0veoHxCu7XHM1ddkT4SFuZ
	 rxpSZgECWgT0f7xw7DYMR99uPp+8x0259s6BnCIKqDtrefxtOvx2h0ZbdNmuandNEt
	 CSa7DA/058jHvuVme9awtrNTjOxl9JtPD+hMgiNV3STCAiKRVyW7RdKockHDMyweF4
	 /K1zzF+ZkcVIsA2h3kM2d87bG0OpOT0cJdAgWtuTcQMwT62vUpauhZVP+lAqjE9rT1
	 QS6ss/yomsong==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B12839D267E;
	Tue, 10 Feb 2026 14:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] serial: caif: fix use-after-free in caif_serial
 ldisc_close()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177073380558.3533387.7854485978368784842.git-patchwork-notify@kernel.org>
Date: Tue, 10 Feb 2026 14:30:05 +0000
References: <20260206074450.154267-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260206074450.154267-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com,
 gregkh@linuxfoundation.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jirislaby@kernel.org, khlebnikov@openvz.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258095-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,827272712bd6d12c79a4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A393211BECA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Feb 2026 15:44:44 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> There is a use-after-free bug in caif_serial where handle_tx() may
> access ser->tty after the tty has been freed.
> 
> The race condition occurs between ldisc_close() and packet transmission:
> 
> [...]

Here is the summary with links:
  - [net,v2] serial: caif: fix use-after-free in caif_serial ldisc_close()
    https://git.kernel.org/netdev/net/c/308e7e4d0a84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



