Return-Path: <netdev+bounces-69575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA7184BB6F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3D6285226
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D614A15;
	Tue,  6 Feb 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmAFPAMj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7B6FAF
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238403; cv=none; b=UVMKFRIxeVQbdeMjC+44gFk1uuJ8n1quDxmJV/f6tlwVF72q/a+qn11FeZh8cRaWnaHRWjJ09W0Pkfa7/vLVLm7+R6njEiSGDKSGTNsFPxNAi7nLyw0XlX1DnqDFL7XGEcDUPJlWrtrmzdVaOGVlXTA1xDtfn/YhPK8OXncJ+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238403; c=relaxed/simple;
	bh=BktSnF3QkHIRZpJkexpTXo46uV/IzfEDVeyJDmFlnMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuyTc+efLC26aYpyPI5TQ4GEaLDqsS7nMppCwiFOd6Is9nvoltnkgqcYHwedGDGWdnkdW2h6000H24bUrjlB1mT5E/ufi/LEp8mpdkGSBV09chJNFHwBt6FuxBy2rVwYWrMSQkWCIsYTM0yMYszny4HS5mFa58p3zck3dpCWGlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmAFPAMj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707238401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVrV6jjNqjmL7vCzt5Nh5PhJeRsy19TqTBtOPWNXh58=;
	b=bmAFPAMjeJwXrGwJonkERPwfOFoYgqrCW3oaYm6BjT+ZhlN0vgyI2dXhocu0DDeGETyu/A
	PN6OH7Ws9R5yZARthCErjFwcx68vpPLuprfKHGj39BxSenSWRyYSwGV94ydbCone4/t0Rz
	cw1j1hMBXk5IhNCmBJlpq7ElxMrVE1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-NIal2_oLPnmdrAkLqewgVA-1; Tue, 06 Feb 2024 11:53:16 -0500
X-MC-Unique: NIal2_oLPnmdrAkLqewgVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FDEB83B7E5;
	Tue,  6 Feb 2024 16:53:16 +0000 (UTC)
Received: from dev.redhat.com (unknown [10.22.8.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C20A1C060AF;
	Tue,  6 Feb 2024 16:53:16 +0000 (UTC)
From: Stephen Gallagher <sgallagh@redhat.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@kernel.org,
	Stephen Gallagher <sgallagh@redhat.com>,
	Andrea Claudi <aclaudi@redhat.com>
Subject: [PATCH] iproute2: fix type incompatibility in ifstat.c
Date: Tue,  6 Feb 2024 11:52:34 -0500
Message-ID: <20240206165246.875567-2-sgallagh@redhat.com>
In-Reply-To: <20240206165246.875567-1-sgallagh@redhat.com>
References: <20240206142213.777317-1-sgallagh@redhat.com>
 <20240206165246.875567-1-sgallagh@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
type, however it is defined as __u64. This works by coincidence on many
systems, however on ppc64le, __u64 is a long unsigned.

This patch makes the type definition consistent with all of the places
where it is accessed.

Fixes: 5a52102b7c8f ("ifstat: Add extended statistics to ifstat")

Reviewed-by: Andrea Claudi <aclaudi@redhat.com>

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


