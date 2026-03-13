Return-Path: <netdev+bounces-267639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBESCd+btGmHrAAAu9opvQ
	(envelope-from <netdev+bounces-267639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:21:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049028AA64
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEA0D3076720
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129573E4C9B;
	Fri, 13 Mar 2026 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pukSWFd8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D8E3E4C60;
	Fri, 13 Mar 2026 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773444049; cv=none; b=RjDXvUzI12LGlULh2gpZf+KEGrP6VcWnWXJaB8ocUesKvPz0xu0fN3UXfrPtym2larnOLf90NCPZ144RxzaqAlquj5wTLAhP4rYtwj7xQVIK1KS75hR0FWhERvuRGCZGp6QU7jnrtnp4rum9Pc3aeBcJvgi7zIh89qKNK0Lhm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773444049; c=relaxed/simple;
	bh=cGqiI5xuJik7Tou8GjfeWbop/vKbAKRDllFYzK95mUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmOFzwjFF/HbY4hmSLSaYRGu8SND0WptDHLeu8E3VGp1qAzGUnZK93+XkEUXbsmC6bK7U2qNLklBV9qPw2+qpt86EqqTaj8p2TerB7pm9t+qtjE6LJqUwr5lVrsxljwt11p6qRinbyy91kHJAV4UHp5qLF2xvQi4PeNgAaeC4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pukSWFd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BECC19421;
	Fri, 13 Mar 2026 23:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773444048;
	bh=cGqiI5xuJik7Tou8GjfeWbop/vKbAKRDllFYzK95mUs=;
	h=From:To:Cc:Subject:Date:From;
	b=pukSWFd8filQiwpH+ixlWoiKrSqx1tzIU8i9t69ixJmKA53dfzsn0GvCrgK4la19c
	 udCMmxCfW+5yfurF/ZXt/u7FPUWjr47AsyH5pQqWsAi02AvNQWmY/eeEPbWVe763ii
	 krCJHbrPyPPOdL+lg0Kq+E/YJXLw5YRr20GCM48K8NZZRLaazaGVjMmoqfc1Covyxh
	 WXVFrq3P2mzr/PDMVEx45XVgd+VaWBZq5HnfOJCm2Pw6OB9sTrbxnQoeAQfPyEwGJX
	 8Tiq5YK7ii6T5lWgqe8DyzVOECditKVakElYM74GljWYeQ/9A6wgGpshp85turhtg0
	 5iHIvJZu6KCOA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] tools: ynl: rework policy access to support recursion
Date: Fri, 13 Mar 2026 16:20:47 -0700
Message-ID: <20260313232047.2068518-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267639-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,args.do:url,fomichev.me:email]
X-Rspamd-Queue-Id: 5049028AA64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Donald points out that the current naive implementation using dicts
breaks if policy is recursive (child nest uses policy idx already
used by its parent).

Lean more into the NlPolicy class. This lets us "render" the policy
on demand, when user accesses it. If someone wants to do an infinite
walk that's on them :) Show policy info as attributes of the class
and use dict format to descend into sub-policies for extra neatness.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: shuah@kernel.org
CC: sdf@fomichev.me
CC: linux-kselftest@vger.kernel.org
---
 tools/net/ynl/pyynl/cli.py               |   4 +-
 tools/net/ynl/pyynl/lib/ynl.py           | 152 ++++++++++++++++-------
 tools/testing/selftests/net/nl_nlctrl.py |  26 ++--
 3 files changed, 120 insertions(+), 62 deletions(-)

diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
index fc9e84754e4b..8275a806cf73 100755
--- a/tools/net/ynl/pyynl/cli.py
+++ b/tools/net/ynl/pyynl/cli.py
@@ -313,11 +313,11 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
     if args.policy:
         if args.do:
             pol = ynl.get_policy(args.do, 'do')
-            output(pol.attrs if pol else None)
+            output(pol.to_dict() if pol else None)
             args.do = None
         if args.dump:
             pol = ynl.get_policy(args.dump, 'dump')
-            output(pol.attrs if pol else None)
+            output(pol.to_dict() if pol else None)
             args.dump = None
 
     if args.ntf:
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 0eedeee465d8..9c078599cea0 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -143,32 +143,117 @@ from .nlspec import SpecFamily
     pass
 
 
