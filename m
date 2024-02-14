Return-Path: <netdev+bounces-71628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DE285443C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 09:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65953B27054
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 08:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB8B651;
	Wed, 14 Feb 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XoI+c4M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7127494
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900516; cv=none; b=emLsU0QFS2lhtMQQZQBcvpDi+dTSwA8a11nEY5A/DuYPj5xZl902hnZfKkPSCTXtP7P2sbxqc4Ia6OpKXQKsafYXM1unuOUeJCmDlnfTBtyRoupH/jkXrDwskkTG442jffxOAFc5fxu9/i6VZVgPJAxeCz4O0IPQXwKuvrYg9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900516; c=relaxed/simple;
	bh=ZU8Yz0EXsy0oVAjGfcA1t+TFkr6hmt5ICferk0jFVtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NEhP6w5Olj03WOh5LNiBdHuLluLNnPWuczi+ygCUBnaRRtR7A1CfsY7J0aG9O46Acn17/sP2RgKh+9WDagcYevb2ZfEoCrULOVVOQFO3LJeMv4lwrojlAsgFdXbx8q3Fi9/tH4BkdjTm9exHxq1FbGFo/vPmrXN+YO9fz3lgGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1XoI+c4M; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60770007e52so38336127b3.1
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 00:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707900513; x=1708505313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/JQWuyrxTUchl8YGMppPeiqbOJguP9SyeCHygUtbeE=;
        b=1XoI+c4M2Z/E+v2FdMwSPv3NIFk4OKKBhU/HgFK1RE46KFKyvZK9kNeD5GhfxVDW2N
         1jjFzGcQPTRL1T5kuyAtL4S6NGMADWfD/G9wF5ZwubjMXAwvHTiU5YQS35joNcjPEZSU
         dMYofRcv4+6ku1Y/tieEzB9WeL2SX6DO2k9BTrJv90MguJ2YB7wia3iSVl08BTZD7AHC
         sf7Wnlp8rpFYqtPaIw8mVGUeviaCyIlPjnkNwQFi3dr2+YSh6Y6+J9gY7RPBhZSEBVPK
         iZ8mp+MoN+zAA0B0Mp9BHEX/bWSzJf1XACAhbW6uRYFxLNlqDb6lXsiBWqKfLWyEiyFp
         Cd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900513; x=1708505313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/JQWuyrxTUchl8YGMppPeiqbOJguP9SyeCHygUtbeE=;
        b=P3+W0XteRfIwYSkBm77OK3nHgSlgU0IQq+j+mMTRSdsrXWzCIlyXhkyD6Q077rrxn+
         B2eEtjAj47jthpe7jNUCR+AcxxGk0dyrS4AgBjpoZv5FaxCsXs92u/JiD4HeOmAButsq
         c70P/bIuIb4s+A+td4xFDk0UpF7wIEaqLB4+vZNKi7ftD6aRZ50nQg1cm8D+i++rrgMe
         w7Q9c1vv9jrL4IIXXy1wiIggxSyLCvdyAzlN1opyvrNAdjTEMvPAD6Oe04xMQKziSuQf
         eKRNoGybs4zIh00qr+N0jnl+XqMkxeqMygLffix1F/NJlDNxkJjiU1AdDeDdc2xm3OpH
         04Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVMPmpZnnPcT2wr7CwGpJT7XFdJV4KDyt1Op938Su4tmDbUIkGitUxZKsw2B6I5ONtiz75xldjwK3pBgG12Szldl9CRc7kV
X-Gm-Message-State: AOJu0Yx6n4uxxsqtHZwTbgFj2okxgKbtUcshtk3GnoE5CkzqNTnsauhf
	8qJ/m8pcZ/RKJfEFZlHmpm1/4Tlli/RsKULxF3R3u27dpmCOk9osLeQnmACfcmKRCJEluJX/FPE
	Mt2g75Rp0wA==
