Return-Path: <netdev+bounces-104198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A0490B7F4
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9121F21994
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BF516EB7D;
	Mon, 17 Jun 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WK8tXsS1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724F16CD28
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645060; cv=none; b=PHrD6ODwM0WWVEkdVpXsFWtaQsTzgFUuEbgRkN5AaTBF9w0cj/nyO6C5tSW2kpidM/d1aTcnkYFGdLtqLzd/IXYWcfPpVjtKyh0d070/sls4/Rv22rK+ssWD9Uc0oJxM6qCwNIwuIJB3Be+Go+vkmtrCUy6NWwhh7r1na9aVuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645060; c=relaxed/simple;
	bh=YG2wOJc6wqf6dykvFPPXqz7UxsVnzoUzwDDgCZ7l2gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNbqenP+5lIafdWkMKpeI1a94JM3X4i97TUFYJzCEnx95hJcyAeFjSBnA4Js0xa28hE+WsMdGnvA8Y1VQHPF1SIA9fAoDUIR102hAy8Ytork+APfs00GyIqlRPvfRYWR6SGR1Dr02+u736zZ+IQg5n5WqcymvE9BkWTWUOHFwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WK8tXsS1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718645058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXtY6Uq6DYBobpANnl4PRcqvhCkxs52eoMmMMFAJuVI=;
	b=WK8tXsS1EtTyp4+JkI1GV3e9bCXSUOHH08ADURZ+KJ/YQWgwMnUhPhOuS03dOoWiCjbUmj
	qHKboON19rprBFJuVU8XTgu4Us8vkbIJOqhpLmjmu3P02hRjIcDvvswFwn7P/wpdhTUHgr
	URBg9I2VmvMGuSWohVEfxp1n63MJKOM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-fMv8c_E0PZ-vo3vN6PSQjg-1; Mon,
 17 Jun 2024 13:24:13 -0400
X-MC-Unique: fMv8c_E0PZ-vo3vN6PSQjg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E24551956089;
	Mon, 17 Jun 2024 17:24:11 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.18.62])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 187B01955E83;
	Mon, 17 Jun 2024 17:24:09 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next v2 2/3] net/mlx4_en: Use ethtool_puts to fill selftest strings
Date: Mon, 17 Jun 2024 13:23:28 -0400
Message-ID: <20240617172329.239819-3-kheib@redhat.com>
In-Reply-To: <20240617172329.239819-2-kheib@redhat.com>
References: <20240617172329.239819-1-kheib@redhat.com>
 <20240617172329.239819-2-kheib@redhat.com>
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


