Return-Path: <netdev+bounces-153009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC369F68F4
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354437A4C99
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC91C2304;
	Wed, 18 Dec 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmrw0sgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81471BEF6A;
	Wed, 18 Dec 2024 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533290; cv=none; b=E1jk1PM6IOtlLGe9CqQdaGhMBojTzRNG3gPghzR+ymRZSQxQihqODWq6q7Qq44Mptz+p36PZawxJDixrAXvDfxLq/vbi0ywkC97qtUeyWmr1PboBS4iEIVnI1YojxIGN+N8EazgJq7p+W/KlwxwyMJWYi+HRUlIb/I93XxwZ4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533290; c=relaxed/simple;
	bh=9MtPKvDbTgpNdhT7mukCeICHI6xk+SR1837zdhmJ83I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFnBqRjEsVGyuQhtyI9UYcxJu4QjCiUM1T5MOAFXlFdMoZQ00F+uGki+Bnpdqf2hu6/pMFiRol+QA1XvupJWd8Cefg79p6RlV/LYCyzv3YX4xJeYOb80KBwNGEl/3OT9YxN7xu/xQec2LsNR3TRYsgV3VqmDOUIjf/2x/OGzDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmrw0sgg; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728ea1573c0so5804547b3a.0;
        Wed, 18 Dec 2024 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533288; x=1735138088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nurHWzKz9w0oZqDegac4s41urnhlqqdqQgodLmjtp/4=;
        b=Cmrw0sggId00IEOjkUyjQ5ajlJv5yZVTmW3zKnvXIG2TWdR9Bk/3PcNkqiL0NAkbd6
         PUKJrEt48BU/Jr/pOPBRvCL/F0e6Ft95pBLMgATjS/AKAJrMg6BCB2jiy7imHeVy5nzU
         kGYeUhOmokpdDdv5zTPrlHTiSiqt7c6ASRXuzewadP6DPOh9VKXmt+l24QTlKXqCoQyN
         zkQGVQn2Sw+VyF2+b2llBpk36DSd9JHlO2KJmYKEeA+7ZfxoVIfgPweq6jVFgkcpaCTZ
         R4NUx5NzI2afGTzzD2pJ0MfCHpsTQbnzFAe2XLDc3pUPVv7qyEPtJSCOFO0e9dpXFwEh
         ncyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533288; x=1735138088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nurHWzKz9w0oZqDegac4s41urnhlqqdqQgodLmjtp/4=;
        b=vNzVgIY8c6lepDjiHzM9u+U7LiLqvu8g9zODb8PtIFdug+RIlQIoemmnQa07gp4YFw
         0u/Gev4qGL3He12yW9wpTrBzCMHBs+r0HjJmsjGipxfI41nWi/S29UrmM3XcalDakAVs
         sPQsVQWqgEsoQ9vbF/tozPcziSuagWnz/kqVrb5szcarenP2XzbqK6CSPZu4rqO+YtTX
         hzpD7AVNkLJahmU4eWuBBivUBtUkVGenmODD0V+FL2wpXAo6PsqjlPpm5J8u+xLqz2Bt
         a+9HWQPyYjwxI9Pj8aJjCel0n73ausoRaC63Dk+LDMWHXZ3Rf7jHk3rmD6wI5dTgKecI
         D+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Fm/L9b0vYjpD5bXExF1lVe+riMYDHuEH4YbEPISzyloXahl8+FWVLPaHNgMzmWLxhCado+j3MVY=@vger.kernel.org, AJvYcCXX/ZoBAph2kMyTZUpwc/Mqre3uJCZXinYFRWZcLecyffSUGYf5KuSHUcM6t0pwZxSGcFmHzUQh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzahkd/OwhKhoeAw/gdpwG6F8PEC6tsGPbX5JDEVFLd0pl4V3er
	fbbRgdGp6+W2XuIyqA835dvi160EGDIeEFqfYAJwiBg3iPMB8C6G
X-Gm-Gg: ASbGncs+5fkVDsqmabQwhY+P0reU5c/MwHW+CJjOaCf17m7RItVJktFCIK9JCzvMvaJ
	Iy+f4VsNmwCDIjGOQ2Vjmnq/AlmObFO+c5RnwrtnF5cmRJaEAg/T9rkgf3th/Siq9JazVEQyHnu
	mbT1ZLaVj8rHUmyt0FWP+AYHgTHlNQKGSyqUzAWBQfHnQe+J4tBMGXkAy/m0CQuaOx/I927Mx33
	0s2Nq8c4gN2mxHU6SB76W4fUZ07E/NUFcWBlAdLrj9vHA==
