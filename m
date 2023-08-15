Return-Path: <netdev+bounces-27803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD677D386
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A611C20D3D
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF85198AE;
	Tue, 15 Aug 2023 19:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1688198AD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:43:41 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC6410FF;
	Tue, 15 Aug 2023 12:43:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso5085014f8f.0;
        Tue, 15 Aug 2023 12:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692128618; x=1692733418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8mNYBAbLghexAM2MZEbEhjesH9w35WH3ToK8+snsTQ=;
        b=S/R6TvnziwdQCfEmLaAxwEFqLxyeyhLK8HlN12cm0j/onoD0kciTsxG6+9B7MCZjC9
         RDc5OMfm0zrdwupIrF1C6n4CTerBqW7IQ5gK2tDBZ1XYlIl+jZWBpUIW2uO+j6iREjAX
         WQ1CORQi4kbixREhoUqsIIG0n8AshRk/WZeSRNJntAQ2nCR5QpFr7DIjaJmILhPt84gj
         GrTZ4RdNNVOGoxY1SIqw9TsZ2aMNnNqN0wF7m1f3C6E1sw5P5BpO45WAsXnPN1ZzzORn
         zcLoCe9/cB9M3SmcZzQk7fMSaAYN2mOBzsaGrYzkg2/Gdf4LgOMk/4rfu3nNfE4UeaEt
         30SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128618; x=1692733418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8mNYBAbLghexAM2MZEbEhjesH9w35WH3ToK8+snsTQ=;
        b=U9NUx+/Z+zPF0XxnycmGVnxR/2MMfJDsmr8gO57QR4+YIfoFuYh/rod38jkT51lcFx
         S15NYHRmQ2McFwCTPoNBWfkjoYeONtB7nm+4JlFkTerV8o0Lg6U+/OQWQCQsYk4EKO8G
         IlhIPcmVcKaUT5qFe17bubWl+tfarpGtt9glKvO1It6UC1P6AysEItb6Rh1gpSlS7+TV
         oqJ+vIeKrjK9UdFH1yyynDHB3nFQdJyJnSHCviuo7pgKTUHnfTNEYwm20OsSBx/FkPaZ
         fZqSfwcPJxCJj/FgosCqiBHxBNYIogBCzIXumcvqJ6SAft2xX2CeCKNhtTL6C8Mjhyds
         DP3Q==
X-Gm-Message-State: AOJu0Yw7YDP4havYJZwGyH9HAJf4WOKzEuvLrZNl4hiJG1nNN1MwSY4V
	4qGNUfMWr052lD31Lm70ECFsaud0rktHX/Ry
X-Google-Smtp-Source: AGHT+IFkleXFNg2i9h29/7SaHyG9UpQTmAV6ugClAkOzeEi7KdmXVPRMKU37sULfjQBOS93+yKbqxA==
X-Received: by 2002:a5d:4ec1:0:b0:317:5e0a:545e with SMTP id s1-20020a5d4ec1000000b003175e0a545emr9038845wrv.58.1692128617737;
        Tue, 15 Aug 2023 12:43:37 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9934:e2f7:cd0e:75a6])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d6610000000b003179d5aee67sm18814892wru.94.2023.08.15.12.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:43:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Stanislav Fomichev <sdf@google.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 06/10] tools/net/ynl: Add support for netlink-raw families
Date: Tue, 15 Aug 2023 20:42:50 +0100
Message-ID: <20230815194254.89570-7-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815194254.89570-1-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Refactor the ynl code to encapsulate protocol specifics into
NetlinkProtocol and GenlProtocol.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/ynl.py | 103 +++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 25 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 4fa42a7c5955..325dc0d9c5b5 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -25,6 +25,7 @@ class Netlink:
     NETLINK_ADD_MEMBERSHIP = 1
     NETLINK_CAP_ACK = 10
     NETLINK_EXT_ACK = 11