X-Google-Smtp-Source: AGHT+IG2Be0djmCokrgaXjSGQjKwG6H4/FxR3uEkl0izME4lM2+gS/s/gLSRpIR7tdZhhme10UyseO4zbXu0IA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:8454:0:b0:607:7dee:a7fa with SMTP id
 u81-20020a818454000000b006077deea7famr312009ywf.2.1707900513665; Wed, 14 Feb
 2024 00:48:33 -0800 (PST)
Date: Wed, 14 Feb 2024 08:48:28 +0000
In-Reply-To: <20240214084829.684541-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214084829.684541-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214084829.684541-2-edumazet@google.com>
Subject: [PATCH 1/2] kobject: make uevent_seqnum atomic
From: Eric Dumazet <edumazet@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We will soon no longer acquire uevent_sock_mutex
for most kobject_uevent_net_broadcast() calls,
and also while calling uevent_net_broadcast().

Make uevent_seqnum an atomic64_t to get its own protection.

This fixes a race while reading /sys/kernel/uevent_seqnum.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>
---
 include/linux/kobject.h |  2 +-
 kernel/ksysfs.c         |  2 +-
 lib/kobject_uevent.c    | 17 +++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c30affcc43b444cc17cb894b83b17b52e41f8ebc..c8219505a79f98bc370e52997efc8af51833cfda 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -38,7 +38,7 @@ extern char uevent_helper[];
 #endif
 
 /* counter to tag the uevent, read only except for the kobject core */
-extern u64 uevent_seqnum;
+extern atomic64_t uevent_seqnum;
 
 /*
  * The actions here must match the index to the string array
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 1d4bc493b2f4b2e94133cec75e569bef3f3ead25..32ae7fa74a9c072a44f7280b950b97d25cb07baf 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -39,7 +39,7 @@ static struct kobj_attribute _name##_attr = __ATTR_RW(_name)
 static ssize_t uevent_seqnum_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%llu\n", (unsigned long long)uevent_seqnum);
+	return sysfs_emit(buf, "%llu\n", (u64)atomic64_read(&uevent_seqnum));
 }
 KERNEL_ATTR_RO(uevent_seqnum);
 
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index fb9a2f06dd1e79db0e5db17362c88152790e2b36..9cb1a7fdaeba4fc5c698fbe84f359fb305345be1 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -30,7 +30,7 @@
 #include <net/net_namespace.h>
 
 
-u64 uevent_seqnum;
+atomic64_t uevent_seqnum;
 #ifdef CONFIG_UEVENT_HELPER
 char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
 #endif
@@ -44,7 +44,7 @@ struct uevent_sock {
 static LIST_HEAD(uevent_sock_list);
 #endif
 
-/* This lock protects uevent_seqnum and uevent_sock_list */
+/* This lock protects uevent_sock_list */
 static DEFINE_MUTEX(uevent_sock_mutex);
 
 /* the strings here must match the enum in include/linux/kobject.h */
@@ -583,13 +583,13 @@ int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
 		break;
 	}
 
-	mutex_lock(&uevent_sock_mutex);
 	/* we will send an event, so request a new sequence number */
-	retval = add_uevent_var(env, "SEQNUM=%llu", ++uevent_seqnum);
-	if (retval) {
-		mutex_unlock(&uevent_sock_mutex);
+	retval = add_uevent_var(env, "SEQNUM=%llu",
+				atomic64_inc_return(&uevent_seqnum));
+	if (retval)
 		goto exit;
-	}
+
+	mutex_lock(&uevent_sock_mutex);
 	retval = kobject_uevent_net_broadcast(kobj, env, action_string,
 					      devpath);
 	mutex_unlock(&uevent_sock_mutex);
@@ -688,7 +688,8 @@ static int uevent_net_broadcast(struct sock *usk, struct sk_buff *skb,
 	int ret;
 
 	/* bump and prepare sequence number */
-	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu", ++uevent_seqnum);
+	ret = snprintf(buf, sizeof(buf), "SEQNUM=%llu",
+		       atomic64_inc_return(&uevent_seqnum));
 	if (ret < 0 || (size_t)ret >= sizeof(buf))
 		return -ENOMEM;
 	ret++;
-- 
2.43.0.687.g38aa6559b0-goog


