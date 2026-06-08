Return-Path: <netdev+bounces-296774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VbG1KFxRJ2oMuwIAu9opvQ
	(envelope-from <netdev+bounces-296774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AECB65B2D1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 01:33:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OGBLoGyA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296774-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296774-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0BE3028F3B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 23:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057432AABC;
	Mon,  8 Jun 2026 23:31:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48413AA2F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:31:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961484; cv=none; b=ctINnxt5u3eZLpgBBg66pP3qchywep51asV7IhEaAMWWavvKjrhdnZ8cmfOBqS7dzSSrkkJDpWcLnxNMDKrtburPcDpUMuUki6HLV9T3EF5pYAuNLW/xuV+1J22F7gPNGnCFHfI1uGvdijfyP6BiTa3A2q1lxWZLkHpmNSZaFpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961484; c=relaxed/simple;
	bh=pxBjKwtEH2t2rn+xDWBjfjE1VUT5Fue6VYkz2vk17xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNcc8wDeQMjpe+Q2Uv8sLaRnpeMTlf1Lp3fYgaoMPrX8rghCBFDN2afkc/Zn/zK8ZXyYq5SzuvQi5vNM1St+pQfu7+qxTm9B0+BUmucJFrgLZqbJTtcpNq/A+ZI7J0m+S7JANd/k8SaCJWqKcxbEtVBNScA0XpAjbljuoO+bquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGBLoGyA; arc=none smtp.client-ip=74.125.224.51
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66044692319so524425d50.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961482; x=1781566282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25hLrp+L6VZJrpAv7whXxLsdCJndsgyfb3zsbcFNsUI=;
        b=OGBLoGyAqNFRSMO4hTa3n1lehGZVfZvIeZcqpcP94INydymsIyKa/MMB3tdmRNZOsb
         qLtg+mxYL/EJqR085AWlYoW4l94PuJCqvRo4Mq8de4FOnAzi6gP93eilbbN0LzYSiulP
         +PKKLz36wehMBN7PaMKrIf3q1GOghF8ruIywMQSLFOClwxUYkm5isOfYqKUE4QkVcvKE
         jQF98laUerVsJzr35vSLMcKnYjhBnJ5St0mEBEQQrKIZIGC3xYtVzbSPSTKGJAlA3IOJ
         FqRMJ1MzPqY2Hwz+PRfhWApNTLIgvRQ58QSOQo5NBkZUETlLdq0Q9oPxYrQIRh2Xp5Oc
         9zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961482; x=1781566282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25hLrp+L6VZJrpAv7whXxLsdCJndsgyfb3zsbcFNsUI=;
        b=jJCIb+TvV5NxgiFmdiphkmwLXpUia5UIgAwHEd4ZeaMiHJkmlpSxj084wkL4Zx06SM
         Dm6OWDZpJt830R3r2H+nh3Ybe02nIlHV7auYA4RjuQQlNTsJe8gpppNKhjo9aKcBlw/j
         g2d/H7K1L+d+NcKJtxsCmWTtAE3CCQ9Y6ROsCS/krlg+e2soDYPmsSbLA1hvC7sy1JU5
         8xQu+o1T5QhKLhciUk0MpKllgbvWmbM+PH4RZqy2UlgH/x53syZvlwW16ZaSSihvx2LA
         RVUgN7No234I+04uhjr+fbAQrXttxZbDb3z9GOSZH749kGFIkYjFwYXPbgI1SQz1+a2T
         2oBg==
X-Gm-Message-State: AOJu0Yzl2LHSHj6wBGFwxMNlrf00WRy6tGZKJ85aDUDaGTp3iCnObU1/
	CTQ98hHFP48S6ybNWpml6Nkh3AQMcSVA7mn5w92jj2tw5A2tKU9Z5P5e6Z+DCA==
X-Gm-Gg: Acq92OHEslMaZNNj/lJowjKyEi1SNYQDkpOAbywHGlMwd5gB9cP2i3kJO3peTSVmYa2
	KII33xVfy1LXy4ed70/DQY1mKGa1M3J58wTHHekUixEoH4v29jgk4q//vYL1EcHec6xSA3GALIK
	Tj68I9pRPrQApyiyMXdSIYa1F5A/jpjzozm3wcB7bFOqFCj6vWX+8tMyhYNkwKtpHZZQSne/1vZ
	GrWQL7bprfRFq9vFBa9jK0ocFf4MaE5KBNeLffbj76rrWWfCgwegGZNsuezfzhnFv4m5l6AeYPk
	RlN4KnaiPs/q/1bMGELWwC7cM68MNDBEfqvWVsTQY2IUE1afR7VdG4o15QUR7wVk28pCwuDXf26
	GjKqP4b0bAKT/llHNJizzZTBY/xHYC1WL9DKeeIQV7Yqj/mvsx21d7OiKIOh1dhdVZWppQrWqPN
	7HgJHzGGhqNvsPUNxCaKBwN87/n0ohV535bg==
X-Received: by 2002:a05:690e:1904:b0:65d:7fad:2207 with SMTP id 956f58d0204a3-66106fd585fmr9622632d50.8.1780961482087;
        Mon, 08 Jun 2026 16:31:22 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d5f89271sm10024790d50.8.2026.06.08.16.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:31:21 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v16 net-next 01/10] psp: add admin/non-admin version of psp_device_get_locked
