Return-Path: <netdev+bounces-72429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2280A85813C
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 16:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7444B21B45
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E0139581;
	Fri, 16 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grz+0Mh3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBB12FF84
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097335; cv=none; b=rjJVR7amBZjgRpZmETnqkqA7IjP4DAo4Dui5/2bMxaQH+KpWst0TvJPUBARJ2n6LBzuAkXVx2tL7MNRd9ibnH/mVFxxpgU173RRTcV31oAzcseoQ188P8kf+DpAjEB17p9oxKckTPCgOKeUC5IcIKdQFwXo83Wi0N9B/WMKvdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097335; c=relaxed/simple;
	bh=Mif2Pw9Dh6MEkFyqulQXsxVjnIm4JFp+wr4NhK2k9K8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfk/RVdwAqjQj0X7NatguzjBvdJPHsb/3BrLTf5vQnPP2evOOyaWKstj558nrrnWp0l6rqHmXM4FJV8Yf32WaDqlRs+0qnVqyaP4WG3vJCNK3u4YNwQ/m8Xew5w5I0DtCtJBM/+xhUv4lsstOCM1zYBe0WtdrjYhBXgUX136bxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grz+0Mh3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X7CZOyXG6xCsS25p93OCgGL3CKwaUM6KdPuUn2c9nUM=;
	b=grz+0Mh3e56Si5ouaqrxkMxmyng77uo5ipxXsfhASx0rIv9Rsu67yGKkivpnbh2WTwFpxc
	lgE8e9PJi2A0/klWddQyJ0y3sguscsIj6s8DmCuAcIWXkz9WX/cQ2bJdICW3sigQPSuuW9
	12wU+apPehF8hRNXaXWb+elG52xTwGQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-F2P-j2oBNnyNfOk3U04lOg-1; Fri, 16 Feb 2024 10:28:51 -0500
X-MC-Unique: F2P-j2oBNnyNfOk3U04lOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04472863721;
	Fri, 16 Feb 2024 15:28:51 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89C3F1C060B1;
	Fri, 16 Feb 2024 15:28:50 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC 6/7] selftests: openvswitch: insert module when running the tests
Date: Fri, 16 Feb 2024 10:28:45 -0500
Message-ID: <20240216152846.1850120-7-aconole@redhat.com>
In-Reply-To: <20240216152846.1850120-1-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The openvswitch tests do not attempt to insert the openvswitch module
automatically.  Now the test will auto load the module and try to
unload it at the end.  The test harness includes the option to not
load the module, which is helpful when developing changes and loading
the module from a different location.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../testing/selftests/net/openvswitch/openvswitch.sh  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a2c106104fb8..e7c9b4fc5591 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -672,12 +672,14 @@ run_test() {
 exitcode=0
 desc=0
 all_skipped=true
+LOAD_MOD=yes
 
 while getopts :pvt o
 do
 	case $o in
 	p) PAUSE_ON_FAIL=yes;;
 	v) VERBOSE=1;;
+	n) LOAD_MOD=no;;
 	t) if which tcpdump > /dev/null 2>&1; then
 		TRACING=1
 	   else
@@ -697,6 +699,10 @@ for arg do
 	command -v > /dev/null "test_${arg}" || { echo "=== Test ${arg} not found"; usage; }
 done
 
+if [ "$LOAD_MOD" == "yes" ]; then
+	modprobe openvswitch
+fi
+
 name=""
 desc=""
 for t in ${tests}; do
@@ -716,4 +722,9 @@ for t in ${tests}; do
 	desc=""
 done
 
+
+if [ "$LOAD_MOD" == "yes" ]; then
+	modprobe -r openvswitch
+fi
+
 exit ${exitcode}
-- 
2.41.0


