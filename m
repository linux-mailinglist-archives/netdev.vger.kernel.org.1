Return-Path: <netdev+bounces-65961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99283CA92
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B59291F71
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554313398C;
	Thu, 25 Jan 2024 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icN2RJTH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E0132C04
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206163; cv=none; b=cSiTXNnTaaQzm38CORnnsE6tKXma7W6s/rVXlgMdzfcGQTvhJxJLP8+NDk81tPM0h0Nnfc6fiJSq/Q5R28tskdGZSukmzMeuq+D44L1uD/mfztR7Ee/sfmZwxfvLYZ/TPJlJUwLlt/V2ksUwWQ9Z/B9uYjOr6PKFyKz4ISRTC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206163; c=relaxed/simple;
	bh=x9sRqV3hC/XcuQMwTaODTmd26LK5jjkv/G5dMeLV0+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OpkMFcw+YHVILfljcQcXQ7Afla+b7YbSca4hycwm5PpyqkxfVuxK3RJIhekhdkCISglz5TcnZ0RhcSA1KQSzG677hVKVFTVMhLuwMuxgs7ILvgxce0rU2dj7eWN/l1Afg3bxH+U2y37hAx0x/w4mUhxQRp4xqVrmWjkizO12jn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icN2RJTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706206161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sg9+ktb/HYu5+TMU9uhf3pyyy7AvynDtYCcoVozMG5w=;
	b=icN2RJTHgV5Y5CtxBS0vAS3+YjeUxYI4eVMBGXFa1VtLONfxkBKHhoQkMvhZ3oSXOXtpo2
	eWAg0EA+hy9yzJZKEOQqMzWAHkAuNmOsZMSsxPPd+aYlWqZsB6BeQa37lA1Y1B+13t8siX
	Cvab5nGPcF3i2Mb+yHxIdgVwUjDyGj0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-3aUVE1o5PzuHawXYkyvY1g-1; Thu,
 25 Jan 2024 13:09:15 -0500
X-MC-Unique: 3aUVE1o5PzuHawXYkyvY1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 009F31C0BA49;
	Thu, 25 Jan 2024 18:09:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B87B62166B32;
	Thu, 25 Jan 2024 18:09:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: give more time for GRO aggregation
Date: Thu, 25 Jan 2024 19:09:06 +0100
Message-ID: <bffec2beab3a5672dd13ecabe4fad81d2155b367.1706206101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The gro.sh test-case relay on the gro_flush_timeout to ensure
that all the segments belonging to any given batch are properly
aggregated.

The other end, the sender is a user-space program transmitting
each packet with a separate write syscall. A busy host and/or
stracing the sender program can make the relevant segments reach
the GRO engine after the flush timeout triggers.

Give the GRO flush timeout more slack, to avoid sporadic self-tests
failures.

Fixes: 9af771d2ec04 ("selftests/net: allow GRO coalesce test on veth")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/setup_veth.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
index a9a1759e035c..1f78a87f6f37 100644
--- a/tools/testing/selftests/net/setup_veth.sh
+++ b/tools/testing/selftests/net/setup_veth.sh
@@ -11,7 +11,7 @@ setup_veth_ns() {
 	local -r ns_mac="$4"
 
 	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
-	echo 100000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
+	echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
 	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
 	ip -netns "${ns_name}" link set dev "${ns_dev}" up
 
-- 
2.43.0


