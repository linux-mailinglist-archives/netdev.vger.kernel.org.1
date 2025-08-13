Return-Path: <netdev+bounces-213239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2EEB24338
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7483AD8A1
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5722E285E;
	Wed, 13 Aug 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nahwS0qR"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6CF2D59E3;
	Wed, 13 Aug 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071543; cv=none; b=rvJXGB701l21lkHXgVeKw837Vt5VhcLfpZSE+STGe6Jsv+cV9pL5gjomSOMrBr7j59e9BGT9CRVzxw/0sICc4+GGJl3uNNgXIjKijxVmTt88uXScTg9f5uJmmRxzIZ47B0zmj/rCNyP0oIu4bxBSKqPo3GQqJq0GrVYZS0FXI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071543; c=relaxed/simple;
	bh=rbpZkuoFpSp+LOSGBUuAX3MhcyopUmEUsw+gqSyBjoo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yfw9dlKeSwF6p38agTX7J6NhwrG8Z9ZK2NX30ZNpOnbp9jFufh3vtm0TG4tUS55wFww61LyjKp6DxQbRC8Ygz2kd+VvHspJFdx0zu1DkbIFqTRAxmTqvygO0mS37qjqbkK+K7+eMPWao3HxDOmtIxE9c+g6snFa5k1tHb/3Z5YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nahwS0qR; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755071541; x=1786607541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9mYqUdh8+4WOrSA0/b4w7nz2P7jBkHZ0NDF86QchptE=;
  b=nahwS0qRyX5yyT153DtUjQqxuMM3nVOw6DUj7TGXTn4xWHYV77G6AiNI
   ecOMP8B3qTkfyHpz8sI/XmvR1MXP3Yq6vHp5gR7kg+F7LZBP7Lb3mqdAA
   bso1nnwdVbA8KaBg7iasxsIGsnb/fMacsv2e4GR+atcEHe/nWTOq8m+Rt
   Pkurlb5PyenKLBT4/Gy5FldHwjA6wDJdYRBdMQdsPmyOuJvTb1zhDAlDA
   oWWZfrT6dIJ1qyiCmT9yyll5eVec/Ill1yOjOjL08cFfN7bM9AA8L9niV
   YGjtIDjzhh14/CR3gQSSd2xNAyZXw7qgEs7KjviUy2G7Og3fMpJMAws6R
   Q==;
X-CSE-ConnectionGUID: OE1E8bnWRoKCaUqkm5WiKw==
X-CSE-MsgGUID: /oe6bVl4R4qVJMGsyY5R6g==
X-IronPort-AV: E=Sophos;i="6.17,285,1747699200"; 
   d="scan'208";a="987739"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 07:52:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:41088]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.146:2525] with esmtp (Farcaster)
 id 7b0c3d88-72a3-4bf1-923c-d4a238488dc3; Wed, 13 Aug 2025 07:52:17 +0000 (UTC)
X-Farcaster-Flow-ID: 7b0c3d88-72a3-4bf1-923c-d4a238488dc3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 13 Aug 2025 07:52:17 +0000
Received: from b0be8375a521.amazon.com (10.37.244.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Wed, 13 Aug 2025 07:52:15 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<kohei.enju@gmail.com>, Kohei Enju <enjuk@amazon.com>
Subject: [PATCH v1 iwl-next 0/2] igbvf: ethtool statistics improvements
Date: Wed, 13 Aug 2025 16:50:49 +0900
Message-ID: <20250813075206.70114-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series contains:
1. Add missing lbtx_packets and lbtx_bytes counters that are available
in hardware but not exposed via ethtool
2. Remove rx_long_byte_count counter that shows the same value as
rx_bytes

Tested on Intel Corporation I350 Gigabit Network Connection.

Kohei Enju (2):
  igbvf: add lbtx_packets and lbtx_bytes to ethtool statistics
  igbvf: remove duplicated counter rx_long_byte_count from ethtool
    statistics

 drivers/net/ethernet/intel/igbvf/ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.48.1


