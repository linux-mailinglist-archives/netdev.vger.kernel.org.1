Return-Path: <netdev+bounces-153460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58B9F81E2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9DF166B10
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963BE19D084;
	Thu, 19 Dec 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/iWP7Vx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F961A0728
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629409; cv=none; b=ShQz7s9rNMKK4zhXKvf90Hcf6wqF/dodPE0St/A1e6lJDDr6EOw/auPjvyMMswjO7KA0mBIEdCIWbaGWG07UsAY4Wo3mOFDUWwGrZaw5Idh+95HQhODoITYX8SLS6EQH4pDV0H1DXljuoRQX4fTswxrj4bMJ65biPjwubyUILCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629409; c=relaxed/simple;
	bh=70F86zaSn4GimagvJn0Rk8QAAlztOlL6C+Unj5Ovk38=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=leiqBO0Gnzl5NwqwPxmdhRxxCG0WxGyxhNsYg+4/LdMHHq7Vo8lCP81BWQXeUzKAd66Qjiwyb0rPEupHKTcw9F3ClK6qdO23fExU7HtImWb4Pwg1gLFY8W7xosa76K4Ou0AXqEpRM6AeJQbXVUI+EAv8rBOzRUiBzd8WhOCLXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W/iWP7Vx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fd388b49cbso957380a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734629407; x=1735234207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdcJ3ROUSFah6MzRAeluxvD6XlcCu4QRuejsJYYrHBs=;
        b=W/iWP7VxfHvfXj8aM++aWL4LmeD7Xo+zuubIqGQi7FNgdmPOXuYhuKKYaV4mZWFI5F
         R/QRDTBumuIje5lYPDXh0w2txOXtngLStsq3S62GPHv5qgI1ckSBcGdhO+DKPWZ0M0jV
         a+5H7nRv4Qi3AsAudPA0wJGiZt9q3MiQsqKXtmF7VBCmWpI0+W4gGZGrSMfXSl1qNwj9
         dXXlDy+QZNo5dULCjjfMevpJ01tLoEN8fx6DP0gjEFtq65Tm0rukdhKmMI0MdHw/UYs5
         ZUoRoUGh/c9A/rK9fQki23m6VMcY/jouNsgmdqEYGMdc3ktXFA+snxBeROfm2CvHYuol
         ZL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734629407; x=1735234207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdcJ3ROUSFah6MzRAeluxvD6XlcCu4QRuejsJYYrHBs=;
        b=h2JPa5Xm0fmAjiWySZo/ZMIWvvsLYKRrAi+wVgmf66GB3QXn13xYsTNwm1I5ktzKbF
         i6ZdkUApmW2N8LDgiXrW/ogXnYfpoXBnt0eNGTxG2kFC9WXx6QE7ukTeHvU5JEurKO9g
         bCBXb9KvYMKv9WbsljthXAaELuDRQ+DGsZRAXgk5y8qX31uIRLsSMDBxaXOyLFYdHNQD
         qkDYf1HVFpKiVKglq5HzMKmNt3KgQ/asBksnbFj/IlDCvMDd4p+Rj6qJqfFmoM4KEIfa
         JCXNAwQ+FKxwtG3+o5ULTFe9ikg58DGNH9WM1tA84tguIBSrvqWMglYApdSYWv0zH1BP
         Y44A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1+t44Ay2kFs0Z42i8mcE8iGaKOkTbE16/yWuhaEGjWK27UBQpdVRl2zBE3EixM1xTccr9CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweNazgR+g4aIV45lGY2RhRw0neATuIQ3uyrEmZBdgpV4bOIpsq
	4Zh52CbWIV6cvqBnbNfgtZlDb/tVBxdSUSRUWY8NzQ3tHaHEJNy/O+1H9jLMl1wv5FsUNoJwmHg
	J0rpYJWeTUA==
X-Google-Smtp-Source: AGHT+IFmtfFEjAke/8lxYfo4OsSOp8uM3h9+s0P8J0frSizxw+YEqVW5nQmvp37Ipe6frpdo53WUg68VwmuiyQ==
X-Received: from pfbeg9.prod.google.com ([2002:a05:6a00:8009:b0:729:427:8d73])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d88:b0:1e1:a75e:690b with SMTP id adf61e73a8af0-1e5b48baff2mr12792936637.44.1734629407246;
 Thu, 19 Dec 2024 09:30:07 -0800 (PST)
