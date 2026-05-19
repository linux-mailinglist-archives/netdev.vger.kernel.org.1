Return-Path: <netdev+bounces-289207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM6kBqeoC2oGKwUAu9opvQ
	(envelope-from <netdev+bounces-289207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:02:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A9575581
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A72530479E8
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C9C306B3B;
	Tue, 19 May 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEzd/i/E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354E1F936;
	Tue, 19 May 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148815; cv=none; b=WMJ3XultvJx+zkJCALKYdcVShjqcxxHEH9RuRxhGZH0WTcJE9oTjnrrc0Fh3JvTk6SOu4UY6ik2aRbtKg0Bo/fdlpq5oCN2LKg8JbXD6RJfEZoMu5ASucq4aYauhO/r2uOHBI6hMyRi64KHBGupIvxomEPkSrYYvI9zadOZ27bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148815; c=relaxed/simple;
	bh=KE8DA/JCb9avfiHuOY5HiYe5wMxGEdLImFBSz7ksyfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XwTlqzCETM7t5ermk+n6ljekSHOuWPnAuM6fzXf2yPK9jROWKEVzdhkSnYX5wBSth92gdmxfMm3m05fABJ6Q+rwHX0wqObhwOa5iFpYUjhVaZcT2vTqfYNCsnqGZm53QJSKAYwL/h3qFOAE/0k8RERIauwCuSRWbrqlbRgwThz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEzd/i/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73599C2BCB7;
	Tue, 19 May 2026 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779148815;
	bh=KE8DA/JCb9avfiHuOY5HiYe5wMxGEdLImFBSz7ksyfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WEzd/i/EjA8nMyHyoZOBTjFXgRgcxSyrO+P2KwPSqSBloSO4KykcboCNDKd5u++yg
	 xMsqxnEdi6txndatKiy85bnTwgQ6hFhuOfTSqaybUdksAhEmy7Vh3T/qfxPmce71nO
	 xVxNw6YUXI+HETV2Sd5dFj/T2RNqJRYQJiwvN5x96GFT5IDpC110I4aPwsDP4tdtEd
	 YB2BdHLGUGfkaL0mWSLI2WHE5niP70sEEcZqI/MglnwcwQrWzsorFZemp+nHjrDFb7
	 mAhqcO/fWSdeSNXmP/2xgl1hOwaLYH2otGXW9o1N8NavnKgsy9DwfCFMfYJeC4aU0g
	 XBl0jYGN+a6rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198473930CBF;
	Tue, 19 May 2026 00:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netdevsim: psp: reset spi on key rotation and check for
 exhaustion on alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914882664.2018613.4044608075065988038.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 00:00:26 +0000
References: <20260515-spi-handle-v1-1-debf8cb467cb@gmail.com>
In-Reply-To: <20260515-spi-handle-v1-1-debf8cb467cb@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289207-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D63A9575581
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 May 2026 10:08:52 -0700 you wrote:
> The PSP spec states that the lower 31b of the SPI need to be
> non-zero. Though not in the spec, I think it is reasonable to reset
> the lower 31b of the spi space after a key rotation, and to also
> decline to generate session keys when the lower 31b saturate.
> 
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> 
> [...]

Here is the summary with links:
  - netdevsim: psp: reset spi on key rotation and check for exhaustion on alloc
    https://git.kernel.org/netdev/net-next/c/97386a9cf046

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



