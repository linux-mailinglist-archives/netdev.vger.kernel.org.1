Return-Path: <netdev+bounces-81225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661CD886AC0
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982641C21B60
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04173219E0;
	Fri, 22 Mar 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz58Sifr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3A3D3B3
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105030; cv=none; b=NgFpuuWIQoVvTUoNH29Tw4BkAl8UN5TJLBcFq5NWvUcP/70ZMnnW50BLoM1xSSsKYzYrLy+srRH4nGFTF/KbbefqhLSVrjRs+1Gwzbb69s9CjlBkpg5fRSUdWqUtzwl8nnJ06TrLtAGteaea+HPM2HWKOLbV377sOaizoelXPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105030; c=relaxed/simple;
	bh=zalAkbUd0X7BvJKA6BZF99cH4JpJuM8dCUa4K/QR1g8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIK9/bcMaaAKXWEFbDC1S+ky6W9G0RrGSE4f5JD19IhkgmEc6O4VFWW6ipOqyaCzVIIt4AA+S5jvqIV8f9hkGclAkNu+NdbGnLKwZKgY2aeajYuFr5Z9j8Mt0O8HeqBERrp4scelLBAgJJVbGJVqQd8zYCsv4P46UXax9471iiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fz58Sifr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711105027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hDIY21dtyIbTRs/dYZUQBjVRUhaLx0aik+OUg9EKKH4=;
	b=fz58SifrTXaMLsGdjP+E+nJlnwRVh7BHEPEkwlj7pkzAnZKo9WBdsn8V7NgKm0mrpe3D+j
	TDsZKXK9Aqny+ZE1Sbfruoha0s7+WBkGwPAry6Czn9dPOmUPI+gN0K3eR77i0FU36PdMW5
	XK9kbwoLW1tBPVFnh48SMF7QUuJdJD8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-snqNIZLRPrKwhhFtns7pTA-1; Fri,
 22 Mar 2024 06:57:03 -0400
X-MC-Unique: snqNIZLRPrKwhhFtns7pTA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88A2D29AC01C;
	Fri, 22 Mar 2024 10:57:03 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E651C492BD0;
	Fri, 22 Mar 2024 10:57:00 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] dpll: indent DPLL option type by a tab
Date: Fri, 22 Mar 2024 16:26:49 +0530
Message-ID: <20240322105649.1798057-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Prasad Pandit <pjp@fedoraproject.org>

Indent config option type by a tab. It helps Kconfig parsers
to read file without error.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 drivers/dpll/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


