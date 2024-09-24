Return-Path: <netdev+bounces-129630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A5C984F20
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 01:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4E62844EA
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 23:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700EE189BB8;
	Tue, 24 Sep 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SN7GWOH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3518953A
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221814; cv=none; b=Vlp6xHY0g29AN4Z1k5576l8TNtox8NjjqeDzs21fsC7dbiD7SZQMMSt35KS/1+OOsRBu2NUHkNt7AfTG6s/gTGtE2Ls0qhUeukqmEuCseXoH4PgfpGu8gfX8/OReW8BabpifSY3Qntj5qfs6f0l2KN/tH4/6bFlTzaUjdvpzhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221814; c=relaxed/simple;
	bh=aKfbThZziY+zJe/sEOsSqskCgIIJ0wWvJJ6BwUrFoFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITuKDpTuSolxXQpdATIhLHhZFJ2jeW3xiE8kokFhaYn3GqGZDJpRxpsn0+pcU1JgQBmQSLIiWtv5mCXGhnRW6PHsyrscyhDc6YX4hTvKilsY/vVgFK4qec48HGvW2+1zlJqq9SuJ5n7AWcYhxxBnoF30HDZGyzbmLc4G32O1F9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SN7GWOH1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so257088b3a.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 16:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727221812; x=1727826612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ephrADuveWr0WoQSO01HrUAxliNPUOM5o626XgDqmvg=;
        b=SN7GWOH1h5sbONPpKrNH1ZjOYOjSYf8kpS7Cxnu+iXDnlKsqTUNp6gZkm1V/SWbzwX
         GbbA/k2qLMe/tYOkoxblRGwXtMRgJmQNiq1xXtPGitl6PsYtfzDtJHtlXyoLWq7IOmh3
         GzfyL1hGagYi+bPCptURORm3tDS1octrePr9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727221812; x=1727826612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ephrADuveWr0WoQSO01HrUAxliNPUOM5o626XgDqmvg=;
        b=qX1ipkP294qhN4PSyvyoD1rFfhA/VYgcQNqgrDEf+Nd2PfanqCOuK2I24gFPPhwiLD
         pzY+fRVSzUAgLbMpw6gu/9fKC0c6UAFKPJeK6hyrYBkZJdWnat8IyqtrvVqgqbRVdrnR
         5FnxeSJFxJcxT3Pfrv7Z4dqn5bAZOLtjTB30kVI9F7Qwa3w4PgDAJ+d3oFwLOa3wzhdK
         o74gSLmZsvEokIQEems0GtSOKq0Yor8Z/+/XyJzGb2MitjAByE0+mq6PMn2GAxJN+61x
         H7Yila9zE4+yO8lVpWR3W3ysp2e3L6cRdSmwq0GteTPQrNXzD/EgtCmFQuIcqe0QIvRO
         BsZg==
X-Gm-Message-State: AOJu0YypVdpE7TRnFOmjAvWubI7tkWfwkTR2UzXdf1gMIQ8T42Uqk2r+
	VsQqjpj1zhLv35GVIcC/AXxZa5iAaayHYNpg4CBm/iog2hdW2snMQmUCaXJ3+kWiAbQSv0Gv1MT
	vTrH9NRctCmyfAOds3GokfOBgDM2CNfvpPwbWGGxFBaGGpULabjOVowbE1vFUwCYq28H4AZEIOJ
	DNH0ttAAszYwfyA2xiu//axt1XCapazTua4Gk=
X-Google-Smtp-Source: AGHT+IGyR3k6VurgjFF6O7FoORRcK3N5yMFUnRTooixt3+3KRhyqf3O35MTu5WVXQO7eXIYQdpZhNg==
X-Received: by 2002:a05:6a20:43a0:b0:1cf:4ed:ffc0 with SMTP id adf61e73a8af0-1d4bed0b263mr1307733637.4.1727221811781;
        Tue, 24 Sep 2024 16:50:11 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc834c3dsm1684269b3a.30.2024.09.24.16.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:50:11 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Date: Tue, 24 Sep 2024 23:48:51 +0000
Message-Id: <20240924234851.42348-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924234851.42348-1-jdamato@fastly.com>
References: <20240924234851.42348-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_queue_set_napi to link queues to NAPI instances so that they
can be queried with netlink.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
 drivers/net/hyperv/rndis_filter.c |  9 +++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 2b6ec979a62f..ccaa4690dba0 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
 	for (i = 0; i < net_device->num_chn; i++) {
 		/* See also vmbus_reset_channel_cb(). */
 		/* only disable enabled NAPI channel */
-		if (i < ndev->real_num_rx_queues)
+		if (i < ndev->real_num_rx_queues) {
+			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
 			napi_disable(&net_device->chan_table[i].napi);
+		}
 
 		netif_napi_del(&net_device->chan_table[i].napi);
 	}
@@ -1787,6 +1790,10 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 	netdev_dbg(ndev, "hv_netvsc channel opened successfully\n");
 
 	napi_enable(&net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX,
+			     &net_device->chan_table[0].napi);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX,
+			     &net_device->chan_table[0].napi);
 
 	/* Connect with the NetVsp */
 	ret = netvsc_connect_vsp(device, net_device, device_info);
@@ -1805,6 +1812,8 @@ struct netvsc_device *netvsc_device_add(struct hv_device *device,
 
 close:
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
+	netif_queue_set_napi(ndev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
 	napi_disable(&net_device->chan_table[0].napi);
 
 	/* Now, we can close the channel safely */
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index ecc2128ca9b7..c0ceeef4fcd8 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -1269,10 +1269,15 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
 	ret = vmbus_open(new_sc, netvsc_ring_bytes,
 			 netvsc_ring_bytes, NULL, 0,
 			 netvsc_channel_cb, nvchan);
-	if (ret == 0)
+	if (ret == 0) {
 		napi_enable(&nvchan->napi);
-	else
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_RX,
+				     &nvchan->napi);
+		netif_queue_set_napi(ndev, chn_index, NETDEV_QUEUE_TYPE_TX,
+				     &nvchan->napi);
+	} else {
 		netdev_notice(ndev, "sub channel open failed: %d\n", ret);
+	}
 
 	if (atomic_inc_return(&nvscdev->open_chn) == nvscdev->num_chn)
 		wake_up(&nvscdev->subchan_open);
-- 
2.34.1