+    NETLINK_GET_STRICT_CHK = 12
 
     # Netlink message
     NLMSG_ERROR = 2
@@ -242,6 +243,9 @@ class NlMsg:
             self.fixed_header_attrs[m.name] = value
         self.raw = self.raw[offset:]
 
+    def cmd(self):
+        return self.nl_type
+
     def __repr__(self):
         msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}\n"
         if self.error:
@@ -344,6 +348,9 @@ class GenlMsg:
         self.raw_attrs = NlAttrs(self.raw)
         self.fixed_header_attrs = nl_msg.fixed_header_attrs
 
+    def cmd(self):
+        return self.genl_cmd
+
     def __repr__(self):
         msg = repr(self.nl)
         msg += f"\tgenl_cmd = {self.genl_cmd} genl_ver = {self.genl_version}\n"
@@ -352,9 +359,35 @@ class GenlMsg:
         return msg
 
 
-class GenlFamily:
-    def __init__(self, family_name):
+class NetlinkProtocol:
+    def __init__(self, family_name, proto_num):
         self.family_name = family_name
+        self.proto_num = proto_num
+
+    def _message(self, nl_type, nl_flags, seq=None):
+        if seq is None:
+            seq = random.randint(1, 1024)
+        nlmsg = struct.pack("HHII", nl_type, nl_flags, seq, 0)
+        return nlmsg
+
+    def message(self, flags, command, version, seq=None):
+        return self._message(command, flags, seq)
+
+    def decode(self, ynl, nl_msg):
+        op = ynl.rsp_by_value[nl_msg.nl_type]
+        if op.fixed_header:
+            nl_msg.decode_fixed_header(ynl, op.fixed_header)
+        nl_msg.raw_attrs = NlAttrs(nl_msg.raw)
+        return nl_msg
+
+    def get_mcast_id(self, mcast_name, mcast_groups):
+        if mcast_name not in mcast_groups:
+            raise Exception(f'Multicast group "{mcast_name}" not present in the spec')
+        return mcast_groups[mcast_name].id
+
+class GenlProtocol(NetlinkProtocol):
+    def __init__(self, family_name):
+        super().__init__(family_name, Netlink.NETLINK_GENERIC)
 
         global genl_family_name_to_id
         if genl_family_name_to_id is None:
@@ -363,6 +396,18 @@ class GenlFamily:
         self.genl_family = genl_family_name_to_id[family_name]
         self.family_id = genl_family_name_to_id[family_name]['id']
 
+    def message(self, flags, command, version, seq=None):
+        nlmsg = self._message(self.family_id, flags, seq)
+        genlmsg = struct.pack("BBH", command, version, 0)
+        return nlmsg + genlmsg
+
+    def decode(self, ynl, nl_msg):
+        return GenlMsg(nl_msg, ynl)
+
+    def get_mcast_id(self, mcast_name, mcast_groups):
+        if mcast_name not in self.genl_family['mcast']:
+            raise Exception(f'Multicast group "{mcast_name}" not present in the family')
+        return self.genl_family['mcast'][mcast_name]
 
 #
 # YNL implementation details.
@@ -375,9 +420,19 @@ class YnlFamily(SpecFamily):
 
         self.include_raw = False
 
-        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, Netlink.NETLINK_GENERIC)
+        try:
+            if self.proto == "netlink-raw":
+                self.nlproto = NetlinkProtocol(self.yaml['name'],
+                                               self.yaml['protonum'])
+            else:
+                self.nlproto = GenlProtocol(self.yaml['name'])
+        except KeyError:
+            raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
+
+        self.sock = socket.socket(socket.AF_NETLINK, socket.SOCK_RAW, self.nlproto.proto_num)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_CAP_ACK, 1)
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_EXT_ACK, 1)
+        self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
         self.async_msg_queue = []
@@ -390,18 +445,12 @@ class YnlFamily(SpecFamily):
             bound_f = functools.partial(self._op, op_name)
             setattr(self, op.ident_name, bound_f)
 
