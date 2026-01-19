Return-Path: <netdev+bounces-251031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD47D3A31B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EA6230383AE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA33557E7;
	Mon, 19 Jan 2026 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bmrU6kBY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB30355814
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814985; cv=none; b=RwqHEVXKbI0vggZX/7UH1gggL2pNZzqC1qhSpw//sAopdjEQllLqZmeNr5TRsNvG/W8oIDfP26gb73iA10Vp7ml69AA6TTnumKx2tpnPVt8JEdzA+UUxdIyQqXItRFz2ubhX5LBxb6seEJuQIsPkn8D1wcwcQr6QGGuEXwjeJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814985; c=relaxed/simple;
	bh=RWuTHL2vG6VXYYw+aleWdAzTOjFVPPbKCGWiPi4YKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbiK+CiqAxd5No30HiGyhQiz/tmtI8tz7abK2omlh16EmTy0gpWWZeEWrRKb3GDNR3q5uyK+qccOxb192mbcP4S8uE2woVqD/uCovrIwd5MuD3lcYHLrgZ8n0k7aoOaB0eX0CMsB9z/OtC94CCRZoEWIhWGuIWDr+f/jTOuFdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bmrU6kBY; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-34f634a01e1so258700a91.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814983; x=1769419783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=vjuV7rF3uvODsFwmUgtwW6XQmKAPklJaZnLUdsnytz1lYca80rG6evmeoyTlMKvzeS
         lqedOcWwc7zN9t5EwINuX36AwYuGR57Y1KQ0dzt05kHlH5j2rhIIeXBrkZrYtwUur/Pf
         glqUEGffNpKB9X6ucLPo4vCqX5Fb2F4g+yHeSPzbGXH/ZknSOW/pXLZ7kj5lX34+WkLa
         rdghdk9xFeU+z7ZTwKiPIpYgzRdVGTz12JiR2FID0SrF6Ptrk1uYWvXhgh1B7o1qia1M
         0AqHuOP3k1hGR6GxPPJGONGJxX069SMZnpOBxtCA/FPY72fV5Wg/LKdYaypTd3f9WYPi
         l1BA==
X-Forwarded-Encrypted: i=1; AJvYcCVUIDLkQNjXOt6QkXjmvLHWw5ZFs7SvPCCFgJFd6Tjs/EJ8EDHAzZa0uVHI7l2sQlFsJeMRvbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9QqLdo7UA4m3mc/F9lY9ae1eDJ6JW4PMFgrsRqb3eBtJ4e+p
	dIYrFFQyQsVoXlUNyLWHr3Edpgntg0vtE67zqcv16ogEPefIBqQNAIJJDWj64Kvvg9i2OBp8h6I
	4SoSTn4jZKiU5RMrpgruHR303oKRaXN3OvkbchUjxx6GXJY8b9o3n5Im3NAx/cIlg68PQa/iVJc
	8tbkfA4l9DNEp98izqXb77BwzHG+oteg4dswgfsWFKxtVPj5CFAN3AQTbzG1aETXHUZziITu7HN
	05UAsHgPFnZQwxRFgJAGlfeBjsGXa4=
X-Gm-Gg: AZuq6aJMxmlpNevcIkEX13OZp5oSO64wJVZOb94EbXXjZdhujwTlI2jd5m0O7oMK9Uf
	R1zzH98UVLQCP2qPzREuS1V1foa07yUj2Ong+gCwLBHm618y7gpzIrGYsUnKfAW51lpp5bcde5I
	HP8YKiO5HufANpBpwlphs5Nh36/eJSULTu0t1vobcWdMP/nXIWC9r9QeDcKyBW1pdf8SKNyHIFe
	6EdjS7XJqhXr2QC6ziObzCmA8j8qUsMktRSgd1X2eM0YwRyotkY2JCur8OtZNe44ZYExwSooSOT
	nPY9BJp7g3xhRMWvaiRweRrWjIX9X4D5sWfhPxNxr1Zwa/moOk/WHDt1BSohUcW6FjO+V7jBh0+
	w1Yk37u4sCcIqH/yRduTBtNcEqT8peUR6JlC+aVYRSpijoZD6chP2TnOv5InHREa8BNo3GnWA8J
	g/vtBxKtoCGVrsMt+7/r4GDmeZA56Bp4zNnohrHnP7shVUAbukTXdffM0n0Xs=
