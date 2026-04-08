Return-Path: <netdev+bounces-276744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKbeLHLh1mnUJQgAu9opvQ
	(envelope-from <netdev+bounces-276744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:14:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAF3C4BDE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF2273014865
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985B37FF4E;
	Wed,  8 Apr 2026 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMi/2uGZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5F386C0F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775690064; cv=none; b=rPsZAQk8CWPOzfayXiWD5PPtXvr4/Iwi8aQwzlAoBpivk2FHUaBarBOmj5N6T/bKM5CoaI58IeWHTNNpXHIyiW72vxNnjeAf6j3XsJWhF5DEq4HD4O42tjNkATIY1QtPVjcrnKDqH9Hfj+5WcNkg0cqw7HeDoEg990AEu4Cd4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775690064; c=relaxed/simple;
	bh=9OvJAySVnJT6emSweYvbg3dtprGlyfnChgfLzQwxBdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaeqbMIcUNir+i+TCyP0o2Bs7Ox/txzwkf4Is+JJBcETs5VYJD0v+5ZzWY0JCTYgoLXl/75aIiBo65cxorwducfY0pyxwvPeo3ePLgjsvBnO3+2/3UMmqMUHJ96iqUvgP++uzlB5ytzdfYGVRY02m/AacQen83wECcV5un5vN04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMi/2uGZ; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6500ff16c0aso33451d50.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775690062; x=1776294862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFom3GqY7i4bOkS6YmLFc+xoimFf3UEXYzV7a+y0rXE=;
        b=KMi/2uGZUwWeHpmxM+Yf09Wklva49QOypNA71N5bmCvmGwF5bK7YGf6Gl/mhqSVlrQ
         Y9/N8TIqkzH2G2H4dTcuXxMUpT6G25gsbIe5l0M2ZT8aMuwsmWtAXvnq4+PqfTdd9cYw
         jRGoCwSngG2j06ECHKGRz2RWFX+z/kVdTyAFrvKJlW+cilwc3WrppEGbGbjDPNKSdQXK
         yH2ah80U+AUXYWT0S66H0Vdq1QqSUiEJ4qupYSdJKt+EQl9IFGNRdo3K8vRlG9wIaN/5
         Xh/RN7GmTsfOi4G1nPW0db5QGxcmFo7AFAQACrocMwpZb1zTaYIx0qNK1y88qW+wDJ2b
         68AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775690062; x=1776294862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFom3GqY7i4bOkS6YmLFc+xoimFf3UEXYzV7a+y0rXE=;
        b=tH+SejLVyEM08tWxtvD1DfcEZXd26cT0V+J7aiIQW6X6Ssd6/eEWHMMyCeu5pqcgur
         tSx/rW1LyOQuATxb28YwxDqaSIoIFyp1u0WNM8ShJF27arDnsuFcNlXZDDIzp2snbxWR
         vCBY+4OfOy3YZuQosBRw19gVJMJNt79z9r20eUPNzk1EsHDTvqIguV/I7xxbFYZG7wQ/
         SPt5JHgGuilQmQXea2pjsXd5ReiWaF5A2O6aN5wZvphaAl1VKlQfVPMQIc/4UaNdiUR/
         4Gz093MeU4oH9kW597yv94/1x+ZKQd/ZZf6B8to1/IIff/Dy2PIFGrQGkdZXnV+Gpcae
         oqgQ==
X-Gm-Message-State: AOJu0YzCruhqwdE5DiSxExcxnJlgif/j9ZM6LDs8UjAKbiPZONOa7Hni
	nGmjsuLZJvSXIXyittdwpJBXocyZcsHr0nYdJJQkZQYr18Dw1qTO1aiQBJsW8Wgo
X-Gm-Gg: AeBDietFztTGqi6h21dByZigQnFZHJJUiUa7TUt7S24kO8NqDy+DLLpGso1lqS4YNHz
	eQ8byNYFe7ibhg5o2YivINT2LKgRff2Dlj0QCz0NPCkDF51k4Uq6KO2r+l+VnplUIMWbOoO3QzF
	JWhlE5olRdhvqkdUOC8eOzc1uAikdtsQDL0AvgaMeZ9WfefMknoF+H/DJyx6eDWrU9FzPaHZnEx
	MiEs9Cgc9QCr/W8c4VAavjwh50oRMKdltofICzzEFZeeO++hdCdrSqb4QyMlX6+BV5KtmOTvqmm
	dM/0gH644WwWSMfF/qVlJaXC0N0HsaiSSwvb3DOaCQrStvVyFLeud6Hl8X1VHSMyiMuCEppx5Ml
	fsd6VZMGgiNhmn243CpqWmUs/LdpUWoqHUZp5BuUcYXzDWPgLGdxeG3ONa626iVFqcRWTgaL8Tx
	hdIQWmKA7D1ZmbV06Sg5HeA20=
X-Received: by 2002:a05:690e:1501:b0:650:33f8:da34 with SMTP id 956f58d0204a3-650488d9cc8mr15457568d50.3.1775690061886;
        Wed, 08 Apr 2026 16:14:21 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a978ee5sm9824853d50.10.2026.04.08.16.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:14:21 -0700 (PDT)
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
Subject: [PATCH v11 net-next 1/5] psp: add admin/non-admin version of psp_device_get_locked
Date: Wed,  8 Apr 2026 16:14:10 -0700
Message-ID: <20260408231415.522691-2-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408231415.522691-1-weibunny.kernel@gmail.com>
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276744-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 6BBAF3C4BDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 100c36cda8e5..c54e1202cbe0 100644
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