-# pylint: disable=too-few-public-methods
 class NlPolicy:
     """Kernel policy for one mode (do or dump) of one operation.
 
-    Returned by YnlFamily.get_policy(). Contains a dict of attributes
-    the kernel accepts, with their validation constraints.
+    Returned by YnlFamily.get_policy(). Attributes of the policy
+    are accessible as attributes of the object. Nested policies
+    can be accessed indexing the object like a dictionary::
 
-    Attributes:
-        attrs: dict mapping attribute names to policy dicts, e.g.
-        page-pool-stats-get do policy::
+        pol = ynl.get_policy('page-pool-stats-get', 'do')
+        pol['info'].type            # 'nested'
+        pol['info']['id'].type      # 'uint'
+        pol['info']['id'].min_value # 1
 
-            {
-                'info': {'type': 'nested', 'policy': {
-                    'id':      {'type': 'uint', 'min-value': 1,
-                                'max-value': 4294967295},
-                    'ifindex': {'type': 'u32', 'min-value': 1,
-                                'max-value': 2147483647},
-                }},
-            }
+    Each policy entry always has a 'type' attribute (e.g. u32, string,
+    nested). Optional attributes depending on the 'type': min-value,
+    max-value, min-length, max-length, mask.
 
-        Each policy dict always contains 'type' (e.g. u32, string,
-        nested). Optional keys: min-value, max-value, min-length,
-        max-length, mask, policy.
+    Policies can form infinite nesting loops. These loops are trimmed
+    when policy is converted to a dict with pol.to_dict().
     """
-    def __init__(self, attrs):
-        self.attrs = attrs
+    def __init__(self, ynl, policy_idx, policy_table, attr_set, props=None):
+        self._policy_idx = policy_idx
+        self._policy_table = policy_table
+        self._ynl = ynl
+        self._props = props or {}
+        self._entries = {}
+        self._cache = {}
+        if policy_idx is not None and policy_idx in policy_table:
+            for attr_id, decoded in policy_table[policy_idx].items():
+                if attr_set and attr_id in attr_set.attrs_by_val:
+                    spec = attr_set.attrs_by_val[attr_id]
+                    name = spec['name']
+                else:
+                    spec = None
+                    name = f'attr-{attr_id}'
+                self._entries[name] = (spec, decoded)
+
+    def __getitem__(self, name):
+        """Descend into a nested policy by attribute name."""
+        if name not in self._cache:
+            spec, decoded = self._entries[name]
+            props = dict(decoded)
+            child_idx = None
+            child_set = None
+            if 'policy-idx' in props:
+                child_idx = props.pop('policy-idx')
+                if spec and 'nested-attributes' in spec.yaml:
+                    child_set = self._ynl.attr_sets[spec.yaml['nested-attributes']]
+            self._cache[name] = NlPolicy(self._ynl, child_idx,
+                                         self._policy_table,
+                                         child_set, props)
+        return self._cache[name]
+
+    def __getattr__(self, name):
+        """Access this policy entry's own properties (type, min-value, etc.).
+
+        Underscores in the name are converted to dashes, so that
+        pol.min_value looks up "min-value".
+        """
+        key = name.replace('_', '-')
+        try:
+            # Hack for level-0 which we still want to have .type but we don't
+            # want type to pointlessly show up in the dict / JSON form.
+            if not self._props and name == "type":
+                return "nested"
+            return self._props[key]
+        except KeyError:
+            raise AttributeError(name)
+
+    def get(self, name, default=None):
+        """Look up a child policy entry by attribute name, with a default."""
+        try:
+            return self[name]
+        except KeyError:
+            return default
+
+    def __contains__(self, name):
+        return name in self._entries
+
+    def __len__(self):
+        return len(self._entries)
+
+    def __iter__(self):
+        return iter(self._entries)
+
+    def keys(self):
+        """Return attribute names accepted by this policy."""
+        return self._entries.keys()
+
+    def to_dict(self, seen=None):
+        """Convert to a plain dict, suitable for JSON serialization.
+
+        Nested NlPolicy objects are expanded recursively. Cyclic
+        references are trimmed (resolved to just {"type": "nested"}).
+        """
+        if seen is None:
+            seen = set()
+        result = dict(self._props)
+        if self._policy_idx is not None:
+            if self._policy_idx not in seen:
+                seen = seen | {self._policy_idx}
+                children = {}
+                for name in self:
+                    children[name] = self[name].to_dict(seen)
+                if self._props:
+                    result['policy'] = children
+                else:
+                    result = children
+        return result
+
+    def __repr__(self):
+        return repr(self.to_dict())
 
 
 class NlAttr:
@@ -1308,28 +1393,6 @@ from .nlspec import SpecFamily
     def do_multi(self, ops):
         return self._ops(ops)
 
