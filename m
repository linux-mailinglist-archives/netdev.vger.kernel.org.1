Return-Path: <netdev+bounces-20126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B875DB83
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA52823B2
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA901D31B;
	Sat, 22 Jul 2023 09:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431217FFF
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 09:43:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A590
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690018979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsTenUSU2FyfhBT7UWgtI9Ilemz2ojQYKvA+bjTcAyA=;
	b=enVw16IWu8iddpMSoafg30BnyXaWynreIOTWoWJCMxYqU8j3uzz7k+C5LTOzNwVUEGuBaA
	kFVR1JyJiPuL4Y7UuWnNrC5GlIAd9r4znxYCnEFaWCWPlfTBjGcYeguddAXQ2YjKbWkYBb
	6g0QLssn5shEwxr5qkGzaViXWAI2Zq8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-uT0eCamMOhOJko8G-p96aA-1; Sat, 22 Jul 2023 05:42:53 -0400
X-MC-Unique: uT0eCamMOhOJko8G-p96aA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B71638025F5;
	Sat, 22 Jul 2023 09:42:53 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D25D840C6F4C;
	Sat, 22 Jul 2023 09:42:51 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org,
	aconole@redhat.com,
	i.maximets@ovn.org,
	eric@garver.life
Subject: [PATCH net-next 5/7] selftests: openvswitch: support key masks
Date: Sat, 22 Jul 2023 11:42:35 +0200
Message-ID: <20230722094238.2520044-6-amorenoz@redhat.com>
In-Reply-To: <20230722094238.2520044-1-amorenoz@redhat.com>
References: <20230722094238.2520044-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The default value for the mask actually depends on the value (e.g: if
the value is non-null, the default is full-mask), so change the convert
functions to accept the full, possibly masked string and let them figure
out how to parse the differnt values.

Also, implement size-aware int parsing.

With this patch we can now express flows such as the following:
"eth(src=0a:ca:fe:ca:fe:0a/ff:ff:00:00:ff:00)"
"eth(src=0a:ca:fe:ca:fe:0a)" -> mask = ff:ff:ff:ff:ff:ff
"ipv4(src=192.168.1.1)" -> mask = 255.255.255.255
"ipv4(src=192.168.1.1/24)"
"ipv4(src=192.168.1.1/255.255.255.0)"
"tcp(src=8080)" -> mask = 0xffff
"tcp(src=8080/0xf0f0)"

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 96 ++++++++++++-------
 1 file changed, 64 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 61c4d7b75261..0bc944f36e02 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -169,25 +169,45 @@ def parse_ct_state(statestr):
     return parse_flags(statestr, ct_flags)
 
 
-def convert_mac(mac_str, mask=False):
-    if mac_str is None or mac_str == "":
-        mac_str = "00:00:00:00:00:00"
-    if mask is True and mac_str != "00:00:00:00:00:00":
-        mac_str = "FF:FF:FF:FF:FF:FF"
-    mac_split = mac_str.split(":")
-    ret = bytearray([int(i, 16) for i in mac_split])
-    return bytes(ret)
+def convert_mac(data):
+    def to_bytes(mac):
+        mac_split = mac.split(":")
+        ret = bytearray([int(i, 16) for i in mac_split])
+        return bytes(ret)
 
+    mac_str, _, mask_str = data.partition('/')
 
-def convert_ipv4(ip, mask=False):
-    if ip is None:
-        ip = 0
-    if mask is True:
-        if ip != 0:
-            ip = int(ipaddress.IPv4Address(ip)) & 0xFFFFFFFF
+    if not mac_str:
+        mac_str = mask_str = "00:00:00:00:00:00"
+    elif not mask_str:
+        mask_str = "FF:FF:FF:FF:FF:FF"
 
-    return int(ipaddress.IPv4Address(ip))
+    return to_bytes(mac_str), to_bytes(mask_str)
 
+def convert_ipv4(data):
+    ip, _, mask = data.partition('/')
+
+    if not ip:
+        ip = mask = 0
+    elif not mask:
+        mask = 0xFFFFFFFF
+    elif mask.isdigit():
+        mask = (0xFFFFFFFF << (32 - int(mask))) & 0xFFFFFFFF
+
+    return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
+
+def convert_int(size):
+    def convert_int_sized(data):
+        value, _, mask = data.partition('/')
+
+        if not value:
+            return 0, 0
+        elif not mask:
+            return int(value, 0), pow(2, size) - 1
+        else:
+            return int(value, 0), int(mask, 0)
+
+    return convert_int_sized
 
 def parse_starts_block(block_str, scanstr, returnskipped, scanregex=False):
     if scanregex:
@@ -628,8 +648,10 @@ class ovskey(nla):
         )
 
         fields_map = (
-            ("src", "src", "%d", lambda x: int(x) if x is not None else 0),
-            ("dst", "dst", "%d", lambda x: int(x) if x is not None else 0),
+            ("src", "src", "%d", lambda x: int(x) if x else 0,
+                convert_int(16)),
+            ("dst", "dst", "%d", lambda x: int(x) if x else 0,
+                convert_int(16)),
         )
 
         def __init__(
@@ -678,17 +700,13 @@ class ovskey(nla):
                     data = flowstr[:splitchar]
                     flowstr = flowstr[splitchar:]
                 else:
-                    data = None
+                    data = ""
 
                 if len(f) > 4:
-                    func = f[4]
-                else:
-                    func = f[3]
-                k[f[0]] = func(data)
-                if len(f) > 4:
-                    m[f[0]] = func(data, True)
+                    k[f[0]], m[f[0]] = f[4](data)
                 else:
-                    m[f[0]] = func(data)
+                    k[f[0]] = f[3](data)
+                    m[f[0]] = f[3](data)
 
                 flowstr = flowstr[strspn(flowstr, ", ") :]
                 if len(flowstr) == 0:
@@ -792,10 +810,14 @@ class ovskey(nla):
                 int,
                 convert_ipv4,
             ),
-            ("proto", "proto", "%d", lambda x: int(x) if x is not None else 0),
-            ("tos", "tos", "%d", lambda x: int(x) if x is not None else 0),
-            ("ttl", "ttl", "%d", lambda x: int(x) if x is not None else 0),
-            ("frag", "frag", "%d", lambda x: int(x) if x is not None else 0),
+            ("proto", "proto", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("tos", "tos", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("ttl", "ttl", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("frag", "frag", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
         )
 
         def __init__(
@@ -931,8 +953,8 @@ class ovskey(nla):
         )
 
         fields_map = (
-            ("type", "type", "%d", int),
-            ("code", "code", "%d", int),
+            ("type", "type", "%d", lambda x: int(x) if x else 0),
+            ("code", "code", "%d", lambda x: int(x) if x else 0),
         )
 
         def __init__(
@@ -997,7 +1019,7 @@ class ovskey(nla):
                 int,
                 convert_ipv4,
             ),
-            ("op", "op", "%d", lambda x: int(x) if x is not None else 0),
+            ("op", "op", "%d", lambda x: int(x) if x else 0),
             (
                 "sha",
                 "sha",
@@ -1201,6 +1223,16 @@ class ovskey(nla):
                 "tcp",
                 ovskey.ovs_key_tcp,
             ),
+            (
+                "OVS_KEY_ATTR_UDP",
+                "udp",
+                ovskey.ovs_key_udp,
+            ),
+            (
+                "OVS_KEY_ATTR_ICMP",
+                "icmp",
+                ovskey.ovs_key_icmp,
+            ),
             (
                 "OVS_KEY_ATTR_TCP_FLAGS",
                 "tcp_flags",
-- 
2.41.0


