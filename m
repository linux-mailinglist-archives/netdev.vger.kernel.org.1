Return-Path: <netdev+bounces-70256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77C84E2DA
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D116B1C26A8E
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEC7995D;
	Thu,  8 Feb 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SetsckBf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1B79941
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401544; cv=none; b=Xu2fCjpPQXMBwBpjL33wwWsT1DIUv93nsk6LMsQOdPvuDJsno3A2Fj47CKyayoJ+JXgk8AU919LcEmRycUxafJbB4IvgbRfSU1PGoZa+2wk/XftD3QeGps++6boeBR/sOnJCWvaWCDcb1B6emGdn4ST+yjYXfs3W6bHd2VN7xuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401544; c=relaxed/simple;
	bh=o/c2SVtOn7VLpRdUQiD7yaoQZO6W+ldb//S/aYf25PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qT5m+4FHkkabq6YPfdVxYSPbCd/x3y+bcnlfiy9SUrSVVtdAefNAQS8mJCi7COD4awWszaykBxTVecMcFHEXXcG2+iQI6WKhPXS7HGUnJpi2ygk2jkf4qLUh2UyJw6xjh6etx+qHmDEo2WvGh9iEJYYOCTQarYls0uf1ePOENYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SetsckBf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso3054842276.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401541; x=1708006341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBwdO2teN8myEQ5wIk3WQ7270BDExc3GOf+cz6wVSh8=;
        b=SetsckBfNnIf2q5BhoFk9/hbWyh30QVnd3r9+OsntS8HpqBXaZVOw0rBNq3myGMbw9
         JR8rMbuyjUhtI4/DpbPIQ6QZavstkU3ZJaVsLM9olLM0+B56ZrApeFAfpLjLSe/b1z6t
         56KhPiyqbPpxO0f/v7PqbRZE7RzSG1oQGVuL1KeBGIbGGsS+uYEixfbpwq6IWjApBytq
         uxhaUccwAGbTGMGlc8rpYhWaF8URMyZfhacXfNFsg2IMKfZuR3mGJ/9iOdo80T3kyQH7
         VjjigXo7kms3j5CQykmwu2UAwHjByHhgcTtNnVd1sOhtonqNy2z3xc7qg8n7y5QuXBwB
         0MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401541; x=1708006341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBwdO2teN8myEQ5wIk3WQ7270BDExc3GOf+cz6wVSh8=;
        b=IF2Pg83VdHKPHv2r4OD3hLkwMPc1SM/ptPYlDR98RTeeAa+OfWtfLOSSwMlD9rB8OP
         BbYmqSWvCpM6esbApOA1T6CnAYAC53hrSueceqUw7yOYMasA3wwmL/t8gZjU+qi07izY
         hWU+5U+baUIWtjc402aroUQTfgfLMK1bCAGBPnH5B7dSuMQddvpHpNq8gv+9r/scFk/I
         HT5JC8LkbzEzaIxN1LCRHXbbN/wpKF/700Z+OiE2OQSmQVetaVhzSBUNmGb2+HctDjnP
         Ucon4dpUN+NkRmw6rcW99QoADjj9dB6Sakq878VNffxoj01rONyfPEQ5D585PW83mSih
         W9qw==
X-Gm-Message-State: AOJu0YwNmgJuxks58fI4V5eN39QnGUX9yP6rAfKU0ZzyWLH283FBSYr/
	Fj/ncPoFP6SD3nYrPz1lSyE3eRBeRch/90Oe3MKngbiWUbLMxt32LRe9U6AUeNxRxX+JOYdmsgM
	ZB1NgE/4HpQ==
X-Google-Smtp-Source: AGHT+IERSioINR/0EqDu/60Og1gKwPDU/yccE2J4eUH3gwicagv14bIS/DzKA24KKqdl1T2ciSWF67NwBJt/JQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:98e:b0:dc6:e7c9:b7d2 with SMTP
 id bv14-20020a056902098e00b00dc6e7c9b7d2mr323000ybb.10.1707401541670; Thu, 08
 Feb 2024 06:12:21 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:47 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/13] net-sysfs: use dev_addr_sem to remove races
 in address_show()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using dev_base_lock is not preventing from reading garbage.

Use dev_addr_sem instead.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            |  2 +-
 net/core/net-sysfs.c      | 10 +++++++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5f138025d5f189cd5ab7bb0434205b66d30e60e7..636bea0a3587bd1d73389f2fe7f12b726bf56824 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4031,6 +4031,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack);
+extern struct rw_semaphore dev_addr_sem;
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
 			   struct netdev_phys_item_id *ppid, bool recurse);
diff --git a/net/core/dev.c b/net/core/dev.c
index 89dbba691c9db83102d15074b6ea96312689be10..a69c931fca7bc5904db29a217779981fb6858e54 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8922,7 +8922,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 }
 EXPORT_SYMBOL(dev_set_mac_address);
 
-static DECLARE_RWSEM(dev_addr_sem);
+DECLARE_RWSEM(dev_addr_sem);
 
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 678e4be690821c5cdb933f5e91af2247ebecb830..23ef2df549c3036a702f3be1dca1eda14ee5e76f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -142,17 +142,21 @@ static ssize_t name_assign_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(name_assign_type);
 
-/* use same locking rules as GIFHWADDR ioctl's */
+/* use same locking rules as GIFHWADDR ioctl's (dev_get_mac_address()) */
 static ssize_t address_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct net_device *ndev = to_net_dev(dev);
 	ssize_t ret = -EINVAL;
 
-	read_lock(&dev_base_lock);
+	down_read(&dev_addr_sem);
+
+	rcu_read_lock();
 	if (dev_isalive(ndev))
 		ret = sysfs_format_mac(buf, ndev->dev_addr, ndev->addr_len);
-	read_unlock(&dev_base_lock);
+	rcu_read_unlock();
+
+	up_read(&dev_addr_sem);
 	return ret;
 }
 static DEVICE_ATTR_RO(address);
-- 
2.43.0.594.gd9cf4e227d-goog


