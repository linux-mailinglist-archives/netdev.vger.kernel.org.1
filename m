Return-Path: <netdev+bounces-265826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DNuO/xrr2m8YQIAu9opvQ
	(envelope-from <netdev+bounces-265826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:55:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 572F32432FB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C34A3126722
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF827E074;
	Tue, 10 Mar 2026 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPAiC+31"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F9B2BD11;
	Tue, 10 Mar 2026 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104036; cv=none; b=o8iDIRxpnq1u96gWOT8La2C4V1w7yfW36fCH345bdfSFoTCEXDGt8DCHhiuJN+f8UdOdLC04Z8GwMQnNVzwvSrRPr36wKn9ZRpxLa6YapWqeHrKeQB9DncNQ0Fc9GzBrEIT+1tty5Y5VD+a4derq9EYv1HrE65AZOh83DdiM1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104036; c=relaxed/simple;
	bh=dwgpkViLqZX8234s9U1WGIGUELmodBFEab34fFwqUOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jx6cLNV0k+aQOMEKdK9Efn/HyIDRirSyInasdmWi6DPllESIYfsELgtAnslYg4UqpwPyCDOo7jXzRc0ZVk5KI7nsVQ+bfhdbs+AijIiWR+JbWz1G/A27V01U2l3Sh+fIEp0Khoh927YTMuqaXjviKAKGqgleoeVrV7POrMUdZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPAiC+31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA35C2BCB0;
	Tue, 10 Mar 2026 00:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104034;
	bh=dwgpkViLqZX8234s9U1WGIGUELmodBFEab34fFwqUOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPAiC+31b9lFtStFJGQpDqInXdczVoj78vepZ0Kd25plPaKFxl0622mjpSMF5t6At
	 Dhl/hMwoZ34PUs8FXgXiVf6QbTwYKRkfW6JtwIsVnz+1aWZuJlJirjzsPrg2leVVZa
	 JehW3tJZ7esDN4RtVKiadVitoUVaWWx0K3OvNj3+9l48C/UKOkuRTXJhF24CYnj/rX
	 oflMAfMlcfCnWivqUzepYYru7K0wM3SHJZldwudfKTaIL+c8McyYAdQHlqZc8ltmy4
	 fIfTNpjR8DUZsknm8sRwgb6mWmb518cEn4VegYua6aPW/nq1FLSxrh5kTtfxydV0a6
	 yX4CWwTbV7tsw==
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
Subject: [PATCH net-next 4/5] tools: ynl: add Python API for easier access to policies
Date: Mon,  9 Mar 2026 17:53:36 -0700
Message-ID: <20260310005337.3594225-5-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 572F32432FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265826-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,self.nl:url]
X-Rspamd-Action: no action

The format of Netlink policy dump is a bit curious with messages
in the same dump carrying both attrs and mapping info. Plus each
message carries a single piece of the puzzle the caller must then
reassemble.

I need to do this reassembly for a test, but I think it's generally
useful. So let's add proper support to YnlFamily to return more
user-friendly representation. See the various docs in the patch
for more details.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/__init__.py       |   5 +-
 tools/net/ynl/pyynl/lib/ynl.py            | 133 ++++++++++++++++++++++
 tools/testing/selftests/net/lib/py/ynl.py |   6 +-
 3 files changed, 139 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/__init__.py b/tools/net/ynl/pyynl/lib/__init__.py
index 33a96155fb3b..be741985ae4e 100644
--- a/tools/net/ynl/pyynl/lib/__init__.py
+++ b/tools/net/ynl/pyynl/lib/__init__.py
@@ -5,11 +5,12 @@
 from .nlspec import SpecAttr, SpecAttrSet, SpecEnumEntry, SpecEnumSet, \
     SpecFamily, SpecOperation, SpecSubMessage, SpecSubMessageFormat, \
     SpecException
-from .ynl import YnlFamily, Netlink, NlError, YnlException
+from .ynl import YnlFamily, Netlink, NlError, NlPolicy, YnlException
 
 from .doc_generator import YnlDocGenerator
 
 __all__ = ["SpecAttr", "SpecAttrSet", "SpecEnumEntry", "SpecEnumSet",
            "SpecFamily", "SpecOperation", "SpecSubMessage", "SpecSubMessageFormat",
            "SpecException",
-           "YnlFamily", "Netlink", "NlError", "YnlDocGenerator", "YnlException"]
+           "YnlFamily", "Netlink", "NlError", "NlPolicy", "YnlException",
+           "YnlDocGenerator"]
diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index ec4d95f583fe..e6fcedb597a8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -77,15 +77,22 @@ from .nlspec import SpecFamily
 
     # nlctrl
     CTRL_CMD_GETFAMILY = 3
