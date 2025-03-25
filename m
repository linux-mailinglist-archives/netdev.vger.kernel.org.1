Return-Path: <netdev+bounces-177556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252F7A70898
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6220F3BCFC2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5114263F41;
	Tue, 25 Mar 2025 17:54:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903CB2641E2;
	Tue, 25 Mar 2025 17:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925272; cv=none; b=clUNFrsACjPT44+2Vr0x4UcjLKr7KOgB2Lmk2NAX6wL2sjIOMpkjMC90rzN+0PAiLOX4CglG2HLEdF8axS/KtPzqIFcpMMCYqVZNMY1sLvL3RA5mviEbBmEsobn1VW1a/4h2ijEmcwjugPRPRNK/L0htmmr6qCfPZicJSFC8QmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925272; c=relaxed/simple;
	bh=+u1HyZPPd+R2u3/AXT9yxNUrkUbLjE2OSYzRgR7BXOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sSXAZiXe4TLIHscfPQaWaRTrNOks3GqMH9PaFPL8ql65MY+lsxbx0Jl3UU1N79a3XAHL1Fpa+NvolWzb+JVaWNW1UCc5zTxjhZRKU/4f59Nq5QBCfMVzsDRdC/Me1MuqM0DJkTsZFQcYK8yhQlthQtLpim9+CCPCPaBiqwA1APw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso10019630a91.1;
        Tue, 25 Mar 2025 10:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925269; x=1743530069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KL3xXNyveKKELLggKhdktNiKOym+xaaWn+kS6J3KeJI=;
        b=VbA/7iLv3wqL9Btw+HQb8WoQVBHWwME+MA3GIQP64gCk2f93rEUVlzgMnSo5TTCIv4
         CqKn1V/J5bGcQuFUnC2wceLs2oAUMgIfchCfsRQ4YHGpSBG1VfApSWmhx1LZvSybyvyC
         /Upwtnra45iXbAyH8oTzrv6B4SAdNj6liqt317mAQvcp0lsHzP8Tn7LW8V5l8Xh4k/n1
         u8N3XTlBKumiAnR+mbskOzQlqkZMvAW7Z8biP3IMLOpJm7SnO2qhxsRAv3e6wqaaBVp8
         4gTCz+doJUdRsIR3Hr1WaaNDML5fgqLJ7pFM+H6qBeV0y874RW3sSMA+LNxw/bgNK7fo
         fO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHeE+m+TJf/UIkSYiEyc1oliDXWylctQvOUQb9Dzl80j25GAv15CBHEL0Y45V3ZMUx3P96bu4C7HldTZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEj8Ti/U40MSDjCzGSkcQfOQiUDtO77SXOJsjqAUrDdbgx4I0y
	K48nqFAE4FWE3LTKg8C7UC9/6cjTE0sdnuEEechVPHKFcZd7jgDNinTFb+Q=
X-Gm-Gg: ASbGncvwpxzs2MOGtC71TUrFffZXldDOvGMXGdcE+dnnBCpgJF7oSmg6gqfGDnWW2G+
	7vlYkXtWedKqStIjzinBmdx92UHxxntVZXxVIRpXXDI7WmnTNskOO0Rx4bCxNwli3qXX6XAHuvM
	Pb5YINYcYj171jbreolSfmRimV7XfOmq6HBTR3kMQCA6/WoSoM2rOmVVN5H+FuacM0qGoMbWwI7
	uqZfAb6tCENzn+dOx8iqONMqRnaH070stOpS+9Pjnsp6XBC0fPmpiRmPQHTLh6TGWB2LGaiqt3R
	6V0bAYJu8JmvSbHNW1Igv0gW13kHQLaRQ3TSK+zpEVvuAYmP2yeYUXw=
X-Google-Smtp-Source: AGHT+IHRpLw1w9FOMNF/WEqbsCKznVqXm++T2qibIkMyWcdjpgvrf8acBwLi05NTUhlivjhGkd0qxQ==
X-Received: by 2002:a17:90b:394c:b0:2ff:52b8:2767 with SMTP id 98e67ed59e1d1-3030fe9d786mr28288794a91.19.1742925268817;
        Tue, 25 Mar 2025 10:54:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3030f5f892dsm10671794a91.22.2025.03.25.10.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:54:28 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	horms@kernel.org,
	sdf@fomichev.me
