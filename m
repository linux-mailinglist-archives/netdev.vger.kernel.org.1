Return-Path: <netdev+bounces-48448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19E67EE5A2
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 18:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B45A281007
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EF48CD7;
	Thu, 16 Nov 2023 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNdAm/zd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573231A5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 09:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700154131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xPXye50yN60NPrWJ0DREb+iJaGqc7Pq0Sah7HQttang=;
	b=NNdAm/zdtvLmRaWgnqPqDtZsc9JKeg3PIbdXaqCYMUTJjogl4OP0PEQckOWMWMgsenzdyK
	i8b3VDmp9POQJvILJMjvEuWbaroPkESpFrQVSpXDYRGtdUxUwMvi1Z3zXHFgamawj3aXXg
	GY/mFtqzk90ocdKJfN3n1ZupkjYe0ds=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-fhTxsygoPASkly-2MEWHSA-1; Thu,
 16 Nov 2023 12:02:05 -0500
X-MC-Unique: fhTxsygoPASkly-2MEWHSA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74D4B1C06926;
	Thu, 16 Nov 2023 17:01:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.130])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C60E2492BE8;
	Thu, 16 Nov 2023 17:01:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Daniel Mendes <dmendes@redhat.com>
Subject: [PATCH net] kselftest: rtnetlink: fix ip route command typo
Date: Thu, 16 Nov 2023 18:01:41 +0100
Message-ID: <aabeb7c156a45c878e1ea94a6d715e6908f330a4.1700136983.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The blamed commit below introduced a typo causing 'gretap' test-case
failures:

./rtnetlink.sh  -t kci_test_gretap -v
COMMAND: ip link add name test-dummy0 type dummy
COMMAND: ip link set test-dummy0 up
COMMAND: ip netns add testns
COMMAND: ip link help gretap 2>&1 | grep -q '^Usage:'
COMMAND: ip -netns testns link add dev gretap00 type gretap seq key 102 local 172.16.1.100 remote 172.16.1.200
COMMAND: ip -netns testns addr add dev gretap00 10.1.1.100/24
COMMAND: ip -netns testns link set dev gretap00 ups
    Error: either "dev" is duplicate, or "ups" is a garbage.
COMMAND: ip -netns testns link del gretap00
COMMAND: ip -netns testns link add dev gretap00 type gretap external
COMMAND: ip -netns testns link del gretap00
FAIL: gretap

Fix it by using the correct keyword.

Fixes: 9c2a19f71515 ("kselftest: rtnetlink.sh: add verbose flag")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 5f2b3f6c0d74..38be9706c45f 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -859,7 +859,7 @@ kci_test_gretap()
 
 
 	run_cmd ip -netns "$testns" addr add dev "$DEV_NS" 10.1.1.100/24
-	run_cmd ip -netns "$testns" link set dev $DEV_NS ups
+	run_cmd ip -netns "$testns" link set dev $DEV_NS up
 	run_cmd ip -netns "$testns" link del "$DEV_NS"
 
 	# test external mode
-- 
2.41.0


