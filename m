Return-Path: <netdev+bounces-275441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FgTHDP60WkeSAcAu9opvQ
	(envelope-from <netdev+bounces-275441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 717A639D791
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 07:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E3823003BC2
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DEF36B047;
	Sun,  5 Apr 2026 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOgcaqI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBE36AB46
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775368740; cv=none; b=TCQY/hON0P81Qo7RONvBz5MDNXloDsmXgd9Szj5srTmMvBC/Dxg+mR2O19fC7z2uBLYFamw+TqRTRTfVF0jb4ArVr4mlQZgEEszbzwi/ZRy1+unIHiP+lxgnNfJAOUGlIhtVHxHMNij178I3WV7Gr9aYv76+7aMBqUYPGE7VoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775368740; c=relaxed/simple;
	bh=SsQDzGgZGrTrC0hgM+JKdscuzJK0EEyGj9/wBi0Vghk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4i72txcbIPERAia+RnXfKJm1PWjlV0asn5nKqQKBQxD8mkg6qa069My2BCO/1lzTKYPdUR+QF3DuFJphUped6MtdDwKky57IkLF2R0E/cFFs35YS87PR6qA7PCruPVrMTYnmt+pux6eixZkZCOQsG+wjGN4gliMDDK+pzYkRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOgcaqI1; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-650140d4886so448688d50.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775368738; x=1775973538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GVt+PhLeKmlUNQJMRo/067xPnVzbTIveNJQxTJ9+7s=;
        b=eOgcaqI1jX5tBWjx05hwUKdyYkCuDFKhlcUhBBUSGJJUXd9Av5P5/I3UvEDtnn/CFn
         8nLqoD0F+yJ4zxaYpnuNlcyJTGFqg06f7ziAc1beA2lopqIFSegL6TEZ46TgyzbCOtaN
         BE1z3gu6DsG77Lp6WfRmTrTGMn5li9dhar3zczZIR/Ko7iqH/Qhio8FNbz9A++iarCyV
         91RdUIfcvgEc/69hpjiM+6a7nhbEC/gJWoJxG/4kgNiNE5cwY7SXaEl5dAVmF4z69Llm
         9Yt99a7bJubT7qmBHjHGzURMTBx8h7BdQ/0kFih6kE7N8UyFJI8dp/D0A+5KrmhFuN3z
         FmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775368738; x=1775973538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GVt+PhLeKmlUNQJMRo/067xPnVzbTIveNJQxTJ9+7s=;
        b=iEKtjz7HNNKr+9AADsn757XPYuKX/X8HVdccUVcwXnobIQul0xwlqApjNCO/vvNtJC
         KjtpXkFVBrdZqSE1p2G0nlsPjB69D0iFWroCtB7HrJEBm4r7wEP+o1xWtFy3bFg/dr1c
         femVH4MVYKH4Ah9GKO/QsXNDp+0tDp085uN5djnFEct62wRha7dSsmgZsCdE7Okiy4lX
         W27LKrEawKdQdL2+itLcYMvBRo6HjGt1SrBbHvMZHPiIA/R4KNy5lZt+VSaDyImmHyAH
         tHw8txCJf+EiSzbX6+7n6ZDG0GdHDHxvGEgqCiDnc9s/ECg+GiCYq8QAjgrQ9xsJ98Lk
         WMhw==
X-Gm-Message-State: AOJu0YxHTI5Om63W/tbEhH1Ho+bCJGE8Ctcrts50mZFroNNrTSFwRSiE
	PydtG6PHKFvHaY0nGzwSKAo0SLOf3rpLg4ZyECQBEZfHHoor47mFIzUQb15j6Sr1
X-Gm-Gg: AeBDieueLa87sjvd7y/JMxA0Mkm4kqRP/H+v7VQHK7JlVMWEF9Nxvhmy1TTjuA9W5eZ
	ttUW0IUDnl5soDro29r9dizAth/DBcHPGc4xGUs/1zHA77Iga66U6CghiCFJuIPC0Wre2Ta16oR
	amnCpNTSS0xWadGFGqyWAxFZC3LFQnLJOTmQIlDHN3/h113Xcftu+05sspxhjGhTA+9+qNp9VUR
	6UI6boirvuX/EhT58d3xgXN8DHuDZFQS6UalegheGYwuscFalQBZZ1K/joMqnOTdUrEj17+WmCN
	v8hpUh2pgkf03lDXRiWAXyaXNO9/2Zayq4CGfkh5aFKiUBSlaYP/EHDpXbpb2UN+T9NPnUMtMhl
	VRf1ztBTMeHexC7B4m0gKe8oR9c9p1+8BV8P4JoAGUlrIedRguUt6BfPgawNo5moQHvFsYG+HuG
	d2VL+3Oi3Oi52ruLZ3dMeYPrYn
X-Received: by 2002:a05:690e:140b:b0:64e:a213:da9f with SMTP id 956f58d0204a3-6504882546dmr5728870d50.3.1775368738134;
        Sat, 04 Apr 2026 22:58:58 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a97908dsm4437520d50.13.2026.04.04.22.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 22:58:57 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v10 net-next 1/5] psp: add admin/non-admin version of psp_device_get_locked
