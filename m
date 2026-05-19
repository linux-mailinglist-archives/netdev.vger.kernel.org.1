Return-Path: <netdev+bounces-289623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJuwKTfdDGp5owUAu9opvQ
	(envelope-from <netdev+bounces-289623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:59:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B177D5855B3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 23:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B503B301997B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 21:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F63EBF35;
	Tue, 19 May 2026 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PAODQb4d"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7229B3E9582
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227953; cv=none; b=J+bmlg/c9EM/aawIaY+Tg8c2aPlQCHD1MHBbRSoHEKaaHMal97BdRuTcUNVFoYxKXyTELFE3SMe2bAEoqMHgJa8Yf0f1H6fCXGz8okePiP1NFiT2RvctDL2YRj12leN/X/y95C7z/8XMp11Z+BCCBCJljZyXmTgDOj0ps3p55i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227953; c=relaxed/simple;
	bh=YN/W5BZGqTP1q83IDV8HPtDRR6AKJWU9rbqelM1ecyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALSJ6CACATjlM2xvubgt7kmoNMS9RtD0PvinoHp2n9MLlT3P+eKfOBcX2CdgSNk5oYGQ7XZfFtugFdpVV31pGGx89h4QOKuxJZOMNtsYVN1e/E7EhHCTOhesPkaclZo36HW4yJUwVLxsw14aSu+YryRpgOXVEaFR0nWQ2+lVQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PAODQb4d; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779227950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iin+MykhrTNreja/QVKr8SkAh/iPwo5XPK3tnDQnPds=;
	b=PAODQb4druN14M9AkmMoIZ5m7MblN1Xqtnksspcb297zY4WSpaZE0NBkBjrhI2MEwDyayW
	2+z+5ChqvYGzLj93MDtRJb8BmoqkRGDb3rkUNmk+uEPWy1wFkivHDNTeq1eZVDJ6aurxxq
	nMUeQv7kw1H6MiVhmpGfV/JvlX8sMwE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	'Shakeel Butt ' <shakeel.butt@linux.dev>,
	'Roman Gushchin ' <roman.gushchin@linux.dev>,
	'Amery Hung ' <ameryhung@gmail.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH bpf-next 04/12] bpf: Remove unnecessary prog_list_prog() check
Date: Tue, 19 May 2026 14:58:11 -0700
Message-ID: <20260519215841.2984970-5-martin.lau@linux.dev>
In-Reply-To: <20260519215841.2984970-1-martin.lau@linux.dev>
References: <20260519215841.2984970-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289623-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B177D5855B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

Both replace_effective_prog() and purge_effective_progs() test
the "!prog_list_prog(pl)" to skip a 'detaching' pl.

When detaching a pl, pl->prog and pl->link are set to NULL in case
the update_effective_progs() failed.

However, replace_effective_prog() is not detaching a pl,
so the case "!prog_list_prog()" will not happen.

In purge_effective_prog(), the pl->prog and pl->link are restored
before calling purge_effective_progs(), so the case "!prog_list_prog()"
will not happen either.

This patch removes them as a prep work for the upcoming work
in attaching struct_ops to cgroup. When attaching a struct_ops
to cgroup, there is a link->map case and the prog_list_prog()
will not consider the link->map. The replace_effective_prog()
and purge_effective_progs() will then incorrectly skip a pl
with struct_ops map attached to it.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/cgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 876f6a81a9b6..71591f6dc458 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -946,8 +946,6 @@ static void replace_effective_prog(struct cgroup *cgrp,
 
 			head = &cg->bpf.progs[atype];
 			hlist_for_each_entry(pl, head, node) {
-				if (!prog_list_prog(pl))
-					continue;
 				if (pl->link == link)
 					goto found;
 				pos++;
@@ -1099,8 +1097,6 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
 
 			head = &cg->bpf.progs[atype];
 			hlist_for_each_entry(pl, head, node) {
-				if (!prog_list_prog(pl))
-					continue;
 				if (pl->prog == prog && pl->link == link)
 					goto found;
 				pos++;
-- 
2.53.0-Meta