Subject: [PATCH net-next] net: move replay logic to tc_modify_qdisc
Date: Tue, 25 Mar 2025 10:54:27 -0700
Message-ID: <20250325175427.3818808-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric reports that by the time we call netdev_lock_ops after
rtnl_unlock/rtnl_lock, the dev might point to an invalid device.
As suggested by Jakub in [0], move rtnl lock/unlock and request_module
outside of qdisc_create. This removes extra complexity with relocking
the netdev.

0: https://lore.kernel.org/netdev/20250325032803.1542c15e@kernel.org/

Fixes: a0527ee2df3f ("net: hold netdev instance lock during qdisc ndo_setup_tc")
Reported-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/20250305163732.2766420-1-sdf@fomichev.me/T/#me8dfd778ea4c4463acab55644e3f9836bc608771
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/sched/sch_api.c | 73 +++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index aef39f6dc6a8..fcb07c03117e 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1268,38 +1268,8 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 	struct qdisc_size_table *stab;
 
 	ops = qdisc_lookup_ops(kind);
-#ifdef CONFIG_MODULES
-	if (ops == NULL && kind != NULL) {
-		char name[IFNAMSIZ];
-		if (nla_strscpy(name, kind, IFNAMSIZ) >= 0) {
-			/* We dropped the RTNL semaphore in order to
-			 * perform the module load.  So, even if we
-			 * succeeded in loading the module we have to
-			 * tell the caller to replay the request.  We
-			 * indicate this using -EAGAIN.
-			 * We replay the request because the device may
-			 * go away in the mean time.
-			 */
-			netdev_unlock_ops(dev);
-			rtnl_unlock();
-			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
-			rtnl_lock();
-			netdev_lock_ops(dev);
-			ops = qdisc_lookup_ops(kind);
-			if (ops != NULL) {
-				/* We will try again qdisc_lookup_ops,
-				 * so don't keep a reference.
-				 */
-				module_put(ops->owner);
-				err = -EAGAIN;
-				goto err_out;
-			}
-		}
-	}
-#endif
-
-	err = -ENOENT;
 	if (!ops) {
+		err = -ENOENT;
 		NL_SET_ERR_MSG(extack, "Specified qdisc kind is unknown");
 		goto err_out;
 	}
@@ -1624,8 +1594,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 			     struct netlink_ext_ack *extack,
 			     struct net_device *dev,
 			     struct nlattr *tca[TCA_MAX + 1],
-			     struct tcmsg *tcm,
-			     bool *replay)
+			     struct tcmsg *tcm)
 {
 	struct Qdisc *q = NULL;
 	struct Qdisc *p = NULL;
@@ -1790,13 +1759,8 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 tcm->tcm_parent, tcm->tcm_handle,
 				 tca, &err, extack);
 	}
-	if (q == NULL) {
-		if (err == -EAGAIN) {
-			*replay = true;
-			return 0;
-		}
+	if (!q)
 		return err;
-	}
 
 graft:
 	err = qdisc_graft(dev, p, skb, n, clid, q, NULL, extack);
@@ -1809,6 +1773,27 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static void request_qdisc_module(struct nlattr *kind)
+{
+	struct Qdisc_ops *ops;
+	char name[IFNAMSIZ];
+
+	if (!kind)
+		return;
+
+	ops = qdisc_lookup_ops(kind);
+	if (ops) {
+		module_put(ops->owner);
+		return;
+	}
+
+	if (nla_strscpy(name, kind, IFNAMSIZ) >= 0) {
+		rtnl_unlock();
+		request_module(NET_SCH_ALIAS_PREFIX "%s", name);
+		rtnl_lock();
+	}
+}
+
 /*
  * Create/change qdisc.
  */
@@ -1819,27 +1804,23 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	struct nlattr *tca[TCA_MAX + 1];
 	struct net_device *dev;
 	struct tcmsg *tcm;
-	bool replay;
 	int err;
 
-replay:
-	/* Reinit, just in case something touches this. */
 	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
 				     rtm_tca_policy, extack);
 	if (err < 0)
 		return err;
 
+	request_qdisc_module(tca[TCA_KIND]);
+
 	tcm = nlmsg_data(n);
 	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
 	if (!dev)
 		return -ENODEV;
 
-	replay = false;
 	netdev_lock_ops(dev);
-	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay);
+	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm);
 	netdev_unlock_ops(dev);
-	if (replay)
-		goto replay;
 
 	return err;
 }
-- 
2.48.1


