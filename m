Return-Path: <netdev+bounces-245206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E50CC8A04
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD143178DFC
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993833570AF;
	Wed, 17 Dec 2025 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLgC2xmb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C635505D
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986260; cv=none; b=an3dB3oVETb6VY/4Yu0AVwxVNB3OkNgzYAlCzXF+U5jWpKWLz6rJC1J/ALQdXve/n/OuPwjHfIKla3Vrlk/KFHRA38R518TtK4avJbUWsoeBdqto+RdGW/6N6GHn4lD3ygqH0X5LAoAXP3M+m+CJsXs8OCc2IlGIGNGxfVkloWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986260; c=relaxed/simple;
	bh=GRw3k37jzZigcwcP/ph2YPqgDHd5l8rSTChmEXFVsjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCg6jtBXCdEY8L7KCKub3bm6jpxTauGB4mA8nG/oWn404pmUoWm4Vb2j06M19DaFqoCWxXuJtDTwUUtM/sFLAk7SzmDhAnjij3WbXIR9reE63n7Q86tGrFOkHqqPXSXCRJXoa9PrH7O9IrIRr+/urJYptRDRvKM3L43z2UF2vRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLgC2xmb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765986257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qe7gu7rkTT6RSV7820IncIBCE7lirH9igpBFZqT8LW4=;
	b=fLgC2xmb85zQ+/9ckEzGzWfjXaNVAwoNfLl89EKAsuvhUn7aUpf+wsXd4DqzLjEZ+o2FLg
	3Ex9PchMhqzlGH7ivRRX0cFkZBrxxFGyhbfgxr++iZt0qwV3dOZQ9eL/nVQFdR4rLaruvV
	jC3GT0qIFqQbHlr+LGHzbHXpl1BQSOo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-1zCJbMOvPWejgYXap53Q3g-1; Wed,
 17 Dec 2025 10:44:15 -0500
X-MC-Unique: 1zCJbMOvPWejgYXap53Q3g-1
X-Mimecast-MFC-AGG-ID: 1zCJbMOvPWejgYXap53Q3g_1765986255
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0721A1958FC7
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 15:44:15 +0000 (UTC)
Received: from dev64.shokupan.com (unknown [10.64.240.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88D8A19560B4;
	Wed, 17 Dec 2025 15:44:13 +0000 (UTC)
From: Masatake YAMATO <yamato@redhat.com>
To: netdev@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH iproute2 1/2] man: explain the naming convention of files under .d dir
Date: Thu, 18 Dec 2025 00:43:53 +0900
Message-ID: <20251217154354.2410098-1-yamato@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 man/man8/ip-address.8.in | 7 +++++++
 man/man8/ip-link.8.in    | 7 +++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index 79942c1a..e88a114f 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -331,6 +331,13 @@ values have a fixed interpretation. Namely:
 The rest of the values are not reserved and the administrator is free
 to assign (or not to assign) protocol tags.
 
+When scanning
+.BR rt_addrprotos.d
+directory, only files ending
+.BR .conf
+are considered.
+Files beginning with a dot are ignored.
+
 .SS ip address delete - delete protocol address
 .B Arguments:
 coincide with the arguments of
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index ef45fe08..67f9e2f0 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -2315,8 +2315,11 @@ down on the switch port.
 .BR "protodown_reason PREASON on " or " off"
 set
 .B PROTODOWN
-reasons on the device. protodown reason bit names can be enumerated under
-/etc/iproute2/protodown_reasons.d/. possible reasons bits 0-31
+reasons on the device. protodown reason bit names can be enumerated in the
+.BR *.conf
+files under
+.BR @SYSCONF_USR_DIR@/protodown_reasons.d " or " @SYSCONF_ETC_DIR@/protodown_reasons.d "."
+possible reasons bits 0-31
 
 .TP
 .BR "dynamic on " or " dynamic off"
-- 
2.51.0


