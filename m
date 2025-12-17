Return-Path: <netdev+bounces-245207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3FCC89A7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A30C631B7745
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF135295C;
	Wed, 17 Dec 2025 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBb/NMXZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869C35502A
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986360; cv=none; b=RPEf6NkNfl6zOl37mnCmMZrfZA85OV718tnHREqUwobAeXIfjjAa2HeLprNzitQHq9vryvri9A4z3SPJ+dgpzh770NrfUB1QL7Awrp46zZfaiplH50nKaWqgnMYmQ51DLM60pv+gXyDZG5cMZA+RswTyQRfGi89DL1pzDnchZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986360; c=relaxed/simple;
	bh=0Iz1uQv9GcWWAvKRoXZvgrgUntR1DgvLONWYr3e/iXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l50tcCRuLcIaTx+FOEehS/EKVt7CA6Zfn2H/YrIWQ8H9uhpNt8vLwUPrYaXEwCPsVD/TqUi7u6eKRqTEGDFbqoX/p7G8PCgMC/zAezX6z77kAjbPo3/KMbisSqiuzXbztmTRMeRHpDIAZfJCd1rweqN4AuANwYLoIJVONXEkBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBb/NMXZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765986355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zdc3iUOfQAGuyOrTJc+LTuZxqCWzdJKQjJoELQ44Yf8=;
	b=JBb/NMXZARVOcQjetKWlGgFxX//21jO417TAmhFh6txAjEn6kZxEV/05OuV77lCZgM3hHP
	ZJarT60D7RPK1zVc9XevXRSmFpuvF4xroemVWGAXpRHm4RvMoBvmQUg8tqKjwIKfebE4nH
	zNGZMwhs3Qg5FQcD3ojB18VJNR1iqvk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-IUjBdt1CMRa8KGqoASUDFA-1; Wed,
 17 Dec 2025 10:45:53 -0500
X-MC-Unique: IUjBdt1CMRa8KGqoASUDFA-1
X-Mimecast-MFC-AGG-ID: IUjBdt1CMRa8KGqoASUDFA_1765986352
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F280C1955D8E
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 15:45:51 +0000 (UTC)
Received: from dev64.shokupan.com (unknown [10.64.240.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8844C1800367;
	Wed, 17 Dec 2025 15:45:50 +0000 (UTC)
From: Masatake YAMATO <yamato@redhat.com>
To: netdev@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH iproute2 2/2] man: explain rt_tables.d and rt_protos.d directories
Date: Thu, 18 Dec 2025 00:45:47 +0900
Message-ID: <20251217154547.2410768-1-yamato@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 man/man8/ip-route.8.in | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index aafa6d98..d30285a4 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1474,6 +1474,20 @@ ip route add 10.1.1.0/30 nhid 10
 .RS 4
 Adds an ipv4 route using nexthop object with id 10.
 .RE
+
+.SH FILES
+.BR *.conf
+files under
+.BR @SYSCONF_USR_DIR@/rt_tables.d " or " @SYSCONF_ETC_DIR@/rt_tables.d
+are also read in addition to
+.BR @SYSCONF_USR_DIR@/rt_tables " or " @SYSCONF_ETC_DIR@/rt_tables "."
+
+.BR *.conf
+files under
+.BR @SYSCONF_USR_DIR@/rt_protos.d " or " @SYSCONF_ETC_DIR@/rt_protos.d
+are also read in addition to
+.BR @SYSCONF_USR_DIR@/rt_protos " or " @SYSCONF_ETC_DIR@/rt_protos "."
+
 .SH SEE ALSO
 .br
 .BR ip (8)
-- 
2.51.0


