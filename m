Return-Path: <netdev+bounces-69839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5384CCA9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50E5B21CAB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA4A7CF15;
	Wed,  7 Feb 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OGsTc/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04E7C099
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315998; cv=none; b=hoSdgR/QpdyqR7Urq0qbnCS8qVJtG/oKT2toDgKCFu44eHJuv7We5/E6LZlyZ72gtrZs32ySp7pXhDnQwLiah7PvHiL7mr8GEUu32gENVl8oPfNA0sxtz9SlSytTyX7xeVRNXUSaUSDHCnWodlQ3HaLa5o5ncOUDlUJILM40Gww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315998; c=relaxed/simple;
	bh=MVrNsRBYO0/ChE8zw52OA/oR2pmQfu5LlW2VYcq5ViI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CTjRD8HtVxk85GMokXox/zpNZ5CHLNrPTL7IoZRRZ1T2qUDfJ2fB+1R6jrP1XzHK02/oleT6E092vB9sGGFOSGulQgTH0+4MA8lmrwlA76Cjwq7UsFUMSQQA95rbljliGmm4ec5mvOdSVnSW38Mha+MYr+QK3gfE/WlJz6AFsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0OGsTc/R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso1012066276.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707315996; x=1707920796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jrrTivmlhvG5U54rl/JznSMS2mnircQYl/67qSXK/Go=;
        b=0OGsTc/R33SZa6aBECSZ8vp6IbswZeDMsnOAJlOH7P/qeyh7/5FyROa4Z75Qka5Z+e
         z1GGMBkINEnXWoUenMP/kMTQ8VDDuMMe5o+DzPE1CGskT6bLEYz67ZiJKhWtVF/jKTaq
         T1rpiJvxyZag9ymqm4GI6g/VvhNxZrXOB8qjOBrD6n678QpPmwB5g6XuXz1Y2fLNgJaX
         cv3Zm+L3rJ4QBLXbMG3XZtkF1pe7X0p+wivHpAF/3TtoSnre2nXKK1ivKQ5iHXRc49iP
         NKsi0HUQ4Tcw0KkBvUh9B+5kr1J7S8gfpq6lyGXu9S/IKH/PE6JC5GnsJf7Bw1CpSA7c
         67aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315996; x=1707920796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrrTivmlhvG5U54rl/JznSMS2mnircQYl/67qSXK/Go=;
        b=slvukGwGw+iyCwSIaN4gllimHIbi5/SIxEAHr6ACITfSk3prJkE36E7XfTZH+Pthha
         fVpK4Ep1xN7bo8E2FvZIA0X3B6laci3DYsX8G+3fM/VMHVd9hT5aX3a4FuZKjWpOT+pT
         H/s+nvoDZqbG6Oo5TdSarj+DQVsexu5M7h/XS5/ayf/fZL7pxl9oXfKdj/jfbaH1BUo/
         X+MNqmqIk/YnNIHbqJddupSQFG2KYlnjekv3YpxIr6b1szX1ytKpRPdEkCZNLl3i1gWx
         2u+mUUR/Rne6MumKrWHoNqj7tKjfKWpL42kK1DoVcJUXMY1W2XWzsXmiv09EMB5Dde7V
         cD2w==
X-Gm-Message-State: AOJu0Ywq4Nd+PV7czJrgZM9XjBFJ/MBY+fdNEfpiGgFeT+NHhCDBzm/P
	ODwhS/szUZ0EF6M2YM6f3ia4Ow+hGK69+9HCdwHmMIf/eFvBdtuXW/YH1dk1sCn+CORmQ7OMAEm
	B6LTE5jAe+A==
X-Google-Smtp-Source: AGHT+IGJtPRHNv2SxFURZaH1UW+8mKUv3IXTEk4fIvnYcPMbuaIBfPID3W1puP8qs2Sik+A+FGRpgnczzjpEqg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2293:b0:dc6:207c:dc93 with SMTP
 id dn19-20020a056902229300b00dc6207cdc93mr179198ybb.2.1707315996090; Wed, 07
 Feb 2024 06:26:36 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:17 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-2-edumazet@google.com>
Subject: [PATCH net-next 01/13] net: annotate data-races around dev->name_assign_type
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
index 27ba057d06c490772320775f25fc2885f0a1ff3e..d2321a68a8abb4a4253c5843952b542ed040327a 100644
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