Date: Sat,  4 Apr 2026 22:58:48 -0700
Message-ID: <20260405055853.3285534-2-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275441-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 717A639D791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wei Wang <weibunny@fb.com>

Introduce 2 versions of psp_device_get_locked:
1. psp_device_get_locked_admin(): This version is used for operations
   that would change the status of the psd, and are currently used for
   dev-set nad key-rotation.
2. psp_device_get_locked(): This is the non-admin version, which are
   used for broader user issued operations including: dev-get, rx-assoc,
   tx-assoc, get-stats.

Following commit will be implementing both of the checks.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 Documentation/netlink/specs/psp.yaml |  4 ++--
 net/psp/psp-nl-gen.c                 |  4 ++--
 net/psp/psp-nl-gen.h                 |  2 ++
 net/psp/psp.h                        |  2 +-
 net/psp/psp_main.c                   |  7 +++++-
 net/psp/psp_nl.c                     | 33 ++++++++++++++++++++--------
 6 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index f3a57782d2cf..fe2cdc966604 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -195,7 +195,7 @@ operations:
             - psp-versions-ena
         reply:
           attributes: []
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-admin
         post: psp-device-unlock
     -
       name: dev-change-ntf
@@ -214,7 +214,7 @@ operations:
         reply:
           attributes:
             - id
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-admin
         post: psp-device-unlock
     -
       name: key-rotate-ntf
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 22a48d0fa378..1f5e73e7ccc1 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -71,7 +71,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 	},
 	{
 		.cmd		= PSP_CMD_DEV_SET,
-		.pre_doit	= psp_device_get_locked,
+		.pre_doit	= psp_device_get_locked_admin,
 		.doit		= psp_nl_dev_set_doit,
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_dev_set_nl_policy,
@@ -80,7 +80,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 	},
 	{
 		.cmd		= PSP_CMD_KEY_ROTATE,
-		.pre_doit	= psp_device_get_locked,
+		.pre_doit	= psp_device_get_locked_admin,
 		.doit		= psp_nl_key_rotate_doit,
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_key_rotate_nl_policy,
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 599c5f1c82f2..977355455395 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -17,6 +17,8 @@ extern const struct nla_policy psp_keys_nl_policy[PSP_A_KEYS_SPI + 1];
 
 int psp_device_get_locked(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info);
+int psp_device_get_locked_admin(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info);
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 				struct sk_buff *skb, struct genl_info *info);
 void
diff --git a/net/psp/psp.h b/net/psp/psp.h
index 9f19137593a0..0f9c4e4e52cb 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -14,7 +14,7 @@ extern struct xarray psp_devs;
 extern struct mutex psp_devs_lock;
 
 void psp_dev_free(struct psp_dev *psd);
