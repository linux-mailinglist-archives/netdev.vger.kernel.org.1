Return-Path: <netdev+bounces-103340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF821907AB3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CD92822EA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4B14B950;
	Thu, 13 Jun 2024 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S97nzmW0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43C14B086
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302432; cv=none; b=JEeYRO9qKzwTuseGiVw2bOjyc/AVCv22I3jaaNE5WlD+x77fAnTj+BTiJiAPFfHeDv+D1v1vqTxt1JD3R0+jHzamWYrFQFTYnNaJwiJfRer+UMTkMzQ1UrZoor+1uuUq8QINy92GGU2dekZ9ikJLRrsqfRf+2iEJwOBjIw2ySd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302432; c=relaxed/simple;
	bh=PIMrBNZ+QcTFTWCK6HJzPESDq0Olq4pAwKK/9jAnwRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9TBP17ltUUT7TKlcdZFIR5NuZCjwQ56nSEpRqevNRnj5bb2YLxUenSkBGNcIXQkaA+/vZ27qjvCK/orxxEPo72ZP7MEx+L63InVaqHjKtx7iPXghKDEJwdba9fXUDYTfdEP8lTHrnSVQdrmT3bMWo+zzMQdBW0H5OsN4QCDb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S97nzmW0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718302429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLGJvpvd4CEYNzpdVDTbnwnMoftXigk8Jqf38C6TROA=;
	b=S97nzmW0EHDSC93A4zjdqQ9SVAD7dxc5F9UaoJx7mofShX7Y7+L1Tenyqj1p5Jdb6mdS3j
	wKob7Wc7ndE80H4chAQZAiHWWyqMZp894CJsUkA8kT71VlmtrotivUu5l2zoC4FMwjm6AU
	lSdeLAo62q6QZcLovomNsvLW0r5z8QI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-N1OsEcEROEenTGiR3NVz4Q-1; Thu,
 13 Jun 2024 14:13:46 -0400
X-MC-Unique: N1OsEcEROEenTGiR3NVz4Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7164419560B4;
	Thu, 13 Jun 2024 18:13:44 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E3A019560BF;
	Thu, 13 Jun 2024 18:13:41 +0000 (UTC)
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
	Adrian Moreno <amorenoz@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 2/7] selftests: openvswitch: Refactor actions parsing.
Date: Thu, 13 Jun 2024 14:13:28 -0400
Message-ID: <20240613181333.984810-3-aconole@redhat.com>
In-Reply-To: <20240613181333.984810-1-aconole@redhat.com>
References: <20240613181333.984810-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Until recently, the ovs-dpctl utility was used with a limited actions set
and didn't need to have support for multiple similar actions.  However,
when adding support for tunnels, it will be important to support multiple
set() actions in a single flow.  When printing these actions, the existing
code will be unable to print all of the sets - it will only print the
first.

Refactor this code to be easier to read and support multiple actions of the
same type in an action list.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 56f6bd162d3e..73768f3af6e5 100644
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


