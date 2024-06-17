Return-Path: <netdev+bounces-104197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB84C90B7F3
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC0B1C23694
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D716DC23;
	Mon, 17 Jun 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCSpg+bL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC416EB74
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645059; cv=none; b=cFPTWJKC0bQb35dyD9Q+9x84iSArWU/C97Lb2vnCkjrMn422I878TdLSqVUiAf89g1WGjITBiWVySh2Q2+uyigpEip7ouuxFQcF5bj8rREn26GxUUuXWmYTggE2B4Kj2tPKZ5nra9Rry24/cMolHAonDJHdNRJMeka0pfRz1ECg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645059; c=relaxed/simple;
	bh=rVZKNmYsCg7Cv0JF3bOovcM69egkCp/oEwpFfMlMSH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPciTpnPFDEvPEbZoLdZ47k8ds3811JkFOac1LoqS5EhSkU25v9VPylTlmohvripNzfTIwgYFUaKTADfPwG0XF0GX2KMUb3scBmOwQmnSMxazdiQZczNfR1tkROnSdJ2uamyE6kkW0QyeqH6EmJf3SbUNsEUduftZjXnLY6iymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCSpg+bL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718645057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6gKuRAroxdFSIn4AAkyBRetf77gKe9BhwcyD4tozv8=;
	b=bCSpg+bLP9z2ygsA0FvIxJzpNEPzbVL2athscERIGPIdw3lf0vgq4PhMDweuFXeUngFelS
	Z9ZAzfvvbKeWuoNFSs6RBcXKXQUDoSUaFC3Mk4kmEOWHAh+L9LYdrT4niiSRoOHpsnJV/s
	W0cggVVZxXjD2dSpklSMqhcXf6o8zqA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-CYX2mKGnPjSvsE0FEpk0OQ-1; Mon,
 17 Jun 2024 13:24:11 -0400
X-MC-Unique: CYX2mKGnPjSvsE0FEpk0OQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DE0B1956094;
	Mon, 17 Jun 2024 17:24:10 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.18.62])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05CB51955E80;
	Mon, 17 Jun 2024 17:24:07 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: netdev@vger.kernel.org
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next v2 1/3] net/mlx4_en: Use ethtool_puts to fill priv flags strings
Date: Mon, 17 Jun 2024 13:23:27 -0400
Message-ID: <20240617172329.239819-2-kheib@redhat.com>
In-Reply-To: <20240617172329.239819-1-kheib@redhat.com>
References: <20240617172329.239819-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Use the ethtool_puts helper to print the priv flags strings into the
ethtool strings interface.

Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 619e1c3ef7f9..50a4a017a3f4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -536,8 +536,7 @@ static void mlx4_en_get_strings(struct net_device *dev,
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < ARRAY_SIZE(mlx4_en_priv_flags); i++)
-			strcpy(data + i * ETH_GSTRING_LEN,
-			       mlx4_en_priv_flags[i]);
+			ethtool_puts(&data, mlx4_en_priv_flags[i]);
 		break;
 
 	}
-- 
2.45.2


