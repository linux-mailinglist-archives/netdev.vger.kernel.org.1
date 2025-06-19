Return-Path: <netdev+bounces-199351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75083ADFE5C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F529168EF0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33F246794;
	Thu, 19 Jun 2025 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZR9kFMQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4895B198A09
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750316854; cv=none; b=PSH5412OLK8F3acy22JLED+YwfhNf+8/QA4UUJmntGpWosA34avdKLY22AYP8Y1mqlGfJ1YuoZeYiRI3Bxyf3V6zC9Pcxi9MkaiHM0VNXvUT+olTZxatI6m6lilx+hhbfQw89ywfPfXeVZlHYuij0nkeWfeUxsdj2/41R+TP6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750316854; c=relaxed/simple;
	bh=DS6X6Uh+5BAdzn781q2Z39tpJGkQGohp1jR12NcJK9Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Slt70akdvwsg5x5Ox78VzLJpBH9RdByRJV1RTG8bWezUT7js1MBwkNqmq2LQTT8jfgqmgLxUwXAhYlybyk6wkpPHwXR61mC4nzjzYLP9phLU4WxuNu1DvfLpXdmkHkRIv/M5WHmfYDCqW1MwdXTMfMjO68en/HPYlAV97fKqf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZR9kFMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F62C4CEEA;
	Thu, 19 Jun 2025 07:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750316853;
	bh=DS6X6Uh+5BAdzn781q2Z39tpJGkQGohp1jR12NcJK9Y=;
	h=From:Subject:Date:To:Cc:From;
	b=NZR9kFMQFXBcMXWLxUtQNQci3YLdZ0Z/CLi0P9oiowapdLkqPcaUp7ZBmSWCjPnoO
	 9D/A3zZWufkdjQ35sMPLsg7JTAC5X7fg3qO3HpzT9tHKngNJAd+E1l9k2PejHIgc3U
	 DbSsWuJm/4c78Mpru0gZug3vzKzmrorsbcdjjfN6uAhdnm36HSBtE79RxWgh9b9mYJ
	 bIHAufP9TJ4uH8RbUCwGQe/Ob14Yq33yFM7/p2MLXwxDOWc+kdV1AKlLPLzVFp3n2m
	 pms6WFZXDOZvm2LiRo2530OJ3eKzz+Ba+F9gK28SKDiUkaDh/APvX6kBr3SVMRJB0/
	 hKhiqdh4TgvzA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v4 0/2] net: airoha: Improve hwfd buffer/descriptor
 queues setup
Date: Thu, 19 Jun 2025 09:07:23 +0200
Message-Id: <20250619-airoha-hw-num-desc-v4-0-49600a9b319a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACu3U2gC/32NQQ6CMBBFr0Jm7RgEWqor72FYVJjSidqaqaKGc
 HcrB3D5XvLfnyGRMCU4FDMITZw4hgzNpoDe2zAS8pAZqrJSpd4ZtCzRW/QvDM8bDpR61E6dtds
 7oyxBHt6FHL/X6KnL7Dk9onzWj6n+2b+5qcYSd8bqxrT90Co6XkgCXbdRRuiWZfkC5qYkwbUAA
 AA=
X-Change-ID: 20250618-airoha-hw-num-desc-6f5b6f9f85ae
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Compute the number of hwfd buffers/descriptors according to the reserved
memory size if provided via DTS.
Reduce the required hwfd buffers queue size for QDMA1.

---
Changes in v4:
- Fix commit log for patch 2/2
- Link to v3: https://lore.kernel.org/r/20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org

Changes in v3:
- Target net tree instead of net-next one

Changes in v2:
- Rely on div_u64 to compute number of hw descriptors
- Link to v1: https://lore.kernel.org/r/20250615-airoha-hw-num-desc-v1-0-8f88daa4abd7@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: Compute number of descriptors according to reserved memory size
      net: airoha: Differentiate hwfd buffer size for QDMA0 and QDMA1

 drivers/net/ethernet/airoha/airoha_eth.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)
---
base-commit: 9b70c362a9d4ab93e0b582dad73acb2a953ef797
change-id: 20250618-airoha-hw-num-desc-6f5b6f9f85ae

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


