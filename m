Return-Path: <netdev+bounces-69909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910D684CFCF
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B5A1F22DFE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6CC8286F;
	Wed,  7 Feb 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Krkgxu6N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE701E498
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707327080; cv=none; b=Ikf1uOyPMR4y5jnEslHJllCeoaRe+mOSqq/ioD6Zu4fz2cwS8CuS1+CeEr1RtCgiyd6PQGdQdk7ui/rVYhdwsCRIEzkLzny8zRmK+QChOfqbR5T/sC80MjJRa669z/5+aSWreIaqZBu+1/jaUkPmEBHxfwtodiOo+7uUTmg3TVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707327080; c=relaxed/simple;
	bh=gDfuUYVgKUW/r12EBAceePRcXBkBeDQFRcNeAuQSi/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TczfpkRpxVEYMUscEY0nD5Ob5ZnGJ5ymwOGunY+QzhPe0pGNfMbTd+WXN6ZJB6zoofmvmeLb1/p/VFkXX0iMvhwpq3g3+eKKzz8MHzfyBu+J7joIq1P34UBpz/69gpygWiCZB32xLmND3AM0onPXh9BaccA+j57nCQdcVT/4o78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Krkgxu6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707327078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SO8sv7/cO3G6RaqEjajadlzIMLSqMZLWmNNb2a1ypb0=;
	b=Krkgxu6NtaaAl+zOFNH9VR8btWbUd08Jctn2j8OK2/7p/63ahKvRVu8e7V1JKrhry9HPT+
	wNQdIsvUdgMYiZItbCCxa1l83g6N9+eK+xfYJ8mrs4bnwPamVF3gvMt5LLY/K2fgxSvR1e
	VuacBCNOXNbP+5hSN+drvUNglfRdYq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Mh36QTEUNgKcBkpPO_ZnWQ-1; Wed, 07 Feb 2024 12:31:15 -0500
X-MC-Unique: Mh36QTEUNgKcBkpPO_ZnWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FBB787A38A;
	Wed,  7 Feb 2024 17:31:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 632A82026D08;
	Wed,  7 Feb 2024 17:31:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: add more missing kernel config
Date: Wed,  7 Feb 2024 18:31:10 +0100
Message-ID: <38d3ca7f909736c1aef56e6244d67c82a9bba6ff.1707326987.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The reuseport_addr_any.sh is currently skipping DCCP tests and
pmtu.sh is skipping all the FOU/GUE related cases: add the missing
options.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that this does not include the - still missing - OVS-related
option and pmtu.sh is will keep skipping such cases. Such tests
will still fail in the virtme environment even with the relevant
kernel options enabled, as they have an hard to solve dependency
on systemd/dbus.
The longer term plan is to move such test cases in the openvswitch
directory. One short term option to avoid skips in selftests results
while retaining the potential code coverage would be making the ovs
tests disabled by default but reachable via pmtu.sh command line
arguments.
---
 tools/testing/selftests/net/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 3b749addd364..54d21e2911a9 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -13,6 +13,10 @@ CONFIG_IPV6=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_VETH=y
 CONFIG_NET_IPVTI=y
+CONFIG_NET_FOU=y
+CONFIG_NET_FOU_IP_TUNNELS=y
+CONFIG_NET_IPIP=y
+CONFIG_IPV6_SIT=y
 CONFIG_IPV6_VTI=y
 CONFIG_DUMMY=y
 CONFIG_BRIDGE_VLAN_FILTERING=y
@@ -24,6 +28,7 @@ CONFIG_IFB=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_ESP=y
 CONFIG_INET_ESP_OFFLOAD=y
+CONFIG_IP_DCCP=m
 CONFIG_IP_GRE=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
-- 
2.43.0


