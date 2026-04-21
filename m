Return-Path: <netdev+bounces-280206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOZsON2352mu/wEAu9opvQ
	(envelope-from <netdev+bounces-280206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:46:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199F443E259
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 19:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F9903025912
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2BC31E830;
	Tue, 21 Apr 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw22hRcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390D24C6C;
	Tue, 21 Apr 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793243; cv=none; b=RRBI0t/4xyYn8MykeepdkPwxAII3mL13H421spTL/kikMMwhdQmYt65v6EPmgw0GzDsZ7IPdBIeFHjS1mjgSbMEcCbGEQtBhBavxpXo6Z+INgYHsSRsGAwNgrtsYhAa8QwWfAEFgJdZNJ3UEUcMy9fL4m47lc80DYEda/jBR4eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793243; c=relaxed/simple;
	bh=zSo34kjP8pafihdertQW/cXjfDj2lQafQswq2RgbTK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GKBfbRQG4uXH5c+BXU8tfzYK7rEDdfHN93j+NgKsB6WyYG7vvVBORDmkUCvIwSV4wCUpzpbyRebCf3J8y7K/iLlcGZETf50FkRRQjtUFSUNnYiYWwUE3hd9IjDe0rzhRkqjNZWGkXf0UwTJNpvwX2fbdnTvG+1t6d1e0gdywEB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw22hRcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CF2C2BCB0;
	Tue, 21 Apr 2026 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776793242;
	bh=zSo34kjP8pafihdertQW/cXjfDj2lQafQswq2RgbTK8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iw22hRcwxd06CYUyi13WG0ar05JMor6NzWnWqXk1Oq+MF+zPaaxRKG3R0X0gp4NuQ
	 KhYhX8Xyh2AYJagUtMjBfFkTtRYxDochH48PEsWsy107Jt2qn1BWWadHZC2/4Mtxzv
	 CjoiKT5KsCW7SNZOfpyL5g77H5Lor8l+5+w6OtuKM3Z88ME+prrhbysLcYA/Q+on5p
	 U28U/Dm2wF8VlK6CgBf9rtclKD3Bw0xQjQTz7My3PgUrNO9dLnA+A0NLj4B8y1N30P
	 7MXoA8wzKf8bqB/nsoDSAHj5WQIQznz72Qbkg2e1StXs+DO8RCez6sJqzPe2uhLabN
	 mwkRH3j25JGcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD3239301B9;
	Tue, 21 Apr 2026 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: ISO: Fix KCSAN data-races on iso_pi(sk)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177679320605.2928707.16734719453361782576.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 17:40:06 +0000
References: <20260421025122.55781-1-suunj1331@gmail.com>
In-Reply-To: <20260421025122.55781-1-suunj1331@gmail.com>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, me@brighamcampbell.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org,brighamcampbell.com,linuxfoundation.org,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280206-lists,netdev=lfdr.de,bluetooth];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 199F443E259
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Apr 2026 11:51:20 +0900 you wrote:
> Found while auditing iso_pi(sk) field accesses after a KCSAN report.
> Patch 1/2 is the reported race on iso_pi(sk)->dst in iso_sock_connect();
> patch 2/2 covers related races on other iso_pi(sk) fields accessed in
> iso_connect_{bis,cis}() and iso_connect_ind() that were found by
> inspection during the same audit.
> 
> Changes in v2:
>  - Patch 1/2: Use sa->iso_bdaddr directly instead of caching the
>    bacmp() result in a local variable, as suggested by Luiz [1].
>    This avoids reading from iso_pi(sk) entirely for the broadcast
>    check.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
    https://git.kernel.org/bluetooth/bluetooth-next/c/20ca2749b31a
  - [v2,2/2] Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
    https://git.kernel.org/bluetooth/bluetooth-next/c/66d4d518020b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



