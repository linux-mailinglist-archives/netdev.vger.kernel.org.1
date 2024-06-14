Return-Path: <netdev+bounces-103531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96BE908738
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451A428642B
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9301922E9;
	Fri, 14 Jun 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ2ig8dG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D486190680
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356909; cv=none; b=iY5I4ZpzqGjw/WbSI0bjqUooBAe6QRf40AcZF3Svsx2ciNomSoacFxrB8XoEsC2Rl1SbBKHO4UDdWAzfIxpKJzAI+9ML++s01Kjz/x7+Qf7iovuVhdVRdzF8tfIbEYzT9IAYwYYTm9Ybpi9ArytUOFqnDg5puY2dgzjkMhZ4PCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356909; c=relaxed/simple;
	bh=VkxCdpAClS3cU7MXc9s6Wyc3QcnNJhFTIJjOcp0Gm/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ih0H8qzP9IiKYy6AZ+YKFQheEZZ3qj5/KzUofN5IsMDUwR1xmHUzsTW1UvzovM7xAHaa1twDTfHwOlZGnP/fu/GQmsbZgLY8djhUyV6oIWfkEB5JtpXS4XFR5HMmye9TYcHbvVWqKWEHX2JJa5CVgQWA0eghb17wVaSZAZ3hXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQ2ig8dG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718356907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=10FpRQSrbZjz2/aN19u6lQ+Rivr8yevvfebe/6sigeM=;
	b=hQ2ig8dG8q8X6lUcc4Gm7DMkG6j3lYtVKBJNjlDd1Lf4HUEHy2Ur7Gsm1bNErnGn2sCMAv
	1a3Fjjih1fyu0yAdwlV7v64J6pQFNlH7YHCtLJOkWXHEQQhFrDJl5gG2DsATMrs5X+lsvX
	ZfulCBZxI+SuOb+rQct3P7x9+Udks9o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-hNo00CsZOEiVQg0LsLDOKA-1; Fri,
 14 Jun 2024 05:21:43 -0400
X-MC-Unique: hNo00CsZOEiVQg0LsLDOKA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C678119560B1;
	Fri, 14 Jun 2024 09:21:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AE3519560AA;
	Fri, 14 Jun 2024 09:21:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation: Remove the "rhash_entries=" from kernel-parameters.txt
Date: Fri, 14 Jun 2024 11:21:34 +0200
Message-ID: <20240614092134.563082-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

"rhash_entries" belonged to the routing cache that has been removed in
commit 89aef8921bfb ("ipv4: Delete routing cache.").

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 756ac1e22813..87d5bee924fe 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5781,9 +5781,6 @@
 		2	The "airplane mode" button toggles between everything
 			blocked and everything unblocked.
 
-	rhash_entries=	[KNL,NET]
-			Set number of hash buckets for route cache
-
 	ring3mwait=disable
 			[KNL] Disable ring 3 MONITOR/MWAIT feature on supported
 			CPUs.
-- 
2.45.2


