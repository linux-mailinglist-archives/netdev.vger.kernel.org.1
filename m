Return-Path: <netdev+bounces-70632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CE584FDA8
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089D31F27A29
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79509D282;
	Fri,  9 Feb 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjU4C7En"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B653A9
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510899; cv=none; b=gHkJQp3W334jHp80dMuzG3uAg1k0PXHkTQwrC4cbAyGep5vouRQAQ1F9u+Cu2xUOVX7TtG6JkRetZkFrXS7Qa/HFHJ6U7KQe7qGgrRetQIcfdgNoTc3SgsILoEcKQhP7Rn1+ZB6UXJQ382++dGUCfoHNHhghfIslRuUnHuJsrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510899; c=relaxed/simple;
	bh=cdKCPvWGrytWQoOq781ZjgIyFr8yfYYxG9X79PNEWeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SIPDpSy1x+tURep9iSE2WETBy5AgHnOT6uOyOCR8vFHNNE1hbpq1GfYoe/v+SfadjurHd8ZKqNPNfYosXUR9aQrFqgrOpX1rNZTv1Yx6LXDUMelJcPcWtl1NUXJbSm1flrS/dpMuVVmIq3o1iBBdJJK13AdxUwlIi5+OpZLiMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjU4C7En; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso3236424276.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510897; x=1708115697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAGRx1rPz5nsaCJ+gWH3UX9hC0FJNWT4gFXf5sNBQg0=;
        b=QjU4C7EnRHL61AKYJlR+Ez3gy3w+TDTOyHPuf/ZlAZf+9igiynFXjid+Q1L5dcEcFN
         NsdMAnAhXjnp/uM/LAg6o+nuiImjm3XlBxd6Oyz6Jr4YuwFrfLwGZyAyl81TxfmEDjss
         mWZdxblTVz9CkyqE388HpzasXIrI/XtP4iET/8GyxsELU7HLTHYrCFwGBOibUfdpobT6
         7ldvvKXsSULeINKDlP0jVIas2oQwSaQBtMHbiNyYgRqZpwekrfuvCwirJYPZ5SUcr1M9
         FdAjwOGQ7WEK/RxidIAtF0gphxrm5/1L8ajnzhyIRcNRWmSlOr1QD1vEdr7bhjD53DMH
         X2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510897; x=1708115697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mAGRx1rPz5nsaCJ+gWH3UX9hC0FJNWT4gFXf5sNBQg0=;
        b=m2SM2FW9IrXxN5TBcdtSuMVspawxJ+CEE/R5dhasMyCJxQuDukuLKk203fy5iVGMbw
         YM4q3iLmmMIWe1HRdjDmNJ+fLZdpxV1urQmnNcOj+iO29Q70P0KOa6mTThK+WZRKu0Ng
         /+qMXDucuUPuD9UZYG2IoWg0KZ8na1a1/j5OXk1y0ovOVHzk8R+Ly97tSuI/BtWHSdyM
         iuMrosFHR/21cXVDFJmh9TsW4TaNhNPQIOZbRTjZV5FgHlRHakF13oTlzRt0dNCUnECF
         J+Zd9EK0DB50ZkMgBLz44QXzrSx4hLJcWxDn+YfydasGyv0yV6n4Kr+Ovx45cu+qrH6S
         OajA==
X-Gm-Message-State: AOJu0YxfkM9SUgXbVLCSdfzbItPjLEAnAtcWwO/o4iWEGbBS7QbN7pJj
	skgD7pQN3pDCukm3A/pOxh93qpDwi5CN+YKUgZuuueFu8v2vhGV9cXEgFHlwz68zglirM8zOTh/
	dKI9toY8HKw==
X-Google-Smtp-Source: AGHT+IED1RpSvNx9oMA2mwYUkIxirgTL9ys8SW3lLj+ohq/tRBhaDG+NkrrKslDby64X267jnyEOCh2OH/T4WQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ae03:0:b0:dc7:463a:46d2 with SMTP id
 a3-20020a25ae03000000b00dc7463a46d2mr416556ybj.0.1707510896823; Fri, 09 Feb
 2024 12:34:56 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:16 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-2-edumazet@google.com>
Subject: [PATCH v3 net-next 01/13] net: annotate data-races around dev->name_assign_type
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
index 31f2c97d19903a7b4ce92292dd53486c0043cd1b..7bba4a47231726d666348539538ae94eb248fc3a 100644
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
2.43.0.687.g38aa6559b0-goog


