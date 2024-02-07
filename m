Return-Path: <netdev+bounces-69759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D684C7C7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA691B2408A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 09:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F0820B14;
	Wed,  7 Feb 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzZuLRIk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FC25561
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298989; cv=none; b=LCcgiSSpi6wWr2cnA+jTDlcqVsl2/sODQzp5BHXfBf8x0Aw8pkYvqJcqsaCTwYlv4/XmggwU284O5gpgVjI02p2qQ3T2iTVz2JEl9D3ac+thKnQPXAGhtgd5C1gysY8/6LxZQNlj/ZCDnc+EP4gIMF5LStzk+6lm3K7OKErR0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298989; c=relaxed/simple;
	bh=Un9dSswqhy5BvcgN+CICgEU+zyHY4nOPH1heqk252iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIKITPVDCoi/4LYnry1rESGHjqQgOeNyW8BZzokitu4FJdJzt5JAJtJrWiIZmWt9McI7sSdWkLzXzZE+l6hI9eTno7YTYJCc13/qIEAa5qpzazs0ulDj9qzFNOAyqmAn9yYTLlo2fmJ1jrs4WnD5C5+8PPEZfmLhiVeEbxuMzTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzZuLRIk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707298987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=62ePsh182eryxOt7CDUqfSF+zfi9BMgTVxVNtxqYx1E=;
	b=gzZuLRIkVPjTkzG7CkhaPsijtY1hbZwuMLevz98L2WLzEOYRVfw+W6voD5v2itvVsTGCa/
	sb1GIRxC9j0oWwbD905gMXsw9G7ogq0zt7qj/Ss0r9Ko3xOuv187cBp7k/T5Xx6J2QeGfE
	qDLOtcQ4SGbCfOPhEEkaBF+EIiGrp3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-magBBZuvNg2-gRq0st-rEA-1; Wed, 07 Feb 2024 04:43:03 -0500
X-MC-Unique: magBBZuvNg2-gRq0st-rEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F76A8493F1;
	Wed,  7 Feb 2024 09:43:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 041E22026D06;
	Wed,  7 Feb 2024 09:42:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: include forwarding lib
Date: Wed,  7 Feb 2024 10:42:45 +0100
Message-ID: <f7b1e9d468224cbc136d304362315499fe39848f.1707298927.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The altnames test uses the forwarding/lib.sh and that dependency
currently causes failures when running the test after install:

  make -C tools/testing/selftests/ TARGETS=net install
  ./tools/testing/selftests/kselftest_install/run_kselftest.sh \
      -t net:altnames.sh
  # ...
  # ./altnames.sh: line 8: ./forwarding/lib.sh: No such file or directory
  # RTNETLINK answers: Operation not permitted
  # ./altnames.sh: line 73: tests_run: command not found
  # ./altnames.sh: line 65: pre_cleanup: command not found

Address the issue leveraging the TEST_INCLUDES infrastructure
provided by commit 2a0683be5b4c ("selftests: Introduce Makefile variable
to list shared bash scripts")

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 211753756bde..7b6918d5f4af 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -97,6 +97,8 @@ TEST_PROGS += vlan_hw_filter.sh
 TEST_FILES := settings
 TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
 
+TEST_INCLUDES := forwarding/lib.sh
+
 include ../lib.mk
 
 $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
-- 
2.43.0


