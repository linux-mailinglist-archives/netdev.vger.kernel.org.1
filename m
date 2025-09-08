Return-Path: <netdev+bounces-220749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16509B48795
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C77C189FAC1
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E82EC0AA;
	Mon,  8 Sep 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRSq76JS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C92EC0AD
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757321609; cv=none; b=LAg6Y5ZjvqCAf/f+YIjnoja6TJyW8vDnlmB62JFV9kdT/jbvWsOXeMMbYk9LSPKzgOJyxZI7N8RJe6YbLd8WOvYOv2vo87Q1AUxsqjSumDx6stfNnLS8a/z/SWPyEdNmGWI/mVDPFyKZNDbgGYm2XWhawMBFhKIhJQ5iY5O6KIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757321609; c=relaxed/simple;
	bh=VYcalhrmZ0ou8kR3V/P6aDv9WAaUsx1h4gfExu5ZwTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jMqojXW8jvp7S1ITjqUANK6h71ZFfutFZ8XXVGyHAv5ICdyQeg+oucH1bbKbS3xakaVLF9v4FHNbqU2kDxB2cSIALkT2RFAuGLV42SaOMiapOvvBlggBz6eo0OI8bsVf+YFkuC2E4PHzCTpZ6oZnJziU1am4klffhFdFb7RaooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRSq76JS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757321607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s+XlcET2nSPe+3w1n07l6XtTiMae7xEcZ2qEeRqgat8=;
	b=RRSq76JS1Mk6U5wWGQaZDmV2z8J0fg2D8Au+djJxx5mHAKG0q7jR+2hhMiLKpv8k6hMfbe
	hL+uUGxWkQ+Bbx/TJQRZADQ0C1+SdgQaRYJK4H0MZu3h1XrxEL15FthJnheaNW9dADLNzy
	aGgPxdHESN69VkKwPlY1exnR94NUnzo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-Q42QmBXyM6ynLAxy1PvIXw-1; Mon,
 08 Sep 2025 04:53:22 -0400
X-MC-Unique: Q42QmBXyM6ynLAxy1PvIXw-1
X-Mimecast-MFC-AGG-ID: Q42QmBXyM6ynLAxy1PvIXw_1757321600
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A40BF19560AF;
	Mon,  8 Sep 2025 08:53:20 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.112.56])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB9251955F24;
	Mon,  8 Sep 2025 08:53:15 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Benjamin Poirier <bpoirier@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH net] net/mlx5: Not returning mlx5_link_info table when speed is unknown
Date: Mon,  8 Sep 2025 16:53:13 +0800
Message-ID: <20250908085313.18768-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Because mlx5e_link_mode is sparse e.g. Azure mlx5 reports PTYS 19.
Do not return it when speed unless retrieved successfully.

Fixes: 65a5d35571849 ("net/mlx5: Refactor link speed handling with mlx5_link_info struct")
Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Li Tian <litian@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/port.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 2d7adf7444ba..a69c83da2542 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1170,7 +1170,11 @@ const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
 	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
 					  force_legacy);
 	i = find_first_bit(&temp, max_size);
-	if (i < max_size)
+	/*
+	 * mlx5e_link_mode is sparse. Check speed
+	 * is non-zero as indication of a hole.
+	 */
+	if (i < max_size && table[i].speed)
 		return &table[i];
 
 	return NULL;
-- 
2.50.0


