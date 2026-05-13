Return-Path: <netdev+bounces-287568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ3yKiFrBGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:14:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A6532E2B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37F7B30A4D70
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333E402442;
	Wed, 13 May 2026 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfHU2qMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D13F7A86
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674388; cv=none; b=rNYVCuyyRGC0JHLTt98pxGgQdTBft8hNZbpvZv5FBbV7RpcAKwsVyyFAomjDC/F7TiJDXkcwVUa2n9+nyuz23B7mKeHwCjZfZcFmeHiKbCi/hdeMUKDxhjclNGG24wHKkfPeCNkQX2Q62gRH1baRdDfgGrpYrC2SgVESdthZ8qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674388; c=relaxed/simple;
	bh=H8Xj3KTe+E9/Icf7A/pFrLf3P4u43HDYe01sD8jBu5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwBmEDi1Z2VHBqGTgKJUa5LMnQZ5FQ8HtwBhQjTIMIKCJwqq1MVcYoaRNT+aycGTjbHfJFd8PnpTjypRWv4JKn43wfjrD5Wei782ZiEGuBh2qGve7wY5fSofH3x41aKMz+q89QFK7klWtfyjMlmjYy7VO4N/A8EQ2RkzIEp92vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfHU2qMV; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-439bdbc86b1so868556fac.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778674385; x=1779279185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWNE3Q2DvPCR8hHHvFryq5OpzNlFSaZimilgjtTyjxY=;
        b=kfHU2qMV0zsMCUXoqvYsddtZo51iwGIuI1aaWi8VeQwJ4XONTw5vMWPoyLK9QkBcO1
         PI4eW3JJ737N4Y+/4Oe4Rs1zg0+LhQvkjFaluYgXxWRDO4LwPEJDsYqKwjLhbCW7qliT
         rr9PCABQNyEbHyQhzaX3VaJTSEc+VlMbnKWnTNdL98YbeCFNv7D8GNnOSDF7ls+OXLnh
         yXtr2pFP+8S8WuY8RmLw62gmyE/aJMdNDtld8fArOyGVNCXhXkqnQbz3Ky7dZ68i1/Oz
         1TuqWi5rGWRn8TuIyhJlFcJeJJOspUfHh6ucnxW1zFK9DsbhgWFIB3WhBRXxwifEbkuO
         hNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674385; x=1779279185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZWNE3Q2DvPCR8hHHvFryq5OpzNlFSaZimilgjtTyjxY=;
        b=a+OEyrqUQ7zgeuTEdSr1bUvIokasAogcgS4+Ha65OYAaUyj99wftyfKKnp0GhOXhA9
         mttxWadEliotYgqW6PNKxLY7Ye8Q/eLerss3ivqChpjiDgyKkZEsa/sbUOPFgqoo7WnZ
         3fhouQarVebtJAFMduxhYAcZqxbxHdmCTEHzNv9YyIgOk10vxbezt2cxwyH2zk8kCJJI
         pOrs5zDuV3UKz8/2Vnwu9cppMzY8a632B0XmiEis7fHZYMbG/jXdSWMO4nnarBCi42yb
         q4SxON/YI3xWaYi78cuX6ouq1jXv120udKp3JhK+pYKcpAQLDVhlTxtGVzmER8eAw9G9
         qpSg==
X-Gm-Message-State: AOJu0YxnKBjn/JVV/6YzGixMFxiOM+IK9by+USaa8mtvWCw0QwLvL80x
	/ui/VctBvrNykqlryZ+6qN13NAQV8GH47+G/MaF5dR1/ZwCcpSfckaax+ffeX95QVXY=
X-Gm-Gg: Acq92OHC3zmZBIunbZ2Hm2GrPYVPtom3k2qgZfuUsiaqA7t8EufCyW9aeUiM9h2A3pM
	u/v+Kstj1+ubrz5o1wClhbFA3+ZZMkgmUgN/4lpeDV3eh2L8yKQOvfdSP73SAaBb5zQoGmBxayG
	/ygc9x5lasZQnUds55oI5FFhgWDECX/wT/qNXfu0M87wy5a0wY5I08TkBNMF6eL2/vEZRvWmFxD
	S06F5ZNGFSDno1qb4Mm1zlXws3kiuJrQGqGPMN3IGIm+aVuVau9bdNoBFDmKE/m6BLjN1KEBlyw
	rXe1VrdmDoYtYqM7Z7cdwg6yHfoJ1nGoqo6t/5AoyWy0SfFMwizWj2s6yioV5FZ16XnuxcT1zzr
	XS9QOwJC0GiOYnfPC75+EqEyTBzZDS7KowGolNUVxViZBroQ/gwIuLylW3kpDOYjRTgZ0DilIQT
	nyzwfPR5DYP5DX/AE=