-    def _resolve_policy(self, policy_idx, policy_table, attr_set):
-        attrs = {}
-        if policy_idx not in policy_table:
-            return attrs
-        for attr_id, decoded in policy_table[policy_idx].items():
-            if attr_set and attr_id in attr_set.attrs_by_val:
-                spec = attr_set.attrs_by_val[attr_id]
-                name = spec['name']
-            else:
-                spec = None
-                name = f'attr-{attr_id}'
-            if 'policy-idx' in decoded:
-                sub_set = None
-                if spec and 'nested-attributes' in spec.yaml:
-                    sub_set = self.attr_sets[spec.yaml['nested-attributes']]
-                nested = self._resolve_policy(decoded['policy-idx'],
-                                              policy_table, sub_set)
-                del decoded['policy-idx']
-                decoded['policy'] = nested
-            attrs[name] = decoded
-        return attrs
-
     def get_policy(self, op_name, mode):
         """Query running kernel for the Netlink policy of an operation.
 
@@ -1341,8 +1404,8 @@ from .nlspec import SpecFamily
             mode: 'do' or 'dump'
 
         Returns:
-            NlPolicy with an attrs dict mapping attribute names to
-            their policy properties (type, min/max, nested, etc.),
+            NlPolicy acting as a read-only dict mapping attribute names
+            to their policy properties (type, min/max, nested, etc.),
             or None if the operation has no policy for the given mode.
             Empty policy usually implies that the operation rejects
             all attributes.
@@ -1353,5 +1416,4 @@ from .nlspec import SpecFamily
         if mode not in op_policy:
             return None
         policy_idx = op_policy[mode]
-        attrs = self._resolve_policy(policy_idx, policy_table, op.attr_set)
-        return NlPolicy(attrs)
+        return NlPolicy(self, policy_idx, policy_table, op.attr_set)
diff --git a/tools/testing/selftests/net/nl_nlctrl.py b/tools/testing/selftests/net/nl_nlctrl.py
index d19e206c2c02..fe1f66dc9435 100755
--- a/tools/testing/selftests/net/nl_nlctrl.py
+++ b/tools/testing/selftests/net/nl_nlctrl.py
@@ -68,39 +68,35 @@ from lib.py import NetdevFamily, EthtoolFamily, NlctrlFamily
     # dev-get: do has a real policy with ifindex, dump has no policy
     # (only the reject-all policy with maxattr=0)
     pol = ndev.get_policy('dev-get', 'do')
-    ksft_in('ifindex', pol.attrs,
-            comment="dev-get do policy should have ifindex")
-    ksft_eq(pol.attrs.get('ifindex', {}).get('type'), 'u32')
+    ksft_in('ifindex', pol, comment="dev-get do policy should have ifindex")
+    ksft_eq(pol['ifindex'].type, 'u32')
 
     pol_dump = ndev.get_policy('dev-get', 'dump')
-    ksft_eq(len(pol_dump.attrs), 0,
-            comment="dev-get should not accept any attrs")
+    ksft_eq(len(pol_dump), 0, comment="dev-get should not accept any attrs")
 
     # napi-get: both do and dump have real policies
     pol_do = ndev.get_policy('napi-get', 'do')
-    ksft_ge(len(pol_do.attrs), 1)
+    ksft_ge(len(pol_do), 1)
 
     pol_dump = ndev.get_policy('napi-get', 'dump')
-    ksft_ge(len(pol_dump.attrs), 1)
+    ksft_ge(len(pol_dump), 1)
 
     # -- ethtool (full ops) --
     et = EthtoolFamily()
 
     # strset-get (has both do and dump, full ops share policy)
     pol_do = et.get_policy('strset-get', 'do')
-    ksft_ge(len(pol_do.attrs), 1, comment="strset-get should have a do policy")
+    ksft_ge(len(pol_do), 1, comment="strset-get should have a do policy")
 
     pol_dump = et.get_policy('strset-get', 'dump')
-    ksft_ge(len(pol_dump.attrs), 1,
-            comment="strset-get should have a dump policy")
+    ksft_ge(len(pol_dump), 1, comment="strset-get should have a dump policy")
 
     # Same policy means same attribute names
-    ksft_eq(set(pol_do.attrs.keys()), set(pol_dump.attrs.keys()))
+    ksft_eq(set(pol_do.keys()), set(pol_dump.keys()))
 
     # linkinfo-set is do-only (SET command), no dump
     pol_do = et.get_policy('linkinfo-set', 'do')
-    ksft_ge(len(pol_do.attrs), 1,
-            comment="linkinfo-set should have a do policy")
+    ksft_ge(len(pol_do), 1, comment="linkinfo-set should have a do policy")
 
     pol_dump = et.get_policy('linkinfo-set', 'dump')
     ksft_eq(pol_dump, None,
@@ -113,9 +109,9 @@ from lib.py import NetdevFamily, EthtoolFamily, NlctrlFamily
 
     # dev-get do policy should have named attributes from the spec
     pol = ndev.get_policy('dev-get', 'do')
-    ksft_ge(len(pol.attrs), 1)
+    ksft_ge(len(pol), 1)
     # All attr names should be resolved (no 'attr-N' fallbacks)
-    for name in pol.attrs:
+    for name in pol:
         ksft_true(not name.startswith('attr-'),
                   comment=f"unresolved attr name: {name}")
 
-- 
2.53.0


