Return-Path: <netdev+bounces-106671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982D9172C4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883621C20A58
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76AA181D0E;
	Tue, 25 Jun 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGxSh/DN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9117DE31
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348793; cv=none; b=AJR5Ue/jPydWt/DtTen+FGer02jS66hGsVEJHowpbfuo8fMT8IBT0Nx6L7Zgcf8mT2o1th2kJZ7ZE7lmnVFNUg7CXn1NzGNMiG5CgGUmOPIOcwbyBmYQ+2lOyVn0lFG54I8mpjnX7TLiFb62IsmnqcLTRL17BchBiA2Ya3S/wzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348793; c=relaxed/simple;
	bh=mtBJ/V1IIRB4mNznMgJ2S7o2Tvjn+KPcNGhQmZODsJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgzbOOtDvejpWIoqOD2anA4zJ2pVoj0ao9zmCoQTRn62Y26iQaL+HRuT95aYL/k9R/OMEdMB3LQBZYuIV3QkRdktCmOgcfH8lBt+gL0J++GEeSgEXkUFyEfXSkXkgGn6rhY+cF4/c6Jg0ZpPfq1eqwcm2pZDlTq8xd0QO31t5Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGxSh/DN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719348791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcAs18J6BrHJ+tKKq/UE15hx5Fffl3E+01zCrNA89yQ=;
	b=YGxSh/DN5Ty5XbB7V18GbEmnav2hJNlT0u0pQcMox8TfZRfd6h3oCabx1AegSMNBnTHGlK
	x6022zYE8+a66MwFD4gwHUV2iabcnLBzrpKmtFz5PNr57Mhw5eIUyou30vBy5PQTxRLoMo
	tlMSMqRxpXVBhQVGZeLuRkypTI09PBc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-oHnlsvrwMg-zmpdW90uHJg-1; Tue,
 25 Jun 2024 16:53:09 -0400
X-MC-Unique: oHnlsvrwMg-zmpdW90uHJg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E47C1955E7E;
	Tue, 25 Jun 2024 20:53:07 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2870B19560BF;
	Tue, 25 Jun 2024 20:53:01 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 08/10] selftests: openvswitch: add userspace parsing
Date: Tue, 25 Jun 2024 22:51:51 +0200
Message-ID: <20240625205204.3199050-9-amorenoz@redhat.com>
In-Reply-To: <20240625205204.3199050-1-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The userspace action lacks parsing support plus it contains a bug in the
name of one of its attributes.

This patch makes userspace action work.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index ddf4d999317c..071309289cff 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -575,13 +575,27 @@ class ovsactions(nla):
                 print_str += "userdata="
                 for f in self.get_attr("OVS_USERSPACE_ATTR_USERDATA"):
                     print_str += "%x." % f
-            if self.get_attr("OVS_USERSPACE_ATTR_TUN_PORT") is not None:
+            if self.get_attr("OVS_USERSPACE_ATTR_EGRESS_TUN_PORT") is not None:
                 print_str += "egress_tun_port=%d" % self.get_attr(
-                    "OVS_USERSPACE_ATTR_TUN_PORT"
+                    "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT"
                 )
             print_str += ")"
             return print_str
 
+        def parse(self, actstr):
+            attrs_desc = (
+                ("pid", "OVS_USERSPACE_ATTR_PID", int),
+                ("userdata", "OVS_USERSPACE_ATTR_USERDATA",
+                    lambda x: list(bytearray.fromhex(x))),
+                ("egress_tun_port", "OVS_USERSPACE_ATTR_EGRESS_TUN_PORT", int)
+            )
+
+            attrs, actstr = parse_attrs(actstr, attrs_desc)
+            for attr in attrs:
+                self["attrs"].append(attr)
+
+            return actstr
+
     def dpstr(self, more=False):
         print_str = ""
 
@@ -797,6 +811,12 @@ class ovsactions(nla):
                 self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
                 parsed = True
 
+            elif parse_starts_block(actstr, "userspace(", False):
+                uact = self.userspace()
+                actstr = uact.parse(actstr[len("userspace(") : ])
+                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
+                parsed = True
+
             actstr = actstr[strspn(actstr, ", ") :]
             while parencount > 0:
                 parencount -= 1
-- 
2.45.1


