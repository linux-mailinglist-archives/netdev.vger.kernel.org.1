Return-Path: <netdev+bounces-267554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JzCBEhXtGlbmAAAu9opvQ
	(envelope-from <netdev+bounces-267554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:28:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C802288BB0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77F503026BC9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2CA3DD528;
	Fri, 13 Mar 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8aorxJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8E3DDDB0
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426498; cv=none; b=WLvCLpqWZacqcLSiWlMpxkE4PEJI4YCosi6aIbpU0l7f/GqAXqNJilh1AaA/mp2qHz7CHt5cMwkHeJ26G4WieTUbLLDDb+PtRk3uxsGt9VHhOs+J3aqv1S0MRxYuFRM1mpsFfb69jTI12lhBRcaWKBU2b2b/VH4OcJ9XYNcYzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426498; c=relaxed/simple;
	bh=z7O5uDrHFBa2yYFygk5BeTauqO9/Q4LLBn8f97UuQKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kze4PYF5EkhA9bSkYr+2AEMWUffnKeO44BiRuXz4R86jkDiqY9KZyRzzfeoF+XL6IY7fa6SKu44OjWao2F8yblgwk808orI4UOEI059qGbEbxJPkAA0XGBMJWyVNRtMojWF2FBsNeJ1Vs3n/0x279q8w6Rtc7Tju2yhewxws1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8aorxJk; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6470d549e10so283839d50.3
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773426495; x=1774031295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5vMzoAzlJoxa++WHdvyaDDYcqjmQvIi2gFcyOQrLKQ=;
        b=H8aorxJkxUq8wq7RACVFqWcjxefMiqY7TwXAGk/owBCUclSYDpCix0ivzVdYk06ygE
         4cIOQheTAEyVAKRBYaLJoFTvKKWbpcjlj6iFIXKZQwuiVRFawYKxhs0Ix2h9vJphqP7I
         Ur5nFIVQUNKg6yewyJS5xpRGV6M/oyQeS+4qU4LtgnQgWRvTmstArKaoKl528JxWjv/9
         tF2+TgtIx5Ql7jkVKqoVFHoRCB6V6y+Nym3yUvQRL5qGOVBSLQj3vxvq+YcF+OHE8CJR
         wbJteaWN8Wx5FSAePhMuIjkt62kNsp6gmRu/S5bu5WkOLMNb4+GsOZbx4JstW8kcKaKO
         Pd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426495; x=1774031295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5vMzoAzlJoxa++WHdvyaDDYcqjmQvIi2gFcyOQrLKQ=;
        b=nnsHxggWeJHX1/xoA/TKcznLdYXhkTUbpzhTh2qkZj/EPNyQK6K4foTwlw7l9vLhXo
         xAiY4XK2RXIfNjejG8PlohLNDYcJ/+2pBucUbe9qVVT2rr4V90OHwI/8LNZ+O0BM3qLh
         BbUxHqp7DjTtkyVx2zcYxQbPp9x/djlg4UZV3Q7l2tEgQHTjeEnmfvWpOcM5dzEDgWfb
         ZmaiQrRbZgarHBiRx/Osd5DhqR8mt7jDOoK8SETxuOYgxwPJNhsOKGGfggZ/t0Q4cyc5
         FLtSUWccAKk8ChsKtJDxWinlU8y0P2wFPP/Ho3yjEzhPEYmhHjaVXaV9dg45B0S5zToO
         WUEw==
X-Gm-Message-State: AOJu0YxOS1wgKiGnNrZN/TLDwU/3g9f+94kGncmxcNgtGpwk4zlekoC/
	WpE1RnCeVTw9pwNWi2a/B1Gpf+pDKj4l2zf/68lB877cbFXBllJZvSsOwm6jvUvL
X-Gm-Gg: ATEYQzwOWKfKqPK93Qr6h1KyAPhcTGw76FC2TCDSj63BUMrjKOprX0d/cswuZzezPo2
	pU+kMsLyYVEs26fS2A/9Mbcdb/9VtZVm1iHNSARm3EK3y35z7alcxZZ79ydduud3r/SRs2hXZiG
	8yPNFs4IaW43Xh10p/oLLHkhr9s03peBrmYdhf/S0KXJC5I7kk0AaOzMVPgRNLoePOvvaSJFB4Q
	cYFCaxE5fNvBhrzT+A3f0XmMy/ej80VXJbHjjpR3QA72Q6UkwHWyC8OmWxptA70iOxNO5ZZOul5
	Nlkay6Ir7RD6A68L7Zjmolq2sJaUmWIn35DyuCLQF6kUWfVTbL7Ym5qbtX1r6Z136xzP26449qF
	oi7QjRQ//VEAY/22+zWiUVdXoZOa7INsZey8m4/TRGiT8KxSVhR+1HM/fqMm+f9oZJD2XWPriFs
	AeQcMATi4p8a4akoC4xy4FfPQ=
X-Received: by 2002:a05:690c:e3c8:b0:798:c633:d10f with SMTP id 00721157ae682-79a1e9c9c3dmr30257127b3.5.1773426495470;
        Fri, 13 Mar 2026 11:28:15 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917dea7c9sm50946027b3.5.2026.03.13.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:28:15 -0700 (PDT)
From: Wei Wang <weibunny.kernel@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Cc: Wei Wang <weibunny@fb.com>
Subject: [PATCH v5 net-next 1/5] psp: add admin/non-admin version of psp_device_get_locked
Date: Fri, 13 Mar 2026 11:27:59 -0700
Message-ID: <20260313182804.696100-2-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313182804.696100-1-weibunny.kernel@gmail.com>
References: <20260313182804.696100-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267554-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C802288BB0
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
 net/psp/psp_main.c                   |  7 ++++++-
 net/psp/psp_nl.c                     | 28 +++++++++++++++++++++-------
 6 files changed, 34 insertions(+), 13 deletions(-)

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
index 6afd7707ec12..b988f35412df 100644
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
@@ -65,6 +66,18 @@ psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
 	return psd;
 }
 