X-Google-Smtp-Source: AGHT+IGyXL/jY4ZpJVlfKFa4l0IVypUBaFxkXF0sO1ELxMEVdLOy13mZvo6Co+HDvukxp/eBLM3b7A==
X-Received: by 2002:a05:6a20:d806:b0:1d9:c64a:9f72 with SMTP id adf61e73a8af0-1e5b47f252cmr4956312637.2.1734533288039;
        Wed, 18 Dec 2024 06:48:08 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:48:07 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v6 9/9] netdevsim: add HDS feature
Date: Wed, 18 Dec 2024 14:45:30 +0000
Message-Id: <20241218144530.2963326-10-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDS options(tcp-data-split, hds-thresh) have dendencies between other
features like XDP. Basic dependencies are checked in the core API.
netdevsim is very useful to check basic dependencies.

The default tcp-data-split mode is UNKNOWN but netdevsim driver
returns DISABLED when ethtool dumps tcp-data-split mode.
The default value of HDS threshold is 0 and the maximum value is 1024.

ethtool shows like this.

ethtool -g eni1np1
Ring parameters for eni1np1:
Pre-set maximums:
...
HDS thresh:             1024
Current hardware settings:
...
TCP data split:         off
HDS thresh:             0

ethtool -G eni1np1 tcp-data-split on hds-thresh 1024
ethtool -g eni1np1
Ring parameters for eni1np1:
Pre-set maximums:
...
HDS thresh:             1024
Current hardware settings:
...
TCP data split:         on
HDS thresh:             1024

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v6:
 - Patch added.

 drivers/net/netdevsim/ethtool.c   | 15 ++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  4 ++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 5fe1eaef99b5..aa176f52fc3f 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2020 Facebook
 
 #include <linux/debugfs.h>
-#include <linux/ethtool.h>
 #include <linux/random.h>
 
 #include "netdevsim.h"
@@ -72,6 +71,11 @@ static void nsim_get_ringparam(struct net_device *dev,
 	struct netdevsim *ns = netdev_priv(dev);
 
 	memcpy(ring, &ns->ethtool.ring, sizeof(ns->ethtool.ring));
+	memcpy(kernel_ring, &ns->ethtool.kernel_ring,
+	       sizeof(ns->ethtool.kernel_ring));
+
+	if (kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+		kernel_ring->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
 static int nsim_set_ringparam(struct net_device *dev,
@@ -85,6 +89,9 @@ static int nsim_set_ringparam(struct net_device *dev,
 	ns->ethtool.ring.rx_jumbo_pending = ring->rx_jumbo_pending;
 	ns->ethtool.ring.rx_mini_pending = ring->rx_mini_pending;
 	ns->ethtool.ring.tx_pending = ring->tx_pending;
+	ns->ethtool.kernel_ring.tcp_data_split = kernel_ring->tcp_data_split;
+	ns->ethtool.kernel_ring.hds_thresh = kernel_ring->hds_thresh;
+
 	return 0;
 }
 
@@ -161,6 +168,8 @@ static int nsim_get_ts_info(struct net_device *dev,
 
 static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
+	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+					  ETHTOOL_RING_USE_HDS_THRS,
 	.get_pause_stats	        = nsim_get_pause_stats,
 	.get_pauseparam		        = nsim_get_pauseparam,
 	.set_pauseparam		        = nsim_set_pauseparam,
@@ -182,6 +191,10 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 	ns->ethtool.ring.rx_jumbo_max_pending = 4096;
 	ns->ethtool.ring.rx_mini_max_pending = 4096;
 	ns->ethtool.ring.tx_max_pending = 4096;
+
+	ns->ethtool.kernel_ring.tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+	ns->ethtool.kernel_ring.hds_thresh = 0;
+	ns->ethtool.kernel_ring.hds_thresh_max = NSIM_HDS_THRESHOLD_MAX;
 }
 
 void nsim_ethtool_init(struct netdevsim *ns)
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index bf02efa10956..6abbc627308d 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -16,6 +16,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
@@ -36,6 +37,8 @@
 #define NSIM_IPSEC_VALID		BIT(31)
 #define NSIM_UDP_TUNNEL_N_PORTS		4
 
+#define NSIM_HDS_THRESHOLD_MAX		1024
+
 struct nsim_sa {
 	struct xfrm_state *xs;
 	__be32 ipaddr[4];
@@ -87,6 +90,7 @@ struct nsim_ethtool {
 	struct nsim_ethtool_pauseparam pauseparam;
 	struct ethtool_coalesce coalesce;
 	struct ethtool_ringparam ring;
+	struct kernel_ethtool_ringparam kernel_ring;
 	struct ethtool_fecparam fec;
 };
 
-- 
2.34.1


