Return-Path: <netdev+bounces-172138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4699A50514
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15867A4815
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34B198842;
	Wed,  5 Mar 2025 16:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC11922C4
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192658; cv=none; b=qfaahjYwiqystOAdZCVW6jI0fRfXCHw/q/zHsXYAPwWTsqFTRUTiZZpoMDZDfYUcJ5iMVARq0M5/HawRB0Q8go/mabVR40EG6jbpp3Mv7WUSpXj3HGt7oxjX33GpG52+LViFk7x0Cg0+wlWEZVJTjPdrFY3vNQZANu5tyyu+31o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192658; c=relaxed/simple;
	bh=4PzH4d2JZmEOOe0S7ZnBeFJM7FC8NDC8XZG/Boe/rn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAoQrVGFq51NHnPfxNbxLVsZy32suZ39tYxf7f+bCQ/G1dOjaVKfOhXhRMbhcQC6A+qj1ugHIx3HZGkcHdyj6iBXo9JGj5jl3oxIjxZgiT/4/o8VlB+0PzznBoRWA6TzvseyH7vEeSuf4jGtdbVezJaZX9IkroYzrC/Fc3IIkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so8962965a91.2
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192656; x=1741797456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPyXr8Bb7Frf2F/g5SpddnLan7LIobq/UGlFPqLBaEw=;
        b=IMu91jjtsrsVnBjIHJTt76haRPI9XIFEaZWowMYN3c18vw1dDAXL2kWLaN5gYDChxK
         /8VTY1eoi9kt2lCTgms5TtVjjkSqrWrbiXCMk4puVM0+7s6xZjzOzVtJvMsdqUVlRMkL
         Z71nj1YXYIAjVFnkximOCxTdHa0L6BbShqaHtaORUzaJIXRbDvkAhBHlbGWw70w6IV7N
         ysI/cWsR7yHJJlddewUqe2Z+vSG0O0jFKzKxfW61SH1ntTiTlDhjm32hGU2Scpn99v80
         WejiEJ0LQ2rmlMKNxLBrhgCPM1dL+PjaQqonyK7hoaWHpS6Y0lvzoUiYR7QiqR3N6awX
         aFjA==
X-Gm-Message-State: AOJu0Yyugld/+fhA6O7IAm1kukwM+McIn6j2Z485OlLdJsb9divzfD/f
	TL4YpUxrYSwi3Dt5uj4iQeGqHCixcmngHh2yQPPdgLVlIZxiVCdM7HQM
X-Gm-Gg: ASbGncvsces0/3DEUhAqnl3lnlzBCVIKa/ezoqBy9uDIJiYlfhvXGR/n+s/84IGmYVG
	qfCqxLTQ+Yy6GzIUJl/glTTL6C80PcC2CvMQ+e4q5HFCIZetZCc8KanFf0AxsGWZnUUsG8ga+Uf
	65CYtuATzRXmpLgOCf8O81u4LmtbdxJvxCR9MITmoFwy4/PsoqbhBRBMzve1u5O/2YPdb9+ZKHg
	p7WBMPD5Tt4RXWflv3sqJ+YECWQdkVXlrIoQxlgGkuMnln9zEUel92181Oy2DPRYg9ZhhT5v1pC
	yo86OF4nrhr+4VJjFJQDud1oQZ5SpKbhO9EIisLmXnGt
X-Google-Smtp-Source: AGHT+IFXcZiZnzA27a4t2GfFSOqbjUTYjM0cB1MBom5x1+f99vvetppiWdoVSoFsbDfSwG6LILH6NA==
X-Received: by 2002:a17:90b:3ec1:b0:2fe:a8b1:7d8 with SMTP id 98e67ed59e1d1-2ff497995f0mr6225584a91.25.1741192656518;
        Wed, 05 Mar 2025 08:37:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e789387sm1550437a91.25.2025.03.05.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:36 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 02/14] net: hold netdev instance lock during nft ndo_setup_tc
Date: Wed,  5 Mar 2025 08:37:20 -0800
Message-ID: <20250305163732.2766420-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce new dev_setup_tc for nft ndo_setup_tc paths.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  2 --
 include/linux/netdevice.h                   |  2 ++
 net/core/dev.c                              | 18 ++++++++++++++++++
 net/netfilter/nf_flow_table_offload.c       |  2 +-
 net/netfilter/nf_tables_offload.c           |  2 +-
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 9f4d223dffcf..032e1a58af6f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3894,10 +3894,8 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 	if (test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
 		return 0;
 
-	netdev_lock(netdev);
 	netif_set_real_num_rx_queues(netdev, total_qps);
 	netif_set_real_num_tx_queues(netdev, total_qps);
-	netdev_unlock(netdev);
 
 	return ret;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 33066b155c84..69951eeb96d2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3353,6 +3353,8 @@ int dev_alloc_name(struct net_device *dev, const char *name);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void dev_close(struct net_device *dev);
 void dev_close_many(struct list_head *head, bool unlink);
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
 u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
diff --git a/net/core/dev.c b/net/core/dev.c
index 7a327c782ea4..57af25683ea1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1786,6 +1786,24 @@ void dev_close(struct net_device *dev)
 }
 EXPORT_SYMBOL(dev_close);
 
+int dev_setup_tc(struct net_device *dev, enum tc_setup_type type,
+		 void *type_data)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (!ops->ndo_setup_tc)
+		return -EOPNOTSUPP;
+
+	netdev_lock_ops(dev);
+	ret = ops->ndo_setup_tc(dev, type, type_data);
+	netdev_unlock_ops(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(dev_setup_tc);
 
 /**
  *	dev_disable_lro - disable Large Receive Offload on a device
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index e06bc36f49fe..0ec4abded10d 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -1175,7 +1175,7 @@ static int nf_flow_table_offload_cmd(struct flow_block_offload *bo,
 	nf_flow_table_block_offload_init(bo, dev_net(dev), cmd, flowtable,
 					 extack);
 	down_write(&flowtable->flow_block_lock);
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, bo);
+	err = dev_setup_tc(dev, TC_SETUP_FT, bo);
 	up_write(&flowtable->flow_block_lock);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index 64675f1c7f29..b761899c143c 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -390,7 +390,7 @@ static int nft_block_offload_cmd(struct nft_base_chain *chain,
 
 	nft_flow_block_offload_init(&bo, dev_net(dev), cmd, chain, &extack);
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+	err = dev_setup_tc(dev, TC_SETUP_BLOCK, &bo);
 	if (err < 0)
 		return err;
 
-- 
2.48.1