+int psp_device_get_locked_admin(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info)
+{
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
+		return -EINVAL;
+
+	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
+						    info->attrs[PSP_A_DEV_ID],
+						    true);
+	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
+}
+
 int psp_device_get_locked(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info)
 {
@@ -72,7 +85,8 @@ int psp_device_get_locked(const struct genl_split_ops *ops,
 		return -EINVAL;
 
 	info->user_ptr[0] = psp_device_get_and_lock(genl_info_net(info),
-						    info->attrs[PSP_A_DEV_ID]);
+						    info->attrs[PSP_A_DEV_ID],
+						    false);
 	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
 }
 
@@ -160,7 +174,7 @@ static int
 psp_nl_dev_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
 			  struct psp_dev *psd)
 {
-	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+	if (psp_dev_check_access(psd, sock_net(rsp->sk), false))
 		return 0;
 
 	return psp_nl_dev_fill(psd, rsp, genl_info_dump(cb));
@@ -305,7 +319,7 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 
 	psd = psp_dev_get_for_sock(socket->sk);
 	if (psd) {
-		err = psp_dev_check_access(psd, genl_info_net(info));
+		err = psp_dev_check_access(psd, genl_info_net(info), false);
 		if (err) {
 			psp_dev_put(psd);
 			psd = NULL;
@@ -330,7 +344,7 @@ int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 
 		psp_dev_put(psd);
 	} else {
-		psd = psp_device_get_and_lock(genl_info_net(info), id);
+		psd = psp_device_get_and_lock(genl_info_net(info), id, false);
 		if (IS_ERR(psd)) {
 			err = PTR_ERR(psd);
 			goto err_sock_put;
@@ -573,7 +587,7 @@ static int
 psp_nl_stats_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *cb,
 			    struct psp_dev *psd)
 {
-	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+	if (psp_dev_check_access(psd, sock_net(rsp->sk), false))
 		return 0;
 
 	return psp_nl_stats_fill(psd, rsp, genl_info_dump(cb));
-- 
2.52.0


