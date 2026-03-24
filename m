Return-Path: <netdev+bounces-271333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNeLFAQYw2nAoAQAu9opvQ
	(envelope-from <netdev+bounces-271333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:02:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D331D9A2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866B43033080
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B123C7DF6;
	Tue, 24 Mar 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNoCZ/aR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2E3C6A4C;
	Tue, 24 Mar 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393218; cv=none; b=RUomi/cnJSftv53hgWyQ7pyxdOchzn97SahCZXH9mRxBJMrqgaS9kaX7CcLV6Wc0Isbvm7IWD4B64g7um+h5HGh6IXRSQu4NaRSSOUKn1aU1qexk90Ql+UqlDhkVEq1VI4IPXM6VGyUdhRp5rDN8opPXC3lPR+x5WKlXWsF/tuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393218; c=relaxed/simple;
	bh=KQxlvgDljIWttCUioUmVOheW5pdAG5lCdfGTEpT0UFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZK00r6zlSdWoUCKc6NdsSzzcc793uE8AEBZ2n/K7nTjN8njQ+iB28BGOj2PKcgC9HjdTR2CfVDzaQQRgKaQcqsf/ahMztUjsKbb3SY8hq6lANX8MTNTSDPcKbVhpYq7lG3gUwFT3oMtNJ1kzrXdDegAv28Sf3lA4ODjFIEnA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNoCZ/aR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC08C19424;
	Tue, 24 Mar 2026 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774393218;
	bh=KQxlvgDljIWttCUioUmVOheW5pdAG5lCdfGTEpT0UFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aNoCZ/aRgbLJhNVHlPvjJDb6+ftsfpraZTKJz/mEo900ul0Ec3BGRiq7BVYxajEw7
	 3ehWfUbg13zme1x/UvspMjFNXBWryup6zzrF5TkyusCjvavLGd4orAiu3WHwuXXijP
	 nR64hNNVpLJuPK94P4RZ6kQ14O9/nEZWT10c+2xsMTLMZ4pa8x/NiBYRLqKxZOkJ3W
	 jJoZRdLBUIPgGuguUVAOfNSt5vzSAXd1uAPx1z3ElgPcefTLHNSqBOgrGGbuAomX2+
	 hoF5VMWJLfTV6uRIGSSkuZ9Gx3AHjBT1x7LbENha5nsY1kU9t3Liv//NpFlsYUZPpf
	 sskCKQyXVD3dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DBC3808203;
	Tue, 24 Mar 2026 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: use RCU-safe iteration in
 dev_map_redirect_multi() SKB path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177439320580.1338341.8176625069776928433.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 23:00:05 +0000
References: <20260320072645.16731-1-devnexen@gmail.com>
In-Reply-To: <20260320072645.16731-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-271333-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA4D331D9A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 20 Mar 2026 07:26:45 +0000 you wrote:
> The DEVMAP_HASH branch in dev_map_redirect_multi() uses
> hlist_for_each_entry_safe() to iterate hash buckets, but this function
> runs under RCU protection (called from xdp_do_generic_redirect_map()
> in softirq context). Concurrent writers (__dev_map_hash_update_elem,
> dev_map_hash_delete_elem) modify the list using RCU primitives
> (hlist_add_head_rcu, hlist_del_rcu).
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use RCU-safe iteration in dev_map_redirect_multi() SKB path
    https://git.kernel.org/bpf/bpf-next/c/8ed82f807bb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