-int psp_dev_check_access(struct psp_dev *psd, struct net *net);
+int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 9508b6c38003..82de78a1d6bd 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -27,10 +27,15 @@ struct mutex psp_devs_lock;
  * psp_dev_check_access() - check if user in a given net ns can access PSP dev
  * @psd:	PSP device structure user is trying to access
  * @net:	net namespace user is in
+ * @admin:	If true, only allow access from @psd's main device's netns,
+ *		for admin operations like config changes and key rotation.
+ *		If false, also allow access from network namespaces that have
+ *		an associated device with @psd, for read-only and association
+ *		management operations.
  *
  * Return: 0 if PSP device should be visible in @net, errno otherwise.
  */
-int psp_dev_check_access(struct psp_dev *psd, struct net *net)
+int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool admin)
 {
 	if (dev_net(psd->main_netdev) == net)
 		return 0;
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 6afd7707ec12..eb47a9ee4438 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -41,7 +41,8 @@ static int psp_nl_reply_send(struct sk_buff *rsp, struct genl_info *info)
 /* Device stuff */
 
 static struct psp_dev *
-psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
+psp_device_get_and_lock(struct net *net, struct nlattr *dev_id,
+			bool admin)
 {
 	struct psp_dev *psd;
 	int err;
@@ -56,7 +57,7 @@ psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
 	mutex_lock(&psd->lock);
 	mutex_unlock(&psp_devs_lock);
 
-	err = psp_dev_check_access(psd, net);
+	err = psp_dev_check_access(psd, net, admin);
 	if (err) {
 		mutex_unlock(&psd->lock);
 		return ERR_PTR(err);
@@ -65,17 +66,31 @@ psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
 	return psd;
 }
 
-int psp_device_get_locked(const struct genl_split_ops *ops,
-			  struct sk_buff *skb, struct genl_info *info)
+static int __psp_device_get_locked(const struct genl_split_ops *ops,
+				   struct sk_buff *skb, struct genl_info *info,
+				   bool admin)
 {
 	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
 		return -EINVAL;
 
 	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
-						    info->attrs[PSP_A_DEV_ID]);
+						    info->attrs[PSP_A_DEV_ID],
+						    admin);
 	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
 }
 
+int psp_device_get_locked_admin(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info)
+{
+	return __psp_device_get_locked(ops, skb, info, true);
+}
+
+int psp_device_get_locked(const struct genl_split_ops *ops,
+			  struct sk_buff *skb, struct genl_info *info)
+{
+	return __psp_device_get_locked(ops, skb, info, false);
+}
+
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info)
@@ -160,7 +175,7 @@ static int
 psp_nl_dev_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
 			  struct psp_dev *psd)
 {
-	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+	if (psp_dev_check_access(psd, sock_net(rsp->sk), false))
 		return 0;
 
 	return psp_nl_dev_fill(psd, rsp, genl_info_dump(cb));
@@ -305,7 +320,7 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 
 	psd = psp_dev_get_for_sock(socket->sk);
 	if (psd) {
-		err = psp_dev_check_access(psd, genl_info_net(info));
+		err = psp_dev_check_access(psd, genl_info_net(info), false);
 		if (err) {
 			psp_dev_put(psd);
 			psd = NULL;
@@ -330,7 +345,7 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 
 		psp_dev_put(psd);
 	} else {
-		psd = psp_device_get_and_lock(genl_info_net(info), id);
+		psd = psp_device_get_and_lock(genl_info_net(info), id, false);
 		if (IS_ERR(psd)) {
 			err = PTR_ERR(psd);
 			goto err_sock_put;
@@ -573,7 +588,7 @@ static int
 psp_nl_stats_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
 			    struct psp_dev *psd)
 {
-	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+	if (psp_dev_check_access(psd, sock_net(rsp->sk), false))
 		return 0;
 
 	return psp_nl_stats_fill(psd, rsp, genl_info_dump(cb));
-- 
2.52.0


