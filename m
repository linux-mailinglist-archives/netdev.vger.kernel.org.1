Return-Path: <netdev+bounces-69494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E0084B7A3
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB81C1F22BF4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75243131E55;
	Tue,  6 Feb 2024 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Phb8EEk8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1A13172E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229216; cv=none; b=phk4ihTsx/m726iQZjgkAlwSIX6Hz1A9LbvoCAj2G2MGQih5OozZmPpvVOZC8depBfxfsSHFlmCc3lwomqGCEH7i2tWmd33RhkIk5KvU63iZ3WZLx078XnK8EoYnAUwuLPeOo7gBv8gED9ESb1K1Q2NGR+XIK5qdMzCY64AE0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229216; c=relaxed/simple;
	bh=1d+EQeI7ZRJejmJelMH/afAGSNnfgVWs/QGeMw7wlxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkZERUD/HXtDai0lBkg5mPMoyATAK00JxTrvAgyI6Iu2Yf8NUCYcP2j9kMqmbffQw4n5OYsYYHdFc74IN5QVR1ONjMPJNHBDs+SWuDMhHDNK6fG/6n2DiPRqRVuxt8VDgNuC8LanWDcfuC5YsA4/A0evqkazlVdsUi16eQxRPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Phb8EEk8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707229213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8V5/ZF2pQRxInlm+8vcoORP65KVQFSUe+GcgFA0pcLE=;
	b=Phb8EEk8Tx6x+z2aRUPpr79v3TBvuaJPQzkjsVUuYAut0a7Ke2V6C93TUOmzACCMwut3/0
	ONqcJYRS/cPpBv/pghgvqh6VCsVDxhbfp/gz/kGow1jozvH9XrwM6xx+dF+FiuOS//iFmQ
	qzBXfC3XGdUyTKWkQHxC9+EviNM/FKI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-oHIkm--EORGrCMed5XWODQ-1; Tue,
 06 Feb 2024 09:20:10 -0500
X-MC-Unique: oHIkm--EORGrCMed5XWODQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9344C1C06913
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:20:09 +0000 (UTC)
Received: from dev.redhat.com (unknown [10.22.8.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 738ED1121312;
	Tue,  6 Feb 2024 14:20:09 +0000 (UTC)
From: Stephen Gallagher <sgallagh@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Gallagher <sgallagh@redhat.com>
Subject: [PATCH] ifstat.c: fix type incompatibility
Date: Tue,  6 Feb 2024 09:18:54 -0500
Message-ID: <20240206141944.774917-1-sgallagh@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
type, however it is defined as __u64. This works by coincidence on many
systems, however on ppc64le, __u64 is a long unsigned.

This patch makes the type definition consistent with all of the places
where it is accessed.

Signed-off-by: Stephen Gallagher <sgallagh@redhat.com>
---
 misc/ifstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 721f4914..767cedd4 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -58,7 +58,7 @@ struct ifstat_ent {
 	struct ifstat_ent	*next;
 	char			*name;
 	int			ifindex;
-	__u64			val[MAXS];
+	unsigned long long	val[MAXS];
 	double			rate[MAXS];
 	__u32			ival[MAXS];
 };
-- 
2.43.0