X-Received: by 2002:a05:6870:344a:b0:42f:d8b8:9faa with SMTP id 586e51a60fabf-4399bab5fedmr4099456fac.28.1778674384855;
        Wed, 13 May 2026 05:13:04 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736dbc0sm15189442fac.11.2026.05.13.05.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:13:04 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 1/5] selftests: openvswitch: convert %-formatting to f-strings
Date: Wed, 13 May 2026 20:12:36 +0800
Message-ID: <20260513121240.2590767-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513121240.2590767-1-houminxi@gmail.com>
References: <20260513121240.2590767-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 682A6532E2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[openvswitch.org,vger.kernel.org,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-287568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Convert all %-formatting instances to f-strings to fix C0209
pylint warnings. No behavior change.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 274 ++++++++----------
 1 file changed, 123 insertions(+), 151 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 3b6a26e265a4..3671fe16b5a7 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -65,7 +65,7 @@ OVS_FLOW_CMD_SET = 4
 UINT32_MAX = 0xFFFFFFFF
 
 def macstr(mac):
-    outstr = ":".join(["%02X" % i for i in mac])
+    outstr = ":".join([f"{i:02X}" for i in mac])
     return outstr
 
 
@@ -146,7 +146,7 @@ def parse_flags(flag_str, flag_vals):
         if flag in flag_vals:
             if maskResult & flag_vals[flag]:
                 raise KeyError(
-                    "Flag %s set once, cannot be set in multiples" % flag
+                    f"Flag {flag} set once, cannot be set in multiples"
                 )
 
             if setFlag:
@@ -154,7 +154,7 @@ def parse_flags(flag_str, flag_vals):
 
             maskResult |= flag_vals[flag]
         else:
-            raise KeyError("Missing flag value: %s" % flag)
+            raise KeyError(f"Missing flag value: {flag}")
 
         flag_str = flag_str[flag_len:]
 
@@ -211,7 +211,7 @@ def convert_ipv6(data):
     elif not mask:
         mask = 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff'
     elif mask.isdigit():
-        mask = ipaddress.IPv6Network("::/" + mask).hostmask
+        mask = ipaddress.IPv6Network(f"::/{mask}").hostmask
 
     return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed
 
@@ -342,13 +342,13 @@ def parse_attrs(actstr, attr_desc):
                 del attr_desc[i]
 
         if not found:
-            raise ValueError("Unknown attribute: '%s'" % actstr)
+            raise ValueError(f"Unknown attribute: '{actstr}'")
 
         actstr = actstr[strspn(actstr, ", ") :]
 
     if actstr[0] != ")":
         raise ValueError("Action string contains extra garbage or has "
-                         "unbalanced parenthesis: '%s'" % actstr)
+                         f"unbalanced parenthesis: '{actstr}'")
 
     return attrs, actstr[1:]
 
@@ -403,14 +403,13 @@ class ovsactions(nla):
         )
 
         def dpstr(self, more=False):
-            args = "group=%d" % self.get_attr("OVS_PSAMPLE_ATTR_GROUP")
+            args = f"group={self.get_attr('OVS_PSAMPLE_ATTR_GROUP')}"
 
             cookie = self.get_attr("OVS_PSAMPLE_ATTR_COOKIE")
             if cookie:
-                args += ",cookie(%s)" % \
-                        "".join(format(x, "02x") for x in cookie)
+                args += f",cookie({''.join(format(x, '02x') for x in cookie)})"
 
-            return "psample(%s)" % args
+            return f"psample({args})"
 
         def parse(self, actstr):
             desc = (
@@ -441,15 +440,15 @@ class ovsactions(nla):
         def dpstr(self, more=False):
             args = []
 
-            args.append("sample={:.2f}%".format(
-                100 * self.get_attr("OVS_SAMPLE_ATTR_PROBABILITY") /
-                UINT32_MAX))
+            prob = 100 * self.get_attr(
+                "OVS_SAMPLE_ATTR_PROBABILITY") / UINT32_MAX
+            args.append(f"sample={prob:.2f}%")
 
             actions = self.get_attr("OVS_SAMPLE_ATTR_ACTIONS")
             if actions:
-                args.append("actions(%s)" % actions.dpstr(more))
+                args.append(f"actions({actions.dpstr(more)})")
 
-            return "sample(%s)" % ",".join(args)
+            return f"sample({','.join(args)})"
 
         def parse(self, actstr):
             def parse_nested_actions(actstr):
@@ -518,26 +517,20 @@ class ovsactions(nla):
                     "OVS_NAT_ATTR_IP_MAX"
                 ):
                     if self.get_attr("OVS_NAT_ATTR_IP_MIN"):