X-Received: by 2002:a17:90b:2d43:b0:343:653d:318 with SMTP id 98e67ed59e1d1-35272d7a677mr6644105a91.0.1768814983038;
        Mon, 19 Jan 2026 01:29:43 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35272f44aefsm1401318a91.0.2026.01.19.01.29.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:43 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88fce043335so15794516d6.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814981; x=1769419781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6I5h2vtJMAW+jL+bI0U3FZ65rr+yn6OcLWKLyGnstA=;
        b=bmrU6kBY8jgheGuW0E+kX7911OSKXZJPfgWdr6zMMr6NFEH8fHcMd7rqeAzZawHMIV
         BTpM3jGYkKRFqAcnXVxvvSOTrpXRviMx6sY+tzy9xqpHnK/xj1D8Dez33auKxsaWIb9D
         R5j0/wufJUvM7XC8ygefW3PspBtJPosdtHhCo=
X-Forwarded-Encrypted: i=1; AJvYcCVPJEKDh1S7aV3TcSONjAbQ+MPhknMeUuFyqNqv+nwbC5hbebnGLWMTB0nH5HRRnZLPvV9Nv5s=@vger.kernel.org
X-Received: by 2002:a05:6214:4c45:b0:880:4f69:e598 with SMTP id 6a1803df08f44-8942dd7fa20mr139500826d6.4.1768814981593;
        Mon, 19 Jan 2026 01:29:41 -0800 (PST)
X-Received: by 2002:a05:6214:4c45:b0:880:4f69:e598 with SMTP id 6a1803df08f44-8942dd7fa20mr139500646d6.4.1768814981167;
        Mon, 19 Jan 2026 01:29:41 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:40 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Tariq Toukan <tariqt@nvidia.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 4/5] net: netdevice: Add operation ndo_sk_get_lower_dev
Date: Mon, 19 Jan 2026 09:26:01 +0000
Message-ID: <20260119092602.1414468-5-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
References: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Tariq Toukan <tariqt@nvidia.com>

[ Upstream commit 719a402cf60311b1cdff3f6320abaecdcc5e46b7]

ndo_sk_get_lower_dev returns the lower netdev that corresponds to
a given socket.
Additionally, we implement a helper netdev_sk_get_lowest_dev() to get
the lowest one in chain.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 include/linux/netdevice.h |  4 ++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d3a3e77a18df..c9f2a88a6c83 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1435,6 +1435,8 @@ struct net_device_ops {
 	struct net_device*	(*ndo_get_xmit_slave)(struct net_device *dev,
 						      struct sk_buff *skb,
 						      bool all_slaves);
+	struct net_device*	(*ndo_sk_get_lower_dev)(struct net_device *dev,
+							struct sock *sk);
 	netdev_features_t	(*ndo_fix_features)(struct net_device *dev,
 						    netdev_features_t features);
 	int			(*ndo_set_features)(struct net_device *dev,
@@ -2914,6 +2916,8 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index c0dc524548ee..ad2be47b48a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8169,6 +8169,39 @@ struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 }
 EXPORT_SYMBOL(netdev_get_xmit_slave);
 
+static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
+						  struct sock *sk)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+
+	if (!ops->ndo_sk_get_lower_dev)
+		return NULL;
+	return ops->ndo_sk_get_lower_dev(dev, sk);
+}
+
+/**
+ * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
+ * @dev: device
+ * @sk: the socket
+ *
+ * %NULL is returned if no lower device is found.
+ */
+
+struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
+					    struct sock *sk)
+{
+	struct net_device *lower;
+
+	lower = netdev_sk_get_lower_dev(dev, sk);
+	while (lower) {
+		dev = lower;
+		lower = netdev_sk_get_lower_dev(dev, sk);
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
 	struct netdev_adjacent *iter;
-- 
2.43.7


