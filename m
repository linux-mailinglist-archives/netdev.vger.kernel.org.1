Return-Path: <netdev+bounces-265823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM6dOM9rr2m8YQIAu9opvQ
	(envelope-from <netdev+bounces-265823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:54:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 496142432A9
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8546B30F69D3
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC427E07A;
	Tue, 10 Mar 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUTY2WHE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B227E074;
	Tue, 10 Mar 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104032; cv=none; b=Cshx2xU7gjMW+jKZ4VmIB/npd3JOl2avxbyPb6jRjfFLwRhKkxo/3B63Oqpg2qzJNR+Mm3EjVY7SpzU1SBQ+lOVmn56KUs8sZ6tERAhMQuYgGDWPN8Lp/czaI+pW9UUhJX46G1V5C6F3PmVpMvdVFgV2fP7VDnJsIlMfi6406gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104032; c=relaxed/simple;
	bh=I6QMT4s8iNk+bKl2BvI1TIGvfqxu1PIr94DEW3JbxTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keSCVJHqlEGmV3FerdvQbuCNmWgkIzcIULL19cfS9+Rzf1TolzXJXwg6Eu5T6NKakrHGfDWZqAFgUmvq3ajLrR/WlCKpN3Zvo76yCYgDgOw6Se8lOuJyT5SVBgAGwXhemOe2AH7gWX9bRlrqeIL5SiA6BEO/2mEFynsfoz//Fvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUTY2WHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F99EC4CEF7;
	Tue, 10 Mar 2026 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104032;
	bh=I6QMT4s8iNk+bKl2BvI1TIGvfqxu1PIr94DEW3JbxTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUTY2WHExQx8q5epffF7phDR43kr5j+mXzlZ96Hf2nbjSpxYklM/wnmagdXYz1LSW
	 rvIEEp+1rW0gHvBfWQgCqNsFiTlfl3zR1CmwYmyopyiNAq12CIBwAI49bshpNY3bbH
	 NfqTvAU5Cii1I6DI5YkRUiILL1t4TwSwgdI7KZLCR0mCvVl9FpqmclkDnU38UK9kg6
	 HCOkBI3MD7xU59bdXjIW+Ur7z2ZJ9eGS3Hc3XJwjOikRu7gpm1rchJHAqawNohXg7j
	 1WgtrHi23DLtU0Dtfu7a96GYaPEI/l2R3LnY1ya2BQk3Dd9qCmggKbLCUB8pRG2o1z
	 TUweOyHQTSFUQ==
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
Subject: [PATCH net-next 2/5] tools: ynl: move policy decoding out of NlMsg
Date: Mon,  9 Mar 2026 17:53:34 -0700
Message-ID: <20260310005337.3594225-3-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 496142432A9
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
	TAGGED_FROM(0.00)[bounces-265823-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

We'll soon need to decode policies from dump so move _decode_policy()
out of class NlMsg.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 53 ++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 8302c19ab55c..17482c17a976 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -247,7 +247,7 @@ from .nlspec import SpecFamily
                 elif extack.type == Netlink.NLMSGERR_ATTR_OFFS:
                     self.extack['bad-attr-offs'] = extack.as_scalar('u32')
                 elif extack.type == Netlink.NLMSGERR_ATTR_POLICY:
-                    self.extack['policy'] = self._decode_policy(extack.raw)
+                    self.extack['policy'] = _genl_decode_policy(extack.raw)
                 else:
                     if 'unknown' not in self.extack:
                         self.extack['unknown'] = []
@@ -256,30 +256,6 @@ from .nlspec import SpecFamily
             if attr_space:
                 self.annotate_extack(attr_space)
 
-    def _decode_policy(self, raw):
-        policy = {}
-        for attr in NlAttrs(raw):
-            if attr.type == Netlink.NL_POLICY_TYPE_ATTR_TYPE:
-                type_ = attr.as_scalar('u32')
-                policy['type'] = Netlink.AttrType(type_).name
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_S:
-                policy['min-value'] = attr.as_scalar('s64')
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_S:
-                policy['max-value'] = attr.as_scalar('s64')
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_U:
-                policy['min-value'] = attr.as_scalar('u64')
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_U:
-                policy['max-value'] = attr.as_scalar('u64')
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_LENGTH:
-                policy['min-length'] = attr.as_scalar('u32')
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_LENGTH:
-                policy['max-length'] = attr.as_scalar('u32')
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_BITFIELD32_MASK:
-                policy['bitfield32-mask'] = attr.as_scalar('u32')
-            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MASK:
-                policy['mask'] = attr.as_scalar('u64')
-        return policy
-
     def annotate_extack(self, attr_space):
         """ Make extack more human friendly with attribute information """
 
@@ -333,6 +309,33 @@ from .nlspec import SpecFamily
     return struct.pack("I", len(msg) + 4) + msg
 
 
+def _genl_decode_policy(raw):
+    policy = {}
+    for attr in NlAttrs(raw):
+        if attr.type == Netlink.NL_POLICY_TYPE_ATTR_TYPE:
+            type_ = attr.as_scalar('u32')
+            policy['type'] = Netlink.AttrType(type_).name
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_S:
+            policy['min-value'] = attr.as_scalar('s64')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_S:
+            policy['max-value'] = attr.as_scalar('s64')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_U:
+            policy['min-value'] = attr.as_scalar('u64')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_U:
+            policy['max-value'] = attr.as_scalar('u64')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_LENGTH:
+            policy['min-length'] = attr.as_scalar('u32')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_LENGTH:
+            policy['max-length'] = attr.as_scalar('u32')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_POLICY_IDX:
+            policy['policy-idx'] = attr.as_scalar('u32')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_BITFIELD32_MASK:
+            policy['bitfield32-mask'] = attr.as_scalar('u32')
+        elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MASK:
+            policy['mask'] = attr.as_scalar('u64')
+    return policy
+
+
 # pylint: disable=too-many-nested-blocks
 def _genl_load_families():
     genl_family_name_to_id = {}
-- 
2.53.0