-                        print_str += "=%s," % str(
-                            self.get_attr("OVS_NAT_ATTR_IP_MIN")
-                        )
+                        print_str += f"={self.get_attr('OVS_NAT_ATTR_IP_MIN')!s},"
 
                     if self.get_attr("OVS_NAT_ATTR_IP_MAX"):
-                        print_str += "-%s," % str(
-                            self.get_attr("OVS_NAT_ATTR_IP_MAX")
-                        )
+                        print_str += f"-{self.get_attr('OVS_NAT_ATTR_IP_MAX')!s},"
                 else:
                     print_str += ","
 
                 if self.get_attr("OVS_NAT_ATTR_PROTO_MIN"):
-                    print_str += "proto_min=%d," % self.get_attr(
-                        "OVS_NAT_ATTR_PROTO_MIN"
-                    )
+                    val = self.get_attr("OVS_NAT_ATTR_PROTO_MIN")
+                    print_str += f"proto_min={val},"
 
                 if self.get_attr("OVS_NAT_ATTR_PROTO_MAX"):
-                    print_str += "proto_max=%d," % self.get_attr(
-                        "OVS_NAT_ATTR_PROTO_MAX"
-                    )
+                    val = self.get_attr("OVS_NAT_ATTR_PROTO_MAX")
+                    print_str += f"proto_max={val},"
 
                 if self.get_attr("OVS_NAT_ATTR_PERSISTENT"):
                     print_str += "persistent,"
@@ -554,22 +547,18 @@ class ovsactions(nla):
             if self.get_attr("OVS_CT_ATTR_COMMIT") is not None:
                 print_str += "commit,"
             if self.get_attr("OVS_CT_ATTR_ZONE") is not None:
-                print_str += "zone=%d," % self.get_attr("OVS_CT_ATTR_ZONE")
+                print_str += f"zone={self.get_attr('OVS_CT_ATTR_ZONE')},"
             if self.get_attr("OVS_CT_ATTR_HELPER") is not None:
-                print_str += "helper=%s," % self.get_attr("OVS_CT_ATTR_HELPER")
+                print_str += f"helper={self.get_attr('OVS_CT_ATTR_HELPER')},"
             if self.get_attr("OVS_CT_ATTR_NAT") is not None:
                 print_str += self.get_attr("OVS_CT_ATTR_NAT").dpstr(more)
                 print_str += ","
             if self.get_attr("OVS_CT_ATTR_FORCE_COMMIT") is not None:
                 print_str += "force,"
             if self.get_attr("OVS_CT_ATTR_EVENTMASK") is not None:
-                print_str += "emask=0x%X," % self.get_attr(
-                    "OVS_CT_ATTR_EVENTMASK"
-                )
+                print_str += f"emask=0x{self.get_attr('OVS_CT_ATTR_EVENTMASK'):X},"
             if self.get_attr("OVS_CT_ATTR_TIMEOUT") is not None:
-                print_str += "timeout=%s" % self.get_attr(
-                    "OVS_CT_ATTR_TIMEOUT"
-                )
+                print_str += f"timeout={self.get_attr('OVS_CT_ATTR_TIMEOUT')}"
             print_str += ")"
             return print_str
 
@@ -586,17 +575,15 @@ class ovsactions(nla):
         def dpstr(self, more=False):
             print_str = "userspace("
             if self.get_attr("OVS_USERSPACE_ATTR_PID") is not None:
-                print_str += "pid=%d," % self.get_attr(
-                    "OVS_USERSPACE_ATTR_PID"
-                )
+                print_str += f"pid={self.get_attr('OVS_USERSPACE_ATTR_PID')},"
             if self.get_attr("OVS_USERSPACE_ATTR_USERDATA") is not None:
                 print_str += "userdata="
                 for f in self.get_attr("OVS_USERSPACE_ATTR_USERDATA"):
-                    print_str += "%x." % f
+                    print_str += f"{f:x}."
             if self.get_attr("OVS_USERSPACE_ATTR_EGRESS_TUN_PORT") is not None:
-                print_str += "egress_tun_port=%d" % self.get_attr(
-                    "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT"
-                )
+                val = self.get_attr(
+                    "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT")
+                print_str += f"egress_tun_port={val}"
             print_str += ")"
             return print_str
 
@@ -624,13 +611,13 @@ class ovsactions(nla):
                 print_str += ","
 
             if field[0] == "OVS_ACTION_ATTR_OUTPUT":
-                print_str += "%d" % int(self.get_attr(field[0]))
+                print_str += f"{self.get_attr(field[0])}"
             elif field[0] == "OVS_ACTION_ATTR_RECIRC":
