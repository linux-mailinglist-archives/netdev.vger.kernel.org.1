Return-Path: <netdev+bounces-294971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kqsgMuLAIGo87gAAu9opvQ
	(envelope-from <netdev+bounces-294971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:03:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 271D063BF72
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 02:03:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JLX+WOyP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294971-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294971-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FA293086991
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569094DD6D7;
	Wed,  3 Jun 2026 23:59:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D64D9901
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:59:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531193; cv=none; b=hoZVx/dxXo8rW9n904tLdeVrP1lhQtY8oc5V4lxKDUgM6FVUGamvhi8/oVIUCGPwPAU1rpQIEqmvNq3bWD/Gbc9bZ3UjnoAK+PyypuZ8mCiDwttf4n8rtbzR6dFkQ/hi18e8aUsKT8SHnz37KeSuYwQxb+DBcwurJNqTcapE7R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531193; c=relaxed/simple;
	bh=pxBjKwtEH2t2rn+xDWBjfjE1VUT5Fue6VYkz2vk17xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9va59uPSQ2eCRi5XelM8HG1wJP9E8+XUsl6uL8GQRrDkVT/t5F8fqB9a51R+kgSxrtRpg6BRA7YSXHVGTWyB2XCUwkyT4OmspcEPeK92HSGY1sK6jJoKWEwO12s1muleaO8ybZGfQSIUqpHqDvrqdLSQrcXcdZe4RRK385pmWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLX+WOyP; arc=none smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-660a40aac63so11335d50.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780531191; x=1781135991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25hLrp+L6VZJrpAv7whXxLsdCJndsgyfb3zsbcFNsUI=;
        b=JLX+WOyPGuWQSxBQR4ZXlwJysKH/jF5Y/BhFURktP66Hq4pV+MVrgAUXsMRNWbn/of
         Q0Qic7bvKiKTG1pnzecRjhPwkJL2JomZWzJUfj/iT9xlLsaPth0R0VLi0xla7vgRWTVc
         YJuCBo/0w2lFxg9M8D5d13OGitaHSEZplg+mFC01dDkJPve+d0XyvzYLVbjVUiRnPwMI
         /Wawl+AUtH1ZvhwmGxzEoiilvWkuOnF3vD7IvEDmSsGzkmB+8Xhj/0S1RyIoEm7+ky2W
         T6RwSwa0wj/G15nHCa3Tj7aDkXX6BiKIJ7y7AMDOfdrZCLWqXuaPpDfZmCgLDKfKkgUQ
         EDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780531191; x=1781135991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25hLrp+L6VZJrpAv7whXxLsdCJndsgyfb3zsbcFNsUI=;
        b=r7HYMGE8cUjv1YOpXN9Ysbm9r9bVm1GxZM4ZU+M4VB6Mv7hdDCUTHHg0iN+yJXBu7I
         5PvELNVAiracOGgJok+AFe/XyBp19y6tdkWLWuMdMKKQxXLhN0TGLDlPNuEBxNbJUDI0
         OmQINCL6Pxvd5oPVlvLzCYcVr4yKkSc0mc13wByx1TfR2+iOFiPl5JduodqKan54stSF
         9wyqBBvfnnmXyEs6RYP23w9IH1chvIicoKAxlbmDb7fT7Gza16GFfNTZiWjwK/5cHBjm
         KzuE6zby1EFUhlQY2Qn/ID1Sw24gmMVm9ynK32w8nK9WcNX7yGAKcs7zUN+EBJBwcB1L
         emLQ==
X-Gm-Message-State: AOJu0Ywmv5/m8UQl1uySP34bPuV8ztf0ju0V9c9+lZd9cji6N3ad+pAy
	BLydFLqvwvcEsb6ESuaZwkit2T3CvR1QLioA9xpD7lxynzfETEaQxC9iZFOqUg==
X-Gm-Gg: Acq92OEB3o6cuaJMS0/xB3YFqQglr1tjy5wIS8NnVxp/+BQTYkVr41gEYP/R9BG5GZ7
	MEv216TpEzgcEqGGUzLSF0Uzhzr57/xQJKyu6eIgJeUlVgO9sHToEPYYh0WKRDmURrJLW2n9s8A
	yMmHYF4GWadFrq6ldPD2c9RaNfdEjLlgb779arhoS6cONqPyCa+nMzcLA8X8YMb+LthSy9aEPfA
	+B5fWW5Q85yDMT57SZPbwpuN6pT8j4+ywIJElq4RHBym70CS8Scgx0SGC0RtUUI3J/o09IVdZ+h
	8lA+IH0lv+DSVBuaXC9ozDsL4x8CMytLxcl1hC351QhpEH19WYRpkgT85G39DXIhiH/ADsFocYN
	JUFJiSOa2uziZBd6ksBTttDmNH/Rz0xVS5l39qHxeZ2MQArBCf+G25y7SRl+7ShRxTa/s21W7NM
	iFwtjaUzs+Vq/IbjrMIaMnHXgZGYJQclKXnbj91uNWAG9vLQ==
X-Received: by 2002:a05:690e:b4e:b0:653:1298:2757 with SMTP id 956f58d0204a3-660f40fd7eamr298780d50.3.1780531190716;
        Wed, 03 Jun 2026 16:59:50 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:71::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d6488b1csm2878695d50.19.2026.06.03.16.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:59:50 -0700 (PDT)
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
Subject: [PATCH v15 net-next 01/10] psp: add admin/non-admin version of psp_device_get_locked
Date: Wed,  3 Jun 2026 16:59:30 -0700
Message-ID: <20260603235947.2986110-2-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
References: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294971-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 271D063BF72

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


