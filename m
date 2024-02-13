Return-Path: <netdev+bounces-71181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9B852905
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0714E2844EE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE643134CD;
	Tue, 13 Feb 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aaFa9JNI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0D17562
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805981; cv=none; b=bB6+N5sUQf4PGVnBBOlSiAT4gHNWaEiFo7INOjpwdRP464Cz7wyZCSjGlIJX8pvU4TsYIl8zNkJQV2FFQN0G+gGRsISDgI5aYjdK+a/tcf3TYzAyIphgtCA9Xe8UhbwU0ayUcOtK4xTghJcoH8DdbdF58zgJPKHkiZPMsO/l5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805981; c=relaxed/simple;
	bh=2QEWSDrKcwOJ8yFatOKq0aJznOY1GszOklLPUK+O8BI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SSLLhObU12MuUuJycRusYwoEGQ+PIIez2OTxT5rd+GSBVTDTHEM6PeGV/lzsDv02SYJ/arWCg9WG7cyM2XwfvHxblEpzqP57OFsB6nxiW1ZXtGK31GiCoaYhHIbxkx8ibuQO6d1UFjaQSv4IfD11ryoMPKZb8Ps/Ig4rOI8ttOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aaFa9JNI; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-42c6d28d780so45347861cf.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805979; x=1708410779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1KqXMYa2UosTmP1duRdQrY9TNrdN9X/3nB8QxfCRp4=;
        b=aaFa9JNI8S/aiOLxjr0UYAQOeprYjxvbREHxn2TDCAjqQN/pE3EgD5Sa6son2xX8/i
         uVIg+UGqlNlYJGmtSukbW+Z28zN+9i6oydOj24w/S5E3teCb3UrQOGWBX6UML4rEDaG7
         9LMcMw3G1JyRmXq0GK6q2ImCxF/y30kfHPT1abtkQtJv1zdesx4wGesVQGeS9JX6nAyt
         zbAop7mZhIN+9zBEGeczc69ml/g9xY3o968ADtxOiUoW/zF3Ey5MKbYr90tgOEvfrD2A
         N/NcuAhF9iauMG276EaPvA77O6QXgZRfZXrtM+P8vZ3vAIdpqiDtVLOcRBUEmokMXrWj
         I9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805979; x=1708410779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1KqXMYa2UosTmP1duRdQrY9TNrdN9X/3nB8QxfCRp4=;
        b=cb756w0I1o/sgxUY4CZ4E316Ds8Jf1duqgf54ALhZWWa0um+HO6JDscLqmCkpATMSd
         Uj0Xnvoz1Njw5ESxMlgiIpzAyyoDUZxqF3yFzFJirY9XN97A1XlbJxUamhx9+j7oy3Y+
         pBC7+nEJIE9xzhCD2MP56zdWNz0yoXf1NxVUZpSQXfJQULuffbcnvOPYhkB852C40Nx1
         VNHADVcDxo8AUFNf4gihXf31JUxMVPcSBK5e43QPAyTyym8BvqrwUeXXcLb5hPNIM60r
         xmDvI1xi4k8kwaCavAivX4il4cdZXv9oZvUkczT00tFElA1CKHN0nqzIokk6rYoq2wq8
         XSGA==
X-Gm-Message-State: AOJu0YwJAr3JKPDD4yzo53Hv9UnDZzQ6gVDJcvTeGojVZpy46vQowsbj
	HYwhCyoQs6zekbVAwiFlZm5jHT43QQJE5yC80uN1EKCFaKD+Uvd+omQiv4pT4TAdM5f4VJUfih3
	F6iLAXNxlRQ==
X-Google-Smtp-Source: AGHT+IE8TY0Zc2tXrC+fGi18bIjGD19yDtMntMeLJ65mOCZCQFfCaYaY57/D3e2X3C5GRLhtN+ky44lpwKF5TA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:5a15:0:b0:42c:5c99:2c9f with SMTP id
 n21-20020ac85a15000000b0042c5c992c9fmr38449qta.3.1707805979182; Mon, 12 Feb
 2024 22:32:59 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:38 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-7-edumazet@google.com>
Subject: [PATCH v4 net-next 06/13] net-sysfs: use dev_addr_sem to remove races
 in address_show()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using dev_base_lock is not preventing from reading garbage.

Use dev_addr_sem instead.

v4: place dev_addr_sem extern in net/core/dev.h (Jakub Kicinski)
 Link: https://lore.kernel.org/netdev/20240212175845.10f6680a@kernel.org/

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c       |  2 +-
 net/core/dev.h       |  3 +++
 net/core/net-sysfs.c | 10 +++++++---
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c08e8830ff976e74455157d3a3b8819e8424f93c..ddf2beae547726590b1f0bbad3d40c0556d815d2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8951,7 +8951,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 }
 EXPORT_SYMBOL(dev_set_mac_address);
 
-static DECLARE_RWSEM(dev_addr_sem);
+DECLARE_RWSEM(dev_addr_sem);
 
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack)
diff --git a/net/core/dev.h b/net/core/dev.h
index a43dfe3de50ee75ee0f4b290b385378ed4a6cfdc..45892267848d7a35a09aea95f04cfd9b72204d3c 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -3,6 +3,7 @@
 #define _NET_CORE_DEV_H
 
 #include <linux/types.h>
+#include <linux/rwsem.h>
 
 struct net;
 struct net_device;
@@ -46,6 +47,8 @@ extern int		weight_p;
 extern int		dev_weight_rx_bias;
 extern int		dev_weight_tx_bias;
 
+extern struct rw_semaphore dev_addr_sem;
+
 /* rtnl helpers */
 extern struct list_head net_todo_list;
 void netdev_run_todo(void);
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
2.43.0.687.g38aa6559b0-goog


