Return-Path: <netdev+bounces-104207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A5F90B943
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 20:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B0BB277B5
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB4199224;
	Mon, 17 Jun 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHnSqDKI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02D1991C4
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647356; cv=none; b=jIL7reBbifwKadMSQL7b+6nOQlt7TtHGNH8sfS00UUOGZiWUdz2Hx6b5efrM3KxpM28bX5GwB1AyVg8lqAkrjPODXJ4IpYLnRgFMxnwS/kHnYevpyqYYTAa1ka36+4QFDk/eTe1XHd53gWKBjwGgrwqd/UpW+GqZwWCGGzKrgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647356; c=relaxed/simple;
	bh=o6RnBTW4s3uiAETke5S5c6fAOu8f+O5tvYrKnMkHzow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTgQhhKWApn6eKDzStgrD/L0YDNQuYC3pj9GMn9UBB9bb6RVg50xLgUAoZyXrQy+9Nz4kmhYcCHhv4dl2sXYX3qX9+cyXAUk7TeZgb2BCibjV9cTBvFUbsjKQ5SJO8LmjncVnnpwB1sMlTzRtB/hVylzyvDw8mZMshY09e9HzDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHnSqDKI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZ0rv/2WRMjhZezksPBXgrWYjB1aeegMia2Pp0v5mXA=;
	b=IHnSqDKI8PBeZsIwVY3tSlzGgCRYVyGaMbd86LD4H3YVWMqiXKsYwtxWdns25F/cfGeIBw
	v1qlZ0ZZ0TCCD67anFknMhWdrgBesDnRzWm6eQnro5meHJubosXjv10WCUl9c0QeJCf9rE
	wWoPGAT9Jnp3mPGg5rfnqNgGl/+Xvf4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-VjpeAh6COmmCSTUnAABxug-1; Mon,
 17 Jun 2024 14:02:30 -0400
X-MC-Unique: VjpeAh6COmmCSTUnAABxug-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D4AF195608D;
	Mon, 17 Jun 2024 18:02:29 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D4FC1956087;
	Mon, 17 Jun 2024 18:02:26 +0000 (UTC)
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
Subject: [PATCH net-next 2/7] selftests: openvswitch: Refactor actions parsing.
Date: Mon, 17 Jun 2024 14:02:13 -0400
Message-ID: <20240617180218.1154326-3-aconole@redhat.com>
In-Reply-To: <20240617180218.1154326-1-aconole@redhat.com>
References: <20240617180218.1154326-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Until recently, the ovs-dpctl utility was used with a limited actions set
and didn't need to have support for multiple similar actions.  However,
when adding support for tunnels, it will be important to support multiple
set() actions in a single flow.  When printing these actions, the existing
code will be unable to print all of the sets - it will only print the
first.

Refactor this code to be easier to read and support multiple actions of the
same type in an action list.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 8f92215303a3..4db20b38b481 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -439,32 +439,30 @@ class ovsactions(nla):
     def dpstr(self, more=False):
         print_str = ""
 
-        for field in self.nla_map:
+        for field in self["attrs"]:
             if field[1] == "none" or self.get_attr(field[0]) is None:
                 continue
             if print_str != "":
                 print_str += ","
 
-            if field[1] == "uint32":
-                if field[0] == "OVS_ACTION_ATTR_OUTPUT":
-                    print_str += "%d" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_RECIRC":
-                    print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_TRUNC":
-                    print_str += "trunc(%d)" % int(self.get_attr(field[0]))
-                elif field[0] == "OVS_ACTION_ATTR_DROP":
-                    print_str += "drop(%d)" % int(self.get_attr(field[0]))
-            elif field[1] == "flag":
-                if field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
-                    print_str += "ct_clear"
-                elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
-                    print_str += "pop_vlan"
-                elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
-                    print_str += "pop_eth"
-                elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
-                    print_str += "pop_nsh"
-                elif field[0] == "OVS_ACTION_ATTR_POP_MPLS":
-                    print_str += "pop_mpls"
+            if field[0] == "OVS_ACTION_ATTR_OUTPUT":
+                print_str += "%d" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_RECIRC":
+                print_str += "recirc(0x%x)" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_TRUNC":
+                print_str += "trunc(%d)" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_DROP":
+                print_str += "drop(%d)" % int(self.get_attr(field[0]))
+            elif field[0] == "OVS_ACTION_ATTR_CT_CLEAR":
+                print_str += "ct_clear"
+            elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
+                print_str += "pop_vlan"
+            elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
+                print_str += "pop_eth"
+            elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
+                print_str += "pop_nsh"
+            elif field[0] == "OVS_ACTION_ATTR_POP_MPLS":
+                print_str += "pop_mpls"
             else:
                 datum = self.get_attr(field[0])
                 if field[0] == "OVS_ACTION_ATTR_CLONE":
@@ -472,7 +470,10 @@ class ovsactions(nla):
                     print_str += datum.dpstr(more)
                     print_str += ")"
                 else:
-                    print_str += datum.dpstr(more)
+                    try:
+                        print_str += datum.dpstr(more)
+                    except:
+                        print_str += "{ATTR: %s not decoded}" % field[0]
 
         return print_str
 
-- 
2.45.1


