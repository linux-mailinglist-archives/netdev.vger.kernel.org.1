Return-Path: <netdev+bounces-121458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2218C95D449
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF0A28456D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777418F2F2;
	Fri, 23 Aug 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b7EgIJHt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23ED1917DA
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434309; cv=none; b=JQ3p6VW5gWSHaWRHeSMr+3MGBnbG4BB8vV5ykz6lv+JLYCESLiXLpP2PAsBZWip7koDD1GLOgU43zwSozQCLPXxyX2C4g9xTE7TdGUlivk/m1IBTduR+3WcwUtV/biIGPPewkX4wJKr9eqFhuRn183mg03QWpCebyniY5rU4fT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434309; c=relaxed/simple;
	bh=VNWu2J39++LQzHtTrd4Q6xUHjBc0llUb4IP1EArdOZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2bQDwG69oy7TJCphcWz/rw0vKWyjdXPqcHqLk0GiDVAgPznPxAGiP63oCzjdiHNysSNUaeaGbftoLHRXP0ELwUbdSyBwD6pnb3KL7xKDDS8pj2LFpAsGCMSsHVJ6UFOk3xMF3Mha9n+VwVsgprDOqgCygGMYuntBgP+F40/3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b7EgIJHt; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so1583948a12.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724434307; x=1725039107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yL0MPvBF8bNsfhufIdh1IITs7ZJ9No4pUlKB9Ss45Q=;
        b=b7EgIJHtUTkvQqKhxVwAF7xGob00f5q8CfXcd7qGXd8PgMUOj34bO7KPDgzIcX+27F
         2O48J7fmJ7tCwTVMxHID7qp6H+A3i4F6CYqIjTdXhA3T3KV8JDtqyq/BpHfA7qUXZjjS
         yM0hGzoXmLXtgPT4TaENEKnz05Z//SRu/AgxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434307; x=1725039107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yL0MPvBF8bNsfhufIdh1IITs7ZJ9No4pUlKB9Ss45Q=;
        b=dRuC84gGITx9LTm13d+EGSyvxGyv07gDeIFYLzCFiAg62SoxdvFQmivJLNOyH7Tp9e
         FwtRIgYMaTYxGbeave64f6pgO3UvdQLUT4CJCID5DBA3I1OBK7N26+LUKsSt26pMrIVp
         aBoApSnilOggOZrStXErXUg08tWCnYRWb5LwTejMwcfKuCGX31WqZ05UNcrcfvyRx+KF
         mw+Cc0nFv+pAnGwIXOqkl2SPar0CiQ3+zpIeQRi9I8wqbmQF48YzSoOyNcVGt09IAU6S
         CGsydOzcByj4IkvGWnoZy7m22b4HwisOq+XFGXOgd/tDihEybx2/3OmQnxQ0hnpLjd1z
         8hJA==
X-Gm-Message-State: AOJu0Yz0qoYO0Zp70WRmxY9xX0dvqLPLN3SATeOhc0FcgEf5rHvRbQE8
	wxx05EzxFaSeEq71jXbK9SQPSheXabC6eltXV6X2ojWipE2AIl1t+T8XbNlKLs7xgCSCABRPCCq
	FhPzMt8Rg7VsWwQdoNwMYvz6egLBerlLcaj3zMkZw4BEgxev5XHle2K7E5fpYoMB9yg2dSGcuHa
	ajCKBbjJToIolzNLDLAYbVyDWFrHaJItOW2Sbf/A==
X-Google-Smtp-Source: AGHT+IFmojFMICV8FHNtia4R5sPL+9AeNF/vbaHALXfPws8KtlkVXl3M4m9hBDPIXTtBqi5YwD+2Nw==
X-Received: by 2002:a05:6a21:a343:b0:1c2:956a:a909 with SMTP id adf61e73a8af0-1cc89dbc287mr3646076637.27.1724434300683;
        Fri, 23 Aug 2024 10:31:40 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430964fsm3279624b3a.150.2024.08.23.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:31:40 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Breno Leitao <leitao@debian.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/6] net: Add sysfs parameter irq_suspend_timeout
Date: Fri, 23 Aug 2024 17:30:52 +0000
Message-Id: <20240823173103.94978-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823173103.94978-1-jdamato@fastly.com>
References: <20240823173103.94978-1-jdamato@fastly.com>
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
 rfc -> v1:
   - Removed napi.rst documentation from this patch; added to patch 6.

 include/linux/netdevice.h |  2 ++
 net/core/dev.c            |  3 ++-
 net/core/net-sysfs.c      | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index e7260889d4cb..3bf325ec25a3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11945,6 +11945,7 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_flush_timeout);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, napi_defer_hard_irqs);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, irq_suspend_timeout);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, gro_ipv4_max_size);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, rx_handler);
@@ -11956,7 +11957,7 @@ static void __init net_dev_struct_check(void)
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