+    CTRL_CMD_GETPOLICY = 10
 
     CTRL_ATTR_FAMILY_ID = 1
     CTRL_ATTR_FAMILY_NAME = 2
     CTRL_ATTR_MAXATTR = 5
     CTRL_ATTR_MCAST_GROUPS = 7
+    CTRL_ATTR_POLICY = 8
+    CTRL_ATTR_OP_POLICY = 9
+    CTRL_ATTR_OP = 10
 
     CTRL_ATTR_MCAST_GRP_NAME = 1
     CTRL_ATTR_MCAST_GRP_ID = 2
 
+    CTRL_ATTR_POLICY_DO = 1
+    CTRL_ATTR_POLICY_DUMP = 2
+
     # Extack types
     NLMSGERR_ATTR_MSG = 1
     NLMSGERR_ATTR_OFFS = 2
@@ -136,6 +143,34 @@ from .nlspec import SpecFamily
     pass
 
 
+# pylint: disable=too-few-public-methods
+class NlPolicy:
+    """Kernel policy for one mode (do or dump) of one operation.
+
+    Returned by YnlFamily.get_policy(). Contains a dict of attributes
+    the kernel accepts, with their validation constraints.
+
+    Attributes:
+        attrs: dict mapping attribute names to policy dicts, e.g.
+        page-pool-stats-get do policy::
+
+            {
+                'info': {'type': 'nested', 'policy': {
+                    'id':      {'type': 'uint', 'min-value': 1,
+                                'max-value': 4294967295},
+                    'ifindex': {'type': 'u32', 'min-value': 1,
+                                'max-value': 2147483647},
+                }},
+            }
+
+        Each policy dict always contains 'type' (e.g. u32, string,
+        nested). Optional keys: min-value, max-value, min-length,
+        max-length, mask, policy.
+    """
+    def __init__(self, attrs):
+        self.attrs = attrs
+
+
 class NlAttr:
     ScalarFormat = namedtuple('ScalarFormat', ['native', 'big', 'little'])
     type_formats = {
@@ -384,6 +419,52 @@ from .nlspec import SpecFamily
                     genl_family_name_to_id[fam['name']] = fam
 
 
+# pylint: disable=too-many-nested-blocks
+def _genl_policy_dump(family_id, op):
+    op_policy = {}
+    policy_table = {}
+
+    with socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, Netlink.NETLINK_GENERIC) as sock:
+        sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_CAP_ACK, 1)
+
+        msg = _genl_msg(Netlink.GENL_ID_CTRL,
+                        Netlink.NLM_F_REQUEST | Netlink.NLM_F_ACK | Netlink.NLM_F_DUMP,
+                        Netlink.CTRL_CMD_GETPOLICY, 1)
+        msg += struct.pack('HHHxx', 6, Netlink.CTRL_ATTR_FAMILY_ID, family_id)
+        msg += struct.pack('HHI', 8, Netlink.CTRL_ATTR_OP, op)
+        msg = _genl_msg_finalize(msg)
+
+        sock.send(msg, 0)
+
+        while True:
+            reply = sock.recv(128 * 1024)
+            nms = NlMsgs(reply)
+            for nl_msg in nms:
+                if nl_msg.error:
+                    raise YnlException(f"Netlink error: {nl_msg.error}")
+                if nl_msg.done:
+                    return op_policy, policy_table
+
+                gm = GenlMsg(nl_msg)
+                for attr in NlAttrs(gm.raw):
+                    if attr.type == Netlink.CTRL_ATTR_OP_POLICY:
+                        for op_attr in NlAttrs(attr.raw):
+                            for method_attr in NlAttrs(op_attr.raw):
+                                if method_attr.type == Netlink.CTRL_ATTR_POLICY_DO:
+                                    op_policy['do'] = method_attr.as_scalar('u32')
+                                elif method_attr.type == Netlink.CTRL_ATTR_POLICY_DUMP:
+                                    op_policy['dump'] = method_attr.as_scalar('u32')
+                    elif attr.type == Netlink.CTRL_ATTR_POLICY:
+                        for pidx_attr in NlAttrs(attr.raw):
+                            policy_idx = pidx_attr.type
+                            for aid_attr in NlAttrs(pidx_attr.raw):
+                                attr_id = aid_attr.type
+                                decoded = _genl_decode_policy(aid_attr.raw)
+                                if policy_idx not in policy_table:
+                                    policy_table[policy_idx] = {}
+                                policy_table[policy_idx][attr_id] = decoded
+
+
 class GenlMsg:
     def __init__(self, nl_msg):
         self.nl = nl_msg
