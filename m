Return-Path: <netdev+bounces-71176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE49852900
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5DA1F23192
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707191428D;
	Tue, 13 Feb 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2fI+J8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1FAD49
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805974; cv=none; b=CsNavlWgtCR5xR12g7yHbjdSbR6j89G2olvhL/8UYG5V/r1nWiLWyEnE78Hdoam+MnLcm79/QJnme1sI16H3tsG8XgjPMr75DPfZjXuo2Odh1ZBK5HuK25Fz9I6WQsCB/e6+GjaOoOGrEMhZgYrQfeQs/BE+aBqpm80025wFV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805974; c=relaxed/simple;
	bh=iiKCLy2hMnCbS6WQbJCzTI0KpdhHSTQBm4Pe6S29VvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LUijiZMLZn0mVG5g9h9ZcexPIjFhKUc3SuDA3QLjaGgw/mjZtirxjX5D6R1MAyJu7NUEVw2NQatW/2nsfJ9LNijX1dNxtE9QXdaA3QGyHLmRRrWD/WaX03s9ge3M34+5wGwW8/X1M8omW8mEx2kCTp0vGPxEYE67z3yQXFrXlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2fI+J8O; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60770007e52so19129437b3.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805972; x=1708410772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiKDMud0/ZkfrpdxLizMTEVsfc5poVFCyYO0qToodU8=;
        b=D2fI+J8OwrH82Y5oc3z7y871XALWxyI+2ZaCxQG+ef3sCKDJzzWhhhCFVppDwkOQv9
         9EXTFlZRfsfj4bVa7z0fYur9dyyhuqqCyDl2lmKFQ8tfLHrPtNL7CyVnVGvMEgUj16Bx
         VsgkpboCrhWVKASrsuEghZlnKmhf140w9TTlhO9l4jgjAvDSRlaycYmyUabHGeHc4LPn
         7XUZi8Hqvd4cmKZrgcPK5U12qcu8Hh0d9+18MWFrAeLJwLnJZrVlAACkFiOtzxWLv01P
         FkmL1ZQQ6w0ALRmX+JI10bQ4wTROZ2O5QXkpSFQPGJhgYAnvjV7gN4u7aq7zytBqYpeD
         Ol/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805972; x=1708410772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiKDMud0/ZkfrpdxLizMTEVsfc5poVFCyYO0qToodU8=;
        b=acUzoM7e2lp5P+40zlZczmMlOooQyY3VR1ibQ6MlYF9Vw1daepuQzUBWGYpdjW3/jq
         ABhnerTlsx6zpcF7v5uiupmZQ1eaE/241hRDt5f+bS0buDD/W2DTY+VEoz8ibRbDbWtx
         iY/vgsD0U0ZWTAMgm1YqUSFMUrEBjMYSU1lM7gwmNi+61JQOr8p/NHUzc8btA+5EWCVJ
         8rrdUZGfl/mwS8iSkiIauAD3eJ8sU1AM6Pzjm76Gi0EaFLdYKllCfBgTqTInlVb10zsb
         mqvhEmIhTQmoYZokvR49dDxK5cdcZpraY+51XNkkVwbxw0M5oMAvIiWC9VXIY9IAEIHL
         Pk9g==
X-Gm-Message-State: AOJu0YxXGQCr4sQD8xzalBYmu2oC4vrJ/hRaCbL1dpCVpq+vp0RSOFx7
	vBLDK8kmPtaBJ2UCmRQJALaMR90yT7WLjjXUu4lb0yl9pFbjzAqzF+FqVPDQjgnJINOiSaTg+pX
	Mh2dUfCCuoA==
X-Google-Smtp-Source: AGHT+IHQaDHnn6E5Nylgh4cRnpfGl1YmgICy4Js6P16l+AwptXRb4hoVMdLgVnGtSuWKXUeaM3N4rvpqZXo7Sw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1505:b0:dcc:8be2:7cb0 with SMTP
 id q5-20020a056902150500b00dcc8be27cb0mr31176ybu.0.1707805971802; Mon, 12 Feb
 2024 22:32:51 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:33 +0000
In-Reply-To: <20240213063245.3605305-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213063245.3605305-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-2-edumazet@google.com>
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


