Return-Path: <netdev+bounces-211809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37A9B1BC2F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9CA1887E79
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2FC257AC1;
	Tue,  5 Aug 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZVI/Yup"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40D25A340
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430748; cv=none; b=QsALXP5wzTR9y6HiRxjk+CC7M+CVKhXvjcTUl4ugL5HRiJ4LmsCThaUeuGMI1CiMS/YYPODljSQAKuK1Svfp2aPS+VEuvq0oUc1fXTOB8R/jzGChPL3DVyF64h6yCn8ra4I/A9ywb+DHN+hoR/7iUp3gd1jXS1hbPgtpcppn/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430748; c=relaxed/simple;
	bh=cxw88F86+efxpjCeTqNzsZYFkDz6jHw5LSK433H0MkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/5QbA0L7rPbkWkRR0S8HZoPTjXnMCtgg2JPQBJJJrQdm4N8AuTxz5ytrl428Vroe6Dop+Q3b3xTf66IaD2mTySl9OwqdwiyPqsGqWoFJv4IERDIJ0CIO60wCVTt5fVVo+OVHL8Pn4auIdMz6YGj9KNOm3rc+7kfSHi5TwaPatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZVI/Yup; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754430744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mOWTp40JUk6/kR6ncUSjJf2Ac1g7cYUy+ecjSbiK87o=;
	b=hZVI/YupUHUAmK9OnbjTcyQ9JW3N6eAgjuuvReTmbysSjosgLMtC3lXmf1EU3SFg5dJvuz
	gcYkL8ni2iciSUWYot6D+bp1or9UxFlfiSiI7KlzdZfWx5f9ZZbxeeA9VC3DNwa051KxW8
	JP1246iNhgNMjfxVC6yfHrCqq4Gl7Co=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-I6eEl55WP6uc6oOb1-V2ZA-1; Tue,
 05 Aug 2025 17:52:23 -0400
X-MC-Unique: I6eEl55WP6uc6oOb1-V2ZA-1
X-Mimecast-MFC-AGG-ID: I6eEl55WP6uc6oOb1-V2ZA_1754430742
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24A581955DDD;
	Tue,  5 Aug 2025 21:52:22 +0000 (UTC)
Received: from lima-lima (unknown [10.22.80.60])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62A023000199;
	Tue,  5 Aug 2025 21:52:20 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: netdev@vger.kernel.org
Cc: dechen@redhat.com,
	dchen27@ncsu.edu,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com
Subject: [PATCH net-next 0/3] netdevsim: Add support for ethtool stats and add
Date: Tue,  5 Aug 2025 17:33:53 -0400
Message-ID: <20250805213356.3348348-1-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series adds support for querying standard interface stats and
driver-specific stats with ethtool -S. This allows hardware-independent
testing of ethtool stats reporting. Driver-specific stats are incremented
every 100ms once enabled through a debugfs toggle.

Also adds a selftest for ethtool -S for netdevsim.

The implementation of mock stats is heavily based on the mock L3 stats 
support added by commit 1a6d7ae7d63c45("netdevsim: Introduce support for
L3 offload xstats").

Note: Further replies will come from my school email address,
dchen27@ncsu.edu, as I will soon lose access to my Red Hat email.

Dennis Chen (2):
  netdevsim: Add mock stats for ethtool
  selftests: netdevsim: Add test for ethtool stats

Kamal Heib (1):
  netdevsim: Support ethtool stats

 drivers/net/netdevsim/ethtool.c               | 183 ++++++++++++++++++
 drivers/net/netdevsim/netdev.c                |   1 +
 drivers/net/netdevsim/netdevsim.h             |  11 ++
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../drivers/net/netdevsim/ethtool-common.sh   |  13 ++
 .../drivers/net/netdevsim/ethtool-stats.sh    |  36 ++++
 6 files changed, 245 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/ethtool-stats.sh

-- 
2.50.1


