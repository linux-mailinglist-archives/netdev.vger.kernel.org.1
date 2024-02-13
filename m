Return-Path: <netdev+bounces-71174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31F8528F1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027711C23314
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DB14291;
	Tue, 13 Feb 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqeM7dmS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90313FFA
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805796; cv=none; b=FaGETpXLh3UKoAFL7Iz3d1sCPyuso+uDOXqUlwwrOfKuSePx0/86FhtOWrAR4ZkO6l04emAjCSZOezgw1LAYoqFYx3uwYOlwN+Jwrh/xwZP6BIGGN2lRMEikaNeVjh2MZYn7DTGWxP3FjGyI6MvzallpurmMPqsQgf++EjJuzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805796; c=relaxed/simple;
	bh=iiKCLy2hMnCbS6WQbJCzTI0KpdhHSTQBm4Pe6S29VvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tpWDHtKtButVlSW3qjXbqUV8B4bOGgHAu2IG7IiOe2q5c8KFRVxnKgh9gUBusO6uR5AKQtqLonQw+wab4Y24MnRQZDGMx/Qr1xmegpwPDE4+CqCyEc8FWeJt0vYNM4ou7Wbq+wiIxP17QyJFYW+sTADayUIuIpEhshG1akAWChg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqeM7dmS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047f0741e2so63141817b3.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805793; x=1708410593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiKDMud0/ZkfrpdxLizMTEVsfc5poVFCyYO0qToodU8=;
        b=ZqeM7dmSr+vWfK1TcO3L6mKbwq79LxtUrTVoDp2WLsUZbkrZO8fwmbQevrUaWzAAI8
         DC0cafV+hpwOAM4unvGvu3LiTx2DGjXigFQRvq1/W/pljKrg731wINhj0Se6e9aciSJW
         qv9WDfNt5JwBOvjkd7j+8/OotM1MqrgvAGC5b1RpI+txxyP8Q2XKSBDQkDvzhIhzeGcQ
         chf7Go8tY1deTcF9H4UFxFWnzTn5BNmxZ+8a3wRx3rX7Az84EApLi07sDxj6Lwdl4c8t
         9/AhV1bXZPw7C5BTlemh8oIiSA2rO1TMU3L+c8BoN6zVWlewMSCQnvigGsaahz7S0CZa
         nyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805793; x=1708410593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiKDMud0/ZkfrpdxLizMTEVsfc5poVFCyYO0qToodU8=;
        b=VG5wuTY7lTEmSMxRwh1jP15zfU/bDRgg9Pbygv84SKQFgrOSo0DWrckJJy9xMr6s7s
         u4+AIsymoAFjdnzPVKS/GV+qQCW0EJjUOxsfPPY5R8NxQ5A3ds8jssQGYuo3TH5mBK68
         whFcN/60SPAGxz7gvGXKeYdOyBwwi0PnkzUmwC/Wos7rnbUUx5EgABQLkfKUntBzATYL
         kNvoDgWyerCj8nbf6X+oOYbUBJSJHigUG/vVEzKXYtQgqhVDSi5Z7rdEfWKUCF0m+ID8
         J3jErq1dY0XzdXexL60HIadepJ5cBgLx6HZArpzvNUnvGiDWDX9NJhhIPOpl04Qc770k
         M08w==
X-Gm-Message-State: AOJu0YwactdpT1ZJnvYEppAgy9nJQEHCpHHWrAmBqve/seEoH8KX67bt
	zdVNIp5D8xWM8UJIFiw2tY2x1RXwmFyVUs39bw7UfE5oSnIocBi/TUmaru87rttNqdlrHf5g25w
	WJPaVk3v87A==
X-Google-Smtp-Source: AGHT+IGKEllN1D8eiwLrW5/muXaZneza4N2EvWXOUbQ3AaYHZgIK/98lfn32og+SkmUzjyNkAIc3jvLtleFsLw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:908:b0:5f8:e803:4b0d with SMTP
 id cb8-20020a05690c090800b005f8e8034b0dmr2053602ywb.2.1707805793508; Mon, 12
 Feb 2024 22:29:53 -0800 (PST)
Date: Tue, 13 Feb 2024 06:29:38 +0000
In-Reply-To: <20240213062950.3603891-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213062950.3603891-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213062950.3603891-2-edumazet@google.com>
Subject: [PATCH v4 net-next 01/13] net: annotate data-races around dev->name_assign_type
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
index 7cf15d2bf78def778c397416bfe730434c3cc093..693e08f3304d1de18f859ff4a65947b4a5cb9e4a 100644
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


