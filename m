Return-Path: <netdev+bounces-105636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5559121E9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7F91C20E97
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC97E17839E;
	Fri, 21 Jun 2024 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddF5RYVA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FE17837E
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964738; cv=none; b=LyU/OL/f/2kiF2WffTfhdbAPVE1FYli2YdTUebk5TW7u+CW4eqXXrl9VOzkfd5h3SzChexmXAD6kQwwaPqTUUH4LTt/o9aR5dSji7qNtlmO+KTR6zipHeqFuQ7pQGQWHIs+LiStmlA4vWT/3JfWOXRJ+s/Lhqhu0Nh+b03zhxTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964738; c=relaxed/simple;
	bh=mtBJ/V1IIRB4mNznMgJ2S7o2Tvjn+KPcNGhQmZODsJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCFJefQEwK4eiOHIfW/VvcVN+QD0NRi3rY1JIMCp/+zud65Ld7ODhR2rIRMFaccWbrVTr/G2koiteBxd4XOwPX9qN7jkWqIZn+DQ1BTEzfd9YY/6cqFpFRAJoYzO9mx04VyT3Bi+1uFKGM2y1M9Mga7o//sPuaugr42ApTXVoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddF5RYVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718964736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zcAs18J6BrHJ+tKKq/UE15hx5Fffl3E+01zCrNA89yQ=;
	b=ddF5RYVA5tj1hjmeSFDdLZFpUhUqJfwXj57IgxwePGoXlNnaXWFMTEM9hdpC7jeZhLEy1R
	hJ/NmZrvXA4p4OMEgNyNsgbk45YsZlS3ec6JuiYPLWtElbedSSB2werlipcWJzEuUqclnO
	W5WLFuF4J1q9UxnilAZxyGXwVYaLplE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-yAFJNqbQOkSMm23m2xdvlA-1; Fri,
 21 Jun 2024 06:12:13 -0400
X-MC-Unique: yAFJNqbQOkSMm23m2xdvlA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 788B61956086;
	Fri, 21 Jun 2024 10:12:11 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6E771956048;
	Fri, 21 Jun 2024 10:12:06 +0000 (UTC)
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
Subject: [PATCH net-next v4 08/10] selftests: openvswitch: add userspace parsing
Date: Fri, 21 Jun 2024 12:11:00 +0200
Message-ID: <20240621101113.2185308-9-amorenoz@redhat.com>
In-Reply-To: <20240621101113.2185308-1-amorenoz@redhat.com>
References: <20240621101113.2185308-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