@@ -516,6 +597,11 @@ from .nlspec import SpecFamily
       ynl.ntf_subscribe(mcast_name)      -- join a multicast group
       ynl.check_ntf()                    -- drain pending notifications
       ynl.poll_ntf(duration=None)        -- yield notifications
+
+    Policy introspection allows querying validation criteria from the running
+    kernel. Allows checking whether kernel supports a given attribute or value.
+
+      ynl.get_policy(op_name, mode)      -- query kernel policy for an op
     """
     def __init__(self, def_path, schema=None, process_unknown=False,
                  recv_size=0):
@@ -1221,3 +1307,50 @@ from .nlspec import SpecFamily
 
     def do_multi(self, ops):
         return self._ops(ops)
+
+    def _resolve_policy(self, policy_idx, policy_table, attr_set):
+        attrs = {}
+        if policy_idx not in policy_table:
+            return attrs
+        for attr_id, decoded in policy_table[policy_idx].items():
+            if attr_set and attr_id in attr_set.attrs_by_val:
+                spec = attr_set.attrs_by_val[attr_id]
+                name = spec['name']
+            else:
+                spec = None
+                name = f'attr-{attr_id}'
+            if 'policy-idx' in decoded:
+                sub_set = None
+                if spec and 'nested-attributes' in spec.yaml:
+                    sub_set = self.attr_sets[spec.yaml['nested-attributes']]
+                nested = self._resolve_policy(decoded['policy-idx'],
+                                              policy_table, sub_set)
+                del decoded['policy-idx']
+                decoded['policy'] = nested
+            attrs[name] = decoded
+        return attrs
+
+    def get_policy(self, op_name, mode):
+        """Query running kernel for the Netlink policy of an operation.
+
+        Allows checking whether kernel supports a given attribute or value.
+        This method consults the running kernel, not the YAML spec.
+
+        Args:
+            op_name: operation name as it appears in the YAML spec
+            mode: 'do' or 'dump'
+
+        Returns:
+            NlPolicy with an attrs dict mapping attribute names to
+            their policy properties (type, min/max, nested, etc.),
+            or None if the operation has no policy for the given mode.
+            No policy usually implies that the operation rejects all attributes.
+        """
+        op = self.ops[op_name]
+        op_policy, policy_table = _genl_policy_dump(self.nlproto.family_id,
+                                                    op.req_value)
+        if mode not in op_policy:
+            return None
+        policy_idx = op_policy[mode]
+        attrs = self._resolve_policy(policy_idx, policy_table, op.attr_set)
+        return NlPolicy(attrs)
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index b42986bf39e3..e8aa97936f6c 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -13,14 +13,14 @@ from .ksft import ksft_pr, ktap_result
         SPEC_PATH = KSFT_DIR / "net/lib/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, Netlink
+        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, NlPolicy, Netlink
     else:
         # Running in tree
         tools_full_path = KSRC / "tools"
         SPEC_PATH = KSRC / "Documentation/netlink/specs"
 
         sys.path.append(tools_full_path.as_posix())
-        from net.ynl.pyynl.lib import YnlFamily, NlError, Netlink
+        from net.ynl.pyynl.lib import YnlFamily, NlError, NlPolicy, Netlink
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `ynl` library from kernel sources")
     ksft_pr(str(e))
@@ -28,7 +28,7 @@ from .ksft import ksft_pr, ktap_result
     sys.exit(4)
 
 __all__ = [
-    "NlError", "Netlink", "YnlFamily", "SPEC_PATH",
+    "NlError", "NlPolicy", "Netlink", "YnlFamily", "SPEC_PATH",
     "EthtoolFamily", "RtnlFamily", "RtnlAddrFamily",
     "NetdevFamily", "NetshaperFamily", "DevlinkFamily", "PSPFamily",
 ]
-- 
2.53.0


