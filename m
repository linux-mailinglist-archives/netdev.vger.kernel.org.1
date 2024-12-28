Return-Path: <netdev+bounces-154431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A387E9FDBF0
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 19:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6031882C5D
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48019924D;
	Sat, 28 Dec 2024 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qglg4mgi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D31990BD;
	Sat, 28 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411801; cv=none; b=uoN9FLf74Pv+zOUsT9+kM7Q7vGVJsIVrFqQAq2s0E+yOa0ouX0lfwc0EFPsCgUUNnYrBG+Gl64m0oWXmJ1vJ4G0YI/Cb72GOVGVURTSEQb3u2lFqCPmW8MyA0Ztg3mZRIBwDI3QXky6MArdgFeIrHbHRaqLbyRCgNQ9/3gvSXRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411801; c=relaxed/simple;
	bh=LKBBs7f6TPE3UEfobjTvbZ289SCsfoAg3ya4QFyqHdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDYWSn4eyTTWBaDxaMHI2hmi2xbAh9S/rL+ktbDrRmavYsHM0RD7YiouAeznH1n4SGEsTerJ9SsaynlGr05Mpk/qMAa2nGStZ290h4AD6XGyhxeeAt1Obntc/IrPRUVM8nGTQwn3lgWc8FE+MMESSUxB/bJhUG2Twx4UGiLxnmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qglg4mgi; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e4a6b978283so10107378276.0;
        Sat, 28 Dec 2024 10:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411799; x=1736016599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL8rNecoxrOgRuhpm+UkLZuLqFEtoRoNCimf/pNjqjs=;
        b=Qglg4mgix2Id8tX4dKCb+WINfyhD5fU0AfeshymC9M8+DN4k4DXSiUp1sfjz4Ojex+
         9GE2g2Hm5c/61z1R4tBUGVG0g+fITY/CQUW6lT1Ti+aWhK/2Hlz3ZM2+fzSj0ulkLic+
         ZM4UfVwzNXSSrB3aZi4yqnHh8YfhOujdeClcKASConwY2csdgpVp93OQBPM7vxirnPix
         AMcvThYX+oM4FuDLSlXiYNkhvylJV9q64b7gW4A6Qk/poNFFzEw29pGC3AIz8juBUDA8
         nbhwU9p2aMF2LZanF/K+yuv/LnL/vrsTCfnX7nHKpQTBYojxaZB+UdWj2ngxOcdQ53TL
         FE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411799; x=1736016599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lL8rNecoxrOgRuhpm+UkLZuLqFEtoRoNCimf/pNjqjs=;
        b=hqzJob6YJsU+AmzWxjVU3O6RLJUBrv+12gTTTt6LYNGytlJCiGjulynsVhDZPKQepA
         BXcUW6Ose8Jsun+44wRSYxcunCWMJywomwYpkD0qGgdIuygILRtmtbZTYxH+CzuOcHKA
         k7CZgvNJp4WpbAo9C317FzgVjejrIau2cqWfTeY+cg6RqPVwH+Wt+wovLKSisWuKwdSZ
         3YCjIlDdxepRolSu9MmtqBIZcBFG38ncTfTccqK04mVdv0OiKu8hjxjkMrvhs8jU5oEY
         9MLxvEBfAotnCO2TE93nDEV/wxWsPqHu241o6XXdIyEquhIiJ2IfVfFyceL4dpT2URrh
         zn+A==
X-Forwarded-Encrypted: i=1; AJvYcCWRFpBwXlG06UUVDdzncjqQqk0VM7QIeUgFOE93lT45XbqlBvIU5USoS7CYYdavZKVlZycQpYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywne3BMIer3SomRnsnmaHBKh53jOt0+4p2lBCo+ySORDdz4mJ3I
	jqzxLzhkxXkEQNSQUwfltIAbbFg3oWR36KT1+eXzVclkR/bL41HmfAbi3Q8u
