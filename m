Return-Path: <netdev+bounces-114979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FB944D70
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE8AB24BF5
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F078A1A255A;
	Thu,  1 Aug 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="l761aTSQ"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEB189B98;
	Thu,  1 Aug 2024 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520189; cv=none; b=j3HqKJVt6v49bS6VgxfnVZydkoqmZFcb9OtVHAwi0Q3ZziZ3hUSl9z5uzSxt+tCq7sQJMeSZdbiMEJZFidYPKOadaSfADnZvcKprTteu35E4Wn0QkIUpSiFvxx43sd3Eu+sg7+VBs6M5ouCWTRag09KevCl2pAAt6CPoVE9Cezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520189; c=relaxed/simple;
	bh=GsoCn77fV7d9tlKa+WgxxiX5PGRunJ1LESJ7+Epwvbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4ZuVGFLdo8nh7FU8sKoezIocXcfUMCJeZkxBxXkoq3JZRqRHAE+4uhIGAmFpd4RXQo/+oiq+/klyRkuGFdf28J0KKh7GnE9fuQ1VGUkp/93xP566zBSatz46rly8Jl31FJtJ+cXmWrBTb1gSHrPthPr5LJ4UEVKrCx/R9UK5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=l761aTSQ; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from ritsuko.sh.sumomo.pri (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id 6A0912FE3AC;
	Thu,  1 Aug 2024 22:50:12 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 6A0912FE3AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1722520212; bh=lmDvIp8wVJ+pUhzHi6TDXIwavE0pwN92FStcwMmAvKw=;
	h=From:To:Cc:Subject:Date:From;
	b=l761aTSQV1X3Ej/aDWEAykeF/3xunoHEBX8bizYUBgLoXlpRlwtUcK0CL9yvzH+QH
	 TAp9B/qNDHJ0OEkypTJc3A0VcxOHWJBhPks4R6vNuhwmsD74rRxArleCxWACJQCYTN
	 cwu2GXSL3zQYV3yd6tK6H403hY+kD1koc/9iYHts=
From: Randy Li <ayaka@soulik.info>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Randy Li <ayaka@soulik.info>
Subject: [PATCH net-next v2] net: tuntap: add ioctl() TUNGETQUEUEINDEX to fetch queue index
Date: Thu,  1 Aug 2024 21:49:21 +0800
Message-ID: <20240801134929.206678-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need the queue index in qdisc mapping rule. There is no way to
fetch that.

Changelog:
v2:
Fixes the flow when the queue is disabled in the tap type device.
Put this ioctl() under the lock protection for the tun device.

Signed-off-by: Randy Li <ayaka@soulik.info>
---
 drivers/net/tap.c           | 10 ++++++++++
 drivers/net/tun.c           | 13 +++++++++++++
 include/uapi/linux/if_tun.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 77574f7a3bd4..bbd717cf78a5 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1120,6 +1120,16 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 		rtnl_unlock();
 		return ret;
 
+	case TUNGETQUEUEINDEX:
+		rtnl_lock();
+		if (!q->enabled)
+			ret = -EINVAL;
+		else
+			ret = put_user(q->queue_index, up);
+
+		rtnl_unlock();
+		return ret;
+
 	case SIOCGIFHWADDR:
 		rtnl_lock();
 		tap = tap_get_tap_dev(q);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 1d06c560c5e6..05fa9727721e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3151,6 +3151,19 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		tfile->ifindex = ifindex;
 		goto unlock;
 	}
+	if (cmd == TUNGETQUEUEINDEX) {
+		ret = -EINVAL;
+		if (tfile->detached)
+			goto unlock;
+
+		ret = -EFAULT;
+		if(put_user(tfile->queue_index, (unsigned int __user*)argp))
+			goto unlock;
+
+		ret = 0;
+		goto unlock;
+	}
+
 
 	ret = -EBADFD;
 	if (!tun)
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..2668ca3b06a5 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -61,6 +61,7 @@
 #define TUNSETFILTEREBPF _IOR('T', 225, int)
 #define TUNSETCARRIER _IOW('T', 226, int)
 #define TUNGETDEVNETNS _IO('T', 227)
+#define TUNGETQUEUEINDEX _IOR('T', 228, unsigned int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
-- 
2.45.2


