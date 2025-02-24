Return-Path: <netdev+bounces-168892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B16A41542
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB30C1890349
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAB71C6FF1;
	Mon, 24 Feb 2025 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHZhXrEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62211CD1F
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377770; cv=none; b=CtxxNjYA4A6+MpDd61Qw0uiLw8kLfxeAifsoRvISXhSySxY+aliREwxCb9bW+A5RsEbndoeX1PoK/H3oBjWvXdwOqXt9T7k6l2cqCCrsq0iSYlFYacE2i+NqakNTZS/o7bqgSfF+d8Ipvn62LFt+KWKdA455lyTV67pezd09HbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377770; c=relaxed/simple;
	bh=HTv61SCzECXYKziGHp9qV62tdygEaTM2oChECM3oEY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRk+kQC85YfbWKg3GukSjdvsDfxx1idHBUnUo98zGQ2vAm4N2iuuZ02ZB58iGZolbStJXs4KlC5YDZd95dNfmib1ZoejWAc6TuKQjJejBoH7IE6M9r/fQI5X250taCZkPIEksecHyS4379jUQjDMvKVjh3WIMMQYwfeJ29bsJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHZhXrEM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc518f0564so8780890a91.2
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 22:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740377768; x=1740982568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsgqsshtCo2YMIwkZzH6IRkGV5bqy/E0Ju1YSO4VYNk=;
        b=bHZhXrEMf68GB49WzZAd1U+BJu/8+E2VKVZSluSCA//QApVqqtcIKPfKFpB4myufQ4
         eQoNtgnZewXbVt+13tEoXIJGhwy3Gq7aUbfDUm4ozVxXavptz06bx+EHqBBXEO1lQama
         EI1/0tnR6uHPdA7EB+XydP3vKHGV4wyteOazwaPrXvXWEIFuXpSgEgPWkiwMhenF3saP
         WnuONQgB+7FwcwyNxL5bOjeDslajqnZm86aoMvQj74DjpwhfhwUDL78WEH4hrIxo809F
         Lw1zR2O1QrAaeSDPr4bPv7T1IGXEeArHriiZ1ee03mwnU6a+XfCk+DJpaE1p2Ujb3B31
         YFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740377768; x=1740982568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsgqsshtCo2YMIwkZzH6IRkGV5bqy/E0Ju1YSO4VYNk=;
        b=cEL/HcXwq87rubTGmOByxeyDkl6zN/FktUmb8xN9iGcbLdlCMkwM6Eox8PQ3CwYSij
         IOc5HPYAF6HL3VO74h8sQgPORX1iyw38aGZxKHlMCWY/IhYPxifsD9QG/KxGRzEfi1PW
         xdemHydF6BtG8brohqRbmwZGMHgFk8O3Z+IvwWtvf9xYRgspZkRE4/OEfK84/HLsMtpY
         6MahyYceaxaxEUHHSpRNW/x7P1Tzz3gLO6B/2STzMWNr40sE2pWe7rwWCSEouGN+CGWU
         3GD+LMJYC5pvOZ8wHNbmQitVUTtuJslriC/3ZD5NLEmzQPYoOJQsGdrpxnTBWGqwNt2A
         P3hA==
X-Gm-Message-State: AOJu0YzF0CcNS3Y2PMH6JzzkNjC6B/uNB8IY3/4I6M6OC5DGI9fQcQVV
	hnbzYe+oS4Tfe2WYAxQEgxQnm0aJdSfE+lyfLmxVXwjEDDzYilmB7dXkPxj22+ns5ZPGsejRZZz
	NLOAZp4jTz5yUaXMJxyEe2xv92Tt6XlswK4E5gjK4ArFlnrGBKFD3vqmiIDyu1zoTYNLNCuj8Qo
	MYQqrx4ajZTbFWNoBmnkA06ZQmvjyrfaTy95NBNu/aE2ADZNWbFaBggk3EfUEJa8D+IDlPZA==
X-Google-Smtp-Source: AGHT+IEipLYyXNAV231sYD4gYfXvdnBL6rz0szUvawuzMgx4HUdzloyM70TsgItLd0CkbKCejl7t+ASICKLJruYL0518
X-Received: from pfbef10.prod.google.com ([2002:a05:6a00:2c8a:b0:732:9235:5f2])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:33a4:b0:1ee:e785:a08a with SMTP id adf61e73a8af0-1eef3da4c68mr22310872637.29.1740377767860;
 Sun, 23 Feb 2025 22:16:07 -0800 (PST)
Date: Mon, 24 Feb 2025 06:15:54 +0000
In-Reply-To: <20250224061554.1906002-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224061554.1906002-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224061554.1906002-2-chiachangwang@google.com>
Subject: [PATCH ipsec v3 1/1] xfrm: Migrate offload configuration
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: chiahcangwang@google.com, stanleyjhu@google.com, yumike@google.com, 
	Chiachang Wang <chiachangwang@google.com>
Content-Type: text/plain; charset="UTF-8"

Add hardware offload configuration to XFRM_MSG_MIGRATE
using an option netlink attribute XFRMA_OFFLOAD_DEV.

