Return-Path: <netdev+bounces-70636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596584FDAE
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87F81C220DF
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95195125CA;
	Fri,  9 Feb 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dthAc9Hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5310953
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510905; cv=none; b=af3SMBogVKWQU8gHZTc9EOMnQBQulSPU3+wwhboMC5O3mRkDar8z8r+5vfhkd7dHmQveeKcv/CSEZ6FxA2a205Rcca70uhDE8VwTD9OVB1MC8az9+kihZwKCz8oT77Fda71eHJTBca5CDWRW091pYczkFfAmtfFG8vbNOIDXVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510905; c=relaxed/simple;
	bh=7pqrGzbpWYJEJI08SpJPboTuMzmU/rW+dYExYdhy5U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jnp2VB+Fz+asMrCXaRcDYa0o15OdqnEymTqr21asSrUO+/huwwZ2/o5acko3DG/OpfHRRZ0RxVseJ/uQSw0KUuBjEiBq5dmAoV6W6nCFXEM0llClRlirwLlRM6mvmx8i0ec0tJHqoBssZTlNBZPshELNiI5UN2i84Agpu8QDWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dthAc9Hu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047f0741e2so22943517b3.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510903; x=1708115703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4VWoYyboQTF1nqDxdUJGRhH/tbxg5kkeje8iYCgLL0=;
        b=dthAc9HuhyXukMDAeA6HxE1YNw5IuwkxYdU7GjZlEYMI/z1dkWi1NViwkr6TugatYh
         kibZ0l0JJ+q0ze0xFWRp/wwGDsXC4Dadc0jrmP2RNLi9lXL51I21ygCdcz5LJjNf2Vi6
         dwccHiqRYwKMk++WB/EMDts8cvqB9c8WNsM7PEAbjwHLQiGR0hX56P/JAgezoVIrwQLb
         zYsdP8uW+NDxLYyXS7vwGwL8eR6tw+BQVRA08PRDNNL3rvtw+93QL9RChizCd9kLJWmt
         SPmeFJonlQpxN/VB0CS94DHh0gYDxOWYzzXb3abIHAZGtbb3jIMCtPw3mOUNuG+g4ekg
         pdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510903; x=1708115703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4VWoYyboQTF1nqDxdUJGRhH/tbxg5kkeje8iYCgLL0=;
        b=NrQrprBuD/A1JoXNSVwRiOFe/NDGD4drfpcNwI5qv5Zst4MkUgTxd+jkrPY8wajTXf
         ox97nlPgplXkKg6KJ608atdSBRj7jz1fDhtI9n/s2DODwp6M1mr14Dw92k7iBsNPmsWa
         BQMsZRLUeomrre3Cnl6CbjTbrsRzEs2Wj8/mDoLqmJwLN2QhNkzuFRwQsG6vIfIztxZQ
         7YiOg8BOU+mrZj4jW2lgSyiu3WOlpsMmMTSoqWnw7KNH466KvEKuygeLmBDrPe3zp7sV
         VrT4WkUf/9LimGdxKpVO+CaEj7KuI7Rfnb3hxo4ZdUG/hxcSPs3nQ1Z8OTTx//TWXTNd
         zMYA==
X-Gm-Message-State: AOJu0YxfIYJvopbnG7GCP2FfvsapAoOWfrREtpJ7PWA5vaKpE0ShHjCQ
	lBtBfxtbVyb7wWaGqijTVJaVVqUJ5qv6Q0Icl50OdzI20fJVvVPLnJv7Vg/18YwnT1eJ3LsDCdP
	gDj8IPylCJw==
X-Google-Smtp-Source: AGHT+IGPQ7nOE5O3ura/TL7sa+3937E95Bfa+GkfnqtlT6DFWJIoR8dYSofVXT1UIDQODApLb3A04jsExXiX3w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:701:b0:dc6:dfd9:d423 with SMTP
 id k1-20020a056902070100b00dc6dfd9d423mr5399ybt.3.1707510903052; Fri, 09 Feb
 2024 12:35:03 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:20 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-6-edumazet@google.com>
Subject: [PATCH v3 net-next 05/13] net-sysfs: convert netdev_show() to RCU
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
2.43.0.687.g38aa6559b0-goog


