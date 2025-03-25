Return-Path: <netdev+bounces-177628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58A4A70C10
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA14A3AB738
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BEA269CE5;
	Tue, 25 Mar 2025 21:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE71EA7D3
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938271; cv=none; b=ECCPBkrs06Oq7RlAuyACEscFIoFE5A9du3T4Xc6Ou+tvOjKv03KvQLrEenbxaKp+saQMkEbemN8/+Xb/6fOCcGZ2LE/tpQ2RjHyc8tD9ykmQl62OisYa0V4z3lCwnOaqipqiKdCx4/4B4Yy6/en/ip2nPv4ZBNg+TmuaLn5q3TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938271; c=relaxed/simple;
	bh=u0NFjKidKiCCC5Zpktj60hLTvahC55mnRL3QytGn26w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6G78F2dnXONr1se8AZT8kxb2JHaB07RlqQTbFwEIBwtkr4Jdxbo021cFdP7DH/rIN/JyAb3VlO9Fu0uiLUth600DLNiWxsM5eDj4k9cTihZTaBV558/ERtC1v4ffbRDy+gLWbEeRYlgDAUpyAo6g79yCOGXTkDOlSUMto4wiTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2260c91576aso103744175ad.3
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938269; x=1743543069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpxWmB0uAND3cvwNO+EN3BRKNqzAQc/XiisPNxzPy+o=;
        b=FV2YMdt4Trnt41SToofO0W8hW6hR/RZfgpbWkCl12fsNzJAwwzbH7eiy8TdSkWFICp
         /ATetmlMUHRQONr5vHVpFywZksRoPhX56mu2yZucPiuKnzO7b7rf6gj8j3mtdd7bwxXI
         yOELFAsRn3usHsaARJBGo+ki4OZzHKtGl2G8qWO01nThmFSE+8G0R96eeCmzXj54H00f
         O430WXowYuLhajtG8+VMFUq8oop+Jq/f28oE+zpS3WHPxcgkVwI08g/DaVLp4ZE6lDQo
         2w2emO+VQb7yMbyqKUod0dJn8y2oTpz2+ndMz2VAYNmYdUM7NquYzPMLgaWNk+AT9XaC
         h0hA==
X-Gm-Message-State: AOJu0Yy2aa2/tzPvWJmY/l543rhPk9MTIp6BVlMlV/+jdfvlFP3H5+xn
	13RL3KncOlUyvkN6AmmaGgx4nn3COQbO+RvBIGhlIwqxO6O9urXOCgnJ9qPCTw==
X-Gm-Gg: ASbGncsul/yvZCdzqf15G9MT76L6hOJttlFwszpcyCKWqMKCD+X9jhcyu6qNs0Q+NtW
	IMe7r/IEuvlr6uKZoNeXul06BRUlVnRvgU4r14XuGqyJPpbm1OmF9/eibz+hopyRcfLUp6C4Db/
	ck0L5b1+lDVqKcC1P1TTrzuBAJHHUcEQjHa4lvlM3i9qb8hNgAPCq0MPWvEsYOTcdkkTBB0FS0p
	s3flTsDfrJ1JkjPz/k6I61i/xr4DZFIMZj8WyWsUJwy6MD5JynOrKg97e4Bz7Evi4Mj/L6grxIg
	320WjRpBPjqG5tcG+4/qvDcXTHcYLtGQbzhDffVMGad1qa7/AT7ro7w=
X-Google-Smtp-Source: AGHT+IE1kCjIGhTZzWTzQxtjK+v0B9Pg5luT1quOviI9496U8IpaRYj6jq/AwBSjw/2asXiifOa+lw==
X-Received: by 2002:a17:902:ea07:b0:220:ca08:8986 with SMTP id d9443c01a7336-22780d828c4mr292248765ad.22.1742938268622;
        Tue, 25 Mar 2025 14:31:08 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3030f806f1csm10850235a91.46.2025.03.25.14.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:08 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 8/9] netdev: add "ops compat locking" helpers
Date: Tue, 25 Mar 2025 14:30:55 -0700
Message-ID: <20250325213056.332902-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add helpers to "lock a netdev in a backward-compatible way",
which for ops-locked netdevs will mean take the instance lock.
For drivers which haven't opted into the ops locking we'll take
rtnl_lock.

The scoped foreach is dropping and re-taking the lock for each
device, even if prev and next are both under rtnl_lock.
I hope that's fine since we expect that netdev nl to be mostly
supported by modern drivers, and modern drivers should also
opt into the instance locking.