-        try:
-            self.family = GenlFamily(self.yaml['name'])
-        except KeyError:
-            raise Exception(f"Family '{self.yaml['name']}' not supported by the kernel")
 
     def ntf_subscribe(self, mcast_name):
-        if mcast_name not in self.family.genl_family['mcast']:
-            raise Exception(f'Multicast group "{mcast_name}" not present in the family')
-
+        mcast_id = self.nlproto.get_mcast_id(mcast_name, self.mcast_groups)
         self.sock.bind((0, 0))
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_ADD_MEMBERSHIP,
-                             self.family.genl_family['mcast'][mcast_name])
+                             mcast_id)
 
     def _add_attr(self, space, name, value):
         attr = self.attr_sets[space][name]
@@ -525,9 +574,12 @@ class YnlFamily(SpecFamily):
         if self.include_raw:
             msg['nlmsg'] = nl_msg
             msg['genlmsg'] = genl_msg
-        op = self.rsp_by_value[genl_msg.genl_cmd]
+        op = self.rsp_by_value[genl_msg.cmd()]
+        decoded = self._decode(genl_msg.raw_attrs, op.attr_set.name)
+        decoded.update(genl_msg.fixed_header_attrs)
+
         msg['name'] = op['name']
-        msg['msg'] = self._decode(genl_msg.raw_attrs, op.attr_set.name)
+        msg['msg'] = decoded
         self.async_msg_queue.append(msg)
 
     def check_ntf(self):
@@ -547,12 +599,12 @@ class YnlFamily(SpecFamily):
                     print("Netlink done while checking for ntf!?")
                     continue
 
-                gm = GenlMsg(nl_msg)
-                if gm.genl_cmd not in self.async_msg_ids:
-                    print("Unexpected msg id done while checking for ntf", gm)
+                decoded = self.nlproto.decode(self, nl_msg)
+                if decoded.cmd() not in self.async_msg_ids:
+                    print("Unexpected msg id done while checking for ntf", decoded)
                     continue
 
-                self.handle_ntf(nl_msg, gm)
+                self.handle_ntf(nl_msg, decoded)
 
     def operation_do_attributes(self, name):
       """
@@ -573,7 +625,7 @@ class YnlFamily(SpecFamily):
             nl_flags |= Netlink.NLM_F_DUMP
 
         req_seq = random.randint(1024, 65535)
-        msg = _genl_msg(self.family.family_id, nl_flags, op.req_value, 1, req_seq)
+        msg = self.nlproto.message(nl_flags, op.req_value, 1, req_seq)
         fixed_header_members = []
         if op.fixed_header:
             fixed_header_members = self.consts[op.fixed_header].members
@@ -605,18 +657,19 @@ class YnlFamily(SpecFamily):
                     done = True
                     break
 
-                gm = GenlMsg(nl_msg, self)
+                decoded = self.nlproto.decode(self, nl_msg)
+
                 # Check if this is a reply to our request
-                if nl_msg.nl_seq != req_seq or gm.genl_cmd != op.rsp_value:
-                    if gm.genl_cmd in self.async_msg_ids:
-                        self.handle_ntf(nl_msg, gm)
+                if nl_msg.nl_seq != req_seq or decoded.cmd() != op.rsp_value:
+                    if decoded.cmd() in self.async_msg_ids:
+                        self.handle_ntf(nl_msg, decoded)
                         continue
                     else:
-                        print('Unexpected message: ' + repr(gm))
+                        print('Unexpected message: ' + repr(decoded))
                         continue
 
-                rsp_msg = self._decode(gm.raw_attrs, op.attr_set.name)
-                rsp_msg.update(gm.fixed_header_attrs)
+                rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
+                rsp_msg.update(decoded.fixed_header_attrs)
                 rsp.append(rsp_msg)
 
         if not rsp:
-- 
2.41.0


