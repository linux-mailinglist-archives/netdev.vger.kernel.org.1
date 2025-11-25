Return-Path: <netdev+bounces-241489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6848C84702
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CBE534F60C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD972F39B0;
	Tue, 25 Nov 2025 10:20:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3BD2F1FC3
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066001; cv=none; b=BroUnldDZ9UbgcoEaKHhKGU6F72vpmWkBR9aFoFoEKhyuEGEIc/Xyio1ZchxjueUiPJTxfOMsyrf42rvUzlo5DLJrp6MLZxqJZn6+aqXn3MGn8lrAI2txi2FhjMVtg4XGP7aLpMxC668YWxg561nPeCar2E+qoZxBUPXEQYD7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066001; c=relaxed/simple;
	bh=+mKqoVITB42hGcYSGhqJCuohMHY7kF/4b4nnE5SxPMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mz5du69fq6a0tZ7dmrbVVcTZJbE0IcNn0LJ1wcV+hAZYaKJVCoTUzE77zVeeT13IdJTa52wP4xT9clGISkgjs4CbTVPeCBf95xvNpsjzqMV0yoZ7bAGqHoz/9lfcX4ZuX8ZVObzjzUQhgJs+emNUG6zxnz+DQBHF5XZv2jP3BIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c7533dbd87so3728290a34.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:19:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065999; x=1764670799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3UJKFUGkVvLB3wHG4oGvnme23SWc+gY7YZkrVaP7Sw=;
        b=MW+ZpTWMLjdGhdkD2XtxRUXPmiHyWa54jGO27hy2HdPgBG5sBn4KHv4BUZVsmzrDJh
         r1TQQ5a2lfZqgilAPpY8tw+PL3UGbvrjZ+Fdon7GUNHSRaxQYABjwIkNPCGL3cl8PldY
         dHYMvVvKe7zkH1MRlLQHG7H9xdhndHM8XBuEF+45yhjpDpjry6+bJfluEy14oFvKtZYT
         Yp/peUlDheDJGW4qtXlhBqJssS74EY9g5J0TzVVyz/Inh1yqRrT+keGuNYzBfXSUAOKA
         lGM748eMeVOxE2aoHVRDDjOuOwkcgNZHHENxT6JD1+LhtVT07dvTmQfFo737+U9fQyM0
         Iiyw==
X-Forwarded-Encrypted: i=1; AJvYcCUntoW4x2kFSZiYlPX1QdQaCMskeVVkQkyWCdHnqkB7s1lGaasNqbOzDdu9JqKzTRcmoleRjoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3sL30QJesaXYDDAxks0MLP8Kpz5y3bys9ZCCW8ZfIvEsjYYO
	/6vsS80uKUjga7AGtKAdWx+G/mEWUqIhf5oUrDf927uhJ4EvKWP3u8+r
X-Gm-Gg: ASbGnct6/yeAI3gkIWqJ6MBuWeUR1RLWHcvaWl6uy+pJP5p4MszxIzqs/jSWqJ+Q1DZ
	sd5S7o4/mS+yu/E/FxtqUPuN5BK5FT95PBVk7IfcOB6Nzeg2zgY1DzyTFm8EsP1x5PepCQ5VLP/
	s98pvlu1GfSrq78EeXd8ZDFR+fulsDEyK5kT6LdKvxt4hQ/T6D4U4R0tS9NSnEpyeBKKZa+eabH
	qD3qZbgWbFKfDZmyotyBLKw66p7tHqaIRkFjsVrhSQrgkxoAVf6xBy0byTZR9b8bNlKgRdWzDbl
	8BOwivEvbpESqahcLhHSZNtOOyUnuQJCKVwwXCYyKljEItrlQ2F0m+uWYP+LTHNsdZsT2NKZu66
	4FforF30ayvqZJBD1aaxPiV8pYCYnztUavko3uaMqdekZsCWTkLpusTC9vW3Spp15HCX0I1t233
	2zEFXi/uK+t18QCA==
