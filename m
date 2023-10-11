Return-Path: <netdev+bounces-40130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9CE7C5DD3
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528AE1C20FDB
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F43F4A7;
	Wed, 11 Oct 2023 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkAr48PN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EF2233B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 19:49:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82DC90
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697053789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKHk9hX32NvUAjpB6c62OJCCjOws1Nm9GPb/DcDj7CQ=;
	b=gkAr48PNdX3KqywXoyiPItiVGVbfLlsXOItLRLRTITnRZfcOsmxcmjFP2FpvcFOc80sc8X
	RQ3fnn4ojhRPIWv0PwE9wCrxlKMLJtMEIACgxBX07aPNyxLvC8HVoIZ/ubyz8W1inm7dbp
	thLzWia41eFskUwljqk5C7Gf6KyhTAs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-690-8gTFy7U0MGaSpUNUzKimcQ-1; Wed, 11 Oct 2023 15:49:45 -0400
X-MC-Unique: 8gTFy7U0MGaSpUNUzKimcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0BC41C0BB40;
	Wed, 11 Oct 2023 19:49:44 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.34.140])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 284E01C060B5;
	Wed, 11 Oct 2023 19:49:44 +0000 (UTC)
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
	Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	shuah@kernel.org
Subject: [PATCH net v2 4/4] selftests: openvswitch: Fix the ct_tuple for v4
Date: Wed, 11 Oct 2023 15:49:39 -0400
Message-ID: <20231011194939.704565-5-aconole@redhat.com>
In-Reply-To: <20231011194939.704565-1-aconole@redhat.com>
References: <20231011194939.704565-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The ct_tuple v4 data structure decode / encode routines were using
the v6 IP address decode and relying on default encode. This could
cause exceptions during encode / decode depending on how a ct4
tuple would appear in a netlink message.

Caught during code review.

Fixes: e52b07aa1a54 ("selftests: openvswitch: add flow dump support")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
v2: More detailed explanation for fix.

 tools/testing/selftests/net/openvswitch/ovs-dpctl.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 10b8f31548f84..b97e621face95 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1119,12 +1119,14 @@ class ovskey(nla):
                 "src",
                 lambda x: str(ipaddress.IPv4Address(x)),
                 int,
+                convert_ipv4,
             ),
             (
                 "dst",
                 "dst",
-                lambda x: str(ipaddress.IPv6Address(x)),
+                lambda x: str(ipaddress.IPv4Address(x)),
                 int,
+                convert_ipv4,
             ),
             ("tp_src", "tp_src", "%d", int),
             ("tp_dst", "tp_dst", "%d", int),
-- 
2.41.0


