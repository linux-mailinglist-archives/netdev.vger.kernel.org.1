Return-Path: <netdev+bounces-298817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id owYZG4eWLGqzTQQAu9opvQ
	(envelope-from <netdev+bounces-298817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:30:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630267D0DB
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:30:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NPN4tdCA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298817-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298817-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 698963007227
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FF3D6CB9;
	Fri, 12 Jun 2026 23:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2523D5231;
	Fri, 12 Jun 2026 23:30:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781307009; cv=none; b=bZiEnEpNjsT6Ajr7QKo75PwxxigfxK3xHrBJouFfxKI1/1QGAmtJ9ALKJaHG8vHJff4d1Kh/+zBysMGMk+xpMFKbCidH0tZIIrX6DzoNvbqRi8ZNDEvxLujjPK2r18E/covpIt18UnYDanBTOJnGU50ek5jTeI1bU5R1J2KyEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781307009; c=relaxed/simple;
	bh=eo+WUzg/att0IsnELRzgKAMYVi9fz/WMA0kSQQiyC8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s9SVXf2g5iAIi3JyuA4+aG1aljAAsIMrzKNqJk/GoF46jxdX9Lx6ESpbLsd6LZoAQB2k2KVJBZgtHcK6AIpIJFJ0WNk7OLz5RcCgKC7xG7qE4f8JR4QXktCuQ1EkcDcCs8doqugCj2tGRX/n1uobhqaQ/2e2BMdy/u2jgQ8Kh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPN4tdCA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B381F000E9;
	Fri, 12 Jun 2026 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781307008;
	bh=a78Ydabh7K/+xnyLol+3opjSmu+u+3N/j5nDh7dKSQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NPN4tdCAqZxDQlPMvjAFf0qo5Z6bIaSl9OFwVkzQSEB0uNFJwTRGX7ls+DN5NgP9V
	 HfPGiVHsk2VD3lY0HOj/YBPTKm5A/b6DGhlTN7DUgn3EG8ZaoQxPRrCVoPQmIBrAT8
	 M39e5dGfBv/qjmR80abj51X/+4IJMkINa9rDDX8086suYBWLLe0tIIb2jLQKeawXoY
	 jLGfE5BLpA8NU+GSLfcv23EVls+tvuMp9fBsFSNCq6tlVpk4T/1p71Ap1Ym/EJr995
	 /eDSAsvcdMRyIacZeBZ4Gx5EkOKh4P7RtDq+Esdb0OS5eXazaJY+0/nFRXEQtSd0aH
	 cxKi0g/3r3f2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ABD39E9602;
	Fri, 12 Jun 2026 23:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: hsr: simplify fill_last_seq_nrs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130700464.1289947.14178453595763880988.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 23:30:04 +0000
References: <20260609171545.1051322-1-ynorov@nvidia.com>
In-Reply-To: <20260609171545.1051322-1-ynorov@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 bigeasy@linutronix.de, kexinsun@smail.nju.edu.cn, ynorov@nvidia.com,
 2022090917019@std.uestc.edu.cn, luka.gejak@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298817-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yury.norov@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fmaurer@redhat.com,m:bigeasy@linutronix.de,m:kexinsun@smail.nju.edu.cn,m:ynorov@nvidia.com,m:2022090917019@std.uestc.edu.cn,m:luka.gejak@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5630267D0DB

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 13:15:44 -0400 you wrote:
> The function checks the HSR_PT_SLAVE_A and HSR_PT_SLAVE_B bitmaps
> for emptiness right before calling find_last_bit().
> 
> This pass may be avoided, because if the bitmap is empty, the
> find_last_bit() returns >= HSR_SEQ_BLOCK_SIZE
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> 
> [...]

Here is the summary with links:
  - net: hsr: simplify fill_last_seq_nrs()
    https://git.kernel.org/netdev/net-next/c/8058d9755ecf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