-                print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
+                print_str += f"recirc(0x{self.get_attr(field[0]):x})"
             elif field[0] == "OVS_ACTION_ATTR_TRUNC":
-                print_str += "trunc(%d)" % int(self.get_attr(field[0]))
+                print_str += f"trunc({self.get_attr(field[0])})"
             elif field[0] == "OVS_ACTION_ATTR_DROP":
-                print_str += "drop(%d)" % int(self.get_attr(field[0]))
+                print_str += f"drop({self.get_attr(field[0])})"
             elif field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
                 print_str += "ct_clear"
             elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
@@ -641,8 +628,8 @@ class ovsactions(nla):
                 tci = datum["vlan_tci"]
                 vid = tci & 0x0FFF
                 pcp = (tci >> 13) & 0x7
-                print_str += "push_vlan(vid=%d,pcp=%d" \
-                    ",tpid=0x%04x)" % (vid, pcp, tpid)
+                print_str += (f"push_vlan(vid={vid},pcp={pcp}"
+                              f",tpid=0x{tpid:04x})")
             elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
                 print_str += "pop_eth"
             elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
@@ -750,32 +737,27 @@ class ovsactions(nla):
                 for kv in actstr[:paren].split(","):
                     if "=" not in kv:
                         raise ValueError(
-                            "push_vlan(): bad field '%s'"
-                            % kv.strip())
+                            f"push_vlan(): bad field '{kv.strip()}'")
                     k = kv[:kv.index("=")].strip()
                     v = kv[kv.index("=") + 1:].strip()
                     if k == "vid":
                         vid = int(v, 0)
                         if vid < 0 or vid > 0xFFF:
                             raise ValueError(
-                                "push_vlan(): vid=%d out of "
-                                "range (0-4095)" % vid)
+                                f"push_vlan(): vid={vid} out of range (0-4095)")
                     elif k == "pcp":
                         pcp = int(v, 0)
                         if pcp < 0 or pcp > 7:
                             raise ValueError(
-                                "push_vlan(): pcp=%d out of "
-                                "range (0-7)" % pcp)
+                                f"push_vlan(): pcp={pcp} out of range (0-7)")
                     elif k == "tpid":
                         tpid = int(v, 0)
                         if tpid < 0 or tpid > 0xFFFF:
                             raise ValueError(
-                                "push_vlan(): tpid=0x%x out "
-                                "of range (0-0xffff)" % tpid)
+                                f"push_vlan(): tpid=0x{tpid:x} out of range (0-0xffff)")
                     else:
                         raise ValueError(
-                            "push_vlan(): unknown key '%s'"
-                            % k)
+                            f"push_vlan(): unknown key '{k}'")
                 tci = (vid & 0x0FFF) | ((pcp & 0x7) << 13) \
                     | 0x1000
                 pvact = self.push_vlan()
@@ -802,7 +784,7 @@ class ovsactions(nla):
                 actstr = k.parse(actstr, None)
                 self["attrs"].append(("OVS_ACTION_ATTR_SET", k))
                 if not actstr.startswith(")"):
-                    actstr = ")" + actstr
+                    actstr = f"){actstr}"
                 parsed = True
             elif parse_starts_block(actstr, "set_masked(", False):
                 parencount += 1
@@ -812,7 +794,7 @@ class ovsactions(nla):
                 actstr = k.parse(actstr, m)
                 self["attrs"].append(("OVS_ACTION_ATTR_SET_MASKED", [k, m]))
                 if not actstr.startswith(")"):
-                    actstr = ")" + actstr
+                    actstr = f"){actstr}"
                 parsed = True
             elif parse_starts_block(actstr, "ct(", False):
                 parencount += 1
@@ -943,7 +925,7 @@ class ovsactions(nla):
                 parencount -= 1
                 actstr = actstr[strspn(actstr, " "):]
                 if len(actstr) and actstr[0] != ")":
-                    raise ValueError("Action str: '%s' unbalanced" % actstr)
+                    raise ValueError(f"Action str: '{actstr}' unbalanced")
                 actstr = actstr[1:]
 
             if len(actstr) and actstr[0] == ")":
@@ -952,7 +934,7 @@ class ovsactions(nla):
             actstr = actstr[strspn(actstr, ", ") :]
 
             if not parsed:
-                raise ValueError("Action str: '%s' not supported" % actstr)
+                raise ValueError(f"Action str: '{actstr}' not supported")
 
         return (totallen - len(actstr))
 
@@ -1071,20 +1053,20 @@ class ovskey(nla):
             return flowstr, k, m
 
         def dpstr(self, masked=None, more=False):
-            outstr = self.proto_str + "("
+            outstr = f"{self.proto_str}("
             first = False
             for f in self.fields_map:
                 if first:
                     outstr += ","
                 if masked is None:
-                    outstr += "%s=" % f[0]
+                    outstr += f"{f[0]}="
                     if isinstance(f[2], str):
                         outstr += f[2] % self[f[1]]
                     else:
                         outstr += f[2](self[f[1]])
                     first = True
                 elif more or f[3](masked[f[1]]) != 0:
-                    outstr += "%s=" % f[0]
+                    outstr += f"{f[0]}="
                     if isinstance(f[2], str):
                         outstr += f[2] % self[f[1]]
                     else:
@@ -1658,23 +1640,23 @@ class ovskey(nla):
             for k in self["attrs"]:
                 noprint = False
                 if k[0] == "OVS_TUNNEL_KEY_ATTR_ID":
-                    print_str += "tun_id=%d" % k[1]
+                    print_str += f"tun_id={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV4_SRC":
-                    print_str += "src=%s" % k[1]
+                    print_str += f"src={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV4_DST":
-                    print_str += "dst=%s" % k[1]
+                    print_str += f"dst={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV6_SRC":
-                    print_str += "ipv6_src=%s" % k[1]
+                    print_str += f"ipv6_src={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV6_DST":
-                    print_str += "ipv6_dst=%s" % k[1]
+                    print_str += f"ipv6_dst={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_TOS":
-                    print_str += "tos=%d" % k[1]
+                    print_str += f"tos={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_TTL":
-                    print_str += "ttl=%d" % k[1]
+                    print_str += f"ttl={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_TP_SRC":
-                    print_str += "tp_src=%d" % k[1]
+                    print_str += f"tp_src={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_TP_DST":
-                    print_str += "tp_dst=%d" % k[1]
+                    print_str += f"tp_dst={k[1]}"
                 elif k[0] == "OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT":
                     noprint = True
                     flagsattrs.append("df")
@@ -1689,7 +1671,7 @@ class ovskey(nla):
                     print_str += ","
 
             if len(flagsattrs):
-                print_str += "flags(" + "|".join(flagsattrs) + ")"
+                print_str += f"flags({'|'.join(flagsattrs)})"
             print_str += ")"
             return print_str
 
@@ -1712,8 +1694,8 @@ class ovskey(nla):
         pcp = (tci >> 13) & 0x7
         cfi = (tci >> 12) & 0x1
         if cfi:
-            return "vid=%d,pcp=%d,cfi=%d" % (vid, pcp, cfi)
-        return "tci=0x%04x" % tci
+            return f"vid={vid},pcp={pcp},cfi={cfi}"
+        return f"tci=0x{tci:04x}"
 
     @staticmethod
     def _parse_vlan_from_flowstr(flowstr):
@@ -1757,7 +1739,7 @@ class ovskey(nla):
             eq = flowstr.find('=')
             if eq == -1:
                 raise ValueError(
-                    "vlan(): expected key=value, got '%s'" % flowstr)
+                    f"vlan(): expected key=value, got '{flowstr}'")
             key = flowstr[:eq].strip()
             flowstr = flowstr[eq + 1:]
 
@@ -1771,13 +1753,12 @@ class ovskey(nla):
             flowstr = flowstr[end:]
 
             if not val:
-                raise ValueError("vlan(): empty value for key '%s'" % key)
+                raise ValueError(f"vlan(): empty value for key '{key}'")
             try:
                 v = int(val, 0)
             except ValueError as exc:
                 raise ValueError(
-                    "vlan(): invalid value '%s' for key '%s'"
-                    % (val, key)) from exc
+                    f"vlan(): invalid value '{val}' for key '{key}'") from exc
 
             if key == 'tci':
                 if has_tci:
@@ -1785,7 +1766,7 @@ class ovskey(nla):
                 if has_vid or has_pcp or has_cfi:
                     raise ValueError(_tci_mix_err)
                 if v > 0xFFFF or v < 0:
-                    raise ValueError("vlan(): tci=0x%x out of range" % v)
+                    raise ValueError(f"vlan(): tci=0x{v:x} out of range")
                 tci = v
                 mask = 0xFFFF
                 has_tci = True
@@ -1795,7 +1776,7 @@ class ovskey(nla):
                 if has_vid:
                     raise ValueError("vlan(): duplicate 'vid'")
                 if v < 0 or v > 0xFFF:
-                    raise ValueError("vlan(): vid=%d out of range (0-4095)" % v)
+                    raise ValueError(f"vlan(): vid={v} out of range (0-4095)")
                 tci |= v
                 mask |= 0x0FFF
                 has_vid = True
@@ -1805,7 +1786,7 @@ class ovskey(nla):
                 if has_pcp:
                     raise ValueError("vlan(): duplicate 'pcp'")
                 if v < 0 or v > 7:
-                    raise ValueError("vlan(): pcp=%d out of range (0-7)" % v)
+                    raise ValueError(f"vlan(): pcp={v} out of range (0-7)")
                 tci |= (v & 0x7) << 13
                 mask |= 0xE000
                 has_pcp = True
@@ -1820,7 +1801,7 @@ class ovskey(nla):
                 mask |= ovskey._VLAN_CFI_MASK
                 has_cfi = True
             else:
-                raise ValueError("vlan(): unknown key '%s'" % key)
+                raise ValueError(f"vlan(): unknown key '{key}'")
 
         flowstr = flowstr[1:]  # skip ')'
         # Catch immediate '))' (user error).  A ')' after ',' is consumed
@@ -1856,7 +1837,7 @@ class ovskey(nla):
                 depth -= 1
                 if depth < 0:
                     raise ValueError(
-                        "encap(): unmatched ')' at position %d" % i)
+                        f"encap(): unmatched ')' at position {i}")
                 if depth == 0:
                     end = i
                     break
@@ -1879,8 +1860,7 @@ class ovskey(nla):
         remaining = inner_key.parse(inner_str, inner_mask)
         if remaining and re.search(r'[^\s,)]', remaining):
             raise ValueError(
-                "encap(): unrecognized trailing "
-                "content '%s'" % remaining.strip())
+                f"encap(): unrecognized trailing content '{remaining.strip()}'")
 
         return flowstr, inner_key, inner_mask
 
@@ -1951,7 +1931,7 @@ class ovskey(nla):
                 lambda x: parse_flags(x, None),
             ),
         ):
-            fld = field[1] + "("
+            fld = f"{field[1]}("
             if not flowstr.startswith(fld):
                 continue
 
@@ -2089,15 +2069,15 @@ class ovskey(nla):
                 else:
                     if m is None or field[3](m):
                         val = fmt(v) if callable(fmt) else fmt % v
-                        print_str += field[1] + "(" + val + "),"
+                        print_str += f"{field[1]}({val}),"
                     elif more or m != 0:
                         if field[0] == "OVS_KEY_ATTR_VLAN":
-                            val = "tci=0x%04x/0x%04x" % (v, m)
+                            val = f"tci=0x{v:04x}/0x{m:04x}"
                         elif callable(fmt):
-                            val = fmt(v) + "/" + fmt(m)
+                            val = f"{fmt(v)}/{fmt(m)}"
                         else:
-                            val = (fmt % v) + "/" + (fmt % m)
-                        print_str += field[1] + "(" + val + "),"
+                            val = f"{fmt % v}/{fmt % m}"
+                        print_str += f"{field[1]}({val}),"
 
         return print_str
 
@@ -2179,7 +2159,7 @@ class OvsPacket(GenericNetlinkSocket):
                     elif msg["cmd"] == OvsPacket.OVS_PACKET_CMD_EXECUTE:
                         up.execute(msg)
                     else:
-                        print("Unknown cmd: %d" % msg["cmd"])
+                        print(f"Unknown cmd: {msg['cmd']}")
             except NetlinkError as ne:
                 raise ne
 
@@ -2363,7 +2343,7 @@ class OvsVport(GenericNetlinkSocket):
             return "vxlan"
         elif vport_type == OvsVport.OVS_VPORT_TYPE_GENEVE:
             return "geneve"
-        raise ValueError("Unknown vport type:%d" % vport_type)
+        raise ValueError(f"Unknown vport type:{vport_type}")
 
     def str_to_type(vport_type):
         if vport_type == "netdev":
@@ -2376,7 +2356,7 @@ class OvsVport(GenericNetlinkSocket):
             return OvsVport.OVS_VPORT_TYPE_VXLAN
         elif vport_type == "geneve":
             return OvsVport.OVS_VPORT_TYPE_GENEVE
-        raise ValueError("Unknown vport type: '%s'" % vport_type)
+        raise ValueError(f"Unknown vport type: '{vport_type}'")
 
     def __init__(self, packet=OvsPacket()):
         GenericNetlinkSocket.__init__(self)
@@ -2550,16 +2530,14 @@ class OvsFlow(GenericNetlinkSocket):
             ufid = self.get_attr("OVS_FLOW_ATTR_UFID")
             ufid_str = ""
             if ufid is not None:
-                ufid_str = (
-                    "ufid:{:08x}-{:04x}-{:04x}-{:04x}-{:04x}{:08x}".format(
-                        ufid[0],
-                        ufid[1] >> 16,
-                        ufid[1] & 0xFFFF,
-                        ufid[2] >> 16,
-                        ufid[2] & 0,
-                        ufid[3],
-                    )
-                )
+                u0 = ufid[0]
+                u1h = ufid[1] >> 16
+                u1l = ufid[1] & 0xFFFF
+                u2h = ufid[2] >> 16
+                u2l = ufid[2] & 0
+                u3 = ufid[3]
+                ufid_str = (f"ufid:{u0:08x}-{u1h:04x}-{u1l:04x}"
+                            f"-{u2h:04x}-{u2l:04x}{u3:08x}")
 
             key_field = self.get_attr("OVS_FLOW_ATTR_KEY")
             keymsg = None
@@ -2579,7 +2557,7 @@ class OvsFlow(GenericNetlinkSocket):
             print_str = ""
 
             if more:
-                print_str += ufid_str + ","
+                print_str += f"{ufid_str},"
 
             if keymsg is not None:
                 print_str += keymsg.dpstr(maskmsg, more)
@@ -2588,10 +2566,9 @@ class OvsFlow(GenericNetlinkSocket):
             if stats is None:
                 print_str += " packets:0, bytes:0,"
             else:
-                print_str += " packets:%d, bytes:%d," % (
-                    stats["packets"],
-                    stats["bytes"],
-                )
+                pkts = stats["packets"]
+                nbytes = stats["bytes"]
+                print_str += f" packets:{pkts}, bytes:{nbytes},"
 
             used = self.get_attr("OVS_FLOW_ATTR_USED")
             print_str += " used:"
@@ -2601,7 +2578,7 @@ class OvsFlow(GenericNetlinkSocket):
                 used_time = int(used)
                 cur_time_sec = time.clock_gettime(time.CLOCK_MONOTONIC)
                 used_time = (cur_time_sec * 1000) - used_time