Date: Thu, 19 Dec 2024 17:30:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241219173004.2615655-1-zhuyifei@google.com>
Subject: [PATCH v3 net-next] sfc: Use netdev refcount tracking in struct efx_async_filter_insertion
From: YiFei Zhu <zhuyifei@google.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-net-drivers@amd.com, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

I was debugging some netdev refcount issues in OpenOnload, and one
of the places I was looking at was in the sfc driver. Only
struct efx_async_filter_insertion was not using netdev refcount tracker,
so add it here. GFP_ATOMIC because this code path is called by
ndo_rx_flow_steer which holds RCU.

This patch should be a no-op if !CONFIG_NET_DEV_REFCNT_TRACKER

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
v1 -> v2:
- Documented the added field of @net_dev_tracker in the struct
v2 -> v3:
- Separate req->net_dev assignment into its own line in
  efx_filter_rfs & efx_siena_filter_rfs
---
 drivers/net/ethernet/sfc/net_driver.h       | 2 ++
 drivers/net/ethernet/sfc/rx_common.c        | 5 +++--
 drivers/net/ethernet/sfc/siena/net_driver.h | 2 ++
 drivers/net/ethernet/sfc/siena/rx_common.c  | 5 +++--
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 620ba6ef3514b..f70a7b7d6345c 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -831,6 +831,7 @@ struct efx_arfs_rule {
 /**
  * struct efx_async_filter_insertion - Request to asynchronously insert a filter
  * @net_dev: Reference to the netdevice
+ * @net_dev_tracker: reference tracker entry for @net_dev
  * @spec: The filter to insert
  * @work: Workitem for this request
  * @rxq_index: Identifies the channel for which this request was made
@@ -838,6 +839,7 @@ struct efx_arfs_rule {
  */
 struct efx_async_filter_insertion {
 	struct net_device *net_dev;
+	netdevice_tracker net_dev_tracker;
 	struct efx_filter_spec spec;
 	struct work_struct work;
 	u16 rxq_index;
diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index ab358fe13e1df..4cc83203e1880 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -897,7 +897,7 @@ static void efx_filter_rfs_work(struct work_struct *data)
 
 	/* Release references */
 	clear_bit(slot_idx, &efx->rps_slot_map);
-	dev_put(req->net_dev);
+	netdev_put(req->net_dev, &req->net_dev_tracker);
 }
 
 int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
@@ -989,7 +989,8 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	}
 
 	/* Queue the request */
-	dev_hold(req->net_dev = net_dev);
+	req->net_dev = net_dev;
+	netdev_hold(req->net_dev, &req->net_dev_tracker, GFP_ATOMIC);
 	INIT_WORK(&req->work, efx_filter_rfs_work);
 	req->rxq_index = rxq_index;
 	req->flow_id = flow_id;
diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
index 9785eff10607b..2be3bad3c9933 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -753,6 +753,7 @@ struct efx_arfs_rule {
 /**
  * struct efx_async_filter_insertion - Request to asynchronously insert a filter
  * @net_dev: Reference to the netdevice
+ * @net_dev_tracker: reference tracker entry for @net_dev
  * @spec: The filter to insert
  * @work: Workitem for this request
  * @rxq_index: Identifies the channel for which this request was made
@@ -760,6 +761,7 @@ struct efx_arfs_rule {
  */
 struct efx_async_filter_insertion {
 	struct net_device *net_dev;
+	netdevice_tracker net_dev_tracker;
 	struct efx_filter_spec spec;
 	struct work_struct work;
 	u16 rxq_index;
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 082e35c6caaae..2839d0e0a9c16 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -888,7 +888,7 @@ static void efx_filter_rfs_work(struct work_struct *data)
 
 	/* Release references */
 	clear_bit(slot_idx, &efx->rps_slot_map);
-	dev_put(req->net_dev);
+	netdev_put(req->net_dev, &req->net_dev_tracker);
 }
 
 int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
@@ -980,7 +980,8 @@ int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	}
 
 	/* Queue the request */
-	dev_hold(req->net_dev = net_dev);
+	req->net_dev = net_dev;
+	netdev_hold(req->net_dev, &req->net_dev_tracker, GFP_ATOMIC);
 	INIT_WORK(&req->work, efx_filter_rfs_work);
 	req->rxq_index = rxq_index;
 	req->flow_id = flow_id;
-- 
2.47.1.613.gc27f4b7a9f-goog


