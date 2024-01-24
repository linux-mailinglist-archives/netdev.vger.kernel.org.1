Return-Path: <netdev+bounces-65644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FA283B400
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 22:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB331F2283B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 21:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4E135411;
	Wed, 24 Jan 2024 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9ORrzB3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6363135403
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132079; cv=none; b=Y2v0AhC/B3ZiCaB7dENL9W38WNIyunlddkzhIVCOj8a7jZk0wSXe5g0aYoaUkUiYAkGQYUFV9ZUr46HUGR4BgpMN71ciPz/Vdkh44/6czK2QRBGvmwrz2V5G/51BxF1kMipwg9iXbEp2iEAqBOv3KD/7nnKlveVNCjQ0Bab6h/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132079; c=relaxed/simple;
	bh=5WuvJY3aN3BdxPSU6MNv5FAhNY4DCF0eIbhGXWMwsiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlAN6kus5sioSTKW0tFc3CREJFAu4JgNtFKOYi+ys5UO8kc6dvzGBvJRC1IM0JgOQQtMfHaM3bkhC07t200jeTP4JswNFCRPIKcFyoUeTT5WbqOzjwkmwY4lhKNLb5F9IeNSkPDzjbVmYzOinHKC5ggaBCD7KXjvJL540Hkuk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9ORrzB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706132076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8G9xRkMOo+i1Iah9aKA8dHZj7Qv1QBS8lrHWTGi9AAg=;
	b=c9ORrzB3lQGn0NY7ZpkwtTA7F5dyUOSipYxjhY6nMIlHz6jSYPsr7KDlwRT09xUnjQEdk8
	7K83WtqZ2PpH2VySVrMfdABdvuCv/uNnbhvVcD+VHNqtcxaIbp3yIK3GXRMOt2zE3fi/pm
	pWKQLuCJnX8QAaM39jxfNWduZ64fvJY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-JxB-9tKWPaSNU0njxx9bNQ-1; Wed,
 24 Jan 2024 16:34:33 -0500
X-MC-Unique: JxB-9tKWPaSNU0njxx9bNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BAE638212E6;
	Wed, 24 Jan 2024 21:34:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 117AE2166B32;
	Wed, 24 Jan 2024 21:34:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/3] selftests: net: explicitly wait for listener ready
Date: Wed, 24 Jan 2024 22:33:22 +0100
Message-ID: <4d58900fb09cef42749cfcf2ad7f4b91a97d225c.1706131762.git.pabeni@redhat.com>
In-Reply-To: <cover.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The UDP GRO forwarding test still hard-code an arbitrary pause
to wait for the UDP listener becoming ready in background.

That causes sporadic failures depending on the host load.

Replace the sleep with the existing helper waiting for the desired
port being exposed.

Fixes: a062260a9d5f ("selftests: net: add UDP GRO forwarding self-tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/udpgro_fwd.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index 5fa8659ab13d..d6b9c759043c 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+source net_helper.sh
+
 BPF_FILE="xdp_dummy.o"
 readonly BASE="ns-$(mktemp -u XXXXXX)"
 readonly SRC=2
@@ -119,7 +121,7 @@ run_test() {
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 8000
 	ip netns exec $NS_DST ./udpgso_bench_rx -C 1000 -R 10 -n 10 -l 1300 $rx_args &
 	local spid=$!
-	sleep 0.1
+	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC ./udpgso_bench_tx $family -M 1 -s 13000 -S 1300 -D $dst
 	local retc=$?
 	wait $spid
@@ -168,7 +170,7 @@ run_bench() {
 	ip netns exec $NS_DST bash -c "echo 2 > /sys/class/net/veth$DST/queues/rx-0/rps_cpus"
 	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 1000 -R 10  &
 	local spid=$!
-	sleep 0.1
+	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC taskset 0x1 ./udpgso_bench_tx $family -l 3 -S 1300 -D $dst
 	local retc=$?
 	wait $spid
-- 
2.43.0


