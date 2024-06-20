Return-Path: <netdev+bounces-105270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B0910520
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA34F286146
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4E1B47D4;
	Thu, 20 Jun 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL3LL8xh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59C1B3F09
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888192; cv=none; b=XaedGm/omYfRmPZ4/LFLMVIyzvsarnghTWsaJQEWHZTRKwOgdMqgpxHEsvxZ1AZZDRnFnbm7UseDkks4Qfl0fcspAZI29qlCqg0SBzzlLNUL/EL7ov2lq8fn/k+XrHsROi5N4J7NqPEswXuygChCoVauKBQoUFIp8gsh+Deub+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888192; c=relaxed/simple;
	bh=DM5Ex803zS7MOxfWJYf5m05LJwFNJsDu1bx7wMEtVz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8E+Tby0+nLJrfT59RutQpbuTKrs81Tnzi0CLhl3IKz705R9c3ZPh4v+YLYU4AwGPXjfc/Gt53bUP8YVY4gDQd7Qk2AJHbXLTj+vKuwvTdo2q5DzG1CkecB9EtL0S2/egLKPfTycL6Bz4swbMlrEkHRYOQqH4MZ+QgdgQ2fdgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fL3LL8xh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KlgFTzGvRQ9KF2HWnCZmoGsdCauwElV+Abi5MawrNg=;
	b=fL3LL8xhKcuwzhup3fwWV8UG6sI3e1sXoLntgcA1lS0uYhPQC4Ox5PPX7JEYDRFQB1bXNs
	iz4MKlOiE8DJn0S5lVxYcSgw17729b/LLEJXyfWOkNYUsuX/0D68Sz0QeP/DXXIsvcaiQ+
	ajteU4Q/m6EZHadPgcmBLM9j/JS3aGY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-Zhx9NxpYOn6hONCNaIiG6g-1; Thu,
 20 Jun 2024 08:56:23 -0400
X-MC-Unique: Zhx9NxpYOn6hONCNaIiG6g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 882BE1955EBA;
	Thu, 20 Jun 2024 12:56:19 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.9.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C30C1956087;
	Thu, 20 Jun 2024 12:56:16 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 net-next 4/7] selftests: openvswitch: Add support for tunnel() key.
Date: Thu, 20 Jun 2024 08:55:58 -0400
Message-ID: <20240620125601.15755-5-aconole@redhat.com>
In-Reply-To: <20240620125601.15755-1-aconole@redhat.com>
References: <20240620125601.15755-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This will be used when setting details about the tunnel to use as
transport.  There is a difference between the ODP format between tunnel():
the 'key' flag is not actually a flag field, so we don't support it in the
same way that the vswitchd userspace supports displaying it.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 167 +++++++++++++++++-
 1 file changed, 166 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 4c235ff07aeb..2f16df2fb16b 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -709,7 +709,7 @@ class ovskey(nla):
         ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),
         ("OVS_KEY_ATTR_ND", "ovs_key_nd"),
         ("OVS_KEY_ATTR_SKB_MARK", "uint32"),
-        ("OVS_KEY_ATTR_TUNNEL", "none"),
+        ("OVS_KEY_ATTR_TUNNEL", "ovs_key_tunnel"),
         ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),
         ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),
         ("OVS_KEY_ATTR_DP_HASH", "uint32"),
@@ -1269,6 +1269,163 @@ class ovskey(nla):
                 init=init,
             )
 
