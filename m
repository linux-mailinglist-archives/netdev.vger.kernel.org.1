Return-Path: <netdev+bounces-266302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCEbDrpssGmNjAIAu9opvQ
	(envelope-from <netdev+bounces-266302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:10:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF68256E1B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C6783071C04
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F13CB2D1;
	Tue, 10 Mar 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOkgfxy/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA042BD00C;
	Tue, 10 Mar 2026 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169812; cv=none; b=kmpCmmpk5T8xnCSVk+KA1CmawtlTWYb0aBwo4YxLcruYvXieHWG4v7Jy7TCnbG4NwbRi8otWdcRk84v4p1h0lH5XRttpnu6bxF8cZM2Rj0jAztGOUHkDx0RdxiSmZF6WJ+3s30u8bPeFH770kVs3f6hRmi8g2E27MyulJJFwtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169812; c=relaxed/simple;
	bh=ihdfgYmQoHZOKZoNO9sM/pCeu2BJgu6l6BTDMHQoKsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rIzWXlXHJ7BXNmlJoNETD9kgNvDcGRfNuSgQs96Xc36SjB8UBYPAKEfuGNCCSZv4r1djk0vLrwAZVXFCZEU0O5hPoBsRJpP+UggqktP5PaQAAwNPGKt4jxk0DwZFgZ/04JlnZZMWISDoxqNEYRZXDU8a30luNh5lZ1JaoX8545c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOkgfxy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D205C19425;
	Tue, 10 Mar 2026 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169811;
	bh=ihdfgYmQoHZOKZoNO9sM/pCeu2BJgu6l6BTDMHQoKsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oOkgfxy/fYKn7zc2YUOcb/bnKDeBdBk15XSnl6cv9ok59ntkwWlQu10fMBXRsvuP9
	 hKNKFdNncYbP01Xj/2EeJH/VWKY63l+KS+DNDqzkfjrrsEjndROkW5TFu2tWec5w1h
	 BiEQh9FmkjDcC1EdMxQQAwqbP8nOnZQG4rKNc1Vd2Xg/TLQgr4saxGbS5lka5xaG8t
	 xxuLEPQvd3gD5JCqYIfYGQcBPa+Fon69g2NAb0CTp7VCEfHwYUKpuDH4z7aHhuUXV6
	 79MExmKPQDT0e8in1zcmrJqbr8TgZ5K4vYaFXcyQ8EK92FyjCiXLU7KcQOiHjOpy4p
	 l0FzjJWlorhZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CED83808200;
	Tue, 10 Mar 2026 19:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] bpf: fix constant blinding bypass for PROBE_MEM32
 stores
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177316980830.2469448.16863487105813117785.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 19:10:08 +0000
References: 
 <Y6IT5VvNRchPBLI5D7JZHBzZrU9rb0ycRJPJzJSXGj7kJlX8RJwZFSM2YZjcDxoQKABkxt1T8Os2gi23PYyFuQe6KkZGWVyfz8K5afdy9ak=@protonmail.com>
In-Reply-To: 
 <Y6IT5VvNRchPBLI5D7JZHBzZrU9rb0ycRJPJzJSXGj7kJlX8RJwZFSM2YZjcDxoQKABkxt1T8Os2gi23PYyFuQe6KkZGWVyfz8K5afdy9ak=@protonmail.com>
To: Sachin Kumar <xcyfun@protonmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, netdev@vger.kernel.org, jolsa@kernel.org,
 haoluo@google.com, kpsingh@kernel.org, john.fastabend@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 eddyz87@gmail.com, sdf@fomichev.me, puranjay@kernel.org, emil@etsalapatis.com
X-Rspamd-Queue-Id: CDF68256E1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266302-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,kernel.org,google.com,gmail.com,linux.dev,fomichev.me,etsalapatis.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 09 Mar 2026 18:25:42 +0000 you wrote:
> BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
> bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
> survive unblinded into JIT-compiled native code when bpf_jit_harden >= 1.
> 
> The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
> to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
> before bpf_jit_blind_constants() runs during JIT compilation. The
> blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
> BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
> unblinded.
> 
> [...]

Here is the summary with links:
  - [bpf,v4] bpf: fix constant blinding bypass for PROBE_MEM32 stores
    https://git.kernel.org/bpf/bpf/c/2321a9596d22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



