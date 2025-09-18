Return-Path: <netdev+bounces-222766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB4B55EF2
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 08:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981081C2793B
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7F02E7652;
	Sat, 13 Sep 2025 06:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUzKSGav"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FA2E7646
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744907; cv=none; b=KMga/qKi60uYWWG+2mRYwGJOtnWepA9VpY4/h/t3LnztvLN+1sFG7ytLWD7ql3QGbnv5zXEViPrVVjZpsuydG3c6X/t1yqVFFOn3/9BlYp2Afqv8fAap3t8AO1R23LFCbQ12Zl6FI7iKUkeVcX5x4MAGf6RqdxwHFyKJx6NIQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744907; c=relaxed/simple;
	bh=/i/Vpx5Mot8737yhSFoj0KRVF1Oqi+ZajfOBBYnzlY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIEwiPPhp6EZyYwebEj2yn04+5QS5tqpwnQM8umol+mG96X1AWP2gtqwrhDdfDl0zgSYH9KkgcCPH5+0la3SE8EoaH0f7jOa0a3nxLgJaCo7ipMK7N+/PPBXcnfx0H8tmlUbXzR4zaZkTsxamYOsJkEclPmGeMl1ln7P5ASrZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUzKSGav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757744904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mY0zwfbcY1iYfa3XybLBXvWgZp6sPQxxx4em9LXqmGk=;
	b=jUzKSGav/quFvFIA5zTCUkHwOefHM9CMVRcgv6FA30kjuQtV107DSQ8Fd5JP/6ugf5vrQb
	/T/c9WCXqJLdqGWUV5Q2sh6lxrH0aeY0bQw88YxQv0cgl+Z9eaEttQE7KC8zJfzeX3vOVA
	jqYHORkZWGyx2RJ4GXtI6L4LFMT8BfQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-RKEeC9LyO6O3JcQ8hwjPSg-1; Sat,
 13 Sep 2025 02:28:20 -0400
X-MC-Unique: RKEeC9LyO6O3JcQ8hwjPSg-1
X-Mimecast-MFC-AGG-ID: RKEeC9LyO6O3JcQ8hwjPSg_1757744899
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3FF51800365;
	Sat, 13 Sep 2025 06:28:18 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.112.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17A2B300021A;
	Sat, 13 Sep 2025 06:28:12 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH net] net/mlx5: report duplex full when speed is known
Date: Sat, 13 Sep 2025 14:28:10 +0800
Message-ID: <20250913062810.11141-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Prior commit in Fixes, duplex is always reported full as long
as the speed is known. Restore this behavior. Besides, modern
Mellanox doesn't seem to care about half duplex. This change
mitigates duplex unknown issue on Azure Mellanox 5.

Fixes: c268ca6087f55 ("net/mlx5: Expose port speed when possible")
Signed-off-by: Li Tian <litian@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index d507366d773e..9f35d3b491e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1118,9 +1118,11 @@ static void get_link_properties(struct net_device *netdev,
 	if (info) {
 		speed = info->speed;
 		lanes = info->lanes;
-		duplex = DUPLEX_FULL;
 	} else if (data_rate_oper)
 		speed = 100 * data_rate_oper;
+	if (!speed)
+		goto out;
+	duplex = DUPLEX_FULL;
 
 out:
 	link_ksettings->base.duplex = duplex;
-- 
2.50.0


