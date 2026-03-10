Return-Path: <netdev+bounces-265825-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH9tEvtrr2m8YQIAu9opvQ
	(envelope-from <netdev+bounces-265825-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:55:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A312432F3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A8F3123FBC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B67E27CCF0;
	Tue, 10 Mar 2026 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHMXvV4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280112773EE;
	Tue, 10 Mar 2026 00:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104036; cv=none; b=q73A07iG2N3ppx6n2nUOGWuxhj0tdzOid6CeqWDmR0VktZzuNuXSg9Zr9NwbVEym89a9yNAKt9MvlFi1xRtTi3W3OIFSwoqLVCpuSyBFIw1Lh5I/9qj9MP4gvPzgwkq2/YuZkMVWxVRVk3Oc/Qb1At/5y6wnMgo+Ev3d4MmhfRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104036; c=relaxed/simple;
	bh=NX2cvUA6wnhoxJ70P2P0si+IE+BvhFgKaDbjiB+k1us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtQ1C2arrjgEUBqqJsGMgz88zDR2GlMjdlWbS8x88X4CJEE0j0DnYrcf5ahy+MwAFOOK1mg4icUY47W5mFfH7HaJTofLfJperqbJE5oJwOSZWFew6mxLfHku9eJYJ8AChlGTZgegdAq07UG+GYT+GA/AS8gbTh7X1CdUns62Bjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHMXvV4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39ABC2BCAF;
	Tue, 10 Mar 2026 00:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104035;
	bh=NX2cvUA6wnhoxJ70P2P0si+IE+BvhFgKaDbjiB+k1us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pHMXvV4EU3LvApgSfNejytAU52vls3oIQz6zNOvfJSr0oDB1LbwsW4+lHOA0p8SXJ
	 U7ZeCGQPfQO3vb2nglC3dw+krENfNDTvk4UZPYnUO4noXDNCqQeaEFUYUsEFcfTdSH
	 N3gTolF+lKxGIAIV2j44887t/WRHD+vqR3Ww29pKYXimvq+slEY+zGIuFMJ15fAr6l
	 VWBKBTlnebeKVGQv3Gnc29C2mzwZ7sQS8kR0WyTncp1ID3pO4AAh3PjMM0M4Vb30E+
	 jdYf+islbzV1wDsX8wQ2DiFrkatp+JP0OLoSQeSmQE6Yh7SFNpMQkq91o2tNpQFAHP
	 vLBSEg9dADJsA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] tools: ynl: cli: add --policy support
Date: Mon,  9 Mar 2026 17:53:37 -0700
Message-ID: <20260310005337.3594225-6-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310005337.3594225-1-kuba@kernel.org>
References: <20260310005337.3594225-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95A312432F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265825-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,args.do:url]
X-Rspamd-Action: no action

Add --policy flag which can be combined with --do or --dump to query
the kernel's netlink policy for an operation instead of executing it.

Examples:

  $ ynl --family netdev --do dev-get --policy
  {'ifindex': {'max-value': 4294967295, 'min-value': 1, 'type': 'u32'}}

  $ ynl --family ethtool --do channels-get --policy --output-json
  {"header": {"type": "nested", "policy": {"dev-index": ...}}}

  $ ynl --family netdev --dump dev-get --policy
  None

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/cli.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index b452d4fb9434..fc9e84754e4b 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -256,6 +256,8 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     schema_group.add_argument('--no-schema', action='store_true')
 
     dbg_group = parser.add_argument_group('Debug options')
+    io_group.add_argument('--policy', action='store_true',
+                          help='Query kernel policy for the operation instead of executing it')
     dbg_group.add_argument('--dbg-small-recv', default=0, const=4000,
                            action='store', nargs='?', type=int, metavar='INT',
                            help="Length of buffers used for recv()")
@@ -308,6 +310,16 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     if args.dbg_small_recv:
         ynl.set_recv_dbg(True)
 
+    if args.policy:
+        if args.do:
+            pol = ynl.get_policy(args.do, 'do')
+            output(pol.attrs if pol else None)
+            args.do = None
+        if args.dump:
+            pol = ynl.get_policy(args.dump, 'dump')
+            output(pol.attrs if pol else None)
+            args.dump = None
+
     if args.ntf:
         ynl.ntf_subscribe(args.ntf)
 
-- 
2.53.0


