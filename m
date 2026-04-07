Return-Path: <netdev+bounces-275844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJpMCOJv1GkruAcAu9opvQ
	(envelope-from <netdev+bounces-275844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:45:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAD43A937B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 04:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50276302158D
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 02:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6020372675;
	Tue,  7 Apr 2026 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5LAiOJM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14352727F3
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775529929; cv=none; b=cbfGTwjdbC8l+DbJN87mZ2go6s8xfDcOwLDLBP0OT6rL3ky7MPFD8XCV5LP+O1FUlKzbUQ2vdb6kUVcs6yN6EcqPisVL4uDa9dW2akPRJUCAD/i9Zz5drAFI+S2dRBqdffvOJkuKKJOOzVI0xNlCFUCBHVt8koHOljs/OSDcij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775529929; c=relaxed/simple;
	bh=Ja+s+qesPzExVKKINDPzevrST5k6ihEc1TyUc3HpcdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngIBML82hSFA5LkYBXqF3nImb4WPFjH2Jxp68fIUN5+EBzzinToDMVBUb3vDbkFXmWrDrznWH9NVL8wcbrBCEHICjjybPbRsea1Vva5CXs4G/4P3abPiUyysNwVyDyywh6xvnPezUkXVYFEzz03Cn7HFPDwVYQnXfr5ROPTcivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W5LAiOJM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775529927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+fBSYxsCHm/g97qqEX2hKEUxcvlEWL8dj5yDnsF1Z0=;
	b=W5LAiOJM2sRRGI7IGGnFRZ+EesSccTfj+HCmt9VxAuEVxhLRwURELMhw2k1wVzvUUN1V2h
	lHQ5lWt7NrjF9hSQfRz8UCFInhX0PX1SKevG2BKQijG3Gn6JFtHSu1iobJ117FzuH+3KX2
	NAVq5DCiBPYUOc47x4cTdeCJKQYZBvA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-JmArAdLOOCahNa7o7-_fbw-1; Mon,
 06 Apr 2026 22:45:24 -0400
X-MC-Unique: JmArAdLOOCahNa7o7-_fbw-1
X-Mimecast-MFC-AGG-ID: JmArAdLOOCahNa7o7-_fbw_1775529923
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D1B7195608A;
	Tue,  7 Apr 2026 02:45:23 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.com (unknown [10.72.116.131])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4187F300019F;
	Tue,  7 Apr 2026 02:45:18 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 1/4] selftests: drv-net: tso: retry connect on EHOSTUNREACH
Date: Tue,  7 Apr 2026 10:45:08 +0800
Message-ID: <a030c72662673990263aeb62c7050cdf58e18af3.1775527362.git.xudu@redhat.com>
In-Reply-To: <cover.1775527362.git.xudu@redhat.com>
References: <cover.1775527362.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275844-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFAD43A937B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The TSO test occasionally fails with "No route to host" (EHOSTUNREACH)
when connecting to the remote socat listener. This can happen when the
neighbor resolution has not yet completed by the time the test attempts
to connect, particularly in tunnel setups where neighbor entries may
take slightly longer to establish.

Add a retry loop (up to 5 attempts with 0.5s delay) around the
sock.connect() call to handle this transient condition gracefully.

Signed-off-by: Xu Du <xudu@redhat.com>
---
 tools/testing/selftests/drivers/net/hw/tso.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/tso.py b/tools/testing/selftests/drivers/net/hw/tso.py
index bb675e3dac88..f792115adfb3 100755
--- a/tools/testing/selftests/drivers/net/hw/tso.py
+++ b/tools/testing/selftests/drivers/net/hw/tso.py
@@ -3,6 +3,7 @@
 
 """Run the tools/testing/selftests/net/csum testsuite."""
 
+import errno
 import fcntl
 import socket
 import struct
@@ -47,10 +48,20 @@ def run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso):
 
         if ipver == "4":
             sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
-            sock.connect((remote_v4, port))
+            sockaddr = (remote_v4, port)
         else:
             sock = socket.socket(socket.AF_INET6, socket.SOCK_STREAM)
-            sock.connect((remote_v6, port))
+            sockaddr = (remote_v6, port)
+
+        for attempt in range(5):
+            try:
+                sock.connect(sockaddr)
+                break
+            except OSError as e:
+                if e.errno == errno.EHOSTUNREACH and attempt < 4:
+                    time.sleep(0.5)
+                else:
+                    raise
 
         # Small send to make sure the connection is working.
         sock.send("ping".encode())
-- 
2.53.0


