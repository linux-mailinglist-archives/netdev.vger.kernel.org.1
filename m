Return-Path: <netdev+bounces-268350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEP6G72buGkzggEAu9opvQ
	(envelope-from <netdev+bounces-268350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:09:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B92A22A9
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37634300879A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE8624B28;
	Tue, 17 Mar 2026 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saewXlGb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C81E89C
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706103; cv=none; b=GJkZKZr29+Ro6pTIwfcu+btUgX2pBn64NMp8K6TGVfcA4hLPU3dJ20zsHYfOBeYiBif6y3KO2m96hH/Pfs3AoLlGqjxO/s+YFExIyDMfo3pTLsyMNkmUZvyPbn6mjoOxmQqPgXaFFHZROu2akuPENhjSI9CXDlcndJSf83n6Jmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706103; c=relaxed/simple;
	bh=7qkgXyzzrbkR8aoOpHZPcO0wxCY3K6KDUUbpGo8VnwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mePdFSwAImoSWhSXaDHgKng9xsmTlF6g1kQcaPyTpYtfwEKRHLaGqOOR1JXlAFVBMMB2aHbrPXPIg59ThxJNemh+enGIdnowu5a3KIa+qHpuUutrzG7CrDMrKGKOi9M1hKpvBoAlvAnLDu+pyzT5KIcAbKMrIeI0OnvEc55lBlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saewXlGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA72FC19421;
	Tue, 17 Mar 2026 00:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773706103;
	bh=7qkgXyzzrbkR8aoOpHZPcO0wxCY3K6KDUUbpGo8VnwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=saewXlGbR/lH2Bpni066nL55EajGaW+S95GBJHX5Q4MS9fujxzspMFgdA9X9Gqh6M
	 eSvoHE18w5Wi4jYoGbsczm8b77jEOcGOtQqr1FhkRRkADfEmTmjp4xTN8g8vqLFEfC
	 X3Yw+QPLcQ4ZG/4NwFYvZI2uMdWrYzku6SLtsyJPwzTF7Ad4YRIcZ4ga+qMfmN0D9V
	 OuweG2anESRyBhcS7XFI7g5yWwJEtrkUQ1RHFp5+YNA+lTUhivaAJK/UvPsQUVZVyU
	 207kn52bEk0sfelUkMqiiOnkxOMb8HfUvTmDUsNxgASAvObQ4712Uu3fig7vbdcaKI
	 4EJxJeBVxvChQ==
Date: Mon, 16 Mar 2026 17:08:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bestswngs@gmail.com
Subject: Re: [PATCH net] net: bonding: fix NULL deref in
 bond_debug_rlb_hash_show
Message-ID: <20260316170822.3e35122e@kernel.org>
In-Reply-To: <20260315194404.579122-1-xmei5@asu.edu>
References: <20260315194404.579122-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,jvosburgh.net,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-268350-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B45B92A22A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 12:44:04 -0700 Xiang Mei wrote:
> rlb_clear_slave intentionally keeps RLB hash-table entries on
> the rx_hashtbl_used_head list with slave set to NULL when no
> replacement slave is available. However, bond_debug_rlb_hash_show
> visites client_info->slave without checking if it's NULL.
> 
> Other used-list iterators in bond_alb.c already handle this NULL-slave
> state safely:
> 
> - rlb_update_client returns early on !client_info->slave
> - rlb_req_update_slave_clients, rlb_clear_slave, and rlb_rebalance
> compare slave values before visiting
> - lb_req_update_subnet_clients continues if slave is NULL
> 
> The following NULL deref crash can be trigger in
> bond_debug_rlb_hash_show:
> 
> [    1.289791] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    1.290262] #PF: supervisor read access in kernel mode
> [    1.290494] #PF: error_code(0x0000) - not-present page
> [    1.290724] PGD 102a98067 P4D 102a98067 PUD 102831067 PMD 0
> [    1.291013] Oops: Oops: 0000 [#1] SMP NOPTI
> [    1.291202] CPU: 1 UID: 0 PID: 145 Comm: exploit Not tainted 7.0.0-rc3-virtme #1 PREEMPTLAZY
> [    1.291555] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.or4
> [    1.292058] RIP: 0010:bond_debug_rlb_hash_show (drivers/net/bonding/bond_debugfs.c:41)
> [    1.292286] Code: 83 fb ff 74 3c 48 c1 e3 06 49 03 9c 24 f0 00 00 00 48 c7 c6 d5 aa 9d 83 48 89 ef 48 8b 43 30 48 85

Please apply some critical thinking to the commit message.
Do you really think we need the code disasm for the second stack frame!?

Please trim the crash dump to what is relevant.
Around 20 lines of crucial stack trace and crash info.

Spend some time each day looking at submissions of expert developers.
-- 
pw-bot: cr