Note that these helpers are mostly needed for queue related state,
because drivers modify queue config in their ops in a non-atomic
way. Or differently put, queue changes don't have a clear-cut API
like NAPI configuration. Any state that can should just use the
instance lock directly, not the "compat" hacks.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/netdev_lock.h | 16 +++++++++++++
 net/core/dev.c            | 49 +++++++++++++++++++++++++++++++++++++++
 net/core/dev.h            | 15 ++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 1c0c9a94cc22..76cbf5a449b6 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -64,6 +64,22 @@ netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
 		netdev_ops_assert_locked(dev);
 }
 
+static inline void netdev_lock_ops_compat(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_lock(dev);
+	else
+		rtnl_lock();
+}
+
+static inline void netdev_unlock_ops_compat(struct net_device *dev)
+{
+	if (netdev_need_ops_lock(dev))
+		netdev_unlock(dev);
+	else
+		rtnl_unlock();
+}
+
 static inline int netdev_lock_cmp_fn(const struct lockdep_map *a,
 				     const struct lockdep_map *b)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index bbcf302b53a8..3589cd4471c8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1051,6 +1051,18 @@ struct net_device *__netdev_put_lock(struct net_device *dev)
 	return dev;
 }
 
+static struct net_device *__netdev_put_lock_ops_compat(struct net_device *dev)
+{
+	netdev_lock_ops_compat(dev);
+	if (dev->reg_state > NETREG_REGISTERED) {
+		netdev_unlock_ops_compat(dev);
+		dev_put(dev);
+		return NULL;
+	}
+	dev_put(dev);
+	return dev;
+}
+
 /**
  *	netdev_get_by_index_lock() - find a device by its ifindex
  *	@net: the applicable net namespace
@@ -1073,6 +1085,18 @@ struct net_device *netdev_get_by_index_lock(struct net *net, int ifindex)
 	return __netdev_put_lock(dev);
 }
 
+struct net_device *
+netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
+{
+	struct net_device *dev;
+
+	dev = dev_get_by_index(net, ifindex);
+	if (!dev)
+		return NULL;
+
+	return __netdev_put_lock_ops_compat(dev);
+}
+
 struct net_device *
 netdev_xa_find_lock(struct net *net, struct net_device *dev,
 		    unsigned long *index)
@@ -1098,6 +1122,31 @@ netdev_xa_find_lock(struct net *net, struct net_device *dev,
 	} while (true);
 }
 
+struct net_device *
+netdev_xa_find_lock_ops_compat(struct net *net, struct net_device *dev,
+			       unsigned long *index)
+{
+	if (dev)
+		netdev_unlock_ops_compat(dev);
+
+	do {
+		rcu_read_lock();
+		dev = xa_find(&net->dev_by_index, index, ULONG_MAX, XA_PRESENT);
+		if (!dev) {
+			rcu_read_unlock();
+			return NULL;
+		}
+		dev_hold(dev);
+		rcu_read_unlock();
+
+		dev = __netdev_put_lock_ops_compat(dev);
+		if (dev)
+			return dev;
+
+		(*index)++;
+	} while (true);
+}
+
 static DEFINE_SEQLOCK(netdev_rename_lock);
 
 void netdev_copy_name(struct net_device *dev, char *name)
diff --git a/net/core/dev.h b/net/core/dev.h
index 8d35860f2e89..e7446b25bcde 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -40,6 +40,21 @@ DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));
 	     (var_name = netdev_xa_find_lock(net, var_name, &ifindex)); \
 	     ifindex++)
 
+struct net_device *
+netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex);
+struct net_device *
+netdev_xa_find_lock_ops_compat(struct net *net, struct net_device *dev,
+			       unsigned long *index);
+
+DEFINE_FREE(netdev_unlock_ops_compat, struct net_device *,
+	    if (_T) netdev_unlock_ops_compat(_T));
+
+#define for_each_netdev_lock_ops_compat_scoped(net, var_name, ifindex)	\
+	for (struct net_device *var_name __free(netdev_unlock_ops_compat) = NULL; \
+	     (var_name = netdev_xa_find_lock_ops_compat(net, var_name,	\
+							&ifindex));	\
+	     ifindex++)
+
 #ifdef CONFIG_PROC_FS
 int __init dev_proc_init(void);
 #else
-- 
2.48.1


