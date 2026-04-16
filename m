Return-Path: <netdev+bounces-279072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIyVCi714GmInwAAu9opvQ
	(envelope-from <netdev+bounces-279072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:41:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EADE40FAFF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78A2A30078B6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8443DE431;
	Thu, 16 Apr 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXZD6tpE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5863ACF15;
	Thu, 16 Apr 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350438; cv=none; b=hTVX/kDMgqP69BWD0nbBCh/1RKvoZC0JdoVlWsFB10f9PwAVqZh8Jx9P4fifN/G8uwZV1qBI8lT4v8uoUdK2zqb5EdBRBls7Ua/wftmixL47zR9iC7/yeqEcmAoqFZ+7ku1ivg7Jg6vBzmWoiJ6H9hWVDWojpfnk+SFuGNj+KwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350438; c=relaxed/simple;
	bh=tT1416H5Bea/qRzPxcGIGfsbKTxzK3vYci/z3A9nqzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q/IT8GWkECd4DwrAlb2YqigaC2EOxujEJzfHu/AthaCeYB6Mlm1BpY60+NGxKjI6K1FqshOouitjYirspZRxz7CQhTuSQ9grj0kUrSn+g5ms75XXyEBeRyBdQRLPVskVDNVkX1/uiKP3QCih+aY04HrIb5+TGW95yLT1iMH39d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXZD6tpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A6C2BCAF;
	Thu, 16 Apr 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776350438;
	bh=tT1416H5Bea/qRzPxcGIGfsbKTxzK3vYci/z3A9nqzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QXZD6tpEX/td6SQMbqQJaGTBvq3Oi/r1LK5e/N8jauFyHxzlyrz/e8iWwSCAPVfaC
	 Gaf6cQ0GwT9PZsjwiE9fRxC+sq/qk4qS1hKj7iBp244AvMT5jvXoI2TuKyZdw78x6W
	 SBoa6iQnBu7HvKTJ859hpVpiZXq6vKjPxHLVAnM9DSTkfWm0Ml4FUzat8sutgbOJNH
	 w2jWcZvUSAho76W9XSmCdUHgumM0NfuClzx39YxvXhrJOXnUYjnQehiDOK37joZlSy
	 ujiaLU5C/M/ZSk+ZcwFTzvAcalpWAEthyXjNUbLydmvJYniJ+N+mpDubtl4FBNtamg
	 Heq8hbqTskztA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B63380AA61;
	Thu, 16 Apr 2026 14:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix precedence bug in convert_bpf_ld_abs
 alignment
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177635040680.3258205.15154840823715414256.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 14:40:06 +0000
References: <20260416122719.661033-1-daniel@iogearbox.net>
In-Reply-To: <20260416122719.661033-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279072-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EADE40FAFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Apr 2026 14:27:19 +0200 you wrote:
> Fix an operator precedence issue in convert_bpf_ld_abs() where the
> expression offset + ip_align % size evaluates as offset + (ip_align % size)
> due to % having higher precedence than +. That latter evaluation does
> not make any sense. The intended check is (offset + ip_align) % size == 0
> to verify that the packet load offset is properly aligned for direct
> access.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix precedence bug in convert_bpf_ld_abs alignment check
    https://git.kernel.org/bpf/bpf/c/e5f635edd393

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