In the existing xfrm_state_migrate(), the xfrm_init_state()
is called assuming no hardware offload by default. Even the
original xfrm_state is configured with offload, the setting will
be reset. If the device is configured with hardware offload,
it's reasonable to allow the device to maintain its hardware
offload mode. But the device will end up with offload disabled
after receiving a migration event when the device migrates the
connection from one netdev to another one.

The devices that support migration may work with different
underlying networks, such as mobile devices. The hardware setting
should be forwarded to the different netdev based on the
migration configuration. This change provides the capability
for user space to migrate from one netdev to another.

Test: Tested with kernel test in the Android tree located
      in https://android.googlesource.com/kernel/tests/
      The xfrm_tunnel_test.py under the tests folder in
      particular.
Signed-off-by: Chiachang Wang <chiachangwang@google.com>
---

v2 -> v3:
- Modify af_key to fix kbuild error
v1 -> v2:
- Address review feedback to correct the logic in the
  xfrm_state_migrate in the migration offload configuration
  change.
- Revise the commit message for "xfrm: Migrate offload configuration"
---
 include/net/xfrm.h     |  8 ++++++--
 net/key/af_key.c       |  2 +-
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  | 14 +++++++++++---
 net/xfrm/xfrm_user.c   | 15 +++++++++++++--
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index ed4b83696c77..9e916d812af7 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1876,12 +1876,16 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
 						u32 if_id);
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap);
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack);
 int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_bundles,
 		 struct xfrm_kmaddress *k, struct net *net,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
-		 struct netlink_ext_ack *extack);
+		 struct netlink_ext_ack *extack,
+		 struct xfrm_user_offload *xuo);
 #endif

 int km_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr, __be16 sport);
diff --git a/net/key/af_key.c b/net/key/af_key.c
index c56bb4f451e6..efc2a91f4c48 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -2630,7 +2630,7 @@ static int pfkey_migrate(struct sock *sk, struct sk_buff *skb,
 	}

 	return xfrm_migrate(&sel, dir, XFRM_POLICY_TYPE_MAIN, m, i,
-			    kma ? &k : NULL, net, NULL, 0, NULL);
+			    kma ? &k : NULL, net, NULL, 0, NULL, NULL);

  out:
 	return err;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6551e588fe52..82f755e39110 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4630,7 +4630,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		 struct xfrm_migrate *m, int num_migrate,
 		 struct xfrm_kmaddress *k, struct net *net,
 		 struct xfrm_encap_tmpl *encap, u32 if_id,
-		 struct netlink_ext_ack *extack)
+		 struct netlink_ext_ack *extack, struct xfrm_user_offload *xuo)
 {
 	int i, err, nx_cur = 0, nx_new = 0;
 	struct xfrm_policy *pol = NULL;
@@ -4663,7 +4663,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 		if ((x = xfrm_migrate_state_find(mp, net, if_id))) {
 			x_cur[nx_cur] = x;
 			nx_cur++;
-			xc = xfrm_state_migrate(x, mp, encap);
+			xc = xfrm_state_migrate(x, mp, encap, net, xuo, extack);
 			if (xc) {
 				x_new[nx_new] = xc;
 				nx_new++;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index ad2202fa82f3..0b5f7e90f4f3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2122,22 +2122,30 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);

 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap)
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
-
+	bool offload = (xuo);
 	xc = xfrm_state_clone(x, encap);
 	if (!xc)
 		return NULL;

 	xc->props.family = m->new_family;

-	if (xfrm_init_state(xc) < 0)
+	if (__xfrm_init_state(xc, true, offload, NULL) < 0)
 		goto error;

+	x->km.state = XFRM_STATE_VALID;
 	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
 	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));

+	/* configure the hardware if offload is requested */
+	if (offload && xfrm_dev_state_add(net, xc, xuo, extack))
+		goto error;
+
 	/* add state */
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/* a care is needed when the destination address of the
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 5877eabe9d95..4c2c74078e65 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3069,6 +3069,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int n = 0;
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_encap_tmpl  *encap = NULL;
+	struct xfrm_user_offload *xuo = NULL;
 	u32 if_id = 0;

 	if (!attrs[XFRMA_MIGRATE]) {
@@ -3099,11 +3100,21 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (attrs[XFRMA_IF_ID])
 		if_id = nla_get_u32(attrs[XFRMA_IF_ID]);

+	if (attrs[XFRMA_OFFLOAD_DEV]) {
+		xuo = kmemdup(nla_data(attrs[XFRMA_OFFLOAD_DEV]),
+			      sizeof(*xuo), GFP_KERNEL);
+		if (!xuo) {
+			err = -ENOMEM;
+			goto error;
+		}
+	}
+
 	err = xfrm_migrate(&pi->sel, pi->dir, type, m, n, kmp, net, encap,
-			   if_id, extack);
+			   if_id, extack, xuo);

+error:
 	kfree(encap);
-
+	kfree(xuo);
 	return err;
 }
 #else
--
2.48.1.601.g30ceb7b040-goog


