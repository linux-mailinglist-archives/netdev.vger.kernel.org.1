Return-Path: <netdev+bounces-209953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97CBB11739
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 05:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC73C1C288D7
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 03:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D880239E7E;
	Fri, 25 Jul 2025 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAxUErDJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14A230BD2
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753415447; cv=none; b=IQGjSga18D0nmKfigFulzjRr2kkMswBb8mcGCl3ozfucSCNonBBH+HYAfIM3u9/4MJJjkOh7ksaSUT2TUKYIZENii8MqgMnZC7o9bIS2InoKr5YkU+TSrdcMNg4e0YTU6CVRBN9kR8oUp0TzPTvnuXV0H9w6KUGKZknNdE8P1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753415447; c=relaxed/simple;
	bh=fCJxRZ/FM2eScA1Yqd4ouGWZ0gc+qVaV9V8SgiiE5SY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agY4EHSB9Lh8awt57czNXhDa+0x0FRpRgpL8AdXOSCiW/bwi+ETmm+l5PvimjyybUjBzSMJrOhmd60ieHHIsnm78KY4VTsKpSHWDYnn/AzQgmz4sCzj+fKsP6vp8a251kiikyCzmtQ0B1UbJK4tGX446RzVtfkjflvDTnt6jArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAxUErDJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753415444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CDqOduZNxWnbZSoqqq7n2RgVln6pLZG+oZF2xiPbDm4=;
	b=SAxUErDJWyILfCI8nyigBAECRgB/MRhslc3OdC88CsvpiwGoHjsZ30HpTMtS3kvV/LiBYB
	cS6AS25UaTd9g+By9t9KbdV3Kx1KqM3ODUGr5o82KBBuEh0olCX2RnuIKJcKmW2GOIJGpF
	8iaNticAa6/TyrUdVTp5fjRwbGWZExA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-44yUy-CnNj-BSbuackteyg-1; Thu,
 24 Jul 2025 23:50:40 -0400
X-MC-Unique: 44yUy-CnNj-BSbuackteyg-1
X-Mimecast-MFC-AGG-ID: 44yUy-CnNj-BSbuackteyg_1753415438
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 637E51956087;
	Fri, 25 Jul 2025 03:50:38 +0000 (UTC)
Received: from xmu-thinkpadx1carbon3rd.raycom.csb (unknown [10.72.120.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D965D195608D;
	Fri, 25 Jul 2025 03:50:31 +0000 (UTC)
From: Xiumei Mu <xmu@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Long Xin <lxin@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <sln@onemain.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net v2] selftests: rtnetlink.sh: remove esp4_offload after test
Date: Fri, 25 Jul 2025 11:50:28 +0800
Message-ID: <6d3a1d777c4de4eb0ca94ced9e77be8d48c5b12f.1753415428.git.xmu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The esp4_offload module, loaded during IPsec offload tests, should
be reset to its default settings after testing.
Otherwise, leaving it enabled could unintentionally affect subsequence
test cases by keeping offload active.

Without this fix:
$ lsmod | grep offload; ./rtnetlink.sh -t kci_test_ipsec_offload ; lsmod | grep offload;
PASS: ipsec_offload
esp4_offload           12288  0
esp4                   32768  1 esp4_offload

With this fix:
$ lsmod | grep offload; ./rtnetlink.sh -t kci_test_ipsec_offload ; lsmod | grep offload;
PASS: ipsec_offload

Fixes: 2766a11161cc ("selftests: rtnetlink: add ipsec offload API test")
Signed-off-by: Xiumei Mu <xmu@redhat.com>
Reviewed-by: Shannon Nelson <sln@onemain.com>
---
Changes in v2:
- add test results in description
- Enhanced logic for rmmod esp4_offload
- fix shellcheck warning: SC2086 (The quoting issue)
---
---
 tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..d2298da320a6 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -673,6 +673,11 @@ kci_test_ipsec_offload()
 	sysfsf=$sysfsd/ipsec
 	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
 	probed=false
+	esp4_offload_probed_default=false
+
+	if lsmod | grep -q esp4_offload; then
+		esp4_offload_probed_default=true
+	fi
 
 	if ! mount | grep -q debugfs; then
 		mount -t debugfs none /sys/kernel/debug/ &> /dev/null
@@ -766,6 +771,7 @@ EOF
 	fi
 
 	# clean up any leftovers
+	! "$esp4_offload_probed_default" && lsmod | grep -q esp4_offload && rmmod esp4_offload
 	echo 0 > /sys/bus/netdevsim/del_device
 	$probed && rmmod netdevsim
 
-- 
2.50.1