X-Gm-Gg: ASbGncvu86a9n5+PfE6Y0vYS4ifUeumMEFRVb50kN5r/lgG3aj/m7gcLvGdlxdh7mXL
	HEzPrkEfI1rJjgzfBIHYW8sm548DZO8OiC5LiXmj2qT10ILdawmSFEIT47fK5JJRq0BW5C9LddX
	zkD4jC7QpTObA/6RFQIJtidy9g6JSzViYAmXEXNgDI6i7h9m4dOPenHOWVSX1vHHoKrN/Y6fXb8
	6J2KSf0bLf2Ik/NsktHNvl0KsSpXKFmCDPVxko4MteZnGx6FROBUPhVkot+yanT0Nf7StOhBjd4
	W9VpM1+lHUpyFWH7
X-Google-Smtp-Source: AGHT+IGzd+E2S8x2gXxoaCvAStSmkZ51igXj24qQWSN3ZW4n/H7SUeu2mKOPhIyoM4H12slkJ1LXvQ==
X-Received: by 2002:a05:690c:4a0a:b0:6ee:5104:f43a with SMTP id 00721157ae682-6f3e2b8aeffmr257339587b3.20.1735411799162;
        Sat, 28 Dec 2024 10:49:59 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e71a8d26sm47945657b3.0.2024.12.28.10.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:49:58 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 03/14] ibmvnic: simplify ibmvnic_set_queue_affinity()
Date: Sat, 28 Dec 2024 10:49:35 -0800
Message-ID: <20241228184949.31582-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241228184949.31582-1-yury.norov@gmail.com>
References: <20241228184949.31582-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A loop based on cpumask_next_wrap() opencodes the dedicated macro
for_each_online_cpu_wrap(). Using the macro allows to avoid setting
bits affinity mask more than once when stride >= num_online_cpus.

This also helps to drop cpumask handling code in the caller function.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e95ae0d39948..4cfd90fb206b 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -234,11 +234,16 @@ static int ibmvnic_set_queue_affinity(struct ibmvnic_sub_crq_queue *queue,
 		(*stragglers)--;
 	}
 	/* atomic write is safer than writing bit by bit directly */
-	for (i = 0; i < stride; i++) {
-		cpumask_set_cpu(*cpu, mask);
-		*cpu = cpumask_next_wrap(*cpu, cpu_online_mask,
-					 nr_cpu_ids, false);
+	for_each_online_cpu_wrap(i, *cpu) {
+		if (!stride--)
+			break;
+		cpumask_set_cpu(i, mask);
 	}
+
+	/* For the next queue we start from the first unused CPU in this queue */
+	if (i < nr_cpu_ids)
+		*cpu = i + 1;
+
 	/* set queue affinity mask */
 	cpumask_copy(queue->affinity_mask, mask);
 	rc = irq_set_affinity_and_hint(queue->irq, queue->affinity_mask);
@@ -256,7 +261,7 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
 	int num_rxqs = adapter->num_active_rx_scrqs, i_rxqs = 0;
 	int num_txqs = adapter->num_active_tx_scrqs, i_txqs = 0;
 	int total_queues, stride, stragglers, i;
-	unsigned int num_cpu, cpu;
+	unsigned int num_cpu, cpu = 0;
 	bool is_rx_queue;
 	int rc = 0;
 
@@ -274,8 +279,6 @@ static void ibmvnic_set_affinity(struct ibmvnic_adapter *adapter)
 	stride = max_t(int, num_cpu / total_queues, 1);
 	/* number of leftover cpu's */
 	stragglers = num_cpu >= total_queues ? num_cpu % total_queues : 0;
-	/* next available cpu to assign irq to */
-	cpu = cpumask_next(-1, cpu_online_mask);
 
 	for (i = 0; i < total_queues; i++) {
 		is_rx_queue = false;
-- 
2.43.0


