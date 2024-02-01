Return-Path: <netdev+bounces-68172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73948846033
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284511F23D8E
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0684FD7;
	Thu,  1 Feb 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBOIawtP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6D84FB6
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 18:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812999; cv=none; b=agVyomHhL8JPVYdT3nTLcS4ThyjSoDbf2Z5CxnGjHL7qeGN8bFxf96+RLr9Tlk6kh+LTLQB77W1wD8OLKjk9ywPdn2jwioDGh5o0LWbil7xnxxdOsq/utHGDUDCwXM1zMjD6AL8KOfB0Z7nxP+5SO6VZF/qrEx4cs3Jc8aoE4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812999; c=relaxed/simple;
	bh=+Zw2OOePxeW/RxY8iz4sE5b+Ic1/JlNERv9v1ctZxbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmZ2q/l7sGYJEdjkAhNT77icTZB1f8D6tkI5jad5qDYRlyhUXPhf3AJoASBlvyw/JlXDItel4QrOBmY5qx8k1SX/7+zXfH+1UpzzgveDLuQ6H41CPItScuWoLzz6jhaTaB/kJ3qw6/k/4PDaqCHRtrOL6i6FDfE6ggXCit6ZtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBOIawtP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706812995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeuFY4PVeFzo6AK3paeQU9WqnXIlU4CEzy28HPrqsRI=;
	b=SBOIawtPHRIZplYTihlCuu7QEejYNGEyVrR9CXhQFH1k/yaYibDEH6V0wmvTbnSM52GDzx
	v0xpBhz0vnIXiZAF9rq4wvdEHo/wa06tXDq9YFeiwqFlHXDprFYKO/LeFlaDahhg9jlUAL
	bF78/rYVDCtK/DnJW6w/462BRXis3vs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-po3JcRQeO9iAhTY-UHlIQw-1; Thu,
 01 Feb 2024 13:43:12 -0500
X-MC-Unique: po3JcRQeO9iAhTY-UHlIQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 957BF1C29EA1;
	Thu,  1 Feb 2024 18:43:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB0A8111F9;
	Thu,  1 Feb 2024 18:43:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	David Ahern <dsahern@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 net 3/4] selftests: net: fix tcp listener handling in pmtu.sh
Date: Thu,  1 Feb 2024 19:42:40 +0100
Message-ID: <f8e8f6d44427d8c45e9f6a71ee1a321047452087.1706812005.git.pabeni@redhat.com>
In-Reply-To: <cover.1706812005.git.pabeni@redhat.com>
References: <cover.1706812005.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

The pmtu.sh test uses a few TCP listener in a problematic way:
It hard-codes a constant timeout to wait for the listener starting-up
in background. That introduces unneeded latency and on very slow and
busy host it can fail.

Additionally the test starts again the same listener in the same
namespace on the same port, just after the previous connection
completed. Fast host can attempt starting the new server before the
old one really closed the socket.

Address the issues using the wait_local_port_listen helper and
explicitly waiting for the background listener process exit.

Fixes: 136a1b434bbb ("selftests: net: test vxlan pmtu exceptions with tcp")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/pmtu.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 3f118e3f1c66..f0febc19baae 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -199,6 +199,7 @@
 #	Same as above but with IPv6
 
 source lib.sh
+source net_helper.sh
 
 PAUSE_ON_FAIL=no
 VERBOSE=0
@@ -1336,13 +1337,15 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 			TCPDST="TCP:[${dst}]:50000"
 		fi
 		${ns_b} socat -T 3 -u -6 TCP-LISTEN:50000 STDOUT > $tmpoutfile &
+		local socat_pid=$!
 
-		sleep 1
+		wait_local_port_listen ${NS_B} 50000 tcp
 
 		dd if=/dev/zero status=none bs=1M count=1 | ${target} socat -T 3 -u STDIN $TCPDST,connect-timeout=3
 
 		size=$(du -sb $tmpoutfile)
 		size=${size%%/tmp/*}
+		wait ${socat_pid}
 
 		[ $size -ne 1048576 ] && err "File size $size mismatches exepcted value in locally bridged vxlan test" && return 1
 	done
-- 
2.43.0


