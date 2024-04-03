Return-Path: <netdev+bounces-84620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A458979BD
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879211C2135D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEDF15575B;
	Wed,  3 Apr 2024 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ypd+IoXS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F72A31
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175781; cv=none; b=tfWyKNS/P0C4gGWj/uSlHvrJz+huZ+gSTIvBOwEgD3Ap7wap2NWhgdwHoo+sy7YDDC94qMJdOsZbOROAmfDAJVtyzEF77LeGkk+/s4xlAtZLug9FmgpR4HIPONYV1eCkKf8q16JyFdq+EnbhcE1bcLfZMUjlbiu1M4vSZ1wtmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175781; c=relaxed/simple;
	bh=ASQXFewowix0TB4/g3lMWJ0wcEQzgORWfqrq/G89l6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdlSivirqR/KYBiGr4rmtSbqb1GfKnC5GNpBc/pu1iP5Ea8/+rDvqGPWqZgvphW+SiCtpw5JLxCHM8GO+toriUDRQ0QBeHlq6aCfXI84o8+wUDipadKktCRKFsa8ZwNqJIz3pVbrjii3tNEwF3zUc6m0c4517kQFvNbufZgFDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ypd+IoXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EDEC433C7;
	Wed,  3 Apr 2024 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712175780;
	bh=ASQXFewowix0TB4/g3lMWJ0wcEQzgORWfqrq/G89l6c=;
	h=From:To:Cc:Subject:Date:From;
	b=Ypd+IoXSI4hthW5l3rvdDzGX5mURov6GcTxnq5Ab70Y25iYEZyBy9ieSuchCGWXvv
	 0lTyA086HArzoDcWB46EzKX70Z/1D8tqneIW4BA6WI2dhTjwokpxAyi597USEwxrNi
	 0vvG8PIvdjberO3GQrcuo1LPnYHOFx2csQ4PKTpo/Z2K72siQFF61OWmSGcVd5doUq
	 S1G8y3dDn78oQ+CbjSSurZZlaLGdSWz0+rtmn2/NQhbhDbRz2bRUAJXpDChmihCOXE
	 Z+sVxphRJwIYRG2Q40IJavQ3CMqPYP5C1Yxn021t7/+DCtOYXkj0jLRHhR9Jia6QCK
	 zX1E4rJwH1FKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us
Subject: [PATCH net-next] netlink: add nlmsg_consume() and use it in devlink compat
Date: Wed,  3 Apr 2024 13:22:59 -0700
Message-ID: <20240403202259.1978707-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devlink_compat_running_version() sticks out when running
netdevsim tests and watching dropped skbs. Add nlmsg_consume()
for cases were we want to free a netlink skb but it is expected,
rather than a drop. af_netlink code uses consume_skb() directly,
which is fine, but some may prefer the symmetry of nlmsg_new() /
nlmsg_consume().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jiri@resnulli.us
---
 include/net/netlink.h | 14 ++++++++++++--
 net/devlink/dev.c     |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 1d2bbcc50212..61cef3bd2d31 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -41,7 +41,8 @@
  *   nlmsg_get_pos()			return current position in message
  *   nlmsg_trim()			trim part of message
  *   nlmsg_cancel()			cancel message construction
- *   nlmsg_free()			free a netlink message
+ *   nlmsg_consume()			free a netlink message (expected)
+ *   nlmsg_free()			free a netlink message (drop)
  *
  * Message Sending:
  *   nlmsg_multicast()			multicast message to several groups
@@ -1082,7 +1083,7 @@ static inline void nlmsg_cancel(struct sk_buff *skb, struct nlmsghdr *nlh)
 }
 
 /**
- * nlmsg_free - free a netlink message
+ * nlmsg_free - drop a netlink message
  * @skb: socket buffer of netlink message
  */
 static inline void nlmsg_free(struct sk_buff *skb)
@@ -1090,6 +1091,15 @@ static inline void nlmsg_free(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+/**
+ * nlmsg_consume - free a netlink message
+ * @skb: socket buffer of netlink message
+ */
+static inline void nlmsg_consume(struct sk_buff *skb)
+{
+	consume_skb(skb);
+}
+
 /**
  * nlmsg_multicast_filtered - multicast a netlink message with filter function
  * @sk: netlink socket to spread messages to
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index c609deb42e88..13c73f50da3d 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -1214,7 +1214,7 @@ static void __devlink_compat_running_version(struct devlink *devlink,
 		}
 	}
 free_msg:
-	nlmsg_free(msg);
+	nlmsg_consume(msg);
 }
 
 void devlink_compat_running_version(struct devlink *devlink,
-- 
2.44.0


