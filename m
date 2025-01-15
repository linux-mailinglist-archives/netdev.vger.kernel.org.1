Return-Path: <netdev+bounces-158449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A40A11EAA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E027D1888F1C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5F91D5143;
	Wed, 15 Jan 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iov1AqzO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53670248166
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934993; cv=none; b=LXIJQ++LSglHAQVZ3kX3oPLikifiNhCWb/5qLB8Rm3BoUYcUMfrCVXspehHJT4BZBRUAI4mUr/XmNby1zeDalNRMuSoIRcg08BtesEawsNHIrrVQ+g4B2oMCx/HwxsvfGMccKoEienyX1bixUQw3ONKgNAOi51Z0UzfiZmDdUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934993; c=relaxed/simple;
	bh=RrmHwxdmY6KSKkvwonimaM3ge3oJIEDwoyqLpVemCpc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FR0KGBVxnfOPltIy2U+tGzIMksliKHbjdPnkI+hUhvyt/7JiyErmaMf2Wvm+ZvMUe6wuhs1cmUTehAABnZb0P5yubZDzOrE9f4A3xk8ykQpOkWILJDEJVLerJOkbtzCcpiNftT6Do7OZv+3T7vFM7rUz+l6s9AWslCs3rtCzLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iov1AqzO; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736934993; x=1768470993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wOIX9QtFMh4/TUrVG69iuhusfHSmX60+jRsqtdD5e1A=;
  b=iov1AqzOqyjB0Iz4aA9ywu8SSTyJAH0b8givdIt0Y4xvPUKj8SIvu27U
   D13+727CYStCPKl6AeRK5qewzmTeGj1xpND1vW/0fVgkauFYGORGiHy/x
   PiwdNfIJv9Fk74beubfXe737HCwjLCT3o6bPO+0nR3c/BKXFQaqoCasZu
   M=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="263217104"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:56:29 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:44952]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.180:2525] with esmtp (Farcaster)
 id 067d9572-6a29-4c0e-86b0-cde736e05c38; Wed, 15 Jan 2025 09:56:28 +0000 (UTC)
X-Farcaster-Flow-ID: 067d9572-6a29-4c0e-86b0-cde736e05c38
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:56:28 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.2.246) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:56:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/3] dev: Acquire netdev_rename_lock before restoring dev->name in dev_change_name().
Date: Wed, 15 Jan 2025 18:55:43 +0900
Message-ID: <20250115095545.52709-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115095545.52709-1-kuniyu@amazon.com>
References: <20250115095545.52709-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The cited commit forgot to add netdev_rename_lock in one of the
error paths in dev_change_name().

Let's hold netdev_rename_lock before restoring the old dev->name.

Fixes: 0840556e5a3a ("net: Protect dev->name by seqlock.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index fda4e1039bf0..0237687d4a41 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1277,7 +1277,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
 rollback:
 	ret = device_rename(&dev->dev, dev->name);
 	if (ret) {
+		write_seqlock_bh(&netdev_rename_lock);
 		memcpy(dev->name, oldname, IFNAMSIZ);
+		write_sequnlock_bh(&netdev_rename_lock);
 		WRITE_ONCE(dev->name_assign_type, old_assign_type);
 		up_write(&devnet_rename_sem);
 		return ret;
-- 
2.39.5 (Apple Git-154)


