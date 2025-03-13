Return-Path: <netdev+bounces-174437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89FCA5E9FA
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 03:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A506F1793C8
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 02:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201AB2EB10;
	Thu, 13 Mar 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jf9+mlsT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982AAD5E
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 02:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741833416; cv=none; b=AS1SKPaA6VYhG7raICnD0LpsTUzQM2/f5yXPZn5H4TqD2hRCO04b58jIptGZcQ3Kdt5Rphyk9hoZ7mJ8LtknAtYw+wsF7pP+OHtMVkwY0oIKAWsdCJXroxH6k87EcZ1D0Y0IWEVrougf8i8XdxvISchWKoBqHgbiE9leNqiFRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741833416; c=relaxed/simple;
	bh=22n5dVo83QqF0ymWrZWZcB4Q6Rdr1rdFRN7IKvhYs48=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nEYgyqfaacbv9a5KlpWuvp/XhUjYCHT5muFmgfcRNvrxwhMT3omMPOLgOkTH9WxObUS5NC57InHdz1jXkYURIIXo6mzMrCKrkWnOZv8MsxjUF2KbFHhU8X/Go0fZ0nUyfxskWdDL0Hi/wfmobhI2iyt35C66KiHN5Y9PSM0X3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jf9+mlsT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chiachangwang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2235a1f8aadso7572845ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 19:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741833412; x=1742438212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nnk1XsVr4MgSOojSXfhq0WgJ5qTjfhJ2DytIbC0xeaw=;
        b=jf9+mlsTz7NLI/+KV5zDYYDE4fu7I6RKjAp9GqhrdCKyE8B/Q/Ymn4NmCsvHXBj8IQ
         uvTk39katUoj4AAAckSgkeBHZqjvshaJ5rkUwLyUaUb3ffFEPu3vPaoesHh6GXBwiFMm
         tU7Ibi3mCWvXn8bYjEJOJqKO+VWOJNB3cZxMXwzzJM+Be69rDamp9Bfv2+ldhdVNmDRc
         +MgClGc75toAJvDFOLtDs/XC6rtJ4HuqZUeIX8v5RH+F7iWWLJ7wI5WxqPJTnkxp+M/F
         O2BSpCpD/PADB5oOghSm86KIgY9FLEpKdJEhYz4rmgmbefY4ix4yKqSSeKs2NweytLT1
         EjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741833412; x=1742438212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnk1XsVr4MgSOojSXfhq0WgJ5qTjfhJ2DytIbC0xeaw=;
        b=S6oEvdoV5k9nUger7jAqOCeanJ9iXo0JvaIRw2nerIiyfkX6A8o+pkavfQvD67GY03
         UHGYB08rsIQpGf53rvWvlUpt1QvuaC5TAEXRUdqvKyMwCiH4pmf2ZyYKkyx0brz1OgbJ
         asuhSeuENPIupqI0gm/ztvsTIIeuiKWpzxtSpv6jV3e66CI6ertz/ktMMrDmEgJwIfkY
         yr3M27Pss482oc/+VLKKzaoY3z9UR4eVzcOJroan7uLRXjUzLV6LkzJA6yoyDWAwSI1w
         o6aWmiZ90GOveBDmzPw6Td0egkOTCA8J++gOec+fFRQDgeGkV/L5Sx2RbGD5NUqBIzAP
         pG+Q==
X-Gm-Message-State: AOJu0YwXMbKZdm4d9cs+zx5RP4tbesgne2VG7s9++eaq5gdv5r4UWQ1U
	As7bQKtOOVzDzDRCVwsHbuO0t9gO2TVoJK8LOX4QPEFqAkNHeZQyecjezNOz178FnklZ4OCe09T
	ChA0vj9iO2YVWf5vY/KaxThUxIDEoaGzWyds3Ph8vJw2AAQCc+tjxEizH4uhQAp3tSfzWA+QPXH
	omenmwGMn1bHtZ5PdBe6WDGB5F26B716B4CAUaYUTynSlAyxJ8QbCJSCDRCPfaT//VCe2cDQ==
X-Google-Smtp-Source: AGHT+IE2SxZsnCYQvqAjKZk9s8+vfHxn6sLjaMpIoE0Gno7ngJ8U21zkQzdYh1Da5qNEttmEzdqR32M7G9Qp4zFzEfz0
X-Received: from pfbei20.prod.google.com ([2002:a05:6a00:80d4:b0:730:743a:f2b0])
 (user=chiachangwang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d90:b0:736:64b7:f104 with SMTP id d2e1a72fcca58-736aa9c1b0fmr29394622b3a.5.1741833412487;
 Wed, 12 Mar 2025 19:36:52 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:36:40 +0000
In-Reply-To: <20250313023641.1007052-1-chiachangwang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313023641.1007052-1-chiachangwang@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313023641.1007052-2-chiachangwang@google.com>
Subject: [PATCH ipsec-next v5 1/2] xfrm: Migrate offload configuration
From: Chiachang Wang <chiachangwang@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com, leonro@nvidia.com
Cc: chiachangwang@google.com, stanleyjhu@google.com, yumike@google.com
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
 v3 -> v4:
 - Rebase commit to adopt updated xfrm_init_state()
 - Remove redundant variable to rely on validiaty of pointer
 v2 -> v3:
 - Modify af_key to fix kbuild error
 v1 -> v2:
 - Address review feedback to correct the logic in the
   xfrm_state_migrate in the migration offload configuration
   change
 - Revise the commit message for "xfrm: Migrate offload configuration"
---
 include/net/xfrm.h     |  8 ++++++--
 net/key/af_key.c       |  2 +-
 net/xfrm/xfrm_policy.c |  4 ++--
 net/xfrm/xfrm_state.c  |  9 ++++++++-
 net/xfrm/xfrm_user.c   | 15 ++++++++++++---
 5 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 39365fd2ea17..f80cdef43ed5 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1893,12 +1893,16 @@ struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *n
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
index 7b1028671144..9cd707362767 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2120,7 +2120,10 @@ EXPORT_SYMBOL(xfrm_migrate_state_find);
 
 struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 				      struct xfrm_migrate *m,
-				      struct xfrm_encap_tmpl *encap)
+				      struct xfrm_encap_tmpl *encap,
+				      struct net *net,
+				      struct xfrm_user_offload *xuo,
+				      struct netlink_ext_ack *extack)
 {
 	struct xfrm_state *xc;
 
@@ -2136,6 +2139,10 @@ struct xfrm_state *xfrm_state_migrate(struct xfrm_state *x,
 	memcpy(&xc->id.daddr, &m->new_daddr, sizeof(xc->id.daddr));
 	memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));
 
+	/* configure the hardware if offload is requested */
+	if (xuo && xfrm_dev_state_add(net, xc, xuo, extack))
+		goto error;
+
 	/* add state */
 	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/* a care is needed when the destination address of the
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 784a2d124749..85383d15d003 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3069,6 +3069,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int n = 0;
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_encap_tmpl  *encap = NULL;
+	struct xfrm_user_offload *xuo = NULL;
 	u32 if_id = 0;
 
 	if (!attrs[XFRMA_MIGRATE]) {
@@ -3099,11 +3100,19 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
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
 	err = xfrm_migrate(&pi->sel, pi->dir, type, m, n, kmp, net, encap,
-			   if_id, extack);
-
+			   if_id, extack, xuo);
+error:
 	kfree(encap);
-
+	kfree(xuo);
 	return err;
 }
 #else
-- 
2.49.0.rc1.451.g8f38331e32-goog


