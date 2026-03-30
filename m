Return-Path: <netdev+bounces-273348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP8kGQD7ymmlBwYAu9opvQ
	(envelope-from <netdev+bounces-273348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B46362031
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5B96301FDA6
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8793E3D86;
	Mon, 30 Mar 2026 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lrbq3z0O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594D3E558E
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909923; cv=none; b=koVXfHyiQY5RneGPGNJiMavlVxhzR/hKbfBoaXLlPLPtOugyQpbjFAuiS+dlSd11UlpbHvSYvIrheRM+OGouvH4H7p73kP/LQo3pogsiZIfMrqK3ZkzbLIjzbr8GPF7aSKRrIfI1WFvjq7zxcxj5adhe7vAHa73m/vYDGfH+G/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909923; c=relaxed/simple;
	bh=SsQDzGgZGrTrC0hgM+JKdscuzJK0EEyGj9/wBi0Vghk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6eTpdCblYELl9+6D44ycytoYv5t+cHib/QLw2oLlPRwQdbPweOsFLJxfyd/jBOQajrK5PUUJyfyqFsstIXnVSLl0gs6yCBETTwwlE2bCzdMXrHTcg/u/75a5sO1tmXOcI+JGongl5eWBv6aTNpGIHZ+3RIbk6m3qlDbCCrKV/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lrbq3z0O; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6470d549e10so716206d50.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 15:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909908; x=1775514708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GVt+PhLeKmlUNQJMRo/067xPnVzbTIveNJQxTJ9+7s=;
        b=Lrbq3z0Op0xXDga8+ps9wEUOcV0WE4pg6yJDK2dB3D1N48JOsBYQgoNhHixJAdMOHn
         j2ngkgLFmAPxADDcJWh/LcPirKRlhJnDaitZifS3AbFt2EVnjRS/R+rborxJ2PlSRNAt
         UqieJjn5IuXx9J819EagcJ2gJLjub3/skr3pb4Ci3RLmKw/RLQlyCJMELl12ldz5Wbwm
         RaFiBbg6yqIUpFxc5Gh8N2UXpjg2ByLz+MSzMggt90p5RBGHfqjb9NR/pYaW7VbsSMs7
         l7YFs9PbBF02Bxe5VMuljabAxy8PWjtjeHNopfL41WfeDe8YY3jSydpxNc+CQR0wNEo4
         7T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909908; x=1775514708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/GVt+PhLeKmlUNQJMRo/067xPnVzbTIveNJQxTJ9+7s=;
        b=bTFnxpq2mIjSSrHpN8yu8y7NMrME73dDiA9Iv+74abZLze9Zdu7xS/vGai5LM6RyAu
         zWiakWVhx4V6bVxtGAbWaUlty9MarrVRmLG517MzUNM2aJ7g18HKyTO/Iuu6zjuYB6UG
         K7MwIZn9OPkUyWKFMCXzkkQRfij1iupMlG39rOk8TXa1X8O68FH4a4yzKBOaxIIJQ0Lo
         6RO1mcTNJLWCi4C4WBA3wfD3WxI0ycjK33bpdYQfvewpaZFS7KdU7ODYNQSssdik5/XS
         iPdd1NNllrfh2cF9k9eotrECYhwoZ/LBaDEcxxT4AHHlxALXZTmqqYmxjGPKl9EJk2i/
         Yqhw==
X-Gm-Message-State: AOJu0YxBkZ8OwnoSVcWP+xSeqUzofqZ2x3W9Cmoj4aVd8rgSHNaDVLNK
	6JRzmXHxJjYeeoSV93LN4HEZSHzfpZcmPeh8CtL0uwDFthe/6S0xzSzbGhCBd070
X-Gm-Gg: ATEYQzzCE2d89TWX/i0OtnEPaJjuH7O0B7pbBc10OxaAfkLWwhJ3c4Ai+mL0bdmCGqA
	5rVOf2DTc2cgQCon4c6chZpq8Xyl17+dEUc/K107L0BSFmP0oFQiG/z6wSyKiGZK0n3F7VLmliz
	IPZKaNQ/mEyoLm/xmFBwpKaTehl1YneDqUhL9RvLWJsov01YJUHtwUT27y3SRM3S5bcsn3MP4BU
	d2tzWaVUWfMdogV12nF/Jtt95nJcE6BM7g8Yc7TPvsGMgQ+uZjTdF1l0dsBRhFEcc/xVPN5rQi2
	P7OFbtBFZV25Q70RX4x9O3dVvgqr5GGw/c8e/X73Yo5gO0nKG2jZ55zPoGaVSmifjmoF5kPFOgr
	2LwdYx0ny3FLs6DcJs5INbl53W1hmX51HndKKhg68pu2FEd47+UwvS43vWTmE2884/0Qvopi0ve
	9RryxjZsYrnufhhEcK/7ExSYNfXHOPtj1GZos=
X-Received: by 2002:a05:690c:e3c8:b0:79f:843d:2327 with SMTP id 00721157ae682-79f843d274amr36853427b3.3.1774909908047;
        Mon, 30 Mar 2026 15:31:48 -0700 (PDT)
Received: from localhost ([2a03:2880:21ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb7910e7fsm41719267b3.18.2026.03.30.15.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:31:47 -0700 (PDT)
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
Subject: [PATCH v9 net-next 1/5] psp: add admin/non-admin version of psp_device_get_locked
Date: Mon, 30 Mar 2026 15:31:38 -0700
Message-ID: <20260330223143.2394706-2-weibunny.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
References: <20260330223143.2394706-1-weibunny.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-273348-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 64B46362031
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


