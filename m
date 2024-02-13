Return-Path: <netdev+bounces-71180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2731852904
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99938284261
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96914287;
	Tue, 13 Feb 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qe5SlX4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898B1756A
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805980; cv=none; b=UyGx69EEKzuqOD2YRZBTC27TCWkcJtF1OPNav5qKU4a9nA+o8WG+BJCwb7VbHXj9PgMo8o0fQ6JjCYPNDeY2JQVi2jCAI5Me+bQHCztn/XycC55SATgvRM52OuMEH6HqYQf6nAi1EOJr+wmMyvEFQUcns63Qg0OQl8kQtFaaAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805980; c=relaxed/simple;
	bh=7pqrGzbpWYJEJI08SpJPboTuMzmU/rW+dYExYdhy5U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m4+IeADKH+pTSts282R5mycjnFLSWBkAN6I8AEGUswg5+BUOTQtz0miXkmZoO6l0xQYXwvKV4hANLizmQMZxb3NS89ZJktcopWh4kAkhWQRHQeYXNIlpLeUHSocbMPfLpFIMKWevfYem3dA18jPLVpGbNX75RC8DmWgSyugFuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qe5SlX4q; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso82852787b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805977; x=1708410777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4VWoYyboQTF1nqDxdUJGRhH/tbxg5kkeje8iYCgLL0=;
        b=qe5SlX4qTces5i1Yo2x4ZWjcSfwWv4dKXPkfTJDqQKGgfGWXmWGr/FBKA2+GKTFiaV
         xIlZFND5CQscVR22p+W3tlsSN++bK8zVKnO6ehspci4yYzJyFKr2vL9WbPhBfIbIp+Si
         T/cJ1qMITyjoZzYIujCKfXHQU6jxFzUz8ginFrsMXcRovgBZb2XDywy6DFDQ/7HPY5Z1
         UAoRtYZSYRoOcvIzo2rcLWfngTDKd8ncI6FIrf1jRUgiwUDH7i2TXgkmHClbW5VA6PoG
         u/kg/SN+uSNSARyI9MgdBbf9a7Okl+Mg56B6HmxqCLkTK6rqhk487LYF3Isk47RMRf8Y
         mveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805977; x=1708410777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4VWoYyboQTF1nqDxdUJGRhH/tbxg5kkeje8iYCgLL0=;
        b=gny7/4sG97wb4fe/TagGc94RbuAc9/+pXr2ON4aeb1KYeNMsnMVcYHPYlC8cETgMq8
         LBHoTMnMcBQ2+4atNkUnCRvQTFxgZjNz/9POFDAhldZDBFkBnkx6Y1q/y43CumIWDYis
         WWvt7etTPpmgHsOmztFhgkOzrsKA4SbLI805DMlSc8txoOewFSQb4K2r1i6MkhD2fOPT
         Yiu9ckU0s8Ht5cHDJuIcqFp2Reb7Kur9pKNGgrr18wU90k3HcRXzhrAVU14rN/O36ISj
         kehLq8ENaiGNlZMjVWf8EQPkvkGFkDAGhS8W5YYrP99k0JIapbfEddNT3LgDnQ1jbzy9
         Wawg==
X-Gm-Message-State: AOJu0YyqPSDSBQ7wwSrMM4RV+D9VfQFWHijvmWestFqD8Bi6UXFu+J7J
	3bqe/bBVDgNxJKF68dCJuTvFnZ9+3Hld1IPMZgqlrVls+PKu5003xC/UovBZcyTYtpj7zmmI66v
	f2RivGcYn5g==
X-Google-Smtp-Source: AGHT+IG07ZrZh1u8wcRPOx2P2zvbxTeSnVkbPzKNoz5ategb8zbuHELX6T/B+r9qzuEGcYH4g3XZxwN0N1hdWA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3505:b0:604:127:3652 with SMTP
 id fq5-20020a05690c350500b0060401273652mr2350832ywb.5.1707805977782; Mon, 12
 Feb 2024 22:32:57 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:37 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-6-edumazet@google.com>
Subject: [PATCH v4 net-next 05/13] net-sysfs: convert netdev_show() to RCU
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


