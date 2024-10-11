Return-Path: <netdev+bounces-134632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351B99A999
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93F2B25573
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF8B1BE87E;
	Fri, 11 Oct 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sb9dwb9Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E019F118
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666742; cv=none; b=XYuxLJUHBX0ndm1Qv2p0i+Be4LxhJykL62LAjIS3Q01P3TX7VDKZdeg0I5UVItRJe1nYA5D1NPO20QSndGQsHZNEiDM6/Wi9kYu/nkHOLvNhiQH2eKgQxaNwZbnejwKWfhN/JlWdqDlHE7GJJ5xUyvzvC14UyH6jWUg4aZEtPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666742; c=relaxed/simple;
	bh=A124KVAjZG+Fa+c7c4eE9C+k2MZi2Xz7c8dpXeIqjOA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Lurw/qdt7KGlwcrpfvpq8TA4VGHFqOwbiRbZYW43tPhZuthkGE7qxgyXjaIvP7MbCRksJa7Q1bpFd17nD1ktr4TRhlcaRf6D+b4VUAVx7I30j67Gq2TnNgSz8ZQEDjLw+SshSZg4MeqHGp6cHnMH3YXo4AgMT41lAKiOzVmDb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sb9dwb9Q; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29142c79d6so2018299276.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666739; x=1729271539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2/XtE3yq4kfURfRRXf5LQEH/Xc2K0VbWifS43+hE1U=;
        b=sb9dwb9Q3hnKmNz18tJkcqNbApAEEQjL49l97ytvQkkm0fPqHwPGi85EFVzkURHlJo
         7qtuHL3Xrd68HKWQG/L5PZZsb0G1jwJchtuklrjU9tDRpfLUimkWyxQYkFwNPXcgUl1M
         X1pTNfYPFSnhgzubg9zIl8Wt9dosdANKFQxKQPVJIm7IpN8cDeA0UcJVMKVQOYDUMoC+
         paEQZtG2I7wvBkF9OfMcSsJjRKwwtQgfZk4e1eyNdQzVNg/G9Ow5qyfSrZ//bhGuhW8T
         YwKi750eNWTQ3jM/3WIVXV7UaC/m4ArsoLIx6bW414hORjYzwgwlyrAx/3SDbUiJOZaZ
         w5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666739; x=1729271539;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2/XtE3yq4kfURfRRXf5LQEH/Xc2K0VbWifS43+hE1U=;
        b=kVQ1vQRb8+BgcKWNHfjm7UpGrNEourv262WciFxUQaEPWYlnkicSdJi1VqGtdh3uLT
         2WZSzvb9FzfwqJR6HsVb/3YGn02TLOHTeH64Ck+rJJQUhRzG+TF1MIcGMfu3rKMkaqqT
         hsOzCDgGK3tZNFmvr5kAS6G8F7dWavLTNboZspHZYVvzFOsKPG3ybeU055a1tfMLyZj3
         pJTH9OVLGdtCy9ckrfcGs2yB9H5E50F5zb8w8QA4qfjW8AYLU5tcA+Pg7KXsZHmWw6/1
         VsbUMzW4j1dOxjFWnQrUHet1txSBuWJBY61QKlJRm/rsvDdrNfNNm5PMmpeiELsvt52n
         rlgw==
X-Gm-Message-State: AOJu0YwO+Kv0dBZRsf2LPsQzTSDYoVBlHcL0vbxi74fuPToC6uwYt6jX
	Aktj7cIlpOWL1T4IIgI5niNI/QEwSQkAo+GgO6R/3F5/40WF+mqy8xy7XaL0SF3+ZRylojm76/V
	l7dV38sCAsQ==
X-Google-Smtp-Source: AGHT+IFvgeG8v020ig2SD9iMTnhclARok7gXHzlIms9nydheWTGho28w9WCc2uB14LWU++pIGg1qxBgDOFY5Vw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:b810:0:b0:e25:17cb:352e with SMTP id
 3f1490d57ef6-e2919ff850emr1947276.9.1728666738993; Fri, 11 Oct 2024 10:12:18
 -0700 (PDT)
Date: Fri, 11 Oct 2024 17:12:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011171217.3166614-1-edumazet@google.com>
Subject: [PATCH net] genetlink: hold RCU in genlmsg_mcast()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, James Chapman <jchapman@katalix.com>, 
	Tom Parkin <tparkin@katalix.com>, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"

