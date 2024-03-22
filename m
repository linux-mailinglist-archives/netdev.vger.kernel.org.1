Return-Path: <netdev+bounces-81243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149BE886B81
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93FBB213DA
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700713F9CB;
	Fri, 22 Mar 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI8ksgjZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D843FB94
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108118; cv=none; b=pQMxbpQzkhegG/5n27B3GzMBamfqs+jIPkJRY9WW/Xo5UfMX1Hk6dEtJat2atXE3jYSQ6OhZrDlU3pcnJRZAZEe4K3wfsufISkpJWPYoW/EBlQ2WOXo/3/GFmlMMCsWr+aNIr2T53481ZiaCXKfwTxFB4vH/2ZuMzeJQQCNbYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108118; c=relaxed/simple;
	bh=8XihaJZGKHIgJT9BDZw23QcPPsWUy7RkxqNYtoJFcDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qz0AsAPP5ZXrkpk56b0UJR9qRC8Yxu2tJAdciHNDy+9Omza7SwfjxqHyQhKgvoe/9NFisYHChxJ8TXP3g1OU8rJDA7RQKDf9V7msx57kWDjlktjG7wL7/kLhAqgyTYFxL2ZLs3hfA09+p9cy2fmh28abfMSv+rqAF1U+/wYzg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aI8ksgjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711108115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A9NsddZ7Cp7S7HOLKILZgfGRo3Q+5hj4fkGcUL+CK4Q=;
	b=aI8ksgjZV8wEDdDKKW2iGpkFwmdHXHDrv6lOb5bHsP+DdPc8rJGXtoHcvV2Ie4a8HFSMi1
	YLnzM1MDq+reQliwPwK/yfeEGpdM1WAJSzwjIrTBLKoBN2iTO08gd0NsnA7n0AAGP4/ZIt
	vENvY7gD4KC/+Xbn1dfgQWZGTXjaM4M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-Zgj7E0WpMPKh2VZ6O1yzSg-1; Fri,
 22 Mar 2024 07:48:32 -0400
X-MC-Unique: Zgj7E0WpMPKh2VZ6O1yzSg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C87C83C000AF;
	Fri, 22 Mar 2024 11:48:31 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E73D7492BCA;
	Fri, 22 Mar 2024 11:48:28 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH net v1] dpll: indent DPLL option type by a tab
Date: Fri, 22 Mar 2024 17:18:19 +0530
Message-ID: <20240322114819.1801795-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Prasad Pandit <pjp@fedoraproject.org>

Indent config option type by a tab. It helps Kconfig parsers
to read file without error.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/dpll/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v1:
  - Add Fixes tag and specify -net tree in the subject.
v0: https://lore.kernel.org/netdev/CAE8KmOx9-BgbOxV6-wDRz2XUasEzp2krqMPbVYYZbav+8dCtBw@mail.gmail.com/T/#t

diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index a4cae73f20d3..20607ed54243 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -4,4 +4,4 @@
 #
 
 config DPLL
-  bool
+	bool
-- 
2.44.0


