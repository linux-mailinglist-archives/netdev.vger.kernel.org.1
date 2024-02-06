Return-Path: <netdev+bounces-69495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ADC84B7B4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1289A28A573
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4D132466;
	Tue,  6 Feb 2024 14:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYSV7j/V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4CD131E55
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229344; cv=none; b=BuNahh/A+lTMCs7SV6KguR/GJMPwvxOaTpqpOTLsYmhluIDVRvy24SZUqPQZum9fj+lcYAFRwwmOIUvMB9CqPrjbA18oVxJUAiHInOAbQ8oKutYK0aqL/JS0sH9XaJPCgAI6ovQOB8CeeIGGxIah1O5bBJCH8kht7u9pbrIJSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229344; c=relaxed/simple;
	bh=1d+EQeI7ZRJejmJelMH/afAGSNnfgVWs/QGeMw7wlxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKSg77IQnWqY7Vr22npzcYh2oTbCUvDKI3y8dUbV7QUJDYK9yShQUqqMeApPzVeXj9lRguamjH0L4RB6NpLGcagCdPcuq83j2G0deJAisZc1PqpI4AcXEqKfGAN1YNbPcrLIVLFgX5ohIH/Gwxlm3/N9NRbwQrf1qnvFKrqWJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYSV7j/V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707229341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8V5/ZF2pQRxInlm+8vcoORP65KVQFSUe+GcgFA0pcLE=;
	b=AYSV7j/V1bCemwkLx7ZXCexCfna5hJsCRiQjZV3KzE48SCgfUr21J405J5RBEbJjfAASGM
	nXLGU1D0rARYQgWii5PkLzoTA0SD07rgEo80llq7yR7i0jQdwqMxm03jCSOrF9pebAWKvK
	8L0cIRq3ZqDkg3RWs+BVP2yI+aCAN/c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-Kftf1KD3M42edJv78Djztw-1; Tue,
 06 Feb 2024 09:22:20 -0500
X-MC-Unique: Kftf1KD3M42edJv78Djztw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B15E2280C29B
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:22:19 +0000 (UTC)
Received: from dev.redhat.com (unknown [10.22.8.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91C77400D6D2;
	Tue,  6 Feb 2024 14:22:19 +0000 (UTC)
From: Stephen Gallagher <sgallagh@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Gallagher <sgallagh@redhat.com>
Subject: [PATCH] iproute2: fix type incompatibility in ifstat.c
Date: Tue,  6 Feb 2024 09:22:06 -0500
Message-ID: <20240206142213.777317-1-sgallagh@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

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