While running net selftests with CONFIG_PROVE_RCU_LIST=y I saw
one lockdep splat [1].

genlmsg_mcast() uses for_each_net_rcu(), and must therefore hold RCU.

Instead of letting all callers guard genlmsg_multicast_allns()
with a rcu_read_lock()/rcu_read_unlock() pair, do it in genlmsg_mcast().

This also means the @flags parameter is useless, we need to always use
GFP_ATOMIC.

[1]
[10882.424136] =============================
[10882.424166] WARNING: suspicious RCU usage
[10882.424309] 6.12.0-rc2-virtme #1156 Not tainted
[10882.424400] -----------------------------
[10882.424423] net/netlink/genetlink.c:1940 RCU-list traversed in non-reader section!!
[10882.424469]
other info that might help us debug this:

[10882.424500]
rcu_scheduler_active = 2, debug_locks = 1
[10882.424744] 2 locks held by ip/15677:
[10882.424791] #0: ffffffffb6b491b0 (cb_lock){++++}-{3:3}, at: genl_rcv (net/netlink/genetlink.c:1219)
[10882.426334] #1: ffffffffb6b49248 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg (net/netlink/genetlink.c:61 net/netlink/genetlink.c:57 net/netlink/genetlink.c:1209)
[10882.426465]
stack backtrace:
[10882.426805] CPU: 14 UID: 0 PID: 15677 Comm: ip Not tainted 6.12.0-rc2-virtme #1156
[10882.426919] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[10882.427046] Call Trace:
[10882.427131]  <TASK>
[10882.427244] dump_stack_lvl (lib/dump_stack.c:123)
[10882.427335] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
[10882.427387] genlmsg_multicast_allns (net/netlink/genetlink.c:1940 (discriminator 7) net/netlink/genetlink.c:1977 (discriminator 7))
[10882.427436] l2tp_tunnel_notify.constprop.0 (net/l2tp/l2tp_netlink.c:119) l2tp_netlink
[10882.427683] l2tp_nl_cmd_tunnel_create (net/l2tp/l2tp_netlink.c:253) l2tp_netlink
[10882.427748] genl_family_rcv_msg_doit (net/netlink/genetlink.c:1115)
[10882.427834] genl_rcv_msg (net/netlink/genetlink.c:1195 net/netlink/genetlink.c:1210)
[10882.427877] ? __pfx_l2tp_nl_cmd_tunnel_create (net/l2tp/l2tp_netlink.c:186) l2tp_netlink
[10882.427927] ? __pfx_genl_rcv_msg (net/netlink/genetlink.c:1201)
[10882.427959] netlink_rcv_skb (net/netlink/af_netlink.c:2551)
[10882.428069] genl_rcv (net/netlink/genetlink.c:1220)
[10882.428095] netlink_unicast (net/netlink/af_netlink.c:1332 net/netlink/af_netlink.c:1357)
[10882.428140] netlink_sendmsg (net/netlink/af_netlink.c:1901)
[10882.428210] ____sys_sendmsg (net/socket.c:729 (discriminator 1) net/socket.c:744 (discriminator 1) net/socket.c:2607 (discriminator 1))

