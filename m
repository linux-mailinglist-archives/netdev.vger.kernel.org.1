Return-Path: <netdev+bounces-103364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C934907BB2
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 20:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B1FB24079
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 18:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3390E14C5B0;
	Thu, 13 Jun 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Umb62CkR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E914B95E
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304245; cv=none; b=SpDg84J9m06gPMJXzdtpwEXpnQ8RAEh9ewjO3NAorcDOiy1zXglpXZv5FHgy05gbTyBgtKOyddSTWdvXQg4mMOVFCoDg+/9oUO30V5G8TV29yHRAz2UW6PGMMP6Qxi+FBQEDt9aTDVWWVLb1LEIETCYsU6R7Zss5A9F3fiyz0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304245; c=relaxed/simple;
	bh=YG2wOJc6wqf6dykvFPPXqz7UxsVnzoUzwDDgCZ7l2gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKZ1llYegWKcoIRgL0hpmj65oi7/H2xnbWrRQLhVijeyaZ0p83LbmsLUL9MwF10ntngDc+dYZdRQ5Psw0vNbp2+XE6Wlf3EjtSo0vOyPg/1W4ijl6CmRQaz65W1kv6mgZXX5j4/tGf+/HBbnBTWhIFbabvU8d+9r/yPiDK/Wlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Umb62CkR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718304238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXtY6Uq6DYBobpANnl4PRcqvhCkxs52eoMmMMFAJuVI=;
	b=Umb62CkRIuD3WucyiBY3RcnenPcvBLwvIECPs4b4oPjK3T8IZS3N54f+XZfpE8aWbBX6/v
	UhGiN5WGrZI30tNYhyft1+quqefjZVMWjyiUfkdXczpwT6eswrXJH2Gpi3ySCPBKU4ixcn
	Mg7/5uB6o8n90AZqx7ati0nSjdxkFM4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-Uo94IL3oNTa7fhXMit8QmQ-1; Thu,
 13 Jun 2024 14:43:55 -0400
X-MC-Unique: Uo94IL3oNTa7fhXMit8QmQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4C1A1956089;
	Thu, 13 Jun 2024 18:43:53 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.17.127])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 635261956087;
	Thu, 13 Jun 2024 18:43:52 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next 2/3] net/mlx4_en: Use ethtool_puts to fill selftest strings
Date: Thu, 13 Jun 2024 14:43:32 -0400
Message-ID: <20240613184333.1126275-3-kheib@redhat.com>
In-Reply-To: <20240613184333.1126275-2-kheib@redhat.com>
References: <20240613184333.1126275-1-kheib@redhat.com>
 <20240613184333.1126275-2-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use the ethtool_puts helper to print the selftest strings into the
ethtool strings interface.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 50a4a017a3f4..fee02a94ed2f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -459,10 +459,10 @@ static void mlx4_en_get_strings(struct net_device *dev,
 	switch (stringset) {
 	case ETH_SS_TEST:
 		for (i = 0; i < MLX4_EN_NUM_SELF_TEST - 2; i++)
-			strcpy(data + i * ETH_GSTRING_LEN, mlx4_en_test_names[i]);
+			ethtool_puts(&data, mlx4_en_test_names[i]);
 		if (priv->mdev->dev->caps.flags & MLX4_DEV_CAP_FLAG_UC_LOOPBACK)
 			for (; i < MLX4_EN_NUM_SELF_TEST; i++)
-				strcpy(data + i * ETH_GSTRING_LEN, mlx4_en_test_names[i]);
+				ethtool_puts(&data, mlx4_en_test_names[i]);
 		break;
 
 	case ETH_SS_STATS:
-- 
2.45.2


