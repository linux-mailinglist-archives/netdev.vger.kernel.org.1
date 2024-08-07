Return-Path: <netdev+bounces-116575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB194B03A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D09B25157
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184C140360;
	Wed,  7 Aug 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="SB+VhBGC"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AEA13D25E;
	Wed,  7 Aug 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057377; cv=none; b=dWUaROP4Me29b4URWex4vg9PAp7gN7nqKkw85CqLGubEv51SYW/MFWtQTzQNs1DuiLLIw8E2Sv9bN+RNK22PUpTAUBrWwBLKCwwuYiKwuRi6BA85RfXwbRM7tOmcZVuf20dzYb6bFGE//YbdtVYznGs7SZcOuPBCr5/M6JxF3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057377; c=relaxed/simple;
	bh=gIvOf/5hVLft58zo+v3QpsHnM1jf5o2ChZQEy5lTmzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7guHZ+cx7AHKc1FdshvRstRRHxtYUD3QG89Ifh6E+2GVp758/PpUMfFeR1DbuKAZrbATnzLrklgAp3+NjwXJK4zf/zBgcdhK+O8jWVp68sEA98o4Nns1paUUfcAC2dp48BLZUS3EoRsal21/IL85wpiUMFUWba2Wu58FipRfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=SB+VhBGC; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from ritsuko.sh.sumomo.pri (unknown [10.0.12.132])
	by kozue.soulik.info (Postfix) with ESMTPSA id 2684B2FE4F7;
	Thu,  8 Aug 2024 04:03:27 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 2684B2FE4F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1723057408; bh=7w7qHeMGg7SZYXwBAqvBIFMjYY6UskdLZbVxcHbBcCA=;
	h=From:To:Cc:Subject:Date:From;
	b=SB+VhBGCnvQrmAbEsczFOUQyjy4QFAZg+7lHwHw/Qh26kJxJdzDRindjmmxyMzq/z
	 B4eJJ0TMG760XrNMJWzrjQmhHB0f0xqptcnPwpSiqO4FDLaw72CkKmrbOJVSqDnB1/
	 rtfcpm+Oc5wcKfqAd6lBrG0TVM998fJEz74/PqUs=
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
Subject: [PATCH net-next v3] net: tuntap: add ioctl() TUNGETQUEUEINDEX to fetch queue index
Date: Thu,  8 Aug 2024 03:02:30 +0800
Message-ID: <20240807190236.136388-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need the queue index in qdisc mapping rule and the result
value for the steering eBPF.
There was no way to know that.

Changelog:
v3:
fixes two style issues in the previous commit
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
index 1d06c560c5e6..0c527ccdeab3 100644
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
+		if (put_user(tfile->queue_index, (unsigned int __user *)argp))
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


