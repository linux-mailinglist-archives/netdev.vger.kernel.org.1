Return-Path: <netdev+bounces-70255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E984E2D9
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B596E1C263AE
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8378B74;
	Thu,  8 Feb 2024 14:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jP4Wm+QT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA87992F
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401542; cv=none; b=aIWCS3HNywTnyMHmOVKbPWwVxHCNQ0b5k7Oi5Rl3QA4z73XPi94KfCBGwZJENPBKh1Cmixj+iHsIxdI5MxCqlViYhfdgyWTm6L+8CbqFFYhNiUVpcbPYvltt0d6abdylsn1Yvxe5W18RiaeyysaSrZdqPe2M+eGbVooi7OQgRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401542; c=relaxed/simple;
	bh=A1AxBIRilVUDb4+CoB/1XBXgN6/J1A53bxW2BFyc0Zw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dSlrQAQLkoETpvEGWWfY+sw76bqDkU6B960ng2N6NkNPzx+kffb9E4b06r3AhbYYU1JMejMBqrT1IgOtH8S0pykgWiqUzGF2hZPllxlczcVfXUZtVh0PvH3VSz0OfwRm3nw/RBGIT5wKkyUaAQr4NMRolpfB8ecZKO9ijxQUV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jP4Wm+QT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74897c041so370116276.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401540; x=1708006340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhbWSbuWjf05VEZa3YQG76+cdv9gP/2iSpbLXiukNbY=;
        b=jP4Wm+QT/yG0d5EQ3r+DKr0PeHafzH60SCgvGsrcg0Ua+pn1vkf7z239GP3mdp9ir7
         0nasxIo0RwL+r61Dg67gzwp+HA1Gq5PGFa+wFZKa290syFMiXV4FTlFpWLsED/ZretWH
         uFkS7W6g/PSG2XBLGjh4GlYsCNr7NnjDJkkOoO/US6QXWZUV+kmJ9lC7Q5UduYoIH6vi
         G1MCJABL10TBkcP+9bR/JTNp6Bc83iwKQhS/wSDSPHuiuj5bouizOIavcnUpHikvT/lu
         y0IPBpmz1dwE9pN4T0MN+gy9cvxZuhdH4ebDV38jjXJKV1+hqjwUg5ckV5/LMV53U9mz
         vElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401540; x=1708006340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhbWSbuWjf05VEZa3YQG76+cdv9gP/2iSpbLXiukNbY=;
        b=HerHIMLgz+oG6e1H8KxScvkKVvfABHb03RRjnXkYOb5rhHjSWr4cInwq0fvYwKbQ2U
         DDegkfh9yPkcgU3SfQffrsx+S3A0qRhBSqo+y1mci7HLHcq037qVWW/3HFbV/PubIM0Q
         MXIl/d9dP9dZNCnco8gcdHR2Gg2undODEO+uL6B8jBQhsnqNyCDmQxi4h4jUYnPQ42GY
         KMLc/k4eDvjpAEv0M4VyEMxQWXMhqp3H4izeBfmA8i5A+v9QXcqJNdOakDqfFlei7KdC
         LHwznSGqVDoDbS4DUcn8arbTKHW4pbc8phJR0pjZbagtyR+2pPfKEubeCEZw/ibzBXJv
         9eaw==
X-Gm-Message-State: AOJu0YzSJDH8NE0BE0X2mubvd3WRUyxuck4uI1RkYepnySb2Zsg+Qmis
	ZD8OquCCVQewQvZxj7RGsElAJj8fEhsVI7ihNLNcXyF2paYubul6eJR7TEaYEv7DoXVVf+TV8dV
	U2/aM5CkuZg==
X-Google-Smtp-Source: AGHT+IFL1J4B8P+9gU4UYt2gWDspe3RylpxuXL+zq/Gbl9qJTJ4ohVSGGjT/JT2wu8g/kfn7vmv5bGOuwAyVZQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2182:b0:dc6:c94e:fb85 with SMTP
 id dl2-20020a056902218200b00dc6c94efb85mr281324ybb.2.1707401539914; Thu, 08
 Feb 2024 06:12:19 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:46 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/13] net-sysfs: convert netdev_show() to RCU
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Make clear dev_isalive() can be called with RCU protection.

Then convert netdev_show() to RCU, to remove dev_base_lock
dependency.

Also add RCU to broadcast_show().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-sysfs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index f4c2b82674951bbeefd880ca22c54e6a32c9f988..678e4be690821c5cdb933f5e91af2247ebecb830 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -34,10 +34,10 @@ static const char fmt_dec[] = "%d\n";
 static const char fmt_ulong[] = "%lu\n";
 static const char fmt_u64[] = "%llu\n";
 
-/* Caller holds RTNL or dev_base_lock */
+/* Caller holds RTNL, RCU or dev_base_lock */
 static inline int dev_isalive(const struct net_device *dev)
 {
-	return dev->reg_state <= NETREG_REGISTERED;
+	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
 }
 
 /* use same locking rules as GIF* ioctl's */
@@ -48,10 +48,10 @@ static ssize_t netdev_show(const struct device *dev,
 	struct net_device *ndev = to_net_dev(dev);
 	ssize_t ret = -EINVAL;
 
-	read_lock(&dev_base_lock);
+	rcu_read_lock();
 	if (dev_isalive(ndev))
 		ret = (*format)(ndev, buf);
-	read_unlock(&dev_base_lock);
+	rcu_read_unlock();
 
 	return ret;
 }
@@ -60,7 +60,7 @@ static ssize_t netdev_show(const struct device *dev,
 #define NETDEVICE_SHOW(field, format_string)				\
 static ssize_t format_##field(const struct net_device *dev, char *buf)	\
 {									\
-	return sysfs_emit(buf, format_string, dev->field);		\
+	return sysfs_emit(buf, format_string, READ_ONCE(dev->field));		\
 }									\
 static ssize_t field##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)	\
@@ -161,10 +161,13 @@ static ssize_t broadcast_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct net_device *ndev = to_net_dev(dev);
+	int ret = -EINVAL;
 
+	rcu_read_lock();
 	if (dev_isalive(ndev))
-		return sysfs_format_mac(buf, ndev->broadcast, ndev->addr_len);
-	return -EINVAL;
+		ret = sysfs_format_mac(buf, ndev->broadcast, ndev->addr_len);
+	rcu_read_unlock();
+	return ret;
 }
 static DEVICE_ATTR_RO(broadcast);
 
-- 
2.43.0.594.gd9cf4e227d-goog


