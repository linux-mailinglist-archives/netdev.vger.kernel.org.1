Return-Path: <netdev+bounces-69844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FF84CCAE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5415F289C01
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B07E576;
	Wed,  7 Feb 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLSpeV1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B487CF14
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316006; cv=none; b=b8jl1lv85R7NDvH3B1UaN+rMA1mUH+REjbys+58iXYY+S2OSdVhYwKHe/K2OaFRGldhOMGgnmFmOuqcn0+BkWDpMHy5NtBpmiDcN0ZnhfjF0Ag7f4fwYDRfVmWOg0ii0uBzNF7NzrxUzqHlwJDFJyI+CeeEdpiUYkhhRw2VZ4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316006; c=relaxed/simple;
	bh=hMaDRYHKIlC6mDinN4ZyUeSrzcmEpWdP98uc0qQFVZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fCqacU2D6f5G4xRA24lzHa/4Z1Pp3/JGPX+7M8tSlDuj/1PzLTH4Yp6mwfMcCyybA3a4hNtZkoMB5bfseTgUrQnLXD1hq0Cws/AYpze/ar8W9OnNM+H6NBk4rwr9R1d662vHXdIQvMU4agFEliT3LMVTaR5mVW7x7knM+slYf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLSpeV1F; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6df2b2d1aso854632276.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316004; x=1707920804; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8FUmQSm0SyTa71msP7ZrPTvJh5Lg0Np6y7f/wDkNfY=;
        b=MLSpeV1FO4dM3pA6bssTUc+oZL7p7SZ6lcYCoal94rMdd5G3X63igj5L6/Pbhlxk1b
         MjNi3At6AQxnomK9J6HMA/Q+iaUyQ5DHwKj3/luuv2r5u3U5/2PnATJdbLmDSNlI3aBJ
         WBewOr0oXYkQ6CBRzk1o9hQpmc6+Iov3wqQnMf9qeXibzccfVGVK98WO3oS6z3D+TpaP
         ZcIsICAbWJZASsTERmWrZbaw5Cn3EstGbxmVnuCW8TGRaen7tFu1a9lGD/C0X+MVUTy2
         1GZbMeL+3DuJRy+WI9Jt7u5qqIn+vtLAbaC22drA6jh+Y1ptsreNL0I2GpycOJAILMSA
         0VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316004; x=1707920804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8FUmQSm0SyTa71msP7ZrPTvJh5Lg0Np6y7f/wDkNfY=;
        b=oKo0iBxRtM4BPPZI1EHtiMq6EL6dtB1ix7n8/8/I3DlRREYQTiJUFzWb9ksAL+ZrxK
         6i9lm6mROL+BlTcYn7C/qKb0a+dlQY5oFmC5wGzqS/LMQbqxXg1g1fzjBDk3gWzv3Wc2
         HCAPR6QOITLNKwqDUqTSyxmUOYxbE7wJHt8IF+iT5smalxSi3FUCkTafKv1CpNQExMI0
         2LAKGQcJoBrBy8RtahLVLaGotMiAACI3Bq9TVdfYH4pk+rsncsnPTzarNjLK2sLFVVoE
         oDMxqlQ9lSwS7vCjLS9O7FsdR4Zy/JyAxFxRhaaeqw57gVWOniHfNbhnpYm+/HY+rfHY
         1i1w==
X-Gm-Message-State: AOJu0YyjURrYzMb/TPY9F60NMCcpkz+RRXVX/jXGKqTuiaL0BtGmbwCw
	DXOyY/Hd0OEypD00LKRZdOpEBp7N0PAOmA9gPONLtlqPh4w77AfBghN+rdKabkz9bOrp9VKEoUA
	oLD0jzjdPAA==
X-Google-Smtp-Source: AGHT+IGQUAXLhw/DVqeGvCkFTANyAtbAN7nJ8JZoSWJS06YtHlHWSVZI0H1HwCGGeYB0L1DgJRbHIGveImHdbA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:220c:b0:dc2:5456:d9ac with SMTP
 id dm12-20020a056902220c00b00dc25456d9acmr178853ybb.5.1707316004186; Wed, 07
 Feb 2024 06:26:44 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:22 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-7-edumazet@google.com>
Subject: [PATCH net-next 06/13] net-sysfs: use dev_addr_sem to remove races in address_show()
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
index bed8de91e91a4bd83fe80f6835643af68f1adc53..b9140499630fa84108a1f22a2987c0c1934e8f8d 100644
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
index 027d0b7976f337df885266aeab2c90fe631decf1..2b96d1ed7f481cbd022368b3f16608cce4c6bc49 100644
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