Fixes: 33f72e6f0c67 ("l2tp : multicast notification to the registered listeners")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Chapman <jchapman@katalix.com>
Cc: Tom Parkin <tparkin@katalix.com>
Cc: Johannes Berg <johannes.berg@intel.com>
---
 drivers/target/target_core_user.c |  2 +-
 include/net/genetlink.h           |  3 +--
 net/l2tp/l2tp_netlink.c           |  4 ++--
 net/netlink/genetlink.c           | 28 ++++++++++++++--------------
 net/wireless/nl80211.c            |  8 ++------
 5 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 7eb94894bd68faf639a9fc02da004b986df89c2b..717931267bda0c52829c628d09cbfbf80ea63a54 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -2130,7 +2130,7 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
 	}
 
 	ret = genlmsg_multicast_allns(&tcmu_genl_family, skb, 0,
-				      TCMU_MCGRP_CONFIG, GFP_KERNEL);
+				      TCMU_MCGRP_CONFIG);
 
 	/* Wait during an add as the listener may not be up yet */
 	if (ret == 0 ||
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9ab49bfeae789afc11338ac1c89bb081566554a8..c1d91f1d20f6c9badde002fc0f412a3ce73a89c5 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -531,13 +531,12 @@ static inline int genlmsg_multicast(const struct genl_family *family,
  * @skb: netlink message as socket buffer
  * @portid: own netlink portid to avoid sending to yourself
  * @group: offset of multicast group in groups array
- * @flags: allocation flags
  *
  * This function must hold the RTNL or rcu_read_lock().
  */
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags);
+			    unsigned int group);
 
 /**
  * genlmsg_unicast - unicast a netlink message
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 284f1dec1b56dd07b4e6e22af3088233b4a25069..59457c0c14aab811b6157819ca4c9ac1eb579b6f 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -116,7 +116,7 @@ static int l2tp_tunnel_notify(struct genl_family *family,
 				  NLM_F_ACK, tunnel, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
@@ -144,7 +144,7 @@ static int l2tp_session_notify(struct genl_family *family,
 				   NLM_F_ACK, session, cmd);
 
 	if (ret >= 0) {
-		ret = genlmsg_multicast_allns(family, msg, 0, 0, GFP_ATOMIC);
+		ret = genlmsg_multicast_allns(family, msg, 0, 0);
 		/* We don't care if no one is listening */
 		if (ret == -ESRCH)
 			ret = 0;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index feb54c63a1165f25bdeb95daa11080374ad91761..07ad65774fe298a1fea8e67413521252fc31ed20 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1501,15 +1501,11 @@ static int genl_ctrl_event(int event, const struct genl_family *family,
 	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
-	if (!family->netnsok) {
+	if (!family->netnsok)
 		genlmsg_multicast_netns(&genl_ctrl, &init_net, msg, 0,
 					0, GFP_KERNEL);
-	} else {
-		rcu_read_lock();
-		genlmsg_multicast_allns(&genl_ctrl, msg, 0,
-					0, GFP_ATOMIC);
-		rcu_read_unlock();
-	}
+	else
+		genlmsg_multicast_allns(&genl_ctrl, msg, 0, 0);
 
 	return 0;
 }
@@ -1929,23 +1925,23 @@ static int __init genl_init(void)
 
 core_initcall(genl_init);
 
-static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
-			 gfp_t flags)
+static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group)
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
 	bool delivered = false;
 	int err;
 
+	rcu_read_lock();
 	for_each_net_rcu(net) {
 		if (prev) {
-			tmp = skb_clone(skb, flags);
+			tmp = skb_clone(skb, GFP_ATOMIC);
 			if (!tmp) {
 				err = -ENOMEM;
 				goto error;
 			}
 			err = nlmsg_multicast(prev->genl_sock, tmp,
-					      portid, group, flags);
+					      portid, group, GFP_ATOMIC);
 			if (!err)
 				delivered = true;
 			else if (err != -ESRCH)
@@ -1954,27 +1950,31 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
 
 		prev = net;
 	}
+	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, GFP_ATOMIC);
+
+	rcu_read_unlock();
 
-	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
 		return err;
 	return delivered ? 0 : -ESRCH;
  error:
+	rcu_read_unlock();
+
 	kfree_skb(skb);
 	return err;
 }
 
 int genlmsg_multicast_allns(const struct genl_family *family,
 			    struct sk_buff *skb, u32 portid,
-			    unsigned int group, gfp_t flags)
+			    unsigned int group)
 {
 	if (WARN_ON_ONCE(group >= family->n_mcgrps))
 		return -EINVAL;
 
 	group = family->mcgrp_offset + group;
-	return genlmsg_mcast(skb, portid, group, flags);
+	return genlmsg_mcast(skb, portid, group);
 }
 EXPORT_SYMBOL(genlmsg_multicast_allns);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9ab777e0bd4d3493619ed73b279a80a84ce476e2..d7d099f7118ab5d5c745905abdea85d246c2b7b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17986,10 +17986,8 @@ void nl80211_common_reg_change_event(enum nl80211_commands cmd_id,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
@@ -18722,10 +18720,8 @@ void nl80211_send_beacon_hint_event(struct wiphy *wiphy,
 
 	genlmsg_end(msg, hdr);
 
-	rcu_read_lock();
 	genlmsg_multicast_allns(&nl80211_fam, msg, 0,
-				NL80211_MCGRP_REGULATORY, GFP_ATOMIC);
-	rcu_read_unlock();
+				NL80211_MCGRP_REGULATORY);
 
 	return;
 
-- 
2.47.0.rc1.288.g06298d1525-goog


