Return-Path: <netdev+bounces-158979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFAA13FFA
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E661628DC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FDD24386F;
	Thu, 16 Jan 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD9iM/32"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816A24386A;
	Thu, 16 Jan 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737046506; cv=none; b=lAwvkFoIbgtnxvf8TRqdJJ7URmNz1TOvHODSkXZm6+zkIG7pMrO6Y2HjDU2XxIl/S8fOoeXzj72kXMl45yUCb9V4PBvDkeXYFYz5t7zwmBwNQfcRYKqWoOor91xEaAiuH8J6D7u6fGxLsoG/rMzkQzzgNMCOWwZgGRLDoNaBmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737046506; c=relaxed/simple;
	bh=PbVfnDei8esycz4yY+Dbr+xfdio/vutAk4LjcJsrUyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBh3BCgA4L14fsM7jXyswMFMBs4C+1NkCaxlYfoTzHoWo+/suWJbkPmY/LRWpJg3pxxjfohqCOt9hiDvPdjXaNaXxj8x+o/Aj4tQA/BLkk0TLM6sd+/lgZ6e0FH5gxsaj2AXKktfjNi62XXXjY4McaAfrzTprfkPiXTNv7UGLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD9iM/32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD54AC4CEE2;
	Thu, 16 Jan 2025 16:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737046506;
	bh=PbVfnDei8esycz4yY+Dbr+xfdio/vutAk4LjcJsrUyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cD9iM/324i0kwWnvOE8N4cyr7fUnRdMlhTK20Zv5xIqAlpSK4Qd0LbsHK8ghEpMkA
	 q/m+PciMIdZsMRpX0OA8DnyrjydRMysvp5jE/RZNZCK1qjYlKKtaf9IUkLQMmqn5T+
	 d12Q5y0zJvN4En34zvVkIlG1VlQ/NEAABAXkqoicP/rnJkDiALMU9RN1dVXu3d/MB5
	 C9ijnNcyEohVC+luA8qxPFK8nwnVjtZgB4a/08MVSsjEYx74MQR+gsyYYuG5waQ+lk
	 46z5UqWD6y78h0eriJK8g8FrFNs0TZfBsEOwogfzDEq1m0S/KpDs6ci5xj+3DUqOal
	 ZvhWZHvaJwSeQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 17:51:34 +0100
Subject: [PATCH net-next 12/15] mptcp: pm: reuse sending nlmsg code in
 get_addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-12-c0b43f18fe06@kernel.org>
References: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
In-Reply-To: <20250116-net-next-mptcp-pm-misc-cleanup-2-v1-0-c0b43f18fe06@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7747; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hlcuc1ckPIlJFVnOveNkkX2nqEb/VHMmICaJVO+RQ50=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniTnHEoPn6sBN+nGu/LjgGajMHdxJdN/O0+53L
 3U+IuBHtnqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4k5xwAKCRD2t4JPQmmg
 c+5fD/9mYI2JFwUjSNpv/kAVSLpHqwQcyV5x9jDD/p+EvDgGlpJQA11Ucu+5+H/oSlPbe0m2eOe
 KaH0mSwOLTfjUL4ke6Yeb44zEQA+bA44HEO8mq2kzl5Q3HGEGcTIq/GxGivn80lHpOBGWmkVDIN
 lJTEEFckf/dJfwM4iFfz/aiGOA9jQij1fxOmGnaaB9jQwi21MKuOVaN9SD0i9QHGHuHRgdNyMba
 LJkKmW/PK2JmCAHp4bM8DW4YyS6v7pIwksSqap8NAT1Vm7esc7ORthWVj87JpWVXB2JHUjT6Ko+
 lPm8exK4Uil+zVCkIepPKiCKRfvajRh0ZM6iEraEOZYY1kGRhIv5rLklS5BvFh4lYcDSFQ6HHGF
 mUYA3V3Vb8tA1FW+KX210AsTyysIpjmTPn6s181c4cqJYHZJbEKpTHcYkS+ESFDTJUCjpo7b4qJ
 KC9qXSZFk4mbxtA6WGY/ZFs/OKott+6a2vrSHV0DCwxFwykFTtV8ph8BkYmibvLd4jcdK+2xyWa
 64khjTzFe2d2vRWmibLPXgzBYlWsTTJCw8liFKbaqz65t01V4/IC5qlsCaZm3+Im9kJQ9wC0sIf
 vjQ51kh0vgg+wjp5gdYBOWhM20IBHx9onfLrzMsUResajtyewpDg6CZ9LPI6I2k1eHqxgxxdHeg
 SIXTjsbRs4P+5BQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The netlink messages are sent both in mptcp_pm_nl_get_addr() and
mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
This is because the netlink PM and userspace PM use different locks to
protect the address entry that needs to be sent via the netlink message.
The former uses rcu read lock, and the latter uses msk->pm.lock.

The current get_addr() flow looks like this:

	lock();
	entry = get_entry();
	send_nlmsg(entry);
	unlock();

After holding the lock, get the entry from the list, send the entry, and
finally release the lock.

This patch changes the process by getting the entry while holding the lock,
then making a copy of the entry so that the lock can be released. Finally,
the copy of the entry is sent without locking:

	lock();
	entry = get_entry();
	*copy = *entry;
	unlock();

	send_nlmsg(copy);

This way we can reuse the send_nlmsg() code in get_addr() interfaces
between the netlink PM and userspace PM. They only need to implement their
own get_addr() interfaces to hold the different locks, get the entry from
the different lists, then release the locks.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           | 39 +++++++++++++++++++++++++++++++++++----
 net/mptcp/pm_netlink.c   | 40 ++++++----------------------------------
 net/mptcp/pm_userspace.c | 42 +++++-------------------------------------
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 50 insertions(+), 77 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index caf5bfc3cd1ddeb22799c28dec3d19b30467b169..ba22d17c145186476c984d1eb27b102af986a0cd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -434,17 +434,20 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
+static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			     struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(id, info);
-	return mptcp_pm_nl_get_addr(id, info);
+		return mptcp_userspace_pm_get_addr(id, addr, info);
+	return mptcp_pm_nl_get_addr(id, addr, info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry addr;
 	struct nlattr *attr;
+	struct sk_buff *msg;
+	void *reply;
 	int ret;
 
 	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
@@ -455,7 +458,35 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	return mptcp_pm_get_addr(addr.addr.id, info);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
+		goto fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, &addr);
+	if (ret)
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	return ret;
+
+fail:
+	nlmsg_free(msg);
+	return ret;
 }
 
 static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 392f91dd21b4ce07efb5f44c701f2261afcdc37e..d86887004781e9020061394c350e4710b68cc22f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1773,49 +1773,21 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
+int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			 struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
-	struct sk_buff *msg;
-	struct nlattr *attr;
-	void *reply;
-	int ret;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
+	int ret = -EINVAL;
 
 	rcu_read_lock();
 	entry = __lookup_addr_by_id(pernet, id);
-	if (!entry) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
 	}
-
-	ret = mptcp_nl_fill_addr(msg, entry);
-	if (ret)
-		goto unlock_fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	rcu_read_unlock();
-	return ret;
-
-unlock_fail:
 	rcu_read_unlock();
 
-fail:
-	nlmsg_free(msg);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 79e2d12e088805ff3f59ecf41f5092df9823c1b4..80d75df18b039dc60ca5c4432da44a1a9dbf33f1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -684,15 +684,13 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
-	struct sk_buff *msg;
-	struct nlattr *attr;
 	int ret = -EINVAL;
 	struct sock *sk;
-	void *reply;
 
 	msk = mptcp_userspace_pm_get_sock(info);
 	if (!msk)
@@ -700,46 +698,16 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
-
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
-	if (!entry) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
 	}
-
-	ret = mptcp_nl_fill_addr(msg, entry);
-	if (ret)
-		goto unlock_fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
 	spin_unlock_bh(&msk->pm.lock);
 	release_sock(sk);
-	sock_put(sk);
-	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
-fail:
-	nlmsg_free(msg);
-out:
 	sock_put(sk);
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f209b40d08f372528b2294f3494ccf2d6bbb43e1..fe9bd483d6a067a3cacedea1e893e54fd2e1198b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,8 +1127,10 @@ int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info);
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
+int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			 struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {

-- 
2.47.1


