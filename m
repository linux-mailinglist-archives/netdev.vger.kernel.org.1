Return-Path: <netdev+bounces-70251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FA284E2D4
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8518828538A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A267F763F7;
	Thu,  8 Feb 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0WsndEFR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10276C61
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401535; cv=none; b=s0S3HZQ42BLbA+TwPuJ0mfzTphdMcPKJ1VwIhXA3kgbo7TSZq6rPcZC+mfIqWvGR36RW8FiLn5zn0WkpZ0tePEzuWDzqiCGASufzrtSbf5Mw2u9O6eYwfVlteTMvmFVRmlfUXb1QUSz3EJFu638keJtGZJ6rDhYjnYvsGtZX3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401535; c=relaxed/simple;
	bh=UPCtezE2ezGvig0UOhbj+qdTC9XDpY4SsUFqiJlhAwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdM3/qb3qVqc9PcJ6laLfQaJGG188oESd3DvgDldcSY2xQPdikb1Xf76kRdyLtvkVHEHTWilRuty/CzrEtIuojLGfBfU5DVApfG7R+2cleWnpxC2Cow4JZOlpJ7ZorF4YCNGFWgOuf8OyqKffzMwCaZkzemDkwpHwjlrGJBr1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0WsndEFR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604ab15463aso7306067b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401533; x=1708006333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UiVAxap0mRx3roHZR74ekKikit7IxM8bcv2tvYhfiR0=;
        b=0WsndEFRyyXu2h0ERuhO+SwHviw1fv4YGsXyo205999xmx9cGg89IW6JymNZ1w+qlF
         6sv4EhEwT6XpkVt7zqSTVKpULV4WCc15cvV85kFpd0tW8ztiS1Bnbh6vAfLFyVMiCP+G
         cuqRQ8QlTbjnuLrEZEYCq57BnIp5az+Qtm5zIthcyKOcDRW/iJGJcM3IwQUEProTRGfA
         9/VEEGkiPjmvoIQrI8o6Ru4/FkH6gw1jSnUVjk0/Aah/nlA5gQO+lJREnZk+g/UVgIPp
         M19UuNGC1fVNZZA12BBSckhcYIYwtl5bJUXDBKfDTf4L2iRogBgJx/DJt310M8Jk2e7s
         5m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401533; x=1708006333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UiVAxap0mRx3roHZR74ekKikit7IxM8bcv2tvYhfiR0=;
        b=jOdb3i0kiav+b8box8Bt+bJYZ/nM5H4/ILmLF/5qMeUUGsIVGNc4xjStrp8SYfFu0S
         LeefLyIlaMhgteCxXct1Hzne4tBvE29YAmfChVlJ3Yo2oZqV8CrNLte2V8FCGd6HPFcV
         WhWX3Vh8HBXa3Qqcecz4xl+j3DQMFuS5e7XV77Swb0o/iUT0u8awIC4454Ik3Y0glH4I
         y6uLirQlbURyhvSQ9UDzK5pF3jBUkLBIZKQW3eYmRF3y+chGPtzfrQ3qlNWdTEEPyGQB
         Elprbq4CFZU5gYyXIr3uMaSathJTSplXMRR9Q3b5GEdagNJrQvVJRfynduQ/OvvvzJg4
         PKfw==
X-Gm-Message-State: AOJu0Yy+BYNnkiNta9EjcMdCjyM2GSgjcUHUdq5oR+IDHiwqBNFJpHjq
	hyjVciMNQ6RHsEpttGzes0kqB0znAkBkk9oFIsuiTNrjXtoXZFhpUkK13EYSQMjg6196dM411Pa
	W5P1GvnzGSg==
X-Google-Smtp-Source: AGHT+IGXY6vtJao46BhxTSuUv6nzqvyyBdON8pqKJtwfT9UzK8d7CFZGtrYPCmVxKw3Ir+CYXBYbJE0kB5Gtaw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2086:b0:dc2:5273:53f9 with SMTP
 id di6-20020a056902208600b00dc2527353f9mr299900ybb.1.1707401533118; Thu, 08
 Feb 2024 06:12:13 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:42 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/13] net: annotate data-races around dev->name_assign_type
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

name_assign_type_show() runs locklessly, we should annotate
accesses to dev->name_assign_type.

Alternative would be to grab devnet_rename_sem semaphore
from name_assign_type_show(), but this would not bring
more accuracy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c       | 6 +++---
 net/core/net-sysfs.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e52e2888cccd37e0df794155004e77261c812ef9..c0db7408fa9f9a3ae9b5b83d34b50663604a5f99 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1220,13 +1220,13 @@ int dev_change_name(struct net_device *dev, const char *newname)
 			    dev->flags & IFF_UP ? " (while UP)" : "");
 
 	old_assign_type = dev->name_assign_type;
-	dev->name_assign_type = NET_NAME_RENAMED;
+	WRITE_ONCE(dev->name_assign_type, NET_NAME_RENAMED);
 
 rollback:
 	ret = device_rename(&dev->dev, dev->name);
 	if (ret) {
 		memcpy(dev->name, oldname, IFNAMSIZ);
-		dev->name_assign_type = old_assign_type;
+		WRITE_ONCE(dev->name_assign_type, old_assign_type);
 		up_write(&devnet_rename_sem);
 		return ret;
 	}
@@ -1255,7 +1255,7 @@ int dev_change_name(struct net_device *dev, const char *newname)
 			down_write(&devnet_rename_sem);
 			memcpy(dev->name, oldname, IFNAMSIZ);
 			memcpy(oldname, newname, IFNAMSIZ);
-			dev->name_assign_type = old_assign_type;
+			WRITE_ONCE(dev->name_assign_type, old_assign_type);
 			old_assign_type = NET_NAME_RENAMED;
 			goto rollback;
 		} else {
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a09d507c5b03d24a829bf7af0b7cf1e6a0bdb65a..f4c2b82674951bbeefd880ca22c54e6a32c9f988 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -125,7 +125,7 @@ static DEVICE_ATTR_RO(iflink);
 
 static ssize_t format_name_assign_type(const struct net_device *dev, char *buf)
 {
-	return sysfs_emit(buf, fmt_dec, dev->name_assign_type);
+	return sysfs_emit(buf, fmt_dec, READ_ONCE(dev->name_assign_type));
 }
 
 static ssize_t name_assign_type_show(struct device *dev,
@@ -135,7 +135,7 @@ static ssize_t name_assign_type_show(struct device *dev,
 	struct net_device *ndev = to_net_dev(dev);
 	ssize_t ret = -EINVAL;
 
-	if (ndev->name_assign_type != NET_NAME_UNKNOWN)
+	if (READ_ONCE(ndev->name_assign_type) != NET_NAME_UNKNOWN)
 		ret = netdev_show(dev, attr, buf, format_name_assign_type);
 
 	return ret;
-- 
2.43.0.594.gd9cf4e227d-goog


