Return-Path: <netdev+bounces-137666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75119A9371
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3613D1F2225F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2C1FEFAC;
	Mon, 21 Oct 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gcqgyi0V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182641E2839
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 22:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550159; cv=none; b=eSFi3w/KCD3I9TOeuY+CTMmxqdQz0/LeiBuk96KN6QfyTSeCj8krRv5Ct6SNDL7koVvRTgd7NfurkH9YhgVj747dO4EbELqNW6D4ufVXj0R2kZTXP0lc6Cu/fhc1sTeonRcabdcB+X9fsrkmgpc/8PPGo+NGFWvi6fq98btj+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550159; c=relaxed/simple;
	bh=aIEngXYITkGtYVSWyQd/A3vL4a+XE2IDgBQVcNr076o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nRO2YtA+CibESVYacDS3EdZA4ddrjqU79KQ3qPHIBNiyfrw4l6S/r0X/0S16kPwIglTEcqbGe32EMmZ4IJxDH54mcJ0d3HPiU34aUa3ZQupGtWdRHNWJelwNw5bTaBtjiWFHgnnSQn4dtZTL7dN7tU/5uGdR0wf06HkuI4xF4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gcqgyi0V; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8b557f91so50131215ad.2
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729550157; x=1730154957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+21hon7jB7Ze6MH6lzU0hyrhZwk9Xet7rRe7hsDfrQ=;
        b=gcqgyi0V1wI/J375rCzXF9Yeib/ALbUGFtM9jVZ7tMtUyZHeL1XpqJqYbJYQKFruk6
         OaSQcroxdPUaB7bAHTz/sWk9jbzQzhFwmDR5l99jK0AeFfmGlXylR7v1uWjQZzTiZn3B
         HTIkpZdeLi4QyCmu1uPTqDtIz08hzv52fj3pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729550157; x=1730154957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+21hon7jB7Ze6MH6lzU0hyrhZwk9Xet7rRe7hsDfrQ=;
        b=mxcleRUU/fcHciUdduWKrpLGhsDb5Zh0sDDSZpSlSVqEhlTd3QBzXa6mkS7YgEtSPR
         /3wkHwJB1pSuBny+fWLmW2HOHKyaI4WGKJBJbC/ckXv+IdapjQpydzWYMgH9aZTpxMul
         qlRq0Ez/l+QNPSz2pGUVxjbwgkdTHinoZC+n1X9BS9f+abJzEJrCxQbrPG7hbpU9+OhR
         am6PEUbIYjBH2cCPwKhPO6SmRmzqCn95Czjgt2Sy1gaXn1XiXi4XdhuGcney5VJAwlDK
         AwW1e5IpAMds4PxWDKGEDic+TNC9L4/CYDCH021i3o3HuMNOTfDUV7WFbbwSu+PKe1kJ
         dJjg==
X-Gm-Message-State: AOJu0YzuUhqKulmnzhWUo9U/sehhfuMF0jP8bjLY0RNV3vDCbliGu3In
	XH2pYlo91JiHrll0QI2Rtozj4uTazf7t8HknISeEhZr/g+WS8mIRUuib5RGIAJ2VqQiX03rTs/S
	A8W+Yf7z2bOKIqmp/PZ/84dA6uKOSQgl2CifYVPGh8UWU+7jrChZrsTCRMdbV3oULmF0BMAJka1
	F+M1hAwPzFHBXF3giH5/PD42tjc89/pjEHbic=
X-Google-Smtp-Source: AGHT+IF3piS/fRA42347FWj61Lwbz0hs9de6WGfsiJ7XbyQ5WMZ9MBPYLBRxKS5gnyUcXdhPwbfDCA==
X-Received: by 2002:a17:902:d48e:b0:20c:f39e:4c25 with SMTP id d9443c01a7336-20e5a707c78mr214083015ad.8.1729550156983;
        Mon, 21 Oct 2024 15:35:56 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0db2desm30897655ad.203.2024.10.21.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:35:56 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH intel-next] ice: Add support for persistent NAPI config
Date: Mon, 21 Oct 2024 22:35:51 +0000
Message-Id: <20241021223551.508030-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs. This preserves NAPI config settings when queue
counts are adjusted.

Tested with an E810-2CQDA2 NIC.

Begin by setting the queue count to 4:

$ sudo ethtool -L eth4 combined 4

Check the queue settings:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8452,
  'ifindex': 4,
  'irq': 2782},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8451,
  'ifindex': 4,
  'irq': 2781},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Now, set the queue with NAPI ID 8451 to have a gro-flush-timeout of
1111:

$ sudo ./tools/net/ynl/cli.py \
            --spec Documentation/netlink/specs/netdev.yaml \
            --do napi-set --json='{"id": 8451, "gro-flush-timeout": 1111}'
None

Check that worked:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8452,
  'ifindex': 4,
  'irq': 2782},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 1111,
  'id': 8451,
  'ifindex': 4,
  'irq': 2781},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Now reduce the queue count to 2, which would destroy the queue with NAPI
ID 8451:

$ sudo ethtool -L eth4 combined 2

Check the queue settings, noting that NAPI ID 8451 is gone:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Now, increase the number of queues back to 4:

$ sudo ethtool -L eth4 combined 4

Dump the settings, expecting to see the same NAPI IDs as above and for
NAPI ID 8451 to have its gro-flush-timeout set to 1111:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 4}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8452,
  'ifindex': 4,
  'irq': 2782},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 1111,
  'id': 8451,
  'ifindex': 4,
  'irq': 2781},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8450,
  'ifindex': 4,
  'irq': 2780},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 8449,
  'ifindex': 4,
  'irq': 2779}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 3a8e156d7d86..82a9cd4ec7ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -156,7 +156,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	 * handler here (i.e. resume, reset/rebuild, etc.)
 	 */
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, ice_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      ice_napi_poll, v_idx);
 
 out:
 	/* tie q_vector and VSI together */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d4e74f96a8ad..a7d45a8ce7ac 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2777,8 +2777,10 @@ void ice_napi_add(struct ice_vsi *vsi)
 		return;
 
 	ice_for_each_q_vector(vsi, v_idx)
-		netif_napi_add(vsi->netdev, &vsi->q_vectors[v_idx]->napi,
-			       ice_napi_poll);
+		netif_napi_add_config(vsi->netdev,
+				      &vsi->q_vectors[v_idx]->napi,
+				      ice_napi_poll,
+				      v_idx);
 }
 
 /**

base-commit: 6f07cd8301706b661776074ddc97c991d107cc91
-- 
2.25.1