Date: Mon,  8 Jun 2026 16:31:09 -0700
Message-ID: <20260608233118.2694144-2-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
References: <20260608233118.2694144-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296774-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fb.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AECB65B2D1

From: Wei Wang <weibunny@fb.com>

Introduce 2 versions of psp_device_get_locked:
1. psp_device_get_locked_admin(): This version is used for operations
   that would change the status of the psd, and are currently used for
   dev-set and key-rotation.
2. psp_device_get_locked(): This is the non-admin version, which are
   used for broader user issued operations including: dev-get, rx-assoc,
   tx-assoc, get-stats.

Following commit will be implementing both of the checks.

Signed-off-by: Wei Wang <weibunny@fb.com>
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 Documentation/netlink/specs/psp.yaml |  4 ++--
 net/psp/psp-nl-gen.c                 |  4 ++--
 net/psp/psp-nl-gen.h                 |  2 ++
 net/psp/psp.h                        |  2 +-
 net/psp/psp_main.c                   |  7 +++++-
 net/psp/psp_nl.c                     | 33 ++++++++++++++++++++--------
 6 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index bfcd6e4ecb85..e3b0fe296e8f 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -196,7 +196,7 @@ operations:
             - psp-versions-ena
         reply:
           attributes: []
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-admin
         post: psp-device-unlock
     -
       name: dev-change-ntf
@@ -216,7 +216,7 @@ operations:
         reply:
           attributes:
             - id
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-admin
         post: psp-device-unlock
     -
       name: key-rotate-ntf
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 953309952cef..a71dd629aeab 100644
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
index ccbbb2a5fa58..aaa44e6cb9ff 100644
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
index 0cc744a6e1c9..b4f1b7f9b0c2 100644
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
@@ -310,7 +325,7 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 		 */
 		mutex_lock(&psd->lock);
 		if (!psp_dev_is_registered(psd) ||
-		    psp_dev_check_access(psd, genl_info_net(info))) {
+		    psp_dev_check_access(psd, genl_info_net(info), false)) {
 			mutex_unlock(&psd->lock);
 			psp_dev_put(psd);
 			psd = NULL;
@@ -334,7 +349,7 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 
 		psp_dev_put(psd);
 	} else {
-		psd = psp_device_get_and_lock(genl_info_net(info), id);
+		psd = psp_device_get_and_lock(genl_info_net(info), id, false);
 		if (IS_ERR(psd)) {
 			err = PTR_ERR(psd);
 			goto err_sock_put;
@@ -577,7 +592,7 @@ static int
 psp_nl_stats_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
 			    struct psp_dev *psd)
 {
-	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+	if (psp_dev_check_access(psd, sock_net(rsp->sk), false))
 		return 0;
 
 	return psp_nl_stats_fill(psd, rsp, genl_info_dump(cb));
-- 
2.52.0