-                print_str += "{}s,".format(used_time / 1000)
+                print_str += f"{used_time / 1000}s,"
 
             print_str += " actions:"
             if (
@@ -2769,7 +2746,7 @@ class OvsFlow(GenericNetlinkSocket):
         pktdata = packetmsg.get_attr("OVS_PACKET_ATTR_PACKET")
         pktpres = "yes" if pktdata is not None else "no"
 
-        print("MISS upcall[%d/%s]: %s" % (seq, pktpres, keystr), flush=True)
+        print(f"MISS upcall[{seq}/{pktpres}]: {keystr}", flush=True)
 
     def execute(self, packetmsg):
         print("userspace execute command", flush=True)
@@ -2803,16 +2780,16 @@ class psample_sample(genlmsg):
         data = ""
         for (attr, value) in self["attrs"]:
             if attr == "PSAMPLE_ATTR_SAMPLE_GROUP":
-                fields.append("group:%d" % value)
+                fields.append(f"group:{value}")
             if attr == "PSAMPLE_ATTR_SAMPLE_RATE":
-                fields.append("rate:%d" % value)
+                fields.append(f"rate:{value}")
             if attr == "PSAMPLE_ATTR_USER_COOKIE":
                 value = "".join(format(x, "02x") for x in value)
-                fields.append("cookie:%s" % value)
+                fields.append(f"cookie:{value}")
             if attr == "PSAMPLE_ATTR_DATA" and len(value) > 0:
-                data = "data:%s" % "".join(format(x, "02x") for x in value)
+                data = f"data:{''.join(format(x, '02x') for x in value)}"
 
-        return ("%s %s" % (",".join(fields), data)).strip()
+        return (f"{','.join(fields)} {data}").strip()
 
 
 class psample_msg(Marshal):
@@ -2846,23 +2823,22 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
     user_features = dp_lookup_rep.get_attr("OVS_DP_ATTR_USER_FEATURES")
     masks_cache_size = dp_lookup_rep.get_attr("OVS_DP_ATTR_MASKS_CACHE_SIZE")
 
-    print("%s:" % dp_name)
-    print(
-        "  lookups: hit:%d missed:%d lost:%d"
-        % (base_stats["hit"], base_stats["missed"], base_stats["lost"])
-    )
-    print("  flows:%d" % base_stats["flows"])
+    print(f"{dp_name}:")
+    hit = base_stats["hit"]
+    missed = base_stats["missed"]
+    lost = base_stats["lost"]
+    print(f"  lookups: hit:{hit} missed:{missed} lost:{lost}")
+    print(f"  flows:{base_stats['flows']}")
     pkts = base_stats["hit"] + base_stats["missed"]
     avg = (megaflow_stats["mask_hit"] / pkts) if pkts != 0 else 0.0
-    print(
-        "  masks: hit:%d total:%d hit/pkt:%f"
-        % (megaflow_stats["mask_hit"], megaflow_stats["masks"], avg)
-    )
+    mhit = megaflow_stats["mask_hit"]
+    mtotal = megaflow_stats["masks"]
+    print(f"  masks: hit:{mhit} total:{mtotal} hit/pkt:{avg:f}")
     print("  caches:")
-    print("    masks-cache: size:%d" % masks_cache_size)
+    print(f"    masks-cache: size:{masks_cache_size}")
 
     if user_features is not None:
-        print("  features: 0x%X" % user_features)
+        print(f"  features: 0x{user_features:X}")
 
     # port print out
     for iface in ndb.interfaces:
@@ -2873,16 +2849,12 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
             if vpo:
                 dpo = vpo.get_attr("OVS_TUNNEL_ATTR_DST_PORT")
                 if dpo:
-                    opts += " tnl-dport:%s" % dpo
-            print(
-                "  port %d: %s (%s%s)"
-                % (
-                    rep.get_attr("OVS_VPORT_ATTR_PORT_NO"),
-                    rep.get_attr("OVS_VPORT_ATTR_NAME"),
-                    OvsVport.type_to_str(rep.get_attr("OVS_VPORT_ATTR_TYPE")),
-                    opts,
-                )
-            )
+                    opts += f" tnl-dport:{dpo}"
+            port_no = rep.get_attr("OVS_VPORT_ATTR_PORT_NO")
+            name = rep.get_attr("OVS_VPORT_ATTR_NAME")
+            vtype = OvsVport.type_to_str(
+                rep.get_attr("OVS_VPORT_ATTR_TYPE"))
+            print(f"  port {port_no}: {name} ({vtype}{opts})")
 
 
 def main(argv):
@@ -3014,14 +2986,14 @@ def main(argv):
         if not found:
             msg = "No DP found"
             if args.showdp is not None:
-                msg += ":'%s'" % args.showdp
+                msg += f":'{args.showdp}'"
             print(msg)
     elif hasattr(args, "adddp"):
         rep = ovsdp.create(args.adddp, args.upcall, args.versioning, ovspk)
         if rep is None:
-            print("DP '%s' already exists" % args.adddp)
+            print(f"DP '{args.adddp}' already exists")
         else:
-            print("DP '%s' added" % args.adddp)
+            print(f"DP '{args.adddp}' added")
         if args.upcall:
             ovspk.upcall_handler(ovsflow)
     elif hasattr(args, "deldp"):
@@ -3029,12 +3001,12 @@ def main(argv):
     elif hasattr(args, "addif"):
         rep = ovsdp.info(args.dpname, 0)
         if rep is None:
-            print("DP '%s' not found." % args.dpname)
+            print(f"DP '{args.dpname}' not found.")
             return 1
         dpindex = rep["dpifindex"]
         rep = ovsvp.attach(rep["dpifindex"], args.addif, args.ptype,
                            args.dport, args.lwt)
-        msg = "vport '%s'" % args.addif
+        msg = f"vport '{args.addif}'"
         if rep and rep["header"]["error"] is None:
             msg += " added."
         else:
@@ -3046,10 +3018,10 @@ def main(argv):
     elif hasattr(args, "delif"):
         rep = ovsdp.info(args.dpname, 0)
         if rep is None:
-            print("DP '%s' not found." % args.dpname)
+            print(f"DP '{args.dpname}' not found.")
             return 1
         rep = ovsvp.detach(rep["dpifindex"], args.delif)
-        msg = "vport '%s'" % args.delif
+        msg = f"vport '{args.delif}'"
         if rep and rep["header"]["error"] is None:
             msg += " removed."
         else:
@@ -3060,7 +3032,7 @@ def main(argv):
     elif hasattr(args, "dumpdp"):
         rep = ovsdp.info(args.dumpdp, 0)
         if rep is None:
-            print("DP '%s' not found." % args.dumpdp)
+            print(f"DP '{args.dumpdp}' not found.")
             return 1
         rep = ovsflow.dump(rep["dpifindex"])
         for flow in rep:
@@ -3068,7 +3040,7 @@ def main(argv):
     elif hasattr(args, "flbr"):
         rep = ovsdp.info(args.flbr, 0)
         if rep is None:
-            print("DP '%s' not found." % args.flbr)
+            print(f"DP '{args.flbr}' not found.")
             return 1
         flow = OvsFlow.ovs_flow_msg()
         flow.parse(args.flow, args.acts, rep["dpifindex"])
@@ -3076,7 +3048,7 @@ def main(argv):
     elif hasattr(args, "flsbr"):
         rep = ovsdp.info(args.flsbr, 0)
         if rep is None:
-            print("DP '%s' not found." % args.flsbr)
+            print(f"DP '{args.flsbr}' not found.")
         ovsflow.del_flows(rep["dpifindex"])
 
     return 0
-- 
2.53.0


