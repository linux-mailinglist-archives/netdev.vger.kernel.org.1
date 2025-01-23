Return-Path: <netdev+bounces-160506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B4A19FFB
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 09:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BDC7A3273
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22A820C008;
	Thu, 23 Jan 2025 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPWoMCH4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609E20C010
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621400; cv=none; b=CLfbRyrua2+JRAUx2prmulQSFDQDEUDlQPzr48SdQjYqygikt6T0D5OA0rSWHgvdU+904oGxMntYviJV1fEBgVSvpqlbKd9N+qCBKJfmpHzMJBinxSP4KyI39Y9RZwh4SDSZAOR+MKdKngkDuUA2EcEfJQLxaQYkQJce5PyYNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621400; c=relaxed/simple;
	bh=tPDXxQmFO3rFL3PwHMqD4NyKg88jquh3GkuYyRPqN/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=mPcrPuW5Da4STnvDb30iHUAT9oX4G+DNOFVyMOKkjxRW4o7H+cQXvB9VWBA7+CmwtrzEfInOT3XT9/HsL3fqOft631Q7ASiFaJGZ1LI5ek/higsQFJioXrl+3RQK7ekoVPw/+h4r9g0SADBSKIfhoZvdT0rgFpxaQKpOaB11NUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPWoMCH4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737621398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U9ex3Sx0fENYs3g5O+SN/OczFe9ryb1KuaGlSbCbQ7I=;
	b=WPWoMCH4ZKsOMKfOpF+g8e8n03CtmHOP5sCU1qsJI47u+0oh0VJ2Otkeq6WgsgLcJSMftl
	mpJ6PIpX9N0aLtwxskqZs5JDcvFNfvksRgUJn5GXtTYODFtjYl5tXCuYCRqu2khGUp6fBK
	91l9j6lkawD52avS35NLUdoNQ8exhXo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-DjiGA2y8OJGldjzScybEVA-1; Thu,
 23 Jan 2025 03:36:32 -0500
X-MC-Unique: DjiGA2y8OJGldjzScybEVA-1
X-Mimecast-MFC-AGG-ID: DjiGA2y8OJGldjzScybEVA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F3641955DC0;
	Thu, 23 Jan 2025 08:36:30 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 043451955F1B;
	Thu, 23 Jan 2025 08:36:27 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	eliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	haliu@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: mptcp: extend CFLAGS to keep options from environment
Date: Thu, 23 Jan 2025 09:35:42 +0100
Message-ID: <7abc701da9df39c2d6cd15bc3cf9e6cee445cb96.1737621162.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Package build environments like Fedora rpmbuild introduced hardening
options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
and LDFLAGS.

mptcp Makefile currently overrides CFLAGS but not LDFLAGS, which leads
to a mismatch and build failure, for example:
  make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/mptcp/mptcp_sockopt] Error 1
  /usr/bin/ld: /tmp/ccqyMVdb.o: relocation R_X86_64_32 against `.rodata.str1.8' can not be used when making a PIE object; recompile with -fPIE
  /usr/bin/ld: failed to set dynamic section sizes: bad value
  collect2: error: ld returned 1 exit status

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/testing/selftests/net/mptcp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 8e3fc05a5397..9706bc73809f 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 
 top_srcdir = ../../../../..
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
-- 
2.43.0


