Return-Path: <netdev+bounces-68170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBF9846038
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 19:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68571B28E48
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5C84FB3;
	Thu,  1 Feb 2024 18:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ku/MZjQ/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D484FC3
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812995; cv=none; b=r80zFYfYbeM6sD7KyKSmZc36ACyQdQ2swIgQrKmy5/qWmLAj1I7rSHfjLJHWS1NXOKGVn4twvlbjWD68qEJYzlxOjQ4RIB8kAOa68BSz6gt23bY0Qfj61ZpKdl829vmEwRnVD6OEwZGxdlNx+vOT+u08ZR0v7HJvePV1G55f5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812995; c=relaxed/simple;
	bh=/U3++LNgHNq5LoSfa03kHjmpVY/55mZ0Wq4o9X3+CQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC1FHea57ZES84Fc5DnNDD6vOZpZjJBxtorkhDv8eB+IewvC7zoAhP76jCKPeOUgVXAT3Ts8cd3coe/A3XvvMvPqyscgkmFB3OMcwJcp28HHpDGyTYCrRYw5fa0IY3RFvQZ2YVcLjAjnqQBpJQT5PgoODpItvW7lPsUQXTAsdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ku/MZjQ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706812992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFXJQBZcC1NUjddVG97YNlr9vxCb4Zf6zNEjvTg+J5M=;
	b=Ku/MZjQ/LycNA5ld+BD+Hw/GRjsCmuDcpksHPxK9I9oswXq2Jgix4DX7v6RoXFx2otYi5L
	c32uiXEF1vn6PwIcmiar3l9z9vZ6S8011enW2q3p21J69qtUbFkdDa+4vqvzN87Bz6njZD
	nIz4SbH50Nz4QRhFkE/L1ylFhFxaDgo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-nWJ6iJ3sOnO9xAzAKGkahg-1; Thu, 01 Feb 2024 13:43:11 -0500
X-MC-Unique: nWJ6iJ3sOnO9xAzAKGkahg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 918DE1064C64;
	Thu,  1 Feb 2024 18:43:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E2AF1111FA;
	Thu,  1 Feb 2024 18:43:07 +0000 (UTC)
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
Subject: [PATCH v2 net 2/4] selftests: net: fix setup_ns usage in rtnetlink.sh
Date: Thu,  1 Feb 2024 19:42:39 +0100
Message-ID: <6e7c937c8ff73ca52a21a4a536a13a76ec0173a8.1706812005.git.pabeni@redhat.com>
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

The setup_ns helper marks the testns global variable as
readonly. Later attempts to set such variable are unsuccessful,
causing a couple test failures.

Avoid completely the variable re-initialization and let the
function access the global value.

Fixes: ("selftests: rtnetlink: use setup_ns in bonding test")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 4667d74579d1..874a2952aa8e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -440,7 +440,6 @@ kci_test_encap_vxlan()
 	local ret=0
 	vxlan="test-vxlan0"
 	vlan="test-vlan0"
-	testns="$1"
 	run_cmd ip -netns "$testns" link add "$vxlan" type vxlan id 42 group 239.1.1.1 \
 		dev "$devdummy" dstport 4789
 	if [ $? -ne 0 ]; then
@@ -485,7 +484,6 @@ kci_test_encap_fou()
 {
 	local ret=0
 	name="test-fou"
-	testns="$1"
 	run_cmd_grep 'Usage: ip fou' ip fou help
 	if [ $? -ne 0 ];then
 		end_test "SKIP: fou: iproute2 too old"
@@ -526,8 +524,8 @@ kci_test_encap()
 	run_cmd ip -netns "$testns" link set lo up
 	run_cmd ip -netns "$testns" link add name "$devdummy" type dummy
 	run_cmd ip -netns "$testns" link set "$devdummy" up
-	run_cmd kci_test_encap_vxlan "$testns"
-	run_cmd kci_test_encap_fou "$testns"
+	run_cmd kci_test_encap_vxlan
+	run_cmd kci_test_encap_fou
 
 	ip netns del "$testns"
 	return $ret
-- 
2.43.0


