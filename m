Return-Path: <netdev+bounces-270799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPgvIXPFwWlTWQQAu9opvQ
	(envelope-from <netdev+bounces-270799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8522FEADA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3422A3068EFD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B70383C91;
	Mon, 23 Mar 2026 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="olggVphl"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47CC382F3D
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306384; cv=none; b=of0EJSbV++RNSIGLWngFys3tGn+W6Kyv0wFJiufwrH36nnFXhJDmRFH4ifMNYHFYbWdlF19L29uEV3tmElSkslrz20EKfvd33RuL5prbKVWYwv47OXpMNKv/818z6ZzBAa1BPgJwRUW5QApD7EEKHNtjmNerD8YFvLLlRER3h1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306384; c=relaxed/simple;
	bh=9hwFuFeafiCxNX2rf9FhnT9pc7zjaDB2weIabKgX7OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQffHwNTB58IurDb0KYhuFKZa+431km50kNl1hl20le4yoerrAFL2Qa+TOVsr8iEQgRQSCtJYK5eyzuE4kA4+hX5bmkiAJcdGhRjKWSbvWm/aTEW5CGYIhlvWi35AXnBjcT0gYLpj4ggpIc28KV1rxvXqnCkTIQ8YSvYvTzDAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=olggVphl; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774306380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Awp8ntv1wXoCvwDEiN8wvX8nlownd7HDMmXlQU0i9yw=;
	b=olggVphlIokpcHuBYoGKv7Q7UZn4g3UFDrxK0/sYODAwmF4/JG9yk4fcoGk6vDfXvKX11+
	5EVAlo+G72nrmE3Rhv09qAwILSr9iQs2NzmfhQAeCLbHQxVSQxq4bs2Tub42BLlRNaarCw
	TZMoZmav/8Hkegopqr5SavnwxRGBGyU=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
Date: Mon, 23 Mar 2026 15:52:50 -0700
Message-ID: <20260323225250.1623542-1-martin.lau@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270799-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,suse.de:email]
X-Rspamd-Queue-Id: DE8522FEADA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
BPF_PROG_TYPE_LWT_XMIT test runs.

It currently checks ipv6_bpf_stub before using ip6_null_entry.
ipv6_bpf_stub will be removed by the CONFIG_IPV6=m support removal
series posted at [1], so switch this check to ipv6_mod_enabled()
instead.

This change depends on that series [1]. Without it, CONFIG_IPV6=m is
still possible, and net->ipv6.ip6_null_entry remains NULL until
the IPv6 module is loaded.

[1] https://lore.kernel.org/netdev/20260320185649.5411-1-fmancera@suse.de/

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/bpf/test_run.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 56bc8dc1e281..fb25184ed03b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1157,15 +1157,12 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 
 	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
-		if (!ipv6_bpf_stub) {
-			pr_warn_once("Please test this program with the IPv6 module loaded\n");
+		if (!ipv6_mod_enabled()) {
+			pr_warn_once("Please test this program with IPv6 enabled kernel\n");
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
 #if IS_ENABLED(CONFIG_IPV6)
-		/* For CONFIG_IPV6=n, ipv6_bpf_stub is NULL which is
-		 * handled by the above if statement.
-		 */
 		dst_hold(&net->ipv6.ip6_null_entry->dst);
 		skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
 #endif
-- 
2.52.0


