Return-Path: <netdev+bounces-117700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01E294ED77
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52F8283583
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC4F17BB0F;
	Mon, 12 Aug 2024 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t1qzOMRC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725ED17C210
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467462; cv=none; b=Eg4Gvw60RYy/kGLoA75oyVIPkuIsoGHbVQnfoB6QiXJu++8OOLUvoRxZui63SODNNJ4HuYnNC8OMq3D35XbbooT6dr8eIgFeQ3W2eDQkR6zBBWSX4h02mVTUzMfpIwBonQMtqU4DBPz4itGn78++X6g9ZdNprxctNc6O7Teg+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467462; c=relaxed/simple;
	bh=UU9YetgXXPCskdk6gOfxmmZ7JeMKgrNe4FVwpCMuu7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXjNsYYh5Da8D7PJs5Pg8byVq+dwAtmKhxHex35jr5DwCSxXbIFYc//QRO17P+YpvNfn0l408ASEV+gU6eul5Vii8jws+H4atjv6rvgdMjxHzxgTrvGFq6dUaOnAY4g1JnNZw4hsNRbCQFAp4d+UI/aBNGqY90Yg7q2ewvOw0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t1qzOMRC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d28023accso3369026b3a.0
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723467460; x=1724072260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRh17J0oYLnjpYt6fboaKb0SXYeVubbfK7YpxWdImGw=;
        b=t1qzOMRCzLoLVFMdl9j4OULHGrKVqNM6OAwft6kY3ZNdygezIUd5b9eA4/rZBNby+u
         tTlUiRQXaHfPZOIo6nFV1Go7/BMx48zGkIGbuWSYo7QFj0OPhGC766pffV/1WAtx/eDh
         9V3y/Bc969IjfOQd0PWvHcJ3Eut5ftI+i27Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467460; x=1724072260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRh17J0oYLnjpYt6fboaKb0SXYeVubbfK7YpxWdImGw=;
        b=DetmF89RetBOqIngjMH36tcRTcKwso78pLdJgjZiTm2wwV3+cEfZu7WlQnktBtQMuq
         JG2MXwgUhIEcu2ieGEXTgq+0d1f1Mta4FyGxCoKfNvl6vNDDVpX5Qycz9Z1UoRQ03mX7
         DKKGvfddyRYDUMqT7XnRw9Rf3m0Xijefs/YDQdR5cH9dyIGQvJ2MII9P0JrnFJW5XkT9
         2aSSjt1HJLSJwWVIFit94k8Q3ZPLxrLJe1d+HSUW2n7Uo+8XjiopuEOFd5DOOg8CPfG2
         THBFzEq9gTuIg0jLOf6yezcvO/Jn1eLBie3KAotJNoBp7QVP/FtlWKJbQQHw+Dmxp3nj
         0nqA==
X-Gm-Message-State: AOJu0YxoWxEpGkE5MnPyl+NRNc+AAiyCryM4JUi1s91XvFCkhCjN8q4Z
	NCNwqCiapP1mMqRLyDFhM0Q4DoqLGDlTR/B78VSCY5sqTC/qo4kuZVRG8vAehb8ZdrXivtHdI8B
	329bHg8eFJnowafLvz1AM9qc5gY2Iy2MKCHxYVgSQCjIrWBKWT7IiRZffsGjwiPRTHR+c/pIu9l
	kAv3VnZ6rChqXJ/DzI/STHoR5oyPyegIzTue2B0Q==
X-Google-Smtp-Source: AGHT+IEq9qb5amGbSMq5W4M/QmN7S0NtNcAlbtlnwHYghOllBYYxaVtW9gHS8KIZ2Q+wiEkV50eorQ==
X-Received: by 2002:a05:6a20:c78f:b0:1c4:a49b:403 with SMTP id adf61e73a8af0-1c8d75dfd98mr314810637.46.1723467460243;
        Mon, 12 Aug 2024 05:57:40 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6fafsm8183368a91.34.2024.08.12.05.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:57:39 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 1/5] net: Add sysfs parameter irq_suspend_timeout
Date: Mon, 12 Aug 2024 12:57:04 +0000
Message-Id: <20240812125717.413108-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812125717.413108-1-jdamato@fastly.com>
References: <20240812125717.413108-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

This patch doesn't change any behavior but prepares the code for other
changes in the following commits which use irq_suspend_timeout as a
timeout for IRQ suspension.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 Documentation/networking/napi.rst |  3 +++
 include/linux/netdevice.h         |  2 ++
 net/core/dev.c                    |  3 ++-
 net/core/net-sysfs.c              | 18 ++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 7bf7b95c4f7a..0a029dd6d77e 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -192,6 +192,9 @@ The ``gro_flush_timeout`` sysfs configuration of the netdevice
 is reused to control the delay of the timer, while
 ``napi_defer_hard_irqs`` controls the number of consecutive empty polls
 before NAPI gives up and goes back to using hardware IRQs.
+``irq_suspend_timeout`` is used to determine how long an application can
+completely suspend IRQs. It is used in combination with SO_PREFER_BUSY_POLL,
+which can be set on a per-epoll context basis with EPIOCSPARAMS ioctl.
 
 .. _poll:
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0ef3eaa23f4b..31867bb2ff65 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1857,6 +1857,7 @@ enum netdev_reg_state {
  *	@gro_flush_timeout:	timeout for GRO layer in NAPI
  *	@napi_defer_hard_irqs:	If not zero, provides a counter that would
  *				allow to avoid NIC hard IRQ, on busy queues.
+ *	@irq_suspend_timeout:	IRQ suspension timeout
  *
  *	@rx_handler:		handler for received packets
  *	@rx_handler_data: 	XXX: need comments on this one
@@ -2060,6 +2061,7 @@ struct net_device {
 	struct netdev_rx_queue	*_rx;
 	unsigned long		gro_flush_timeout;
 	int			napi_defer_hard_irqs;
+	unsigned long		irq_suspend_timeout;
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
 	rx_handler_func_t __rcu	*rx_handler;
diff --git a/net/core/dev.c b/net/core/dev.c
index 751d9b70e6ad..bf45c90aebcd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11937,6 +11937,7 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, irq_suspend_timeout);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -11948,7 +11949,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 104);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 112);
 }
 
 /*
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e2084ce7b75..fb6f3327310f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -440,6 +440,23 @@ static ssize_t napi_defer_hard_irqs_store(struct device *dev,
 }
 NETDEVICE_SHOW_RW(napi_defer_hard_irqs, fmt_dec);
 
+static int change_irq_suspend_timeout(struct net_device *dev, unsigned long val)
+{
+	WRITE_ONCE(dev->irq_suspend_timeout, val);
+	return 0;
+}
+
+static ssize_t irq_suspend_timeout_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	return netdev_store(dev, attr, buf, len, change_irq_suspend_timeout);
+}
+NETDEVICE_SHOW_RW(irq_suspend_timeout, fmt_ulong);
+
 static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t len)
 {
@@ -664,6 +681,7 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_tx_queue_len.attr,
 	&dev_attr_gro_flush_timeout.attr,
 	&dev_attr_napi_defer_hard_irqs.attr,
+	&dev_attr_irq_suspend_timeout.attr,
 	&dev_attr_phys_port_id.attr,
 	&dev_attr_phys_port_name.attr,
 	&dev_attr_phys_switch_id.attr,
-- 
2.25.1


