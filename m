Return-Path: <netdev+bounces-69843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE784CCAD
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D651C21472
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0EA7E575;
	Wed,  7 Feb 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHz9XbDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E3E7E567
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316004; cv=none; b=lbFbEPhH/G+FjxPlu9M8i+EGOTvQwirHxE8IqdGTUPuP8blhQYmlb3KO4nVssKYyF80V01ObBnvG64Xr1DK4E4RVB7Q4qkxJ3w9kE/yzCU7s5xXGsgbX1j+9dkWpFu/CpBhI7HPtz9dDL/GfsSH1Fm7FXIZ+QelTtpDff/5dPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316004; c=relaxed/simple;
	bh=A1AxBIRilVUDb4+CoB/1XBXgN6/J1A53bxW2BFyc0Zw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y9WQy4n9deS39+fo0iHEVQhIS69LtSdhPAa+h5I0rCIxDl+MhAQ5+8/eHDm9GXSw4imnkWFrhi5n3Y8XM10e8CES4ZKh1vtHKTOTV1+TlC2JqqNODBXBr8/B9hpkSehMPS0Ehiggv0uPb/24I0MUVgRne0qJk8P+51RMx0AfoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHz9XbDY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6cd10fd94so971046276.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707316002; x=1707920802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IhbWSbuWjf05VEZa3YQG76+cdv9gP/2iSpbLXiukNbY=;
        b=zHz9XbDYViz9sCx+MUcLWhj5wq7hiKKpUd8bmiuv5iCkRTgo1Ey7GMVeeWzvvO0GDx
         NYbzWtDfOcGZ/CsynpTW5vHnKE68sSc68HHTPrb68XFDzd3a1lf3cWgUdi4g4cAhD89A
         Rt5CMNiSif5bT17nlPHZHMEvFEUk44VIULVjNV5II91wgM5kUiyhYRZcCQA26wszJHXz
         ZWPaypVVor58OcByQZzxN4MhjILt61RMewebMzLxgo/9564Zy9smz3I1rJaPZnXkYySd
         5N7RKVD8B7jnlbzlOFLd60PHCO53XUvDX8i/wnsF9XXknOjLCiZFF/qLv/eZ1csDL2h9
         Rsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316002; x=1707920802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IhbWSbuWjf05VEZa3YQG76+cdv9gP/2iSpbLXiukNbY=;
        b=g7rKiKCY4ASfeWxXsBPVE2LeLVlY4mPWDMVQ9PmAPUAfyJGz9J7bk9NDioboY1uB+9
         fif5dFmtAis0Gfi1kYUlWes6acdsSRT8Czs/180Mo/L4hArcc87V/ZXY8k5FncfDKynA
         q0TWcgG877SUi8ywGwMCq+KeI9NRdqqGKMqB/5ymUvsJDorCeH72/z13oBYwmgCvJRHU
         70QM3sGYyduSqr638wIa6fkTSKNpQaQZSBwAz3GVUWWfA3HslZUMDhRJQeEoOilMDQWD
         46v7Lx1NEkwitYzWjoYnb6ItJiQcyeIotcLU6kOc/tZH9U109OhUVG1yri/GGE+bz2T2
         m7TQ==
X-Gm-Message-State: AOJu0Yw2uRvRmfnMmthdHydT/In0eQqcX5nFD0/vTHRBjIGLflEw9T2I
	4ZJNSIjnt1eXi68HA2/c+9B43fn5lRWriVHcnxap6TDWh1Gni+PcRp0WtVZ431Oi12JAm1j1ufO
	jRkBSxTdTmg==
X-Google-Smtp-Source: AGHT+IFA1YkTDDSyFBuvjfdqiCmM8AjRiIg4cuhFnyfMi/bpkhEVW5CNzKW3qxWGavMBCJ2Wmkxfifd06MTitw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b91:b0:dc2:23f5:1791 with SMTP
 id ei17-20020a0569021b9100b00dc223f51791mr1219089ybb.6.1707316002457; Wed, 07
 Feb 2024 06:26:42 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:21 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-6-edumazet@google.com>
Subject: [PATCH net-next 05/13] net-sysfs: convert netdev_show() to RCU
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