+    class ovs_key_tunnel(nla):
+        nla_flags = NLA_F_NESTED
+
+        nla_map = (
+            ("OVS_TUNNEL_KEY_ATTR_ID", "be64"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV4_DST", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_TOS", "uint8"),
+            ("OVS_TUNNEL_KEY_ATTR_TTL", "uint8"),
+            ("OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT", "flag"),
+            ("OVS_TUNNEL_KEY_ATTR_CSUM", "flag"),
+            ("OVS_TUNNEL_KEY_ATTR_OAM", "flag"),
+            ("OVS_TUNNEL_KEY_ATTR_GENEVE_OPTS", "array(uint32)"),
+            ("OVS_TUNNEL_KEY_ATTR_TP_SRC", "be16"),
+            ("OVS_TUNNEL_KEY_ATTR_TP_DST", "be16"),
+            ("OVS_TUNNEL_KEY_ATTR_VXLAN_OPTS", "none"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV6_SRC", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV6_DST", "ipaddr"),
+            ("OVS_TUNNEL_KEY_ATTR_PAD", "none"),
+            ("OVS_TUNNEL_KEY_ATTR_ERSPAN_OPTS", "none"),
+            ("OVS_TUNNEL_KEY_ATTR_IPV4_INFO_BRIDGE", "flag"),
+        )
+
+        def parse(self, flowstr, mask=None):
+            if not flowstr.startswith("tunnel("):
+                return None, None
+
+            k = ovskey.ovs_key_tunnel()
+            if mask is not None:
+                mask = ovskey.ovs_key_tunnel()
+
+            flowstr = flowstr[len("tunnel("):]
+
+            v6_address = None
+
+            fields = [
+                ("tun_id=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_ID",
+                 0xffffffffffffffff, None, None),
+
+                ("src=", r"([0-9a-fA-F\.]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV4_SRC", "255.255.255.255", "0.0.0.0",
+                 False),
+                ("dst=", r"([0-9a-fA-F\.]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV4_DST", "255.255.255.255", "0.0.0.0",
+                 False),
+
+                ("ipv6_src=", r"([0-9a-fA-F:]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV6_SRC",
+                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
+                ("ipv6_dst=", r"([0-9a-fA-F:]+)", str,
+                 "OVS_TUNNEL_KEY_ATTR_IPV6_DST",
+                 "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "::", True),
+
+                ("tos=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TOS", 255, 0,
+                 None),
+                ("ttl=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TTL", 255, 0,
+                 None),
+
+                ("tp_src=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_SRC",
+                 65535, 0, None),
+                ("tp_dst=", r"(\d+)", int, "OVS_TUNNEL_KEY_ATTR_TP_DST",
+                 65535, 0, None),
+            ]
+
+            forced_include = ["OVS_TUNNEL_KEY_ATTR_TTL"]
+
+            for prefix, regex, typ, attr_name, mask_val, default_val, v46_flag in fields:
+                flowstr, value = parse_extract_field(flowstr, prefix, regex, typ, False)
+                if not attr_name:
+                    raise Exception("Bad list value in tunnel fields")
+
+                if value is None and attr_name in forced_include:
+                    value = default_val
+                    mask_val = default_val
+
+                if value is not None:
+                    if v46_flag is not None:
+                        if v6_address is None:
+                            v6_address = v46_flag
+                        if v46_flag != v6_address:
+                            raise ValueError("Cannot mix v6 and v4 addresses")
+                    k["attrs"].append([attr_name, value])
+                    if mask is not None:
+                        mask["attrs"].append([attr_name, mask_val])
+                else:
+                    if v46_flag is not None:
+                        if v6_address is None or v46_flag != v6_address:
+                            continue
+                    if mask is not None:
+                        mask["attrs"].append([attr_name, default_val])
+
+            if k["attrs"][0][0] != "OVS_TUNNEL_KEY_ATTR_ID":
+                raise ValueError("Needs a tunid set")
+
+            if flowstr.startswith("flags("):
+                flowstr = flowstr[len("flags("):]
+                flagspos = flowstr.find(")")
+                flags = flowstr[:flagspos]
+                flowstr = flowstr[flagspos + 1:]
+
+                flag_attrs = {
+                    "df": "OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT",
+                    "csum": "OVS_TUNNEL_KEY_ATTR_CSUM",
+                    "oam": "OVS_TUNNEL_KEY_ATTR_OAM"
+                }
+
+                for flag in flags.split("|"):
+                    if flag in flag_attrs:
+                        k["attrs"].append([flag_attrs[flag], True])
+                        if mask is not None:
+                            mask["attrs"].append([flag_attrs[flag], True])
+
+            flowstr = flowstr[strspn(flowstr, ", ") :]
+            return flowstr, k, mask
+
+        def dpstr(self, mask=None, more=False):
+            print_str = "tunnel("
+
+            flagsattrs = []
+            for k in self["attrs"]:
+                noprint = False
+                if k[0] == "OVS_TUNNEL_KEY_ATTR_ID":
+                    print_str += "tun_id=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV4_SRC":
+                    print_str += "src=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV4_DST":
+                    print_str += "dst=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV6_SRC":
+                    print_str += "ipv6_src=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_IPV6_DST":
+                    print_str += "ipv6_dst=%s" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TOS":
+                    print_str += "tos=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TTL":
+                    print_str += "ttl=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TP_SRC":
+                    print_str += "tp_src=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_TP_DST":
+                    print_str += "tp_dst=%d" % k[1]
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_DONT_FRAGMENT":
+                    noprint = True
+                    flagsattrs.append("df")
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_CSUM":
+                    noprint = True
+                    flagsattrs.append("csum")
+                elif k[0] == "OVS_TUNNEL_KEY_ATTR_OAM":
+                    noprint = True
+                    flagsattrs.append("oam")
+
+                if not noprint:
+                    print_str += ","
+
+            if len(flagsattrs):
+                print_str += "flags(" + "|".join(flagsattrs) + ")"
+            print_str += ")"
+            return print_str
+
     class ovs_key_mpls(nla):
         fields = (("lse", ">I"),)
 
@@ -1277,6 +1434,7 @@ class ovskey(nla):
             ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
             ("OVS_KEY_ATTR_SKB_MARK", "skb_mark", intparse),
             ("OVS_KEY_ATTR_RECIRC_ID", "recirc_id", intparse),
+            ("OVS_KEY_ATTR_TUNNEL", "tunnel", ovskey.ovs_key_tunnel),
             ("OVS_KEY_ATTR_DP_HASH", "dp_hash", intparse),
             ("OVS_KEY_ATTR_CT_STATE", "ct_state", parse_ct_state),
             ("OVS_KEY_ATTR_CT_ZONE", "ct_zone", intparse),
@@ -1379,6 +1537,13 @@ class ovskey(nla):
                 lambda x: False,
                 True,
             ),
+            (
+                "OVS_KEY_ATTR_TUNNEL",
+                "tunnel",
+                None,
+                False,
+                False,
+            ),
             (
                 "OVS_KEY_ATTR_CT_STATE",
                 "ct_state",
-- 
2.45.1