X-Google-Smtp-Source: AGHT+IGuLIuKJ9TdTjmy0inbvUt0VBwN2voCUtXNkx0exipVNDA/fm8mJbXcCwAq/N0Z7Pyhn9HWTg==
X-Received: by 2002:a05:6830:2b09:b0:7c7:4bb:dc06 with SMTP id 46e09a7af769-7c7c3c66650mr1144804a34.0.1764065998716;
        Tue, 25 Nov 2025 02:19:58 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d346d84sm6126885a34.13.2025.11.25.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:19:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:47 -0800
Subject: [PATCH net-next v2 4/8] idpf: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-4-f55cd022d28b@debian.org>
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2441; i=leitao@debian.org;
 h=from:subject:message-id; bh=+mKqoVITB42hGcYSGhqJCuohMHY7kF/4b4nnE5SxPMY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIa66miHkyrbzAg+8nGLilethXxs3tVSlYv
 eK4pwAyJOCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bS8ZD/kBb4tdz4tRd09xMak7gTq+zCpME4Wj5VOfKeVLSiV6t4bWaxIqHC3/L0ojLy5UUR6gwMq
 r4kXBHYP+uLQS1zUpwCiJ8jkulST7Ti8qkIJAm4OgiGEBf8DY9Fef3VaguLTY8987d1a9G+0qla
 EBar+X+C0cFsNcxFndfmEnN7qAZ1wbVxTTEHltsPvqkxGglHUYkRyFDeFjYyTAqGOCkwEzzPqLC
 0E9x4NAbFLUGunFF3l5fxHm3mDo0VLxrCuZecOkXes9WVuzN8xa4h6/omKU4pTMvXHX1s4PUhcE
 y/foMyfQvUa/t78CnujY4J/G70DTrqrd1hWKgvwfYWWolY4GZumZIu0n3QnNp3Pqe+x149xm5W0
 qpLPRD7++g5a/sPUBqXvNiD43ZGCob5mhEOmFA9ap4soGFMJfZrOTrzpQPc/Jf3w2u5JcjlZGKS
 HzRx/geY7KmiDKl4n4Tnck6eDSsmHxb1fatr0kKtVWdW4LkVd/L9j3pl5hcIuV9Na7rHc3tuYrc
 qDTRECaw9NsdH5Pia8lKFj2J5hqbx2P98OHaA4BIFMjbfiC5IOuk92Dz+uhn7qkMNGeQUrWmh0L
 O+zZdvhez49HSxnvPCebgOHOFac+lSzKgladEOswJAIF4KZpr/T/sMwAt3SJbRSJF6ZCdgZEpX3
 XEQCfGXkiX8vYJg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns idpf with the new
ethtool API for querying RX ring parameters.

I was not totally convinced I needed to have the lock, but, I decided to
be on the safe side and get the exact same behaviour it was before.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index a5a1eec9ade8..5dd82b1349c5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -5,6 +5,25 @@
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 
+/**
+ * idpf_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Return: number of RX rings.
+ */
+static u32 idpf_get_rx_ring_count(struct net_device *netdev)
+{
+	struct idpf_vport *vport;
+	u32 num_rxq;
+
+	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
+	num_rxq = vport->num_rxq;
+	idpf_vport_ctrl_unlock(netdev);
+
+	return num_rxq;
+}
+
 /**
  * idpf_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
@@ -28,9 +47,6 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = vport->num_rxq;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = user_config->num_fsteer_fltrs;
 		cmd->data = idpf_fsteer_max_rules(vport);
@@ -1757,6 +1773,7 @@ static const struct ethtool_ops idpf_ethtool_ops = {
 	.get_channels		= idpf_get_channels,
 	.get_rxnfc		= idpf_get_rxnfc,
 	.set_rxnfc		= idpf_set_rxnfc,
+	.get_rx_ring_count	= idpf_get_rx_ring_count,
 	.get_rxfh_key_size	= idpf_get_rxfh_key_size,
 	.get_rxfh_indir_size	= idpf_get_rxfh_indir_size,
 	.get_rxfh		= idpf_get_rxfh,

-- 
2.47.3


